Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726DCC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3781C208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3781C208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbeK0SCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:02:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:55738 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728625AbeK0SCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 13:02:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 32337AE26;
        Tue, 27 Nov 2018 07:05:05 +0000 (UTC)
Date:   Tue, 27 Nov 2018 08:05:02 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 20/24] x86/speculation: Split out TIF update
In-Reply-To: <alpine.DEB.2.21.1811262244510.1682@nanos.tec.linutronix.de>
Message-ID: <nycvar.YFH.7.76.1811270800090.21108@cbobk.fhfr.pm>
References: <20181121201430.559770965@linutronix.de> <20181121201724.227260385@linutronix.de> <f976eb35-5dcd-387e-eb29-f7c6636fd17b@linux.intel.com> <alpine.DEB.2.21.1811222352340.1665@nanos.tec.linutronix.de> <20181123073735.GA12959@gmail.com>
 <c51dd20a-2cea-1bd1-bee7-48ca25f9bdb9@linux.intel.com> <alpine.DEB.2.21.1811262244510.1682@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2018, Thomas Gleixner wrote:

> > Looks like seccomp thread can be running on a remote CPU when its
> > TIF_SPEC_IB flag gets updated.
> >
> > I wonder if this will cause STIBP to be always off in this scenario, when
> > two tasks with SPEC_IB flags running on a remote CPU have STIBP bit always
> > *off* in SPEC MSR.
> > 
> > Let's say we have tasks A and B running on a remote CPU:
> > 
> > task A: SPEC_IB flag is on
> >
> > task B: SPEC_IB flag is off but is currently running on remote CPU, SPEC
> >         MSR's STIBP bit is off
> >
> > Now arch_seccomp_spec_mitigation is called, setting SPEC_IB flag on task B.
> > SPEC MSR becomes out of sync with running task B's SPEC_IB flag.
> > 
> >
> > Task B context switches to task A. Because both tasks have SPEC_IB flag
> > set and the flag status is unchanged, SPEC MSR's STIBP bit is not
> > updated.  SPEC MSR STIBP bit remains off if tasks A and B are the only
> > tasks running on the CPU.
> >
> > There is an equivalent scenario where the SPEC MSR's STIBP bit remains on
> > even though both running task A and B's SPEC_IB flags are turned off.
> >
> > Wonder if I may be missing something so the above scenario is not of
> > concern?
> 
> The above is real. 

Agreed.

> The question is whether we need to worry about it.

Well, update of seccomp filters (and therefore updating of the flags) 
might happen at any time, long after the seccomp process has been started, 
so it might be pretty spread across cores by that time. So I think it 
indeed is a real scenario, although probably even harder for explicitly 
target by an attacker.

> If so, then the right thing to do is to leave thread_info.flags alone 
> and flip the bits in a shadow storage, e.g. thread_info.spec_flags and 
> after updating that set something like TIF_SPEC_UPDATE and evaluate that 
> bit on context switch and if set update the TIF flags. Too tired to code 
> that now, but it's straight forward. I'll look at it on wednesday if 
> nobody beats me to it.

Hm, the we'd have to implement the same split for things like checking of 
the work masks etc. (because we'd have to be checking in both places), 
right? That doesn't look particularly nice.

How about the minimalistic aproach below? (only compile tested so far, 
applies on top of your latest WIP.x86/pti branch). The downside of course 
is wasting another TIF bit.

Thanks.



From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] x86/speculation: Always properly update SPEC_CTRL MSR for remote seccomp tasks

If seccomp task is setting (*) TIF_SPEC_IB of a task running on remote CPU, the
value of TIF_SPEC_IB becomes out-of-sync with the actual MSR value on that CPU.

This becomes a problem when such task then context switches to another task
that has TIF_SPEC_IB set, as in such case the value of SPEC_CTRL MSR is not
updated and the next task starts running with stale value of SPEC_CTRL,
potentially unprotected by STIBP.

Fix that by always unconditionally updating the MSR in case that

