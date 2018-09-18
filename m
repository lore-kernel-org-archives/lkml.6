Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67FEECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8C221471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8C221471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbeISClt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 22:41:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58861 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbeISClt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 22:41:49 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g2NDO-0003Rg-AX; Tue, 18 Sep 2018 23:07:22 +0200
Date:   Tue, 18 Sep 2018 23:07:21 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Waiman Long <longman@redhat.com>
cc:     John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] clocksource: Warn if too many missing ticks are
 detected
In-Reply-To: <1537295774-17975-1-git-send-email-longman@redhat.com>
Message-ID: <alpine.DEB.2.21.1809182259110.1468@nanos.tec.linutronix.de>
References: <1537295774-17975-1-git-send-email-longman@redhat.com>
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

Waiman,

On Tue, 18 Sep 2018, Waiman Long wrote:

> The clocksource watchdog, when running, is scheduled on all the CPUs in
> the system sequentially on a round-robin fashion with a period of 0.5s.
> A bug in the 4.18 kernel is causing missing ticks when nohz_full
> is specified. Under some circumstances, this causes the watchdog to
> incorrectly state that the TSC is unstable because of counter overflow
> in the hpet watchdog clock source after a few minutes delay.
> 
> That particular bug is fixed by the 4.19 commit 7059b36636beab ("sched:
> idle: Avoid retaining the tick when it has been stopped"). To make it
> easier to catch this kind of bug in the future, a check is added to see
> if there is too much delay in the watchdog invocation and print a
> warning once if it happens.

I like the idea.

> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/time/clocksource.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index 0e6e97a..2ea5db0 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -140,6 +140,7 @@ static void inline clocksource_watchdog_unlock(unsigned long *flags)
>   * Interval: 0.5sec Threshold: 0.0625s
>   */
>  #define WATCHDOG_INTERVAL (HZ >> 1)
> +#define WATCHDOG_INTERNVAL_NS (NSEC_PER_SEC >> 1)
>  #define WATCHDOG_THRESHOLD (NSEC_PER_SEC >> 4)
>  
>  static void clocksource_watchdog_work(struct work_struct *work)
> @@ -242,6 +243,18 @@ static void clocksource_watchdog(struct timer_list *unused)
>  		wd_nsec = clocksource_cyc2ns(delta, watchdog->mult,
>  					     watchdog->shift);
>  
> +		/*
> +		 * When the timer tick is incorrectly stopped on a CPU with
> +		 * pending events, for example, it is possible that the
> +		 * clocksource watchdog will stop running for a sufficiently
> +		 * long enough time to cause overflow in the delta
> +		 * computation leading to incorrect report of unstable clock
> +		 * source. So print a warning if there is unusually large
> +		 * delay (> 0.5s) in the invocation of the watchdog. That
> +		 * can indicate a hidden bug in the timer tick code.
> +		 */
> +		WARN_ON_ONCE(!wd_nsec || wd_nsec > 2*WATCHDOG_INTERNVAL_NS);

But this is using the watchdog delta to check. If that wrapped the
detection is broken.

I'd rather use watchdog_timer.expires and check against jiffies. That tells
you how late the timer callback actually is and does not suffer any
wraparound issues.

Thanks,

	tglx


