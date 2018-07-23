Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C262ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2872820779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2872820779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388499AbeGWP32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:29:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:43708 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388424AbeGWP3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:29:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2018 07:27:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,393,1526367600"; 
   d="scan'208";a="242560357"
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
Subject: [PATCH 5/7] x86/vdso: Add vDSO functions for direct store instructions
Date:   Mon, 23 Jul 2018 05:55:55 -0700
Message-Id: <1532350557-98388-6-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1532350557-98388-1-git-send-email-fenghua.yu@intel.com>
References: <1532350557-98388-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User wants to query if direct store instructions are supported and use
the instructions. The vDSO functions provides fast interface for user
to query the support and use the instructions.

movdiri_supported and its alias __vdso_movdiri_supported check if
movdiri instructions are supported.

movdir64b_supported and its alias __vdso_movdir64b_supported checks
if movdir64b instruction is supported.

movdiri32 and its alias __vdso_movdiri32 provide user APIs for calling
32-bit movdiri instruction.

movdiri64 and its alias __vdso_movdiri64 provide user APIs for calling
64-bit movdiri instruction.

movdir64b and its alias __vdso_movdir64b provide user APIs to move
64-byte data through movdir64b instruction.

The instructions can be implemented in intrinsic functions in future
GCC. But the vDSO interfaces are available to user without the
intrinsic functions support in GCC and the APIs movdiri_supported and
movdir64b_supported cannot be implemented as GCC functions.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/entry/vdso/Makefile           |   2 +-
 arch/x86/entry/vdso/vdirectstore.c     | 152 +++++++++++++++++++++++++++++++++
 arch/x86/entry/vdso/vdso.lds.S         |  10 +++
 arch/x86/entry/vdso/vma.c              |  12 +++
 arch/x86/include/asm/vdso_funcs_data.h |  17 ++++
 arch/x86/include/asm/vvar.h            |   1 +
 6 files changed, 193 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/entry/vdso/vdirectstore.c
 create mode 100644 arch/x86/include/asm/vdso_funcs_data.h

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index b9ed1aa53a26..af4fcae5de83 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -17,7 +17,7 @@ VDSO32-$(CONFIG_X86_32)		:= y
 VDSO32-$(CONFIG_IA32_EMULATION)	:= y
 
 # files to link into the vdso
-vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o
+vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o vdirectstore.o
 
 # files to link into kernel
 obj-y				+= vma.o
diff --git a/arch/x86/entry/vdso/vdirectstore.c b/arch/x86/entry/vdso/vdirectstore.c
new file mode 100644
index 000000000000..6f6d76ed8cde
--- /dev/null
+++ b/arch/x86/entry/vdso/vdirectstore.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * vDSO functions for direct store instructions
+ *
+ * Copyright 2018 Intel Coporation
+ *
+ * Author: Fenghua Yu <fenghua.yu@intel.com>
+ */
+#include <asm/vdso_funcs_data.h>
+
+notrace bool __vdso_movdiri_supported(void)
+{
+	return _vdso_funcs_data->movdiri_supported;
+}
+
+/**
+ * movdiri_supported() - vDSO function for checking movdiri instructions support
+ *
+ * This function checks if direct store instruction movdiri is supported
+ * on this machine.
+ *
+ * movdiri_supported() and its alias __vdso_movdiri_supported() are
+ * implemented as vDSO functions.
+ *
+ * Return:
+ * true: supported
+ *
+ * false: not supported
+ */
+bool movdiri_supported(void)
+	__attribute__((weak, alias("__vdso_movdiri_supported")));
+
+notrace int __vdso_movdir64b_supported(void)
+{
+	return _vdso_funcs_data->movdir64b_supported;
+}
+
+/**
+ * movdir64b_supported() - vDSO function for checking movdir64b instruction
+ * support
+ *
+ * This function checks if direct store instruction movdir64b is supported
+ * on this machine.
+ *
+ * movdir64b_supported() and its alias __vdso_movdir64b_supported() are
+ * implemented as vDSO functions.
+ *
+ * Return:
+ * true: supported
+ *
+ * false: not supported
+ */
+bool movdir64b_supported(void)
+	__attribute__((weak, alias("__vdso_movdir64b_supported")));
+
+notrace int __vdso_movdiri32(int *dst, int data)
+{
+	if (!_vdso_funcs_data->movdiri_supported)
+		return -ENODEV;
+
+	/* movdiri eax, [rdx] */
+	asm volatile(".byte 0x0f, 0x38, 0xf9, 0x02"
+		     : "=m" (*dst)
+		     : "a" (data), "d" (dst));
+
+	return 0;
+}
+
+/**
+ * movdiri32() - vDSO function for moving doubleword using direct store.
+ * @dst: Destination address.
+ * @data: 32-bit data.
+ *
+ * Moves the doubleword in @data to the destination address @dst
+ * using direct-store operation.
+ *
+ * movdiri32() and its alias __vdso_movdiri32() are implemented as vDSO
+ * functions.
+ *
+ * Return:
+ * 0: Successful
+ *
+ * Less than zero: error code
+ */
+int movdiri32(int *dst, int data)
+	__attribute__((weak, alias("__vdso_movdiri32")));
+
+notrace int __vdso_movdiri64(long *dst, long data)
+{
+	if (!_vdso_funcs_data->movdiri_supported)
+		return -ENODEV;
+
+	/* movdiri rax, [rdx] */
+	asm volatile(".byte 0x48, 0x0f, 0x38, 0xf9, 0x02"
+		     : "=m" (*dst)
+		     : "a" (data), "d" (dst));
+
+	return 0;
+}
+
+/**
+ * movdiri64() - vDSO function for moving quadword using direct store
+ * @dst: Destination address
+ * @data: 64-bit data
+ *
+ * Moves the quadword in @data to the destination address @dst using
+ * direct-store operation.
+ *
+ * movdiri64() and its alias __vdso_movdiri64() are implemented as vDSO
+ * functions.
+ *
+ * Return:
+ * 0: Successful
+ *
+ * Less than zero: error code
+ */
+void movdiri64(long *dst, long data)
+	__attribute__((weak, alias("__vdso_movdiri64")));
+
+notrace int __vdso_movdir64b(char *dst, char *src)
+{
+	if (!_vdso_funcs_data->movdir64b_supported)
+		return -ENODEV;
+
+	 /* movdir64b [rax], rdx */
+	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
+		     : "=m" (*dst)
+		     : "a" (src), "d" (dst));
+
+	return 0;
+}
+
+/**
+ * movdir64b() - vDSO function for moving 64 bytes using direct store
+ * @dst: Destination address
+ * @src: Source address
+ *
+ * Moves 64 bytes as direct store with 64 bytes write atomicity from
+ * source memory address @src to destination address @dst.
+ *
+ * @dst must be 64-byte aligned. No alignment requirement for @src.
+ *
+ * movdir64b() and its alias __vdso_movdir64b() are implemented as vDSO
+ * functions.
+ *
+ * Return:
+ * 0: Successful
+ *
+ * Less than zero: error code
+ */
+int movdir64b(char *dst, char *src)
+	__attribute__((weak, alias("__vdso_movdir64b")));
diff --git a/arch/x86/entry/vdso/vdso.lds.S b/arch/x86/entry/vdso/vdso.lds.S
index d3a2dce4cfa9..097cdcda43a5 100644
--- a/arch/x86/entry/vdso/vdso.lds.S
+++ b/arch/x86/entry/vdso/vdso.lds.S
@@ -25,6 +25,16 @@ VERSION {
 		__vdso_getcpu;
 		time;
 		__vdso_time;
+		movdiri_supported;
+		__vdso_movdiri_supported;
+		movdiri32;
+		__vdso_movdiri32;
+		movdiri64;
+		__vdso_movdiri64;
+		movdir64b_supported;
+		__vdso_movdir64b_supported;
+		movdir64b;
+		__vdso_movdir64b;
 	local: *;
 	};
 }
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 5b8b556dbb12..edbe5e63e5c2 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -23,11 +23,14 @@
 #include <asm/desc.h>
 #include <asm/cpufeature.h>
 #include <asm/mshyperv.h>
