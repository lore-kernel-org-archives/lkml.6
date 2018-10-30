Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFC8C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D4E12080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D4E12080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeJaERg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 00:17:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:23900 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727764AbeJaERe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 00:17:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 12:22:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,445,1534834800"; 
   d="scan'208";a="103876811"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by fmsmga001.fm.intel.com with ESMTP; 30 Oct 2018 12:22:49 -0700
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
Subject: [Patch v4 17/18] x86/speculation: Update SPEC_CTRL MSRs of remote CPUs
Date:   Tue, 30 Oct 2018 11:49:24 -0700
Message-Id: <a14236d8b56dafe6988ce1b266a6e929be5296a8.1540923609.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1540923609.git.tim.c.chen@linux.intel.com>
References: <cover.1540923609.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1540923609.git.tim.c.chen@linux.intel.com>
References: <cover.1540923609.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPEC_CTRL MSR of a remote CPU cannot be updated immediately when
TIF_STIBP flag is changed on a task running on the remote CPU.

If next task's TIF_STIBP flag happened to be the same as the updated
TIF_STIBP on the previous task on the next context switch, the SPEC_CTRL
MSR update is missed as the SPEC_CTRL MSR update occurs only on flag
changes, and update of the SPEC_CTRL MSR did not happen while previous
task was running.

This patch creates TIF_UPDATE_SPEC_CTRL bit and set it along with
TIF_STIBP bit update for tasks running on remote CPU. This signals that
the SPEC_CTRL MSR has a pending forced update on the next context
switch.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 arch/x86/include/asm/thread_info.h |  6 +++++-
 arch/x86/kernel/cpu/bugs.c         |  2 ++
 arch/x86/kernel/process.c          | 22 +++++++++++++++++++++-
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 4f6a7a9..7bdd097 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -97,6 +97,7 @@ struct thread_info {
 #define TIF_USER_RETURN_NOTIFY	14	/* Notify kernel of userspace return */
 #define TIF_PATCH_PENDING	15	/* Pending live patching update */
 #define TIF_FSCHECK		16	/* Check FS is USER_DS on return */
+#define TIF_UPDATE_SPEC_CTRL    17	/* Pending update of speculation control MSR */
 
 /* Task status */
 #define TIF_UPROBE		18	/* Breakpointed or singlestepping */
@@ -131,6 +132,7 @@ struct thread_info {
 #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
 #define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
 #define _TIF_FSCHECK		(1 << TIF_FSCHECK)
+#define _TIF_UPDATE_SPEC_CTRL	(1 << TIF_UPDATE_SPEC_CTRL)
 
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_MEMDIE		(1 << TIF_MEMDIE)
@@ -166,7 +168,9 @@ struct thread_info {
 	(_TIF_IO_BITMAP|_TIF_NOCPUID|_TIF_NOTSC|_TIF_BLOCKSTEP|		\
 	 _TIF_SSBD|_TIF_STIBP)
 
-#define _TIF_WORK_CTXSW_PREV (_TIF_WORK_CTXSW|_TIF_USER_RETURN_NOTIFY)
+#define _TIF_WORK_CTXSW_PREV \
+	(_TIF_WORK_CTXSW|_TIF_USER_RETURN_NOTIFY|_TIF_UPDATE_SPEC_CTRL)
+
 #define _TIF_WORK_CTXSW_NEXT (_TIF_WORK_CTXSW)
 
 #define STACK_WARN		(THREAD_SIZE/8)
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index b402b96..1ba9cb5 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -789,6 +789,8 @@ static void set_task_stibp(struct task_struct *tsk, bool stibp_on)
 
 	if (tsk == current)
 		speculation_ctrl_update_current();
+	else if (task_cpu(tsk) != smp_processor_id())
+		set_tsk_thread_flag(tsk, TIF_UPDATE_SPEC_CTRL);
 }
 
 void arch_set_security(struct task_struct *tsk, unsigned int value)
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 943e90d..048b7f4b 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -426,7 +426,19 @@ static __always_inline void spec_ctrl_update_msr(unsigned long tifn)
 static __always_inline void __speculation_ctrl_update(unsigned long tifp,
 						      unsigned long tifn)
 {
-	bool updmsr = !!((tifp ^ tifn) & _TIF_STIBP);
+	/*
+	 * If TIF_UPDATE_SPEC_CTRL bit is set in tifp, speculation related
+	 * TIF flags have changed when previous task was running, but
+	 * SPEC_CTRL MSR has not been synchronized with TIF flag changes.
+	 * SPEC_CTRL MSR value can be out of date.
+	 *
+	 * Need to force update SPEC_CTRL MSR if TIF_UPDATE_SPEC_CTRL
+	 * bit in tifp is set.
+	 *
+	 * The TIF_UPDATE_SPEC_CTRL bit in tifn was cleared before calling
+	 * this function.
+	 */
+	bool updmsr = !!((tifp ^ tifn) & (_TIF_STIBP|_TIF_UPDATE_SPEC_CTRL));
 
 	/* If TIF_SSBD is different, select the proper mitigation method */
 	if ((tifp ^ tifn) & _TIF_SSBD) {
@@ -482,6 +494,14 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p,
 	if ((tifp ^ tifn) & _TIF_NOCPUID)
 		set_cpuid_faulting(!!(tifn & _TIF_NOCPUID));
 
+	if (tifp & _TIF_UPDATE_SPEC_CTRL)
+		clear_tsk_thread_flag(prev_p, TIF_UPDATE_SPEC_CTRL);
+
+	if (tifn & _TIF_UPDATE_SPEC_CTRL) {
+		clear_tsk_thread_flag(next_p, TIF_UPDATE_SPEC_CTRL);
+		tifn &= ~_TIF_UPDATE_SPEC_CTRL;
+	}
+
 	__speculation_ctrl_update(tifp, tifn);
 }
 
-- 
2.9.4

