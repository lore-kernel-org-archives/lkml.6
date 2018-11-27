Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB61C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00ADC208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00ADC208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeK1I4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 03:56:42 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:58472 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbeK1I4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 03:56:42 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gRlM6-0003U1-1K; Tue, 27 Nov 2018 22:57:18 +0100
Date:   Tue, 27 Nov 2018 22:57:17 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jiri Kosina <jikos@kernel.org>
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
In-Reply-To: <nycvar.YFH.7.76.1811271350590.21108@cbobk.fhfr.pm>
Message-ID: <alpine.DEB.2.21.1811272247140.1875@nanos.tec.linutronix.de>
References: <20181121201430.559770965@linutronix.de> <20181121201724.227260385@linutronix.de> <f976eb35-5dcd-387e-eb29-f7c6636fd17b@linux.intel.com> <alpine.DEB.2.21.1811222352340.1665@nanos.tec.linutronix.de> <20181123073735.GA12959@gmail.com>
 <c51dd20a-2cea-1bd1-bee7-48ca25f9bdb9@linux.intel.com> <alpine.DEB.2.21.1811262244510.1682@nanos.tec.linutronix.de> <nycvar.YFH.7.76.1811270800090.21108@cbobk.fhfr.pm> <alpine.DEB.2.21.1811270809450.1682@nanos.tec.linutronix.de> <nycvar.YFH.7.76.1811270820050.21108@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1811271350590.21108@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018, Jiri Kosina wrote:
