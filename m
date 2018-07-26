Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9D6C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893602083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="OL7QpDEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 893602083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731823AbeGZSyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 14:54:16 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:58678 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731011AbeGZSyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 14:54:15 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 8A8C35C19DE;
        Thu, 26 Jul 2018 19:36:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1532626582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CFfHwf+MuYA4c2goNCU8WD1b+Eb5pQqGpLhgS5hr7ZQ=;
        b=OL7QpDEkNOpZVSc16GdhS37SrnCOflmDcWLY8q0lQ63W9zN80dYUYrVLjTwcpdtVSs337N
        qQQw1iNnYshfK9m5lNRZPBFFa5nOoyZmhLM3wc+hV3KKNiTAZKJ3ZiWcYMm97SjPrDfDJt
        oRUbEiCgA+QjwTKspjaEBDQaooXh2xE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 26 Jul 2018 19:36:22 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        marcel.ziswiler@toradex.com, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra-owner@vger.kernel.org
Subject: Re: [PATCH 3/3] mmc: tegra: prevent ACMD23 on Tegra 3
In-Reply-To: <12ae1da9-cd09-b15d-9a81-461ca9cc06d7@gmail.com>
References: <20180712073904.4705-1-stefan@agner.ch>
 <20180712073904.4705-3-stefan@agner.ch>
 <430c718d-9ede-d47a-44c0-b8e47e297720@gmail.com>
 <1553c44e99b96a813af129d1c4169222@agner.ch>
 <553f9ed6-8f7c-775b-d731-fd9732f74b07@gmail.com>
 <7edc8c666dbbc0743221c86286ff583a@agner.ch>
 <12ae1da9-cd09-b15d-9a81-461ca9cc06d7@gmail.com>
Message-ID: <24fffc2c52b58301c37d95fe5d1ad355@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [1.40 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[10];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.07.2018 18:39, Peter Geis wrote:
>>>>> I finally got around to testing this on the Ouya (Tegra 3).
>>>>
>>>> Thanks for testing!
>>>>
>>>>>
>>>>> I found that the "Got command interrupt 0x00010000 even though no
>>>>> command operation was in progress." error occurred when the interface
>>>>> is unstable.
>>>>> I've had a lot of problems with sdmmc4 stability on the Ouya above 34
>>>>> Mhz, probably due to the fact that they are using the internal cmd and
>>>>> clock pull-up resistors, against the TRM's instruction.
>>>>> At 39Mhz, I saw the error this patch corrects.
>>>>> With the patch, the error went away, but the interface is still
>>>>> unstable under load.
>>>>
>>>> How does this instability manifest exactly?
>>>>
>>>
>>> At the very edge of stability, you see write errors under heavy load.
>>> As clock rate increases, the write errors occur more frequently.
>>> At a certain point, you start getting read errors.
>>> Following that you get constant io errors during card probing.
>>> Eventually the emmc will fail to initialize, with errors 87 or 110.
>>
>> What mode are you running at actually? E.g. what is the ios file saying?
>> cat /sys/kernel/debug/mmcX/ios
> 
> This is the best functionality I've been able to get prior to the patches:
> root@ouya:~# cat /sys/kernel/debug/mmc0/ios
> clock:          30000000 Hz
> actual clock:   29142858 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      3 (8 bits)
> timing spec:    9 (mmc HS200)
> signal voltage: 1 (1.80 V)
> driver type:    0 (driver type B)
> 

Yeah HS200 is definilty not supported by the controller and really
should not be used.

> Now I am trying DDR, but even with the patches I'm not able to remain
> stable above 17Mhz (34Mhz clock).
> 
> I've also tried just straight mmc-hs mode, but even that makes no difference.
> 

So you tried timing spec 1 (mmc HS)?

How did you exactly enable mmc-hs mode?

I suggest to *not set* vqmmc and apply patch 1. It will report that
signaling voltage is 3.3V, but that did not really matter in our case.
This was our baseline and always worked stable on mainline. I also would
use that mode when tweaking pinmux etc...

>>
>>>
>>> I've been tweaking the pull up/down values to try and improve the
>>> stability, but without access to anything but the TRM it's a lot of
>>> trial and error.
>>>
>>
>> Hm, maybe Marcel's recent fixes in our device tree are helpful?
>> https://lkml.org/lkml/2018/7/22/165
>>
>> Also make sure to have a complete pinmux such that alternative pins for
>> sdmmc4 are *not* muxed as sdmmc4.
> 
> That was my first issue, which was preventing sdmmc4 from working at all.
> Just double checked all of the spare function pins, they are all
> assigned elsewhere.
> 

Ok.

>>
>>>>>
>>>>> Lowering down to 32Mhz, without the patch there are no errors.
>>>>
>>>> So the patch does not make it less stable right?
>>>>
>>>
>>> No, it did not affect stability.
>>> Although I'd conduct some performance testing to check for degradation.
>>> Of course I'm nowhere near the limits of the controller, so it is
>>> doubtful I'd see a hit.
>>
>> Ok, and this is with the complete patchset applied correct?
>>
>> Btw, what device tree are you using? Ouya is not upstream as far as I
>> can tell?
> 
> Indeed, I have the full patchset.
> 
> Ouya is an old android game console that I've been working on getting
> mainline working on.

I know, I have one sitting here too. I only tried to tinker a bit at the
very beginning...

> I've written most of the device tree, with contributions from Matt Merhar.
> It's almost bit for bit a cardhu dev board, but with everything not
> necessary to function removed.
> They cut a lot of corners with the board design.
> Last stable kernel was 3.2, but it ran fine at 52mhz, mind you it
> reported it was running mode 5.

That is what we saw too. With Apalis/Colibri T30 L4T downstream kernel
(which is 3.1 with quite some patches) 52MHz DDR worked fine,
surprisingly even with ACMD23. However, speed is slightly slower than
mainline 52MHz without ACMD23...

--
Stefan

> 
> To get this speed, I have the pins all driven down at 4, and up at 24.
> Default is 2 down and 18 up from driver init.
> The pin pull ups are exactly as the original kernel, all pins pulled
> up except reset, which is pulled down.
> 
>>
>> --
>> Stefan
>>
>>>
>>>> --
>>>> Stefan
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
