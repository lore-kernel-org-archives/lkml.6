Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933068AbeBUK1U (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:27:20 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33509 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932807AbeBUK1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:27:15 -0500
Date: Wed, 21 Feb 2018 02:26:10 -0800
From: tip-bot for Changbin Du <tipbot@zytor.com>
Message-ID: <tip-63cd02d84be5f7b3bc4f8fbb93cc1f871f84ae1d@git.kernel.org>
Cc: namhyung@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
        tglx@linutronix.de, hpa@zytor.com, acme@redhat.com, jolsa@redhat.com,
        changbin.du@intel.com, peterz@infradead.org
Reply-To: acme@redhat.com, peterz@infradead.org, changbin.du@intel.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <1519007609-14551-1-git-send-email-changbin.du@intel.com>
References: <1519007609-14551-1-git-send-email-changbin.du@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf ftrace: Append an EOL when write tracing files
Git-Commit-ID: 63cd02d84be5f7b3bc4f8fbb93cc1f871f84ae1d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  63cd02d84be5f7b3bc4f8fbb93cc1f871f84ae1d
Gitweb:     https://git.kernel.org/tip/63cd02d84be5f7b3bc4f8fbb93cc1f871f84ae1d
Author:     Changbin Du <changbin.du@intel.com>
AuthorDate: Mon, 19 Feb 2018 10:33:29 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 19 Feb 2018 09:49:12 -0300

perf ftrace: Append an EOL when write tracing files

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
index 25a42ac..f42f228 100644
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
