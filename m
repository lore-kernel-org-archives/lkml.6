Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FACEC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB06B20671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MMo2xJ4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB06B20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731769AbeGZVJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 17:09:07 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36832 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731521AbeGZVJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 17:09:07 -0400
Received: by mail-qk0-f195.google.com with SMTP id a132-v6so1822430qkg.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 12:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SpdJpyBzihY7mEmvUoa8RX4I2t79z8V0OFnQ1jPHc1s=;
        b=MMo2xJ4phLhfEUYM5L61CEAwF3XP8Uty2g/IarKok/1jprcaxyxqMjD+Q4c05coDyi
         XQ3ROgXR+i8PCArWDDL3rRYsntR4zgRGefHtSVwb2tjz/UEqQmav1kKFlBbKiFzaLJcm
         Xpb/TZjXKvOHwyPfYT22awsmOJArmx6dn/A7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SpdJpyBzihY7mEmvUoa8RX4I2t79z8V0OFnQ1jPHc1s=;
        b=FYo/91eEF+osLnBnKdZ3FTuhoE6WKs0dC/NuUy9MF1KaK+wjqo/sScNI0ORTS+7dDX
         SVPnC3eAgDtScvpqtGXQFgWMyR7YL/Ep1ecbMamsdwqtj8w4ea+k8RedbWakqq6g58K3
         hOqwHbiPdn3g4LVHzJTRATe0KMpNzb+6zxQM3n6v0EMGjP4e5WVhWxR8XQ0Ssv3keWfR
         8VyhGXfy8FN5cPx66gUuJBcsqNPnLWcw2unPJQzGy+KpWqbWsu1LaYhRsOWpfVnFKGxz
         3R+UAGuzh34+1lbLrwHkQfrCKEKaNFPIl+8ZrY7qXUF6/S5t9GL3IfxAuGIistBn1urH
         Xh5g==
X-Gm-Message-State: AOUpUlHf4rYYzsnz5svb0Im4wqohDibblyu4FvJfDocv7ss0IUOVvUXQ
        CcEWJ7Q3btDTe5eHEIny9st4eg==
X-Google-Smtp-Source: AAOMgpdB+5AEi29xfBxO4akyMDMJXaTVE46qZFaDbAvBJFfy2CEPV1MY4Ob7bEMA5bQ59URCH7AGJw==
X-Received: by 2002:a37:bfc2:: with SMTP id p185-v6mr3049676qkf.169.1532634645710;
        Thu, 26 Jul 2018 12:50:45 -0700 (PDT)
Received: from [10.136.4.147] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id l5-v6sm1430241qte.20.2018.07.26.12.50.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 12:50:45 -0700 (PDT)
Subject: Re: [PATCH 7/7] net: phy: Add pm support for scan ctrl register to
 bcm mdio mux
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532630184-29450-8-git-send-email-arun.parameswaran@broadcom.com>
 <20180726192050.GJ10686@lunn.ch>
 <170a4731-b091-aef4-2d66-2950114e41fc@broadcom.com>
 <20180726193634.GM10686@lunn.ch>
From:   Arun Parameswaran <arun.parameswaran@broadcom.com>
Message-ID: <f2521267-c774-6a56-ac5f-f777346b779c@broadcom.com>
Date:   Thu, 26 Jul 2018 12:51:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180726193634.GM10686@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 18-07-26 12:36 PM, Andrew Lunn wrote:
> On Thu, Jul 26, 2018 at 12:33:05PM -0700, Arun Parameswaran wrote:
>>
>>
>> On 18-07-26 12:20 PM, Andrew Lunn wrote:
>>> On Thu, Jul 26, 2018 at 11:36:24AM -0700, Arun Parameswaran wrote:
>>>> Add support for saving and restoring the 'scan control' register
>>>> in the Broadcom iProc mdio mux driver.
>>>
>>> Hi Arun
>>>
>>> I don't see anything setting this register. So why is it necessary to
>>> save it over suspend/resume?
>>>
>>>      Andrew
>>>
>> Hi Andrew
>> In the Omega SoC (only), this register was defaulted incorrectly (to use
>> a test mode) by the hardware. So we added the setup of the register to
>> the early bootloader (ATF).
>>
>> We still need to restore this register while resuming from sleep.
> 
> Hi Arun
> 
> It is better to not rely on the bootloader and have the driver do it.
> That makes it easier for people to swap to alternative bootloaders.
> 
>      Andrew
> 
I will make the change to set the register in the driver.

Thanks
Arun
