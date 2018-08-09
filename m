Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEB8C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B9B215A5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I57JDLcB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B9B215A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbeHINmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 09:42:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37131 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730673AbeHINmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 09:42:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so4811878wrr.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 04:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h0BxJRg0ZU8+Hj+go9HJ+g3lK1ARBqBXM4Ub8q7BRfo=;
        b=I57JDLcBP2b0TxYK3xgoCb8wVppJlNR5AJAJPkRzTYud172NcxOc4D1y6R7POY//9w
         mIHgSzscngTlyj3BtMcHKdCZs6tS51SHDf/ZiciXJj931QU/rfVx08iWHIhdwq4dJlbb
         HQxDf9vggIRfoQtHlkxe1xlmEvKMGAJIb6ZQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h0BxJRg0ZU8+Hj+go9HJ+g3lK1ARBqBXM4Ub8q7BRfo=;
        b=tvuO6i/wAJiKriXL8RZFV8PH2ApWix3k+SPVe4Huczs2cUd5yH1HrF09pnFSQ9dB6o
         y2iphbEQ89NM2iJL1CjxiXFuHzUQr3cyL9li2oiPYwvL+8F9ZNTd9oAb/BWBTZXuIyTB
         +cNC5xkHKl8hX8RMjSqJforJD1vFmPhcBqpK0SJVXI2uLdkny/k0iqn7AF6hO0ImOGuk
         ofbFNalwBI6h2WV/9/GKdp0m9PgNHnF2ruQ+g1gqTI9AP8Y0gPaOk/tiQ7Es48ykbEAA
         27U/cAwN6ZQCw3ICehEs2SM/0B9YkTA6ivsOHxL0t1DZYK7dp2yshaS2mngvjfZmjfHi
         2G8g==
X-Gm-Message-State: AOUpUlF/4d1Nq/ThB95t8AmuU7+CrFK9FCnW/L/lX9fiYTViJE8pfns2
        r2za5K6YPRs6Q4QslTHyHjlwng==
X-Google-Smtp-Source: AA+uWPyy25BZT8y3RqFLHsc0LSS6Rl1YvK2HBHhUUvy+ZU8ieOccqHiqW3188UFcdKGM333HAGar9g==
X-Received: by 2002:adf:b2a7:: with SMTP id g36-v6mr1151139wrd.218.1533813458318;
        Thu, 09 Aug 2018 04:17:38 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id 68-v6sm9111356wmk.45.2018.08.09.04.17.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 04:17:37 -0700 (PDT)
Date:   Thu, 9 Aug 2018 19:17:26 +0800
From:   leo.yan@linaro.org
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: idle: Reenable sched tick for cpuidle request
Message-ID: <20180809111726.GC14362@leoy-ThinkPad-X240s>
References: <1533793647-5628-1-git-send-email-leo.yan@linaro.org>
 <20180809104549.GS2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809104549.GS2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 12:45:49PM +0200, Peter Zijlstra wrote:
> On Thu, Aug 09, 2018 at 01:47:27PM +0800, Leo Yan wrote:
> > diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> > index 1a3e9bd..802286e 100644
> > --- a/kernel/sched/idle.c
> > +++ b/kernel/sched/idle.c
> > @@ -190,10 +190,18 @@ static void cpuidle_idle_call(void)
> >  		 */
> >  		next_state = cpuidle_select(drv, dev, &stop_tick);
> >  
> > -		if (stop_tick)
> > +		if (stop_tick) {
> >  			tick_nohz_idle_stop_tick();
> > -		else
> > +		} else {
> > +			/*
> > +			 * The cpuidle framework says to not stop tick but
> > +			 * the tick has been stopped yet, so restart it.
> > +			 */
> > +			if (tick_nohz_tick_stopped())
> > +				tick_nohz_idle_restart_tick();
> > +
> 
> I suspect you want an 'else' here. restart_tick already calls
> timer_clear_idle().

No, from the testing I found must call retain_tick, otherwise the
kernel compliants the warning from tick_nohz_idle_exit() when exit
from idle state:

        WARN_ON_ONCE(ts->timer_expires_base);

> >  			tick_nohz_idle_retain_tick();
> > +		}
> >  
> 
> However, I would rather we stuff all this into retain_tick.

Ah, yes; I tested below change and it also have same improvement for
idle state with my preivous change; please review if it's okay?

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index da9455a..fd2bfad 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -962,6 +962,10 @@ void tick_nohz_idle_stop_tick(void)
 
 void tick_nohz_idle_retain_tick(void)
 {
+       /* Restart the tikc if it has been stopped yet. */
+       if (tick_nohz_tick_stopped())
+               tick_nohz_idle_restart_tick();
+
        tick_nohz_retain_tick(this_cpu_ptr(&tick_cpu_sched));
        /*
         * Undo the effect of get_next_timer_interrupt() called from

Thanks,
Leo Yan
