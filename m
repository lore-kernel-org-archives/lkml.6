Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEC2C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FA5214FF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80FA5214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732813AbeHIR23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:28:29 -0400
Received: from mout02.posteo.de ([185.67.36.142]:36049 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732603AbeHIR22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:28:28 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 1130120FAE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Aug 2018 17:03:08 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 41mWhn2tLFz9rxL;
        Thu,  9 Aug 2018 17:03:05 +0200 (CEST)
Subject: Re: [PATCH RESEND 2/2] gpio: mvebu: Allow to use non-default PWM
 counter
To:     Andrew Lunn <andrew@lunn.ch>, Aditya Prayoga <aditya@kobol.io>
Cc:     linux-gpio@vger.kernel.org,
        Richard Genoud <richard.genoud@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Gauthier Provost <gauthier@kobol.io>,
        Alban Browaeys <alban.browaeys@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Gilmore <dennis@ausil.us>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>
References: <1533522556-55055-1-git-send-email-aditya@kobol.io>
 <1533522556-55055-3-git-send-email-aditya@kobol.io>
 <20180806135257.GB6584@lunn.ch>
From:   Richard Genoud <richard.genoud@gmail.com>
Message-ID: <9d12abba-0be8-bce7-45d5-99659cbe0915@sorico.fr>
Date:   Thu, 9 Aug 2018 17:03:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180806135257.GB6584@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/08/2018 15:52, Andrew Lunn wrote:
> On Mon, Aug 06, 2018 at 10:29:16AM +0800, Aditya Prayoga wrote:
>> On multiple PWM lines, if the other PWM counter is unused, allocate it
>> to next PWM request. The priority would be:
>> 1. Default counter assigned to the bank
>> 2. Unused counter that is assigned to other bank
>> 3. Fallback to default counter
>>
>> For example on second bank there are three PWM request, first one would
>> use default counter (counter B), second one would try to use counter A,
>> and the third one would use counter B.
> 
> Hi Aditya
> 
> There are only two PWM counters for all the GPIO lines. So you cannot
> support 3 PWM requests. You have to enforce a maximum of two PWMs.
> 
> When i implemented this PWM code, i only needed one PWM. So it took
> the easy option. GPIO bank 0 uses counter A, GPIO bank1 uses counter
> B. For the hardware you have, this is not sufficient, so you need to
> generalise this. Any PWM can use any counter, whatever is available
> when the PWM is requested.
> 
> Rather than have a linked list of PWM, i think it would be better to
> have a static array of two mvebu_pwm structures. Index 0 uses counter
> A, index 1 uses counter B. You can then keep with the concept of
> pwm->pgiod != NULL means the counter is in use. The request() call can
> then find an unused PWM, set pwm->gpiod, and point mvchip->mvpwm to
> one of the two static instances.
> 
>     Andrew
> 
I'm not sure that the logic:
1. Default counter assigned to the bank
2. Unused counter that is assigned to other bank
3. Fallback to default counter
is the best one.

I gave the code a try, and I've been a little confused.
I declared:
- fan1 as gpio1 22 
- fan2 as gpio1 11
- fan3 as gpio0 22

and I did:
echo 10 > hwmon1/pwm1  # ok
echo 100 > hwmon2/pwm1 # still ok
echo 200 > hwmon3/pwm1 # hey !! my fan2 is now at 200 (I can see it with the scope)
# but
cat hwmon2/pwm1
100
# okay, I want my fan2 back, So I turn off fan3:
echo 0 > hwmon3/pwm1 # fan2 and fan3 are stopped
echo 100 > hwmon2/pwm1 # not working.. fan2 is still at 0 on the scope
but:
cat hwmon2/pwm1
100

IMHO, I would either:
- allow only 2 pwm and no more (but that's a pity)
- allow lots of fans, but once 2 different speeds are set, return EINVAL for another different speed (even if it's on another bank)
That way, we'll be able to switch on/off 1, 2, 3 or more fans, as long as they have the same speed.
I'll give an example :

echo 10 > hwmon1/pwm1 # ok
echo 100 > hwmon2/pwm1 # still ok
echo 200 > hwmon3/pwm1 # returns EINVAL
echo 10 > hwmon3/pwm1 # ok

The headache will come when we want to change the speed...
echo 50 > hwmon3/pwm1 # should this change the hwmon1 as well or return EINVAL ?
I'd say that it changes hwmon1 as well, as if hwmon1 and hwmon3 were tied.
But, If I then do :
echo 100 > hwmon3/pwm1 # fan2 was already at 100
What should happen ? Do fan1, fan2 and fan3 be set to 100 ?
Or fan1 stay at 10 and fan3 at 100 ? (in this case, fan3 won't be tied to fan1 anymore, but to fan2)

Hum...
I don't know if anyone followed me on this...
Anyway, I think I convinced myself that only allowing 2 pwm is less confusing than anything else :)



Richard.
