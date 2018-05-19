Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752650AbeESK6b (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 06:58:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752296AbeESKzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 06:55:39 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 06/18] perf parse-events: Use get/put_events_file()
Date: Sat, 19 May 2018 07:54:55 -0300
Message-Id: <20180519105507.16450-7-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180519105507.16450-1-acme@kernel.org>
References: <20180519105507.16450-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Instead of accessing the trace_events_path variable directly, that may
not have been properly initialized wrt detecting where tracefs is
mounted.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-id7hzn1ydgkxbumeve5wapqz@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/parse-events.c |  7 +++---
 tools/perf/util/parse-events.c  | 50 +++++++++++++++++++++++++++--------------
 tools/perf/util/trace-event.c   |  8 +++++--
 3 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 6829dd416a99..6d57d7082637 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1328,7 +1328,7 @@ static int count_tracepoints(void)
 	TEST_ASSERT_VAL("Can't open events dir", events_dir);
 
 	while ((events_ent = readdir(events_dir))) {
-		char sys_path[PATH_MAX];
+		char *sys_path;
 		struct dirent *sys_ent;
 		DIR *sys_dir;
 
@@ -1339,8 +1339,8 @@ static int count_tracepoints(void)
 		    || !strcmp(events_ent->d_name, "header_page"))
 			continue;
 
-		scnprintf(sys_path, PATH_MAX, "%s/%s",
-			  tracing_events_path, events_ent->d_name);
+		sys_path = get_events_file(events_ent->d_name);
+		TEST_ASSERT_VAL("Can't get sys path", sys_path);
 
 		sys_dir = opendir(sys_path);
 		TEST_ASSERT_VAL("Can't open sys dir", sys_dir);
@@ -1356,6 +1356,7 @@ static int count_tracepoints(void)
 		}
 
 		closedir(sys_dir);
+		put_events_file(sys_path);
 	}
 
 	closedir(events_dir);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index f9d5bbd63484..24668300b327 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -189,19 +189,19 @@ struct tracepoint_path *tracepoint_id_to_path(u64 config)
 	int fd;
 	u64 id;
 	char evt_path[MAXPATHLEN];
-	char dir_path[MAXPATHLEN];
+	char *dir_path;
 
 	sys_dir = opendir(tracing_events_path);
 	if (!sys_dir)
 		return NULL;
 
 	for_each_subsystem(sys_dir, sys_dirent) {
-
-		snprintf(dir_path, MAXPATHLEN, "%s/%s", tracing_events_path,
-			 sys_dirent->d_name);
+		dir_path = get_events_file(sys_dirent->d_name);
+		if (!dir_path)
+			continue;
 		evt_dir = opendir(dir_path);
 		if (!evt_dir)
-			continue;
+			goto next;
 
 		for_each_event(dir_path, evt_dir, evt_dirent) {
 
@@ -217,6 +217,7 @@ struct tracepoint_path *tracepoint_id_to_path(u64 config)
 			close(fd);
 			id = atoll(id_buf);
 			if (id == config) {
+				put_events_file(dir_path);
 				closedir(evt_dir);
 				closedir(sys_dir);
 				path = zalloc(sizeof(*path));
@@ -241,6 +242,8 @@ struct tracepoint_path *tracepoint_id_to_path(u64 config)
 			}
 		}
 		closedir(evt_dir);
+next:
+		put_events_file(dir_path);
 	}
 
 	closedir(sys_dir);
@@ -511,14 +514,19 @@ static int add_tracepoint_multi_event(struct list_head *list, int *idx,
 				      struct parse_events_error *err,
 				      struct list_head *head_config)
 {
-	char evt_path[MAXPATHLEN];
+	char *evt_path;
 	struct dirent *evt_ent;
 	DIR *evt_dir;
 	int ret = 0, found = 0;
 
-	snprintf(evt_path, MAXPATHLEN, "%s/%s", tracing_events_path, sys_name);
+	evt_path = get_events_file(sys_name);
+	if (!evt_path) {
+		tracepoint_error(err, errno, sys_name, evt_name);
+		return -1;
+	}
 	evt_dir = opendir(evt_path);
 	if (!evt_dir) {
+		put_events_file(evt_path);
 		tracepoint_error(err, errno, sys_name, evt_name);
 		return -1;
 	}
@@ -544,6 +552,7 @@ static int add_tracepoint_multi_event(struct list_head *list, int *idx,
 		ret = -1;
 	}
 
+	put_events_file(evt_path);
 	closedir(evt_dir);
 	return ret;
 }
