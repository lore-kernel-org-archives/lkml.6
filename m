Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3072C67839
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820AF2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XUBVYZVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 820AF2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbeLJQCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:02:15 -0500
Received: from merlin.infradead.org ([205.233.59.134]:59784 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbeLJQCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:02:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4EKVW+hAfSkSgUcESSFHuIL80PpQuXuWr+0DFFQ5DB8=; b=XUBVYZVQhFxRsAy/nSISdnQPI
        ETyGkz8ZGNDq175W6v6gc5/k2VIud+MRFeCqQOD/U+SX253lZPsSPDkuMdTgMOkteuOZ0lwPLl2yc
        0mUBZ1WM0yRBRsutWILKIkEd82Bt9DfNutOmeruKAxhSlRg5aYphQ87f26HPbKLfQzcwKZrLZNiHO
        KpgrqZfxrneD954GNvRbU17poaMOPgV+NWHuFzmIXDuWuYMI8QS5V2xGpijavyzalXJAmQ8toWkaL
        A9YRhZabPDPanldBj4yzfrKs4E2JSv0LUXhvrpQe7bdPVTPv7r0Aek7xRH6C1FwjDuuVcHmS5TaXz
        2QV5N+OpQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWO0V-0004oV-D3; Mon, 10 Dec 2018 16:02:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D714D2075BE71; Mon, 10 Dec 2018 17:02:05 +0100 (CET)
Date:   Mon, 10 Dec 2018 17:02:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stefan Liebler <stli@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Darren Hart <dvhart@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [patch] futex: Cure exit race
Message-ID: <20181210160205.GQ5289@hirez.programming.kicks-ass.net>
References: <20181210152311.986181245@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210152311.986181245@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 04:23:06PM +0100, Thomas Gleixner wrote:

>  kernel/futex.c |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 53 insertions(+), 4 deletions(-)
> 
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -1148,11 +1148,60 @@ static int attach_to_pi_state(u32 __user
>  	return ret;
>  }
>  
> +static int handle_exit_race(u32 __user *uaddr, u32 uval, struct task_struct *tsk)
> +{
> +	u32 uval2;
> +
> +	/*
> +	 * If PF_EXITPIDONE is not yet set try again.
> +	 */
> +	if (!(tsk->flags & PF_EXITPIDONE))
> +		return -EAGAIN;
> +
> +	/*
> +	 * Reread the user space value to handle the following situation:
> +	 *
> +	 * CPU0				CPU1
> +	 *
> +	 * sys_exit()			sys_futex()
> +	 *  do_exit()			 futex_lock_pi()
> +	 *   exit_signals(tsk)		  No waiters:
> +	 *    tsk->flags |= PF_EXITING;	  *uaddr == 0x00000PID
> +	 *  mm_release(tsk)		  Set waiter bit
> +	 *   exit_robust_list(tsk) {	  *uaddr = 0x80000PID;

Just to clarify; this is: sys_futex() <- futex_lock_pi() <-
futex_lock_pi_atomic(), where we do:

  lock_pi_update_atomic(); // changes the futex word
  attach_to_pi_owner(); // possibly returns ESRCH after changing the word


> +	 *      Set owner died		  attach_to_pi_owner() {
> +	 *    *uaddr = 0xC0000000;	   tsk = get_task(PID);
> +	 *   }				   if (!tsk->flags & PF_EXITING) {
> +	 *  ...				     attach();
> +	 *  tsk->flags |= PF_EXITPIDONE;   } else {
> +	 *				     if (!(tsk->flags & PF_EXITPIDONE))
> +	 *				       return -EAGAIN;
> +	 *				     return -ESRCH; <--- FAIL
> +	 *				   }
> +	 *
> +	 * Returning ESRCH unconditionally is wrong here because the
> +	 * user space value has been changed by the exiting task.
> +	 */
> +	if (get_futex_value_locked(&uval2, uaddr))
> +		return -EFAULT;
> +
> +	/* If the user space value has changed, try again. */
> +	if (uval2 != uval)
> +		return -EAGAIN;

And this then goes back to futex_lock_pi(), which does a retry loop.

> +	/*
> +	 * The exiting task did not have a robust list, the robust list was
> +	 * corrupted or the user space value in *uaddr is simply bogus.
> +	 * Give up and tell user space.
> +	 */
> +	return -ESRCH;

If it is unchanged; -ESRCH is a valid return value.

> +}

There is another callers of futex_lock_pi_atomic(),
futex_proxy_trylock_atomic(), which is part of futex_requeue(), that too
does a retry loop on -EAGAIN.

And there is another caller of attach_to_pi_owner(): lookup_pi_state(),
and that too is in futex_requeue() and handles the retry case properly.

Yes, this all looks good.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
