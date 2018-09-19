Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2656EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56F221524
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zTrSUEr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C56F221524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732179AbeISUEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:04:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730876AbeISUEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:04:07 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4423F2151B;
        Wed, 19 Sep 2018 14:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537367156;
        bh=rodeIOqRDhc6tJerGcgOIZJkqntuYb2WbR6fZXUeVWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zTrSUEr2rk8Lcj98WeTsEzHdBe2LTEB2eUIsj3Xz1m610NMNEZ2WLdbAKayDt8Qxj
         spUX4pOiFAKtK9USm9PKzuv4T8uPo995ADg6qSowDkB+ARPpHYYV2MEF4ZSweHdIny
         2r5djf1j7A7r88f0v0xHVdJlfY1UqhQYnivrDTzc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 02/13] perf test: Add watchpoint test
Date:   Wed, 19 Sep 2018 11:25:26 -0300
Message-Id: <20180919142537.29985-3-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180919142537.29985-1-acme@kernel.org>
References: <20180919142537.29985-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

We don't have a 'perf test' entry available to test the watchpoint
functionality.

Add a simple set of tests:

 - Read only watchpoint
 - Write only watchpoint
 - Read / Write watchpoint
 - Runtime watchpoint modification

Ex.: on powerpc:

  $ sudo perf test 22
  22: Watchpoint                                            :
  22.1: Read Only Watchpoint                                : Ok
  22.2: Write Only Watchpoint                               : Ok
  22.3: Read / Write Watchpoint                             : Ok
  22.4: Modify Watchpoint                                   : Ok

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Sandipan Das <sandipan@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Link: http://lkml.kernel.org/r/20180912061229.22832-1-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/Build          |   1 +
 tools/perf/tests/builtin-test.c |   9 ++
 tools/perf/tests/tests.h        |   3 +
 tools/perf/tests/wp.c           | 229 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 242 insertions(+)
 create mode 100644 tools/perf/tests/wp.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 6c108fa79ae3..0b2b8305c965 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -21,6 +21,7 @@ perf-y += python-use.o
 perf-y += bp_signal.o
 perf-y += bp_signal_overflow.o
 perf-y += bp_account.o
+perf-y += wp.o
 perf-y += task-exit.o
 perf-y += sw-clock.o
 perf-y += mmap-thread-lookup.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index d7a5e1b9aa6f..54ca7d87236f 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -120,6 +120,15 @@ static struct test generic_tests[] = {
 		.func = test__bp_accounting,
 		.is_supported = test__bp_signal_is_supported,
 	},
