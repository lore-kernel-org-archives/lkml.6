Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57776ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B37520657
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B37520657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbeGQQVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:21:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48862 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729671AbeGQQVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:21:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5B907A9;
        Tue, 17 Jul 2018 08:48:20 -0700 (PDT)
Received: from [10.1.207.53] (e112298-lin.cambridge.arm.com [10.1.207.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A34603F318;
        Tue, 17 Jul 2018 08:48:19 -0700 (PDT)
Subject: Re: [RFC PATCH 1/4] genirq: Provide basic NMI management for
 interrupt lines
From:   Julien Thierry <julien.thierry@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        ricardo.neri-calderon@linux.intel.com, marc.zyngier@arm.com,
        peterz@infradead.org, mingo@kernel.org
References: <1531152846-19374-1-git-send-email-julien.thierry@arm.com>
 <1531152846-19374-2-git-send-email-julien.thierry@arm.com>
 <alpine.DEB.2.21.1807171114280.3238@nanos.tec.linutronix.de>
 <e0c00482-7125-32e5-faa1-4251c118de5e@arm.com>
Message-ID: <c4f7e808-d416-63c9-2972-fb90a5c72753@arm.com>
Date:   Tue, 17 Jul 2018 16:48:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <e0c00482-7125-32e5-faa1-4251c118de5e@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/07/18 12:13, Julien Thierry wrote:
> Hi Thomas,
> 
> Thanks for the review.
> 
> On 17/07/18 10:22, Thomas Gleixner wrote:

[...]

>> On Mon, 9 Jul 2018, Julien Thierry wrote:
>>> +/* This function must be called with desc->lock held */
>>> +static const void *__cleanup_nmi(unsigned int irq, struct irq_desc 
>>> *desc)
>>> +{
>>> +    const char *devname = NULL;
>>> +
>>> +    desc->istate &= ~IRQS_NMI;
>>> +
>>> +#ifdef CONFIG_SMP
>>> +    if (WARN_ON(desc->affinity_notify))
>>> +        desc->affinity_notify = NULL;
>>> +#endif
>>
>> We should not support that affinity notify horror for NMIs at all.
>>
> 
> Makes sense, I'll add it to the constraints for NMIs and remove that part.
> 
>>> +    if (!WARN_ON(desc->action == NULL)) {
>>> +        irq_pm_remove_action(desc, desc->action);
>>> +        devname = desc->action->name;
>>> +        unregister_handler_proc(irq, desc->action);
>>> +
>>> +        kfree(desc->action);
>>> +        desc->action = NULL;
>>> +    }
>>> +
>>> +    irq_settings_clr_disable_unlazy(desc);
>>> +    irq_shutdown(desc);
>>> +
>>> +#ifdef CONFIG_SMP
>>> +    /* make sure affinity_hint is cleaned up */
>>> +    if (WARN_ON_ONCE(desc->affinity_hint))
>>> +        desc->affinity_hint = NULL;
>>> +#endif
>>
>> Especially not twice :)
>>
> 
> Oops... I'll remove that as well.

Re-reading this I realized that second part was about 
desc->affinity_hint and not desc->affinity_notify.

Supporting desc->affinity_hint for NMIs shouldn't be an issue, right?

Thanks,

-- 
Julien Thierry
