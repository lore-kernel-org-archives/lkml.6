Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A405EC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7F121A27
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7F121A27
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tronnes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbeHHSwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:52:01 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:41998 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbeHHSwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:52:00 -0400
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:60385 helo=[192.168.10.173])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1fnRMx-0006HR-Dz; Wed, 08 Aug 2018 18:31:31 +0200
Subject: Re: [PATCH v1 5/5] tinydrm: add winstar wg160160 driver
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20180802193909.GA11443@ravnborg.org>
 <20180802194536.10820-5-sam@ravnborg.org>
 <16dfa544-e454-f59b-91ef-9bac7bf1b490@tronnes.org>
 <20180808083238.GA17613@ravnborg.org>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <2f8c6467-4aa4-47d6-56ad-dc1252a2ffa2@tronnes.org>
Date:   Wed, 8 Aug 2018 18:31:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180808083238.GA17613@ravnborg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Den 08.08.2018 10.32, skrev Sam Ravnborg:
> Hi Noralf.
>
> On Tue, Aug 07, 2018 at 07:35:30PM +0200, Noralf Trønnes wrote:
>> Den 02.08.2018 21.45, skrev Sam Ravnborg:
>>> Add driver for the winstar wg160160 display.
>>> The driver utilises pardata-dbi that
>>> again utilise the pardata subsystem.
>>>
>>> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
>>> ---
>>>   MAINTAINERS                        |   5 +
>>>   drivers/gpu/drm/tinydrm/Kconfig    |  10 ++
>>>   drivers/gpu/drm/tinydrm/Makefile   |   1 +
>>>   drivers/gpu/drm/tinydrm/wg160160.c | 298 +++++++++++++++++++++++++++++++++++++
>>>   4 files changed, 314 insertions(+)
>>>   create mode 100644 drivers/gpu/drm/tinydrm/wg160160.c
>>>
>> [...]
>>
>>> +
>>> +/**
>>> + * write_reg - Write instruction on parallel bus to controller
>>> + *
>>> + * Check BUSY flag and write instruction
>>> + *
>>> + * @pdd: pardata data
>>> + * @reg: The register to write
>>> + * @value: The value of the register
>>> + *
>>> + * Returns:
>>> + * Zero on success, negative error code on failure
>>> + */
>>> +int write_reg(struct pardata_data *pdd, unsigned int reg, unsigned int value)
>>> +{
>>> +	int ins[PIN_NUM];
>>> +	int val[PIN_NUM];
>>> +	int i;
>>> +
>>> +	for (i = 0; i < PIN_NUM; i++)
>>> +		ins[PIN_DB0 + i] = !!BIT(reg);
>>> +
>>> +	for (i = 0; i < PIN_NUM; i++)
>>> +		val[PIN_DB0 + i] = !!(value & BIT(i));
>>> +
>>> +	gpiod_set_value_cansleep(pdd->bus->pin_rs, 1);
>>> +	gpiod_set_array_value_cansleep(PIN_NUM, pdd->bus->data_pins->desc, ins);
>>> +	wait_busy(pdd);
>>> +	pardata_strobe_write(pdd);
>>> +
>>> +	gpiod_set_value_cansleep(pdd->bus->pin_rs, 0);
>>> +	gpiod_set_array_value_cansleep(PIN_NUM, pdd->bus->data_pins->desc, val);
>>> +	wait_busy(pdd);
>>> +	pardata_strobe_write(pdd);
>>> +
>>> +	return 0;
>>> +}
>> If this controller has normal registers, you could do a regmap
>> implementation for pardata: drivers/base/regmap.
> If I understand you correct then you suggest to add a regmap implementation
> on top of the registers replacing the current gpio support?
>
> So we in regmap can optimize access to the registers better.
> Or did you have something else in mind?

I was thinking of a regmap-pardata.c like drivers/base/regmap/regmap-i2c.c.
It's not much code an we would avoid having generic register access
functions in DRM. It's not about speed or caching, but just to try and
put code where it logically belongs.

Here is one experiment where I have created a regmap on a 8080 bus:
https://github.com/notro/tinydrm/blob/master/tinydrm-regmap.c
Used here: https://github.com/notro/tinydrm/blob/master/fb_ili9325.c

I don't advocate this particular approach, I mention it just as an
example of using regmap in a tinydrm driver.

Noralf.

> As speed is not the main challenge here I will likely wait with this
> and continue using gpio.
>
> 	Sam

