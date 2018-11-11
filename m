Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B1AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C4320818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C4320818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbeKLGUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:20:30 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50354 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730400AbeKLFsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:19 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsf-0000oO-8L; Sun, 11 Nov 2018 19:58:49 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsa-0001tG-R4; Sun, 11 Nov 2018 19:58:44 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        "Wang Nan" <wangnan0@huawei.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "David Ahern" <dsahern@gmail.com>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        "Jiri Olsa" <jolsa@kernel.org>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.263705088@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 357/366] perf tools: Use readdir() instead of
 deprecated readdir_r()
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Arnaldo Carvalho de Melo <acme@redhat.com>

commit bfc279f3d233150ff260e9e93012e14f86810648 upstream.

The readdir() function is thread safe as long as just one thread uses a
DIR, which is the case when parsing tracepoint event definitions, to
avoid breaking the build with glibc-2.23.90 (upcoming 2.24), use it
instead of readdir_r().

See: http://man7.org/linux/man-pages/man3/readdir.3.html

"However, in modern implementations (including the glibc implementation),
concurrent calls to readdir() that specify different directory streams
are thread-safe.  In cases where multiple threads must read from the
same directory stream, using readdir() with external synchronization is
still preferable to the use of the deprecated readdir_r(3) function."

Noticed while building on a Fedora Rawhide docker container.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-wddn49r6bz6wq4ee3dxbl7lo@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 tools/perf/util/parse-events.c | 60 +++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 30 deletions(-)

--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -123,11 +123,11 @@ static struct event_symbol event_symbols
 #define PERF_EVENT_TYPE(config)		__PERF_EVENT_FIELD(config, TYPE)
 #define PERF_EVENT_ID(config)		__PERF_EVENT_FIELD(config, EVENT)
 
