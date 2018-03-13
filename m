Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751572AbeCMPOr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 11:14:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50455 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751408AbeCMPOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 11:14:46 -0400
Date: Tue, 13 Mar 2018 08:13:43 -0700
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-032db28e5fa3594dfa3df585c54d8b612657f537@git.kernel.org>
Cc: fweisbec@gmail.com, hpa@zytor.com, namhyung@kernel.org,
        tglx@linutronix.de, chabbi.milind@gmail.com, acme@redhat.com,
        dsahern@gmail.com, mingo@kernel.org, onestero@redhat.com,
        will.deacon@arm.com, peterz@infradead.org, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org, hbathini@linux.vnet.ibm.com,
        sukadev@linux.vnet.ibm.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        kan.liang@intel.com, jolsa@kernel.org, torvalds@linux-foundation.org
Reply-To: fweisbec@gmail.com, hpa@zytor.com, namhyung@kernel.org,
        tglx@linutronix.de, chabbi.milind@gmail.com, acme@redhat.com,
        dsahern@gmail.com, onestero@redhat.com, mingo@kernel.org,
        peterz@infradead.org, will.deacon@arm.com, mpe@ellerman.id.au,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        sukadev@linux.vnet.ibm.com, hbathini@linux.vnet.ibm.com,
        jolsa@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        torvalds@linux-foundation.org, kan.liang@intel.com
In-Reply-To: <20180312134548.31532-9-jolsa@kernel.org>
References: <20180312134548.31532-9-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tests: Add breakpoint accounting/modify test
Git-Commit-ID: 032db28e5fa3594dfa3df585c54d8b612657f537
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

Commit-ID:  032db28e5fa3594dfa3df585c54d8b612657f537
Gitweb:     https://git.kernel.org/tip/032db28e5fa3594dfa3df585c54d8b612657f537
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 12 Mar 2018 14:45:48 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Mar 2018 15:23:37 +0100

perf tests: Add breakpoint accounting/modify test

Adding test that:

  - detects the number of watch/break-points,
    skip test if any is missing
  - detects PERF_EVENT_IOC_MODIFY_ATTRIBUTES ioctl,
    skip test if it's missing
  - detects if watchpoints and breakpoints share
    same slots
  - create all possible watchpoints on cpu 0
  - change one of it to breakpoint
  - in case wp and bp do not share slots,
    we create another watchpoint to ensure
    the slot accounting is correct

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Milind Chabbi <chabbi.milind@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Oleg Nesterov <onestero@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Link: http://lkml.kernel.org/r/20180312134548.31532-9-jolsa@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/perf/tests/Build          |   1 +
 tools/perf/tests/bp_account.c   | 195 ++++++++++++++++++++++++++++++++++++++++
 tools/perf/tests/builtin-test.c |   4 +
 tools/perf/tests/tests.h        |   1 +
 4 files changed, 201 insertions(+)

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 87bf3edb037c..62ca0174d5e1 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -20,6 +20,7 @@ perf-y += hists_cumulate.o
 perf-y += python-use.o
 perf-y += bp_signal.o
 perf-y += bp_signal_overflow.o
+perf-y += bp_account.o
 perf-y += task-exit.o
 perf-y += sw-clock.o
 perf-y += mmap-thread-lookup.o
diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
new file mode 100644
index 000000000000..2f75fa0c4fef
--- /dev/null
+++ b/tools/perf/tests/bp_account.c
@@ -0,0 +1,195 @@
+/*
+ * Powerpc needs __SANE_USERSPACE_TYPES__ before <linux/types.h> to select
+ * 'int-ll64.h' and avoid compile warnings when printing __u64 with %llu.
+ */
+#define __SANE_USERSPACE_TYPES__
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <time.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <sys/mman.h>
+#include <linux/compiler.h>
+#include <linux/hw_breakpoint.h>
+#include <sys/ioctl.h>
+
+#include "tests.h"
+#include "debug.h"
+#include "perf.h"
+#include "cloexec.h"
+
+volatile long the_var;
+
+static noinline int test_function(void)
+{
+	return 0;
+}
+
+static int __event(bool is_x, void *addr, struct perf_event_attr *attr)
+{
+	int fd;
+
+	memset(attr, 0, sizeof(struct perf_event_attr));
+	attr->type = PERF_TYPE_BREAKPOINT;
+	attr->size = sizeof(struct perf_event_attr);
+
+	attr->config = 0;
+	attr->bp_type = is_x ? HW_BREAKPOINT_X : HW_BREAKPOINT_W;
+	attr->bp_addr = (unsigned long) addr;
+	attr->bp_len = sizeof(long);
+
+	attr->sample_period = 1;
+	attr->sample_type = PERF_SAMPLE_IP;
+
+	attr->exclude_kernel = 1;
+	attr->exclude_hv = 1;
+
+	fd = sys_perf_event_open(attr, -1, 0, -1,
+				 perf_event_open_cloexec_flag());
+	if (fd < 0) {
+		pr_debug("failed opening event %llx\n", attr->config);
+		return TEST_FAIL;
+	}
+
+	return fd;
+}
+
+static int wp_event(void *addr, struct perf_event_attr *attr)
+{
+	return __event(false, addr, attr);
+}
+
+static int bp_event(void *addr, struct perf_event_attr *attr)
+{
+	return __event(true, addr, attr);
+}
+
+static int bp_accounting(int wp_cnt, int share)
+{
+	struct perf_event_attr attr, attr_mod, attr_new;
+	int i, fd[wp_cnt], fd_wp, ret;
+
+	for (i = 0; i < wp_cnt; i++) {
+		fd[i] = wp_event((void *)&the_var, &attr);
+		TEST_ASSERT_VAL("failed to create wp\n", fd[i] != -1);
+		pr_debug("wp %d created\n", i);
+	}
+
+	attr_mod = attr;
+	attr_mod.bp_type = HW_BREAKPOINT_X;
+	attr_mod.bp_addr = (unsigned long) test_function;
+
+	ret = ioctl(fd[0], PERF_EVENT_IOC_MODIFY_ATTRIBUTES, &attr_mod);
+	TEST_ASSERT_VAL("failed to modify wp\n", ret == 0);
+
+	pr_debug("wp 0 modified to bp\n");
+
+	if (!share) {
+		fd_wp = wp_event((void *)&the_var, &attr_new);
+		TEST_ASSERT_VAL("failed to create max wp\n", fd_wp != -1);
+		pr_debug("wp max created\n");
+	}
+
+	for (i = 0; i < wp_cnt; i++)
+		close(fd[i]);
+
+	return 0;
+}
+
+static int detect_cnt(bool is_x)
+{
+	struct perf_event_attr attr;
+	void *addr = is_x ? test_function : (void *) &the_var;
+	int fd[100], cnt = 0, i;
+
+	while (1) {
+		fd[cnt] = __event(is_x, addr, &attr);
+
+		if (fd[cnt] < 0)
+			break;
+
+		if (cnt == 100) {
+			pr_debug("way too many debug registers, fix the test\n");
+			return 0;
+		}
+
+		cnt++;
+	}
+
+	for (i = 0; i < cnt; i++)
+		close(fd[i]);
+
+	return cnt;
+}
+
+static int detect_ioctl(void)
+{
+	struct perf_event_attr attr;
+	int fd, ret = 1;
+
+	fd = wp_event((void *) &the_var, &attr);
+	if (fd > 0) {
+		ret = ioctl(fd, PERF_EVENT_IOC_MODIFY_ATTRIBUTES, &attr);
+		close(fd);
+	}
+
+	return ret ? 0 : 1;
+}
+
+static int detect_share(int wp_cnt, int bp_cnt)
+{
+	struct perf_event_attr attr;
+	int i, fd[wp_cnt + bp_cnt], ret;
+
+	for (i = 0; i < wp_cnt; i++) {
+		fd[i] = wp_event((void *)&the_var, &attr);
+		TEST_ASSERT_VAL("failed to create wp\n", fd[i] != -1);
+	}
+
+	for (; i < (bp_cnt + wp_cnt); i++) {
+		fd[i] = bp_event((void *)test_function, &attr);
+		if (fd[i] == -1)
+			break;
+	}
+
+	ret = i != (bp_cnt + wp_cnt);
+
+	while (i--)
+		close(fd[i]);
+
+	return ret;
+}
+
+/*
+ * This test does following:
+ *   - detects the number of watch/break-points,
+ *     skip test if any is missing
+ *   - detects PERF_EVENT_IOC_MODIFY_ATTRIBUTES ioctl,
+ *     skip test if it's missing
+ *   - detects if watchpoints and breakpoints share
+ *     same slots
+ *   - create all possible watchpoints on cpu 0
+ *   - change one of it to breakpoint
+ *   - in case wp and bp do not share slots,
+ *     we create another watchpoint to ensure
+ *     the slot accounting is correct
+ */
+int test__bp_accounting(struct test *test __maybe_unused, int subtest __maybe_unused)
+{
+	int has_ioctl = detect_ioctl();
+	int wp_cnt = detect_cnt(false);
+	int bp_cnt = detect_cnt(true);
+	int share  = detect_share(wp_cnt, bp_cnt);
+
+	pr_debug("watchpoints count %d, breakpoints count %d, has_ioctl %d, share %d\n",
+		 wp_cnt, bp_cnt, has_ioctl, share);
+
+	if (!wp_cnt || !bp_cnt || !has_ioctl)
+		return TEST_SKIP;
+
+	return bp_accounting(wp_cnt, share);
+}
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index fafa014240cd..38bf109ce106 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -115,6 +115,10 @@ static struct test generic_tests[] = {
 		.func = test__bp_signal_overflow,
 		.is_supported = test__bp_signal_is_supported,
 	},
+	{
+		.desc = "Breakpoint accounting",
+		.func = test__bp_accounting,
+	},
 	{
 		.desc = "Number of exit events of a simple workload",
 		.func = test__task_exit,
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 2862b80bc288..9f51edac44ae 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -58,6 +58,7 @@ int test__hists_link(struct test *test, int subtest);
 int test__python_use(struct test *test, int subtest);
 int test__bp_signal(struct test *test, int subtest);
 int test__bp_signal_overflow(struct test *test, int subtest);
+int test__bp_accounting(struct test *test, int subtest);
 int test__task_exit(struct test *test, int subtest);
 int test__mem(struct test *test, int subtest);
 int test__sw_clock_freq(struct test *test, int subtest);
