Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD8BC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B0D214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qwXn1UEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B0D214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbeIZQgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 12:36:53 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50030 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbeIZQgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 12:36:53 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8QAOZ44018067;
        Wed, 26 Sep 2018 05:24:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537957475;
        bh=x6XFqD5p4e4clCNru816FSciA/vyqqXsmOyBE8bEoNI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qwXn1UEQSrD6GEMx5NinDBy7U7xiCqRBpHBh7zLqVqjNTcvduEVVLZELMmVHRkfdI
         B9QX7n3GHrJy6JVYc5+0xZ3aO+lv9XBfD/VQMCmxnLZxA7Ig+5OvekoW49lPT7XPgW
         GWlKmvMBdOObmaG3vU1zJqxg1MMoc/Rtkmyk397Y=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8QAOZlC001093;
        Wed, 26 Sep 2018 05:24:35 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 26
 Sep 2018 05:24:34 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 26 Sep 2018 05:24:34 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8QAOWN7022919;
        Wed, 26 Sep 2018 05:24:33 -0500
Subject: Re: [PATCH RESEND] backlight: gpio-backlight: Correct initial power
 state handling
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        <lee.jones@linaro.org>, <jingoohan1@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180508070426.32211-1-peter.ujfalusi@ti.com>
 <cb603304-2052-2586-1673-96ab421a5547@linaro.org>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <94685994-98ff-2a1d-901c-6d3cce71db16@ti.com>
Date:   Wed, 26 Sep 2018 13:25:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cb603304-2052-2586-1673-96ab421a5547@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel,

On 2018-06-13 18:11, Daniel Thompson wrote:
> On 08/05/18 08:04, Peter Ujfalusi wrote:
>> The default-on property - or the def_value via legacy pdata) should be
>> handled as:
>> if it is 1, the backlight must be enabled (kept enabled)
>> if it is 0, the backlight must be disabled (kept disabled)
>>
>> This only works for the case when default-on is set. If it is not set
>> then
>> the brightness of the backlight is set to 0. Now if the backlight is
>> enabled by external driver (graphics) the backlight will stay disabled
>> since
>> the brightness is configured as 0. The backlight will not turn on.
>>
>> The correct action at probe time is to configure the props.power to
>> FB_BLANK_UNBLANK if we want the backlight on by default or to
>> FB_BLANK_POWERDOWN if the backlight should be off by default.
>>
>> The initial brightness should be set to 1.
> 
> Hmnn... I guess this comes down to the definition of "on" for a binary
> 
> Actually I'm a little worried that backlight already has too many
> different behaviors and that this patch introduces another way for them
> to be different!
> 
> Is there any mileage in adopting the same approach as PWM backlight for
> blank/unblank management as a way to get a flicker free boot?

This patch is merely fixing a bug in the driver.

> For PWM the default property controls the initial brightness and the
> initial power state is unblanked *unless* there is a phandle link to the
> node, in which case we inherit whatever the power state the bootloader
> had configured before the driver probed.
> 
> Put another way, what happens is we implement
> gpio_backlight_initial_power_state() to perform a similar task to
> pwm_backlight_initial_power_state().

I agree, but what should we do with the default-on parameter?

non DT boot or DT boot, no phandle link:
default-on ? FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN

DT boot and phandle link:
if the GPIO was enabled by the bootloader: FB_BLANK_UNBLANK
if the GIOP was not enabled by the bootloader: FB_BLANK_POWERDOWN

I think this will mimic closely what the
pwm_backlight_initial_power_state() does.

- Péter

> 
> 
> Daniel.
> 
> 
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>> Hi,
>>
>> for some reason the original patch got lost:
>> https://patchwork.kernel.org/patch/9445539/
>>
>> But it is still valid, so I'm resending it.
>>
>> Regards,
>> Peter
>>
>>   drivers/video/backlight/gpio_backlight.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/backlight/gpio_backlight.c
>> b/drivers/video/backlight/gpio_backlight.c
>> index e470da95d806..904a4462cefe 100644
>> --- a/drivers/video/backlight/gpio_backlight.c
>> +++ b/drivers/video/backlight/gpio_backlight.c
>> @@ -142,7 +142,9 @@ static int gpio_backlight_probe(struct
>> platform_device *pdev)
>>           return PTR_ERR(bl);
>>       }
>>   -    bl->props.brightness = gbl->def_value;
>> +    bl->props.power = gbl->def_value ? FB_BLANK_UNBLANK :
>> FB_BLANK_POWERDOWN;
>> +    bl->props.brightness = 1;
>> +
>>       backlight_update_status(bl);
>>         platform_set_drvdata(pdev, bl);
>>
> 

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
