Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0E9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC962080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC962080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbeKTAYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:24:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:52302 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728258AbeKTAYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 19:24:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 44263AC4B;
        Mon, 19 Nov 2018 14:00:19 +0000 (UTC)
Date:   Mon, 19 Nov 2018 15:00:17 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     Tim Chen <tim.c.chen@linux.intel.com>,
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
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: Re: [Patch v5 11/16] x86/speculation: Add Spectre v2 app to app
 protection modes
In-Reply-To: <alpine.DEB.2.21.1811191451101.1537@nanos.tec.linutronix.de>
Message-ID: <nycvar.YFH.7.76.1811191455120.21108@cbobk.fhfr.pm>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com> <ca5dd01c12789d3f75ab1b73bfcac3bdaea93dd6.1542418937.git.tim.c.chen@linux.intel.com> <nycvar.YFH.7.76.1811171044510.21108@cbobk.fhfr.pm> <nycvar.YFH.7.76.1811182358370.21108@cbobk.fhfr.pm>
 <alpine.DEB.2.21.1811191433100.1537@nanos.tec.linutronix.de> <nycvar.YFH.7.76.1811191438290.21108@cbobk.fhfr.pm> <alpine.DEB.2.21.1811191451101.1537@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2018, Thomas Gleixner wrote:

> > Yeah. IBPB implementation used to check the dumpability of tasks during 
> > rescheduling, but that went away later.
> > 
> > I still think that ideally that 'app2app' setting would toggle how IBPB is 
> > being used as well, something along the lines:
> > 
> > lite:
> > 	- STIBP for the ones marked via prctl() and SECCOMP with the TIF_ 
> > 	  flag
> > 	- ibpb_needed() returning true for the same
> > 
> > strict:
> > 	- STIBP: as currently implemented
> > 	- ibpb_needed() returning always true
> > 
> > off:
> > 	- neither STIBP nor IBPB applied ever
> > 
> > That's give us also some % of performance lost via IBPB back.
> > 
> > Makes sense?
> 
> Except for the naming convention, yes. See other mail.

Actually Tim's patchset seems to already deal with IBPB in a consistent 
way as well in

	[11/16] x86/speculation: Add Spectre v2 app to app protection modes

but the fact that it's still using TIF_STIBP makes it a bit confusing and 
hidden. So I'd suggest to fold something like below into it.



From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] x86/speculation: rename TIF_STIBP to TIF_SPEC_INDIR_BRANCH

TIF_STIBP is being used not only for making decisions about STIBP, but also
for determining whether IBPB should be issued during reschedule. Let's
not pretend the TIF flag is specific to STIBP.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 arch/x86/include/asm/spec-ctrl.h   |  8 ++++----
 arch/x86/include/asm/thread_info.h |  6 +++---
 arch/x86/kernel/cpu/bugs.c         | 14 +++++++-------
 arch/x86/kernel/process.c          |  2 +-
 arch/x86/mm/tlb.c                  |  2 +-
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/spec-ctrl.h b/arch/x86/include/asm/spec-ctrl.h
index b59377952665..41b993e3756f 100644
--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -55,8 +55,8 @@ static inline u64 ssbd_tif_to_spec_ctrl(u64 tifn)
 
 static inline u64 stibp_tif_to_spec_ctrl(u64 tifn)
 {
-	BUILD_BUG_ON(TIF_STIBP < SPEC_CTRL_STIBP_SHIFT);
-	return (tifn & _TIF_STIBP) >> (TIF_STIBP - SPEC_CTRL_STIBP_SHIFT);
+	BUILD_BUG_ON(TIF_SPEC_INDIR_BRANCH < SPEC_CTRL_STIBP_SHIFT);
+	return (tifn & _TIF_SPEC_INDIR_BRANCH) >> (TIF_SPEC_INDIR_BRANCH - SPEC_CTRL_STIBP_SHIFT);
 }
 
 static inline unsigned long ssbd_spec_ctrl_to_tif(u64 spec_ctrl)
