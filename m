Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D660C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA06C2170E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RI8d/yzU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hqWPMx0B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA06C2170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbeHTTGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:06:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34698 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeHTTGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:06:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2FBFB6147F; Mon, 20 Aug 2018 15:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534780201;
        bh=g+8nx+Dyb7/VwQIyuI7+rVVx3sesOQA8DlODxwKCaDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RI8d/yzUpgiGKKqsp4mA9e62V7cjyVV7eyviKUkjanbvxuhp7buPWCZW39xwo83ea
         XT4BkAGs2K5X4ojLXT+5iHkERwbdJWcxdnYFpgM+qK11htjgZ6MISiLmblqbh24e3+
         OUrnLIfZ3xUk5uU+038HjnUeMW6BpaTP71seLfdQ=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 20E0D6144B;
        Mon, 20 Aug 2018 15:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534780200;
        bh=g+8nx+Dyb7/VwQIyuI7+rVVx3sesOQA8DlODxwKCaDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hqWPMx0BMFtk68/jP1iNWHYSCGOC9rcIsCUUsoVQl8eZbgHvV1BmvB9kWJSk9ruUQ
         8RPbiWiX6xeChtcKonl6X43XYSmLQIGKAZdM7y+UqCdfE3jH+ya8UC5wE8CWAdO2rL
         SgfBeSOS0rlZMFbIjqfByJL8z7n2v2+CT5QpTBLc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 20E0D6144B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Mon, 20 Aug 2018 09:49:59 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     bjorn.andersson@linaro.org, sboyd@kernel.org, evgreen@chromium.org,
        linus.walleij@linaro.org, rplsssn@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, devicetree@vger.kernel.org,
        andy.gross@linaro.org, dianders@chromium.org
Subject: Re: [PATCH RESEND v1 2/5] drivers: pinctrl: msm: enable PDC
 interrupt only during suspend
Message-ID: <20180820154959.GS5081@codeaurora.org>
References: <20180817191026.32245-1-ilina@codeaurora.org>
 <20180817191026.32245-3-ilina@codeaurora.org>
 <86a7pjq0l1.wl-marc.zyngier@arm.com>
 <20180820152629.GR5081@codeaurora.org>
 <047d37fb-1011-0650-6517-e6052ba47a18@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <047d37fb-1011-0650-6517-e6052ba47a18@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20 2018 at 09:34 -0600, Marc Zyngier wrote:
>On 20/08/18 16:26, Lina Iyer wrote:
>> On Sat, Aug 18 2018 at 07:13 -0600, Marc Zyngier wrote:
>>> Hi Lina,
>>>
>>> On Fri, 17 Aug 2018 20:10:23 +0100,
>>> Lina Iyer <ilina@codeaurora.org> wrote:
>
>[...]
>
>>>> @@ -920,6 +928,8 @@ static int msm_gpio_pdc_pin_request(struct irq_data *d)
>>>>  	}
>>>>
>>>>  	irq_set_handler_data(d->irq, irq_get_irq_data(irq));
>>>> +	irq_set_handler_data(irq, d);
>>>> +	irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY);
>>>
>>> Could you explain what this is trying to do? I'm trying to understand
>>> this code, but this function isn't in 4.18...
>>>
>> Oh, I have been able to test only on 4.14 so far. The flag does seem to
>> exist at least, I didn't get a compiler error.
>>
>> I read this in kernel/irq/chip.c -
>>
>> If the interrupt chip does not implement the irq_disable callback,
>> a driver can disable the lazy approach for a particular irq line by
>> calling 'irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY)'. This can
>> be used for devices which cannot disable the interrupt at the
>> device level under certain circumstances and have to use
>> disable_irq[_nosync] instead.
>>
>> And interpreted this as something that this would prevent 'relaxed'
>> disable. I am enabling and disabling the IRQ in suspend path, that I
>> thought this would help avoid issues caused by late disable. Am I
>> mistaken?
>
>Sorry, I wasn't clear enough. I'm talking about what you're trying to do
>in this particular function (msm_gpio_pdc_pin_request), which doesn't
>exist in 4.18. Short of having a bit of context, I can hardly review this.
>
Sorry, my patch generation during the resend is messed up. Seems like I
didn't send that patch out during the resend.

-- Lina

