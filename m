Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 151BBC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC6EF20660
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DIjlG6gI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC6EF20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935342AbeFMBGo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 21:06:44 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:56712 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935098AbeFMBGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 21:06:41 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllnx210.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5D16eoa015962;
        Tue, 12 Jun 2018 20:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1528852000;
        bh=TWUvItduixIkOw56byGxL+W2n5ombMrmiYXLfeXscC0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=DIjlG6gI9k+5r20hnPHF9WOwhjgouDK4y7ieWu4+DVy26Om18HEhOShLrKJvsZ0U6
         MmEYZ80w2fxKqbrj6M7+XYhLxhXISAjQcg9PZYAKgI3yc0iASmKVDIGFrPP95aGIAj
         W4oR0QeAUuC6bDRIhTR/FpmkgfiIATm7Zb42mZSQ=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5D16eWm017713;
        Tue, 12 Jun 2018 20:06:40 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 12
 Jun 2018 20:06:40 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 12 Jun 2018 20:06:40 -0500
Received: from [172.22.219.132] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5D16aVA013415;
        Tue, 12 Jun 2018 20:06:37 -0500
Subject: Re: [PATCH v3 2/2] gpio: davinci: Do not assume continuous IRQ
 numbering
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        <linus.walleij@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <t-kristo@ti.com>
References: <1528790356-15945-1-git-send-email-j-keerthy@ti.com>
 <1528790356-15945-2-git-send-email-j-keerthy@ti.com>
 <4ef40eb2-774e-925c-f4f1-5ed431ec1268@ti.com>
From:   "J, KEERTHY" <j-keerthy@ti.com>
Message-ID: <af41c620-6c3c-a348-80c1-89918d0db898@ti.com>
Date:   Wed, 13 Jun 2018 06:36:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <4ef40eb2-774e-925c-f4f1-5ed431ec1268@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/13/2018 1:36 AM, Grygorii Strashko wrote:
> 
> 
> On 06/12/2018 02:59 AM, Keerthy wrote:
>> Currently the driver assumes that the interrupts are continuous
>> and does platform_get_irq only once and assumes the rest are continuous,
>> instead call platform_get_irq for all the interrupts and store them
>> in an array for later use.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>
>> Tested for GPIO Interrupts on da850-lcdk board.
>>
>> Changes in v3:
>>
>>     * Changed irqs type from unsigned to int
>>
>> Changes in v2:
>>
>>     * Extended the logic of using saved IRQs to unbanked IRQs
>>       as per Grygorii's suggestion.
>>
>>    drivers/gpio/gpio-davinci.c                | 54 +++++++++++++++++++-----------
>>    include/linux/platform_data/gpio-davinci.h |  3 +-
>>    2 files changed, 36 insertions(+), 21 deletions(-)
>>
> 
> [...]
> 
>>    
>> @@ -383,7 +396,7 @@ static int gpio_to_irq_unbanked(struct gpio_chip *chip, unsigned offset)
>>    	 * can provide direct-mapped IRQs to AINTC (up to 32 GPIOs).
>>    	 */
>>    	if (offset < d->gpio_unbanked)
>> -		return d->base_irq + offset;
>> +		return d->irqs[offset];
> 
> this one seems right
> 
>>    	else
>>    		return -ENODEV;
>>    }
>> @@ -396,7 +409,7 @@ static int gpio_irq_type_unbanked(struct irq_data *data, unsigned trigger)
>>    
>>    	d = (struct davinci_gpio_controller *)irq_data_get_irq_handler_data(data);
>>    	g = (struct davinci_gpio_regs __iomem *)d->regs[0];
>> -	mask = __gpio_mask(data->irq - d->base_irq);
>> +	mask = __gpio_mask(data->irq - d->irqs[0]);
> 
> but this one is not. You can't do "base + offset" or "irq - base" ops
> if Irqs range is not sequential. So, in my opinion, here you need to
> convert irq to gpio bank offset (hwirq value in irq_data is not offset
> - gic specific value) which means - walk through d->irqs[x] and find
> item with d->irqs[x] == irq which will give gpio bank offset.
> Than offset can be used to build mask.

Agreed.

> 
>>    
>>    	if (trigger & ~(IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
>>    		return -EINVAL;
>> @@ -458,7 +471,7 @@ static struct irq_chip *keystone_gpio_get_irq_chip(unsigned int irq)
>>     * (dm6446) can be set appropriately for GPIOV33 pins.
>>     */
>>    
>> -static int davinci_gpio_irq_setup(struct platform_device *pdev, int bank_irq)
> 
> 
> [...]
> 
>>    #include <asm-generic/gpio.h>
>>    
>>    #define MAX_REGS_BANKS		5
>> +#define MAX_INT_PER_BANK 32
>>    
>>    struct davinci_gpio_platform_data {
>>    	u32	ngpio;
>> @@ -41,7 +42,7 @@ struct davinci_gpio_controller {
>>    	spinlock_t		lock;
>>    	void __iomem		*regs[MAX_REGS_BANKS];
>>    	int			gpio_unbanked;
>> -	unsigned int		base_irq;
>> +	int			irqs[MAX_INT_PER_BANK];
>>    	unsigned int		base;
>>    };
>>    
>>
> 
