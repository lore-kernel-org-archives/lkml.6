Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E770BC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB103208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB103208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933336AbeGJNZ5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:25:57 -0400
Received: from foss.arm.com ([217.140.101.70]:46410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933138AbeGJNZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:25:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DDC8ED1;
        Tue, 10 Jul 2018 06:25:56 -0700 (PDT)
Received: from [10.1.210.28] (unknown [10.1.210.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E81133F5A0;
        Tue, 10 Jul 2018 06:25:53 -0700 (PDT)
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/2] clocksource: arm_arch_timer: set arch_mem_timer
 cpumask to cpu_possible_mask
To:     Thomas Gleixner <tglx@linutronix.de>
References: <1531151136-18297-1-git-send-email-sudeep.holla@arm.com>
 <1531151136-18297-2-git-send-email-sudeep.holla@arm.com>
 <alpine.DEB.2.21.1807100008100.1590@nanos.tec.linutronix.de>
 <b98e0d87-3d9a-9b0c-23c4-7b289cc79a97@arm.com>
 <alpine.DEB.2.21.1807101419130.4356@nanos.tec.linutronix.de>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <a8979e78-9844-160a-a758-631505924bbd@arm.com>
Date:   Tue, 10 Jul 2018 14:25:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1807101419130.4356@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/07/18 13:21, Thomas Gleixner wrote:
> On Tue, 10 Jul 2018, Sudeep Holla wrote:
> 
>>
>>
>> On 09/07/18 23:09, Thomas Gleixner wrote:
>>> On Mon, 9 Jul 2018, Sudeep Holla wrote:
>>>
>>>> Currently, arch_mem_timer cpumask is set to cpu_all_mask which should be
>>>> fine. However, cpu_possible_mask is more accurate and if there are other
>>>> clockevent source in the system which are set to cpu_possible_mask, then
>>>> having cpu_all_mask may result in issue.
>>>>
>>>> E.g. on a platform with arm,sp804 timer with rating 300 and
>>>> cpu_possible_mask and this arch_mem_timer timer with rating 400 and
>>>> cpu_all_mask, tick_check_preferred may choose both preferred as the
>>>> cpumasks are not equal though they must be.
>>>>
>>>> This issue was root caused incorrectly initially and a fix was merged as
>>>> commit 1332a9055801 ("tick: Prefer a lower rating device only if it's CPU
>>>> local device").
>>>
>>> To avoid that in the future we really should fix the decision logic to mask
>>> out the non possible CPUs from the supplied masks.
>>
>> Sure, I can do that. But do you want that as a fix for v4.18 ?
> 
> No, that's for 4.19
> 

Ah OK, I assume you are fine with this patch as fix for v4.18.
>> I think we may need this check at another place in tick_setup_device
>>
>> 213         /*
>> 214          * When the device is not per cpu, pin the interrupt to the
>> 215          * current cpu:
>> 216          */
>> 217         if (!cpumask_equal(newdev->cpumask, cpumask))
>> 218                 irq_set_affinity(newdev->irq, cpumask);
>>
>> Does it make sense trim dev->cpumask when registering the clockevents
>> device itself instead of adding check at place where this cpumask
>> can be used ? So that any future user of those masks need not have to
>> take care of that.
> 
> The problem is you cannot trim it because cpu_all_mask is global and const.
> 

Indeed, again forgot it just a pointer to the global one, duh!

>> Also only few ARM clocksource drivers use cpu_all_mask which could be
>> result of copy-paste, we can even fix them too.
>>
>> arm_arch_timer.c:	clk->cpumask = cpu_all_mask;
>> tegra20_timer.c:	tegra_clockevent.cpumask = cpu_all_mask;
>> timer-atcpit100.c:	.cpumask = cpu_all_mask,
>> timer-keystone.c:	event_dev->cpumask = cpu_all_mask;
>> zevio-timer.c:		timer->clkevt.cpumask	= cpu_all_mask;
> 
> Yes, that makes sense. What we could do is warn, when cpu_all_mask is set
> at registration time and replace the pointer with cpu_possible_mask.
> 

I like this approach than having to bitwise and with cpu_possible_mask
at all the necessary place. I will cook up a patch.
-- 
Regards,
Sudeep
