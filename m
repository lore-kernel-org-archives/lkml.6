Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E04C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1DED26C51
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DED26C51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965703AbeFZO1X (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 10:27:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:60819 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935942AbeFZOWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 10:22:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 07:22:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,274,1526367600"; 
   d="scan'208";a="52376247"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 26 Jun 2018 07:22:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id B08B862D; Tue, 26 Jun 2018 17:22:51 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 06/18] x86/mm: Mask out KeyID bits from page table entry pfn
Date:   Tue, 26 Jun 2018 17:22:33 +0300
Message-Id: <20180626142245.82850-7-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180626142245.82850-1-kirill.shutemov@linux.intel.com>
References: <20180626142245.82850-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MKTME claims several upper bits of the physical address in a page table
entry to encode KeyID. It effectively shrinks number of bits for
physical address. We should exclude KeyID bits from physical addresses.

For instance, if CPU enumerates 52 physical address bits and number of
bits claimed for KeyID is 6, bits 51:46 must not be threated as part
physical address.

This patch adjusts __PHYSICAL_MASK during MKTME enumeration.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/cpu/intel.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index eb75564f2d25..bf2caf9d52dd 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -571,6 +571,29 @@ static void detect_tme(struct cpuinfo_x86 *c)
 		mktme_status = MKTME_ENABLED;
 	}
 
+#ifdef CONFIG_X86_INTEL_MKTME
+	if (mktme_status == MKTME_ENABLED && nr_keyids) {
+		/*
+		 * Mask out bits claimed from KeyID from physical address mask.
+		 *
+		 * For instance, if a CPU enumerates 52 physical address bits
+		 * and number of bits claimed for KeyID is 6, bits 51:46 of
+		 * physical address is unusable.
+		 */
+		phys_addr_t keyid_mask;
+
+		keyid_mask = GENMASK_ULL(c->x86_phys_bits - 1, c->x86_phys_bits - keyid_bits);
+		physical_mask &= ~keyid_mask;
+	} else {
+		/*
+		 * Reset __PHYSICAL_MASK.
+		 * Maybe needed if there's inconsistent configuation
+		 * between CPUs.
+		 */
+		physical_mask = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
+	}
+#endif
+
 	/*
 	 * KeyID bits effectively lower the number of physical address
 	 * bits.  Update cpuinfo_x86::x86_phys_bits accordingly.
-- 
2.18.0

