Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C140C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1209D24724
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1209D24724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934616AbeGCSWr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 14:22:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:31145 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934593AbeGCSWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 14:22:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2018 11:22:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,304,1526367600"; 
   d="scan'208";a="242708135"
Received: from cdikicix-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.69])
  by fmsmga006.fm.intel.com with ESMTP; 03 Jul 2018 11:22:38 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     x86@kernel.org, platform-driver-x86@vger.kernel.org
Cc:     dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        linux-sgx@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v12 05/13] x86/sgx: architectural structures
Date:   Tue,  3 Jul 2018 21:19:50 +0300
Message-Id: <20180703182118.15024-6-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180703182118.15024-1-jarkko.sakkinen@linux.intel.com>
References: <20180703182118.15024-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds arch/x86/include/asm/sgx_arch.h that contains definitions
for data structures used by the SGX.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Co-developed-by: Suresh Siddha <suresh.b.siddha@intel.com>
---
 arch/x86/include/asm/sgx_arch.h | 183 ++++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)
 create mode 100644 arch/x86/include/asm/sgx_arch.h

diff --git a/arch/x86/include/asm/sgx_arch.h b/arch/x86/include/asm/sgx_arch.h
new file mode 100644
index 000000000000..41a37eaa3f51
--- /dev/null
+++ b/arch/x86/include/asm/sgx_arch.h
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2016-17 Intel Corporation.
+
+#ifndef _ASM_X86_SGX_ARCH_H
+#define _ASM_X86_SGX_ARCH_H
+
+#include <linux/types.h>
+
+#define SGX_CPUID 0x12
+
+enum sgx_cpuid {
+	SGX_CPUID_CAPABILITIES	= 0,
+	SGX_CPUID_ATTRIBUTES	= 1,
+	SGX_CPUID_EPC_BANKS	= 2,
+};
+
+#define SGX_SSA_GPRS_SIZE		182
+#define SGX_SSA_MISC_EXINFO_SIZE	16
+
+enum sgx_misc {
+	SGX_MISC_EXINFO		= 0x01,
+};
+
+#define SGX_MISC_RESERVED_MASK 0xFFFFFFFFFFFFFFFEL
+
+enum sgx_attribute {
+	SGX_ATTR_DEBUG		= 0x02,
+	SGX_ATTR_MODE64BIT	= 0x04,
+	SGX_ATTR_PROVISIONKEY	= 0x10,
+	SGX_ATTR_EINITTOKENKEY	= 0x20,
+};
+
+#define SGX_ATTR_RESERVED_MASK 0xFFFFFFFFFFFFFFC9L
+
+#define SGX_SECS_RESERVED1_SIZE 24
+#define SGX_SECS_RESERVED2_SIZE 32
+#define SGX_SECS_RESERVED3_SIZE 96
+#define SGX_SECS_RESERVED4_SIZE 3836
+
+struct sgx_secs {
+	uint64_t size;
+	uint64_t base;
+	uint32_t ssaframesize;
+	uint32_t miscselect;
+	uint8_t reserved1[SGX_SECS_RESERVED1_SIZE];
+	uint64_t attributes;
+	uint64_t xfrm;
+	uint32_t mrenclave[8];
+	uint8_t reserved2[SGX_SECS_RESERVED2_SIZE];
+	uint32_t mrsigner[8];
+	uint8_t	reserved3[SGX_SECS_RESERVED3_SIZE];
+	uint16_t isvvprodid;
+	uint16_t isvsvn;
+	uint8_t reserved4[SGX_SECS_RESERVED4_SIZE];
+} __packed __aligned(4096);
+
+enum sgx_tcs_flags {
+	SGX_TCS_DBGOPTIN	= 0x01, /* cleared on EADD */
+};
+
+#define SGX_TCS_RESERVED_MASK 0xFFFFFFFFFFFFFFFEL
+
+struct sgx_tcs {
+	uint64_t state;
+	uint64_t flags;
+	uint64_t ossa;
+	uint32_t cssa;
+	uint32_t nssa;
+	uint64_t oentry;
+	uint64_t aep;
+	uint64_t ofsbase;
+	uint64_t ogsbase;
+	uint32_t fslimit;
+	uint32_t gslimit;
+	uint64_t reserved[503];
+} __packed __aligned(4096);
+
+struct sgx_pageinfo {
+	uint64_t linaddr;
+	uint64_t srcpge;
+	union {
+		uint64_t secinfo;
+		uint64_t pcmd;
+	};
+	uint64_t secs;
+} __packed __aligned(32);
+
+
+#define SGX_SECINFO_PERMISSION_MASK	0x0000000000000007L
+#define SGX_SECINFO_PAGE_TYPE_MASK	0x000000000000FF00L
+#define SGX_SECINFO_RESERVED_MASK	0xFFFFFFFFFFFF00F8L
+
+enum sgx_page_type {
+	SGX_PAGE_TYPE_SECS	= 0x00,
+	SGX_PAGE_TYPE_TCS	= 0x01,
+	SGX_PAGE_TYPE_REG	= 0x02,
+	SGX_PAGE_TYPE_VA	= 0x03,
+	SGX_PAGE_TYPE_TRIM	= 0x04,
+};
+
+enum sgx_secinfo_flags {
+	SGX_SECINFO_R		= 0x01,
+	SGX_SECINFO_W		= 0x02,
+	SGX_SECINFO_X		= 0x04,
+	SGX_SECINFO_SECS	= (SGX_PAGE_TYPE_SECS << 8),
+	SGX_SECINFO_TCS		= (SGX_PAGE_TYPE_TCS << 8),
+	SGX_SECINFO_REG		= (SGX_PAGE_TYPE_REG << 8),
+	SGX_SECINFO_VA          = (SGX_PAGE_TYPE_VA << 8),
+	SGX_SECINFO_TRIM	= (SGX_PAGE_TYPE_TRIM << 8),
+};
+
+struct sgx_secinfo {
+	uint64_t flags;
+	uint64_t reserved[7];
+} __packed __aligned(64);
+
+struct sgx_pcmd {
+	struct sgx_secinfo secinfo;
+	uint64_t enclave_id;
+	uint8_t reserved[40];
+	uint8_t mac[16];
+} __packed __aligned(128);
+
+#define SGX_MODULUS_SIZE 384
+
+struct sgx_sigstruct_header {
+	uint64_t header1[2];
+	uint32_t vendor;
+	uint32_t date;
+	uint64_t header2[2];
+	uint32_t swdefined;
+	uint8_t reserved1[84];
+} __packed;
+
+struct sgx_sigstruct_body {
+	uint32_t miscselect;
+	uint32_t miscmask;
+	uint8_t reserved2[20];
+	uint64_t attributes;
+	uint64_t xfrm;
+	uint8_t attributemask[16];
+	uint8_t mrenclave[32];
+	uint8_t reserved3[32];
+	uint16_t isvprodid;
+	uint16_t isvsvn;
+} __packed;
+
+struct sgx_sigstruct {
+	struct sgx_sigstruct_header header;
+	uint8_t modulus[SGX_MODULUS_SIZE];
+	uint32_t exponent;
+	uint8_t signature[SGX_MODULUS_SIZE];
+	struct sgx_sigstruct_body body;
+	uint8_t reserved4[12];
+	uint8_t q1[SGX_MODULUS_SIZE];
+	uint8_t q2[SGX_MODULUS_SIZE];
+} __packed __aligned(4096);
+
+struct sgx_einittoken_payload {
+	uint32_t valid;
+	uint32_t reserved1[11];
+	uint64_t attributes;
+	uint64_t xfrm;
+	uint8_t mrenclave[32];
+	uint8_t reserved2[32];
+	uint8_t mrsigner[32];
+	uint8_t reserved3[32];
+} __packed;
+
+struct sgx_einittoken {
+	struct sgx_einittoken_payload payload;
+	uint8_t cpusvnle[16];
+	uint16_t isvprodidle;
+	uint16_t isvsvnle;
+	uint8_t reserved2[24];
+	uint32_t maskedmiscselectle;
+	uint64_t maskedattributesle;
+	uint64_t maskedxfrmle;
+	uint8_t keyid[32];
+	uint8_t mac[16];
+} __packed __aligned(512);
+
+#endif /* _ASM_X86_SGX_ARCH_H */
-- 
2.17.1

