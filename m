Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DB0C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86BE20862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C86BE20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freenet.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeICP6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 11:58:22 -0400
Received: from mout0.freenet.de ([195.4.92.90]:49842 "EHLO mout0.freenet.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbeICP6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 11:58:21 -0400
X-Greylist: delayed 326 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Sep 2018 11:58:20 EDT
Received: from [195.4.92.164] (helo=mjail1.freenet.de)
        by mout0.freenet.de with esmtpa (ID viktor.jaegerskuepper@freenet.de) (port 25) (Exim 4.90_1 #2)
        id 1fwn6L-0005X3-Pw; Mon, 03 Sep 2018 13:33:01 +0200
Received: from [::1] (port=52904 helo=mjail1.freenet.de)
        by mjail1.freenet.de with esmtpa (ID viktor.jaegerskuepper@freenet.de) (Exim 4.90_1 #2)
        id 1fwn6L-0002NC-OS; Mon, 03 Sep 2018 13:33:01 +0200
Received: from sub6.freenet.de ([195.4.92.125]:35554)
        by mjail1.freenet.de with esmtpa (ID viktor.jaegerskuepper@freenet.de) (Exim 4.90_1 #2)
        id 1fwn4C-0007bW-Tt; Mon, 03 Sep 2018 13:30:48 +0200
Received: from [2a02:8071:2b3:500:b248:7aff:fe90:aac4] (port=32998 helo=[127.0.0.1])
        by sub6.freenet.de with esmtpsa (ID viktor.jaegerskuepper@freenet.de) (TLSv1.2:ECDHE-RSA-CHACHA20-POLY1305:256) (port 465) (Exim 4.90_1 #2)
        id 1fwn4C-0005ox-R4; Mon, 03 Sep 2018 13:30:48 +0200
Subject: Re: REGRESSION: boot stalls on several old dual core Intel CPUs
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Kevin Shanahan <kevin@shanahan.id.au>,
        Siegfried Metz <frame@mailbox.org>,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        len.brown@intel.com, rjw@rjwysocki.net, diego.viola@gmail.com,
        rui.zhang@intel.com
References: <74c5abc8-7430-5bc9-2f8a-a2205608bee7@mailbox.org>
 <20180830130439.GM24082@hirez.programming.kicks-ass.net>
 <20180901022125.GO4941@tuon.disenchant.local>
 <20180903072506.GS24124@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1809030937230.1349@nanos.tec.linutronix.de>
 <20180903085423.GU24124@hirez.programming.kicks-ass.net>
 <20180903093305.GC24142@hirez.programming.kicks-ass.net>
From:   =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?= 
        <viktor_jaegerskuepper@freenet.de>
Message-ID: <5177cb97-e5d9-018e-781a-fc98a24f4173@freenet.de>
Date:   Mon, 03 Sep 2018 11:30:00 +0000
MIME-Version: 1.0
In-Reply-To: <20180903093305.GC24142@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originated-At: 2a02:8071:2b3:500:b248:7aff:fe90:aac4!32998
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra:
> On Mon, Sep 03, 2018 at 10:54:23AM +0200, Peter Zijlstra wrote:
>> On Mon, Sep 03, 2018 at 09:38:15AM +0200, Thomas Gleixner wrote:
>>> On Mon, 3 Sep 2018, Peter Zijlstra wrote:
>>>> On Sat, Sep 01, 2018 at 11:51:26AM +0930, Kevin Shanahan wrote:
>>>>> commit 01548f4d3e8e94caf323a4f664eb347fd34a34ab
>>>>> Author: Martin Schwidefsky <schwidefsky@de.ibm.com>
>>>>> Date:   Tue Aug 18 17:09:42 2009 +0200
>>>>>
>>>>>     clocksource: Avoid clocksource watchdog circular locking dependency
>>>>>
>>>>>     stop_machine from a multithreaded workqueue is not allowed because
>>>>>     of a circular locking dependency between cpu_down and the workqueue
>>>>>     execution. Use a kernel thread to do the clocksource downgrade.
>>>>
>>>> I cannot find stop_machine usage there; either it went away or I need to
>>>> like wake up.
>>>
>>> timekeeping_notify() which is involved in switching clock source uses stomp
>>> machine.
>>
>> ARGH... OK, lemme see if I can come up with something other than
>> endlessly spawning that kthread.
>>
>> A special purpose kthread_worker would make more sense than that.
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
>  	finished_booting = 1;
>  	/*
>  	 * Run the watchdog first to eliminate unstable clock sources
> 

Applied on mainline tag v4.19-rc2. Tested without additional parameters,
with "quiet" and with "debug", my PC booted successfully in all three
cases, whereas it stalled almost always in these three cases before.

Thanks!
