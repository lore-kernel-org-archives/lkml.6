Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8C3C4321E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 21:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0412086B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 21:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="u18LVUa8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0412086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mailbox.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeIDB5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 21:57:12 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:58884 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbeIDB5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 21:57:11 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 1767A41D72;
        Mon,  3 Sep 2018 23:35:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received; s=mail20150812; t=
        1536010504; bh=KG7/yRu/8xuw047agLb6KcOL5yV4KVcQZwzUVyFOjKU=; b=u
        18LVUa8lXppcw41wvHFItBQzZDQYRrpkMq694ccnuzhN563TuN+guREnlb1wv/4l
        fzb58jzcXt/QNEXEHC8QF7sPedBrd3prW0S4tqhf2aQ3SiSbYCt/9KPYIZubyjA4
        DicwbIrG4/0CKlb4BxwEAMSyeaMCcKtfQAQoz7LRAwHb0NUUNbIvM8ol3pM8+HWM
        ZyeRBdqCPKkUqvEIX9vOS8Dr7ZEUthTmFH4rujzPl2cm/SRnHibbN48Asd8LHzPU
        LIa6SxTiIFGEwVcHXUfByPoFyRWyzjDCA6r2NEXrhSIxnpbX4uoWbJIJ8l/OHTIQ
        ROYg7BdmO/BCwatkJZWsg==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id 26xa7igVenII; Mon,  3 Sep 2018 23:35:04 +0200 (CEST)
Subject: Re: REGRESSION: boot stalls on several old dual core Intel CPUs
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Kevin Shanahan <kevin@shanahan.id.au>,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        len.brown@intel.com, rjw@rjwysocki.net, diego.viola@gmail.com,
        rui.zhang@intel.com, viktor_jaegerskuepper@freenet.de
References: <74c5abc8-7430-5bc9-2f8a-a2205608bee7@mailbox.org>
 <20180830130439.GM24082@hirez.programming.kicks-ass.net>
 <20180901022125.GO4941@tuon.disenchant.local>
 <20180903072506.GS24124@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1809030937230.1349@nanos.tec.linutronix.de>
 <20180903085423.GU24124@hirez.programming.kicks-ass.net>
 <20180903093305.GC24142@hirez.programming.kicks-ass.net>
From:   Siegfried Metz <frame@mailbox.org>
Message-ID: <14c49f11-4df3-a07b-b2aa-dacb998dcd89@mailbox.org>
Date:   Mon, 3 Sep 2018 23:34:56 +0200
MIME-Version: 1.0
In-Reply-To: <20180903093305.GC24142@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/18 11:33 AM, Peter Zijlstra wrote:
> On Mon, Sep 03, 2018 at 10:54:23AM +0200, Peter Zijlstra wrote:
>> On Mon, Sep 03, 2018 at 09:38:15AM +0200, Thomas Gleixner wrote:
>>> On Mon, 3 Sep 2018, Peter Zijlstra wrote:
>>>> On Sat, Sep 01, 2018 at 11:51:26AM +0930, Kevin Shanahan wrote:
>>>>> commit 01548f4d3e8e94caf323a4f664eb347fd34a34ab
>>>>> Author: Martin Schwidefsky <schwidefsky@de.ibm.com>
>>>>> Date:   Tue Aug 18 17:09:42 2009 +0200
>>>>>
>>>>>      clocksource: Avoid clocksource watchdog circular locking dependency
>>>>>
>>>>>      stop_machine from a multithreaded workqueue is not allowed because
>>>>>      of a circular locking dependency between cpu_down and the workqueue
>>>>>      execution. Use a kernel thread to do the clocksource downgrade.
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
>   kernel/time/clocksource.c | 28 ++++++++++++++++++++++------
>   1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index f74fb00d8064..898976d0082a 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -112,13 +112,28 @@ static int finished_booting;
>   static u64 suspend_start;
>   
>   #ifdef CONFIG_CLOCKSOURCE_WATCHDOG
> -static void clocksource_watchdog_work(struct work_struct *work);
> +static void clocksource_watchdog_work(struct kthread_work *work);
>   static void clocksource_select(void);
>   
>   static LIST_HEAD(watchdog_list);
>   static struct clocksource *watchdog;
>   static struct timer_list watchdog_timer;
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
>   static DEFINE_SPINLOCK(watchdog_lock);
>   static int watchdog_running;
>   static atomic_t watchdog_reset_pending;
> @@ -158,7 +173,7 @@ static void __clocksource_unstable(struct clocksource *cs)
>   
>   	/* kick clocksource_watchdog_work() */
>   	if (finished_booting)
> -		schedule_work(&watchdog_work);
> +		kthread_queue_work(watchdog_worker, &watchdog_work);
>   }
>   
>   /**
> @@ -199,7 +214,7 @@ static void clocksource_watchdog(struct timer_list *unused)
>   		/* Clocksource already marked unstable? */
>   		if (cs->flags & CLOCK_SOURCE_UNSTABLE) {
>   			if (finished_booting)
> -				schedule_work(&watchdog_work);
> +				kthread_queue_work(watchdog_worker, &watchdog_work);
>   			continue;
>   		}
>   
> @@ -269,7 +284,7 @@ static void clocksource_watchdog(struct timer_list *unused)
>   			 */
>   			if (cs != curr_clocksource) {
>   				cs->flags |= CLOCK_SOURCE_RESELECT;
> -				schedule_work(&watchdog_work);
> +				kthread_queue_work(watchdog_worker, &watchdog_work);
>   			} else {
>   				tick_clock_notify();
>   			}
> @@ -418,7 +433,7 @@ static int __clocksource_watchdog_work(void)
>   	return select;
>   }
>   
> -static void clocksource_watchdog_work(struct work_struct *work)
> +static void clocksource_watchdog_work(struct kthread_work *work)
>   {
>   	mutex_lock(&clocksource_mutex);
>   	if (__clocksource_watchdog_work())
> @@ -806,6 +821,7 @@ static int __init clocksource_done_booting(void)
>   {
>   	mutex_lock(&clocksource_mutex);
>   	curr_clocksource = clocksource_default_clock();
> +	watchdog_worker = kthread_create_worker(0, "cs-watchdog");
>   	finished_booting = 1;
>   	/*
>   	 * Run the watchdog first to eliminate unstable clock sources
> 

Successfully booted my Intel Core 2 Duo with the patch applied on top of
4.18.5 (based on default Arch Linux config).

I tested with at least 8/8 successful boots in total - with no
additional kernel boot parameters and also with "quiet", and "debug".
No problems seen so far.

Thank you for your effort and developing this patch.


Siegfried
