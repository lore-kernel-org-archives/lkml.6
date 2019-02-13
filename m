Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1204C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4A4222C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391450AbfBMJ5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:57:23 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50618 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733235AbfBMJ5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:57:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BA6AA78;
        Wed, 13 Feb 2019 01:57:22 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FD493F575;
        Wed, 13 Feb 2019 01:57:19 -0800 (PST)
Subject: Re: [PATCH v6 2/4] genirq: Provide NMI management for percpu_devid
 interrupts
To:     "liwei (GF)" <liwei391@huawei.com>, linux-kernel@vger.kernel.org
References: <1548946441-38546-1-git-send-email-julien.thierry@arm.com>
 <1548946441-38546-3-git-send-email-julien.thierry@arm.com>
 <dc1334f6-f451-183a-758c-8f54da2bd952@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ingo Molnar <mingo@kernel.org>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <8aa2c1f8-6fad-4556-39df-f397c5b9d552@arm.com>
Date:   Wed, 13 Feb 2019 09:57:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <dc1334f6-f451-183a-758c-8f54da2bd952@huawei.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li Wei,

[Adding back Cc that were dropped]

On 12/02/2019 09:51, liwei (GF) wrote:
> Hi Julien,
> 
> On 2019/1/31 22:53, Julien Thierry Wrote:
>> Add support for percpu_devid interrupts treated as NMIs.
>>
>> Percpu_devid NMIs need to be setup/torn down on each CPU they target.
>>
>> The same restrictions as for global NMIs still apply for percpu_devid NMIs.
>>
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  include/linux/interrupt.h |   9 +++
>>  kernel/irq/manage.c       | 177 ++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 186 insertions(+)
>>
> (SNIP)
>>  
>>  /**
>> + *	request_percpu_nmi - allocate a percpu interrupt line for NMI delivery
>> + *	@irq: Interrupt line to allocate
>> + *	@handler: Function to be called when the IRQ occurs.
>> + *	@name: An ascii name for the claiming device
>> + *	@dev_id: A percpu cookie passed back to the handler function
>> + *
>> + *	This call allocates interrupt resources for a per CPU NMI. Per CPU NMIs
>> + *	have to be setup on each CPU by calling ready_percpu_nmi() before being
> ready_percpu_nmi need to be renamed here.
> 

Thanks for spotting this. I'll send a fix for next.

>> + *	enabled on the same CPU by using enable_percpu_nmi().
>> + *
>> + *	Dev_id must be globally unique. It is a per-cpu variable, and
>> + *	the handler gets called with the interrupted CPU's instance of
>> + *	that variable.
>> + *
>> + *	Interrupt lines requested for NMI delivering should have auto enabling
>> + *	setting disabled.
>> + *
>> + *	If the interrupt line cannot be used to deliver NMIs, function
>> + *	will fail returning a negative value.
>> + */
>> +int request_percpu_nmi(unsigned int irq, irq_handler_t handler,
>> +		       const char *name, void __percpu *dev_id)
>> +{
>> +	struct irqaction *action;
>> +	struct irq_desc *desc;
>> +	unsigned long flags;
>> +	int retval;
>> +
>> +	if (!handler)
>> +		return -EINVAL;
>> +
>> +	desc = irq_to_desc(irq);
>> +
> and i have an other question, i found that kstat_incr_irqs_this_cpu() was omitted in
> handle_fasteoi_nmi() and handle_percpu_devid_fasteoi_nmi(), are there some worrys here?
> It is a little odd since we can get NMI counters on the x86 machine in /proc/interrputs.

I don't think x86 uses the IRQ framework for NMIs and probably have
their own thing to count NMIs.

The issue is that we cannot take the desc lock so I'm not sure it would
be safe to increment the desc->tot_count in NMI context (although
technically NMI IRQ lines cannot be shared, so I think it should be fine
for non-percpu_nmis). The other concern is incrementing the percpu
kstat.irqs_sum, which I guess is a definite *no* in an NMI context as we
could have interrupted and interrupt trying to increment that same counter.

So we might be able to establish some kstat_incr_nmi to update some of
the counters but it might require a bit more reflexion on the matter, so
I'd like to avoid adding that as a "quick fix" in next which might end
up breaking things.

Thanks,

-- 
Julien Thierry
