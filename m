Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C55ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B95E20685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B95E20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389742AbeGWNsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:48:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51918 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388215AbeGWNsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:48:20 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 35C65BB3;
        Mon, 23 Jul 2018 12:47:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 066/107] x86/process: Allow runtime control of Speculative Store Bypass
Date:   Mon, 23 Jul 2018 14:42:00 +0200
Message-Id: <20180723122416.502317117@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122413.003644357@linuxfoundation.org>
References: <20180723122413.003644357@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 885f82bfbc6fefb6664ea27965c3ab9ac4194b8c upstream

The Speculative Store Bypass vulnerability can be mitigated with the
Reduced Data Speculation (RDS) feature. To allow finer grained control of
this eventually expensive mitigation a per task mitigation control is
required.

Add a new TIF_RDS flag and put it into the group of TIF flags which are
evaluated for mismatch in switch_to(). If these bits differ in the previous
and the next task, then the slow path function __switch_to_xtra() is
invoked. Implement the TIF_RDS dependent mitigation control in the slow
path.

If the prctl for controlling Speculative Store Bypass is disabled or no
task uses the prctl then there is no overhead in the switch_to() fast
path.

Update the KVM related speculation control functions to take TID_RDS into
account as well.

Based on a patch from Tim Chen. Completely rewritten.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/include/asm/msr-index.h   |    3 ++-
 arch/x86/include/asm/spec-ctrl.h   |   17 +++++++++++++++++
 arch/x86/include/asm/thread_info.h |    6 ++++--
 arch/x86/kernel/cpu/bugs.c         |   26 +++++++++++++++++++++-----
 arch/x86/kernel/process.c          |   22 ++++++++++++++++++++++
 5 files changed, 66 insertions(+), 8 deletions(-)

--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -35,7 +35,8 @@
 #define MSR_IA32_SPEC_CTRL		0x00000048 /* Speculation Control */
 #define SPEC_CTRL_IBRS			(1 << 0)   /* Indirect Branch Restricted Speculation */
 #define SPEC_CTRL_STIBP			(1 << 1)   /* Single Thread Indirect Branch Predictors */
-#define SPEC_CTRL_RDS			(1 << 2)   /* Reduced Data Speculation */
+#define SPEC_CTRL_RDS_SHIFT		2	   /* Reduced Data Speculation bit */
+#define SPEC_CTRL_RDS			(1 << SPEC_CTRL_RDS_SHIFT)   /* Reduced Data Speculation */
 
 #define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
 #define PRED_CMD_IBPB			(1 << 0)   /* Indirect Branch Prediction Barrier */
--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_SPECCTRL_H_
 #define _ASM_X86_SPECCTRL_H_
 
