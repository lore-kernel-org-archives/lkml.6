Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC1DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1622086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF1622086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbeK0XuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:50:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:51956 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729104AbeK0XuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 18:50:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E7AFAAF0D;
        Tue, 27 Nov 2018 12:52:25 +0000 (UTC)
Date:   Tue, 27 Nov 2018 13:52:23 +0100 (CET)
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
In-Reply-To: <nycvar.YFH.7.76.1811270820050.21108@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.1811271350590.21108@cbobk.fhfr.pm>
References: <20181121201430.559770965@linutronix.de> <20181121201724.227260385@linutronix.de> <f976eb35-5dcd-387e-eb29-f7c6636fd17b@linux.intel.com> <alpine.DEB.2.21.1811222352340.1665@nanos.tec.linutronix.de> <20181123073735.GA12959@gmail.com>
 <c51dd20a-2cea-1bd1-bee7-48ca25f9bdb9@linux.intel.com> <alpine.DEB.2.21.1811262244510.1682@nanos.tec.linutronix.de> <nycvar.YFH.7.76.1811270800090.21108@cbobk.fhfr.pm> <alpine.DEB.2.21.1811270809450.1682@nanos.tec.linutronix.de>
 <nycvar.YFH.7.76.1811270820050.21108@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018, Jiri Kosina wrote:

> > That's racy and does not prevent the situation because the TIF flags are
> > updated befor the UPDATE bit is set. 
> 
> > So __speculation_ctrl_update() might see the new bits, but not 
> > TIF_SPEC_UPDATE. 
> 
> Hm, right, scratch that. We'd need to do that before updating TIF_SPEC_IB 
> in task_update_spec_tif(), but that has the opposite ordering issue.

I think this should do it (not yet fully tested).


From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] x86/speculation: Always properly update SPEC_CTRL MSR for remote SECCOMP tasks

If seccomp task is setting TIF_SPEC_IB for a task running on remote CPU, 
the value of TIF_SPEC_IB becomes out-of-sync with the actual MSR value on 
that CPU.

This becomes a problem when such task then context switches to another 
task that has TIF_SPEC_IB set, as in such case the value of SPEC_CTRL MSR 
is not updated and the next task starts running with stale value of 
SPEC_CTRL, potentially unprotected by STIBP.

Fix that by "queuing" the needed flags update in 'spec_ctrl' shadow 
variable, and populating proper TI flags with it on context switch to the 
task that has the TIF_SPEC_UPDATE flag (indicating that syncing is 
necessary) set.

Reported-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 arch/x86/include/asm/thread_info.h |  5 ++++-
 arch/x86/kernel/cpu/bugs.c         | 13 +++++++++++--
 arch/x86/kernel/process.c          | 15 +++++++++++++++
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 6d201699c651..001b053067d7 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -55,6 +55,7 @@ struct task_struct;
 
 struct thread_info {
 	unsigned long		flags;		/* low level flags */
+	unsigned long		spec_flags;	/* spec flags to sync on ctxsw */
 	u32			status;		/* thread synchronous flags */
 };
 
@@ -84,6 +85,7 @@ struct thread_info {
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SECCOMP		8	/* secure computing */
 #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
+#define TIF_SPEC_UPDATE		10	/* SPEC_CTRL MSR sync needed on CTXSW */
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
 #define TIF_UPROBE		12	/* breakpointed or singlestepping */
 #define TIF_PATCH_PENDING	13	/* pending live patching update */
@@ -112,6 +114,7 @@ struct thread_info {
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
+#define _TIF_SPEC_UPDATE	(1 << TIF_SPEC_UPDATE)
 #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
@@ -155,7 +158,7 @@ struct thread_info {
  * Avoid calls to __switch_to_xtra() on UP as STIBP is not evaluated.
  */
 #ifdef CONFIG_SMP
-# define _TIF_WORK_CTXSW	(_TIF_WORK_CTXSW_BASE | _TIF_SPEC_IB)
+# define _TIF_WORK_CTXSW	(_TIF_WORK_CTXSW_BASE | _TIF_SPEC_IB | _TIF_SPEC_UPDATE)
 #else
 # define _TIF_WORK_CTXSW	(_TIF_WORK_CTXSW_BASE)
 #endif
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index b5d2b36618a5..679946135789 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -761,9 +761,11 @@ static void task_update_spec_tif(struct task_struct *tsk, int tifbit, bool on)
 	bool update;
 
 	if (on)
-		update = !test_and_set_tsk_thread_flag(tsk, tifbit);
+		update = !test_and_set_bit(tifbit,
+				&task_thread_info(tsk)->spec_flags);
 	else
-		update = test_and_clear_tsk_thread_flag(tsk, tifbit);
+		update = test_and_clear_bit(tifbit,
+				&task_thread_info(tsk)->spec_flags);
 
 	/*
 	 * Immediately update the speculation control MSRs for the current
@@ -772,9 +774,16 @@ static void task_update_spec_tif(struct task_struct *tsk, int tifbit, bool on)
 	 *
 	 * This can only happen for SECCOMP mitigation. For PRCTL it's
 	 * always the current task.
+	 *
+	 * If we are updating non-current SECCOMP task, set a flag for it to
+	 * always perform the MSR sync on a first context switch to it, in order
+	 * to make sure the TIF_SPEC_IB above is not out of sync with the MSR value.
 	 */
 	if (tsk == current && update)
 		speculation_ctrl_update_current();
+	else
+		set_tsk_thread_flag(tsk, TIF_SPEC_UPDATE);
+
 }
 
 static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 3f5e351bdd37..6c4fcef52b19 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -474,6 +474,21 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
 
 	tifn = READ_ONCE(task_thread_info(next_p)->flags);
 	tifp = READ_ONCE(task_thread_info(prev_p)->flags);
+
+	/*
+	 * SECCOMP tasks might have had their spec_ctrl flags updated during
+	 * runtime from a different CPU.
+	 *
+	 * When switching to such a task, populate thread flags with the ones
+	 * that have been temporarily saved in spec_flags by task_update_spec_tif()
+	 * in order to make sure MSR value is always kept up to date.
+	 *
+	 * SECCOMP tasks never disable the mitigation for other threads, only enable.
+	 */
+	if (IS_ENABLED(CONFIG_SECCOMP) &&
+			test_and_clear_tsk_thread_flag(next_p, TIF_SPEC_UPDATE))
+		tifp |= READ_ONCE(task_thread_info(next_p)->spec_flags);
+
 	switch_to_bitmap(prev, next, tifp, tifn);
 
 	propagate_user_return_notify(prev_p, next_p);

-- 
Jiri Kosina
SUSE Labs

