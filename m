Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CCCC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD70208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD70208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389662AbeHAQ6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 12:58:04 -0400
Received: from foss.arm.com ([217.140.101.70]:43854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389557AbeHAQ6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 12:58:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 188B97A9;
        Wed,  1 Aug 2018 08:11:55 -0700 (PDT)
Received: from [10.4.13.159] (e112298-lin.emea.arm.com [10.4.13.159])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05B2D3F5D0;
        Wed,  1 Aug 2018 08:11:53 -0700 (PDT)
Subject: Re: [PATCH 2/4] genirq: Provide NMI management for percpu_devid
 interrupts
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, marc.zyngier@arm.com, mingo@kernel.org
References: <1532430427-57151-1-git-send-email-julien.thierry@arm.com>
 <1532430427-57151-3-git-send-email-julien.thierry@arm.com>
 <20180801031104.GB31383@voyager>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <17bd4c2f-000e-3b32-49bf-b2700e74f66e@arm.com>
Date:   Wed, 1 Aug 2018 16:11:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180801031104.GB31383@voyager>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/08/18 04:11, Ricardo Neri wrote:
> On Tue, Jul 24, 2018 at 12:07:05PM +0100, Julien Thierry wrote:
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
>>   include/linux/interrupt.h |   9 +++
>>   kernel/irq/manage.c       | 149 ++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 158 insertions(+)
>>
>> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
>> index 3b1a320..59d3877 100644
>> --- a/include/linux/interrupt.h
>> +++ b/include/linux/interrupt.h
>> @@ -168,10 +168,15 @@ struct irqaction {
>>   				    devname, percpu_dev_id);
>>   }
>>   
>> +extern int __must_check
>> +request_percpu_nmi(unsigned int irq, irq_handler_t handler,
>> +		   const char *devname, void __percpu *dev);
>> +
>>   extern const void *free_irq(unsigned int, void *);
>>   extern void free_percpu_irq(unsigned int, void __percpu *);
>>   
>>   extern const void *free_nmi(unsigned int irq, void *dev_id);
>> +extern void free_percpu_nmi(unsigned int irq, void __percpu *percpu_dev_id);
>>   
>>   struct device;
>>   
>> @@ -224,7 +229,11 @@ struct irqaction {
>>   extern void irq_wake_thread(unsigned int irq, void *dev_id);
>>   
>>   extern void disable_nmi_nosync(unsigned int irq);
>> +extern void disable_percpu_nmi(unsigned int irq);
> 
> Shouldn't this be a disable_percpu_nmi_nosync() as disable_nmi_nosync()?
> 

The naming of the disable_percpu_irq didn't include the nosync either 
(and it doesn't wait for pending percpu_devid_irqs)

>>   extern void enable_nmi(unsigned int irq);
>> +extern void enable_percpu_nmi(unsigned int irq, unsigned int type);
>> +extern int ready_percpu_nmi(unsigned int irq);
>> +extern void teardown_percpu_nmi(unsigned int irq);
>>   
>>   /* The following three functions are for the core kernel use only. */
>>   extern void suspend_device_irqs(void);
>> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
>> index 3b87143..ad41c4d 100644
>> --- a/kernel/irq/manage.c
>> +++ b/kernel/irq/manage.c
>> @@ -2162,6 +2162,11 @@ void enable_percpu_irq(unsigned int irq, unsigned int type)
>>   }
>>   EXPORT_SYMBOL_GPL(enable_percpu_irq);
>>   
>> +void enable_percpu_nmi(unsigned int irq, unsigned int type)
>> +{
>> +	enable_percpu_irq(irq, type);
>> +}
>> +
>>   /**
>>    * irq_percpu_is_enabled - Check whether the per cpu irq is enabled
>>    * @irq:	Linux irq number to check for
>> @@ -2201,6 +2206,11 @@ void disable_percpu_irq(unsigned int irq)
>>   }
>>   EXPORT_SYMBOL_GPL(disable_percpu_irq);
>>   
>> +void disable_percpu_nmi(unsigned int irq)
>> +{
>> +	disable_percpu_irq(irq);
>> +}
>> +
>>   /*
>>    * Internal function to unregister a percpu irqaction.
>>    */
>> @@ -2232,6 +2242,8 @@ static struct irqaction *__free_percpu_irq(unsigned int irq, void __percpu *dev_
>>   	/* Found it - now remove it from the list of entries: */
>>   	desc->action = NULL;
>>   
>> +	desc->istate &= ~IRQS_NMI;
>> +
>>   	raw_spin_unlock_irqrestore(&desc->lock, flags);
>>   
>>   	unregister_handler_proc(irq, action);
>> @@ -2285,6 +2297,19 @@ void free_percpu_irq(unsigned int irq, void __percpu *dev_id)
>>   }
>>   EXPORT_SYMBOL_GPL(free_percpu_irq);
>>   
>> +void free_percpu_nmi(unsigned int irq, void __percpu *dev_id)
>> +{
>> +	struct irq_desc *desc = irq_to_desc(irq);
>> +
>> +	if (!desc || !irq_settings_is_per_cpu_devid(desc))
>> +		return;
>> +
>> +	if (WARN_ON(!(desc->istate & IRQS_NMI)))
>> +		return;
>> +
>> +	kfree(__free_percpu_irq(irq, dev_id));
>> +}
>> +
>>   /**
>>    *	setup_percpu_irq - setup a per-cpu interrupt
>>    *	@irq: Interrupt line to setup
>> @@ -2375,6 +2400,130 @@ int __request_percpu_irq(unsigned int irq, irq_handler_t handler,
>>   EXPORT_SYMBOL_GPL(__request_percpu_irq);
>>   
>>   /**
>> + *	request_percpu_nmi - allocate a percpu interrupt line for NMI delivery
>> + *	@irq: Interrupt line to allocate
>> + *	@handler: Function to be called when the IRQ occurs.
>> + *	@devname: An ascii name for the claiming device
>> + *	@dev_id: A percpu cookie passed back to the handler function
>> + *
>> + *	This call allocates interrupt resources and enables the
>> + *	interrupt on the local CPU. If the interrupt is supposed to be
>> + *	enabled on other CPUs, it has to be done on each CPU using
>> + *	enable_percpu_nmi().
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
>> +	if (!desc || !irq_settings_can_request(desc)
>> +	    || !irq_settings_is_per_cpu_devid(desc)
>> +	    || irq_settings_can_autoenable(desc)
>> +	    || !irq_supports_nmi(desc))
> 
> Shouldn't the logical operators go at the end of the line in a multi-line
> statement?

Yes, I'll fix that.

> 
>> +		return -EINVAL;
>> +
>> +	/* The line cannot already be NMI */
>> +	if (desc->istate & IRQS_NMI)
>> +		return -EINVAL;
>> +
>> +	action = kzalloc(sizeof(struct irqaction), GFP_KERNEL);
>> +	if (!action)
>> +		return -ENOMEM;
>> +
>> +	action->handler = handler;
>> +	action->flags = IRQF_PERCPU | IRQF_NO_SUSPEND | IRQF_NO_THREAD
>> +		| IRQF_NOBALANCING;
> 
> Shouldn't IRQF_NOBALANCING be aligned with IRQF_PERCPU;
> 

Yes, I'll fix this as well.

Thanks,

-- 
Julien Thierry
