Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752068AbeEBPeq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:34:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751559AbeEBPUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:20:04 -0400
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
Subject: [PATCH 02/52] perf buildid-cache: Support --purge-all option
Date: Wed,  2 May 2018 12:18:52 -0300
Message-Id: <20180502151942.20542-3-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

User can remove files from cache using --remove/--purge options but both
needs list of files as an argument. It's not convenient when you want to
flush out entire cache. Add an option to purge all files from cache.

Ex,
  # perf buildid-cache -l
    8a86ef73e44067bca52cc3f6cd3e5446c783391c /tmp/a.out
    ebe71fdcf4b366518cc154d570a33cd461a51c36 /tmp/a.out.1
  # perf buildid-cache -P -v
    Removing /tmp/a.out (8a86ef73e44067bca52cc3f6cd3e5446c783391c): Ok
    Removing /tmp/a.out.1 (ebe71fdcf4b366518cc154d570a33cd461a51c36): Ok
    Purged all: Ok

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
Link: http://lkml.kernel.org/r/20180417041346.5617-4-ravi.bangoria@linux.vnet.ibm.com
[ Initialize 'err' in build_id_cache__purge_all(), to fix build on debian:7, as it can be used uninitialized ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-buildid-cache.txt |  3 +++
 tools/perf/builtin-buildid-cache.c              | 36 ++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-buildid-cache.txt b/tools/perf/Documentation/perf-buildid-cache.txt
index 3f285ba6e1f9..f6de0952ff3c 100644
--- a/tools/perf/Documentation/perf-buildid-cache.txt
+++ b/tools/perf/Documentation/perf-buildid-cache.txt
@@ -48,6 +48,9 @@ OPTIONS
 --purge=::
         Purge all cached binaries including older caches which have specified
 	path from the cache.
+-P::
+--purge-all::
+	Purge all cached binaries. This will flush out entire cache.
 -M::
 --missing=::
 	List missing build ids in the cache for the specified file.
diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index fd0a08661b42..7a7403913b57 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -240,6 +240,34 @@ static int build_id_cache__purge_path(const char *pathname, struct nsinfo *nsi)
 	return err;
 }
 
+static int build_id_cache__purge_all(void)
+{
+	struct strlist *list;
+	struct str_node *pos;
+	int err = 0;
+	char *buf;
+
+	list = build_id_cache__list_all(false);
+	if (!list) {
+		pr_debug("Failed to get buildids: -%d\n", errno);
+		return -EINVAL;
+	}
+
+	strlist__for_each_entry(pos, list) {
+		buf = build_id_cache__origname(pos->s);
+		err = build_id_cache__remove_s(pos->s);
+		pr_debug("Removing %s (%s): %s\n", buf, pos->s,
+			 err ? "FAIL" : "Ok");
+		free(buf);
+		if (err)
+			break;
+	}
+	strlist__delete(list);
+
+	pr_debug("Purged all: %s\n", err ? "FAIL" : "Ok");
+	return err;
+}
+
 static bool dso__missing_buildid_cache(struct dso *dso, int parm __maybe_unused)
 {
 	char filename[PATH_MAX];
@@ -327,6 +355,7 @@ int cmd_buildid_cache(int argc, const char **argv)
 	bool force = false;
 	bool list_files = false;
 	bool opts_flag = false;
+	bool purge_all = false;
 	char const *add_name_list_str = NULL,
 		   *remove_name_list_str = NULL,
 		   *purge_name_list_str = NULL,
@@ -350,6 +379,7 @@ int cmd_buildid_cache(int argc, const char **argv)
 		    "file(s) to remove"),
 	OPT_STRING('p', "purge", &purge_name_list_str, "file list",
 		    "file(s) to remove (remove old caches too)"),
+	OPT_BOOLEAN('P', "purge-all", &purge_all, "purge all cached files"),
 	OPT_BOOLEAN('l', "list", &list_files, "list all cached files"),
 	OPT_STRING('M', "missing", &missing_filename, "file",
 		   "to find missing build ids in the cache"),
@@ -370,7 +400,8 @@ int cmd_buildid_cache(int argc, const char **argv)
 
 	opts_flag = add_name_list_str || kcore_filename ||
 		remove_name_list_str || purge_name_list_str ||
-		missing_filename || update_name_list_str;
+		missing_filename || update_name_list_str ||
+		purge_all;
 
 	if (argc || !(list_files || opts_flag))
 		usage_with_options(buildid_cache_usage, buildid_cache_options);
@@ -457,6 +488,9 @@ int cmd_buildid_cache(int argc, const char **argv)
 		}
 	}
 
+	if (purge_all)
+		ret = build_id_cache__purge_all();
+
 	if (missing_filename)
 		ret = build_id_cache__fprintf_missing(session, stdout);
 
-- 
2.14.3
