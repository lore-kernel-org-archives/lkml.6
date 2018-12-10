Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399CEC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0F72082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0F72082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbeLJP1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:27:53 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:33620 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbeLJP1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:27:53 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gWNTK-0006I9-Vi; Mon, 10 Dec 2018 16:27:51 +0100
Message-Id: <20181210152311.986181245@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 10 Dec 2018 16:23:06 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stefan Liebler <stli@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [patch] futex: Cure exit race
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan reported, that the glibc tst-robustpi4 test case fails
occasionally. That case creates the following race between
sys_exit() and sys_futex(LOCK_PI):

 CPU0				CPU1

 sys_exit()			sys_futex()
  do_exit()			 futex_lock_pi()
   exit_signals(tsk)		  No waiters:
    tsk->flags |= PF_EXITING;	  *uaddr == 0x00000PID
  mm_release(tsk)		  Set waiter bit
   exit_robust_list(tsk) {	  *uaddr = 0x80000PID;
      Set owner died		  attach_to_pi_owner() {
    *uaddr = 0xC0000000;	   tsk = get_task(PID);
   }				   if (!tsk->flags & PF_EXITING) {
  ...				     attach();
  tsk->flags |= PF_EXITPIDONE;	   } else {
				     if (!(tsk->flags & PF_EXITPIDONE))
				       return -EAGAIN;
				     return -ESRCH; <--- FAIL
				   }

ESRCH is returned all the way to user space, which triggers the glibc test
case assert. Returning ESRCH unconditionally is wrong here because the user
space value has been changed by the exiting task to 0xC0000000, i.e. the
FUTEX_OWNER_DIED bit is set and the futex PID value has been cleared. This
is a valid state and the kernel has to handle it, i.e. taking the futex.

Cure it by rereading the user space value when PF_EXITING and PF_EXITPIDONE
is set in the task which owns the futex. If the value has changed, let
the kernel retry the operation, which includes all regular sanity checks
and correctly handles the FUTEX_OWNER_DIED case.

If it hasn't changed, then return ESRCH as there is no way to distinguish
this case from malfunctioning user space. This happens when the exiting
task did not have a robust list, the robust list was corrupted or the user
space value in the futex was simply bogus.

Reported-by: Stefan Liebler <stli@linux.ibm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=200467
---
 kernel/futex.c |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 4 deletions(-)

--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1148,11 +1148,60 @@ static int attach_to_pi_state(u32 __user
 	return ret;
 }
 
+static int handle_exit_race(u32 __user *uaddr, u32 uval, struct task_struct *tsk)
+{
+	u32 uval2;
+
+	/*
+	 * If PF_EXITPIDONE is not yet set try again.
+	 */
+	if (!(tsk->flags & PF_EXITPIDONE))
+		return -EAGAIN;
+
+	/*
+	 * Reread the user space value to handle the following situation:
+	 *
+	 * CPU0				CPU1
+	 *
+	 * sys_exit()			sys_futex()
+	 *  do_exit()			 futex_lock_pi()
+	 *   exit_signals(tsk)		  No waiters:
+	 *    tsk->flags |= PF_EXITING;	  *uaddr == 0x00000PID
+	 *  mm_release(tsk)		  Set waiter bit
+	 *   exit_robust_list(tsk) {	  *uaddr = 0x80000PID;
+	 *      Set owner died		  attach_to_pi_owner() {
+	 *    *uaddr = 0xC0000000;	   tsk = get_task(PID);
+	 *   }				   if (!tsk->flags & PF_EXITING) {
+	 *  ...				     attach();
+	 *  tsk->flags |= PF_EXITPIDONE;   } else {
+	 *				     if (!(tsk->flags & PF_EXITPIDONE))
+	 *				       return -EAGAIN;
+	 *				     return -ESRCH; <--- FAIL
+	 *				   }
+	 *
+	 * Returning ESRCH unconditionally is wrong here because the
+	 * user space value has been changed by the exiting task.
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
@@ -1187,7 +1236,7 @@ static int attach_to_pi_owner(u32 uval,
 		 * set, we know that the task has finished the
 		 * cleanup:
 		 */
-		int ret = (p->flags & PF_EXITPIDONE) ? -ESRCH : -EAGAIN;
+		int ret = handle_exit_race(uaddr, uval, p);
 
 		raw_spin_unlock_irq(&p->pi_lock);
 		put_task_struct(p);
@@ -1244,7 +1293,7 @@ static int lookup_pi_state(u32 __user *u
 	 * We are the first waiter - try to look up the owner based on
 	 * @uval and attach to it.
 	 */
-	return attach_to_pi_owner(uval, key, ps);
+	return attach_to_pi_owner(uaddr, uval, key, ps);
 }
 
 static int lock_pi_update_atomic(u32 __user *uaddr, u32 uval, u32 newval)
@@ -1352,7 +1401,7 @@ static int futex_lock_pi_atomic(u32 __us
 	 * attach to the owner. If that fails, no harm done, we only
 	 * set the FUTEX_WAITERS bit in the user space variable.
 	 */
-	return attach_to_pi_owner(uval, key, ps);
+	return attach_to_pi_owner(uaddr, uval, key, ps);
 }
 
 /**


