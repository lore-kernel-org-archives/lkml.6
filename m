Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753058AbeBFSZD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 13:25:03 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42860 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752602AbeBFSY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 13:24:26 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 16/17] perf tests: Fix dwarf unwind for stripped binaries
Date: Tue,  6 Feb 2018 19:18:12 +0100
Message-Id: <20180206181813.10943-17-jolsa@kernel.org>
In-Reply-To: <20180206181813.10943-1-jolsa@kernel.org>
References: <20180206181813.10943-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we strip the perf binary, dwarf unwind test stop
to work. The reason is that strip will remove static
function symbols, which we need to check for unwind.

This change will keep this test working in cases where
the global symbols are put into dynamic symbol table,
which is the case on x86. It still won't work on powerpc.

Making those 5 local functions global, and adding
'test_dwarf_unwind__' to their names.

Link: http://lkml.kernel.org/n/tip-y6ovucoyct8nimmzggi6tq9s@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/dwarf-unwind.c | 46 +++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
index 260418969120..2f008067d989 100644
--- a/tools/perf/tests/dwarf-unwind.c
+++ b/tools/perf/tests/dwarf-unwind.c
@@ -37,6 +37,19 @@ static int init_live_machine(struct machine *machine)
 						  mmap_handler, machine, true, 500);
 }
 
+/*
+ * We need to keep these functions global, despite the
+ * fact that they are used only locally in this object,
+ * in order to keep them around even if the binary is
+ * stripped. If they are gone, the unwind check for
+ * symbol fails.
+ */
+int test_dwarf_unwind__thread(struct thread *thread);
+int test_dwarf_unwind__compare(void *p1, void *p2);
+int test_dwarf_unwind__krava_3(struct thread *thread);
+int test_dwarf_unwind__krava_2(struct thread *thread);
+int test_dwarf_unwind__krava_1(struct thread *thread);
+
 #define MAX_STACK 8
 
 static int unwind_entry(struct unwind_entry *entry, void *arg)
@@ -45,12 +58,12 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 	char *symbol = entry->sym ? entry->sym->name : NULL;
 	static const char *funcs[MAX_STACK] = {
 		"test__arch_unwind_sample",
-		"unwind_thread",
-		"compare",
+		"test_dwarf_unwind__thread",
+		"test_dwarf_unwind__compare",
 		"bsearch",
-		"krava_3",
-		"krava_2",
-		"krava_1",
+		"test_dwarf_unwind__krava_3",
+		"test_dwarf_unwind__krava_2",
+		"test_dwarf_unwind__krava_1",
 		"test__dwarf_unwind"
 	};
 	/*
@@ -77,7 +90,7 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 	return strcmp((const char *) symbol, funcs[idx]);
 }
 
-static noinline int unwind_thread(struct thread *thread)
+noinline int test_dwarf_unwind__thread(struct thread *thread)
 {
 	struct perf_sample sample;
 	unsigned long cnt = 0;
@@ -108,7 +121,7 @@ static noinline int unwind_thread(struct thread *thread)
 
 static int global_unwind_retval = -INT_MAX;
 
-static noinline int compare(void *p1, void *p2)
+noinline int test_dwarf_unwind__compare(void *p1, void *p2)
 {
 	/* Any possible value should be 'thread' */
 	struct thread *thread = *(struct thread **)p1;
@@ -117,17 +130,17 @@ static noinline int compare(void *p1, void *p2)
 		/* Call unwinder twice for both callchain orders. */
 		callchain_param.order = ORDER_CALLER;
 
-		global_unwind_retval = unwind_thread(thread);
+		global_unwind_retval = test_dwarf_unwind__thread(thread);
 		if (!global_unwind_retval) {
 			callchain_param.order = ORDER_CALLEE;
-			global_unwind_retval = unwind_thread(thread);
+			global_unwind_retval = test_dwarf_unwind__thread(thread);
 		}
 	}
 
 	return p1 - p2;
 }
 
-static noinline int krava_3(struct thread *thread)
+noinline int test_dwarf_unwind__krava_3(struct thread *thread)
 {
 	struct thread *array[2] = {thread, thread};
 	void *fp = &bsearch;
@@ -141,18 +154,19 @@ static noinline int krava_3(struct thread *thread)
 			size_t, int (*)(void *, void *));
 
 	_bsearch = fp;
-	_bsearch(array, &thread, 2, sizeof(struct thread **), compare);
+	_bsearch(array, &thread, 2, sizeof(struct thread **),
+		 test_dwarf_unwind__compare);
 	return global_unwind_retval;
 }
 
-static noinline int krava_2(struct thread *thread)
+noinline int test_dwarf_unwind__krava_2(struct thread *thread)
 {
-	return krava_3(thread);
+	return test_dwarf_unwind__krava_3(thread);
 }
 
-static noinline int krava_1(struct thread *thread)
+noinline int test_dwarf_unwind__krava_1(struct thread *thread)
 {
-	return krava_2(thread);
+	return test_dwarf_unwind__krava_2(thread);
 }
 
 int test__dwarf_unwind(struct test *test __maybe_unused, int subtest __maybe_unused)
@@ -189,7 +203,7 @@ int test__dwarf_unwind(struct test *test __maybe_unused, int subtest __maybe_unu
 		goto out;
 	}
 
-	err = krava_1(thread);
+	err = test_dwarf_unwind__krava_1(thread);
 	thread__put(thread);
 
  out:
-- 
2.13.6
