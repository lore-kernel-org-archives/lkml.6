Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B59C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04EFE21508
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5U28HpC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04EFE21508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbeLDK5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:57:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:40648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbeLDK5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:57:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18382214E0;
        Tue,  4 Dec 2018 10:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921021;
        bh=N1k0owh5seYjrec+GmohYVdxI1bHno+atQ3sZyOrrx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I5U28HpCYM5s4JOf6XtW+SOP6bICR8qANZbckk8mD5J3TeR7olYYY2WViM8Xh8gKq
         8+/fO15p8MKB3AsOAz7zgCjE6S3M8LCrhHIo9QhWlml7wgFni/g36cT9jd7E8+tnJT
         Ws8VOgX6+Mh8zpoouu37aOhRwEd7tfVWRICslX2Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
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
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 4.19 050/139] x86/speculation: Prepare for per task indirect branch speculation control
Date:   Tue,  4 Dec 2018 11:48:51 +0100
Message-Id: <20181204103652.034466382@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tim Chen tim.c.chen@linux.intel.com

commit 5bfbe3ad5840d941b89bcac54b821ba14f50a0ba upstream

To avoid the overhead of STIBP always on, it's necessary to allow per task
control of STIBP.

Add a new task flag TIF_SPEC_IB and evaluate it during context switch if
SMT is active and flag evaluation is enabled by the speculation control
code. Add the conditional evaluation to x86_virt_spec_ctrl() as well so the
guest/host switch works properly.

This has no effect because TIF_SPEC_IB cannot be set yet and the static key
which controls evaluation is off. Preparatory patch for adding the control
code.

[ tglx: Simplify the context switch logic and make the TIF evaluation
  	depend on SMP=y and on the static key controlling the conditional
  	update. Rename it to TIF_SPEC_IB because it controls both STIBP and
  	IBPB ]

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Casey Schaufler <casey.schaufler@intel.com>
Cc: Asit Mallick <asit.k.mallick@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Jon Masters <jcm@redhat.com>
Cc: Waiman Long <longman9394@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Dave Stewart <david.c.stewart@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20181125185005.176917199@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/msr-index.h   |    5 +++--
 arch/x86/include/asm/spec-ctrl.h   |   12 ++++++++++++
 arch/x86/include/asm/thread_info.h |    5 ++++-
 arch/x86/kernel/cpu/bugs.c         |    4 ++++
 arch/x86/kernel/process.c          |   20 ++++++++++++++++++--
 5 files changed, 41 insertions(+), 5 deletions(-)

--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -41,9 +41,10 @@
 
 #define MSR_IA32_SPEC_CTRL		0x00000048 /* Speculation Control */
 #define SPEC_CTRL_IBRS			(1 << 0)   /* Indirect Branch Restricted Speculation */
-#define SPEC_CTRL_STIBP			(1 << 1)   /* Single Thread Indirect Branch Predictors */
+#define SPEC_CTRL_STIBP_SHIFT		1	   /* Single Thread Indirect Branch Predictor (STIBP) bit */
+#define SPEC_CTRL_STIBP			(1 << SPEC_CTRL_STIBP_SHIFT)	/* STIBP mask */
 #define SPEC_CTRL_SSBD_SHIFT		2	   /* Speculative Store Bypass Disable bit */
-#define SPEC_CTRL_SSBD			(1 << SPEC_CTRL_SSBD_SHIFT)   /* Speculative Store Bypass Disable */
+#define SPEC_CTRL_SSBD			(1 << SPEC_CTRL_SSBD_SHIFT)	/* Speculative Store Bypass Disable */
 
 #define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
 #define PRED_CMD_IBPB			(1 << 0)   /* Indirect Branch Prediction Barrier */
--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -53,12 +53,24 @@ static inline u64 ssbd_tif_to_spec_ctrl(
 	return (tifn & _TIF_SSBD) >> (TIF_SSBD - SPEC_CTRL_SSBD_SHIFT);
 }
 
+static inline u64 stibp_tif_to_spec_ctrl(u64 tifn)
+{
+	BUILD_BUG_ON(TIF_SPEC_IB < SPEC_CTRL_STIBP_SHIFT);
+	return (tifn & _TIF_SPEC_IB) >> (TIF_SPEC_IB - SPEC_CTRL_STIBP_SHIFT);
+}
+
 static inline unsigned long ssbd_spec_ctrl_to_tif(u64 spec_ctrl)
 {
 	BUILD_BUG_ON(TIF_SSBD < SPEC_CTRL_SSBD_SHIFT);
 	return (spec_ctrl & SPEC_CTRL_SSBD) << (TIF_SSBD - SPEC_CTRL_SSBD_SHIFT);
 }
 
