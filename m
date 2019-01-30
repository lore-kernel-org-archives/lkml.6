Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41181C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C41C20869
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731956AbfA3R5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:57:21 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48007 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfA3R5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:57:21 -0500
Received: from [2a01:598:b890:92b7:20d0:59ff:fe6e:bab9] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gou6q-00074b-JD; Wed, 30 Jan 2019 18:57:12 +0100
Date:   Wed, 30 Jan 2019 18:56:54 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sebastian Sewior <bigeasy@linutronix.de>
cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org,
        Stefan Liebler <stli@linux.ibm.com>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggered
In-Reply-To: <alpine.DEB.2.21.1901301517220.1950@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1901301853290.1622@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1901291012330.1669@nanos.tec.linutronix.de> <20190129102409.GB26906@osiris> <20190129103557.GF28485@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1901291402410.1513@nanos.tec.linutronix.de> <20190129132303.GE26906@osiris>
 <20190129151058.GG26906@osiris> <20190129171653.ycl64psq2liy5o5c@linutronix.de> <20190130094913.GC5299@osiris> <alpine.DEB.2.21.1901301303320.5537@nanos.tec.linutronix.de> <20190130125955.GD5299@osiris> <20190130132420.spwrq2d4oxeydk5s@linutronix.de>
 <alpine.DEB.2.21.1901301428390.5537@nanos.tec.linutronix.de> <alpine.DEB.2.21.1901301517220.1950@nanos.tec.linutronix.de>
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

On Wed, 30 Jan 2019, Thomas Gleixner wrote:
> On Wed, 30 Jan 2019, Thomas Gleixner wrote:
> The last entries with that uaddr are:
> 
>           <...>-56956 [005] ....   658.923608: sys_futex(uaddr: 3ff9e880140, op: 7, val: 3ff00000007, utime: 3ff9b078910, uaddr2: 3ff9b078910, val3: 3ffea67e3f7)
> 
> UNLOCK
> 
>            <...>-56945 [006] ....   658.923612: sys_futex(uaddr: 3ff9e880140, op: 6, val: 1, utime: 1003ff0, uaddr2: 3ff9e87f910, val3: 3ff0000de71)
> 
> LOCK
> 
>            <...>-56956 [005] ....   658.923612: sys_futex(uaddr: 3ff9e880140, op: 7, val: 3ff00000007, utime: 3ff9b078910, uaddr2: 3ff9b078910, val3: 3ffea67e3f7)
> 
> UNLOCK
> 
>            <...>-56945 [006] ....   658.923830: sys_futex(uaddr: 3ff9e880140, op: 7, val: 3ff00000007, utime: 3ff9e87f910, uaddr2: 3ff9e87f910, val3: 3ffea67e3f7)
> 
> UNLOCK
> 
>            <...>-56496 [001] ....   658.932404: sys_futex(uaddr: 3ff9e880140, op: 6, val: 1, utime: 0, uaddr2: 5, val3: 0)
> 
> LOCK which fails.
> 
> This does not make any sense. The last kernel visible operation of 56956 on
> that uaddr is the UNLOCK above.
> 
> I need to think some more about what might happen.

TBH, no clue. Below are some more traceprintks which hopefully shed some
light on that mystery. See kernel/futex.c line 30  ...

Thanks,

	tglx
8<--------------
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1502,6 +1502,8 @@ static int wake_futex_pi(u32 __user *uad
 	 * died bit, because we are the owner.
 	 */
 	newval = FUTEX_WAITERS | task_pid_vnr(new_owner);
+	trace_printk("uaddr: %lx cur: %x new: %x\n",
+		     (unsigned long) uaddr, uval, newval);
 
 	if (unlikely(should_fail_futex(true)))
 		ret = -EFAULT;
@@ -2431,6 +2433,8 @@ static int fixup_pi_state_owner(u32 __us
 	for (;;) {
 		newval = (uval & FUTEX_OWNER_DIED) | newtid;
 
+		trace_printk("uaddr: %lx cur: %x new: %x\n",
+			     (unsigned long) uaddr, uval, newval);
 		if (cmpxchg_futex_value_locked(&curval, uaddr, uval, newval))
 			goto handle_fault;
 		if (curval == uval)
@@ -2438,6 +2442,8 @@ static int fixup_pi_state_owner(u32 __us
 		uval = curval;
 	}
 
+	trace_printk("uaddr: %lx cur: %x new: %x\n",
+		     (unsigned long) uaddr, uval, newval);
 	/*
 	 * We fixed up user space. Now we need to fix the pi_state
 	 * itself.
@@ -3028,6 +3034,9 @@ static int futex_unlock_pi(u32 __user *u
 		/* drops pi_state->pi_mutex.wait_lock */
 		ret = wake_futex_pi(uaddr, uval, pi_state);
 
+		trace_printk("uaddr: %lx wake: %d\n",
+			     (unsigned long) uaddr, ret);
+
 		put_pi_state(pi_state);
 
 		/*
@@ -3056,6 +3065,8 @@ static int futex_unlock_pi(u32 __user *u
 		goto out_putkey;
 	}
 
+	trace_printk("uaddr: %lx cur: %x new: %x\n",
+		     (unsigned long) uaddr, uval, 0);
 	/*
 	 * We have no kernel internal state, i.e. no waiters in the
 	 * kernel. Waiters which are about to queue themselves are stuck
