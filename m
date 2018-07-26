Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A9FC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D619F20671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HKFGzhRa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D619F20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731601AbeGZUvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:51:07 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:41193 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730452AbeGZUvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:51:07 -0400
Received: by mail-qk0-f195.google.com with SMTP id d22-v6so1773515qkc.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 12:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WVT9UTMDq51YLbjJnNJ7a//BN28qoYszxbYXkVZKlO4=;
        b=HKFGzhRaR0gLRDQNZ4WPTwxclD9fcgxFOuFFSqL92lylUF/Fuf1uquuhiWMA/ZBIBg
         6g7EVslsMUMDKDeXYi/1pJYUGM7vF8FmeGijtwKI1+7HkgRXnMAZv7BkikQ01P7uRedb
         ucDBNm+JascenV1KxVZnqRylleMfsrqVy9+Ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WVT9UTMDq51YLbjJnNJ7a//BN28qoYszxbYXkVZKlO4=;
        b=XkqIvizrc0lGMIkOz8UHXf1B7WlfPgCk1+lBQ/7FVazt14wX8OUZAd3jZbhJtmA8kR
         T80haxrz+xFV8RLSxVbyZsklLXGRrvMnRTEIjAL4YbazQPuZoxfOX6IuSaxkwJl23/3N
         K/oDdxijXMhiwGtxfChNO5DksZEyKK8+R8dcWP4M9H2Qoeoh8PTo4kKGj1YF123MdiBb
         Gwh1A2PQFscAgmo7jwLlGspYu84f5W+Vlz9wvxPsH82xXLK/UGW3pN7Wqdcgt7JjPPFx
         0Egaewgn0sGVmpAb1D51xQEZZHj82iLUHSmhLL+50cTjdiMH7axLJCH8vEdjWNWGaTrE
         7CNw==
X-Gm-Message-State: AOUpUlEF/ZQr8vl+UmRHyd7yiq3j2MiLOlagM8SbmWQ5NdjqWJaz1M8N
        2pu3GWq73D7vVFibgsc+a9E92g==
X-Google-Smtp-Source: AAOMgpeAudY2QFtzTkITmsiDS9JdQlaLdBXNvn0NKUYF762S9G2kA+ANoKCy+9BHfsBCKprltXXV1A==
X-Received: by 2002:a37:9a41:: with SMTP id c62-v6mr3079721qke.395.1532633570039;
        Thu, 26 Jul 2018 12:32:50 -0700 (PDT)
Received: from [10.136.4.147] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id j45-v6sm2008093qta.46.2018.07.26.12.32.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 12:32:49 -0700 (PDT)
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
From:   Arun Parameswaran <arun.parameswaran@broadcom.com>
Message-ID: <170a4731-b091-aef4-2d66-2950114e41fc@broadcom.com>
Date:   Thu, 26 Jul 2018 12:33:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180726192050.GJ10686@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18-07-26 12:20 PM, Andrew Lunn wrote:
> On Thu, Jul 26, 2018 at 11:36:24AM -0700, Arun Parameswaran wrote:
>> Add support for saving and restoring the 'scan control' register
>> in the Broadcom iProc mdio mux driver.
> 
> Hi Arun
> 
> I don't see anything setting this register. So why is it necessary to
> save it over suspend/resume?
> 
>      Andrew
> 
Hi Andrew
In the Omega SoC (only), this register was defaulted incorrectly (to use
a test mode) by the hardware. So we added the setup of the register to
the early bootloader (ATF).

We still need to restore this register while resuming from sleep.

Thanks
Arun
