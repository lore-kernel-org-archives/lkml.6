Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D293C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8612086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB8612086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbeLJPQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:16:52 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:44574 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbeLJPQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:16:51 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-MBX-04.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gWNIb-0003Vg-25 from Vladimir_Zapolskiy@mentor.com ; Mon, 10 Dec 2018 07:16:45 -0800
Received: from [137.202.108.125] (137.202.0.90) by
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Mon, 10 Dec 2018 15:16:39 +0000
Subject: Re: [PATCH] regmap: regmap-irq/gpio-max77620: add level-irq support
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        <mazziesaccount@gmail.com>
References: <20181210081437.GA32228@localhost.localdomain>
CC:     <broonie@kernel.org>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linus.walleij@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <heikki.haikola@fi.rohmeurope.com>,
        <mikko.mutanen@fi.rohmeurope.com>
From:   Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <e378d050-01b4-9a6c-1c17-1f1ca04dd16e@mentor.com>
Date:   Mon, 10 Dec 2018 17:16:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <20181210081437.GA32228@localhost.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-08.mgc.mentorg.com (139.181.222.8) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2018 10:14 AM, Matti Vaittinen wrote:
> Add level active IRQ support to regmap-irq irqchip. Change breaks
> existing regmap-irq type setting. Convert the existing drivers which
> use regmap-irq with trigger type setting (gpio-max77620) to work
> with this new approach. So we do not magically support level-active
> IRQs on gpio-max77620 - but add support to the regmap-irq for chips
> which support them =)
> 
> We do not support distinguishing situation where HW supports rising
> and falling edge detection but not both. Separating this would require
> inventing yet another flags for IRQ types.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> I did both the regmap-irq and max77620 changes in same commit because
> I'd rather not cause spot where max77620 breaks. Besides the changes in
> max77620 driver are trivial. Please let me know if this is not Ok.
> 
> Reason why I submit this patch now - even though my driver which would
> use level active type setting with regmap-irq is not yet ready for
> being submited - is that I'd like to minimize amount of existing drivers
> we need to patch. And if we add level active irq support like this then
> we must patch all existing drivers using type setting with regmap-irq.
> So doing this now when only max77620 uses type setting may be easier
> than postponing this to the future.
> 
> And finally - I don't have max77620 so I have only done _wery_ limited
> testing. So I would really appreciate if someone had time to review this
> thoroughly - and even happier if someone had possibility to try this out
> with the max77620.
> 

[snip]

> diff --git a/include/linux/regmap.h b/include/linux/regmap.h
> index a367d59c301d..91c431ad98c3 100644
> --- a/include/linux/regmap.h
> +++ b/include/linux/regmap.h
> @@ -1098,6 +1098,9 @@ int regmap_fields_update_bits_base(struct regmap_field *field,  unsigned int id,
>   * @type_reg_offset: Offset register for the irq type setting.
>   * @type_rising_mask: Mask bit to configure RISING type irq.
>   * @type_falling_mask: Mask bit to configure FALLING type irq.
> + * @type_level_low_mask: Mask bit to configure LEVEL_LOW type irq.
> + * @type_level_high_mask: Mask bit to configure LEVEL_HIGH type irq.
> + * @types_supported: logical OR of IRQ_TYPE_* flags indicating supported types.

While the existing interface is awful, you don't make it better.

.types_supported value is always derived from non-zero .type_*_mask values, so
it is simply not needed, as well as the whole change to gpio-max77620.c driver.

>   */
>  struct regmap_irq {
>  	unsigned int reg_offset;
> @@ -1105,6 +1108,9 @@ struct regmap_irq {
>  	unsigned int type_reg_offset;
>  	unsigned int type_rising_mask;
>  	unsigned int type_falling_mask;
> +	unsigned int type_level_low_mask;
> +	unsigned int type_level_high_mask;
> +	unsigned int types_supported;
>  };
>  
>  #define REGMAP_IRQ_REG(_irq, _off, _mask)		\
> 

--
Best wishes,
Vladimir
