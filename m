Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0732DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867DA2077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fkWF8zDp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867DA2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbeIDSKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 14:10:07 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:40954 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbeIDSKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 14:10:07 -0400
Received: by mail-lj1-f175.google.com with SMTP id j19-v6so3192210ljc.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 06:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D/s6vFcFm1/sDKDSZP6Xii75wDTwwt/WNz86SkndodE=;
        b=fkWF8zDpbFDbZkmh+GwuCbSW4rUbkVyYdDAp2NAd4JZ0l2sJVFI9ZhN3PYTsY4quVN
         nbo/zydbaVLZOxSmdhmFItGS5lKKOnRupvZtO+/M4p2TsW4jNPWO4f4YGpX/ilm9S4EQ
         U+bxtw+zUFISt10QlakxLUjyy9cN1qtnEQbG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D/s6vFcFm1/sDKDSZP6Xii75wDTwwt/WNz86SkndodE=;
        b=rNZoHqZw/6XBD82Z/ZDwKOHZ7OcbkCVRvWutYWitdBNaMlp8Hdo+LL0WQDeqTqPHrq
         lIdsd0rbb9PCXoK3Bsdh0zzT1mK88CBYNInUcdY1AinLDoDVjgSX39HZx2SVSxPM3o8Z
         uRMgolNuIf9X4ugYYyREXsXoDcaudRadEn7FAhASbPrlt3yNvr5KFu3XIjgG2yssDABB
         nMrbV4tg9z0dVB4jpGGMq1Qji0WbyHikvESWX6206tReulCshSEPP3k6Q1EQwKEaxwB1
         1CW7xCx19DFt1tkBQ4gwc6sJ3PSki/YL2J35V8rVGFd8e5CWVZwRBomYOHQZ+WWBl9jv
         nHnA==
X-Gm-Message-State: APzg51DS4cXZ5lbFNV//SMgI2g8ncbN2etM4brXQLLcsuCjXAhqlB7Qi
        yXSDO1Yy/VqHyMi5n79q+1jf8XckdFQ=
X-Google-Smtp-Source: ANB0VdZ/UfPr21q2TTKwPEpy9Z2TDSPZNRypdcnnvLac/eT96oEK1FW2keC87LTm0MDqQPoxbFdmqQ==
X-Received: by 2002:a2e:85d5:: with SMTP id h21-v6mr20429417ljj.103.1536068692820;
        Tue, 04 Sep 2018 06:44:52 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id b22-v6sm3924201ljj.93.2018.09.04.06.44.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 06:44:52 -0700 (PDT)
Date:   Tue, 4 Sep 2018 15:44:50 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Shanahan <kevin@shanahan.id.au>,
        Siegfried Metz <frame@mailbox.org>,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        len.brown@intel.com, rjw@rjwysocki.net, diego.viola@gmail.com,
        rui.zhang@intel.com, viktor_jaegerskuepper@freenet.de
Subject: Re: REGRESSION: boot stalls on several old dual core Intel CPUs
Message-ID: <20180904134450.GA10572@centauri.lan>
References: <74c5abc8-7430-5bc9-2f8a-a2205608bee7@mailbox.org>
 <20180830130439.GM24082@hirez.programming.kicks-ass.net>
 <20180901022125.GO4941@tuon.disenchant.local>
 <20180903072506.GS24124@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1809030937230.1349@nanos.tec.linutronix.de>
 <20180903085423.GU24124@hirez.programming.kicks-ass.net>
 <20180903093305.GC24142@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903093305.GC24142@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 11:33:05AM +0200, Peter Zijlstra wrote:
