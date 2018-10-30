Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663FEC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE162082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE162082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbeJaERd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 00:17:33 -0400
Received: from mga11.intel.com ([192.55.52.93]:23897 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbeJaERb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 00:17:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 12:22:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,445,1534834800"; 
   d="scan'208";a="103876799"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by fmsmga001.fm.intel.com with ESMTP; 30 Oct 2018 12:22:46 -0700
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
Subject: [Patch v4 14/18] x86/speculation: Turn on or off STIBP according to a task's TIF_STIBP
Date:   Tue, 30 Oct 2018 11:49:21 -0700
Message-Id: <9ec3ccc0d1424b566081fcecf794833e13762485.1540923609.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1540923609.git.tim.c.chen@linux.intel.com>
References: <cover.1540923609.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1540923609.git.tim.c.chen@linux.intel.com>
References: <cover.1540923609.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch creates the mechanism to apply STIBP protection on
a per task basis.

A new TIF_STIBP flag is created.  Tasks needing STIBP would have the
TIF_STIBP flag applied.  During context switch time, this flag is checked
and the STIBP bit in SPEC_CTRL MSR is updated according to changes in
this flag between previous and next tasks.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 arch/x86/include/asm/msr-index.h   |  6 +++++-
 arch/x86/include/asm/spec-ctrl.h   | 12 ++++++++++++
 arch/x86/include/asm/thread_info.h |  5 ++++-
 arch/x86/kernel/process.c          | 10 +++++++++-
 4 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 4731f0c..bd19452 100644
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
index 60798a0..4f6a7a9 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -110,6 +110,7 @@ struct thread_info {
 /* Security mode */
 #define TIF_SECCOMP		25	/* Secure computing */
 #define TIF_SSBD		26	/* Speculative store bypass disable */
+#define TIF_STIBP		27	/* Single thread indirect branch speculation */
 
 #define _TIF_NOCPUID		(1 << TIF_NOCPUID)
 #define _TIF_NOTSC		(1 << TIF_NOTSC)
@@ -141,6 +142,7 @@ struct thread_info {
 
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_SSBD		(1 << TIF_SSBD)
+#define _TIF_STIBP		(1 << TIF_STIBP)
 
 /*
  * work to do in syscall_trace_enter().  Also includes TIF_NOHZ for
@@ -161,7 +163,8 @@ struct thread_info {
 
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

