Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EB9C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 02:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449E82073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 02:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GnDHyN64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449E82073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbeIEHL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 03:11:56 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38799 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeIEHL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 03:11:56 -0400
Received: by mail-oi0-f68.google.com with SMTP id x197-v6so10824640oix.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 19:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yj65X8yHMePEK1pjQXEf71vUUfZKI0OOItdWh4xAtB4=;
        b=GnDHyN64cVpVV/dgdmll6JU24IQi/b6vksZ+z/zselAy/+/nGVacaJoC5u/BBVuza0
         ZQbg99eQJxEaz3kVuADFAS+cYOkRWSUHY7AeLmroMP9+GhxZtM2zHhvx81SxcdCsh/+v
         Hh1kicRsUTDYi+wBDdUFhhfzLwNusFeD2JLW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yj65X8yHMePEK1pjQXEf71vUUfZKI0OOItdWh4xAtB4=;
        b=d2mImbScntVvwrrq5l3jAC8budlTbYmPycZ6S9TYh6IFyP6R9C/MPcKwJyg+EwtuWq
         aAiH1APUDHcoZf9O516fD8JGOrqHvi86ZAYyPmFVQf9jVaD+u1M2EbLopGHVz7TeY925
         JAepZ+4NVGgdpSlfqsa9mZfB5N4GOl8h3vpaGBEXjKKi7zqp7SszeQpaLaExu68K1b//
         sm4d9EGz12o3Rv/z556lpMMW3KWPR6UJdvj6F4kMOevYTLvwp16jC21S+A6TcmBg9i5I
         okBgS2Ynx3qgu6o4rnQj+fppwnSNc1TWgdQMUGtHNLt2gRYAIHH5lmXDYtTJIHpq0gM/
         mOjw==
X-Gm-Message-State: APzg51C1sdSdjvF5D1XFvnDtpSQZv0qJ2fhqHIMjF6S9L43/6bTVwRlo
        706OSp05cL1u/jOcZLYgWJ9abVABT/AUfFQ/fVKdIQ==
X-Google-Smtp-Source: ANB0VdYFtx3nbnVHbwUdZ+tdr1qgBk7P2HqMg9M5cRHAuvZVj5OvXVcgp+J74P1UNS0WU+DinFNLIAWDR7UzY/sgmkk=
X-Received: by 2002:aca:5dc5:: with SMTP id r188-v6mr29011126oib.320.1536115439920;
 Tue, 04 Sep 2018 19:43:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3ec8:0:0:0:0:0 with HTTP; Tue, 4 Sep 2018 19:43:59 -0700 (PDT)
In-Reply-To: <ff34b0fd-dd56-f239-94a9-d84673f6869a@gmail.com>
References: <5a502ec29251c019ddad8f3314ab45fc0f6feaf7.1536027873.git.baolin.wang@linaro.org>
 <e7642c73ac1c20b97990a887f76f2f51c41f930b.1536027873.git.baolin.wang@linaro.org>
 <ff34b0fd-dd56-f239-94a9-d84673f6869a@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 5 Sep 2018 10:43:59 +0800
Message-ID: <CAMz4kuJJUXe-z5s5cRQG19Yj4RE3uVqOCdWNpOX3f+wvW+WbrQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] leds: sc27xx: Add pattern_set/clear interfaces for
 LED controller
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, rteysseyre@gmail.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacek,

On 5 September 2018 at 04:19, Jacek Anaszewski
<jacek.anaszewski@gmail.com> wrote:
> Hi Baolin,
>
> On 09/04/2018 01:01 PM, Baolin Wang wrote:
>> This patch implements the 'pattern_set'and 'pattern_clear'
>> interfaces to support SC27XX LED breathing mode.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>> Changes from v7:
>>  - Add its own ABI documentation file.
>>
>> Changes from v6:
>>  - None.
>>
>> Changes from v5:
>>  - None.
>>
>> Changes from v4:
>>  - None.
>>
>> Changes from v3:
>>  - None.
>>
>> Changes from v2:
>>  - None.
>>
>> Changes from v1:
>>  - Remove pattern_get interface.
>> ---
>>  .../ABI/testing/sysfs-class-led-driver-sc27xx      |   11 +++
>>  drivers/leds/leds-sc27xx-bltc.c                    |   94 ++++++++++++++++++++
>>  2 files changed, 105 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx b/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
>> new file mode 100644
>> index 0000000..ecef3ba
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
>> @@ -0,0 +1,11 @@
>> +What:                /sys/class/leds/<led>/hw_pattern
>> +Date:                September 2018
>> +KernelVersion:       4.20
>> +Description:
>> +             Specify a hardware pattern for the SC27XX LED. For the SC27XX
>> +             LED controller, it only supports 4 hardware patterns to configure
>
> If I understand it correctly then the four components: low, rise, high,
> and fall time make a single pattern. So calling it "4 hardware patterns"
> can be misleading. Below you're using "stage" notion - it would be good
> to use it consequently on the whole span of this document.

Sure. I will modify the documentation to avoid misleading words.

>
>> +             the low time, rise time, high time and fall time for the breathing
>> +             mode, and each stage duration unit is 125ms. So the format of
>> +             the hardware pattern values should be:
>
> I'd be more precise here:
>
> Min stage duration: ???
> Max stage duration: ???
> Stage duration step: 125 ms

OK.

>
>> +             "brightness_1 duration_1 brightness_2 duration_2 brightness_3
>> +             duration_3 brightness_4 duration_4".
>
> Looking at sc27xx_led_pattern_set() it doesn't seem like you would
> use brightnesses other then brightness_1. I assume that the low
> brightness is fixed to 0 and the high brightness is the brightness_1.
> If yes, than we don't need brightnesses in this pattern definition,
> since the current brightness will suffice.
>
> You'd need to alter the hw_pattern description to say that the
> brightness currently set is to be used as a high brightness, and the
> hw_pattern for this driver consists only of the four delta_t components.

Sorry for confusing here. For SC27XX LED, the 4 stages use one same
brightness. To be compatible with the hardware pattern format, so we
force to set one brightness for each stage. I will add some comments
to explain the LED expects the same brightness for each stage instead
of using the current brightness file which is not used for our
breathing mode.

>
> This is clear example of what I had on mind when having doubts
> about using tuples for pattern_set.
>
> Alternatively, if we want to enforce tuples format for hw_pattern,
> and if we want to be consistent - we'd need to require defining target
> brightness for each stage properly, i.e.
>
> echo "100 500 100 500 0 500 0 500" > pattern
>
> Which would mean:
>
> 1. Rise from brightness 0 to 100 for 500 ms.
> 2. Keep brightness 100 for 500 ms.
> 3. Fall from brightness 100 to 0 for 500 ms.
> 4. Keep brightness 0 for 500 ms.
>
> --
> Best regards,
> Jacek Anaszewski



-- 
Baolin Wang
Best Regards
