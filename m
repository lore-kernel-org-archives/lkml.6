Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id p2E1G2KMHlu+cAAAmS7hNA
	; Mon, 11 Jun 2018 14:51:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 60643607E4; Mon, 11 Jun 2018 14:51:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9412360792;
	Mon, 11 Jun 2018 14:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9412360792
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932594AbeFKOvL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:51:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37350 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932484AbeFKOvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:51:07 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fSO9x-0006Dc-Pt; Mon, 11 Jun 2018 16:51:05 +0200
Date: Mon, 11 Jun 2018 16:51:05 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: tglx@linutronix.de, Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] posix-cpu-timers: remove lockdep_assert_irqs_disabled()
Message-ID: <20180611145105.mm4b223szxxkqjmy@linutronix.de>
References: <20180504152548.7166-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180504152548.7166-1-bigeasy@linutronix.de>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-04 17:25:48 [+0200], To linux-kernel@vger.kernel.org wrote:
> The lockdep_assert_irqs_disabled() was a BUG_ON() statement in the
> beginning and it was added just before the "spin_lock(siglock)"
> statement to ensure this lock was taken with disabled interrupts.
> This is no longer the case: the siglock is acquired via
> lock_task_sighand() and this function already disables the interrupts.
> The lock is also acquired before this "lockdep_assert_irqs_disabled" so
> it is beset to remove it.

*ping*

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/time/posix-cpu-timers.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
> index 2541bd89f20e..d4f54df9c9fa 100644
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -604,7 +604,6 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
>  	/*
>  	 * Disarm any old timer after extracting its expiry time.
>  	 */
> -	lockdep_assert_irqs_disabled();
>  
>  	ret = 0;
>  	old_incr = timer->it.cpu.incr;
> @@ -1049,7 +1048,6 @@ static void posix_cpu_timer_rearm(struct k_itimer *timer)
>  	/*
>  	 * Now re-arm for the new expiry time.
>  	 */
> -	lockdep_assert_irqs_disabled();
>  	arm_timer(timer);
>  unlock:
>  	unlock_task_sighand(p, &flags);
> -- 
> 2.17.0