+static inline unsigned long stibp_spec_ctrl_to_tif(u64 spec_ctrl)
+{
+	BUILD_BUG_ON(TIF_SPEC_IB < SPEC_CTRL_STIBP_SHIFT);
+	return (spec_ctrl & SPEC_CTRL_STIBP) << (TIF_SPEC_IB - SPEC_CTRL_STIBP_SHIFT);
+}
+
 static inline u64 ssbd_tif_to_amd_ls_cfg(u64 tifn)
 {
 	return (tifn & _TIF_SSBD) ? x86_amd_ls_cfg_ssbd_mask : 0ULL;
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -83,6 +83,7 @@ struct thread_info {
 #define TIF_SYSCALL_EMU		6	/* syscall emulation active */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SECCOMP		8	/* secure computing */
+#define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
 #define TIF_UPROBE		12	/* breakpointed or singlestepping */
 #define TIF_PATCH_PENDING	13	/* pending live patching update */
@@ -110,6 +111,7 @@ struct thread_info {
 #define _TIF_SYSCALL_EMU	(1 << TIF_SYSCALL_EMU)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
+#define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
 #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
@@ -146,7 +148,8 @@ struct thread_info {
 
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW							\
-	(_TIF_IO_BITMAP|_TIF_NOCPUID|_TIF_NOTSC|_TIF_BLOCKSTEP|_TIF_SSBD)
+	(_TIF_IO_BITMAP|_TIF_NOCPUID|_TIF_NOTSC|_TIF_BLOCKSTEP|		\
+	 _TIF_SSBD|_TIF_SPEC_IB)
 
 #define _TIF_WORK_CTXSW_PREV (_TIF_WORK_CTXSW|_TIF_USER_RETURN_NOTIFY)
 #define _TIF_WORK_CTXSW_NEXT (_TIF_WORK_CTXSW)
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -148,6 +148,10 @@ x86_virt_spec_ctrl(u64 guest_spec_ctrl,
 		    static_cpu_has(X86_FEATURE_AMD_SSBD))
 			hostval |= ssbd_tif_to_spec_ctrl(ti->flags);
 
+		/* Conditional STIBP enabled? */
+		if (static_branch_unlikely(&switch_to_cond_stibp))
+			hostval |= stibp_tif_to_spec_ctrl(ti->flags);
+
 		if (hostval != guestval) {
 			msrval = setguest ? guestval : hostval;
 			wrmsrl(MSR_IA32_SPEC_CTRL, msrval);
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -404,11 +404,17 @@ static __always_inline void amd_set_ssb_
 static __always_inline void __speculation_ctrl_update(unsigned long tifp,
 						      unsigned long tifn)
 {
+	unsigned long tif_diff = tifp ^ tifn;
 	u64 msr = x86_spec_ctrl_base;
 	bool updmsr = false;
 
-	/* If TIF_SSBD is different, select the proper mitigation method */
-	if ((tifp ^ tifn) & _TIF_SSBD) {
+	/*
+	 * If TIF_SSBD is different, select the proper mitigation
+	 * method. Note that if SSBD mitigation is disabled or permanentely
+	 * enabled this branch can't be taken because nothing can set
+	 * TIF_SSBD.
+	 */
+	if (tif_diff & _TIF_SSBD) {
 		if (static_cpu_has(X86_FEATURE_VIRT_SSBD)) {
 			amd_set_ssb_virt_state(tifn);
 		} else if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD)) {
@@ -420,6 +426,16 @@ static __always_inline void __speculatio
 		}
 	}
 
+	/*
+	 * Only evaluate TIF_SPEC_IB if conditional STIBP is enabled,
+	 * otherwise avoid the MSR write.
+	 */
+	if (IS_ENABLED(CONFIG_SMP) &&
+	    static_branch_unlikely(&switch_to_cond_stibp)) {
+		updmsr |= !!(tif_diff & _TIF_SPEC_IB);
+		msr |= stibp_tif_to_spec_ctrl(tifn);
+	}
+
 	if (updmsr)
 		wrmsrl(MSR_IA32_SPEC_CTRL, msr);
 }


