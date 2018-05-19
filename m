Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752536AbeESLm5 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 07:42:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39399 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752205AbeESLmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 07:42:55 -0400
Date: Sat, 19 May 2018 04:42:46 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-42zzi0f274909bg9mxzl81bu@git.kernel.org>
Cc: jolsa@kernel.org, dsahern@gmail.com, mingo@kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, wangnan0@huawei.com, adrian.hunter@intel.com
Reply-To: tglx@linutronix.de, namhyung@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, acme@redhat.com,
        dsahern@gmail.com, jolsa@kernel.org, adrian.hunter@intel.com,
        wangnan0@huawei.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib api fs tracing_path: Introduce opendir()
 method
Git-Commit-ID: 7014e0e3bf9b0d0b6221eb7d2f8a1f690423dd73
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

Commit-ID:  7014e0e3bf9b0d0b6221eb7d2f8a1f690423dd73
Gitweb:     https://git.kernel.org/tip/7014e0e3bf9b0d0b6221eb7d2f8a1f690423dd73
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 17 May 2018 14:42:39 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 17 May 2018 14:50:38 -0300

tools lib api fs tracing_path: Introduce opendir() method

That takes care of using the right call to get the tracing_path
directory, the one that will end up calling tracing_path_set() to figure
out where tracefs is mounted.

One more step in doing just lazy reading of system structures to reduce
the number of operations done unconditionaly at 'perf' start.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-42zzi0f274909bg9mxzl81bu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/api/fs/tracing_path.c | 13 +++++++++++++
 tools/lib/api/fs/tracing_path.h |  3 +++
 tools/perf/tests/parse-events.c |  2 +-
 tools/perf/util/parse-events.c  |  8 ++++----
 4 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/tools/lib/api/fs/tracing_path.c b/tools/lib/api/fs/tracing_path.c
index 9cd282425929..9b451af0721c 100644
--- a/tools/lib/api/fs/tracing_path.c
+++ b/tools/lib/api/fs/tracing_path.c
@@ -101,6 +101,19 @@ void put_events_file(char *file)
 	free(file);
 }
 
+DIR *tracing_events__opendir(void)
+{
+	DIR *dir = NULL;
+	char *path = get_tracing_file("events");
+
+	if (path) {
+		dir = opendir(path);
+		put_events_file(path);
+	}
+
+	return dir;
+}
+
 int tracing_path__strerror_open_tp(int err, char *buf, size_t size,
 				   const char *sys, const char *name)
 {
diff --git a/tools/lib/api/fs/tracing_path.h b/tools/lib/api/fs/tracing_path.h
index 3b32fb439f12..904d085b2ae7 100644
--- a/tools/lib/api/fs/tracing_path.h
+++ b/tools/lib/api/fs/tracing_path.h
@@ -3,9 +3,12 @@
 #define __API_FS_TRACING_PATH_H
 
 #include <linux/types.h>
+#include <dirent.h>
 
 extern char tracing_events_path[];
 
+DIR *tracing_events__opendir(void);
+
 void tracing_path_set(const char *mountpoint);
 const char *tracing_path_mount(void);
 
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 6d57d7082637..b9ebe15afb13 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1323,7 +1323,7 @@ static int count_tracepoints(void)
 	DIR *events_dir;
 	int cnt = 0;
 
-	events_dir = opendir(tracing_events_path);
+	events_dir = tracing_events__opendir();
 
 	TEST_ASSERT_VAL("Can't open events dir", events_dir);
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 24668300b327..15eec49e71a1 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -191,7 +191,7 @@ struct tracepoint_path *tracepoint_id_to_path(u64 config)
 	char evt_path[MAXPATHLEN];
 	char *dir_path;
 
-	sys_dir = opendir(tracing_events_path);
+	sys_dir = tracing_events__opendir();
 	if (!sys_dir)
 		return NULL;
 
@@ -578,7 +578,7 @@ static int add_tracepoint_multi_sys(struct list_head *list, int *idx,
 	DIR *events_dir;
 	int ret = 0;
 
-	events_dir = opendir(tracing_events_path);
+	events_dir = tracing_events__opendir();
 	if (!events_dir) {
 		tracepoint_error(err, errno, sys_name, evt_name);
 		return -1;
@@ -2106,7 +2106,7 @@ void print_tracepoint_events(const char *subsys_glob, const char *event_glob,
 	bool evt_num_known = false;
 
 restart:
-	sys_dir = opendir(tracing_events_path);
+	sys_dir = tracing_events__opendir();
 	if (!sys_dir)
 		return;
 
@@ -2200,7 +2200,7 @@ int is_valid_tracepoint(const char *event_string)
 	char evt_path[MAXPATHLEN];
 	char *dir_path;
 
-	sys_dir = opendir(tracing_events_path);
+	sys_dir = tracing_events__opendir();
 	if (!sys_dir)
 		return 0;
 
