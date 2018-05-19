Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752491AbeESKzm (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 06:55:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752337AbeESKzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 06:55:33 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 04/18] tools lib api fs tracing_path: Introduce get/put_events_file() helpers
Date: Sat, 19 May 2018 07:54:53 -0300
Message-Id: <20180519105507.16450-5-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180519105507.16450-1-acme@kernel.org>
References: <20180519105507.16450-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To make reading events files a tad more compact than with
get_tracing_files("events/foo").

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-do6xgtwpmfl8zjs1euxsd2du@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/api/fs/tracing_path.c    | 15 +++++++++++++++
 tools/lib/api/fs/tracing_path.h    |  5 +++++
 tools/perf/util/trace-event-info.c | 11 +++++------
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/tools/lib/api/fs/tracing_path.c b/tools/lib/api/fs/tracing_path.c
index 6f5fe942eff4..9cd282425929 100644
--- a/tools/lib/api/fs/tracing_path.c
+++ b/tools/lib/api/fs/tracing_path.c
@@ -86,6 +86,21 @@ void put_tracing_file(char *file)
 	free(file);
 }
 
+char *get_events_file(const char *name)
+{
+	char *file;
+
+	if (asprintf(&file, "%s/events/%s", tracing_path_mount(), name) < 0)
+		return NULL;
+
+	return file;
+}
+
+void put_events_file(char *file)
+{
+	free(file);
+}
+
 int tracing_path__strerror_open_tp(int err, char *buf, size_t size,
 				   const char *sys, const char *name)
 {
diff --git a/tools/lib/api/fs/tracing_path.h b/tools/lib/api/fs/tracing_path.h
index 1b65decedfc0..3b32fb439f12 100644
--- a/tools/lib/api/fs/tracing_path.h
+++ b/tools/lib/api/fs/tracing_path.h
@@ -12,5 +12,10 @@ const char *tracing_path_mount(void);
 char *get_tracing_file(const char *name);
 void put_tracing_file(char *file);
 
+char *get_events_file(const char *name);
+void put_events_file(char *file);
+
+#define zput_events_file(ptr) ({ free(*ptr); *ptr = NULL; })
+
 int tracing_path__strerror_open_tp(int err, char *buf, size_t size, const char *sys, const char *name);
 #endif /* __API_FS_TRACING_PATH_H */
diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
index d7f2113462fb..c85d0d1a65ed 100644
--- a/tools/perf/util/trace-event-info.c
+++ b/tools/perf/util/trace-event-info.c
@@ -103,11 +103,10 @@ static int record_file(const char *file, ssize_t hdr_sz)
 
 static int record_header_files(void)
 {
-	char *path;
+	char *path = get_events_file("header_page");
 	struct stat st;
 	int err = -EIO;
 
-	path = get_tracing_file("events/header_page");
 	if (!path) {
 		pr_debug("can't get tracing/events/header_page");
 		return -ENOMEM;
@@ -128,9 +127,9 @@ static int record_header_files(void)
 		goto out;
 	}
 
-	put_tracing_file(path);
+	put_events_file(path);
 
-	path = get_tracing_file("events/header_event");
+	path = get_events_file("header_event");
 	if (!path) {
 		pr_debug("can't get tracing/events/header_event");
 		err = -ENOMEM;
@@ -154,7 +153,7 @@ static int record_header_files(void)
 
 	err = 0;
 out:
-	put_tracing_file(path);
+	put_events_file(path);
 	return err;
 }
 
@@ -243,7 +242,7 @@ static int record_ftrace_files(struct tracepoint_path *tps)
 	char *path;
 	int ret;
 
-	path = get_tracing_file("events/ftrace");
+	path = get_events_file("ftrace");
 	if (!path) {
 		pr_debug("can't get tracing/events/ftrace");
 		return -ENOMEM;
-- 
2.14.3
