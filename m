Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051D0C65BAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F5920666
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F5920666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbeLCJne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:43:34 -0500
Received: from mail-sz2.amlogic.com ([211.162.65.114]:7148 "EHLO
        mail-sz2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeLCJne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:43:34 -0500
X-Greylist: delayed 908 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Dec 2018 04:43:33 EST
Received: from [10.28.18.81] (10.28.18.81) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Mon, 3 Dec 2018
 17:28:26 +0800
Subject: Re: [PATCH 2/2] irqchip/meson-gpio: Add support for Meson-G12A SoC
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kevin Hilman <khilman@baylibre.com>
CC:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Carlo Caione <carlo@caione.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh@kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20181203061324.36248-1-xingyu.chen@amlogic.com>
 <20181203061324.36248-3-xingyu.chen@amlogic.com>
 <7a2f88d849ada782de6e27676518d0b9897e30e7.camel@baylibre.com>
From:   Xingyu Chen <xingyu.chen@amlogic.com>
Message-ID: <dc42e7df-a3de-7323-177f-56a08564fb60@amlogic.com>
Date:   Mon, 3 Dec 2018 17:28:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <7a2f88d849ada782de6e27676518d0b9897e30e7.camel@baylibre.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.18.81]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/12/3 17:19, Jerome Brunet wrote:
> On Mon, 2018-12-03 at 14:13 +0800, Xingyu Chen wrote:
>> The Meson-G12A SoC uses the same GPIO interrupt controller IP block as the
>> other Meson SoCs, A totle of 100 pins can be spied on, which is the sum of:
>>
>> - 223:100 undefined (no interrupt)
>> - 99:97   3 pins on bank GPIOE
>> - 96:77   20 pins on bank GPIOX
>> - 76:61   16 pins on bank GPIOA
>> - 60:53   8 pins on bank GPIOC
>> - 52:37   16 pins on bank BOOT
>> - 36:28   9 pins on bank GPIOH
>> - 27:12   16 pins on bank GPIOZ
>> - 11:0    12 pins in the AO domain
>>
>> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>> ---
>>   drivers/irqchip/irq-meson-gpio.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-
>> gpio.c
>> index 7b531fd075b8..971e8dea069a 100644
>> --- a/drivers/irqchip/irq-meson-gpio.c
>> +++ b/drivers/irqchip/irq-meson-gpio.c
>> @@ -67,12 +67,17 @@ static const struct meson_gpio_irq_params axg_params = {
>>   	.nr_hwirq = 100,
>>   };
>>   
>> +static const struct meson_gpio_irq_params g12a_params = {
>> +	.nr_hwirq = 100,
>> +};
>> +
> 
> Same comment as on i2c, the g12 seems compatible with the axg.
> Is this patchset patchset really necessary ?
> 
Although the total number of pins is the same as the Meson-AXG SoC, the 
gpio banks and irq numbers are different. To avoid confusion on use, i 
think the new compatible string is needed.
>>   static const struct of_device_id meson_irq_gpio_matches[] = {
>>   	{ .compatible = "amlogic,meson8-gpio-intc", .data = &meson8_params },
>>   	{ .compatible = "amlogic,meson8b-gpio-intc", .data = &meson8b_params
>> },
>>   	{ .compatible = "amlogic,meson-gxbb-gpio-intc", .data = &gxbb_params
>> },
>>   	{ .compatible = "amlogic,meson-gxl-gpio-intc", .data = &gxl_params },
>>   	{ .compatible = "amlogic,meson-axg-gpio-intc", .data = &axg_params },
>> +	{ .compatible = "amlogic,meson-g12a-gpio-intc", .data = &g12a_params
>> },
>>   	{ }
>>   };
>>   
> 
> 
> .
> 
