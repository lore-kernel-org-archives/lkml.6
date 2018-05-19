Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752467AbeESLo2 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 07:44:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47875 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752053AbeESLo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 07:44:26 -0400
Date: Sat, 19 May 2018 04:44:12 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-35xhrq91u94uc1djtclek1ie@git.kernel.org>
Cc: wangnan0@huawei.com, tglx@linutronix.de, adrian.hunter@intel.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
        dsahern@gmail.com, jolsa@kernel.org, hpa@zytor.com, acme@redhat.com
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, dsahern@gmail.com,
        jolsa@kernel.org, acme@redhat.com, hpa@zytor.com,
        adrian.hunter@intel.com, wangnan0@huawei.com, tglx@linutronix.de,
        namhyung@kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Read the cache line size lazily
Git-Commit-ID: 9ac94e31ca8c6311ec9eb68aea513e39ad809013
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

Commit-ID:  9ac94e31ca8c6311ec9eb68aea513e39ad809013
Gitweb:     https://git.kernel.org/tip/9ac94e31ca8c6311ec9eb68aea513e39ad809013
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 17 May 2018 15:03:05 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 17 May 2018 16:03:34 -0300

perf tools: Read the cache line size lazily

It is not read as commonly as 'page_size', so it makes sense to read it
lazily, caching its value when it is first read.

Less files open unconditionally at startup.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-35xhrq91u94uc1djtclek1ie@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/perf.c      | 11 -----------
 tools/perf/util/sort.c |  4 ++--
 tools/perf/util/sort.h |  4 ++--
 tools/perf/util/util.c | 21 ++++++++++++++++++++-
 tools/perf/util/util.h |  2 +-
 5 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index d5a0878de816..cefd8f74630c 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -421,16 +421,6 @@ void pthread__unblock_sigwinch(void)
 	pthread_sigmask(SIG_UNBLOCK, &set, NULL);
 }
 
-#ifdef _SC_LEVEL1_DCACHE_LINESIZE
-#define cache_line_size(cacheline_sizep) *cacheline_sizep = sysconf(_SC_LEVEL1_DCACHE_LINESIZE)
-#else
-static void cache_line_size(int *cacheline_sizep)
-{
-	if (sysfs__read_int("devices/system/cpu/cpu0/cache/index0/coherency_line_size", cacheline_sizep))
-		pr_debug("cannot determine cache line size");
-}
-#endif
-
 int main(int argc, const char **argv)
 {
 	int err;
@@ -444,7 +434,6 @@ int main(int argc, const char **argv)
 
 	/* The page_size is placed in util object. */
 	page_size = sysconf(_SC_PAGE_SIZE);
-	cache_line_size(&cacheline_size);
 
 	if (sysctl__read_int("kernel/perf_event_max_stack", &value) == 0)
 		sysctl_perf_event_max_stack = value;
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index e65903a695a6..4058ade352a5 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2582,7 +2582,7 @@ int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
 		if (sort__mode != SORT_MODE__MEMORY)
 			return -EINVAL;
 
-		if (sd->entry == &sort_mem_dcacheline && cacheline_size == 0)
+		if (sd->entry == &sort_mem_dcacheline && cacheline_size() == 0)
 			return -EINVAL;
 
 		if (sd->entry == &sort_mem_daddr_sym)
@@ -2628,7 +2628,7 @@ static int setup_sort_list(struct perf_hpp_list *list, char *str,
 		if (*tok) {
 			ret = sort_dimension__add(list, tok, evlist, level);
 			if (ret == -EINVAL) {
-				if (!cacheline_size && !strncasecmp(tok, "dcacheline", strlen(tok)))
+				if (!cacheline_size() && !strncasecmp(tok, "dcacheline", strlen(tok)))
 					pr_err("The \"dcacheline\" --sort key needs to know the cacheline size and it couldn't be determined on this system");
 				else
 					pr_err("Invalid --sort key: `%s'", tok);
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 035b62e2c60b..9e6896293bbd 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -186,13 +186,13 @@ static inline float hist_entry__get_percent_limit(struct hist_entry *he)
 static inline u64 cl_address(u64 address)
 {
 	/* return the cacheline of the address */
-	return (address & ~(cacheline_size - 1));
+	return (address & ~(cacheline_size() - 1));
 }
 
 static inline u64 cl_offset(u64 address)
 {
 	/* return the cacheline of the address */
-	return (address & (cacheline_size - 1));
+	return (address & (cacheline_size() - 1));
 }
 
 enum sort_mode {
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 1019bbc5dbd8..99ab52165680 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -38,7 +38,26 @@ void perf_set_multithreaded(void)
 }
 
 unsigned int page_size;
-int cacheline_size;
+
+#ifdef _SC_LEVEL1_DCACHE_LINESIZE
+#define cache_line_size(cacheline_sizep) *cacheline_sizep = sysconf(_SC_LEVEL1_DCACHE_LINESIZE)
+#else
+static void cache_line_size(int *cacheline_sizep)
+{
+	if (sysfs__read_int("devices/system/cpu/cpu0/cache/index0/coherency_line_size", cacheline_sizep))
+		pr_debug("cannot determine cache line size");
+}
+#endif
+
+int cacheline_size(void)
+{
+	static int size;
+
+	if (!size)
+		cache_line_size(&size);
+
+	return size;
+}
 
 int sysctl_perf_event_max_stack = PERF_MAX_STACK_DEPTH;
 int sysctl_perf_event_max_contexts_per_stack = PERF_MAX_CONTEXTS_PER_STACK;
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index c9626c206208..74d21dfe0d29 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -43,7 +43,7 @@ size_t hex_width(u64 v);
 int hex2u64(const char *ptr, u64 *val);
 
 extern unsigned int page_size;
-extern int cacheline_size;
+int __pure cacheline_size(void);
 
 int fetch_kernel_version(unsigned int *puint,
 			 char *str, size_t str_sz);
