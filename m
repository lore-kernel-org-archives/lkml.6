Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854F5C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297B920844
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aG72uVsg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="D1IvOU3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 297B920844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeH2LFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:05:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39074 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbeH2LFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:05:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 456026053D; Wed, 29 Aug 2018 07:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535526625;
        bh=iUlkSq7XjKJtBscNoP3fcsz2HPHDzrTiiduCKEXf0k0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aG72uVsg9AOsenLnoBEnh0uaOITC5dh1y1Bqu/tyjFuR5ARK+f7nwOqk1byn/hutr
         RmUARpBG81dJyCNbQf2QGBRsHJBW1zA9D/8isUfQqyJfFdMBY+uA0uaBqATqEaOzvv
         7b+q1ZQ0ylIC7AchTjyFzaS1ZUkr40IQAgr4zxog=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 3528560227;
        Wed, 29 Aug 2018 07:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535526624;
        bh=iUlkSq7XjKJtBscNoP3fcsz2HPHDzrTiiduCKEXf0k0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D1IvOU3R1ia5UFFdtukhfg5laKUvHcz7LfnExRw585b16gMmf/6y0L+mfJmsp7bUl
         oEeALDtMi0ZoBtCn9oyCDjWhuh5G9uBNfagAKIMpSVBTYl6eoDb6Nax7Wcrlha1+al
         jfmadVfuz5ghnEVZNRPVRkWX9jgFqrr7IAimTNWk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 29 Aug 2018 12:40:24 +0530
From:   kgunda@codeaurora.org
To:     Pavel Machek <pavel@ucw.cz>
Cc:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, daniel.thompson@linaro.org,
        jacek.anaszewski@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V5 5/8] backlight: qcom-wled: Restructure the driver for
 WLED3
In-Reply-To: <20180827100939.GG31905@amd>
References: <1535106467-17843-1-git-send-email-kgunda@codeaurora.org>
 <1535106467-17843-6-git-send-email-kgunda@codeaurora.org>
 <20180827100939.GG31905@amd>
Message-ID: <bcd99b19d4a7586ba47c05b8b5bd2bcf@codeaurora.org>
X-Sender: kgunda@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-27 15:39, Pavel Machek wrote:
> On Fri 2018-08-24 15:57:44, Kiran Gunda wrote:
>> Restructure the driver to add the support for new WLED
>> peripherals.
>> 
>> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
>> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
>> ---
>> Changes from V3:
>>     - This is the new patch after splitting the
>>       "backlight: qcom-wled: Add support for WLED4 peripheral" patch
>>       to seperate the WLED3 specific restructure.
>> 
>> Changes from V4:
>>     - Initialize wled->cfg.enabled_strings to 0,1,2,3.
>>     - Replaced the WLED3 macro with 3.
>> 
>>  drivers/video/backlight/qcom-wled.c | 395 
>> ++++++++++++++++++++++--------------
>>  1 file changed, 245 insertions(+), 150 deletions(-)
>> 
>> diff --git a/drivers/video/backlight/qcom-wled.c 
>> b/drivers/video/backlight/qcom-wled.c
>> index 3cd6e75..a746bec 100644
>> --- a/drivers/video/backlight/qcom-wled.c
>> +++ b/drivers/video/backlight/qcom-wled.c
>> @@ -15,59 +15,71 @@
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>>  #include <linux/of_device.h>
>> +#include <linux/of_address.h>
>>  #include <linux/regmap.h>
>> 
>>  /* From DT binding */
>> +#define WLED_MAX_STRINGS				4
>> +
>>  #define WLED_DEFAULT_BRIGHTNESS				2048
>> 
>> -#define WLED3_SINK_REG_BRIGHT_MAX			0xFFF
>> -#define WLED3_CTRL_REG_VAL_BASE				0x40
>> +#define WLED_SINK_REG_BRIGHT_MAX			0xFFF
> 
> Stop this, no. In previous patch you renamed from ABC123_ to WLED3_,
> now you are renaming back to WLED?
> 
> Stop messing with the names. I'd actually prefer you to stick with
> original driver name, and just add note that this now supports more
> hardware.
> 
> But yes, _one_ rename is okay. I guess. But renaming it twice in one
> series is not acceptable.
> 
ok. I will stop renaming from WLED3 to WLED in this patch. I did it 
because these registers
are common for both WLED3 and WLED4 and Bjorn also suggested the same. 
Anyways I will stop
this renaming in this patch from WLED3 to WLED.

>> @@ -365,6 +433,15 @@ static int wled_configure(struct wled *wled, 
>> struct device *dev)
>> 
>>  	cfg->num_strings = cfg->num_strings + 1;
>> 
>> +	string_len = of_property_count_elems_of_size(dev->of_node,
>> +						     "qcom,enabled-strings",
>> +						     sizeof(u32));
>> +	if (string_len > 0)
>> +		rc = of_property_read_u32_array(dev->of_node,
>> +						"qcom,enabled-strings",
>> +						wled->cfg.enabled_strings,
>> +						sizeof(u32));
>> +
>>  	return 0;
>>  }
> 
> rc is assigned but never used.
Will address it next series.
> 									Pavel
