Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970593AbeCSTCG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 15:02:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S970768AbeCSTBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 15:01:51 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0FA217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 01/14] perf annotate: Use asprintf when formatting objdump command line
Date: Mon, 19 Mar 2018 16:01:23 -0300
Message-Id: <20180319190136.7441-2-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180319190136.7441-1-acme@kernel.org>
References: <20180319190136.7441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We were using a local buffer with an arbitrary size, that would have to
get increased to avoid truncation as warned by gcc 8:

  util/annotate.c: In function 'symbol__disassemble':
  util/annotate.c:1488:4: error: '%s' directive output may be truncated writing up to 4095 bytes into a region of size between 3966 and 8086 [-Werror=format-truncation=]
      "%s %s%s --start-address=0x%016" PRIx64
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  util/annotate.c:1498:20:
      symfs_filename, symfs_filename);
                      ~~~~~~~~~~~~~~
  util/annotate.c:1490:50: note: format string is defined here
      " -l -d %s %s -C \"%s\" 2>/dev/null|grep -v \"%s:\"|expand",
                                                  ^~
  In file included from /usr/include/stdio.h:861,
                   from util/color.h:5,
                   from util/sort.h:8,
                   from util/annotate.c:14:
  /usr/include/bits/stdio2.h:67:10: note: '__builtin___snprintf_chk' output 116 or more bytes (assuming 8331) into a destination of size 8192
     return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          __bos (__s), __fmt, __va_arg_pack ());
          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

So switch to asprintf, that will make sure enough space is available.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-qagoy2dmbjpc9gdnaj0r3mml@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index bc3302da702b..ddad87f34a68 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1427,7 +1427,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 {
 	struct map *map = args->map;
 	struct dso *dso = map->dso;
-	char command[PATH_MAX * 2];
+	char *command;
 	FILE *file;
 	char symfs_filename[PATH_MAX];
 	struct kcore_extract kce;
@@ -1468,7 +1468,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		strcpy(symfs_filename, tmp);
 	}
 
-	snprintf(command, sizeof(command),
+	err = asprintf(&command,
 		 "%s %s%s --start-address=0x%016" PRIx64
 		 " --stop-address=0x%016" PRIx64
 		 " -l -d %s %s -C \"%s\" 2>/dev/null|grep -v \"%s:\"|expand",
@@ -1481,12 +1481,17 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		 symbol_conf.annotate_src ? "-S" : "",
 		 symfs_filename, symfs_filename);
 
+	if (err < 0) {
+		pr_err("Failure allocating memory for the command to run\n");
+		goto out_remove_tmp;
+	}
+
 	pr_debug("Executing: %s\n", command);
 
 	err = -1;
 	if (pipe(stdout_fd) < 0) {
 		pr_err("Failure creating the pipe to run %s\n", command);
-		goto out_remove_tmp;
+		goto out_free_command;
 	}
 
 	pid = fork();
@@ -1513,7 +1518,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		 * If we were using debug info should retry with
 		 * original binary.
 		 */
-		goto out_remove_tmp;
+		goto out_free_command;
 	}
 
 	nline = 0;
@@ -1541,6 +1546,8 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 
 	fclose(file);
 	err = 0;
+out_free_command:
+	free(command);
 out_remove_tmp:
 	close(stdout_fd[0]);
 
@@ -1554,7 +1561,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 
 out_close_stdout:
 	close(stdout_fd[1]);
-	goto out_remove_tmp;
+	goto out_free_command;
 }
 
 static void calc_percent(struct sym_hist *hist,
-- 
2.14.3
