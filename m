Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8233ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677A020891
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677A020891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388474AbeGWP3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:29:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:43703 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388426AbeGWP3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:29:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2018 07:27:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,393,1526367600"; 
   d="scan'208";a="242560362"
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
Subject: [PATCH 6/7] x86/vdso: Add vDSO functions for user wait instructions
Date:   Mon, 23 Jul 2018 05:55:56 -0700
Message-Id: <1532350557-98388-7-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1532350557-98388-1-git-send-email-fenghua.yu@intel.com>
References: <1532350557-98388-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User wants to query if user wait instructions (umonitor, umwait, and
tpause) are supported and use the instructions. The vDSO functions
provides fast interface for user to check the support and use the
instructions.

waitpkg_supported and its alias __vdso_waitpkg_supported check if
user wait instructions (a.k.a. wait package feature) are supported

umonitor and its alias __vdso_umonitor provide user APIs for calling
umonitor instruction.

umwait and its alias __vdso_umwait provide user APIs for calling
umwait instruction.

tpause and its alias __vdso_tpause provide user APIs for calling
tpause instruction.

nsec_to_tsc and its alias __vdso_nsec_to_tsc converts nanoseconds
to TSC counter if TSC frequency is known. It will fail if TSC frequency
is unknown.

The instructions can be implemented in intrinsic functions in future
GCC. But the vDSO interfaces are available to user without the
intrinsic functions support in GCC and the API waitpkg_supported and
nsec_to_tsc cannot be implemented as GCC functions.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/entry/vdso/Makefile           |   2 +-
 arch/x86/entry/vdso/vdso.lds.S         |  10 ++
 arch/x86/entry/vdso/vma.c              |   9 ++
 arch/x86/entry/vdso/vuserwait.c        | 233 +++++++++++++++++++++++++++++++++
 arch/x86/include/asm/vdso_funcs_data.h |   3 +
 5 files changed, 256 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/entry/vdso/vuserwait.c

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index af4fcae5de83..fb0062b09b3c 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -17,7 +17,7 @@ VDSO32-$(CONFIG_X86_32)		:= y
 VDSO32-$(CONFIG_IA32_EMULATION)	:= y
 
 # files to link into the vdso
-vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o vdirectstore.o
+vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o vdirectstore.o vuserwait.o
 
 # files to link into kernel
 obj-y				+= vma.o
