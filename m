Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD45C282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF042175B
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbfA3GZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 01:25:22 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:46164 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725823AbfA3GZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 01:25:22 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4BB7B57AB6670DA8943D;
        Wed, 30 Jan 2019 14:25:20 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Wed, 30 Jan 2019
 14:25:16 +0800
Subject: Re: [PATCH -next] irqchip/tango: Fix potential NULL pointer
 dereference
To:     =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
        Marc Zyngier <marc.zyngier@arm.com>
References: <20190129080122.20392-1-yuehaibing@huawei.com>
 <86a7jjvo4y.wl-marc.zyngier@arm.com> <yw1x8sz31wqw.fsf@mansr.com>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.w.gonzalez@free.fr>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <59e45e0d-558a-a40d-36d5-47e7ce3fb5a0@huawei.com>
Date:   Wed, 30 Jan 2019 14:25:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <yw1x8sz31wqw.fsf@mansr.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/29 20:20, Måns Rullgård wrote:
> Marc Zyngier <marc.zyngier@arm.com> writes:
> 
>> On Tue, 29 Jan 2019 08:01:22 +0000,
>> YueHaibing <yuehaibing@huawei.com> wrote:
>>>
>>> There is a potential NULL pointer dereference in case kzalloc()
>>> fails and returns NULL.
>>>
>>> Fixes: 4bba66899ac6 ("irqchip/tango: Add support for Sigma Designs SMP86xx/SMP87xx interrupt controller")
>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>> ---
>>>  drivers/irqchip/irq-tango.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/irqchip/irq-tango.c b/drivers/irqchip/irq-tango.c
>>> index ae28d86..a63b828 100644
>>> --- a/drivers/irqchip/irq-tango.c
>>> +++ b/drivers/irqchip/irq-tango.c
>>> @@ -191,6 +191,8 @@ static int __init tangox_irq_init(void __iomem *base, struct resource *baseres,
>>>  		panic("%pOFn: failed to get address", node);
>>>  
>>>  	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
>>> +	if (!chip)
>>> +		return -ENOMEM;
>>>  	chip->ctl = res.start - baseres->start;
>>>  	chip->base = base;
>>>  
>>
>> This is a commendable effort, but given that the whole error handling
>> of this driver is just to simply panic, I have the ugly feeling that
>> this lack of check is more a feature than a bug... Not that I like it,
>> but at least it is consistent.
> 
> That seemed to be the norm for irqchip drivers when I wrote this one,
> and a fair number of them still panic on errors during init.  There's
> really not much else that can sanely be done since nothing will work
> without irq handling.
> 
> As for the error return added by this patch, nothing checks it, so a
> failure would merely result in the irqchip being silently skipped and
> nothing working.  Propagating the error back to of_irq_init() also has
> no effect, not even a warning.  Besides, kzalloc() is extremely unlikely
> to fail at this stage, and if it does, you have much bigger problems.

Thanks for your comment.

> 

