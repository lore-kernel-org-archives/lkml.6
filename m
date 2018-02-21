Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751404AbeBUBey (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 20:34:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:58328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750732AbeBUBeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 20:34:50 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12AC82177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Changbin Du <changbin.du@intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 3/5] perf ftrace: Append an EOL when write tracing files
Date: Tue, 20 Feb 2018 22:34:29 -0300
Message-Id: <20180221013431.11738-4-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180221013431.11738-1-acme@kernel.org>
References: <20180221013431.11738-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

Before this change, the '--graph-funcs', '--nograph-funcs' and
'--trace-funcs' options didn't work as expected when the <func> doesn't
exist. Because the kernel side hid possible errors.

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

On the example above, I specified the function filter 'abcdefg' but all
functions are enabled. The expected result is for all functions to be
filtered, since there is no such function ('abcdefg')

The original fix is to make the kernel support '\0' as end of string:
https://lkml.org/lkml/2018/1/16/116

But above fix cannot be compatible with old kernels. Then Namhyung Kim
suggest adding a space after function name.

This patch will append an '\n' when write tracing file. After this fix,
the perf will report correct error state. Also let it print an error if
reset_tracing_files() fails.

Committer testing:

Now it prints:

  # perf ftrace -a --graph-depth 1 --graph-funcs abcdefg
  failed to set tracing filters
  #

And for an existing function:

  # perf ftrace -a --graph-depth 1 --graph-funcs SyS_open
   3)               |  SyS_open() {
   3) ! 494.899 us  |  }
   0) + 23.910 us   |  SyS_open();
   1) + 17.115 us   |  SyS_open();
   1) + 13.900 us   |  SyS_open();
   ------------------------------------------
   3)  qemu-sy-2817  =>  pickup-1290
   ------------------------------------------

   3) + 20.021 us   |  SyS_open();
  #

Signed-off-by: Changbin Du <changbin.du@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1519007609-14551-1-git-send-email-changbin.du@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-ftrace.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 25a42acabee1..f42f228e8899 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -72,6 +72,7 @@ static int __write_tracing_file(const char *name, const char *val, bool append)
 	ssize_t size = strlen(val);
 	int flags = O_WRONLY;
 	char errbuf[512];
+	char *val_copy;
 
 	file = get_tracing_file(name);
 	if (!file) {
@@ -91,12 +92,23 @@ static int __write_tracing_file(const char *name, const char *val, bool append)
 		goto out;
 	}
 
-	if (write(fd, val, size) == size)
+	/*
+	 * Copy the original value and append a '\n'. Without this,
+	 * the kernel can hide possible errors.
+	 */
+	val_copy = strdup(val);
+	if (!val_copy)
+		goto out_close;
+	val_copy[size] = '\n';
+
+	if (write(fd, val_copy, size + 1) == size + 1)
 		ret = 0;
 	else
 		pr_debug("write '%s' to tracing/%s failed: %s\n",
 			 val, name, str_error_r(errno, errbuf, sizeof(errbuf)));
 
+	free(val_copy);
+out_close:
 	close(fd);
 out:
 	put_tracing_file(file);
@@ -280,8 +292,10 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
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
2.14.3