+#include <linux/thread_info.h>
 #include <asm/nospec-branch.h>
 
 /*
@@ -18,4 +19,20 @@ extern void x86_spec_ctrl_restore_host(u
 extern u64 x86_amd_ls_cfg_base;
 extern u64 x86_amd_ls_cfg_rds_mask;
 
+/* The Intel SPEC CTRL MSR base value cache */
+extern u64 x86_spec_ctrl_base;
+
+static inline u64 rds_tif_to_spec_ctrl(u64 tifn)
+{
+	BUILD_BUG_ON(TIF_RDS < SPEC_CTRL_RDS_SHIFT);
+	return (tifn & _TIF_RDS) >> (TIF_RDS - SPEC_CTRL_RDS_SHIFT);
+}
+
+static inline u64 rds_tif_to_amd_ls_cfg(u64 tifn)
+{
+	return (tifn & _TIF_RDS) ? x86_amd_ls_cfg_rds_mask : 0ULL;
+}
+
+extern void speculative_store_bypass_update(void);
+
 #endif
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -92,6 +92,7 @@ struct thread_info {
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_SINGLESTEP		4	/* reenable singlestep on user return*/
+#define TIF_RDS			5	/* Reduced data speculation */
 #define TIF_SYSCALL_EMU		6	/* syscall emulation active */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SECCOMP		8	/* secure computing */
@@ -114,8 +115,9 @@ struct thread_info {
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
-#define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
+#define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
+#define _TIF_RDS		(1 << TIF_RDS)
 #define _TIF_SYSCALL_EMU	(1 << TIF_SYSCALL_EMU)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
@@ -147,7 +149,7 @@ struct thread_info {
 
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW							\
-	(_TIF_IO_BITMAP|_TIF_NOTSC|_TIF_BLOCKSTEP)
+	(_TIF_IO_BITMAP|_TIF_NOTSC|_TIF_BLOCKSTEP|_TIF_RDS)
 
 #define _TIF_WORK_CTXSW_PREV (_TIF_WORK_CTXSW|_TIF_USER_RETURN_NOTIFY)
 #define _TIF_WORK_CTXSW_NEXT (_TIF_WORK_CTXSW)
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -32,7 +32,7 @@ static void __init ssb_select_mitigation
  * Our boot-time value of the SPEC_CTRL MSR. We read it once so that any
  * writes to SPEC_CTRL contain whatever reserved bits have been set.
  */
-static u64 x86_spec_ctrl_base;
+u64 x86_spec_ctrl_base;
 
 /*
  * The vendor and possibly platform specific bits which can be modified in
@@ -139,25 +139,41 @@ EXPORT_SYMBOL_GPL(x86_spec_ctrl_set);
 
 u64 x86_spec_ctrl_get_default(void)
 {
-	return x86_spec_ctrl_base;
+	u64 msrval = x86_spec_ctrl_base;
+
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+		msrval |= rds_tif_to_spec_ctrl(current_thread_info()->flags);
+	return msrval;
 }
 EXPORT_SYMBOL_GPL(x86_spec_ctrl_get_default);
 
 void x86_spec_ctrl_set_guest(u64 guest_spec_ctrl)
 {
+	u64 host = x86_spec_ctrl_base;
+
 	if (!boot_cpu_has(X86_FEATURE_IBRS))
 		return;
-	if (x86_spec_ctrl_base != guest_spec_ctrl)
+
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+		host |= rds_tif_to_spec_ctrl(current_thread_info()->flags);
+
+	if (host != guest_spec_ctrl)
 		wrmsrl(MSR_IA32_SPEC_CTRL, guest_spec_ctrl);
 }
 EXPORT_SYMBOL_GPL(x86_spec_ctrl_set_guest);
 
 void x86_spec_ctrl_restore_host(u64 guest_spec_ctrl)
 {
+	u64 host = x86_spec_ctrl_base;
+
 	if (!boot_cpu_has(X86_FEATURE_IBRS))
 		return;
-	if (x86_spec_ctrl_base != guest_spec_ctrl)
-		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
+
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+		host |= rds_tif_to_spec_ctrl(current_thread_info()->flags);
+
+	if (host != guest_spec_ctrl)
+		wrmsrl(MSR_IA32_SPEC_CTRL, host);
 }
 EXPORT_SYMBOL_GPL(x86_spec_ctrl_restore_host);
 
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -31,6 +31,7 @@
 #include <asm/tlbflush.h>
 #include <asm/mce.h>
 #include <asm/vm86.h>
+#include <asm/spec-ctrl.h>
 
 /*
  * per-CPU TSS segments. Threads are completely 'soft' on Linux,
@@ -198,6 +199,24 @@ static inline void switch_to_bitmap(stru
 	}
 }
 
+static __always_inline void __speculative_store_bypass_update(unsigned long tifn)
+{
+	u64 msr;
+
+	if (static_cpu_has(X86_FEATURE_AMD_RDS)) {
+		msr = x86_amd_ls_cfg_base | rds_tif_to_amd_ls_cfg(tifn);
+		wrmsrl(MSR_AMD64_LS_CFG, msr);
+	} else {
+		msr = x86_spec_ctrl_base | rds_tif_to_spec_ctrl(tifn);
+		wrmsrl(MSR_IA32_SPEC_CTRL, msr);
+	}
+}
+
+void speculative_store_bypass_update(void)
+{
+	__speculative_store_bypass_update(current_thread_info()->flags);
+}
+
 void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p,
 		      struct tss_struct *tss)
 {
@@ -226,6 +245,9 @@ void __switch_to_xtra(struct task_struct
 
 	if ((tifp ^ tifn) & _TIF_NOTSC)
 		cr4_toggle_bits(X86_CR4_TSD);
+
+	if ((tifp ^ tifn) & _TIF_RDS)
+		__speculative_store_bypass_update(tifn);
 }
 
 /*


