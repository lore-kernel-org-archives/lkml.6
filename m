Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA55ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7436420779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7436420779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388484AbeGWP3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:29:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:43708 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388414AbeGWP3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:29:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2018 07:27:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,393,1526367600"; 
   d="scan'208";a="242560365"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga005.jf.intel.com with ESMTP; 23 Jul 2018 07:27:37 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>
Cc:     "Ashok Raj" <ashok.raj@intel.com>,
        "Alan Cox" <alan@linux.intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 7/7] selftests/vDSO: Add selftest to test vDSO functions for direct store and user wait instructions
Date:   Mon, 23 Jul 2018 05:55:57 -0700
Message-Id: <1532350557-98388-8-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1532350557-98388-1-git-send-email-fenghua.yu@intel.com>
References: <1532350557-98388-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The selftest tool tests the vDSO functions for calling the instructions
including movdiri32, movdiri64, movdir64b, umonitor, umwait, tpause,
and their support checking.

Limited by testing environment, the selftest doesn't contain some
complex tests e.g. wake up process by writing the monitor address.
After testing environment is ready, the tests will be added.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/vDSO/Makefile             |   4 +-
 tools/testing/selftests/vDSO/vdso_inst_test_x86.c | 405 ++++++++++++++++++++++
 2 files changed, 408 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/vDSO/vdso_inst_test_x86.c

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index f5d7a7851e21..d83228714fbd 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -8,7 +8,7 @@ ifeq ($(CONFIG_X86_32),y)
 LDLIBS += -lgcc_s
 endif
 
-TEST_PROGS := $(OUTPUT)/vdso_test $(OUTPUT)/vdso_standalone_test_x86
+TEST_PROGS := $(OUTPUT)/vdso_test $(OUTPUT)/vdso_standalone_test_x86 $(OUTPUT)/vdso_inst_test_x86
 
 all: $(TEST_PROGS)
 $(OUTPUT)/vdso_test: parse_vdso.c vdso_test.c
