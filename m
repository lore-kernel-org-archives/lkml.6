Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA88C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797D020857
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731286AbfA1R13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:27:29 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51156 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730374AbfA1R11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:27:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 995C5EBD;
        Mon, 28 Jan 2019 09:27:26 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AAED13F59C;
        Mon, 28 Jan 2019 09:27:25 -0800 (PST)
Subject: Re: [PATCH v5 2/4] genirq: Provide NMI management for percpu_devid
 interrupts
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, mingo@kernel.org
References: <1548689907-17124-1-git-send-email-julien.thierry@arm.com>
 <1548689907-17124-3-git-send-email-julien.thierry@arm.com>
 <86h8dsviny.wl-marc.zyngier@arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <99113e5a-1a4b-c656-1ea6-a7cc326b77d5@arm.com>
Date:   Mon, 28 Jan 2019 17:27:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <86h8dsviny.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/01/2019 16:41, Marc Zyngier wrote:
> On Mon, 28 Jan 2019 15:38:25 +0000,
> Julien Thierry <julien.thierry@arm.com> wrote:
>>
>> Add support for percpu_devid interrupts treated as NMIs.
>>
>> Percpu_devid NMIs need to be setup/torn down on each CPU they target.
>>
>> The same restrictions as for global NMIs still apply for percpu_devid NMIs.
> 
> A quick overall view of the new API would be good, specially as some
> of the bits are not 100% obvious.
> 
>>
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  include/linux/interrupt.h |   9 +++
>>  kernel/irq/manage.c       | 148 ++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 157 insertions(+)
>>
>> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
>> index 37a4b0c6..be146bd 100644
>> --- a/include/linux/interrupt.h
>> +++ b/include/linux/interrupt.h
>> @@ -168,10 +168,15 @@ struct irqaction {
>>  				    devname, percpu_dev_id);
>>  }
>>  
>> +extern int __must_check
>> +request_percpu_nmi(unsigned int irq, irq_handler_t handler,
>> +		   const char *devname, void __percpu *dev);
>> +
>>  extern const void *free_irq(unsigned int, void *);
>>  extern void free_percpu_irq(unsigned int, void __percpu *);
>>  
>>  extern const void *free_nmi(unsigned int irq, void *dev_id);
>> +extern void free_percpu_nmi(unsigned int irq, void __percpu *percpu_dev_id);
>>  
>>  struct device;
>>  
>> @@ -224,7 +229,11 @@ struct irqaction {
>>  extern void irq_wake_thread(unsigned int irq, void *dev_id);
>>  
>>  extern void disable_nmi_nosync(unsigned int irq);
>> +extern void disable_percpu_nmi(unsigned int irq);
>>  extern void enable_nmi(unsigned int irq);
>> +extern void enable_percpu_nmi(unsigned int irq, unsigned int type);
>> +extern int ready_percpu_nmi(unsigned int irq);
> 
> ready_percpu_nmi seems a very bizarre name, as I cannot figure out
> what that does. How about something along the line of
> "setup_percpu_nmi"?
> 

The reason I did not go for "setup_percpu_nmi" is because I didn't want
it to be assimilated to "setup_irq"/"__setup_irq" which sets up all the
resources for an IRQ line.

I guess "prepare_percpu_nmi()" could do the trick unless I come up with
a better name.

>> +extern void teardown_percpu_nmi(unsigned int irq);
>>  
>>  /* The following three functions are for the core kernel use only. */
>>  extern void suspend_device_irqs(void);
>> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
>> index a168b2d8f..602a622 100644
>> --- a/kernel/irq/manage.c
>> +++ b/kernel/irq/manage.c
>> @@ -2185,6 +2185,11 @@ void enable_percpu_irq(unsigned int irq, unsigned int type)
>>  }
>>  EXPORT_SYMBOL_GPL(enable_percpu_irq);
>>  
>> +void enable_percpu_nmi(unsigned int irq, unsigned int type)
>> +{
>> +	enable_percpu_irq(irq, type);
>> +}
>> +
>>  /**
>>   * irq_percpu_is_enabled - Check whether the per cpu irq is enabled
>>   * @irq:	Linux irq number to check for
>> @@ -2224,6 +2229,11 @@ void disable_percpu_irq(unsigned int irq)
>>  }
>>  EXPORT_SYMBOL_GPL(disable_percpu_irq);
>>  
>> +void disable_percpu_nmi(unsigned int irq)
>> +{
>> +	disable_percpu_irq(irq);
>> +}
>> +
>>  /*
>>   * Internal function to unregister a percpu irqaction.
>>   */
>> @@ -2255,6 +2265,8 @@ static struct irqaction *__free_percpu_irq(unsigned int irq, void __percpu *dev_
>>  	/* Found it - now remove it from the list of entries: */
>>  	desc->action = NULL;
>>  
>> +	desc->istate &= ~IRQS_NMI;
>> +
>>  	raw_spin_unlock_irqrestore(&desc->lock, flags);
>>  
>>  	unregister_handler_proc(irq, action);
>> @@ -2308,6 +2320,19 @@ void free_percpu_irq(unsigned int irq, void __percpu *dev_id)
>>  }
>>  EXPORT_SYMBOL_GPL(free_percpu_irq);
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
>>  /**
>>   *	setup_percpu_irq - setup a per-cpu interrupt
>>   *	@irq: Interrupt line to setup
>> @@ -2398,6 +2423,129 @@ int __request_percpu_irq(unsigned int irq, irq_handler_t handler,
>>  EXPORT_SYMBOL_GPL(__request_percpu_irq);
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
>> +	if (!desc || !irq_settings_can_request(desc) ||
>> +	    !irq_settings_is_per_cpu_devid(desc) ||
>> +	    irq_settings_can_autoenable(desc) ||
>> +	    !irq_supports_nmi(desc))
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
>> +	action->name = name;
>> +	action->percpu_dev_id = dev_id;
>> +
>> +	retval = irq_chip_pm_get(&desc->irq_data);
>> +	if (retval < 0)
>> +		goto err_out;
>> +
>> +	retval = __setup_irq(irq, desc, action);
>> +	if (retval)
>> +		goto err_irq_setup;
>> +
>> +	raw_spin_lock_irqsave(&desc->lock, flags);
>> +	desc->istate |= IRQS_NMI;
>> +	raw_spin_unlock_irqrestore(&desc->lock, flags);
>> +
>> +	return 0;
>> +
>> +err_irq_setup:
>> +	irq_chip_pm_put(&desc->irq_data);
>> +err_out:
>> +	kfree(action);
>> +
>> +	return retval;
>> +}
>> +
>> +int ready_percpu_nmi(unsigned int irq)
> 
> Name issue withstanding, this could do with some documentation. You
> probably want to indicate that this is expected to be called from a
> non-preemptible section.
> 

Sure, I can elaborate a bit.

>> +{
>> +	unsigned long flags;
>> +	struct irq_desc *desc = irq_get_desc_lock(irq, &flags,
>> +						  IRQ_GET_DESC_CHECK_PERCPU);
>> +	int ret = 0;
>> +
>> +	if (!desc) {
>> +		ret = -EINVAL;
>> +		goto out;
> 
> Ouch. Bad idea.
> 

Oh yes, well spotted!

Thanks,

>> +	}
>> +
>> +	if (WARN(!(desc->istate & IRQS_NMI),
>> +		 KERN_ERR "ready_percpu_nmi called for a non-NMI interrupt: irq %u\n",
>> +		 irq)) {
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	ret = irq_nmi_setup(desc);
>> +	if (ret) {
>> +		pr_err("Failed to setup NMI delivery: irq %u\n", irq);
>> +		goto out;
>> +	}
>> +
>> +out:
>> +	irq_put_desc_unlock(desc, flags);
>> +	return ret;
>> +}
>> +
>> +void teardown_percpu_nmi(unsigned int irq)
>> +{
>> +	unsigned long flags;
>> +	struct irq_desc *desc = irq_get_desc_lock(irq, &flags,
>> +						  IRQ_GET_DESC_CHECK_PERCPU);
>> +
>> +	if (!desc)
>> +		return;
>> +
>> +	if (WARN_ON(!(desc->istate & IRQS_NMI)))
>> +		goto out;
>> +
>> +	irq_nmi_teardown(desc);
>> +out:
>> +	irq_put_desc_unlock(desc, flags);
>> +}
>> +
>> +/**
>>   *	irq_get_irqchip_state - returns the irqchip state of a interrupt.
>>   *	@irq: Interrupt line that is forwarded to a VM
>>   *	@which: One of IRQCHIP_STATE_* the caller wants to know about
>> -- 
>> 1.9.1
>>
> 
> Thanks,
> 
> 	M.
> 

-- 
Julien Thierry
