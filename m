Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D913CC43610
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A512145D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A512145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbeKQMme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 07:42:34 -0500
Received: from mga14.intel.com ([192.55.52.115]:45898 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbeKQMmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 07:42:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2018 18:27:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,242,1539673200"; 
   d="scan'208";a="281852584"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by fmsmga006.fm.intel.com with ESMTP; 16 Nov 2018 18:27:36 -0800
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [Patch v5 04/16] x86/speculation: Add X86_FEATURE_USE_IBRS_ENHANCED
Date:   Fri, 16 Nov 2018 17:53:47 -0800
Message-Id: <40733266e3484cbd576d84b67dd98f9f8769d2e3.1542418937.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1542418936.git.tim.c.chen@linux.intel.com>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1542418936.git.tim.c.chen@linux.intel.com>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STIBP is not needed when enhanced IBRS is used for Spectre V2 mitigation.
A CPU feature flag to indicate that enhanced IBRS is used will be handy
for skipping STIBP for this case.

Add X86_FEATURE_USE_IBRS_ENHANCED feature bit to indicate
enhanced IBRS is used for Spectre V2 mitigation.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/bugs.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 28c4a50..fe8e064 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -221,6 +221,7 @@
 #define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU is AMD family 0x17 (Zen) */
 #define X86_FEATURE_L1TF_PTEINV		( 7*32+29) /* "" L1TF workaround PTE inversion */
 #define X86_FEATURE_IBRS_ENHANCED	( 7*32+30) /* Enhanced IBRS */
+#define X86_FEATURE_USE_IBRS_ENHANCED	( 7*32+31) /* "" Enhanced IBRS enabled */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 91a754a..3a6f13b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -387,6 +387,7 @@ static void __init spectre_v2_select_mitigation(void)
 			/* Force it so VMEXIT will restore correctly */
 			x86_spec_ctrl_base |= SPEC_CTRL_IBRS;
 			wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
+			setup_force_cpu_cap(X86_FEATURE_USE_IBRS_ENHANCED);
 			goto specv2_set_mode;
 		}
 		if (IS_ENABLED(CONFIG_RETPOLINE))
-- 
2.9.4

