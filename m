Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD326C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67044208B7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qF2gKxrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67044208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbeHXTuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:50:03 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53324 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbeHXTuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:50:02 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7OGETis090796;
        Fri, 24 Aug 2018 11:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535127269;
        bh=9EaBSguA/lFh/vdLo9kA/pGPTan0oTshNpGxE7mWk6M=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qF2gKxrE3wH7GtrwF5x5HPjM8WHMrUVHBZ1YpO0i6v0vJncG68dlu/laGLr3Enpg1
         wAo7VeH1lfafdW+PshjoG2zbUSqttL1Jir++KK2eMlHxT6HwccG39UPaY41j6bHOEJ
         qPYw5mtA9RDIKL/2I45K6vzVhrhKD1Pm/7fIa6H4=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7OGETA3032392;
        Fri, 24 Aug 2018 11:14:29 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 24
 Aug 2018 11:14:29 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 24 Aug 2018 11:14:29 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7OGETEf019296;
        Fri, 24 Aug 2018 11:14:29 -0500
Subject: Re: [PATCH] nohz: Fix missing tick reprog while interrupting inline
 timer softirq
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        <stable@vger.kernel.org>
References: <1533077570-9169-1-git-send-email-frederic@kernel.org>
 <8ecb9229-4c14-6967-0863-15b47cefd251@ti.com>
 <20180824061750.GA20523@kroah.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <64587070-b9b1-4bc4-0f2e-59d33fe68f67@ti.com>
Date:   Fri, 24 Aug 2018 11:14:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824061750.GA20523@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/24/2018 01:17 AM, Greg KH wrote:
> On Thu, Aug 23, 2018 at 05:57:06PM -0500, Grygorii Strashko wrote:
>> Hi
>>
>> On 07/31/2018 05:52 PM, Frederic Weisbecker wrote:
>>> Before updating the full nohz tick or the idle time on IRQ exit, we
>>> check first if we are not in a nesting interrupt, whether the inner
>>> interrupt is a hard or a soft IRQ.
>>>
>>> There is a historical reason for that: the dyntick idle mode used to
>>> reprogram the tick on IRQ exit, after softirq processing, and there was
>>> no point in doing that job in the outer nesting interrupt because the
>>> tick update will be performed through the end of the inner interrupt
>>> eventually, with even potential new timer updates.
>>>
>>> One corner case could show up though: if an idle tick interrupts a softirq
>>> executing inline in the idle loop (through a call to local_bh_enable())
>>> after we entered in dynticks mode, the IRQ won't reprogram the tick
>>> because it assumes the softirq executes on an inner IRQ-tail. As a
>>> result we might put the CPU in sleep mode with the tick completely
>>> stopped whereas a timer can still be enqueued. Indeed there is no tick
>>> reprogramming in local_bh_enable(). We probably asssumed there was no bh
>>> disabled section in idle, although there didn't seem to be debug code
>>> ensuring that.
>>>
>>> Nowadays the nesting interrupt optimization still stands but only concern
>>> full dynticks. The tick is stopped on IRQ exit in full dynticks mode
>>> and we want to wait for the end of the inner IRQ to reprogramm the tick.
>>> But in_interrupt() doesn't make a difference between softirqs executing
>>> on IRQ tail and those executing inline. What was to be considered a
>>> corner case in dynticks-idle mode now becomes a serious opportunity for
>>> a bug in full dynticks mode: if a tick interrupts a task executing
>>> softirq inline, the tick reprogramming will be ignored and we may exit
>>> to userspace after local_bh_enable() with an enqueued timer that will
>>> never fire.
>>>
>>> To fix this, simply keep reprogramming the tick if we are in a hardirq
>>> interrupting softirq. We can still figure out a way later to restore
>>> this optimization while excluding inline softirq processing.
>>>
>>> Reported-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
>>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Ingo Molnar <mingo@kernel.org>
>>> Tested-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
>>> ---
>>>    kernel/softirq.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/softirq.c b/kernel/softirq.c
>>> index 900dcfe..0980a81 100644
>>> --- a/kernel/softirq.c
>>> +++ b/kernel/softirq.c
>>> @@ -386,7 +386,7 @@ static inline void tick_irq_exit(void)
>>>    
>>>    	/* Make sure that timer wheel updates are propagated */
>>>    	if ((idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
>>> -		if (!in_interrupt())
>>> +		if (!in_irq())
>>>    			tick_nohz_irq_exit();
>>>    	}
>>>    #endif
>>>
>>
>> This patch was back ported to the Stable linux-4.14.y and It causes regression -
>>   flood of "NOHZ: local_softirq_pending" messages on all TI boards during boot (NFS boot):
>>
>> [    4.179796] NOHZ: local_softirq_pending 2c2 in sirq 256
>> [    4.185051] NOHZ: local_softirq_pending 2c2 in sirq 256
>>
>> the same is not reproducible with LKML - seems due to changes in tick-sched.c
>> __tick_nohz_idle_enter()/tick_nohz_irq_exit().
> 
> What changes do you think fixed this?

not sure. But it seems set of changes from Rafael J. Wysocki:

ff7de62 nohz: Avoid duplication of code related to got_idle_tick
296bb1e cpuidle: menu: Refine idle state selection for running tick
554c8aa sched: idle: Select idle state before stopping the tick
23a8d88 time: tick-sched: Split tick_nohz_stop_sched_tick()
45f1ff5 cpuidle: Return nohz hint from cpuidle_select()
2aaf709 sched: idle: Do not stop the tick upfront in the idle loop
0e77676 time: tick-sched: Reorganize idle tick management code
b7eaf1a cpufreq: schedutil: Avoid reducing frequency of busy CPUs prematurely

> 
>> I've generated backtrace from  can_stop_idle_tick() (see below) and seems this
>> patch makes tick_nohz_irq_exit() call unconditional in case of nested interrupt:
>>
>> gic_handle_irq
>>   |- irq_exit
>>      |- preempt_count_sub(HARDIRQ_OFFSET); <-- [1]
>>      |-__do_softirq
>> 	<irqs enabled>
>> 	|- gic_handle_irq()
>> 	   |- irq_exit()
>> 		|- tick_irq_exit()
>> 		   if (!in_irq()) <-- My understanding is that this condition will be always true due to [1]
>> 			tick_nohz_irq_exit();
>> 			|-__tick_nohz_idle_enter()
>> 			  |- can_stop_idle_tick()
>>
>> Sry, not sure if my conclusion is right and how can it be fixed.
> 
> Any pointers to a patch that might need to be backported would be
> appreciated.
> 

commit 
Author: Frederic Weisbecker <frederic@kernel.org>
Date: Fri Aug 3 15:31:34 2018 +0200

nohz: Fix missing tick reprogram when interrupting an inline softirq

commit 0a0e0829f990120cef165bbb804237f400953ec2 upstream.



-- 
regards,
-grygorii
