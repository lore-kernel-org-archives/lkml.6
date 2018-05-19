Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbeESK4B (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 06:56:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752523AbeESKzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 06:55:54 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 11/18] perf tools: No need to unconditionally read the max_stack sysctls
Date: Sat, 19 May 2018 07:55:00 -0300
Message-Id: <20180519105507.16450-12-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180519105507.16450-1-acme@kernel.org>
References: <20180519105507.16450-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Let tools that need to have those variables with the sysctl current
values use a function that will read them.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-1ljj3oeo5kpt2n1icfd9vowe@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c   |  2 +-
 tools/perf/builtin-trace.c |  2 +-
 tools/perf/perf.c          |  7 -------
 tools/perf/util/evsel.c    |  2 +-
 tools/perf/util/util.c     | 13 +++++++++++++
 tools/perf/util/util.h     |  2 ++
 6 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 3c061c57afb6..7a349fcd3864 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1264,7 +1264,7 @@ int cmd_top(int argc, const char **argv)
 			.proc_map_timeout    = 500,
 			.overwrite	= 1,
 		},
-		.max_stack	     = sysctl_perf_event_max_stack,
+		.max_stack	     = sysctl__max_stack(),
 		.sym_pcnt_filter     = 5,
 		.nr_threads_synthesize = UINT_MAX,
 	};
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c7effcfc40ed..560aed7da36a 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3162,7 +3162,7 @@ int cmd_trace(int argc, const char **argv)
 		mmap_pages_user_set = false;
 
 	if (trace.max_stack == UINT_MAX) {
-		trace.max_stack = input_name ? PERF_MAX_STACK_DEPTH : sysctl_perf_event_max_stack;
+		trace.max_stack = input_name ? PERF_MAX_STACK_DEPTH : sysctl__max_stack();
 		max_stack_user_set = false;
 	}
 
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index cefd8f74630c..51c81509a315 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -426,7 +426,6 @@ int main(int argc, const char **argv)
 	int err;
 	const char *cmd;
 	char sbuf[STRERR_BUFSIZE];
-	int value;
 
 	/* libsubcmd init */
 	exec_cmd_init("perf", PREFIX, PERF_EXEC_PATH, EXEC_PATH_ENVIRONMENT);
@@ -435,12 +434,6 @@ int main(int argc, const char **argv)
 	/* The page_size is placed in util object. */
 	page_size = sysconf(_SC_PAGE_SIZE);
 
-	if (sysctl__read_int("kernel/perf_event_max_stack", &value) == 0)
-		sysctl_perf_event_max_stack = value;
-
-	if (sysctl__read_int("kernel/perf_event_max_contexts_per_stack", &value) == 0)
-		sysctl_perf_event_max_contexts_per_stack = value;
-
 	cmd = extract_argv0_path(argv[0]);
 	if (!cmd)
 		cmd = "perf-help";
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4cd2cf93f726..150db5ed7400 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2862,7 +2862,7 @@ int perf_evsel__open_strerror(struct perf_evsel *evsel, struct target *target,
 			return scnprintf(msg, size,
 					 "Not enough memory to setup event with callchain.\n"
 					 "Hint: Try tweaking /proc/sys/kernel/perf_event_max_stack\n"
-					 "Hint: Current value: %d", sysctl_perf_event_max_stack);
+					 "Hint: Current value: %d", sysctl__max_stack());
 		break;
 	case ENODEV:
 		if (target->cpu_list)
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 99ab52165680..eac5b858a371 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -62,6 +62,19 @@ int cacheline_size(void)
 int sysctl_perf_event_max_stack = PERF_MAX_STACK_DEPTH;
 int sysctl_perf_event_max_contexts_per_stack = PERF_MAX_CONTEXTS_PER_STACK;
 
+int sysctl__max_stack(void)
+{
+	int value;
+
+	if (sysctl__read_int("kernel/perf_event_max_stack", &value) == 0)
+		sysctl_perf_event_max_stack = value;
+
+	if (sysctl__read_int("kernel/perf_event_max_contexts_per_stack", &value) == 0)
+		sysctl_perf_event_max_contexts_per_stack = value;
+
+	return sysctl_perf_event_max_stack;
+}
+
 bool test_attr__enabled;
 
 bool perf_host  = true;
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 74d21dfe0d29..dc58254a2b69 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -45,6 +45,8 @@ int hex2u64(const char *ptr, u64 *val);
 extern unsigned int page_size;
 int __pure cacheline_size(void);
 
+int sysctl__max_stack(void);
+
 int fetch_kernel_version(unsigned int *puint,
 			 char *str, size_t str_sz);
 #define KVER_VERSION(x)		(((x) >> 16) & 0xff)
-- 
2.14.3