+#include <asm/vdso_funcs_data.h>
 
 #if defined(CONFIG_X86_64)
 unsigned int __read_mostly vdso64_enabled = 1;
 #endif
 
+DEFINE_VVAR(struct vdso_funcs_data, vdso_funcs_data);
+
 void __init init_vdso_image(const struct vdso_image *image)
 {
 	BUG_ON(image->size % PAGE_SIZE != 0);
@@ -367,6 +370,14 @@ static int vgetcpu_online(unsigned int cpu)
 	return smp_call_function_single(cpu, vgetcpu_cpu_init, NULL, 1);
 }
 
+static void __init init_vdso_funcs_data(void)
+{
+	if (static_cpu_has(X86_FEATURE_MOVDIRI))
+		vdso_funcs_data.movdiri_supported = true;
+	if (static_cpu_has(X86_FEATURE_MOVDIR64B))
+		vdso_funcs_data.movdir64b_supported = true;
+}
+
 static int __init init_vdso(void)
 {
 	init_vdso_image(&vdso_image_64);
@@ -374,6 +385,7 @@ static int __init init_vdso(void)
 #ifdef CONFIG_X86_X32_ABI
 	init_vdso_image(&vdso_image_x32);
 #endif
+	init_vdso_funcs_data();
 
 	/* notifier priority > KVM */
 	return cpuhp_setup_state(CPUHP_AP_X86_VDSO_VMA_ONLINE,
diff --git a/arch/x86/include/asm/vdso_funcs_data.h b/arch/x86/include/asm/vdso_funcs_data.h
new file mode 100644
index 000000000000..b99a5685029e
--- /dev/null
+++ b/arch/x86/include/asm/vdso_funcs_data.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_VDSO_FUNCS_DATA_H
+#define _ASM_X86_VDSO_FUNCS_DATA_H
+
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <asm/vvar.h>
+
+/* This structure contains data used by vDSO functions. */
+struct vdso_funcs_data {
+	bool movdiri_supported;   /* if movdiri instruction is supported */
+	bool movdir64b_supported; /* if movdir64b instruction is supported */
+};
+
+#define _vdso_funcs_data (&VVAR(vdso_funcs_data))
+
+#endif /* _ASM_X86_VDSO_FUNCS_DATA_H */
diff --git a/arch/x86/include/asm/vvar.h b/arch/x86/include/asm/vvar.h
index 3f32dfc2ab73..74047c0490fe 100644
--- a/arch/x86/include/asm/vvar.h
+++ b/arch/x86/include/asm/vvar.h
@@ -45,6 +45,7 @@ extern char __vvar_page;
 /* DECLARE_VVAR(offset, type, name) */
 
 DECLARE_VVAR(128, struct vsyscall_gtod_data, vsyscall_gtod_data)
+DECLARE_VVAR(256, struct vdso_funcs_data, vdso_funcs_data)
 
 #undef DECLARE_VVAR
 
-- 
2.5.0

