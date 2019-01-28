Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62168C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3181621738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f38SoXvk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbfA1OCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:02:54 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45169 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfA1OCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:02:53 -0500
Received: by mail-pf1-f193.google.com with SMTP id g62so8015808pfd.12;
        Mon, 28 Jan 2019 06:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IvdgvvM1zSo9lb//eNAzGmoMv0AyVL5+L6ujVkAvDFQ=;
        b=f38SoXvklsLBpQGbCwmRDBZujc+wQkokCfZsOemPFBM2JJM4OYHJIwp05O/Aa55TLU
         n1wHp/bZUYl2PDsIlYjIdrr8wohZ/ho/9ZqOm90yQ21KmZBLgi9bX+wP4ba4zLFEyzCM
         AUi/DJJZk2GSd+f/aR/t9B2804cIg0WTAjBwJ0PQwNGLRxQSyWOeG/rBxMsmNRePrLsE
         Nivu8Rnfi+bFNEi90Q2i1k6jpT36KnokhS2A+Tk1G+E4inSLaJoKHS64gfxgIFD52BQO
         5zR5Pl/nj/G4WxV1J6b3GP4B66yIurRfDRGHC/Q5zBLbOqOFvECS+UVc3azJanv9EbXj
         yPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IvdgvvM1zSo9lb//eNAzGmoMv0AyVL5+L6ujVkAvDFQ=;
        b=S1ietF5f1haK3EgnxveJBwELNBsrWq175KbJtrGnPmLnp6cHns2EQvISm1mHDdVI89
         KZZYeMb2c2i77EFYJuiM6dEie8R3GYq996l1xPBetahF9QfYKe0FDtr5JZAr3IEBAL70
         5DEoUOUZXj6xo6YU8Baf9+0ULnro4SDQzufi/N4cfJVqLV6qBSaiYyr2BZ5M1xIeaKmg
         7EJ3sVfLOW84lXBYX5TgYY7APlESufydUGGM4u8KnKHnMDk7benjQfGzkh6tLkrtvdj/
         zWE+t51AXNhHVkRlq6COaRhsFTZHtgFG/c5PbhgZCWr3DZSg8W2purLWq5OICdafoYCq
         /WKw==
X-Gm-Message-State: AJcUukf1b5Cv4iYVB85IQLlRA0y8NIHSG/4zg41K13Z+PX2RyRhOF8lA
        cXos7howE4LTiGW4XrzAteEew2XD
X-Google-Smtp-Source: ALg8bN6g1EdXZPIK8zwaYk1JO0Uh7jHgtLvj8FNG/4Q6xjNRdAPfEQpFOhRiM2qT8kT+aZq5oAfLPg==
X-Received: by 2002:a63:ce50:: with SMTP id r16mr19752271pgi.217.1548684172008;
        Mon, 28 Jan 2019 06:02:52 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o84sm66186036pfi.172.2019.01.28.06.02.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 06:02:50 -0800 (PST)
Subject: Re: [RFC PATCH v2 08/10] rtc: bd70528: Initial support for ROHM
 bd70528 RTC
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org
References: <20190125110536.GA29321@localhost.localdomain>
 <35bbc5b9-5f8c-ec80-3eaa-bb2c0e2812c9@roeck-us.net>
 <20190128074849.GB2030@localhost.localdomain>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <11ff93bf-c71f-7489-841f-09bf757a8ba7@roeck-us.net>