> On Mon, Sep 03, 2018 at 10:54:23AM +0200, Peter Zijlstra wrote:
> > On Mon, Sep 03, 2018 at 09:38:15AM +0200, Thomas Gleixner wrote:
> > > On Mon, 3 Sep 2018, Peter Zijlstra wrote:
> > > > On Sat, Sep 01, 2018 at 11:51:26AM +0930, Kevin Shanahan wrote:
> > > > > commit 01548f4d3e8e94caf323a4f664eb347fd34a34ab
> > > > > Author: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > > > > Date:   Tue Aug 18 17:09:42 2009 +0200
> > > > > 
> > > > >     clocksource: Avoid clocksource watchdog circular locking dependency
> > > > > 
> > > > >     stop_machine from a multithreaded workqueue is not allowed because
> > > > >     of a circular locking dependency between cpu_down and the workqueue
> > > > >     execution. Use a kernel thread to do the clocksource downgrade.
> > > > 
> > > > I cannot find stop_machine usage there; either it went away or I need to
> > > > like wake up.
> > > 
> > > timekeeping_notify() which is involved in switching clock source uses stomp
> > > machine.
> > 
> > ARGH... OK, lemme see if I can come up with something other than
> > endlessly spawning that kthread.
> > 
> > A special purpose kthread_worker would make more sense than that.
> 
> Can someone test this?
> 
> ---
>  kernel/time/clocksource.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index f74fb00d8064..898976d0082a 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -112,13 +112,28 @@ static int finished_booting;
>  static u64 suspend_start;
>  
>  #ifdef CONFIG_CLOCKSOURCE_WATCHDOG
> -static void clocksource_watchdog_work(struct work_struct *work);
> +static void clocksource_watchdog_work(struct kthread_work *work);
>  static void clocksource_select(void);
>  
>  static LIST_HEAD(watchdog_list);
>  static struct clocksource *watchdog;
>  static struct timer_list watchdog_timer;
> -static DECLARE_WORK(watchdog_work, clocksource_watchdog_work);
> +
> +/*
> + * We must use a kthread_worker here, because:
> + *
> + *   clocksource_watchdog_work()
> + *     clocksource_select()
> + *       __clocksource_select()
> + *         timekeeping_notify()
> + *           stop_machine()
> + *
> + * cannot be called from a reqular workqueue, because of deadlocks between
> + * workqueue and stopmachine.
> + */
> +static struct kthread_worker *watchdog_worker;
> +static DEFINE_KTHREAD_WORK(watchdog_work, clocksource_watchdog_work);
> +
>  static DEFINE_SPINLOCK(watchdog_lock);
>  static int watchdog_running;
>  static atomic_t watchdog_reset_pending;
> @@ -158,7 +173,7 @@ static void __clocksource_unstable(struct clocksource *cs)
>  
>  	/* kick clocksource_watchdog_work() */
>  	if (finished_booting)
> -		schedule_work(&watchdog_work);
> +		kthread_queue_work(watchdog_worker, &watchdog_work);
>  }
>  
>  /**
> @@ -199,7 +214,7 @@ static void clocksource_watchdog(struct timer_list *unused)
>  		/* Clocksource already marked unstable? */
>  		if (cs->flags & CLOCK_SOURCE_UNSTABLE) {
>  			if (finished_booting)
> -				schedule_work(&watchdog_work);
> +				kthread_queue_work(watchdog_worker, &watchdog_work);
>  			continue;
>  		}
>  
> @@ -269,7 +284,7 @@ static void clocksource_watchdog(struct timer_list *unused)
>  			 */
>  			if (cs != curr_clocksource) {
>  				cs->flags |= CLOCK_SOURCE_RESELECT;
> -				schedule_work(&watchdog_work);
> +				kthread_queue_work(watchdog_worker, &watchdog_work);
>  			} else {
>  				tick_clock_notify();
>  			}
> @@ -418,7 +433,7 @@ static int __clocksource_watchdog_work(void)
>  	return select;
>  }
>  
> -static void clocksource_watchdog_work(struct work_struct *work)
> +static void clocksource_watchdog_work(struct kthread_work *work)
>  {
>  	mutex_lock(&clocksource_mutex);
>  	if (__clocksource_watchdog_work())
> @@ -806,6 +821,7 @@ static int __init clocksource_done_booting(void)
>  {
>  	mutex_lock(&clocksource_mutex);
>  	curr_clocksource = clocksource_default_clock();
> +	watchdog_worker = kthread_create_worker(0, "cs-watchdog");

Hello Peter,

watchdog_worker is only defined if CONFIG_CLOCKSOURCE_WATCHDOG is set,
so you might want to wrap it with an ifdef to avoid build errors.

Kind regards,
Niklas

>  	finished_booting = 1;
>  	/*
>  	 * Run the watchdog first to eliminate unstable clock sources
