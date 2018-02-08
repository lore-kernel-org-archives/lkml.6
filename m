Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbeBHIWa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 03:22:30 -0500
Received: from mga02.intel.com ([134.134.136.20]:20671 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750986AbeBHIW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 03:22:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,477,1511856000";
   d="scan'208";a="33063165"
From: changbin.du@intel.com
To: jolsa@redhat.com
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Changbin Du <changbin.du@intel.com>
Subject: [PATCH v2] perf ftrace: Fix the buffer size in __write_tracing_file
Date: Thu,  8 Feb 2018 16:13:20 +0800
Message-Id: <1518077600-19615-1-git-send-email-changbin.du@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

The terminal character '\0' should take into account into size of the
string buffer. Without this fix, the '--graph-funcs', '--nograph-funcs'
and '--trace-funcs' options didn't work as expected when the <func>
doesn't exist. If usersapce writes a non-terminated string, the kernel
side will always return success but actually no filter applied.

As discussed before, the kernel now support '\0' to mark the end of string:
https://lkml.org/lkml/2018/1/16/116

After this fix in userspace, the perf will report correct error state. Also
let it print an error if reset_tracing_files() fails.

The problem:
$ sudo ./perf ftrace -a --graph-depth 1 --graph-funcs abcdefg
 0)   0.140 us    |  rcu_all_qs();
 3)   0.304 us    |  mutex_unlock();
 0)   0.153 us    |  find_vma();
 3)   0.088 us    |  __fsnotify_parent();
 0)   6.145 us    |  handle_mm_fault();
 3)   0.089 us    |  fsnotify();
 3)   0.161 us    |  __sb_end_write();
 3)   0.710 us    |  SyS_close();
 3)   7.848 us    |  exit_to_usermode_loop();

On above example, I specified function filter 'abcdefg' but all functions
are enabled. The expected error is hidden.

Signed-off-by: Changbin Du <changbin.du@intel.com>
---
 tools/perf/builtin-ftrace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 25a42ac..a87e9b3 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -69,7 +69,7 @@ static int __write_tracing_file(const char *name, const char *val, bool append)
 {
 	char *file;
 	int fd, ret = -1;
-	ssize_t size = strlen(val);
+	ssize_t size = strlen(val) + 1;
 	int flags = O_WRONLY;
 	char errbuf[512];
 
@@ -280,8 +280,10 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 	signal(SIGCHLD, sig_handler);
 	signal(SIGPIPE, sig_handler);
 
-	if (reset_tracing_files(ftrace) < 0)
+	if (reset_tracing_files(ftrace) < 0) {
+		pr_err("failed to reset ftrace\n");
 		goto out;
+	}
 
 	/* reset ftrace buffer */
 	if (write_tracing_file("trace", "0") < 0)
-- 
2.7.4