+	{
+		.desc = "Watchpoint",
+		.func = test__wp,
+		.subtest = {
+			.skip_if_fail	= false,
+			.get_nr		= test__wp_subtest_get_nr,
+			.get_desc	= test__wp_subtest_get_desc,
+		},
+	},
 	{
 		.desc = "Number of exit events of a simple workload",
 		.func = test__task_exit,
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index a9760e790563..8e26a4148f30 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -59,6 +59,9 @@ int test__python_use(struct test *test, int subtest);
 int test__bp_signal(struct test *test, int subtest);
 int test__bp_signal_overflow(struct test *test, int subtest);
 int test__bp_accounting(struct test *test, int subtest);
+int test__wp(struct test *test, int subtest);
+const char *test__wp_subtest_get_desc(int subtest);
+int test__wp_subtest_get_nr(void);
 int test__task_exit(struct test *test, int subtest);
 int test__mem(struct test *test, int subtest);
 int test__sw_clock_freq(struct test *test, int subtest);
diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
new file mode 100644
index 000000000000..017a99317f94
--- /dev/null
+++ b/tools/perf/tests/wp.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdlib.h>
+#include <sys/ioctl.h>
+#include <linux/hw_breakpoint.h>
+#include "tests.h"
+#include "debug.h"
+#include "cloexec.h"
+
+#define WP_TEST_ASSERT_VAL(fd, text, val)       \
+do {                                            \
+	long long count;                        \
+	wp_read(fd, &count, sizeof(long long)); \
+	TEST_ASSERT_VAL(text, count == val);    \
+} while (0)
+
+volatile u64 data1;
+volatile u8 data2[3];
+
+static int wp_read(int fd, long long *count, int size)
+{
+	int ret = read(fd, count, size);
+
+	if (ret != size) {
+		pr_debug("failed to read: %d\n", ret);
+		return -1;
+	}
+	return 0;
+}
+
+static void get__perf_event_attr(struct perf_event_attr *attr, int wp_type,
+				 void *wp_addr, unsigned long wp_len)
+{
+	memset(attr, 0, sizeof(struct perf_event_attr));
+	attr->type           = PERF_TYPE_BREAKPOINT;
+	attr->size           = sizeof(struct perf_event_attr);
+	attr->config         = 0;
+	attr->bp_type        = wp_type;
+	attr->bp_addr        = (unsigned long)wp_addr;
+	attr->bp_len         = wp_len;
+	attr->sample_period  = 1;
+	attr->sample_type    = PERF_SAMPLE_IP;
+	attr->exclude_kernel = 1;
+	attr->exclude_hv     = 1;
+}
+
+static int __event(int wp_type, void *wp_addr, unsigned long wp_len)
+{
+	int fd;
+	struct perf_event_attr attr;
+
+	get__perf_event_attr(&attr, wp_type, wp_addr, wp_len);
+	fd = sys_perf_event_open(&attr, 0, -1, -1,
+				 perf_event_open_cloexec_flag());
+	if (fd < 0)
+		pr_debug("failed opening event %x\n", attr.bp_type);
+
+	return fd;
+}
+
+static int wp_ro_test(void)
+{
+	int fd;
+	unsigned long tmp, tmp1 = rand();
+
+	fd = __event(HW_BREAKPOINT_R, (void *)&data1, sizeof(data1));
+	if (fd < 0)
+		return -1;
+
+	tmp = data1;
+	WP_TEST_ASSERT_VAL(fd, "RO watchpoint", 1);
+
+	data1 = tmp1 + tmp;
+	WP_TEST_ASSERT_VAL(fd, "RO watchpoint", 1);
+
+	close(fd);
+	return 0;
+}
+
+static int wp_wo_test(void)
+{
+	int fd;
+	unsigned long tmp, tmp1 = rand();
+
+	fd = __event(HW_BREAKPOINT_W, (void *)&data1, sizeof(data1));
+	if (fd < 0)
+		return -1;
+
+	tmp = data1;
+	WP_TEST_ASSERT_VAL(fd, "WO watchpoint", 0);
+
+	data1 = tmp1 + tmp;
+	WP_TEST_ASSERT_VAL(fd, "WO watchpoint", 1);
+
+	close(fd);
+	return 0;
+}
+
+static int wp_rw_test(void)
+{
+	int fd;
+	unsigned long tmp, tmp1 = rand();
+
+	fd = __event(HW_BREAKPOINT_R | HW_BREAKPOINT_W, (void *)&data1,
+		     sizeof(data1));
+	if (fd < 0)
+		return -1;
+
+	tmp = data1;
+	WP_TEST_ASSERT_VAL(fd, "RW watchpoint", 1);
+
+	data1 = tmp1 + tmp;
+	WP_TEST_ASSERT_VAL(fd, "RW watchpoint", 2);
+
+	close(fd);
+	return 0;
+}
+
+static int wp_modify_test(void)
+{
+	int fd, ret;
+	unsigned long tmp = rand();
+	struct perf_event_attr new_attr;
+
+	fd = __event(HW_BREAKPOINT_W, (void *)&data1, sizeof(data1));
+	if (fd < 0)
+		return -1;
+
+	data1 = tmp;
+	WP_TEST_ASSERT_VAL(fd, "Modify watchpoint", 1);
+
+	/* Modify watchpoint with disabled = 1 */
+	get__perf_event_attr(&new_attr, HW_BREAKPOINT_W, (void *)&data2[0],
+			     sizeof(u8) * 2);
+	new_attr.disabled = 1;
+	ret = ioctl(fd, PERF_EVENT_IOC_MODIFY_ATTRIBUTES, &new_attr);
+	if (ret < 0) {
+		pr_debug("ioctl(PERF_EVENT_IOC_MODIFY_ATTRIBUTES) failed\n");
+		close(fd);
+		return ret;
+	}
+
+	data2[1] = tmp; /* Not Counted */
+	WP_TEST_ASSERT_VAL(fd, "Modify watchpoint", 1);
+
+	/* Enable the event */
+	ioctl(fd, PERF_EVENT_IOC_ENABLE, 0);
+	if (ret < 0) {
+		pr_debug("Failed to enable event\n");
+		close(fd);
+		return ret;
+	}
+
+	data2[1] = tmp; /* Counted */
+	WP_TEST_ASSERT_VAL(fd, "Modify watchpoint", 2);
+
+	data2[2] = tmp; /* Not Counted */
+	WP_TEST_ASSERT_VAL(fd, "Modify watchpoint", 2);
+
+	close(fd);
+	return 0;
+}
+
+static bool wp_ro_supported(void)
+{
+#if defined (__x86_64__) || defined (__i386__)
+	return false;
+#else
+	return true;
+#endif
+}
+
+static void wp_ro_skip_msg(void)
+{
+#if defined (__x86_64__) || defined (__i386__)
+	pr_debug("Hardware does not support read only watchpoints.\n");
+#endif
+}
+
+static struct {
+	const char *desc;
+	int (*target_func)(void);
+	bool (*is_supported)(void);
+	void (*skip_msg)(void);
+} wp_testcase_table[] = {
+	{
+		.desc = "Read Only Watchpoint",
+		.target_func = &wp_ro_test,
+		.is_supported = &wp_ro_supported,
+		.skip_msg = &wp_ro_skip_msg,
+	},
+	{
+		.desc = "Write Only Watchpoint",
+		.target_func = &wp_wo_test,
+	},
+	{
+		.desc = "Read / Write Watchpoint",
+		.target_func = &wp_rw_test,
+	},
+	{
+		.desc = "Modify Watchpoint",
+		.target_func = &wp_modify_test,
+	},
+};
+
+int test__wp_subtest_get_nr(void)
+{
+	return (int)ARRAY_SIZE(wp_testcase_table);
+}
+
+const char *test__wp_subtest_get_desc(int i)
+{
+	if (i < 0 || i >= (int)ARRAY_SIZE(wp_testcase_table))
+		return NULL;
+	return wp_testcase_table[i].desc;
+}
+
+int test__wp(struct test *test __maybe_unused, int i)
+{
+	if (i < 0 || i >= (int)ARRAY_SIZE(wp_testcase_table))
+		return TEST_FAIL;
+
+	if (wp_testcase_table[i].is_supported &&
+	    !wp_testcase_table[i].is_supported()) {
+		wp_testcase_table[i].skip_msg();
+		return TEST_SKIP;
+	}
+
+	return !wp_testcase_table[i].target_func() ? TEST_OK : TEST_FAIL;
+}
-- 
2.14.4

