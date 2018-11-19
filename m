Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91C6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94145206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AblXl1ZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94145206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbeKSUkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:40:11 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42794 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbeKSUkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:40:10 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAJAGk5G121574;
        Mon, 19 Nov 2018 04:16:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542622606;
        bh=RwpROdVH0xR9m6WqhAf2fFqF2QLkOQ3I+8XUVbWMEoc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=AblXl1ZUhPeIjEAdKxfuoPnNaHe0kzA4jpnvMI9CjFFPS6LtSVKA/YebCAI+1PUuS
         dC4+NY9nAiU5Gs0CyHVNu/QBM8YSBplC5qVXwEQTW7h5QeGRzLCTQcO1RwRMRSc8T3
         oVqWUxBKcjmUIsffz89kOdaNFd1njY+HqRxr3bl0=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAJAGkjU095261
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Nov 2018 04:16:46 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 19
 Nov 2018 04:16:43 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 19 Nov 2018 04:16:43 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAJAGgkJ012734;
        Mon, 19 Nov 2018 04:16:42 -0600
Subject: Re: omap5 fixing palmas IRQ_TYPE_NONE warning leads to gpadc timeouts
To:     Tony Lindgren <tony@atomide.com>,
        Belisko Marek <marek.belisko@gmail.com>
CC:     LKML <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
References: <CAAfyv35bat+t6awL-VRigAoaUTySwOgZkQMs=W9mEKQ6VDW3FA@mail.gmail.com>
 <20180703084516.GT112168@atomide.com>
 <CAAfyv37F1s8Cg=pfxiN0dA6YEX7KMB-+uifjRoqAdKGWLeYEwA@mail.gmail.com>
 <20181113180656.GE53235@atomide.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <46d271b2-35d3-6353-c530-3292cdac53ab@ti.com>
Date:   Mon, 19 Nov 2018 12:18:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181113180656.GE53235@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-11-13 20:06, Tony Lindgren wrote:
> Hi
> 
> * Belisko Marek <marek.belisko@gmail.com> [180703 18:34]:
>> Hi Tony,
>>
>> On Tue, Jul 3, 2018 at 10:45 AM Tony Lindgren <tony@atomide.com> wrote:
>>>
>>> * Belisko Marek <marek.belisko@gmail.com> [180620 09:40]:
>>>> Hello,
>>>>
>>>> I'm trying to fix warning (for omap5 board) produced by recent change
>>>> to avoid using IRQ_TYPE_NONE like:
>>>> [    1.818666] WARNING: CPU: 1 PID: 778 at
>>>> drivers/irqchip/irq-gic.c:1016 gic_irq_domain_translate+0x78/0x100
>>>> [    1.828839] Modules linked in:
>>>>
>>>> I did look to other commit which did update and without deep knowledge
>>>> I just simply do this small change:
>>>> diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi
>>>> b/arch/arm/boot/dts/omap5-board-common.dtsi
>>>> index 218892b..ab2df8c 100644
>>>> --- a/arch/arm/boot/dts/omap5-board-common.dtsi
>>>> +++ b/arch/arm/boot/dts/omap5-board-common.dtsi
>>>> @@ -393,7 +393,7 @@
>>>>
>>>>         palmas: palmas@48 {
>>>>                 compatible = "ti,palmas";
>>>> -               interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>; /* IRQ_SYS_1N */
>>>> +               interrupts = <GIC_SPI 7 IRQ_TYPE_HIGH>; /* IRQ_SYS_1N */
>>>>                 reg = <0x48>;
>>>>                 interrupt-controller;
>>>>                 #interrupt-cells = <2>;
>>>>
>>>> and it looks board boots fine. Only issue is that gpadc driver is not
>>>> working (at least not getting interrupts at all ADC fails with
>>>> timeout). I did look to gpadc driver and driver is not using
>>>> interrupts defined in dts but request interrupt directly from palmas
>>>> mfd module. Any ideas what needs to be changed to have gpadc again
>>>> working with mentioned patch?
>>>
>>> Can you try with IRQF_TRIGGER_HIGH added also to the flags to
>>> regmap_add_irq_chip() in drivers/mfd/palmas.c?
>> Nope issue is till present also after this change like:
>> diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi
>> b/arch/arm/boot/dts/omap5-board-common.dtsi
>> index 218892b..6912769 100644
>> --- a/arch/arm/boot/dts/omap5-board-common.dtsi
>> +++ b/arch/arm/boot/dts/omap5-board-common.dtsi
>> @@ -393,7 +393,7 @@
>>
>>         palmas: palmas@48 {
>>                 compatible = "ti,palmas";
>> -               interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>; /* IRQ_SYS_1N */
>> +               interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_1N */
>>                 reg = <0x48>;
>>                 interrupt-controller;
>>                 #interrupt-cells = <2>;
>> @@ -432,9 +432,9 @@
>>
>>                 gpadc: gpadc {
>>                         compatible = "ti,palmas-gpadc";
>> -                       interrupts = <18 0
>> -                                     16 0
>> -                                     17 0>;
>> +                       interrupts = <18 IRQ_TYPE_LEVEL_HIGH
>> +                                     16 IRQ_TYPE_LEVEL_HIGH
>> +                                     17 IRQ_TYPE_LEVEL_HIGH>;
>>                         #io-channel-cells = <1>;
>>                         ti,channel0-current-microamp = <5>;
>>                         ti,channel3-current-microamp = <10>;
>> diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
>> index 663a239..15d23db 100644
>> --- a/drivers/mfd/palmas.c
>> +++ b/drivers/mfd/palmas.c
>> @@ -601,7 +601,7 @@ static int palmas_i2c_probe(struct i2c_client *i2c,
>>         regmap_write(palmas->regmap[slave], addr, reg);
>>
>>         ret = regmap_add_irq_chip(palmas->regmap[slave], palmas->irq,
>> -                                 IRQF_ONESHOT | pdata->irq_flags, 0,
>> +                                 IRQF_ONESHOT | IRQF_TRIGGER_HIGH |
>> pdata->irq_flags, 0,
>>                                   driver_data->irq_chip, &palmas->irq_data);
>>         if (ret < 0)
>>                 goto err_i2c;
> 
> Looks like the IRQ_TYPE_NONE issue still is there for omap5 and
> should be fixed with IRQ_TYPE_HIGH.
> 
> No idea about why palmas interrupts would stop working though,
> Peter, do you have any ideas on this one?

No, I don't.
The INT polarity can be changed in Palmas.
based on the pdata->irq_flags (queried via irqd_get_trigger_type())
the code  configures it:

if (pdata->irq_flags & IRQ_TYPE_LEVEL_HIGH)
	reg = PALMAS_POLARITY_CTRL_INT_POLARITY;
else
	reg = 0;

and we pass the same irq_flags to the regmap_add_irq_chip()
IRQ_TYPE_LEVEL_HIGH == IRQF_TRIGGER_HIGH == 0x00000004

A change in DT should be enough, no need to patch palmas.c, imho.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
