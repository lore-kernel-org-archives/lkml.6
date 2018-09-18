Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DC7C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2B52133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD2B52133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbeISDlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:41:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59005 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbeISDlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 23:41:31 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g2O8x-0004td-Ev; Wed, 19 Sep 2018 00:06:51 +0200
Date:   Wed, 19 Sep 2018 00:06:51 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Waiman Long <longman@redhat.com>
cc:     John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] clocksource: Warn if too many missing ticks are
 detected
In-Reply-To: <5afd698b-2337-71ef-f118-7395c7991922@redhat.com>
Message-ID: <alpine.DEB.2.21.1809190004100.1468@nanos.tec.linutronix.de>
References: <1537295774-17975-1-git-send-email-longman@redhat.com> <alpine.DEB.2.21.1809182259110.1468@nanos.tec.linutronix.de> <5afd698b-2337-71ef-f118-7395c7991922@redhat.com>
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

On Tue, 18 Sep 2018, Waiman Long wrote:
> On 09/18/2018 05:07 PM, Thomas Gleixner wrote:
> > On Tue, 18 Sep 2018, Waiman Long wrote:
> >> --- a/kernel/time/clocksource.c
> >> +++ b/kernel/time/clocksource.c
> >> @@ -140,6 +140,7 @@ static void inline clocksource_watchdog_unlock(unsigned long *flags)
> >>   * Interval: 0.5sec Threshold: 0.0625s
> >>   */
> >>  #define WATCHDOG_INTERVAL (HZ >> 1)
> >> +#define WATCHDOG_INTERNVAL_NS (NSEC_PER_SEC >> 1)
> >>  #define WATCHDOG_THRESHOLD (NSEC_PER_SEC >> 4)
> >>  
> >>  static void clocksource_watchdog_work(struct work_struct *work)
> >> @@ -242,6 +243,18 @@ static void clocksource_watchdog(struct timer_list *unused)
> >>  		wd_nsec = clocksource_cyc2ns(delta, watchdog->mult,
> >>  					     watchdog->shift);
> >>  
> >> +		/*
> >> +		 * When the timer tick is incorrectly stopped on a CPU with
> >> +		 * pending events, for example, it is possible that the
> >> +		 * clocksource watchdog will stop running for a sufficiently
> >> +		 * long enough time to cause overflow in the delta
> >> +		 * computation leading to incorrect report of unstable clock
> >> +		 * source. So print a warning if there is unusually large
> >> +		 * delay (> 0.5s) in the invocation of the watchdog. That
> >> +		 * can indicate a hidden bug in the timer tick code.
> >> +		 */
> >> +		WARN_ON_ONCE(!wd_nsec || wd_nsec > 2*WATCHDOG_INTERNVAL_NS);
> > But this is using the watchdog delta to check. If that wrapped the
> > detection is broken.
> >
> > I'd rather use watchdog_timer.expires and check against jiffies. That tells
> > you how late the timer callback actually is and does not suffer any
> > wraparound issues.
> 
> The clocksource_delta() function will deal with wrap-around in the
> counter value. It is only when the counter advances more than 0x80000000
> for 32-bit hpet counter mask that a value of 0 will be returned. That is
> why I have a !wd_nsec check there. There is a small chance when the
> warparound is just within the 1 second window that the test fails. In
> this case, the following kind of warning will certainly be triggered:

Ok.

> [  578.890937] clocksource: timekeeping watchdog on CPU21: Marking
> clocksource 'tsc' as unstable because the skew is too large:
> [  578.890938] clocksource:                       'hpet' wd_now:
> ee332105 wd_last: 544f80e7 mask: ffffffff
> [  578.890939] clocksource:                       'tsc' cs_now:
> 4b6e6ccb5d609 cs_last: 4b679a469d09e mask: ffffffffffffffff
> [  578.890954] tsc: Marking TSC unstable due to clocksource watchdog
> [  578.890963] TSC found unstable after boot, most likely due to broken
> BIOS. Use 'tsc=unstable'.
> [  578.890965] sched_clock: Marking unstable (578920214163,
> -28725675)<-(579047174801, -156217937)
> [  578.891056] clocksource: Switched to clocksource hpet
> 
> Another reason that I used wd_nsec is because the data has already been
> computed.

Sure, but that's hardly a hotpath.

> I am perfectly fine to use the watchdog_timer.expires as suggested, though.

I really prefer that because it's just more robust and obvious. No head
scratching about correctness required.

Thanks,

	tglx
