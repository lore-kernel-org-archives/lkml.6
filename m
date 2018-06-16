Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E4DC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 03:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34675208DA
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 03:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34675208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756883AbeFPDIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 23:08:05 -0400
Received: from mga05.intel.com ([192.55.52.43]:3363 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756852AbeFPDIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 23:08:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 20:08:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,228,1526367600"; 
   d="scan'208";a="233011926"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga005.jf.intel.com with ESMTP; 15 Jun 2018 20:07:28 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>
Cc:     "Ashok Raj" <ashok.raj@intel.com>,
        "Alan Cox" <alan@linux.intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [RFC PATCH 6/8] x86/lib_direct_store.h: Add APIs for direct store instructions
Date:   Fri, 15 Jun 2018 20:06:13 -0700
Message-Id: <1529118375-90191-7-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1529118375-90191-1-git-send-email-fenghua.yu@intel.com>
References: <1529118375-90191-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Direct store instructions MOVDIRI and MOVDIR64B are published in the
latest Intel Instruction Set Extensions document.

Define the APIs for user or kernel to use the instructions.

If feature enabled GCC is available in the future, implementation
of the APIs will be changed to call the intrinsic instructions.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/include/uapi/asm/lib_direct_store.h | 161 +++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)
 create mode 100644 arch/x86/include/uapi/asm/lib_direct_store.h

diff --git a/arch/x86/include/uapi/asm/lib_direct_store.h b/arch/x86/include/uapi/asm/lib_direct_store.h
new file mode 100644
index 000000000000..95a676f170ff
--- /dev/null
+++ b/arch/x86/include/uapi/asm/lib_direct_store.h
@@ -0,0 +1,161 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This library provides a set of APIs for user or kernel to use
+ * some new instructions:
+ * - Director stores: movdiri and movdir64b
+ *
+ * Detailed information on the instructions can be found in
+ * Intel Architecture Instruction Set Extensions and Future Features
+ * Programming Reference.
+ *
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Author:
+ *     Fenghua Yu <fenghua.yu@intel.com>
+ */
+#ifndef _ASM_X86_LIB_DIRECT_STORES_H
+#define _ASM_X86_LIB_DIRECT_STORES_H
+
+#include <stdbool.h>
+
+/* CPUID.07H.0H:ECX[bit 27] */
+#define MOVDIRI_BIT		27
+/* CPUID.07H.0H:ECX[bit 28] */
+#define MOVDIR64B_BIT		28
+
+static bool _movdiri_supported, _movdiri_enumerated;
+static bool _movdir64b_supported, _movdir64b_enumerated;
+
+/**
+ * movdiri_supported() - Is movdiri instruction supported?
+ *
+ * Return:
+ * true: supported
+ *
+ * false: not supported
+ */
+static inline bool movdiri_supported(void)
+{
+	int eax, ebx, ecx, edx;
+	bool ret;
+
+	/*
+	 * If movdiri has been enumerated before, return cached movdiri
+	 * support info.
+	 */
+	if (_movdiri_enumerated)
+		return _movdiri_supported;
+
+	/* Otherwise, enumerate movdiri from CPUID. */
+	asm volatile("mov $7, %%eax\t\n"
+		     "mov $0, %%ecx\t\n"
+		     "cpuid\t\n"
+		     : "=a" (eax), "=b" (ebx), "=c" (ecx), "=d" (edx));
+
+	if (ecx & (1 << MOVDIRI_BIT))
+		ret = true;
+	else
+		ret = false;
+
+	/*
+	 * Cache movdiri support info so we can use it later without
+	 * calling CPUID.
+	 */
+	_movdiri_enumerated = true;
+	_movdiri_supported = ret;
+
+	return ret;
+}
+
+/**
+ * movdir64b_supported() - Is movdir64b instruction supported?
+ *
+ * Return:
+ * true: supported
+ *
+ * false: not supported
+ */
+static inline bool movdir64b_supported(void)
+{
+	int eax, ebx, ecx, edx;
+	int ret;
+
+	/*
+	 * If movdir64b has been enumerated before, return cached movdir64b
+	 * support info.
+	 */
+	if (_movdir64b_enumerated)
+		return _movdir64b_supported;
+
+	/* Otherwise, enumerate movdir64b from CPUID. */
+	asm volatile("mov $7, %%eax\t\n"
+		     "mov $0, %%ecx\t\n"
+		     "cpuid\t\n"
+		     : "=a" (eax), "=b" (ebx), "=c" (ecx), "=d" (edx));
+
+	if (ecx & (1 << MOVDIR64B_BIT))
+		ret = true;
+	else
+		ret = false;
+
+	/*
+	 * Cache movdir64b support info so we can use it later without
+	 * calling CPUID.
+	 */
+	_movdir64b_enumerated = true;
+	_movdir64b_supported = ret;
+
+	return ret;
+}
+
+/**
+ * movdiri32() - Move doubleword using direct store.
+ * @dst: Destination address.
+ * @data: 32-bit data.
+ *
+ * Moves the doubleword integer in @data to the destination address @dst
+ * using a direct-store operation.
+ */
+static inline void movdiri32(int *dst, int data)
+{
+	/* movdiri eax, [rdx] */
+	asm volatile(".byte 0x0f, 0x38, 0xf9, 0x02"
+		     : "=m" (*dst)
+		     : "a" (data), "d" (dst));
+}
+
+/**
+ * movdiri64() - Move quadword using direct store
+ * @dst: Destination address
+ * @data: 64-bit data
+ *
+ * Moves the quadword integer in @data to the destination address @dst
+ * using a direct-store operation.
+ */
+static inline void movdiri64(long *dst, long data)
+{
+	/* movdiri rax, [rdx] */
+	asm volatile(".byte 0x48, 0x0f, 0x38, 0xf9, 0x02"
+		     : "=m" (*dst)
+		     : "a" (data), "d" (dst));
+}
+
+/**
+ * movdir64b() - Move 64 bytes using direct store
+ * @dst: Destination address
+ * @src: Source address
+ *
+ * Moves 64 bytes as direct store with 64 bytes write atomicity from
+ * source memory address @src to destination address @dst.
+ *
+ * @dst must be 64-byte aligned. No alignment requirement for @src.
+ */
+static inline void movdir64b(void *dst, void *src)
+{
+	 /* movdir64b [rax], rdx */
+	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
+		     : "=m" (*dst)
+		     : "a" (src), "d" (dst));
+}
+
+#endif /* _ASM_X86_LIB_DIRECT_STORES_H */
-- 
2.5.0

