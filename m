Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752520AbeESKzt (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 06:55:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752483AbeESKzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 06:55:42 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 07/18] tools lib api fs tracing_path: Introduce opendir() method
Date: Sat, 19 May 2018 07:54:56 -0300
Message-Id: <20180519105507.16450-8-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180519105507.16450-1-acme@kernel.org>
References: <20180519105507.16450-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
 
-- 
2.14.3
