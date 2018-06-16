Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B5FC5CFC1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 03:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C8B2088E
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 03:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96C8B2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756910AbeFPDIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 23:08:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:51110 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756864AbeFPDIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 23:08:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 20:08:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,228,1526367600"; 
   d="scan'208";a="233011933"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga005.jf.intel.com with ESMTP; 15 Jun 2018 20:07:29 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>
Cc:     "Ashok Raj" <ashok.raj@intel.com>,
        "Alan Cox" <alan@linux.intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [RFC PATCH 8/8] selftests/x86: Self test for the APIs in lib_direct_store.h and lib_user_wait.h
Date:   Fri, 15 Jun 2018 20:06:15 -0700
Message-Id: <1529118375-90191-9-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1529118375-90191-1-git-send-email-fenghua.yu@intel.com>
References: <1529118375-90191-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The self test checks APIs defined in arch/x86/include/uapi/asm/
lib_direct_store.h and arch/x86/include/uapi/asm/lib_user_wait.h

Limited by testing environment, this test suit only tests simple cases.
More test cases may be added later.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/x86/Makefile             |   5 +-
 tools/testing/selftests/x86/directstore_umwait.c | 202 +++++++++++++++++++++++
 2 files changed, 205 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/x86/directstore_umwait.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 186520198de7..36cf86f3eeae 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -12,7 +12,8 @@ CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh $(CC) trivial_program.c -no-pie)
 
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
 			check_initial_reg_state sigreturn iopl mpx-mini-test ioperm \
-			protection_keys test_vdso test_vsyscall mov_ss_trap
+			protection_keys test_vdso test_vsyscall mov_ss_trap \
+			directstore_umwait
 TARGETS_C_32BIT_ONLY := entry_from_vm86 syscall_arg_fault test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
@@ -73,7 +74,7 @@ $(BINARIES_32): $(OUTPUT)/%_32: %.c
 	$(CC) -m32 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl -lm
 
 $(BINARIES_64): $(OUTPUT)/%_64: %.c
-	$(CC) -m64 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl
+	$(CC) -m64 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl -lm
 
 # x86_64 users should be encouraged to install 32-bit libraries
 ifeq ($(CAN_BUILD_I386)$(CAN_BUILD_X86_64),01)
diff --git a/tools/testing/selftests/x86/directstore_umwait.c b/tools/testing/selftests/x86/directstore_umwait.c
new file mode 100644
index 000000000000..d1bb1293d2ad
--- /dev/null
+++ b/tools/testing/selftests/x86/directstore_umwait.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * directstore_umwait.c - Test APIs defined in lib_direct_store.h and
+ * lib_user_wait.h
+ *
+ * Copyright (c) 2018 Intel Corporation
+ * Fenghua Yu <fenghua.yu@intel.com>
+ */
+#define _GNU_SOURCE
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <time.h>
+#include <unistd.h>
+#include <string.h>
+#include <asm/lib_direct_store.h>
+#include <asm/lib_user_wait.h>
+
+void test_movdiri_32_bit(void)
+{
+	int __attribute((aligned(64))) dst[10];
+	int __attribute((aligned(64))) data;
+
+	if (!movdiri_supported()) {
+		printf("movdiri is not supported\n");
+
+		return;
+	}
+	dst[0] = 0;
+	data = 0x12345670;
+
+	movdiri32(dst, data);
+
+	if (dst[0] == data)
+		printf("movdiri 32-bit test passed\n");
+	else
+		printf("movdiri 32-bit test failed\n");
+}
+
+void test_movdiri_64_bit(void)
+{
+	long __attribute((aligned(64))) dst[10];
+	long __attribute((aligned(64))) data;
+
+	if (!movdiri_supported()) {
+		printf("movdiri is not supported\n");
+
+		return;
+	}
+	dst[0] = 0;
+	data = 0x123456789abcdef0;
+
+	movdiri64(dst, data);
+
+	if (dst[0] == data)
+		printf("movdiri 64-bit test passed\n");
+	else
+		printf("movdiri 64-bit test failed\n");
+}
+
+void test_movdiri(void)
+{
+	test_movdiri_32_bit();
+	test_movdiri_64_bit();
+}
+
+void test_movdir64b(void)
+{
+	char __attribute((aligned(64))) src[1024], dst[1024];
+
+	if (!movdir64b_supported()) {
+		printf("movdir64b is not supported\n");
+
+		return;
+	}
+	memset(src, 0, 1024);
+	memset(dst, 0, 1024);
+	for (int i = 0; i < 1024; i++)
+		dst[i] = i;
+
+	movdir64b(src, dst);
+	if (memcmp(src, dst, 64))
+		printf("movdir64b test failed\n");
+	else
+		printf("movdir64b test passed\n");
+}
+
+void test_timeout(char *test_name, int state, unsigned long timeout_ns,
+		  unsigned long overhead_ns)
+{
+	unsigned long tsc1, tsc2, real_tsc, real_ns, tsc_per_nsec;
+	int ret;
+
+	ret = nsec_to_tsc(1, &tsc_per_nsec);
+	if (ret) {
+		printf("umwait test failed: nsec cannot be coverted to tsc.\n");
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
+			printf("%s test passed\n", test_name);
+		} else {
+			printf("%s test failed:\n", test_name);
+			printf("real=%luns, expected=%luns. ",
+			       real_ns, timeout_ns);
+			printf("Likely due to slow machine. ");
+			printf("Please adjust overhead_ns or re-run test for a few more times.\n");
+		}
+	} else {
+		printf("%s is not supported\n", test_name);
+	}
+}
+
+void test_tpause_timeout(int state)
+{
+	/*
+	 * Timeout 100usec. Assume overhead of executing umwait is 10usec.
+	 * You can adjust the overhead number based on your machine.
+	 */
+	test_timeout("tpause", state, 100000, 10000);
+}
+
+void test_tpause(void)
+{
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
+	if (waitpkg_supported()) {
+		umonitor(umonitor_range);
+		printf("umonitor test passed\n");
+	} else {
+		printf("waitpkg not supported\n");
+	}
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
+void test_umonitor(void)
+{
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
+void test_umwait(void)
+{
+	/* Test timeout in state 0 (C0.2). */
+	test_umwait_timeout(0);
+	/* Test timeout in state 1 (C0.1). */
+	test_umwait_timeout(1);
+	/* More tests ... */
+}
+
+int main(void)
+{
+	show_basic_info();
+	test_movdiri();
+	test_movdir64b();
+	test_tpause();
+	test_umonitor();
+	test_umwait();
+
+	return 0;
+}
-- 
2.5.0