diff --git a/arch/x86/entry/vdso/vdso.lds.S b/arch/x86/entry/vdso/vdso.lds.S
index 097cdcda43a5..0942710608bf 100644
--- a/arch/x86/entry/vdso/vdso.lds.S
+++ b/arch/x86/entry/vdso/vdso.lds.S
@@ -35,6 +35,16 @@ VERSION {
 		__vdso_movdir64b_supported;
 		movdir64b;
 		__vdso_movdir64b;
+		waitpkg_supported;
+		__vdso_waitpkg_supported;
+		umonitor;
+		__vdso_umonitor;
+		umwait;
+		__vdso_umwait;
+		tpause;
+		__vdso_tpause;
+		nsec_to_tsc;
+		__vdso_nsec_to_tsc;
 	local: *;
 	};
 }
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index edbe5e63e5c2..006dfb5e5003 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -372,10 +372,19 @@ static int vgetcpu_online(unsigned int cpu)
 
 static void __init init_vdso_funcs_data(void)
 {
+	struct system_counterval_t sys_counterval;
+
 	if (static_cpu_has(X86_FEATURE_MOVDIRI))
 		vdso_funcs_data.movdiri_supported = true;
 	if (static_cpu_has(X86_FEATURE_MOVDIR64B))
 		vdso_funcs_data.movdir64b_supported = true;
+	if (static_cpu_has(X86_FEATURE_WAITPKG))
+		vdso_funcs_data.waitpkg_supported = true;
+	if (static_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {
+		vdso_funcs_data.tsc_known_freq = true;
+		sys_counterval = convert_art_ns_to_tsc(1);
+		vdso_funcs_data.tsc_per_nsec = sys_counterval.cycles;
+	}
 }
 
 static int __init init_vdso(void)
diff --git a/arch/x86/entry/vdso/vuserwait.c b/arch/x86/entry/vdso/vuserwait.c
new file mode 100644
index 000000000000..17ff564aef7e
--- /dev/null
+++ b/arch/x86/entry/vdso/vuserwait.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * vDSO functions for user wait instructions
+ *
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Author: Fenghua Yu <fenghua.yu@intel.com>
+ */
+#include <linux/timer.h>
+#include <asm/vdso_funcs_data.h>
+
+notrace bool __vdso_waitpkg_supported(void)
+{
+	return _vdso_funcs_data->waitpkg_supported;
+}
+
+/**
+ * waitpkg_supported() - vDSO function for checking if user wait instructions
+ * are supported
+ *
+ * waitpkg instructions (a.k.a. user wait instructions) group has three
+ * instructions: umonitor, umwait, and tpause. This vDSO API tells user
+ * if the instructions group is supported on the machine.
+ *
+ * waitpkg_supported() and its alias __vdso_waitpkg_supported() are implemented
+ * as vDSO functions.
+ *
+ * Return:
+ * true: supported
+ *
+ * false: not supported
+ */
+bool waitpkge_supported(void)
+	__attribute__((weak, alias("__vdso_waitpkg_supported")));
+
+notrace int __vdso_nsec_to_tsc(unsigned long nsec, unsigned long *tsc)
+{
+	if (!_vdso_funcs_data->tsc_known_freq)
+		return -ENODEV;
+
+	*tsc = _vdso_funcs_data->tsc_per_nsec * nsec;
+
+	return 0;
+}
+
+/**
+ * nsec_to_tsc() - vDSO function for converting nanoseconds to TSC counter
+ * @nsec: nanoseconds
+ * @tsc: Returned TSC counter
+ *
+ * If TSC has known frequency (i.e. X86_FEATURE_TSC_KNOWN_FREQ is supported),
+ * convert nanoseconds to TSC counter.
+ *
+ * nsec_to_tsc() and its alias __vdso_nsec_to_tsc() are implemented
+ * as vDSO functions.
+ *
+ * Return:
+ * 0: Successful
+ *
+ * Less than zero: error code
+ */
+int nsec_to_tsc(unsigned long nsec, unsigned long *tsc)
+	__attribute__((weak, alias("__vdso_nsec_to_tsc")));
+
+notrace int __vdso_umonitor(void *addr)
+{
+	if (!_vdso_funcs_data->waitpkg_supported)
+		return -ENODEV;
+
+	asm volatile("mov %0, %%rdi\t\n"
+		     ".byte 0xf3, 0x0f, 0xae, 0xf7\t\n"
+		     : : "r" (addr));
+
+	return 0;
+}
+
+/**
+ * umonitor() - vDSO function for setting up monitoring address
+ * @addr: Monitored address
+ *
+ * The vDSO function sets up address monitoring hardware using address @addr.
+ * It can be executed at any privilege level.
+ *
+ * umonitor() and its alias __vdso_umonitor() are implemented
+ * as vDSO functions.
+ *
+ * Return:
+ * 0: Successful
+ *
+ * Less than zero: error code
+ */
+int umonitor(void *addr)
+	__attribute__((weak, alias("__vdso_umonitor")));
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
+notrace int __vdso_umwait(int state, unsigned long nsec)
+{
+	unsigned long tsc;
+	int ret;
+
+	if (!_vdso_funcs_data->waitpkg_supported)
+		return -ENODEV;
+
+	if (state != 0 && state != 1)
+		return -EINVAL;
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
+/**
+ * umwait() - vDSO function for user monitor wait
+ * @state: State
+ * @nsec: Time out in nanoseconds
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
+ * umwait() and its alias __vdso_umwait() are implemented as vDSO functions.
+ *
+ * Return:
+ * 1: the processor wakes due to expiration of OS time-limit
+ *
+ * 0: the processor wakes due to other reasons
+ *
+ * less than 0: error code
+ */
+int umwait(int state, unsigned long nsec)
+	__attribute__((weak, alias("__vdso_umwait")));
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
+notrace int __vdso_tpause(int state, unsigned long nsec)
+{
+	unsigned long tsc;
+	int ret;
+
+	if (!_vdso_funcs_data->waitpkg_supported)
+		return -ENODEV;
+
+	if (state != 0 && state != 1)
+		return -EINVAL;
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
+/**
+ * tpause() - vDSO function for timed pause
+ * @state: State
+ * @nsec: Timeout in nanoseconds
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
+ * tpause() and its alias __vdso_tpause() are implemented as vDSO functions.
+ *
+ * Return:
+ * 1: the processor wakes due to expiration of OS time-limit
+ *
+ * 0: the processor wakes due to other reasons
+ *
+ * less than 0: error code
+ */
+int tpause(int state, unsigned long nsec)
+	__attribute__((weak, alias("__vdso_tpause")));
diff --git a/arch/x86/include/asm/vdso_funcs_data.h b/arch/x86/include/asm/vdso_funcs_data.h
index b99a5685029e..a4caa64bbe8d 100644
--- a/arch/x86/include/asm/vdso_funcs_data.h
+++ b/arch/x86/include/asm/vdso_funcs_data.h
@@ -10,6 +10,9 @@
 struct vdso_funcs_data {
 	bool movdiri_supported;   /* if movdiri instruction is supported */
 	bool movdir64b_supported; /* if movdir64b instruction is supported */
+	bool waitpkg_supported;   /* if wait pkg instructions are supported */
+	bool tsc_known_freq;      /* if TSC has known freqency */
+	u64  tsc_per_nsec;        /* TSC counter per nanosecond */
 };
 
 #define _vdso_funcs_data (&VVAR(vdso_funcs_data))
-- 
2.5.0

