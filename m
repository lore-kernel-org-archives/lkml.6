Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F128CECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D0A20894
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D0A20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388409AbeGWP3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:29:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:43703 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388169AbeGWP3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:29:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2018 07:27:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,393,1526367600"; 
   d="scan'208";a="242560343"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga005.jf.intel.com with ESMTP; 23 Jul 2018 07:27:35 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>
Cc:     "Ashok Raj" <ashok.raj@intel.com>,
        "Alan Cox" <alan@linux.intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 1/7] x86/cpufeatures: Enumerate MOVDIRI instruction
Date:   Mon, 23 Jul 2018 05:55:51 -0700
Message-Id: <1532350557-98388-2-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1532350557-98388-1-git-send-email-fenghua.yu@intel.com>
References: <1532350557-98388-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MOVDIRI moves doubleword or quadword from register to memory through
direct store which is implemented by using write combining (WC) for
writing data directly into memory without caching the data.

Programmable agents can handle streaming offload (e.g. high speed packet
processing in network). Hardware implements a doorbell (tail pointer)
register that is updated by software when adding new work-elements to
the streaming offload work-queue.

MOVDIRI can be used as the doorbell write which is a 4-byte or 8-byte
uncachable write to MMIO. MOVDIRI has lower overhead than other ways
to write the doorbell.

Availability of the MOVDIRI instruction is indicated by the presence of
the CPUID feature flag MOVDIRI(CPUID.0x07.0x0:ECX[bit 27]).

Please check the latest Intel Architecture Instruction Set Extensions
and Future Features Programming Reference for more details on the CPUID
feature MOVDIRI flag.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 5701f5cecd31..92630c469675 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -329,6 +329,7 @@
 #define X86_FEATURE_LA57		(16*32+16) /* 5-level page tables */
 #define X86_FEATURE_RDPID		(16*32+22) /* RDPID instruction */
 #define X86_FEATURE_CLDEMOTE		(16*32+25) /* CLDEMOTE instruction */
+#define X86_FEATURE_MOVDIRI		(16*32+27) /* MOVDIRI instruction */
 
 /* AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17 */
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* MCA overflow recovery support */
-- 
2.5.0

