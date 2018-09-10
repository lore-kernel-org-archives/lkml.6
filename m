Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456E8C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E4720870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E4720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbeIJOvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:51:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46752 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726738AbeIJOvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:51:55 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8A9pDRC049655
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 05:58:39 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mdky9ep7k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 05:58:39 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 10 Sep 2018 10:58:36 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 10 Sep 2018 10:58:33 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8A9wVQ6262452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Sep 2018 09:58:31 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 906F711C04C;
        Mon, 10 Sep 2018 12:58:21 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42D1911C04A;
        Mon, 10 Sep 2018 12:58:18 +0100 (BST)
Received: from bangoria.ibmuc.com (unknown [9.199.35.17])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 10 Sep 2018 12:58:17 +0100 (BST)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     acme@kernel.org, jolsa@redhat.com
Cc:     alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        tmricht@linux.ibm.com, sandipan@linux.ibm.com,
        brueckner@linux.ibm.com, kim.phillips@arm.com,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        naveen.n.rao@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH] perf test: Add watchpoint test
Date:   Mon, 10 Sep 2018 15:28:11 +0530
X-Mailer: git-send-email 2.14.4
X-TM-AS-GCONF: 00
x-cbid: 18091009-0028-0000-0000-000002F71109
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091009-0029-0000-0000-000023B0A60B
Message-Id: <20180910095811.22892-1-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-10_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809100105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't have perf test available to test watchpoint functionality.
Add simple set of tests: 
 - Read only watchpoint
 - Write only watchpoint
 - Read / Write watchpoint
 - Runtime watchpoint modification

Ex on powerpc:
  $ sudo ./perf test 22
  22: Watchpoint                                            :
  22.1: Read Only Watchpoint                                : Ok
  22.2: Write Only Watchpoint                               : Ok
  22.3: Read / Write Watchpoint                             : Ok
  22.4: Modify Watchpoint                                   : Ok

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/tests/Build          |   1 +
 tools/perf/tests/builtin-test.c |   9 ++
 tools/perf/tests/tests.h        |   3 +
 tools/perf/tests/wp.c           | 225 ++++++++++++++++++++++++++++++++
 4 files changed, 238 insertions(+)
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
index 000000000000..f9f6d9ee5172
--- /dev/null
+++ b/tools/perf/tests/wp.c
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/ioctl.h>
+#include <linux/hw_breakpoint.h>
+#include "tests/tests.h"
+#include "arch-tests.h"
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
+static struct {
+	const char *desc;
+	int (*target_func)(void);
+	bool (*is_supported)(void);
+} wp_testcase_table[] = {
+	{
+		.desc = "Read Only Watchpoint",
+		.target_func = &wp_ro_test,
+		.is_supported = &wp_ro_supported,
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
+/*
+ * Test
+ * - Read only watchpoint
+ * - Write only watchpoint
+ * - Read / Write watchpoint
+ * - Watchpoint modification
+ */
+int test__wp(struct test *test __maybe_unused, int i)
+{
+	if (i < 0 || i >= (int)ARRAY_SIZE(wp_testcase_table))
+		return TEST_FAIL;
+
+	if (wp_testcase_table[i].is_supported &&
+	    !wp_testcase_table[i].is_supported())
+		return TEST_SKIP;
+
+	return !wp_testcase_table[i].target_func() ? TEST_OK : TEST_FAIL;
+}
-- 
2.17.1


