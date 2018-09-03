Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9ACC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FEB22075E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyjIX9g5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FEB22075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeICSpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:45:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36193 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbeICSpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:45:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id m27-v6so887744wrf.3;
        Mon, 03 Sep 2018 07:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8H+2+Vilw5nuvgG9FY3LKDeo0BV+IY/skCVeF/QCu2w=;
        b=CyjIX9g5Z2lhGRYzWQQgA1k835VgagzTXCIY1zLFm3Zl1XkwRmn3x/3crAj472EWCF
         28tk3DVG+RxwcEqRluZZa1l7uArRbeh3Fbk+PZkWNKEmuMvd21md9SR8m3Clxe/xlAyI
         x/xhqIZjTRuw1afyyy8QimnkMSqwslP92b5MitZSzeYs6NSmMEHnIu2NISsv5Wrb7JG7
         EgoX9h4GZUYpwtxRERfDXV4s7B37edsG2QDE9M3f4finpkX54PDaSgwiHnP11e/uypFL
         Q7zm+EA8TE/mu7LfIWz9vyFeAsfZ6No51vzYdDWkHGBuT9WvOdHW2Ny191PYc68DBGSz
         XSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8H+2+Vilw5nuvgG9FY3LKDeo0BV+IY/skCVeF/QCu2w=;
        b=cY2kpSCx6F54LjjjwuXZ1Beywje3u2nlDYtqnRY18cTe83zV2/fDmwudZc4bCBJhFS
         5RDAfWbFusTJSRWOAE0tHm1GCFXg8ZNXHIHWxXED12iPx5tsViXkEVSJg6xOkKoUtST6
         pz24UeUVj/9PTqNvurrYnWM99p8YZTWmzXWWp5yseQJ+ie9j4SRhBze020WNKMu2Xps/
         gBGQ47LQ/WmcUDtGbnLWuo8kp8/sU5HLN442GBybPWtDueZx3/YR8ibSRjCapqc03pKB
         ZvYB+173U7+I/5i7h6UfjmngdVwRQBJBupFgnSmzIeOG0w7YN7muDi8CbqvsD7OcDxAr
         Hpmw==
X-Gm-Message-State: APzg51DuKl6h/+kUmeG+l5E/A6O5skxLMtcazn/m6LC8a7i04/uf6RmB
        YYMlfZHnV+fg3ZR7HT0sq2E=
X-Google-Smtp-Source: ANB0VdYR/NQouNHY6Jb+41U8Gs1yDxdU+1DlhnXSrfJXRsz7ff2gZ6yIYI6FrpMDLtaQGDk26dCZrQ==
X-Received: by 2002:a5d:494c:: with SMTP id r12-v6mr19335426wrs.244.1535984674974;
        Mon, 03 Sep 2018 07:24:34 -0700 (PDT)
Received: from [10.104.3.222] (eduroam-nat1.rz.uni-ulm.de. [134.60.112.236])
        by smtp.gmail.com with ESMTPSA id 184-v6sm22784205wmv.6.2018.09.03.07.24.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 07:24:34 -0700 (PDT)
Subject: Re: [PATCH v3 05/30] iio: adc: move SUN4I_GPADC_CHANNEL define to
 header file
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        eugen.hristev@microchip.com, rdunlap@infradead.org,
        vilhelm.gray@gmail.com, clabbe.montjoie@gmail.com,
        quentin.schulz@bootlin.com, geert+renesas@glider.be,
        lukas@wunner.de, icenowy@aosc.io, arnd@arndb.de,
        broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-6-embed3d@gmail.com>
 <20180902210109.7bd4a567@archlinux>
From:   Philipp Rossak <embed3d@gmail.com>
Message-ID: <882cb5f9-867b-d120-5ef5-80a8bee2d628@gmail.com>
Date:   Mon, 3 Sep 2018 16:24:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180902210109.7bd4a567@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.09.2018 22:01, Jonathan Cameron wrote:
> On Thu, 30 Aug 2018 17:44:53 +0200
> Philipp Rossak <embed3d@gmail.com> wrote:
> 
>> We are moving the SUN4I_GPADC_CHANNEL define to the header file.
> Maxime has raised this point in other patches...
> 
> Why?  Obvious what but I have no idea why you are doing this.
> 
> Thanks,
> 
> Jonathan
There are two reasons:
1. Personal taste: I like to have the #define stuff in the header file.
2. When I started the rework I had to get some better overview, so I 
moved it...

Since those two reasons are no good reasons to submit a patch I will 
drop it and keep it in the *.c file.

Philipp

>>
>> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
>> ---
>>   drivers/iio/adc/sun4i-gpadc-iio.c | 9 ---------
>>   include/linux/mfd/sun4i-gpadc.h   | 9 +++++++++
>>   2 files changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
>> index d95dd0fde2a6..666329940e1e 100644
>> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
>> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
>> @@ -109,15 +109,6 @@ struct sun4i_gpadc_iio {
>>   	struct device			*sensor_device;
>>   };
>>   
>> -#define SUN4I_GPADC_ADC_CHANNEL(_channel, _name) {		\
>> -	.type = IIO_VOLTAGE,					\
>> -	.indexed = 1,						\
>> -	.channel = _channel,					\
>> -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>> -	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
>> -	.datasheet_name = _name,				\
>> -}
>> -
>>   static struct iio_map sun4i_gpadc_hwmon_maps[] = {
>>   	{
>>   		.adc_channel_label = "temp_adc",
>> diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4i-gpadc.h
>> index 139872c2e0fe..54c7c9375c1b 100644
>> --- a/include/linux/mfd/sun4i-gpadc.h
>> +++ b/include/linux/mfd/sun4i-gpadc.h
>> @@ -90,6 +90,15 @@
>>   /* 10s delay before suspending the IP */
>>   #define SUN4I_GPADC_AUTOSUSPEND_DELAY			10000
>>   
>> +#define SUN4I_GPADC_ADC_CHANNEL(_channel, _name) {		\
>> +	.type = IIO_VOLTAGE,					\
>> +	.indexed = 1,						\
>> +	.channel = _channel,					\
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
>> +	.datasheet_name = _name,				\
>> +}
>> +
>>   struct sun4i_gpadc_dev {
>>   	struct device			*dev;
>>   	struct regmap			*regmap;
> 
