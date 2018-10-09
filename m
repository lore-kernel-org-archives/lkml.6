Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3871DC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46412075C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46412075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbeJIPbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 11:31:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33616 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbeJIPbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 11:31:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDC9B80D;
        Tue,  9 Oct 2018 01:15:21 -0700 (PDT)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 600F13F5B3;
        Tue,  9 Oct 2018 01:15:19 -0700 (PDT)
Subject: Re: [PATCH V10 1/8] irqchip: add C-SKY SMP interrupt controller
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org,
        mark.rutland@arm.com, daniel.lezcano@linaro.org,
        anurup.m@huawei.com, Jonathan.Cameron@huawei.com,
        will.deacon@arm.com, zhangshaokun@hisilicon.com, jhogan@kernel.org,
        paul.burton@mips.com, peterz@infradead.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1538672812.git.ren_guo@c-sky.com>
 <e06484474231375248e3e7a6ab47cf8ff8893129.1538672812.git.ren_guo@c-sky.com>
 <404fb433-020e-28f9-2434-a22c6db36a15@arm.com> <20181009022357.GA826@guoren>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <a8654ba4-fe46-6842-64f6-d4141bbf8793@arm.com>
Date:   Tue, 9 Oct 2018 09:15:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181009022357.GA826@guoren>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/18 03:24, Guo Ren wrote:
> Hi Marc,
> 
> On Mon, Oct 08, 2018 at 05:35:19PM +0100, Marc Zyngier wrote:
>> Hi Guo,
>>
>> On 04/10/18 18:22, Guo Ren wrote:
>>>   - Irq-csky-mpintc is C-SKY smp system interrupt controller and it
>>>     could support 16 soft irqs, 16 private irqs, and 992 max common
>>>     irqs.
>>>
>>> Changelog:
>>>   - pass checkpatch.pl
>>>   - Move IPI_IRQ into the driver
>>>   - Remove irq_set_default_host() and use set_ipi_irq_mapping()
> 
>   [...]
> 
>>> +#ifdef CONFIG_SMP
>>> +static void csky_mpintc_send_ipi(const unsigned long *mask)
>>> +{
>>
>> Why isn't this a cpumask? It should be this driver's job to convert the
>> cpumask to an interrupt-controller specific representation, and not the SMP
>> code's.
> Ok, use cpumask.
> 
>   [...]
> 
>>> +#ifdef CONFIG_SMP
>>> +	set_send_ipi(&csky_mpintc_send_ipi);
>>> +
>>> +	set_ipi_irq_mapping(&csky_mpintc_ipi_irq_mapping);
>>
>> Since you seem to be inventing a new set_send_ipi callback, why don't you
>> define it as:
>>
>> void set_send_ipi(void (*func)(const struct cpumask *),
>> 		  unsigned int ipi_irq);
>> after having created the mapping for the IPI interrupt? It would avoid this
>> rather pointless mapping callback.
> 
> I'll define it to:
> 
> void set_send_ipi(void (*func)(const struct cpumask *));
> 
> IPI_IRQ only use software-irq-15 in mpintc driver, so arch needn't care
> about irq-num.

Except that your SMP code does a request_irq on the result of 
create_mapping. Who is going to do that if you don't pass the Linux irq 
around?

> 
> 	/*
> 	 * INTCL_SIGR[3:0] INTID
> 	 * INTCL_SIGR[8:15] CPUMASK
> 	 */
> 	writel_relaxed((*mask) << 8 | IPI_IRQ, reg_base + INTCL_SIGR);
> 
> We direct put IPI_IRQ to the hw-reg for the target core.

I can see that, but that doesn't solve the issue outlined above.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
