Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB07C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F263E20673
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F263E20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbeK3TQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:16:52 -0500
Received: from mga14.intel.com ([192.55.52.115]:12724 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbeK3TQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:16:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 00:08:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,297,1539673200"; 
   d="scan'208";a="279174483"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 30 Nov 2018 00:08:23 -0800
Received: from dazhang1-ssd.sh.intel.com (unknown [10.239.48.128])
        by linux.intel.com (Postfix) with ESMTP id D340E580213;
        Fri, 30 Nov 2018 00:08:21 -0800 (PST)
From:   Zhang Yi <yi.z.zhang@linux.intel.com>
To:     pbonzini@redhat.com, mdontu@bitdefender.com, ncitu@bitdefender.com
Cc:     rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Zhang Yi <yi.z.zhang@linux.intel.com>
Subject: [RFC PATCH V2 02/11] x86/cpufeature: Add intel Sub-Page Protection to CPU features
Date:   Fri, 30 Nov 2018 16:08:06 +0800
Message-Id: <0b6a870f960c656bc73bf0e0b9c678ee7f52998e.1543481993.git.yi.z.zhang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543481993.git.yi.z.zhang@linux.intel.com>
References: <cover.1543481993.git.yi.z.zhang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds reporting SPP capability from VMX Procbased MSR, according to
the definition of hardware spec, bit 32 is the control of the SPP
capability.

Defined X86_FEATURE_SPP under intel X86 VT-x CPU features.

Defined the X86_VMX_FEATURE_PROC_CTLS2_SPP in intel VMX MSR indicated
features, And enable SPP capability by this MSR.

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
Signed-off-by: He Chen <he.chen@linux.intel.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/intel.c        | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 28c4a50..e22567e 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -228,6 +228,7 @@
 #define X86_FEATURE_FLEXPRIORITY	( 8*32+ 2) /* Intel FlexPriority */
 #define X86_FEATURE_EPT			( 8*32+ 3) /* Intel Extended Page Table */
 #define X86_FEATURE_VPID		( 8*32+ 4) /* Intel Virtual Processor ID */
+#define X86_FEATURE_SPP			( 8*32+ 5) /* Intel EPT-based Sub-Page Write Protection */
 
 #define X86_FEATURE_VMMCALL		( 8*32+15) /* Prefer VMMCALL to VMCALL */
 #define X86_FEATURE_XENPV		( 8*32+16) /* "" Xen paravirtual guest */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index fc3c07f..b55156c 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -476,6 +476,7 @@ static void detect_vmx_virtcap(struct cpuinfo_x86 *c)
 #define X86_VMX_FEATURE_PROC_CTLS2_EPT		0x00000002
 #define X86_VMX_FEATURE_PROC_CTLS2_VPID		0x00000020
 #define x86_VMX_FEATURE_EPT_CAP_AD		0x00200000
+#define X86_VMX_FEATURE_PROC_CTLS2_SPP		0x00800000
 
 	u32 vmx_msr_low, vmx_msr_high, msr_ctl, msr_ctl2;
 	u32 msr_vpid_cap, msr_ept_cap;
@@ -486,6 +487,7 @@ static void detect_vmx_virtcap(struct cpuinfo_x86 *c)
 	clear_cpu_cap(c, X86_FEATURE_EPT);
 	clear_cpu_cap(c, X86_FEATURE_VPID);
 	clear_cpu_cap(c, X86_FEATURE_EPT_AD);
+	clear_cpu_cap(c, X86_FEATURE_SPP);
 
 	rdmsr(MSR_IA32_VMX_PROCBASED_CTLS, vmx_msr_low, vmx_msr_high);
 	msr_ctl = vmx_msr_high | vmx_msr_low;
@@ -509,6 +511,8 @@ static void detect_vmx_virtcap(struct cpuinfo_x86 *c)
 		}
 		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VPID)
 			set_cpu_cap(c, X86_FEATURE_VPID);
+		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_SPP)
+			set_cpu_cap(c, X86_FEATURE_SPP);
 	}
 }
 
-- 
2.7.4

