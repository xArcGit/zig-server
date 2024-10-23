const std = @import("std");
const zap = @import("zap");

fn on_request(r: zap.Request) void {
    if (r.path) |the_path| {
        std.debug.print("PATH: {s}\n", .{the_path});
    }

    if (r.query) |the_query| {
        std.debug.print("QUERY: {s}\n", .{the_query});
    }
    r.sendJson("{ name: \"zap\"}") catch return;
}

pub fn main() !void {
    // TODO: Implement the following functions
    // var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    // defer if (gpa.deinit() == .leak) {
    //     std.debug.panic("leaks detected", .{});
    // };

    // var allocator = gpa.allocator();

    // var db = try sqlite.Db.init(.{
    //     .mode = sqlite.Db.Mode{ .File = "/home/vincent/mydata.db" },
    //     .open_flags = .{
    //         .write = true,
    //         .create = true,
    //     },
    //     .threading_mode = .MultiThread,
    // });
    // defer db.deinit();

    // try db.exec("CREATE TABLE nofity(id integer primary key, title text, description text, date date, tag text, url text, icon text)", .{}, .{});

    var listener = zap.HttpListener.init(.{
        .port = 3000,
        .on_request = on_request,
        .log = true,
    });
    try listener.listen();

    std.debug.print("Listening on 0.0.0.0:3000\n", .{});

    zap.start(.{
        .threads = 2,
        .workers = 2,
    });
}