>  struct thread_info {
>  	unsigned long		flags;		/* low level flags */
> +	unsigned long		spec_flags;	/* spec flags to sync on ctxsw */

The information is already available in task->atomic_flags, no need for new
storage.

>  static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 3f5e351bdd37..6c4fcef52b19 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -474,6 +474,21 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
>  
>  	tifn = READ_ONCE(task_thread_info(next_p)->flags);
>  	tifp = READ_ONCE(task_thread_info(prev_p)->flags);
> +
> +	/*
> +	 * SECCOMP tasks might have had their spec_ctrl flags updated during
> +	 * runtime from a different CPU.
> +	 *
> +	 * When switching to such a task, populate thread flags with the ones
> +	 * that have been temporarily saved in spec_flags by task_update_spec_tif()
> +	 * in order to make sure MSR value is always kept up to date.
> +	 *
> +	 * SECCOMP tasks never disable the mitigation for other threads, only enable.
> +	 */
> +	if (IS_ENABLED(CONFIG_SECCOMP) &&
> +			test_and_clear_tsk_thread_flag(next_p, TIF_SPEC_UPDATE))
> +		tifp |= READ_ONCE(task_thread_info(next_p)->spec_flags);

And how does that get folded into task_thread_info(next_p)->flags for the
next context switch? Also you really need to check both the incoming and
the outgoing in order to enforce consistent state.

The completely untested patch below should fix that.

Thanks,

	tglx

8<---------------
--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -83,10 +83,6 @@ static inline void speculative_store_byp
 #endif
 
 extern void speculation_ctrl_update(unsigned long tif);
-
-static inline void speculation_ctrl_update_current(void)
-{
-	speculation_ctrl_update(current_thread_info()->flags);
-}
+extern void speculation_ctrl_update_current(void);
 
 #endif
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -84,6 +84,7 @@ struct thread_info {
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SECCOMP		8	/* secure computing */
 #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
+#define TIF_SPEC_FORCE_UPDATE	10	/* Force speculation MSR update in context switch */
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
 #define TIF_UPROBE		12	/* breakpointed or singlestepping */
 #define TIF_PATCH_PENDING	13	/* pending live patching update */
@@ -112,6 +113,7 @@ struct thread_info {
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
+#define _TIF_SPEC_FORCE_UPDATE	(1 << TIF_SPEC_FORCE_UPDATE)
 #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
@@ -149,7 +151,7 @@ struct thread_info {
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW_BASE						\
 	(_TIF_IO_BITMAP|_TIF_NOCPUID|_TIF_NOTSC|_TIF_BLOCKSTEP|		\
-	 _TIF_SSBD)
+	 _TIF_SSBD | _TIF_SPEC_FORCE_UPDATE)
 
 /*
  * Avoid calls to __switch_to_xtra() on UP as STIBP is not evaluated.
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -756,14 +756,10 @@ static void ssb_select_mitigation(void)
 #undef pr_fmt
 #define pr_fmt(fmt)     "Speculation prctl: " fmt
 
-static void task_update_spec_tif(struct task_struct *tsk, int tifbit, bool on)
+static void task_update_spec_tif(struct task_struct *tsk)
 {
-	bool update;
-
-	if (on)
-		update = !test_and_set_tsk_thread_flag(tsk, tifbit);
-	else
-		update = test_and_clear_tsk_thread_flag(tsk, tifbit);
+	/* Force the update of the real TIF bits */
+	set_tsk_thread_flag(tsk, TIF_SPEC_FORCE_UPDATE);
 
 	/*
 	 * Immediately update the speculation control MSRs for the current
@@ -773,7 +769,7 @@ static void task_update_spec_tif(struct
 	 * This can only happen for SECCOMP mitigation. For PRCTL it's
 	 * always the current task.
 	 */
-	if (tsk == current && update)
+	if (tsk == current)
 		speculation_ctrl_update_current();
 }
 
@@ -789,16 +785,16 @@ static int ssb_prctl_set(struct task_str
 		if (task_spec_ssb_force_disable(task))
 			return -EPERM;
 		task_clear_spec_ssb_disable(task);
-		task_update_spec_tif(task, TIF_SSBD, false);
+		task_update_spec_tif(task);
 		break;
 	case PR_SPEC_DISABLE:
 		task_set_spec_ssb_disable(task);
-		task_update_spec_tif(task, TIF_SSBD, true);
+		task_update_spec_tif(task);
 		break;
 	case PR_SPEC_FORCE_DISABLE:
 		task_set_spec_ssb_disable(task);
 		task_set_spec_ssb_force_disable(task);
-		task_update_spec_tif(task, TIF_SSBD, true);
+		task_update_spec_tif(task);
 		break;
 	default:
 		return -ERANGE;
@@ -819,7 +815,7 @@ static int ib_prctl_set(struct task_stru
 		if (spectre_v2_user == SPECTRE_V2_USER_STRICT)
 			return -EPERM;
 		task_clear_spec_ib_disable(task);
-		task_update_spec_tif(task, TIF_SPEC_IB, false);
+		task_update_spec_tif(task);
 		break;
 	case PR_SPEC_DISABLE:
 	case PR_SPEC_FORCE_DISABLE:
@@ -834,7 +830,7 @@ static int ib_prctl_set(struct task_stru
 		task_set_spec_ib_disable(task);
 		if (ctrl == PR_SPEC_FORCE_DISABLE)
 			task_set_spec_ib_force_disable(task);
-		task_update_spec_tif(task, TIF_SPEC_IB, true);
+		task_update_spec_tif(task);
 		break;
 	default:
 		return -ERANGE;
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -458,6 +458,23 @@ static __always_inline void __speculatio
 		spec_ctrl_update_msr(tifn);
 }
 
+static unsigned long speculation_ctrl_update_tif(struct task_struct *tsk)
+{
+	if (test_and_clear_tsk_thread_flag(tsk, TIF_SPEC_FORCE_UPDATE)) {
+		if (task_spec_ssb_disable(tsk))
+			set_tsk_thread_flag(tsk, TIF_SSBD);
+		else
+			clear_tsk_thread_flag(tsk, TIF_SSBD);
+
+		if (task_spec_ib_disable(tsk))
+			set_tsk_thread_flag(tsk, TIF_SPEC_IB);
+		else
+			clear_tsk_thread_flag(tsk, TIF_SPEC_IB);
+	}
+	/* Return the updated threadinfo flags*/
+	return task_thread_info(tsk)->flags;
+}
+
 void speculation_ctrl_update(unsigned long tif)
 {
 	/* Forced update. Make sure all relevant TIF flags are different */
@@ -466,6 +483,11 @@ void speculation_ctrl_update(unsigned lo
 	preempt_enable();
 }
 
+void speculation_ctrl_update_current(void)
+{
+	speculation_ctrl_update(speculation_ctrl_update_tif(current));
+}
+
 void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
 {
 	struct thread_struct *prev, *next;
@@ -497,6 +519,11 @@ void __switch_to_xtra(struct task_struct
 	if ((tifp ^ tifn) & _TIF_NOCPUID)
 		set_cpuid_faulting(!!(tifn & _TIF_NOCPUID));
 
+	if (unlikely((tifp | tifn) & _TIF_SPEC_FORCE_UPDATE)) {
+		tifp = speculation_ctrl_update_tif(prev_p);
+		tifn = speculation_ctrl_update_tif(next_p);
+	}
+
 	__speculation_ctrl_update(tifp, tifn);
 }
 
