Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751238AbeBQLb4 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:31:56 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46823 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750771AbeBQLby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:31:54 -0500
Date: Sat, 17 Feb 2018 03:21:30 -0800
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-fdf7c49c200d1b9909e2204cec5bd68b48605c71@git.kernel.org>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        dsahern@gmail.com, mingo@kernel.org, acme@redhat.com, jolsa@kernel.org,
        hpa@zytor.com, namhyung@kernel.org, alexander.shishkin@linux.intel.com
Reply-To: linux-kernel@vger.kernel.org, peterz@infradead.org,
        namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        dsahern@gmail.com, acme@redhat.com, mingo@kernel.org, hpa@zytor.com,
        jolsa@kernel.org, tglx@linutronix.de
In-Reply-To: <20180206181813.10943-17-jolsa@kernel.org>
References: <20180206181813.10943-17-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tests: Fix dwarf unwind for stripped binaries
Git-Commit-ID: fdf7c49c200d1b9909e2204cec5bd68b48605c71
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

Commit-ID:  fdf7c49c200d1b9909e2204cec5bd68b48605c71
Gitweb:     https://git.kernel.org/tip/fdf7c49c200d1b9909e2204cec5bd68b48605c71
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Tue, 6 Feb 2018 19:18:12 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 10:09:23 -0300

perf tests: Fix dwarf unwind for stripped binaries

When we strip the perf binary, dwarf unwind test stop
to work. The reason is that strip will remove static
function symbols, which we need to check for unwind.

This change will keep this test working in cases where
the global symbols are put into dynamic symbol table,
which is the case on x86. It still won't work on powerpc.

Making those 5 local functions global, and adding
'test_dwarf_unwind__' to their names.

Committer testing:

Before:

  # perf test dwarf
  58: DWARF unwind                               : Ok
  # strip ~/bin/perf
  # perf test dwarf
  58: DWARF unwind                               : FAILED!
  # perf test -v dwarf
  58: DWARF unwind                               :
  --- start ---
  test child forked, pid 6590
  unwind: thread map already set, dso=/home/acme/bin/perf
  <SNIP>
  unwind: access_mem addr 0x7ffce6c48098 val 48563f, offset 1144
  unwind: test__dwarf_unwind:ip = 0x4a54e5 (0xa54e5)
  got: test__dwarf_unwind 0xa54e5, expecting test__dwarf_unwind
  unwind: '':ip = 0x4a50bb (0xa50bb)
  failed: got unresolved address 0xa50bb
  unwind failed
  test child finished with -1
  ---- end ----
  DWARF unwind: FAILED!
  #

After:

  # perf test dwarf
  58: DWARF unwind                               : Ok
  # strip ~/bin/perf
  # perf test dwarf
  58: DWARF unwind                               : Ok
  #
  # perf test -v dwarf
  58: DWARF unwind                               :
  --- start ---
  test child forked, pid 7219
  unwind: thread map already set, dso=/home/acme/bin/perf
  <SNIP>
  unwind: access_mem addr 0x7fff007da2c8 val 48575f, offset 1144
  unwind: test__arch_unwind_sample:ip = 0x589044 (0x189044)
  got: test__arch_unwind_sample 0x189044, expecting test__arch_unwind_sample
  unwind: test_dwarf_unwind__thread:ip = 0x4a52f7 (0xa52f7)
  got: test_dwarf_unwind__thread 0xa52f7, expecting test_dwarf_unwind__thread
  unwind: test_dwarf_unwind__compare:ip = 0x4a5468 (0xa5468)
  got: test_dwarf_unwind__compare 0xa5468, expecting test_dwarf_unwind__compare
  unwind: bsearch:ip = 0x7f6608ae94d8 (0x394d8)
  got: bsearch 0x394d8, expecting bsearch
  unwind: test_dwarf_unwind__krava_3:ip = 0x4a54d1 (0xa54d1)
  got: test_dwarf_unwind__krava_3 0xa54d1, expecting test_dwarf_unwind__krava_3
  unwind: test_dwarf_unwind__krava_2:ip = 0x4a550b (0xa550b)
  got: test_dwarf_unwind__krava_2 0xa550b, expecting test_dwarf_unwind__krava_2
  unwind: test_dwarf_unwind__krava_1:ip = 0x4a554b (0xa554b)
  got: test_dwarf_unwind__krava_1 0xa554b, expecting test_dwarf_unwind__krava_1
  unwind: test__dwarf_unwind:ip = 0x4a5605 (0xa5605)
  got: test__dwarf_unwind 0xa5605, expecting test__dwarf_unwind
  test child finished with 0
  ---- end ----
  DWARF unwind: Ok
  #

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180206181813.10943-17-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/dwarf-unwind.c | 46 +++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
index 26041896..2f00806 100644
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