-#define for_each_subsystem(sys_dir, sys_dirent, sys_next)	       \
-	while (!readdir_r(sys_dir, &sys_dirent, &sys_next) && sys_next)	       \
-	if (sys_dirent.d_type == DT_DIR &&				       \
-	   (strcmp(sys_dirent.d_name, ".")) &&				       \
-	   (strcmp(sys_dirent.d_name, "..")))
+#define for_each_subsystem(sys_dir, sys_dirent)			\
+	while ((sys_dirent = readdir(sys_dir)) != NULL)		\
+		if (sys_dirent->d_type == DT_DIR &&		\
+		    (strcmp(sys_dirent->d_name, ".")) &&	\
+		    (strcmp(sys_dirent->d_name, "..")))
 
 static int tp_event_has_id(struct dirent *sys_dir, struct dirent *evt_dir)
 {
@@ -144,12 +144,12 @@ static int tp_event_has_id(struct dirent
 	return 0;
 }
 
-#define for_each_event(sys_dirent, evt_dir, evt_dirent, evt_next)	       \
-	while (!readdir_r(evt_dir, &evt_dirent, &evt_next) && evt_next)        \
-	if (evt_dirent.d_type == DT_DIR &&				       \
-	   (strcmp(evt_dirent.d_name, ".")) &&				       \
-	   (strcmp(evt_dirent.d_name, "..")) &&				       \
-	   (!tp_event_has_id(&sys_dirent, &evt_dirent)))
+#define for_each_event(sys_dirent, evt_dir, evt_dirent)		\
+	while ((evt_dirent = readdir(evt_dir)) != NULL)		\
+		if (evt_dirent->d_type == DT_DIR &&		\
+		    (strcmp(evt_dirent->d_name, ".")) &&	\
+		    (strcmp(evt_dirent->d_name, "..")) &&	\
+		    (!tp_event_has_id(sys_dirent, evt_dirent)))
 
 #define MAX_EVENT_LENGTH 512
 
@@ -158,7 +158,7 @@ struct tracepoint_path *tracepoint_id_to
 {
 	struct tracepoint_path *path = NULL;
 	DIR *sys_dir, *evt_dir;
-	struct dirent *sys_next, *evt_next, sys_dirent, evt_dirent;
+	struct dirent *sys_dirent, *evt_dirent;
 	char id_buf[24];
 	int fd;
 	u64 id;
@@ -172,18 +172,18 @@ struct tracepoint_path *tracepoint_id_to
 	if (!sys_dir)
 		return NULL;
 
-	for_each_subsystem(sys_dir, sys_dirent, sys_next) {
+	for_each_subsystem(sys_dir, sys_dirent) {
 
 		snprintf(dir_path, MAXPATHLEN, "%s/%s", tracing_events_path,
-			 sys_dirent.d_name);
+			 sys_dirent->d_name);
 		evt_dir = opendir(dir_path);
 		if (!evt_dir)
 			continue;
 
-		for_each_event(sys_dirent, evt_dir, evt_dirent, evt_next) {
+		for_each_event(sys_dirent, evt_dir, evt_dirent) {
 
 			snprintf(evt_path, MAXPATHLEN, "%s/%s/id", dir_path,
-				 evt_dirent.d_name);
+				 evt_dirent->d_name);
 			fd = open(evt_path, O_RDONLY);
 			if (fd < 0)
 				continue;
@@ -208,9 +208,9 @@ struct tracepoint_path *tracepoint_id_to
 					free(path);
 					return NULL;
 				}
-				strncpy(path->system, sys_dirent.d_name,
+				strncpy(path->system, sys_dirent->d_name,
 					MAX_EVENT_LENGTH);
-				strncpy(path->name, evt_dirent.d_name,
+				strncpy(path->name, evt_dirent->d_name,
 					MAX_EVENT_LENGTH);
 				return path;
 			}
@@ -1003,7 +1003,7 @@ void print_tracepoint_events(const char
 			     bool name_only)
 {
 	DIR *sys_dir, *evt_dir;
-	struct dirent *sys_next, *evt_next, sys_dirent, evt_dirent;
+	struct dirent *sys_dirent, *evt_dirent;
 	char evt_path[MAXPATHLEN];
 	char dir_path[MAXPATHLEN];
 
@@ -1016,29 +1016,29 @@ void print_tracepoint_events(const char
 	if (!sys_dir)
 		return;
 
-	for_each_subsystem(sys_dir, sys_dirent, sys_next) {
+	for_each_subsystem(sys_dir, sys_dirent) {
 		if (subsys_glob != NULL && 
-		    !strglobmatch(sys_dirent.d_name, subsys_glob))
+		    !strglobmatch(sys_dirent->d_name, subsys_glob))
 			continue;
 
 		snprintf(dir_path, MAXPATHLEN, "%s/%s", tracing_events_path,
-			 sys_dirent.d_name);
+			 sys_dirent->d_name);
 		evt_dir = opendir(dir_path);
 		if (!evt_dir)
 			continue;
 
-		for_each_event(sys_dirent, evt_dir, evt_dirent, evt_next) {
+		for_each_event(sys_dirent, evt_dir, evt_dirent) {
 			if (event_glob != NULL && 
-			    !strglobmatch(evt_dirent.d_name, event_glob))
+			    !strglobmatch(evt_dirent->d_name, event_glob))
 				continue;
 
 			if (name_only) {
-				printf("%s:%s ", sys_dirent.d_name, evt_dirent.d_name);
+				printf("%s:%s ", sys_dirent->d_name, evt_dirent->d_name);
 				continue;
 			}
 
 			snprintf(evt_path, MAXPATHLEN, "%s:%s",
-				 sys_dirent.d_name, evt_dirent.d_name);
+				 sys_dirent->d_name, evt_dirent->d_name);
 			printf("  %-50s [%s]\n", evt_path,
 				event_type_descriptors[PERF_TYPE_TRACEPOINT]);
 		}
@@ -1054,7 +1054,7 @@ void print_tracepoint_events(const char
 int is_valid_tracepoint(const char *event_string)
 {
 	DIR *sys_dir, *evt_dir;
-	struct dirent *sys_next, *evt_next, sys_dirent, evt_dirent;
+	struct dirent *sys_dirent, *evt_dirent;
 	char evt_path[MAXPATHLEN];
 	char dir_path[MAXPATHLEN];
 
@@ -1065,17 +1065,17 @@ int is_valid_tracepoint(const char *even
 	if (!sys_dir)
 		return 0;
 
-	for_each_subsystem(sys_dir, sys_dirent, sys_next) {
+	for_each_subsystem(sys_dir, sys_dirent) {
 
 		snprintf(dir_path, MAXPATHLEN, "%s/%s", tracing_events_path,
-			 sys_dirent.d_name);
+			 sys_dirent->d_name);
 		evt_dir = opendir(dir_path);
 		if (!evt_dir)
 			continue;
 
-		for_each_event(sys_dirent, evt_dir, evt_dirent, evt_next) {
+		for_each_event(sys_dirent, evt_dir, evt_dirent) {
 			snprintf(evt_path, MAXPATHLEN, "%s:%s",
-				 sys_dirent.d_name, evt_dirent.d_name);
+				 sys_dirent->d_name, evt_dirent->d_name);
 			if (!strcmp(evt_path, event_string)) {
 				closedir(evt_dir);
 				closedir(sys_dir);