@@ -17,5 +17,7 @@ $(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c
 		vdso_standalone_test_x86.c parse_vdso.c \
 		-o $@
 
+$(OUTPUT)/vdso_inst_test_x86: parse_vdso.c vdso_inst_test_x86.c
+
 EXTRA_CLEAN := $(TEST_PROGS)
 endif
diff --git a/tools/testing/selftests/vDSO/vdso_inst_test_x86.c b/tools/testing/selftests/vDSO/vdso_inst_test_x86.c
new file mode 100644
index 000000000000..157afa7d56a1
--- /dev/null
+++ b/tools/testing/selftests/vDSO/vdso_inst_test_x86.c
@@ -0,0 +1,405 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test vDSO APIs for direct store and user wait instructions
+ *
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Author: Fenghua Yu <fenghua.yu@intel.com>
+ */
+#include <stdint.h>
+#include <elf.h>
+#include <stdio.h>
+#include <sys/auxv.h>
+#include <sys/time.h>
+#include <stdbool.h>
+#include <string.h>
+#include <stdlib.h>
+
+extern void *vdso_sym(const char *version, const char *name);
+extern void vdso_init_from_sysinfo_ehdr(uintptr_t base);
+extern void vdso_init_from_auxv(void *auxv);
+
+const char *kernel_version = "LINUX_2.6";
+
+/*
+ * If the given instruction group is supported.
+ *   @vdso_name: vdso function name
+ *   @inst_name: instruction group name
+ *
+ * Return:
+ *   True: the instruction group is supported
+ *   False: the instruction group is not supported
+ */
+bool inst_supported(char *vdso_name, char *inst_name)
+{
+	typedef int (*inst_supported_t)(void);
+	int ret;
+
+	inst_supported_t inst_supported = (inst_supported_t)
+					  vdso_sym(kernel_version, vdso_name);
+
+	if (!inst_supported) {
+		printf("Could not find %s\n", vdso_name);
+
+		return false;
+	}
+
+	return inst_supported();
+}
+
+void test_inst_support(char *vdso_name, char *inst_name)
+{
+	int ret;
+
+	ret = inst_supported(vdso_name, inst_name);
+	if (ret)
+		printf("%s supported\n", inst_name);
+	else
+		printf("%s not supported\n", inst_name);
+}
+
+void test_movdiri_support(void)
+{
+	test_inst_support("__vdso_movdiri_supported", "movdiri");
+}
+
+void test_movdir64b_support(void)
+{
+	test_inst_support("__vdso_movdir64b_supported", "movdir64b");
+}
+
+void test_waitpkg_support(void)
+{
+	test_inst_support("__vdso_waitpkg_supported", "waitpkg");
+}
+
+void test_insts_support(void)
+{
+	printf("==");
+	printf("features detection test:\n");
+	test_movdiri_support();
+	test_movdir64b_support();
+	test_waitpkg_support();
+}
+
+/* Test movdiri 32-bit API */
+void test_movdiri32(void)
+{
+	typedef void (*movdiri32_t)(int *, int);
+	char vdso_name[] = "__vdso_movdiri32", inst_name[] = "movdiri32";
+	int ret, data, dst __attribute((aligned(64)));
+
+	printf("==");
+
+	/* movdiri instructions should be supported */
+	ret = inst_supported("__vdso_movdiri_supported", "movdiri");
+	if (!ret) {
+		printf("movdiri not supported\n");
+
+		return;
+	}
+
+	/* movdiri32 API should exist */
+	movdiri32_t movdiri32 = (movdiri32_t)
+				vdso_sym(kernel_version, vdso_name);
+	if (!movdiri32) {
+		printf("Could not find %s\n", vdso_name);
+
+		return;
+	}
+
+	dst = 0;
+	data = 100;
+	/* Call movdiri32 API to move 100 to dst */
+	movdiri32(&dst, data);
+	if (dst == data)
+		printf("%s passes\n", inst_name);
+	else
+		printf("%s fails\n", inst_name);
+}
+
+/* Test movdiri 64-bit API */
+void test_movdiri64(void)
+{
+	typedef void (*movdiri64_t)(long *, long);
+	char vdso_name[] = "__vdso_movdiri64", inst_name[] = "movdiri64";
+	long dst __attribute((aligned(64))), data __attribute((aligned(64)));
+
+	printf("==");
+
+	/* movdiri instructions should be supported */
+	if (!inst_supported("__vdso_movdiri_supported", "movdiri")) {
+		printf("movdiri is not supported\n");
+
+		return;
+	}
+
+	/* movdiri64 API should exist */
+	movdiri64_t movdiri64 = (movdiri64_t)
+				vdso_sym(kernel_version, vdso_name);
+	if (!movdiri64) {
+		printf("Could not find %s\n", vdso_name);
+
+		return;
+	}
+
+	dst = 0;
+	data = 0x123456789abcdef0;
+
+	/* Call movdiri64 API to move 64-bit data to dst */
+	movdiri64(&dst, data);
+
+	if (dst == data)
+		printf("movdiri 64-bit test passed\n");
+	else
+		printf("movdiri 64-bit test failed\n");
+}
+
+void test_movdir64b(void)
+{
+	typedef void (*movdir64b_t)(void *, void *);
+	char __attribute((aligned(64))) dst[1024];
+	char vdso_name[] = "__vdso_movdir64b";
+	char inst_name[] = "movdir64b";
+	int  data_size = 64;
+	char src[1024];
+
+	printf("==");
+
+	/* movdiri instructions should be supported */
+	if (!inst_supported("__vdso_movdir64b_supported", "movdir64b")) {
+		printf("movdir64b is not supported\n");
+
+		return;
+	}
+
+	/* movdir64b API should exist */
+	movdir64b_t movdir64b = (movdir64b_t)
+				vdso_sym(kernel_version, vdso_name);
+	if (!movdir64b) {
+		printf("Could not find %s\n", vdso_name);
+
+		return;
+	}
+
+	memset(src, 0, data_size);
+	memset(dst, 0, data_size);
+	for (int i = 0; i < data_size; i++)
+		dst[i] = i;
+
+	/* Call movdir64b API to move 64 bytes data from src to dst */
+	movdir64b(src, dst);
+
+	if (memcmp(src, dst, data_size))
+		printf("movdir64b test failed\n");
+	else
+		printf("movdir64b test passed\n");
+}
+
+bool waitpkg_supported(void)
+{
+	return inst_supported("__vdso_waitpkg_supported", "waitpkg_supported");
+}
+
+bool nsec_to_tsc(unsigned long nsec, unsigned long *tsc)
+{
+	typedef int (*nsec_to_tsc_t)(unsigned long, unsigned long *);
+	char vdso_name[] = "__vdso_nsec_to_tsc";
+	int ret;
+
+	/* nsec_to_tsc API should exist */
+	nsec_to_tsc_t nsec_to_tsc = (nsec_to_tsc_t)
+			    vdso_sym(kernel_version, "__vdso_nsec_to_tsc");
+	if (!nsec_to_tsc) {
+		printf("Could not find __vdso_nsec_to_tsc\n");
+
+		return false;
+	}
+
+	/* Call nsec_to_tsc API to convert nsec to tsc */
+	ret = nsec_to_tsc(nsec, tsc);
+	if (ret)
+		return false;
+
+	return true;
+}
+
+static unsigned long rdtsc(void)
+{
+	unsigned int low, high;
+
+	asm volatile ("rdtsc\t\n"
+		      : "=a" (low), "=d" (high));
+
+	return (unsigned long)high << 32 | low;
+}
+
+void test_timeout(char *test_name, int state, unsigned long timeout_ns,
+		  unsigned long overhead_ns)
+{
+	typedef int (*umwait_t)(int state, unsigned long nsec);
+	typedef int (*tpause_t)(int state, unsigned long nsec);
+	unsigned long tsc1, tsc2, real_tsc, real_ns, tsc_per_nsec;
+	tpause_t tpause;
+	umwait_t umwait;
+
+	if (!nsec_to_tsc(1, &tsc_per_nsec)) {
+		printf("timeout test failed: ns cannot be converted to tsc.\n");
+		return;
+	}
+
+	/* tpause API should exist */
+	tpause = (tpause_t)vdso_sym(kernel_version, "__vdso_tpause");
+	if (!tpause) {
+		printf("Could not find tpause\n");
+
+		return;
+	}
+
+	/* umwait API should exist */
+	umwait = (umwait_t)vdso_sym(kernel_version, "__vdso_umwait");
+	if (!umwait) {
+		printf("Could not find umwait\n");
+
+		return;
+	}
+
+	umwait = (umwait_t)vdso_sym(kernel_version, "umwait");
+	if (!umwait) {
+		printf("Could not find umwait\n");
+
+		return;
+	}
+
+	if (waitpkg_supported()) {
+		if (!strcmp(test_name, "umwait")) {
+			tsc1 = rdtsc();
+			umwait(state, timeout_ns);
+			tsc2 = rdtsc();
+		} else {
+			tsc1 = rdtsc();
+			tpause(state, timeout_ns);
+			tsc2 = rdtsc();
+		}
+		real_tsc = tsc2 - tsc1;
+		real_ns = real_tsc / tsc_per_nsec;
+		/* Give enough time for overhead on slow running machine. */
+		if (abs(real_ns - timeout_ns) < overhead_ns) {
+			printf("%s C0.%1d test passed\n", test_name, state + 1);
+		} else {
+			printf("%s test failed:\n", test_name);
+			printf("real=%luns, expected=%luns. ",
+			       real_ns, timeout_ns);
+			printf("Likely due to slow machine. ");
+			printf("Please adjust overhead_ns or re-run test for ");
+			printf("a few more times.\n");
+		}
+	} else {
+		printf("%s is not supported\n", test_name);
+	}
+}
+
+void test_tpause_timeout(int state)
+{
+	/*
+	 * Timeout 100usec. Assume overhead of executing umwait is 30usec.
+	 * You can adjust the overhead number based on your machine.
+	 */
+	test_timeout("tpause", state, 100000, 30000);
+}
+
+/* Test tpause API */
+void test_tpause(void)
+{
+	printf("==");
+	/* Test timeout in state 0 (C0.2). */
+	test_tpause_timeout(0);
+	/* Test timeout in state 1 (C0.1). */
+	test_tpause_timeout(1);
+	/* More tests ... */
+}
+
+char umonitor_range[1024];
+
+void test_umonitor_only(void)
+{
+	typedef void (*umonitor_t)(void *addr);
+
+	/* umonitor API should exist */
+	umonitor_t umonitor = (umonitor_t)
+			      vdso_sym(kernel_version, "__vdso_umonitor");
+	if (!umonitor) {
+		printf("Could not find umonitor\n");
+
+		return;
+	}
+
+	if (waitpkg_supported()) {
+		umonitor(umonitor_range);
+		printf("umonitor test passed\n");
+	} else {
+		printf("waitpkg not supported\n");
+	}
+}
+
+/* Test umonitor API */
+void test_umonitor(void)
+{
+	printf("==");
+	test_umonitor_only();
+}
+
+void test_umwait_timeout(int state)
+{
+	/*
+	 * Timeout 100usec. Overhead of executing umwait assumes 90usec.
+	 * You can adjust the overhead number based on your machine.
+	 */
+	test_timeout("umwait", state, 100000, 90000);
+}
+
+/* Test umwait API */
+void test_umwait(void)
+{
+	printf("==");
+	/* Test timeout in state 0 (C0.2). */
+	test_umwait_timeout(0);
+	/* Test timeout in state 1 (C0.1). */
+	test_umwait_timeout(1);
+	/* To add more tests here ... */
+}
+
+void show_basic_info(void)
+{
+	unsigned long tsc;
+	int ret;
+
+	ret = nsec_to_tsc(1, &tsc);
+	if (ret < 0)
+		printf("not tsc freq CPUID available\n");
+	else
+		printf("1 nsec = %lu tsc\n", tsc);
+}
+
+int main(int argc, char **argv)
+{
+	unsigned long sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);
+
+	if (!sysinfo_ehdr) {
+		printf("AT_SYSINFO_EHDR is not present!\n");
+		return 0;
+	}
+
+	vdso_init_from_sysinfo_ehdr(getauxval(AT_SYSINFO_EHDR));
+
+	show_basic_info();
+	test_insts_support();
+	test_movdiri32();
+	test_movdiri64();
+	test_movdir64b();
+	test_umonitor();
+	test_umwait();
+	test_tpause();
+
+	return 0;
+}
-- 
2.5.0