- next task's TIF_SPEC_IB has been remotely set by its another seccomp thread,
  and

- TIF_SPEC_IB value of next is equal to the one of prev, and therefore
  we are guaranteed to be in a situation where MSR update would be lost

(*) symmetrical situation happens with clearing of the flag

Reported-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 arch/x86/include/asm/thread_info.h |  4 +++-
 arch/x86/kernel/cpu/bugs.c         |  8 ++++++++
 arch/x86/kernel/process.c          | 16 +++++++++++++++-
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 6d201699c651..278f9036ca45 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -84,6 +84,7 @@ struct thread_info {
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SECCOMP		8	/* secure computing */
 #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
+#define TIF_SPEC_UPDATE		10	/* SPEC_CTRL MSR sync needed on CTXSW */
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
 #define TIF_UPROBE		12	/* breakpointed or singlestepping */
 #define TIF_PATCH_PENDING	13	/* pending live patching update */
@@ -112,6 +113,7 @@ struct thread_info {
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
+#define _TIF_SPEC_UPDATE	(1 << TIF_SPEC_UPDATE)
 #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
@@ -155,7 +157,7 @@ struct thread_info {
  * Avoid calls to __switch_to_xtra() on UP as STIBP is not evaluated.
  */
 #ifdef CONFIG_SMP
-# define _TIF_WORK_CTXSW	(_TIF_WORK_CTXSW_BASE | _TIF_SPEC_IB)
+# define _TIF_WORK_CTXSW	(_TIF_WORK_CTXSW_BASE | _TIF_SPEC_IB | _TIF_SPEC_UPDATE)
 #else
 # define _TIF_WORK_CTXSW	(_TIF_WORK_CTXSW_BASE)
 #endif
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index b5d2b36618a5..20d7c67b3dda 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -772,9 +772,17 @@ static void task_update_spec_tif(struct task_struct *tsk, int tifbit, bool on)
 	 *
 	 * This can only happen for SECCOMP mitigation. For PRCTL it's
 	 * always the current task.
+	 *
+	 * If we are updating non-current task, set a flag for it to always
+	 * perform the MSR sync on a first context switch, to make sure
+	 * the TIF_SPEC_IB above is not out of sync with the MSR value during
+	 * task's runtime.
 	 */
 	if (tsk == current && update)
 		speculation_ctrl_update_current();
+	else
+		set_tsk_thread_flag(tsk, TIF_SPEC_UPDATE);
+
 }
 
 static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 3f5e351bdd37..78208234e63e 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -449,8 +449,20 @@ static __always_inline void __speculation_ctrl_update(unsigned long tifp,
 	 * otherwise avoid the MSR write.
 	 */
 	if (IS_ENABLED(CONFIG_SMP) &&
-	    static_branch_unlikely(&switch_to_cond_stibp))
+	    static_branch_unlikely(&switch_to_cond_stibp)) {
 		updmsr |= !!(tif_diff & _TIF_SPEC_IB);
+		/*
+		 * We need to update the MSR if remote task did set
+		 * TIF_SPEC_UPDATE on us, and therefore MSR value and
+		 * the TIF_SPEC_IB values might be out of sync.
+		 *
+		 * This can only happen if seccomp task has updated
+		 * one of its remote threads.
+		 */
+		if (IS_ENABLED(CONFIG_SECCOMP) && !updmsr &&
+				(tifn & TIF_SPEC_UPDATE))
+			updmsr = true;
+	}
 
 	if (updmsr)
 		spec_ctrl_update_msr(tifn);
@@ -496,6 +508,8 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
 		set_cpuid_faulting(!!(tifn & _TIF_NOCPUID));
 
 	__speculation_ctrl_update(tifp, tifn);
+	if (IS_ENABLED(CONFIG_SECCOMP))
+		clear_tsk_thread_flag(next_p, TIF_SPEC_UPDATE);
 }
 
 /*


-- 
Jiri Kosina
SUSE Labs

