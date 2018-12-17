Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22141C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9EA52084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731539AbeLQJ0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:26:07 -0500
Received: from foss.arm.com ([217.140.101.70]:51600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbeLQJ0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:26:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88149A78;
        Mon, 17 Dec 2018 01:26:06 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43D3B3F6A8;
        Mon, 17 Dec 2018 01:26:04 -0800 (PST)
Subject: Re: [PATCH v7 11/25] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
To:     Jian-Lin Chen <lecopzer@gmail.com>
Cc:     Jian-Lin Chen <lecopzer.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        daniel.thompson@linaro.org, joel@joelfernandes.org,
        marc.zyngier@arm.com, christoffer.dall@arm.com,
        james.morse@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        mark.rutland@arm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Oleg Nesterov <oleg@redhat.com>
References: <20181216144715.7486-1-lecopzer@gmail.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <e69be9ad-fcda-fa8d-1844-ad0decffb876@arm.com>
Date:   Mon, 17 Dec 2018 09:26:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181216144715.7486-1-lecopzer@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jian-Lin,

Thanks for looking at this.

On 16/12/2018 14:47, Jian-Lin Chen wrote:
> From: Jian-Lin Chen <lecopzer.chen@mediatek.com>
> 
> 
> On Wed, 12 Dec 2018 at 17:48, Julien Thierry <julien.thierry@arm.com> wrote:
>>  static inline void arch_local_irq_enable(void)
>>  {
>> -       asm volatile(
>> -               "msr    daifclr, #2             // arch_local_irq_enable"
>> -               :
>> +       unsigned long unmasked = GIC_PRIO_IRQON;
>> +
> 
> Should we need a WARN_ON() to check if the daif_I bit is masked, or
> explicitly unmasked I bit here?
> 

While I would agree, adding the WARN_ON() will add some non-negligible
overhead, especially if we need to read the daif flags to check it.

Since these functions are called often in the whole system and using PMR
already makes things a bit slower, I'd prefer to avoid checks in here.

> If I bit was masked and someone calls arch_local_irq_enable(), they still
> couldn't recieve any interrupt.
> 
> 
>> +       asm volatile(ALTERNATIVE(
>> +               "msr    daifclr, #2             // arch_local_irq_enable\n"
>> +               "nop",
>> +               "msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
>> +               "dsb    sy",
>> +               ARM64_HAS_IRQ_PRIO_MASKING)
>>                 :
>> +               : "r" (unmasked)
>>                 : "memory");
>>  }
>>
>>  static inline void arch_local_irq_disable(void)
>>  {
>> -       asm volatile(
>> -               "msr    daifset, #2             // arch_local_irq_disable"
>> -               :
>> +       unsigned long masked = GIC_PRIO_IRQOFF;
>> +
>> +       asm volatile(ALTERNATIVE(
>> +               "msr    daifset, #2             // arch_local_irq_disable",
>> +               "msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0",
> 
> May be a "dsb sy" here?

So, we need a "dsb sy" when unmasking interrupts because this ensures
the redistributor sees the latest PMR value and starts forwarding lower
priority interrupts again.

When we disable interrupts however, the GIC CPU interface guarantees
that no interrupts of lower priority than the current value of PMR will
be taken. So we don't really need the redistributor to immediately see
the new value of PMR as the logic in the GIC CPU interface is good
enough for our goal.

Thanks,

-- 
Julien Thierry
