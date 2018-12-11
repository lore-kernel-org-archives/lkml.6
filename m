Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F898C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F92220811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F92220811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbeLKKcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:32:53 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:37760 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbeLKKcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:32:52 -0500
Received: from [88.128.81.80] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gWfLL-0000qh-L7; Tue, 11 Dec 2018 11:32:48 +0100
Date:   Tue, 11 Dec 2018 11:32:29 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Stefan Liebler <stli@linux.ibm.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [patch] futex: Cure exit race
In-Reply-To: <06e7e269-6c87-f5f2-9a15-435b0a376105@linux.ibm.com>
Message-ID: <alpine.DEB.2.21.1812111108350.3075@nanos.tec.linutronix.de>
References: <20181210152311.986181245@linutronix.de> <06e7e269-6c87-f5f2-9a15-435b0a376105@linux.ibm.com>
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

Stefan,

On Tue, 11 Dec 2018, Stefan Liebler wrote:
> does this also handle the ESRCH returned by
> attach_to_pi_owner(...)
> {...
> 	if (!pid)
> 		return -ESRCH;
> 	p = find_get_task_by_vpid(pid);
> 	if (!p)
> 		return -ESRCH;
> ...
> 
> I think pid should never be zero when attach_to_pi_owner is called.

Yeah, I just checked again. It's a paranoid check.

> But it can happen that p is null? At least I traced the "return -ESRCH" with
> the 4.17 kernel. Unfortunately both returns were done by the same instruction
> address.

Yes, you are right. We need the same sanity check for that part. Updated
patch below.

Now I "just" have to come up with a cure for that livelock thing ....

Thanks,

	tglx

8<--------------
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1148,11 +1148,65 @@ static int attach_to_pi_state(u32 __user
 	return ret;
 }
 
+static int handle_exit_race(u32 __user *uaddr, u32 uval,
+			    struct task_struct *tsk)
+{
+	u32 uval2;
+
+	/*
+	 * If PF_EXITPIDONE is not yet set, then try again.
+	 */
+	if (tsk && !(tsk->flags & PF_EXITPIDONE))
+		return -EAGAIN;
+
+	/*
+	 * Reread the user space value to handle the following situation:
+	 *
+	 * CPU0				CPU1
+	 *
+	 * sys_exit()			sys_futex()
+	 *  do_exit()			 futex_lock_pi()
+	 *                                futex_lock_pi_atomic()
+	 *   exit_signals(tsk)		    No waiters:
+	 *    tsk->flags |= PF_EXITING;	    *uaddr == 0x00000PID
+	 *  mm_release(tsk)		    Set waiter bit
+	 *   exit_robust_list(tsk) {	    *uaddr = 0x80000PID;
+	 *      Set owner died		    attach_to_pi_owner() {
+	 *    *uaddr = 0xC0000000;	     tsk = get_task(PID);
+	 *   }				     if (!tsk->flags & PF_EXITING) {
+	 *  ...				       attach();
+	 *  tsk->flags |= PF_EXITPIDONE;     } else {
+	 *				       if (!(tsk->flags & PF_EXITPIDONE))
+	 *				         return -EAGAIN;
+	 *				       return -ESRCH; <--- FAIL
+	 *				     }
+	 *
+	 * Returning ESRCH unconditionally is wrong here because the
+	 * user space value has been changed by the exiting task.
+	 *
+	 * The same logic applies to the case where the exiting task is
+	 * already gone.
+	 */
+	if (get_futex_value_locked(&uval2, uaddr))
+		return -EFAULT;
+
+	/* If the user space value has changed, try again. */
+	if (uval2 != uval)
+		return -EAGAIN;
+
+	/*
+	 * The exiting task did not have a robust list, the robust list was
+	 * corrupted or the user space value in *uaddr is simply bogus.
+	 * Give up and tell user space.
+	 */
+	return -ESRCH;
+}
+
 /*
  * Lookup the task for the TID provided from user space and attach to
  * it after doing proper sanity checks.
  */
-static int attach_to_pi_owner(u32 uval, union futex_key *key,
+static int attach_to_pi_owner(u32 __user *uaddr, u32 uval, union futex_key *key,
 			      struct futex_pi_state **ps)
 {
 	pid_t pid = uval & FUTEX_TID_MASK;
@@ -1162,12 +1216,15 @@ static int attach_to_pi_owner(u32 uval,
 	/*
 	 * We are the first waiter - try to look up the real owner and attach
 	 * the new pi_state to it, but bail out when TID = 0 [1]
+	 *
+	 * The !pid check is paranoid. None of the call sites should end up
+	 * with pid == 0, but better safe than sorry. Let the caller retry
 	 */
 	if (!pid)
-		return -ESRCH;
+		return -EAGAIN;
 	p = find_get_task_by_vpid(pid);
 	if (!p)
-		return -ESRCH;
+		return handle_exit_race(uaddr, uval, NULL);
 
 	if (unlikely(p->flags & PF_KTHREAD)) {
 		put_task_struct(p);
@@ -1187,7 +1244,7 @@ static int attach_to_pi_owner(u32 uval,
 		 * set, we know that the task has finished the
 		 * cleanup:
 		 */
-		int ret = (p->flags & PF_EXITPIDONE) ? -ESRCH : -EAGAIN;
+		int ret = handle_exit_race(uaddr, uval, p);
 
 		raw_spin_unlock_irq(&p->pi_lock);
 		put_task_struct(p);
@@ -1244,7 +1301,7 @@ static int lookup_pi_state(u32 __user *u
 	 * We are the first waiter - try to look up the owner based on
 	 * @uval and attach to it.
 	 */
-	return attach_to_pi_owner(uval, key, ps);
+	return attach_to_pi_owner(uaddr, uval, key, ps);
 }
 
 static int lock_pi_update_atomic(u32 __user *uaddr, u32 uval, u32 newval)
@@ -1352,7 +1409,7 @@ static int futex_lock_pi_atomic(u32 __us
 	 * attach to the owner. If that fails, no harm done, we only
 	 * set the FUTEX_WAITERS bit in the user space variable.
 	 */
-	return attach_to_pi_owner(uval, key, ps);
+	return attach_to_pi_owner(uaddr, newval, key, ps);
 }
 
 /**