Date:   Mon, 28 Jan 2019 06:02:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190128074849.GB2030@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/19 11:48 PM, Matti Vaittinen wrote:
> Thanks again Guenter,
> 
> On Sat, Jan 26, 2019 at 08:30:24AM -0800, Guenter Roeck wrote:
>> On 1/25/19 3:05 AM, Matti Vaittinen wrote:
>>> +/*
>>> + * We read regs RTC_SEC => RTC_YEAR
>>> + * this struct is ordered according to chip registers.
>>> + * Keep it u8 only to avoid padding issues.
>>> + */
>>> +struct bd70528_rtc_day {
>>> +	u8 sec;
>>> +	u8 min;
>>> +	u8 hour;
>>> +};
>>> +
>>> +struct bd70528_rtc_data {
>>> +	struct bd70528_rtc_day time;
>>> +	u8 week;
>>> +	u8 day;
>>> +	u8 month;
>>> +	u8 year;
>>> +};
>>> +
>>> +struct bd70528_rtc_wake {
>>> +	struct bd70528_rtc_day time;
>>> +	u8 ctrl;
>>> +};
>>> +
>>> +struct bd70528_rtc_alm {
>>> +	struct bd70528_rtc_data data;
>>> +	u8 alm_mask;
>>> +	u8 alm_repeat;
>>> +};
>>
>> At least some of the above are directly associated with chip registers.
>> I don't think this will work for all architectures without explicit packed
>> attribute.
> 
> Allright. I was thinking of that but thought that most of the
> architectures using this PMIC would handle alignments fine if I used
> only u8 members. I did consider using __attribute__((packed)) - but I'm
> not sure if we hit into troubles with that too. I guess some people
> would like to compile kernel with other compiler(s) but gcc - although
> I'm not sure if this should be taken into account. I'll try doing some
> study on this - unless someone replies to this and just tells how this
> should be done. (I am pretty sure I can find the answer from mail
> archives though). I'll try adding some packing hint for compiler at v3.
> 

Use __packed ?

>>> +		if ((!enable) == (!(*old_state & BD70528_WAKE_STATE_BIT)))
>>> +			return 0;
>>
>> I think
>> 		if (enable == !!(*old_state & BD70528_WAKE_STATE_BIT))
>> would be much better readable. Even if not, there are way too many ()
>> in the above conditional.
> 
> Allright. I'll fix this
>   
>>> +	if (alm.alm_mask & BD70528_MASK_ALM_EN)
>>> +		a->enabled = 0;
>>> +	else
>>> +		a->enabled = 1;
>>> +
>> Without conditional:
>> 	a->enabled = !(alm.alm_mask & BD70528_MASK_ALM_EN);
>>
> 
> Right. Much nicer, thanks! I'll change this.
> 
>>> +static int bd70528_set_time(struct device *dev, struct rtc_time *t)
>>> +{
>>> +	int ret, old_states;
>>> +	struct bd70528_rtc_data rtc_data;
>>> +	struct bd70528_rtc *r = dev_get_drvdata(dev);
>>> +	struct bd70528 *bd70528 = r->mfd;
>>> +
>>> +	ret = bd70528_disable_rtc_based_timers(r, &old_states);
>>> +
>>
>> AFAICS the disable/enable functions are only called once. Since they
>> also apply set / clear a mutex, I find that a bit confusing. I think
>> it would be better to fold the code into this function. If anything,
>> I could imagine something like
>>
>> 	mutex_lock();
>> 	ret = bd70528_set_time_locked();
>> 	mutex_unlock()
>>
>> to simplify error handling.
> 
> Yep. Makes sense. I'll tidy this.
> 
>>> +	ret = regmap_bulk_read(bd70528->chip.regmap,
>>> +			       BD70528_REG_RTC_START, &rtc_data,
>>> +			       sizeof(rtc_data));
>>> +
>>> +	tm2rtc(t, &rtc_data);
>>> +
>>> +	ret = regmap_bulk_write(bd70528->chip.regmap,
>>> +				BD70528_REG_RTC_START, &rtc_data,
>>> +				sizeof(rtc_data));
>>> +
>>> +	ret = bd70528_re_enable_rtc_based_timers(r, old_states);
>>> +
>>
>> Kind of off that all the error returns are ignored here.
> 
> And I'll fix this too.
> 
> Br,
> 	Matti Vaittinen
> 

