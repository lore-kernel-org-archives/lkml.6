Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751618AbeEBPUJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750936AbeEBPUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:20:00 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Krister Johansen <kjlx@templeofstupid.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Sihyeon Jang <uneedsihyeon@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/52] perf buildid-cache: Support --list option
Date: Wed,  2 May 2018 12:18:51 -0300
Message-Id: <20180502151942.20542-2-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

'perf buildid-cache' allows to add/remove files into cache but there is
no option to list all cached files. Add --list option to list all
_valid_ cached files.

Ex,
  # perf buildid-cache --add /tmp/a.out
  # perf buildid-cache -l
    8a86ef73e44067bca52cc3f6cd3e5446c783391c /tmp/a.out

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Krister Johansen <kjlx@templeofstupid.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Sihyeon Jang <uneedsihyeon@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180417041346.5617-3-ravi.bangoria@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-buildid-cache.txt |  4 ++-
 tools/perf/builtin-buildid-cache.c              | 43 +++++++++++++++++++++++--
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-buildid-cache.txt b/tools/perf/Documentation/perf-buildid-cache.txt
index 73c2650bd0db..3f285ba6e1f9 100644
--- a/tools/perf/Documentation/perf-buildid-cache.txt
+++ b/tools/perf/Documentation/perf-buildid-cache.txt
@@ -59,7 +59,9 @@ OPTIONS
 	exactly same build-id, that is replaced by new one. It can be used
 	to update kallsyms and kernel dso to vmlinux in order to support
 	annotation.
-
+-l::
+--list::
+	List all valid binaries from cache.
 -v::
 --verbose::
 	Be more verbose.
diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index 41db2cba77eb..fd0a08661b42 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -25,6 +25,7 @@
 #include "util/session.h"
 #include "util/symbol.h"
 #include "util/time-utils.h"
+#include "util/probe-file.h"
 
 static int build_id_cache__kcore_buildid(const char *proc_dir, char *sbuildid)
 {
@@ -297,6 +298,26 @@ static int build_id_cache__update_file(const char *filename, struct nsinfo *nsi)
 	return err;
 }
 
+static int build_id_cache__show_all(void)
+{
+	struct strlist *bidlist;
+	struct str_node *nd;
+	char *buf;
+
+	bidlist = build_id_cache__list_all(true);
+	if (!bidlist) {
+		pr_debug("Failed to get buildids: -%d\n", errno);
+		return -1;
+	}
+	strlist__for_each_entry(nd, bidlist) {
+		buf = build_id_cache__origname(nd->s);
+		fprintf(stdout, "%s %s\n", nd->s, buf);
+		free(buf);
+	}
+	strlist__delete(bidlist);
+	return 0;
+}
+
 int cmd_buildid_cache(int argc, const char **argv)
 {
 	struct strlist *list;
@@ -304,6 +325,8 @@ int cmd_buildid_cache(int argc, const char **argv)
 	int ret = 0;
 	int ns_id = -1;
 	bool force = false;
+	bool list_files = false;
+	bool opts_flag = false;
 	char const *add_name_list_str = NULL,
 		   *remove_name_list_str = NULL,
 		   *purge_name_list_str = NULL,
@@ -327,6 +350,7 @@ int cmd_buildid_cache(int argc, const char **argv)
 		    "file(s) to remove"),
 	OPT_STRING('p', "purge", &purge_name_list_str, "file list",
 		    "file(s) to remove (remove old caches too)"),
+	OPT_BOOLEAN('l', "list", &list_files, "list all cached files"),
 	OPT_STRING('M', "missing", &missing_filename, "file",
 		   "to find missing build ids in the cache"),
 	OPT_BOOLEAN('f', "force", &force, "don't complain, do it"),
@@ -344,11 +368,19 @@ int cmd_buildid_cache(int argc, const char **argv)
 	argc = parse_options(argc, argv, buildid_cache_options,
 			     buildid_cache_usage, 0);
 
-	if (argc || (!add_name_list_str && !kcore_filename &&
-		     !remove_name_list_str && !purge_name_list_str &&
-		     !missing_filename && !update_name_list_str))
+	opts_flag = add_name_list_str || kcore_filename ||
+		remove_name_list_str || purge_name_list_str ||
+		missing_filename || update_name_list_str;
+
+	if (argc || !(list_files || opts_flag))
 		usage_with_options(buildid_cache_usage, buildid_cache_options);
 
+	/* -l is exclusive. It can not be used with other options. */
+	if (list_files && opts_flag) {
+		usage_with_options_msg(buildid_cache_usage,
+			buildid_cache_options, "-l is exclusive.\n");
+	}
+
 	if (ns_id > 0)
 		nsi = nsinfo__new(ns_id);
 
@@ -366,6 +398,11 @@ int cmd_buildid_cache(int argc, const char **argv)
 
 	setup_pager();
 
+	if (list_files) {
+		ret = build_id_cache__show_all();
+		goto out;
+	}
+
 	if (add_name_list_str) {
 		list = strlist__new(add_name_list_str, NULL);
 		if (list) {
-- 
2.14.3
