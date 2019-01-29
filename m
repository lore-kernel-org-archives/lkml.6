Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F39C282D0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3849520882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbfA2LgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:36:04 -0500
Received: from foss.arm.com ([217.140.101.70]:34620 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfA2LgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:36:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 193ADEBD;
        Tue, 29 Jan 2019 03:36:04 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D15093F589;
        Tue, 29 Jan 2019 03:36:01 -0800 (PST)
Subject: Re: [PATCH v9 21/26] irqchip/gic: Add functions to access irq
 priorities
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        daniel.thompson@linaro.org, joel@joelfernandes.org,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
 <1548084825-8803-22-git-send-email-julien.thierry@arm.com>
 <86va29ugy0.wl-marc.zyngier@arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <a47b09ff-7d68-8ed9-785e-8334319aef37@arm.com>
Date:   Tue, 29 Jan 2019 11:36:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <86va29ugy0.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/01/2019 12:04, Marc Zyngier wrote:
> On Mon, 21 Jan 2019 15:33:40 +0000,
> Julien Thierry <julien.thierry@arm.com> wrote:
>>
>> Add accessors to the GIC distributor/redistributors priority registers.
>>
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Jason Cooper <jason@lakedaemon.net>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  drivers/irqchip/irq-gic-common.c | 10 ++++++++++
>>  drivers/irqchip/irq-gic-common.h |  2 ++
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
>> index 3c93c6f..04eadbc 100644
>> --- a/drivers/irqchip/irq-gic-common.c
>> +++ b/drivers/irqchip/irq-gic-common.c
>> @@ -110,6 +110,16 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
>>  	return ret;
>>  }
>>  
>> +void gic_set_irq_prio(unsigned int irq, void __iomem *base, u8 prio)
>> +{
>> +	writeb_relaxed(prio, base + GIC_DIST_PRI + irq);
>> +}
>> +
>> +u8 gic_get_irq_prio(unsigned int irq, void __iomem *base)
>> +{
>> +	return readb_relaxed(base + GIC_DIST_PRI + irq);
>> +}
>> +
> 
> Is there a reason why this is in irq-gic-common.c? If we can avoid it,
> I'd rather this is made private to GICv3, as I do not intend to
> support this for earlier revisions on the architecture.
> 

The only reason I put it in common is that the same code works both for
gicv3 and gic drivers.

But if you prefer the gic driver not to see it I'll move it to the gicv3
driver.

Thanks,

-- 
Julien Thierry
