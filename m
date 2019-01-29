Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AF3C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAFF20844
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfA2Ldj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:33:39 -0500
Received: from foss.arm.com ([217.140.101.70]:34522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfA2Ldj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:33:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 017D1EBD;
        Tue, 29 Jan 2019 03:33:39 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AC8C3F589;
        Tue, 29 Jan 2019 03:33:36 -0800 (PST)
Subject: Re: [PATCH v9 20/26] irqchip/gic-v3: Handle pseudo-NMIs
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        daniel.thompson@linaro.org, joel@joelfernandes.org,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
 <1548084825-8803-21-git-send-email-julien.thierry@arm.com>
 <86wompuh5j.wl-marc.zyngier@arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <c332af8d-4529-dbb0-f760-0c2518823053@arm.com>
Date:   Tue, 29 Jan 2019 11:33:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <86wompuh5j.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/01/2019 11:59, Marc Zyngier wrote:
> On Mon, 21 Jan 2019 15:33:39 +0000,
> Julien Thierry <julien.thierry@arm.com> wrote:
>>
>> Provide a higher priority to be used for pseudo-NMIs. When such an
>> interrupt is received, keep interrupts fully disabled at CPU level to
>> prevent receiving other pseudo-NMIs while handling the current one.
>>
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Jason Cooper <jason@lakedaemon.net>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  drivers/irqchip/irq-gic-v3.c | 42 ++++++++++++++++++++++++++++++++++++------
>>  1 file changed, 36 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>> index 5374b43..4df1e94 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -41,6 +41,8 @@
>>  
>>  #include "irq-gic-common.h"
>>  
>> +#define GICD_INT_NMI_PRI	(GICD_INT_DEF_PRI & ~0x80)
>> +
>>  #define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
>>  
>>  struct redist_region {
>> @@ -381,12 +383,45 @@ static u64 gic_mpidr_to_affinity(unsigned long mpidr)
>>  	return aff;
>>  }
>>  
>> +static inline void gic_deactivate_unexpected_irq(u32 irqnr)
> 
> Same remark as on some other patches: you should be able to drop the
> inline attribute without any ill effect. I'd also like this to be
> renamed "gic_deactivate_spurious", or something similar.
> 

I'm a bit concern about using spurious since it is not related to
GICC_INT_SPURIOUS, we actually read a valid IRQ number, we just don't
know how we should handle it.

Would "gic_deactivate_unhandled" work? Or "gic_deactivate_bad"?

Thanks,

-- 
Julien Thierry
