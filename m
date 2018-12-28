Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A27C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CE92184B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999259;
	bh=1cYqyky9dOgmZ7VT29GIRyh/vX4nMx9qZ5bHxHep8ZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S1e3SFLHTLz2uPv96J0y/+/SDOVmdihnD4SFrAsTI6ILoFAbM6mIRd5xvijZqUMEf
	 76TIN5FxJYgL2PIcHaefRwq2EHKBrvDzAv7H6JtAggI1mkHuNakgidokmlfyT51azK
	 G2ksQ4Hw7W8bwVk+alm+XRZvLVObBzzCNYx4PLjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbeL1MOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:14:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:33028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbeL1MOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:14:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBA6C20866;
        Fri, 28 Dec 2018 12:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999256;
        bh=1cYqyky9dOgmZ7VT29GIRyh/vX4nMx9qZ5bHxHep8ZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a9Liq3MLEg0bUc15sDlTK9Tb5JwLfM8w2LY7rfmcplET3846TNbvDe4CvsDBsS4d6
         lFIq4fN66Z/O6vdlewy7V+ctyADCtWv25U9Jt1eV+OScldoGXfs985YtSu9qmogTKK
         0GGNo42lel8flLYw0b9IFHQlcPoMKJUoVHobCMuU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Liebler <stli@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Darren Hart <dvhart@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 25/46] futex: Cure exit race
Date:   Fri, 28 Dec 2018 12:52:19 +0100
Message-Id: <20181228113126.253595860@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113124.971620049@linuxfoundation.org>
References: <20181228113124.971620049@linuxfoundation.org>
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

From: Thomas Gleixner <tglx@linutronix.de>

commit da791a667536bf8322042e38ca85d55a78d3c273 upstream.

Stefan reported, that the glibc tst-robustpi4 test case fails
occasionally. That case creates the following race between
sys_exit() and sys_futex_lock_pi():

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
is set in the task which 'owns' the futex. If the value has changed, let
the kernel retry the operation, which includes all regular sanity checks
and correctly handles the FUTEX_OWNER_DIED case.

If it hasn't changed, then return ESRCH as there is no way to distinguish
this case from malfunctioning user space. This happens when the exiting
task did not have a robust list, the robust list was corrupted or the user
space value in the futex was simply bogus.

Reported-by: Stefan Liebler <stli@linux.ibm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=200467
Link: https://lkml.kernel.org/r/20181210152311.986181245@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/futex.c |   69 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 63 insertions(+), 6 deletions(-)

--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1148,11 +1148,65 @@ out_error:
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


