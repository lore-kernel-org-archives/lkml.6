Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72886ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4236C2148E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4236C2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbeJSVqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 17:46:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:23847 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbeJSVqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 17:46:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2018 06:39:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,400,1534834800"; 
   d="scan'208";a="89603824"
Received: from svm-s2600wft.bj.intel.com ([10.240.193.45])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Oct 2018 06:39:48 -0700
From:   Yi Sun <yi.y.sun@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, jgross@suse.com,
        chao.p.peng@intel.com, chao.gao@intel.com,
        isaku.yamahata@intel.com, michael.h.kelley@microsoft.com,
        tianyu.lan@microsoft.com, Yi Sun <yi.y.sun@linux.intel.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Subject: [PATCH v1 1/2] x86/hyperv: get spinlock retry number on Hyper-V
Date:   Fri, 19 Oct 2018 21:13:54 +0800
Message-Id: <1539954835-34035-2-git-send-email-yi.y.sun@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539954835-34035-1-git-send-email-yi.y.sun@linux.intel.com>
References: <1539954835-34035-1-git-send-email-yi.y.sun@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EBX of Implementation Recommendations MSR (0x40000004) indicates
recommended number of attempts to retry a spinlock failure before
notifying the hypervisor about the failures.

0xFFFFFFFF indicates never to retry.

Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>
Cc: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/mshyperv.h | 3 +++
 arch/x86/kernel/cpu/mshyperv.c  | 1 +
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 0d6271c..f909365 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -11,10 +11,13 @@
 
 #define VP_INVAL	U32_MAX
 
+#define HYPERV_SPINLOCK_RETRY_NEVER	U32_MAX
+
 struct ms_hyperv_info {
 	u32 features;
 	u32 misc_features;
 	u32 hints;
+	u32 num_spin_retry;
 	u32 nested_features;
 	u32 max_vp_index;
 	u32 max_lp_index;
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 1c72f38..04f480a 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -222,6 +222,7 @@ static void __init ms_hyperv_init_platform(void)
 	ms_hyperv.features = cpuid_eax(HYPERV_CPUID_FEATURES);
 	ms_hyperv.misc_features = cpuid_edx(HYPERV_CPUID_FEATURES);
 	ms_hyperv.hints    = cpuid_eax(HYPERV_CPUID_ENLIGHTMENT_INFO);
+	ms_hyperv.num_spin_retry = cpuid_ebx(HYPERV_CPUID_ENLIGHTMENT_INFO);
 
 	pr_info("Hyper-V: features 0x%x, hints 0x%x\n",
 		ms_hyperv.features, ms_hyperv.hints);
-- 
1.9.1

