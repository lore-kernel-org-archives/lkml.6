Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12A6C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8418420644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="de+3+7R6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8418420644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeH2NGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 09:06:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43783 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbeH2NGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 09:06:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id k5-v6so4057815wre.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 02:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dUh4W5vgn6WUDKihwUsC0LGuZ0iu/ZvNvIjJGT4Tl6I=;
        b=de+3+7R6XKdMFiFjJUdi2tjU0hsne6og+9s6iiujLaJ9+F5nM5naq3PIwYYgLSfr4P
         pCzbqsxTCvh/usbQoW+CxfRbSAnpYS2D9R8MYZ9jwd6nyI4EPiaLTS3Z1v4FoVDPrjf2
         a6MLk6TC+R2u6vQ9/ZNY6n9K/SmZBZfmjLIqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dUh4W5vgn6WUDKihwUsC0LGuZ0iu/ZvNvIjJGT4Tl6I=;
        b=PMlGahcEFO9xZcLGUAzLLIDYwX1HIgZ6gw0MXHfq+xdTqkPyhEi4C2H05S8ni8IvCf
         RuMSKGm9IId4YcLr4X23JI7dpgJS4tTn9dXUgyPwZMb8K1EiHP23FgePH9cmHdrzPX73
         CmjSjr4lhJrsj/3NL0VghYxLK9dLLXsT8bofyHolDUZbBvb9/6VgGgkQmWXje3Btbcl3
         e8DylcVXY3uqZ1PrvRHibcSzPh7dtOaudEwgyuvLjJlbx5R0LqqCH1TV2ameIA8JngMd
         8iVqI1YjZZBn3HB9la2l7+pp8cujbkLsQ8xd7gq9cjGjdMp6/67Ulkt1gun4aflddxei
         bQ4Q==
X-Gm-Message-State: APzg51B/sSr/FWA/lSxmrp79pwX/Dvhrs8cbILRZfQkiund80nnB6rX4
        u1qSiQnGa9n233EK9qOfnBPWhw==
X-Google-Smtp-Source: ANB0VdaXWPxggKdVIjWOHF2QWnHVcWXsNcx7yFOEF5g9LUjCBMoci6z/Y4sxOZLMLkFAGHTTOq2+JQ==
X-Received: by 2002:adf:f5c9:: with SMTP id k9-v6mr3643055wrp.59.1535533846592;
        Wed, 29 Aug 2018 02:10:46 -0700 (PDT)
Received: from [192.168.0.22] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id j44-v6sm6940439wre.40.2018.08.29.02.10.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 02:10:45 -0700 (PDT)
Subject: Re: [PATCH v7 05/24] clocksource: Add a new timer-ingenic driver
To:     Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonathan Corbet <corbet@lwn.net>, od@zcrc.me,
        Mathieu Malaterre <malat@debian.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20180821171635.22740-1-paul@crapouillou.net>
 <20180821171635.22740-6-paul@crapouillou.net>
 <20180828172305.bohg6cggnzm3wsuj@pburton-laptop>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <62569807-7be8-51df-4683-82392224432d@linaro.org>
Date:   Wed, 29 Aug 2018 11:10:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828172305.bohg6cggnzm3wsuj@pburton-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2018 19:23, Paul Burton wrote:
> Hi Daniel & Thomas,
> 
> On Tue, Aug 21, 2018 at 07:16:16PM +0200, Paul Cercueil wrote:
>> This driver handles the TCU (Timer Counter Unit) present on the Ingenic
>> JZ47xx SoCs, and provides the kernel with a system timer, and optionally
>> with a clocksource and a sched_clock.
>>
>> It also provides clocks and interrupt handling to client drivers.
>>
>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>> ---
>>
>> Notes:
>>      v2: Use SPDX identifier for the license
>>     
>>      v3: - Move documentation to its own patch
>>          - Search the devicetree for PWM clients, and use all the TCU
>>     	   channels that won't be used for PWM
>>     
>>      v4: - Add documentation about why we search for PWM clients
>>          - Verify that the PWM clients are for the TCU PWM driver
>>     
>>      v5: Major overhaul. Too many changes to list. Consider it's a new
>>          patch.
>>     
>>      v6: - Add two API functions ingenic_tcu_request_channel and
>>            ingenic_tcu_release_channel. To be used by the PWM driver to
>>            request the use of a TCU channel. The driver will now dynamically
>>            move away the system timer or clocksource to a new TCU channel.
>>          - The system timer now defaults to channel 0, the clocksource now
>>            defaults to channel 1 and is no more optional. The
>>            ingenic,timer-channel and ingenic,clocksource-channel devicetree
>>            properties are now gone.
>>          - Fix round_rate / set_rate not calculating the prescale divider
>>            the same way. This caused problems when (parent_rate / div) would
>>            give a non-integer result. The behaviour is correct now.
>>          - The clocksource clock is turned off on suspend now.
>>     
>>      v7: Fix section mismatch by using builtin_platform_driver_probe()
>>
>>  drivers/clocksource/Kconfig         |   10 +
>>  drivers/clocksource/Makefile        |    1 +
>>  drivers/clocksource/ingenic-timer.c | 1124 +++++++++++++++++++++++++++++++++++
>>  drivers/clocksource/ingenic-timer.h |   15 +
>>  include/linux/mfd/ingenic-tcu.h     |    3 +
>>  5 files changed, 1153 insertions(+)
>>  create mode 100644 drivers/clocksource/ingenic-timer.c
>>  create mode 100644 drivers/clocksource/ingenic-timer.h
>> %
> 
> How is this & patch 6 of the series looking to you from a
> drivers/clocksource perspective?

The presence of completion, mutexes, etc ... makes me think the driver
is not going to the right direction.

I have to review the drivers again but it will take some time because
I'm returning from vacations and there are a trillion emails to sort out :/

> If you're happy with them it'd be great to get an ack so I can take this
> through the MIPS tree with the rest of the series. The alternative would
> be to get the drivers in first then the MIPS bits in the next release
> cycle.
> 
> Thanks,
>     Paul
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

