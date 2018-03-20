Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeCTGey (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:34:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39889 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751390AbeCTGew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:34:52 -0400
Date: Mon, 19 Mar 2018 23:34:26 -0700
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-77f18153c080855e1c3fb520ca31a4e61530121d@git.kernel.org>
Cc: dsahern@gmail.com, jpoimboe@redhat.com, tglx@linutronix.de,
        mingo@kernel.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, peterz@infradead.org,
        sergey.senozhatsky.work@gmail.com, acme@redhat.com, hpa@zytor.com
Reply-To: jpoimboe@redhat.com, tglx@linutronix.de, dsahern@gmail.com,
        mingo@kernel.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, sergey.senozhatsky.work@gmail.com,
        peterz@infradead.org, hpa@zytor.com, acme@redhat.com
In-Reply-To: <20180319082902.4518-1-jolsa@kernel.org>
References: <20180319082902.4518-1-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Fix snprint warnings for gcc 8
Git-Commit-ID: 77f18153c080855e1c3fb520ca31a4e61530121d
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

Commit-ID:  77f18153c080855e1c3fb520ca31a4e61530121d
Gitweb:     https://git.kernel.org/tip/77f18153c080855e1c3fb520ca31a4e61530121d
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 19 Mar 2018 09:29:01 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 19 Mar 2018 10:00:43 -0300

perf tools: Fix snprint warnings for gcc 8

With gcc 8 we get new set of snprintf() warnings that breaks the
compilation, one example:

  tests/mem.c: In function ‘check’:
  tests/mem.c:19:48: error: ‘%s’ directive output may be truncated writing \
        up to 99 bytes into a region of size 89 [-Werror=format-truncation=]
    snprintf(failure, sizeof failure, "unexpected %s", out);

The gcc docs says:

 To avoid the warning either use a bigger buffer or handle the
 function's return value which indicates whether or not its output
 has been truncated.

Given that all these warnings are harmless, because the code either
properly fails due to uncomplete file path or we don't care for
truncated output at all, I'm changing all those snprintf() calls to
scnprintf(), which actually 'checks' for the snprint return value so the
gcc stays silent.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Link: http://lkml.kernel.org/r/20180319082902.4518-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c    | 22 +++++++++++-----------
 tools/perf/tests/attr.c        |  4 ++--
 tools/perf/tests/mem.c         |  2 +-
 tools/perf/tests/pmu.c         |  2 +-
 tools/perf/util/cgroup.c       |  2 +-
 tools/perf/util/parse-events.c |  4 ++--
 tools/perf/util/pmu.c          |  2 +-
 7 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index cce926aeb0c0..313c42423393 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2674,8 +2674,8 @@ static int list_available_scripts(const struct option *opt __maybe_unused,
 	}
 
 	for_each_lang(scripts_path, scripts_dir, lang_dirent) {
-		snprintf(lang_path, MAXPATHLEN, "%s/%s/bin", scripts_path,
-			 lang_dirent->d_name);
+		scnprintf(lang_path, MAXPATHLEN, "%s/%s/bin", scripts_path,
+			  lang_dirent->d_name);
 		lang_dir = opendir(lang_path);
 		if (!lang_dir)
 			continue;
@@ -2684,8 +2684,8 @@ static int list_available_scripts(const struct option *opt __maybe_unused,
 			script_root = get_script_root(script_dirent, REPORT_SUFFIX);
 			if (script_root) {
 				desc = script_desc__findnew(script_root);
-				snprintf(script_path, MAXPATHLEN, "%s/%s",
-					 lang_path, script_dirent->d_name);
+				scnprintf(script_path, MAXPATHLEN, "%s/%s",
+					  lang_path, script_dirent->d_name);
 				read_script_info(desc, script_path);
 				free(script_root);
 			}
@@ -2721,7 +2721,7 @@ static int check_ev_match(char *dir_name, char *scriptname,
 	int match, len;
 	FILE *fp;
 
-	sprintf(filename, "%s/bin/%s-record", dir_name, scriptname);
+	scnprintf(filename, MAXPATHLEN, "%s/bin/%s-record", dir_name, scriptname);
 
 	fp = fopen(filename, "r");
 	if (!fp)
@@ -2799,8 +2799,8 @@ int find_scripts(char **scripts_array, char **scripts_path_array)
 	}
 
 	for_each_lang(scripts_path, scripts_dir, lang_dirent) {
-		snprintf(lang_path, MAXPATHLEN, "%s/%s", scripts_path,
-			 lang_dirent->d_name);
+		scnprintf(lang_path, MAXPATHLEN, "%s/%s", scripts_path,
+			  lang_dirent->d_name);
 #ifdef NO_LIBPERL
 		if (strstr(lang_path, "perl"))
 			continue;
@@ -2855,8 +2855,8 @@ static char *get_script_path(const char *script_root, const char *suffix)
 		return NULL;
 
 	for_each_lang(scripts_path, scripts_dir, lang_dirent) {
-		snprintf(lang_path, MAXPATHLEN, "%s/%s/bin", scripts_path,
-			 lang_dirent->d_name);
+		scnprintf(lang_path, MAXPATHLEN, "%s/%s/bin", scripts_path,
+			  lang_dirent->d_name);
 		lang_dir = opendir(lang_path);
 		if (!lang_dir)
 			continue;
@@ -2867,8 +2867,8 @@ static char *get_script_path(const char *script_root, const char *suffix)
 				free(__script_root);
 				closedir(lang_dir);
 				closedir(scripts_dir);
-				snprintf(script_path, MAXPATHLEN, "%s/%s",
-					 lang_path, script_dirent->d_name);
+				scnprintf(script_path, MAXPATHLEN, "%s/%s",
+					  lang_path, script_dirent->d_name);
 				return strdup(script_path);
 			}
 			free(__script_root);
diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
index 97f64ad7fa08..05dfe11c2f9e 100644
--- a/tools/perf/tests/attr.c
+++ b/tools/perf/tests/attr.c
@@ -170,8 +170,8 @@ static int run_dir(const char *d, const char *perf)
 	if (verbose > 0)
 		vcnt++;
 
-	snprintf(cmd, 3*PATH_MAX, PYTHON " %s/attr.py -d %s/attr/ -p %s %.*s",
-		 d, d, perf, vcnt, v);
+	scnprintf(cmd, 3*PATH_MAX, PYTHON " %s/attr.py -d %s/attr/ -p %s %.*s",
+		  d, d, perf, vcnt, v);
 
 	return system(cmd) ? TEST_FAIL : TEST_OK;
 }
diff --git a/tools/perf/tests/mem.c b/tools/perf/tests/mem.c
index 21952e1e6e6d..0f82ee9fd3f7 100644
--- a/tools/perf/tests/mem.c
+++ b/tools/perf/tests/mem.c
@@ -16,7 +16,7 @@ static int check(union perf_mem_data_src data_src,
 
 	n = perf_mem__snp_scnprintf(out, sizeof out, &mi);
 	n += perf_mem__lvl_scnprintf(out + n, sizeof out - n, &mi);
-	snprintf(failure, sizeof failure, "unexpected %s", out);
+	scnprintf(failure, sizeof failure, "unexpected %s", out);
 	TEST_ASSERT_VAL(failure, !strcmp(string, out));
 	return 0;
 }
diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 9abca267afa9..7bedf8608fdd 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -98,7 +98,7 @@ static char *test_format_dir_get(void)
 		struct test_format *format = &test_formats[i];
 		FILE *file;
 
-		snprintf(name, PATH_MAX, "%s/%s", dir, format->name);
+		scnprintf(name, PATH_MAX, "%s/%s", dir, format->name);
 
 		file = fopen(name, "w");
 		if (!file)
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 78408f5c4bad..decb91f9da82 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -81,7 +81,7 @@ static int open_cgroup(const char *name)
 	if (cgroupfs_find_mountpoint(mnt, PATH_MAX + 1))
 		return -1;
 
-	snprintf(path, PATH_MAX, "%s/%s", mnt, name);
+	scnprintf(path, PATH_MAX, "%s/%s", mnt, name);
 
 	fd = open(path, O_RDONLY);
 	if (fd == -1)
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 4e80ca320399..2fb0272146d8 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -206,8 +206,8 @@ struct tracepoint_path *tracepoint_id_to_path(u64 config)
 
 		for_each_event(sys_dirent, evt_dir, evt_dirent) {
 
-			snprintf(evt_path, MAXPATHLEN, "%s/%s/id", dir_path,
-				 evt_dirent->d_name);
+			scnprintf(evt_path, MAXPATHLEN, "%s/%s/id", dir_path,
+				  evt_dirent->d_name);
 			fd = open(evt_path, O_RDONLY);
 			if (fd < 0)
 				continue;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 1111d5bf15ca..064bdcb7bd78 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -351,7 +351,7 @@ static int pmu_aliases_parse(char *dir, struct list_head *head)
 		if (pmu_alias_info_file(name))
 			continue;
 
-		snprintf(path, PATH_MAX, "%s/%s", dir, name);
+		scnprintf(path, PATH_MAX, "%s/%s", dir, name);
 
 		file = fopen(path, "r");
 		if (!file) {