@@ -67,8 +67,8 @@ static inline unsigned long ssbd_spec_ctrl_to_tif(u64 spec_ctrl)
 
 static inline unsigned long stibp_spec_ctrl_to_tif(u64 spec_ctrl)
 {
-	BUILD_BUG_ON(TIF_STIBP < SPEC_CTRL_STIBP_SHIFT);
-	return (spec_ctrl & SPEC_CTRL_STIBP) << (TIF_STIBP - SPEC_CTRL_STIBP_SHIFT);
+	BUILD_BUG_ON(TIF_SPEC_INDIR_BRANCH < SPEC_CTRL_STIBP_SHIFT);
+	return (spec_ctrl & SPEC_CTRL_STIBP) << (TIF_SPEC_INDIR_BRANCH - SPEC_CTRL_STIBP_SHIFT);
 }
 
 static inline u64 ssbd_tif_to_amd_ls_cfg(u64 tifn)
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 453616fdbbd0..796ba73c5a26 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -110,7 +110,7 @@ struct thread_info {
 /* Security mode */
 #define TIF_SECCOMP		24	/* Secure computing */
 #define TIF_SSBD		25	/* Speculative store bypass disable */
-#define TIF_STIBP		26	/* Single thread indirect branch speculation */
+#define TIF_SPEC_INDIR_BRANCH		26	/* Indirect branch speculation */
 
 #define _TIF_NOCPUID		(1 << TIF_NOCPUID)
 #define _TIF_NOTSC		(1 << TIF_NOTSC)
@@ -142,7 +142,7 @@ struct thread_info {
 
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_SSBD		(1 << TIF_SSBD)
-#define _TIF_STIBP		(1 << TIF_STIBP)
+#define _TIF_SPEC_INDIR_BRANCH		(1 << TIF_SPEC_INDIR_BRANCH)
 
 /*
  * work to do in syscall_trace_enter().  Also includes TIF_NOHZ for
@@ -164,7 +164,7 @@ struct thread_info {
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW							\
 	(_TIF_IO_BITMAP|_TIF_NOCPUID|_TIF_NOTSC|_TIF_BLOCKSTEP|		\
-	 _TIF_SSBD|_TIF_STIBP)
+	 _TIF_SSBD|_TIF_SPEC_INDIR_BRANCH)
 
 #define _TIF_WORK_CTXSW_PREV (_TIF_WORK_CTXSW|_TIF_USER_RETURN_NOTIFY)
 #define _TIF_WORK_CTXSW_NEXT (_TIF_WORK_CTXSW)
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 3ec952108e87..ae10f5cef3a0 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -410,10 +410,10 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 static bool stibp_needed(void)
 {
 	/*
-	 * Determine if STIBP should be always on.
-	 * Using enhanced IBRS makes using STIBP unnecessary.
-	 * For lite option, STIBP is used only for task with
-	 * TIF_STIBP flag. STIBP is not always on for that case.
+	 * Determine if STIBP should be always on.  Using enhanced IBRS makes
+	 * using STIBP unnecessary.  For lite option, STIBP is used only for
+	 * task with TIF_SPEC_INDIR_BRANCH flag. STIBP is not always on for
+	 * that case.
 	 */
 
 	if (spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_NONE)
@@ -779,9 +779,9 @@ static void set_task_stibp(struct task_struct *tsk, bool stibp_on)
 	bool update = false;
 
 	if (stibp_on)
-		update = !test_and_set_tsk_thread_flag(tsk, TIF_STIBP);
+		update = !test_and_set_tsk_thread_flag(tsk, TIF_SPEC_INDIR_BRANCH);
 	else if (!task_spec_indir_branch_disable(tsk))
-		update = test_and_clear_tsk_thread_flag(tsk, TIF_STIBP);
+		update = test_and_clear_tsk_thread_flag(tsk, TIF_SPEC_INDIR_BRANCH);
 
 	if (tsk == current && update)
 		speculation_ctrl_update_current();
@@ -898,7 +898,7 @@ static int indir_branch_prctl_get(struct task_struct *task)
 	case SPECTRE_V2_APP2APP_LITE:
 		if (task_spec_indir_branch_force_disable(task))
 			return PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE;
-		if (test_tsk_thread_flag(task, TIF_STIBP))
+		if (test_tsk_thread_flag(task, TIF_SPEC_INDIR_BRANCH))
 			return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
 		return PR_SPEC_PRCTL | PR_SPEC_ENABLE;
 	case SPECTRE_V2_APP2APP_STRICT:
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 943e90dd2e85..15fc1b30c999 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -426,7 +426,7 @@ static __always_inline void spec_ctrl_update_msr(unsigned long tifn)
 static __always_inline void __speculation_ctrl_update(unsigned long tifp,
 						      unsigned long tifn)
 {
-	bool updmsr = !!((tifp ^ tifn) & _TIF_STIBP);
+	bool updmsr = !!((tifp ^ tifn) & _TIF_SPEC_INDIR_BRANCH);
 
 	/* If TIF_SSBD is different, select the proper mitigation method */
 	if ((tifp ^ tifn) & _TIF_SSBD) {
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 920147059567..616694c7497c 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -202,7 +202,7 @@ static bool ibpb_needed(struct task_struct *tsk, u64 last_ctx_id)
 	 */
 
 	if (static_branch_unlikely(&spectre_v2_app_lite))
-		return test_tsk_thread_flag(tsk, TIF_STIBP);
+		return test_tsk_thread_flag(tsk, TIF_SPEC_INDIR_BRANCH);
 	else
 		return ptrace_may_access_sched(tsk, PTRACE_MODE_SPEC_IBPB);
 }

-- 
Jiri Kosina
SUSE Labs

