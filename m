Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EACC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB1E2075B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB1E2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbeKQMmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 07:42:42 -0500
Received: from mga14.intel.com ([192.55.52.115]:45898 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731204AbeKQMml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 07:42:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2018 18:27:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,242,1539673200"; 
   d="scan'208";a="281852618"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by fmsmga006.fm.intel.com with ESMTP; 16 Nov 2018 18:27:45 -0800
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
Subject: [Patch v5 10/16] x86/speculation: Turn on or off STIBP according to a task's TIF_STIBP
Date:   Fri, 16 Nov 2018 17:53:53 -0800
Message-Id: <05bbde92757997c1b57450f83c25541e02f8e376.1542418937.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1542418936.git.tim.c.chen@linux.intel.com>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1542418936.git.tim.c.chen@linux.intel.com>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If STIBP is used all the time, tasks that do not need STIBP
protection will get unnecessarily slowed down by STIBP.

To apply STIBP only to tasks that need it, a new task TIF_STIBP flag is
created. A x86 CPU uses STIBP only for tasks labeled with TIF_STIBP.

During context switch, this flag is checked and the STIBP bit in SPEC_CTRL
MSR is updated according to changes in this flag between previous and
next task.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 arch/x86/include/asm/msr-index.h   |  6 +++++-
 arch/x86/include/asm/spec-ctrl.h   | 12 ++++++++++++
 arch/x86/include/asm/thread_info.h |  5 ++++-
 arch/x86/kernel/process.c          | 10 +++++++++-
 4 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 80f4a4f..501c9d3 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -41,7 +41,11 @@
 
 #define MSR_IA32_SPEC_CTRL		0x00000048 /* Speculation Control */
 #define SPEC_CTRL_IBRS			(1 << 0)   /* Indirect Branch Restricted Speculation */
-#define SPEC_CTRL_STIBP			(1 << 1)   /* Single Thread Indirect Branch Predictors */
+#define SPEC_CTRL_STIBP_SHIFT		1          /*
+						    * Single Thread Indirect Branch
+						    * Predictor (STIBP) bit
+						    */
+#define SPEC_CTRL_STIBP			(1 << SPEC_CTRL_STIBP_SHIFT) /* STIBP mask */
 #define SPEC_CTRL_SSBD_SHIFT		2	   /* Speculative Store Bypass Disable bit */
 #define SPEC_CTRL_SSBD			(1 << SPEC_CTRL_SSBD_SHIFT)   /* Speculative Store Bypass Disable */
 
diff --git a/arch/x86/include/asm/spec-ctrl.h b/arch/x86/include/asm/spec-ctrl.h
index 8e2f841..b593779 100644
--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -53,12 +53,24 @@ static inline u64 ssbd_tif_to_spec_ctrl(u64 tifn)
 	return (tifn & _TIF_SSBD) >> (TIF_SSBD - SPEC_CTRL_SSBD_SHIFT);
 }
 
+static inline u64 stibp_tif_to_spec_ctrl(u64 tifn)
+{
+	BUILD_BUG_ON(TIF_STIBP < SPEC_CTRL_STIBP_SHIFT);
+	return (tifn & _TIF_STIBP) >> (TIF_STIBP - SPEC_CTRL_STIBP_SHIFT);
+}
+
 static inline unsigned long ssbd_spec_ctrl_to_tif(u64 spec_ctrl)
 {
 	BUILD_BUG_ON(TIF_SSBD < SPEC_CTRL_SSBD_SHIFT);
 	return (spec_ctrl & SPEC_CTRL_SSBD) << (TIF_SSBD - SPEC_CTRL_SSBD_SHIFT);
 }
 
+static inline unsigned long stibp_spec_ctrl_to_tif(u64 spec_ctrl)
+{
+	BUILD_BUG_ON(TIF_STIBP < SPEC_CTRL_STIBP_SHIFT);
+	return (spec_ctrl & SPEC_CTRL_STIBP) << (TIF_STIBP - SPEC_CTRL_STIBP_SHIFT);
+}
+
 static inline u64 ssbd_tif_to_amd_ls_cfg(u64 tifn)
 {
 	return (tifn & _TIF_SSBD) ? x86_amd_ls_cfg_ssbd_mask : 0ULL;
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 2ff2a30..8736d23 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -83,6 +83,7 @@ struct thread_info {
 #define TIF_SYSCALL_EMU		6	/* syscall emulation active */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SECCOMP		8	/* secure computing */
+#define TIF_STIBP		9	/* Single thread indirect branch speculation */
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
 #define TIF_UPROBE		12	/* breakpointed or singlestepping */
 #define TIF_PATCH_PENDING	13	/* pending live patching update */
@@ -110,6 +111,7 @@ struct thread_info {
 #define _TIF_SYSCALL_EMU	(1 << TIF_SYSCALL_EMU)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
+#define _TIF_STIBP		(1 << TIF_STIBP)
 #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
@@ -146,7 +148,8 @@ struct thread_info {
 
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW							\
-	(_TIF_IO_BITMAP|_TIF_NOCPUID|_TIF_NOTSC|_TIF_BLOCKSTEP|_TIF_SSBD)
+	(_TIF_IO_BITMAP|_TIF_NOCPUID|_TIF_NOTSC|_TIF_BLOCKSTEP|		\
+	 _TIF_SSBD|_TIF_STIBP)
 
 #define _TIF_WORK_CTXSW_PREV (_TIF_WORK_CTXSW|_TIF_USER_RETURN_NOTIFY)
 #define _TIF_WORK_CTXSW_NEXT (_TIF_WORK_CTXSW)
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 74bef48..943e90d 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -406,6 +406,14 @@ static __always_inline void spec_ctrl_update_msr(unsigned long tifn)
 	if (static_cpu_has(X86_FEATURE_SSBD))
 		msr |= ssbd_tif_to_spec_ctrl(tifn);
 
+	/*
+	 * Need STIBP defense against Spectre v2 attack
+	 * if SMT is in use and enhanced IBRS is unsupported.
+	 */
+	if (static_branch_likely(&cpu_smt_enabled) &&
+	    !static_cpu_has(X86_FEATURE_USE_IBRS_ENHANCED))
+		msr |= stibp_tif_to_spec_ctrl(tifn);
+
 	wrmsrl(MSR_IA32_SPEC_CTRL, msr);
 }
 
@@ -418,7 +426,7 @@ static __always_inline void spec_ctrl_update_msr(unsigned long tifn)
 static __always_inline void __speculation_ctrl_update(unsigned long tifp,
 						      unsigned long tifn)
 {
-	bool updmsr = false;
+	bool updmsr = !!((tifp ^ tifn) & _TIF_STIBP);
 
 	/* If TIF_SSBD is different, select the proper mitigation method */
 	if ((tifp ^ tifn) & _TIF_SSBD) {
-- 
2.9.4

