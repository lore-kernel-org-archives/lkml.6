Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F78C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0298A20844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0298A20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732498AbeGaRWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:22:12 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60020 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732268AbeGaRWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:22:12 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fkWlg-00071U-DQ; Tue, 31 Jul 2018 17:41:01 +0200
Date:   Tue, 31 Jul 2018 17:41:00 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Gaurav Kohli <gkohli@codeaurora.org>
cc:     John Stultz <john.stultz@linaro.org>, sboyd@kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] timers: Clear must_forward_clk inside base lock
In-Reply-To: <1532594522-28045-1-git-send-email-gkohli@codeaurora.org>
Message-ID: <alpine.DEB.2.21.1807311645490.1610@nanos.tec.linutronix.de>
References: <1532594522-28045-1-git-send-email-gkohli@codeaurora.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gaurav,

On Thu, 26 Jul 2018, Gaurav Kohli wrote:

> While migrating timer to new base, there is a need
> to update base clk by calling forward_timer_base to
> avoid stale clock , but at the same time if run_timer
> is exectuing in new core it may set must_forward_clk
> to false and due to this forward base logic may fail as
> per below check:
> 
> if (likely(!base->must_forward_clk))
>                 return;

After twisting my brain for a while I can understand what you are trying to
say, but please look at your own sentence once again. One sentence spawning
6 lines with a really convoluted structure and then you spend 3 lines to
copy a code snippet which is really not helpful.

Please try to structure the description and use a simple table to show the
race, e.g.:

  base->must_forward_clock is indicating that the base clock might be stale
  due to a long idle sleep. The forwarding takes either place in the timer
  softirq or when a timer is enqueued while the base is idle. If the
  enqueue to an idle base happens from a remote CPU then the following race
  can happen:

  CPU0					CPU1

  run_timer_softirq()			mod_timer(timer)
    base->must_forward_clk = false;	  base = lock_base(timer);
    __run_timers(base)	     		  if (base->must_forward_clk)
    					     forward(base);
      lock(base->lock);
					  queue_timer(base, timer);
      					  ^^^ Based on stale base->clk
					  
      					  unlock(base);
      forward(base);					  

  The root cause is that base->must_forward_clk is cleared outside the
  base->lock held region, so the remote queueing CPU observes it as
  cleared, but the base clock is still stale. This can cause large
  granularity values for timers, i.e. the accuracy of the expiry time
  suffers.

  Prevent this by clearing the flag with base->lock held, so that the
  forwarding takes place before the cleared flag is observable by a remote
  CPU.

Can you see the difference?

>  	raw_spin_lock_irq(&base->lock);
>  
> +	/*
> +	 * must_forward_clk must be cleared before running timers so that any
> +	 * timer functions that call mod_timer will not try to forward the
> +	 * base. idle trcking / clock forwarding logic is only used with

I know that the 'trcking' typo was in the original comment, but it does not
make anything better if you just blindly move it.

> +	 * BASE_STD timers.
> +	 *
> +	 * The deferrable base does not do idle tracking at all, so we do
> +	 * not forward it. This can result in very large variations in
> +	 * granularity for deferrable timers, but they can be deferred for
> +	 * long periods due to idle.

This part of the comment is still correct, but now it's also confusing
because the flag is cleared for _ALL_ bases and not only for BASE_STD. So
at least you want to change that to something like this:

   	 * The must_forward_clk flag is cleared unconditionally also for
         * the deferrable base. The deferrable base is not affected by idle
         * tracking and never forwarded, so clearing the flag is a NOOP.
	 *
	 * The fact that the deferrable base is never forwarded can cause
         * large varations in granularity for deferrable timers, but they
         * can be deferred for long periods due to idle anyway.

See? If you move a comment you really have to think about whether it is
still correct. If not, then you have to adjust it so it makes sense and not
just move it blindly around and be done with it. Think about yourself
looking at that code in a year from now when you forgot all the gory
details already.

Thanks,

	tglx


