Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53998C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151F92170E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151F92170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbeHTSuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 14:50:37 -0400
Received: from foss.arm.com ([217.140.101.70]:39438 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbeHTSug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 14:50:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B959B18A;
        Mon, 20 Aug 2018 08:34:30 -0700 (PDT)
Received: from [10.4.13.119] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E8543F24A;
        Mon, 20 Aug 2018 08:34:28 -0700 (PDT)
Subject: Re: [PATCH RESEND v1 2/5] drivers: pinctrl: msm: enable PDC interrupt
 only during suspend
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, sboyd@kernel.org, evgreen@chromium.org,
        linus.walleij@linaro.org, rplsssn@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, devicetree@vger.kernel.org,
        andy.gross@linaro.org, dianders@chromium.org
References: <20180817191026.32245-1-ilina@codeaurora.org>
 <20180817191026.32245-3-ilina@codeaurora.org>
 <86a7pjq0l1.wl-marc.zyngier@arm.com> <20180820152629.GR5081@codeaurora.org>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <047d37fb-1011-0650-6517-e6052ba47a18@arm.com>
Date:   Mon, 20 Aug 2018 16:34:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180820152629.GR5081@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/18 16:26, Lina Iyer wrote:
> On Sat, Aug 18 2018 at 07:13 -0600, Marc Zyngier wrote:
>> Hi Lina,
>>
>> On Fri, 17 Aug 2018 20:10:23 +0100,
>> Lina Iyer <ilina@codeaurora.org> wrote:

[...]

>>> @@ -920,6 +928,8 @@ static int msm_gpio_pdc_pin_request(struct irq_data *d)
>>>  	}
>>>
>>>  	irq_set_handler_data(d->irq, irq_get_irq_data(irq));
>>> +	irq_set_handler_data(irq, d);
>>> +	irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY);
>>
>> Could you explain what this is trying to do? I'm trying to understand
>> this code, but this function isn't in 4.18...
>>
> Oh, I have been able to test only on 4.14 so far. The flag does seem to
> exist at least, I didn't get a compiler error.
> 
> I read this in kernel/irq/chip.c -
> 
> If the interrupt chip does not implement the irq_disable callback,
> a driver can disable the lazy approach for a particular irq line by
> calling 'irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY)'. This can
> be used for devices which cannot disable the interrupt at the
> device level under certain circumstances and have to use
> disable_irq[_nosync] instead.
> 
> And interpreted this as something that this would prevent 'relaxed'
> disable. I am enabling and disabling the IRQ in suspend path, that I
> thought this would help avoid issues caused by late disable. Am I
> mistaken?

Sorry, I wasn't clear enough. I'm talking about what you're trying to do
in this particular function (msm_gpio_pdc_pin_request), which doesn't
exist in 4.18. Short of having a bit of context, I can hardly review this.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
