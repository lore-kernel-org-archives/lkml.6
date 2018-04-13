Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754043AbeDMOCJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 10:02:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754838AbeDMOCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 10:02:06 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3567217A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/17] perf tools: Rename HAVE_SYSCALL_TABLE to HAVE_SYSCALL_TABLE_SUPPORT
Date: Fri, 13 Apr 2018 11:01:04 -0300
Message-Id: <20180413140111.25313-11-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180413140111.25313-1-acme@kernel.org>
References: <20180413140111.25313-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

To be consistent with other HAVE_XXX_SUPPORT uses in Makefile.config,
this patch renames HAVE_SYSCALL_TABLE to HAVE_SYSCALL_TABLE_SUPPORT and
updates the C code accordingly.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1523269609-28824-3-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config          | 2 +-
 tools/perf/builtin-help.c           | 2 +-
 tools/perf/perf.c                   | 4 ++--
 tools/perf/util/generate-cmdlist.sh | 2 +-
 tools/perf/util/syscalltbl.c        | 6 +++---
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 6b307e97dc57..ae7dc46e8f8a 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -68,7 +68,7 @@ ifeq ($(NO_PERF_REGS),0)
 endif
 
 ifneq ($(NO_SYSCALL_TABLE),1)
-  CFLAGS += -DHAVE_SYSCALL_TABLE
+  CFLAGS += -DHAVE_SYSCALL_TABLE_SUPPORT
 endif
 
 # So far there's only x86 and arm libdw unwind support merged in perf.
diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index 4aca13f23b9d..1c41b4eaf73c 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -439,7 +439,7 @@ int cmd_help(int argc, const char **argv)
 #ifdef HAVE_LIBELF_SUPPORT
 		"probe",
 #endif
-#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE)
+#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE_SUPPORT)
 		"trace",
 #endif
 	NULL };
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 1659029d03fc..20a08cb32332 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -73,7 +73,7 @@ static struct cmd_struct commands[] = {
 	{ "lock",	cmd_lock,	0 },
 	{ "kvm",	cmd_kvm,	0 },
 	{ "test",	cmd_test,	0 },
-#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE)
+#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE_SUPPORT)
 	{ "trace",	cmd_trace,	0 },
 #endif
 	{ "inject",	cmd_inject,	0 },
@@ -491,7 +491,7 @@ int main(int argc, const char **argv)
 		argv[0] = cmd;
 	}
 	if (strstarts(cmd, "trace")) {
-#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE)
+#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE_SUPPORT)
 		setup_path();
 		argv[0] = "trace";
 		return cmd_trace(argc, argv);
diff --git a/tools/perf/util/generate-cmdlist.sh b/tools/perf/util/generate-cmdlist.sh
index ff17920a5ebc..c3cef36d4176 100755
--- a/tools/perf/util/generate-cmdlist.sh
+++ b/tools/perf/util/generate-cmdlist.sh
@@ -38,7 +38,7 @@ do
 done
 echo "#endif /* HAVE_LIBELF_SUPPORT */"
 
-echo "#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE)"
+echo "#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE_SUPPORT)"
 sed -n -e 's/^perf-\([^ 	]*\)[ 	].* audit*/\1/p' command-list.txt |
 sort |
 while read cmd
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 895122d638dd..0ee7f568d60c 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -17,7 +17,7 @@
 #include <stdlib.h>
 #include <linux/compiler.h>
 
-#ifdef HAVE_SYSCALL_TABLE
+#ifdef HAVE_SYSCALL_TABLE_SUPPORT
 #include <string.h>
 #include "string2.h"
 #include "util.h"
@@ -139,7 +139,7 @@ int syscalltbl__strglobmatch_first(struct syscalltbl *tbl, const char *syscall_g
 	return syscalltbl__strglobmatch_next(tbl, syscall_glob, idx);
 }
 
-#else /* HAVE_SYSCALL_TABLE */
+#else /* HAVE_SYSCALL_TABLE_SUPPORT */
 
 #include <libaudit.h>
 
@@ -176,4 +176,4 @@ int syscalltbl__strglobmatch_first(struct syscalltbl *tbl, const char *syscall_g
 {
 	return syscalltbl__strglobmatch_next(tbl, syscall_glob, idx);
 }
-#endif /* HAVE_SYSCALL_TABLE */
+#endif /* HAVE_SYSCALL_TABLE_SUPPORT */
-- 
2.14.3
