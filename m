Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7728FC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F1F218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbfBARzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:55:47 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36060 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726639AbfBARzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 12:55:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9AB515BE;
        Fri,  1 Feb 2019 09:55:46 -0800 (PST)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0976F3F589;
        Fri,  1 Feb 2019 09:55:44 -0800 (PST)
Subject: Re: [PATCH v3 1/3] KVM: arm/arm64: vgic: Make vgic_irq->irq_lock a
 raw_spinlock
To:     Julia Cartwright <julia@ni.com>
Cc:     Julien Thierry <julien.thierry@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <1546873577-13895-1-git-send-email-julien.thierry@arm.com>
 <1546873577-13895-2-git-send-email-julien.thierry@arm.com>
 <fa628aae-68eb-7140-0533-367cafa26ed6@arm.com>
 <20190201173650.GC29111@jcartwri.amer.corp.natinst.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <6eeb2d94-cdda-006b-f32f-7857b61b3eaa@arm.com>
Date:   Fri, 1 Feb 2019 17:55:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190201173650.GC29111@jcartwri.amer.corp.natinst.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julia,

On 01/02/2019 17:36, Julia Cartwright wrote:
> On Fri, Feb 01, 2019 at 03:30:58PM +0000, Julien Grall wrote:
>> Hi Julien,
>>
>> On 07/01/2019 15:06, Julien Thierry wrote:
>>> vgic_irq->irq_lock must always be taken with interrupts disabled as
>>> it is used in interrupt context.
>>
>> I am a bit confused with the reason here. The code mention that ap_list_lock
>> could be taken from the timer interrupt handler interrupt. I assume it
>> speaks about the handler kvm_arch_timer_handler. Looking at the
>> configuration of the interrupt, the flag IRQF_NO_THREAD is not set, so the
>> interrupt should be threaded when CONFIG_PREEMPT_FULL is set. If my
>> understanding is correct, this means the interrupt thread would sleep if it
>> takes the spinlock.
>>
>> Did I miss anything? Do you have an exact path where the vGIC is actually
>> called from an interrupt context?
> 
> The part you're missing is that percpu interrupts are not force
> threaded:
> 
> 	static int irq_setup_forced_threading(struct irqaction *new)
> 	{
> 		if (!force_irqthreads)
> 			return 0;
> 		if (new->flags & (IRQF_NO_THREAD | IRQF_PERCPU | IRQF_ONESHOT))
> 			return 0;
> 	
> 		/* ...*/
> 	}

Thank you for the pointer! I think it would be worth mentioning in the commit 
message that per-cpu interrupts are not threaded.

Best regards,

-- 
Julien Grall
