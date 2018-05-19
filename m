Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbeESLl7 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 07:41:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45463 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752175AbeESLl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 07:41:56 -0400
Date: Sat, 19 May 2018 04:41:47 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-54bcs15n0cp6gwcgpc4hptyc@git.kernel.org>
Cc: jolsa@kernel.org, hpa@zytor.com, mingo@kernel.org, dsahern@gmail.com,
        namhyung@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, acme@redhat.com, wangnan0@huawei.com,
        tglx@linutronix.de
Reply-To: adrian.hunter@intel.com, namhyung@kernel.org, dsahern@gmail.com,
        hpa@zytor.com, mingo@kernel.org, jolsa@kernel.org, tglx@linutronix.de,
        wangnan0@huawei.com, acme@redhat.com, linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Reuse the path to the tracepoint
 /events/ directory
Git-Commit-ID: c02cab228e44aacf161642b63779971f8e39993b
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

Commit-ID:  c02cab228e44aacf161642b63779971f8e39993b
Gitweb:     https://git.kernel.org/tip/c02cab228e44aacf161642b63779971f8e39993b
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 17 May 2018 14:22:37 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 17 May 2018 14:25:07 -0300

perf tools: Reuse the path to the tracepoint /events/ directory

When using for_each_event() we needlessly rebuild the whole path to
the tracepoint directory, reuse the dir_path instead, saving some cycles
and reducing the size of the next patch.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-54bcs15n0cp6gwcgpc4hptyc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 2fc4ee8b86c1..f9d5bbd63484 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -156,13 +156,12 @@ struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
 		    (strcmp(sys_dirent->d_name, ".")) &&	\
 		    (strcmp(sys_dirent->d_name, "..")))
 
-static int tp_event_has_id(struct dirent *sys_dir, struct dirent *evt_dir)
+static int tp_event_has_id(const char *dir_path, struct dirent *evt_dir)
 {
 	char evt_path[MAXPATHLEN];
 	int fd;
 
-	snprintf(evt_path, MAXPATHLEN, "%s/%s/%s/id", tracing_events_path,
-			sys_dir->d_name, evt_dir->d_name);
+	snprintf(evt_path, MAXPATHLEN, "%s/%s/id", dir_path, evt_dir->d_name);
 	fd = open(evt_path, O_RDONLY);
 	if (fd < 0)
 		return -EINVAL;
@@ -171,12 +170,12 @@ static int tp_event_has_id(struct dirent *sys_dir, struct dirent *evt_dir)
 	return 0;
 }
 
-#define for_each_event(sys_dirent, evt_dir, evt_dirent)		\
+#define for_each_event(dir_path, evt_dir, evt_dirent)		\
 	while ((evt_dirent = readdir(evt_dir)) != NULL)		\
 		if (evt_dirent->d_type == DT_DIR &&		\
 		    (strcmp(evt_dirent->d_name, ".")) &&	\
 		    (strcmp(evt_dirent->d_name, "..")) &&	\
-		    (!tp_event_has_id(sys_dirent, evt_dirent)))
+		    (!tp_event_has_id(dir_path, evt_dirent)))
 
 #define MAX_EVENT_LENGTH 512
 
@@ -204,7 +203,7 @@ struct tracepoint_path *tracepoint_id_to_path(u64 config)
 		if (!evt_dir)
 			continue;
 
-		for_each_event(sys_dirent, evt_dir, evt_dirent) {
+		for_each_event(dir_path, evt_dir, evt_dirent) {
 
 			scnprintf(evt_path, MAXPATHLEN, "%s/%s/id", dir_path,
 				  evt_dirent->d_name);
@@ -2119,7 +2118,7 @@ restart:
 		if (!evt_dir)
 			continue;
 
-		for_each_event(sys_dirent, evt_dir, evt_dirent) {
+		for_each_event(dir_path, evt_dir, evt_dirent) {
 			if (event_glob != NULL &&
 			    !strglobmatch(evt_dirent->d_name, event_glob))
 				continue;
@@ -2199,7 +2198,7 @@ int is_valid_tracepoint(const char *event_string)
 		if (!evt_dir)
 			continue;
 
-		for_each_event(sys_dirent, evt_dir, evt_dirent) {
+		for_each_event(dir_path, evt_dir, evt_dirent) {
 			snprintf(evt_path, MAXPATHLEN, "%s:%s",
 				 sys_dirent->d_name, evt_dirent->d_name);
 			if (!strcmp(evt_path, event_string)) {
