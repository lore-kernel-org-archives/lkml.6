Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751004AbeEBRk1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:40:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51813 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbeEBRkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:40:24 -0400
Date: Wed, 2 May 2018 10:39:47 -0700
From: tip-bot for Ravi Bangoria <tipbot@zytor.com>
Message-ID: <tip-8e1e0d74672f84e6c4b1e26ce2bb2e529aaf8676@git.kernel.org>
Cc: hpa@zytor.com, acme@redhat.com, tglx@linutronix.de,
        kjlx@templeofstupid.com, pombredanne@nexb.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, uneedsihyeon@gmail.com,
        ravi.bangoria@linux.vnet.ibm.com, mhiramat@kernel.org,
        namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        kstewart@linuxfoundation.org, mingo@kernel.org
Reply-To: acme@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, peterz@infradead.org, pombredanne@nexb.com,
        kjlx@templeofstupid.com, tglx@linutronix.de, uneedsihyeon@gmail.com,
        ravi.bangoria@linux.vnet.ibm.com, kstewart@linuxfoundation.org,
        mingo@kernel.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, mhiramat@kernel.org
In-Reply-To: <20180417041346.5617-3-ravi.bangoria@linux.vnet.ibm.com>
References: <20180417041346.5617-3-ravi.bangoria@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf buildid-cache: Support --list option
Git-Commit-ID: 8e1e0d74672f84e6c4b1e26ce2bb2e529aaf8676
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

Commit-ID:  8e1e0d74672f84e6c4b1e26ce2bb2e529aaf8676
Gitweb:     https://git.kernel.org/tip/8e1e0d74672f84e6c4b1e26ce2bb2e529aaf8676
Author:     Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
AuthorDate: Tue, 17 Apr 2018 09:43:45 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 09:30:26 -0300

perf buildid-cache: Support --list option

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
