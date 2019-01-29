Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FE7C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B522083B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfA2MaG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:30:06 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:50552 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbfA2MaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 07:30:05 -0500
X-Greylist: delayed 597 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Jan 2019 07:30:05 EST
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 4D53615AC8; Tue, 29 Jan 2019 12:20:07 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     YueHaibing <yuehaibing@huawei.com>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.w.gonzalez@free.fr>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH -next] irqchip/tango: Fix potential NULL pointer dereference
References: <20190129080122.20392-1-yuehaibing@huawei.com>
        <86a7jjvo4y.wl-marc.zyngier@arm.com>
Date:   Tue, 29 Jan 2019 12:20:07 +0000
In-Reply-To: <86a7jjvo4y.wl-marc.zyngier@arm.com> (Marc Zyngier's message of
        "Tue, 29 Jan 2019 08:55:41 +0000")
Message-ID: <yw1x8sz31wqw.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Zyngier <marc.zyngier@arm.com> writes:

> On Tue, 29 Jan 2019 08:01:22 +0000,
> YueHaibing <yuehaibing@huawei.com> wrote:
>> 
>> There is a potential NULL pointer dereference in case kzalloc()
>> fails and returns NULL.
>> 
>> Fixes: 4bba66899ac6 ("irqchip/tango: Add support for Sigma Designs SMP86xx/SMP87xx interrupt controller")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/irqchip/irq-tango.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/drivers/irqchip/irq-tango.c b/drivers/irqchip/irq-tango.c
>> index ae28d86..a63b828 100644
>> --- a/drivers/irqchip/irq-tango.c
>> +++ b/drivers/irqchip/irq-tango.c
>> @@ -191,6 +191,8 @@ static int __init tangox_irq_init(void __iomem *base, struct resource *baseres,
>>  		panic("%pOFn: failed to get address", node);
>>  
>>  	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
>> +	if (!chip)
>> +		return -ENOMEM;
>>  	chip->ctl = res.start - baseres->start;
>>  	chip->base = base;
>>  
>
> This is a commendable effort, but given that the whole error handling
> of this driver is just to simply panic, I have the ugly feeling that
> this lack of check is more a feature than a bug... Not that I like it,
> but at least it is consistent.

That seemed to be the norm for irqchip drivers when I wrote this one,
and a fair number of them still panic on errors during init.  There's
really not much else that can sanely be done since nothing will work
without irq handling.

As for the error return added by this patch, nothing checks it, so a
failure would merely result in the irqchip being silently skipped and
nothing working.  Propagating the error back to of_irq_init() also has
no effect, not even a warning.  Besides, kzalloc() is extremely unlikely
to fail at this stage, and if it does, you have much bigger problems.

-- 
Måns Rullgård