@@ -2091,7 +2100,7 @@ void print_tracepoint_events(const char *subsys_glob, const char *event_glob,
 	DIR *sys_dir, *evt_dir;
 	struct dirent *sys_dirent, *evt_dirent;
 	char evt_path[MAXPATHLEN];
-	char dir_path[MAXPATHLEN];
+	char *dir_path;
 	char **evt_list = NULL;
 	unsigned int evt_i = 0, evt_num = 0;
 	bool evt_num_known = false;
@@ -2112,11 +2121,12 @@ void print_tracepoint_events(const char *subsys_glob, const char *event_glob,
 		    !strglobmatch(sys_dirent->d_name, subsys_glob))
 			continue;
 
-		snprintf(dir_path, MAXPATHLEN, "%s/%s", tracing_events_path,
-			 sys_dirent->d_name);
+		dir_path = get_events_file(sys_dirent->d_name);
+		if (!dir_path)
+			continue;
 		evt_dir = opendir(dir_path);
 		if (!evt_dir)
-			continue;
+			goto next;
 
 		for_each_event(dir_path, evt_dir, evt_dirent) {
 			if (event_glob != NULL &&
@@ -2132,11 +2142,15 @@ void print_tracepoint_events(const char *subsys_glob, const char *event_glob,
 				 sys_dirent->d_name, evt_dirent->d_name);
 
 			evt_list[evt_i] = strdup(evt_path);
-			if (evt_list[evt_i] == NULL)
+			if (evt_list[evt_i] == NULL) {
+				put_events_file(dir_path);
 				goto out_close_evt_dir;
+			}
 			evt_i++;
 		}
 		closedir(evt_dir);
+next:
+		put_events_file(dir_path);
 	}
 	closedir(sys_dir);
 
@@ -2184,19 +2198,19 @@ int is_valid_tracepoint(const char *event_string)
 	DIR *sys_dir, *evt_dir;
 	struct dirent *sys_dirent, *evt_dirent;
 	char evt_path[MAXPATHLEN];
-	char dir_path[MAXPATHLEN];
+	char *dir_path;
 
 	sys_dir = opendir(tracing_events_path);
 	if (!sys_dir)
 		return 0;
 
 	for_each_subsystem(sys_dir, sys_dirent) {
-
-		snprintf(dir_path, MAXPATHLEN, "%s/%s", tracing_events_path,
-			 sys_dirent->d_name);
+		dir_path = get_events_file(sys_dirent->d_name);
+		if (!dir_path)
+			continue;
 		evt_dir = opendir(dir_path);
 		if (!evt_dir)
-			continue;
+			goto next;
 
 		for_each_event(dir_path, evt_dir, evt_dirent) {
 			snprintf(evt_path, MAXPATHLEN, "%s:%s",
@@ -2208,6 +2222,8 @@ int is_valid_tracepoint(const char *event_string)
 			}
 		}
 		closedir(evt_dir);
+next:
+		put_events_file(dir_path);
 	}
 	closedir(sys_dir);
 	return 0;
diff --git a/tools/perf/util/trace-event.c b/tools/perf/util/trace-event.c
index 16a776371d03..1aa368603268 100644
--- a/tools/perf/util/trace-event.c
+++ b/tools/perf/util/trace-event.c
@@ -75,6 +75,7 @@ void trace_event__cleanup(struct trace_event *t)
 static struct event_format*
 tp_format(const char *sys, const char *name)
 {
+	char *tp_dir = get_events_file(sys);
 	struct pevent *pevent = tevent.pevent;
 	struct event_format *event = NULL;
 	char path[PATH_MAX];
@@ -82,8 +83,11 @@ tp_format(const char *sys, const char *name)
 	char *data;
 	int err;
 
-	scnprintf(path, PATH_MAX, "%s/%s/%s/format",
-		  tracing_events_path, sys, name);
+	if (!tp_dir)
+		return ERR_PTR(-errno);
+
+	scnprintf(path, PATH_MAX, "%s/%s/format", tp_dir, name);
+	put_events_file(tp_dir);
 
 	err = filename__read_str(path, &data, &size);
 	if (err)
-- 
2.14.3
