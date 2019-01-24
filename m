Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AD3C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B0120854
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="apa86H5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfAXI7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:59:33 -0500
Received: from uho.ysoft.cz ([81.19.3.130]:57836 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbfAXI7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 03:59:33 -0500
X-Greylist: delayed 314 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Jan 2019 03:59:32 EST
Received: from [10.1.8.111] (unknown [10.1.8.111])
        by uho.ysoft.cz (Postfix) with ESMTP id 88B8FA042F;
        Thu, 24 Jan 2019 09:54:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1548320056;
        bh=NMNVQeawFrsPpzsdUdNe0CKqR5xVmVt+AeVW9N6fgAc=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=apa86H5oMjDW+9v6nku9SYMhePOJJ5zUAyPizxN3zfQTwhoiOabubdlWa9SS5Kywh
         r/+WwhgpcG5/1EQMtRpX0urkXh8bzg8x9kKFvMDjOBZm2fH8DQ8bqEEtOljY20DRYM
         ZNtllqr9uQPAMuVZfnQ/LRgB9ipXeQR3a49zB0aE=
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Subject: Re: [RFC PATCH v4 2/2] pwm: imx: Configure output to GPIO in disabled
 state
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Majewski <l.majewski@majess.pl>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <LW@karo-electronics.de>,
        Linus Walleij <linus.walleij@linaro.org>
References: <1544616263-82642-1-git-send-email-michal.vokac@ysoft.com>
 <1544616263-82642-3-git-send-email-michal.vokac@ysoft.com>
 <20181213085605.j2e76y67srg5qfbc@pengutronix.de>
Message-ID: <15db833b-37cb-0d80-6ef2-dd1fd4507027@ysoft.com>
Date:   Thu, 24 Jan 2019 09:54:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181213085605.j2e76y67srg5qfbc@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.12.2018 09:56, Uwe Kleine-König wrote:
> On Wed, Dec 12, 2018 at 12:04:51PM +0000, Vokáč Michal wrote:
>> Normally the PWM output is held LOW when PWM is disabled. This can cause
>> problems when inverted PWM signal polarity is needed. With this behavior
>> the connected circuit is fed by 100% duty cycle instead of being shut-off.
>>
>> Allow users to define a "pwm" and a "gpio" pinctrl states. The pwm pinctrl
>> state is selected when PWM is enabled and the gpio pinctrl state is
>> selected when PWM is disabled. In the gpio state the new pwm-gpios GPIO is
>> configured as input and the internal pull-up resistor is used to pull the
>> output level high.
>>
>> If all the pinctrl states and the pwm-gpios GPIO are not correctly
>> specified in DT the PWM work as usual.
>>
>> As an example, with this patch a PWM controlled backlight with inversed
>> signal polarity can be used in full brightness range. Without this patch
>> the backlight can not be turned off as brightness = 0 disables the PWM
>> and that in turn set PWM output LOW, that is full brightness.
>>
>> Inverted output of the PWM with "default" and with "pwm"+"gpio" pinctrl:
>>
>> +--------------+------------+---------------+----------- +-------------+
>> | After reset  | Bootloader |   PWM probe   |     PWM    |     PWM     |
>> | 100k pull-up |            |               | enable 30% |   disable   |
>> +--------------+------------+---------------+------------+-------------+
>> | pinctrl      |    none    |    default    |   default  |   default   |
>> | out H   __________________                   __   __                 |
>> | out L                     \_________________/  \_/  \_/\____________ |
>> |                                           ^    ^    ^                |
>> +--------------+------------+---------------+------------+-------------+
>> | pinctrl      |    none    |      gpio     |     pwm    |     gpio    |
>> | out H   __________________________________   __   __   _____________ |
>> | out L                                     \_/  \_/  \_/              |
>> |                                           ^    ^    ^                |
>> +----------------------------------------------------------------------+
> 
> Just for the record: My last concern against this patch set (that I sent
> for v3) and v4 of the series criss-crossed. So the problem with the
> peaks that could happen is still unaddressed.

Hi Uwe et al.

Sorry for the huge delay. I hope we will be able to refresh our
memories and continue on the discussion. I will react to your
comments in the appropriate v3 thread. And sorry for this v4.
I was too fast on the trigger back then..

Michal
