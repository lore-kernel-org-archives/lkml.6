Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752410AbeESKzi (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 06:55:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752296AbeESKza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 06:55:30 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 03/18] tools lib api: Unexport 'tracing_path' variable
Date: Sat, 19 May 2018 07:54:52 -0300
Message-Id: <20180519105507.16450-4-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180519105507.16450-1-acme@kernel.org>
References: <20180519105507.16450-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

One should use tracing_path_mount() instead, so more things get done
lazily instead of at every 'perf' tool call startup.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-fci4yll35idd9yuslp67vqc2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/api/fs/tracing_path.c | 4 ++--
 tools/lib/api/fs/tracing_path.h | 1 -
 tools/perf/perf.c               | 5 +----
 tools/perf/util/probe-file.c    | 3 +--
 4 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/tools/lib/api/fs/tracing_path.c b/tools/lib/api/fs/tracing_path.c
index 4f8ec7d476b8..6f5fe942eff4 100644
--- a/tools/lib/api/fs/tracing_path.c
+++ b/tools/lib/api/fs/tracing_path.c
@@ -14,7 +14,7 @@
 #include "tracing_path.h"
 
 static char tracing_mnt[PATH_MAX]  = "/sys/kernel/debug";
-char tracing_path[PATH_MAX]        = "/sys/kernel/debug/tracing";
+static char tracing_path[PATH_MAX]        = "/sys/kernel/debug/tracing";
 char tracing_events_path[PATH_MAX] = "/sys/kernel/debug/tracing/events";
 
 
@@ -75,7 +75,7 @@ char *get_tracing_file(const char *name)
 {
 	char *file;
 
-	if (asprintf(&file, "%s/%s", tracing_path, name) < 0)
+	if (asprintf(&file, "%s/%s", tracing_path_mount(), name) < 0)
 		return NULL;
 
 	return file;
diff --git a/tools/lib/api/fs/tracing_path.h b/tools/lib/api/fs/tracing_path.h
index 0066f06cc381..1b65decedfc0 100644
--- a/tools/lib/api/fs/tracing_path.h
+++ b/tools/lib/api/fs/tracing_path.h
@@ -4,7 +4,6 @@
 
 #include <linux/types.h>
 
-extern char tracing_path[];
 extern char tracing_events_path[];
 
 void tracing_path_set(const char *mountpoint);
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index cd6ea55d4b0c..d5a0878de816 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -238,7 +238,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			(*argc)--;
 		} else if (strstarts(cmd, CMD_DEBUGFS_DIR)) {
 			tracing_path_set(cmd + strlen(CMD_DEBUGFS_DIR));
-			fprintf(stderr, "dir: %s\n", tracing_path);
+			fprintf(stderr, "dir: %s\n", tracing_path_mount());
 			if (envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--list-cmds")) {
@@ -463,9 +463,6 @@ int main(int argc, const char **argv)
 		return err;
 	set_buildid_dir(NULL);
 
-	/* get debugfs/tracefs mount point from /proc/mounts */
-	tracing_path_mount();
-
 	/*
 	 * "perf-xxxx" is the same as "perf xxxx", but we obviously:
 	 *
diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index 4ae1123c6794..b76088fadf3d 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -84,8 +84,7 @@ int open_trace_file(const char *trace_file, bool readwrite)
 	char buf[PATH_MAX];
 	int ret;
 
-	ret = e_snprintf(buf, PATH_MAX, "%s/%s",
-			 tracing_path, trace_file);
+	ret = e_snprintf(buf, PATH_MAX, "%s/%s", tracing_path_mount(), trace_file);
 	if (ret >= 0) {
 		pr_debug("Opening %s write=%d\n", buf, readwrite);
 		if (readwrite && !probe_event_dry_run)
-- 
2.14.3
