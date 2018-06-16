Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073F8C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 03:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E3C2088E
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 03:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E3C2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756921AbeFPDIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 23:08:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:51107 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756860AbeFPDIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 23:08:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 20:08:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,228,1526367600"; 
   d="scan'208";a="233011930"
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
Subject: [RFC PATCH 7/8] x86/lib_user_wait.h: Add APIs for user wait instructions
Date:   Fri, 15 Jun 2018 20:06:14 -0700
Message-Id: <1529118375-90191-8-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1529118375-90191-1-git-send-email-fenghua.yu@intel.com>
References: <1529118375-90191-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few new user wait instructions UMONITOR, UMWAIT, and TPAUSE are
published in the latest Intel Instruction Set Extensions document.

Define the APIs for user or kernel to use the instructions.

If feature enabled GCC is available in the future, implementation
of the APIs will be changed to call the intrinsic instructions.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/include/uapi/asm/lib_user_wait.h | 255 ++++++++++++++++++++++++++++++
 1 file changed, 255 insertions(+)
 create mode 100644 arch/x86/include/uapi/asm/lib_user_wait.h

diff --git a/arch/x86/include/uapi/asm/lib_user_wait.h b/arch/x86/include/uapi/asm/lib_user_wait.h
new file mode 100644
index 000000000000..027d45c1e383
--- /dev/null
+++ b/arch/x86/include/uapi/asm/lib_user_wait.h
@@ -0,0 +1,255 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This library provides a set of APIs for user or kernel to use
+ * some new user wait instructions:
+ * - tpause, umonitor, and umwait
+ *
+ * Detailed information on the instructions can be found in
+ * Intel Architecture Instruction Set Extensions and Future Features
+ * Programming Reference.
+ */
+
+#ifndef _ASM_X86_LIB_USER_WAIT_H
+#define _ASM_X86_LIB_USER_WAIT_H
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <math.h>
+
+/* CPUID.07H.0H:ECX[5] */
+#define WAITPKG_BIT		5
+
+static bool _waitpkg_supported, _waitpkg_enumerated;
+static unsigned long tsc_khz;
+
+/**
+ * waitpkg_supported() - Is CPU flag waitpkg supported?
+ *
+ * Return:
+ * true: supported
+ *
+ * false: not supported
+ */
+static inline int waitpkg_supported(void)
+{
+	int eax, ebx, ecx, edx, ret;
+
+	/*
+	 * If waitpkg has been enumerated before, return cached waitpkg
+	 * support info.
+	 */
+	if (_waitpkg_enumerated)
+		return _waitpkg_supported;
+
+	/* Otherwise, enumerate the feature from CPUID. */
+	asm volatile("mov $7, %%eax\t\n"
+		     "mov $0, %%ecx\t\n"
+		     "cpuid\t\n"
+		     : "=a"(eax), "=b" (ebx), "=c" (ecx), "=d" (edx));
+
+	if (ecx & (1 << WAITPKG_BIT))
+		ret = true;
+	else
+		ret = false;
+
+	/* Cache waitpkg support for future use. */
+	_waitpkg_enumerated = true;
+	_waitpkg_supported = true;
+
+	return ret;
+}
+
+static inline int get_tsc_khz(unsigned long *tsc_khz_val)
+{
+	int fd, ret = 0;
+	char buf[32];
+
+	if (tsc_khz != 0) {
+		*tsc_khz_val = tsc_khz;
+		return 0;
+	}
+
+	fd = open("/sys/devices/system/cpu/user_wait/tsc_khz", O_RDONLY);
+	if (!fd)
+		return -1;
+	ret = read(fd, buf, 32);
+	if (ret < 0)
+		goto out;
+
+	tsc_khz = atol(buf);
+	*tsc_khz_val = tsc_khz;
+printf("tsc_khz=%ld\n", tsc_khz);
+
+out:
+	close(fd);
+	return ret;
+}
+
+#define	USEC_PER_SEC	1000000
+
+static inline int nsec_to_tsc(unsigned long nsec, unsigned long *tsc)
+{
+	int ret;
+
+	/* Get tsc frequency in HZ */
+	ret = get_tsc_khz(&tsc_khz);
+	if (ret < 0)
+		return ret;
+
+	*tsc = (unsigned long)round((double)tsc_khz * nsec / USEC_PER_SEC);
+
+	return 0;
+}
+
+/**
+ * umonitor() - Set up monitoring address
+ * @addr: Monitored address
+ *
+ * This API sets up address monitoring hardware using address @addr.
+ * It can be executed at any privilege level.
+ */
+static inline void umonitor(void *addr)
+{
+	asm volatile("mov %0, %%rdi\t\n"
+		     ".byte 0xf3, 0x0f, 0xae, 0xf7\t\n"
+		     : : "r" (addr));
+}
+
+static inline int _umwait(int state, unsigned long eax, unsigned long edx)
+{
+	unsigned long cflags;
+
+	asm volatile("mov %3, %%edi\t\n"
+		     ".byte 0xf2, 0x0f, 0xae, 0xf7\t\n"
+		     "pushf\t\n"
+		     "pop %0\t\n"
+		     : "=r" (cflags)
+		     : "d" (edx), "a" (eax), "r"(state));
+
+	/*
+	 * If the processor wakes due to expiration of OS time-limit, the CF
+	 * flag is set. Otherwise, the flag is cleared.
+	 */
+	return cflags & 1;
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
+/**
+ * umwait() - Monitor wait
+ * @state: State
+ * @nsec: Time out in nano seconds
+ *
+ * A hint that allows the processor to stop instruction execution and
+ * enter an implementation-dependent optimized state. The processor
+ * wakes up because of events such as store to the monitored address,
+ * timeout, NMI, SMI, machine check, debug exception, etc.
+ *
+ * State 0 is light-weight power optimized state. It allows the processor
+ * to enter C0.2 state which has larger power saving but slower wakeup time.
+ *
+ * State 1 is performance optimized state. It allows the processor
+ * to enter C0.1 state which has smaller power saving but faster wakeup time.
+ *
+ * This function can be executed at any privilege level.
+ *
+ * Return:
+ * 1: the processor wakes due to expiration of OS time-limit
+ *
+ * 0: the processor wakes due to other reasons
+ *
+ * less than 0: error
+ */
+static inline int umwait(int state, unsigned long nsec)
+{
+	unsigned long tsc;
+	int ret;
+
+	if (state != 0 && state != 1)
+		return -1;
+
+	ret = nsec_to_tsc(nsec, &tsc);
+	if (ret)
+		return ret;
+
+	/* Get umwait deadline */
+	tsc += rdtsc();
+	ret = _umwait(state, tsc & 0xffffffff, tsc >> 32);
+
+	return ret;
+}
+
+static inline int _tpause(int state, unsigned long eax, unsigned long edx)
+{
+	unsigned long cflags;
+
+	asm volatile("mov %3, %%edi\t\n"
+		     ".byte 0x66, 0x0f, 0xae, 0xf7\t\n"
+		     "pushf\t\n"
+		     "pop %0\t\n"
+		     : "=r" (cflags)
+		     : "d" (edx), "a" (eax), "r"(state));
+
+	/*
+	 * If the processor wakes due to expiration of OS time-limit, the CF
+	 * flag is set. Otherwise, the flag is cleared.
+	 */
+	return cflags & 1;
+}
+
+/**
+ * tpause() - Timed pause
+ * @state: State
+ * @nsec: Timeout in nano seconds
+ *
+ * tpause() allows the processor to stop instruction execution and
+ * enter an implementation-dependent optimized state. The processor
+ * wakes up because of events such as store to the monitored
+ * address, timeout, NMI, SMI, machine check, debug exception, etc.
+ *
+ * State 0 is light-weight power optimized state. It allows the processor
+ * to enter C0.2 state which has larger power saving but slower wakeup time.
+ *
+ * State 1 is performance optimized state. It allows the processor
+ * to enter C0.1 state which has smaller power saving but faster wakeup time.
+ *
+ * This function can be executed at any privilege level.
+ *
+ * Return:
+ * 1: the processor wakes due to expiration of OS time-limit
+ *
+ * 0: the processor wakes due to other reasons
+ *
+ * less than 0: error
+ */
+static inline int tpause(int state, unsigned long nsec)
+{
+	unsigned long tsc;
+	int ret;
+
+	if (state != 0 && state != 1)
+		return -1;
+
+	ret = nsec_to_tsc(nsec, &tsc);
+	if (ret)
+		return ret;
+
+	/* Get tpause deadline */
+	tsc += rdtsc();
+	ret = _tpause(state, tsc & 0xffffffff, tsc >> 32);
+
+	return ret;
+}
+
+#endif /* _ASM_X86_LIB_USER_WAIT_H */
-- 
2.5.0

