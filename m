Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AF5C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA1220673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MLAxQ3zG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA1220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731808AbeGZVSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 17:18:13 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41340 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731674AbeGZVSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 17:18:13 -0400
Received: by mail-qt0-f194.google.com with SMTP id e19-v6so2842037qtp.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 12:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p70E5hBr1vNKJD4tO8VMDDAU3CjitBSp7uZMfHrf1W8=;
        b=MLAxQ3zGo3tnPG3wlYJ4xVywVsQ9u3lWVuYINq1Mt62QQO/hqexYPqV4qQ7EgHu88n
         5edjkmAARS5vr2GlgRHdwnoM7Q5EJEe4SXHpxait7U6D+zlt/9m7fXqYJkT+nBeoIlir
         gafcT0B2u7bMc9upU/R86ssjptrOlDeCqJ0ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p70E5hBr1vNKJD4tO8VMDDAU3CjitBSp7uZMfHrf1W8=;
        b=t15AczmX1Y1YEkGPWyfLApCKjZdYl/zVwmgza9G2kFoTgq3fr/st26aIMETUJdegxu
         fd3GM3I51nAVv4f5kY5tQ0ulbnN1MApffRBXDaRABgc8nP0SZVO/7Qz4vwTRMqzHLbdt
         8MiSXUnfs/1OQj8m7ZXdX3zahEPiE39Q39bwepJYMTmLbJ6ORfO+4TYUpbsBwQrj4F6F
         YHV8gYEqPCJlTbmTWwe37jhJLevjKJig/iSP5CPTkM8LMphn0Pf66UFlzTEfkW/EKRxi
         NQInea05fboulGrgm35KaBOFId04e39XeEfEArCcUGAHXrA2VlADbQjGQjE00/nY8E+w
         MD9g==
X-Gm-Message-State: AOUpUlGbbZl1ydRQ0jIMcZ6bzSGz/p3s5tn296SEnj6+FD41IL6BgUbb
        RfUarnMglnOQsylu9NLIb7lwzw==
X-Google-Smtp-Source: AAOMgpf9cYw6vwK6xpyhVfRzuHlJHL3pPE+rIUz5+AuYGgHf56oBQY97V0nX8qkSYv+VTWnjGkgq+Q==
X-Received: by 2002:aed:3ae5:: with SMTP id o92-v6mr3328059qte.127.1532635190016;
        Thu, 26 Jul 2018 12:59:50 -0700 (PDT)
Received: from [10.136.4.147] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id x41-v6sm1866929qtj.71.2018.07.26.12.59.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 12:59:49 -0700 (PDT)
Subject: Re: [PATCH 5/7] net: phy: Add support to configure clock in Broadcom
 iProc mdio mux
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
 <1532630184-29450-6-git-send-email-arun.parameswaran@broadcom.com>
 <20180726192651.GK10686@lunn.ch>
From:   Arun Parameswaran <arun.parameswaran@broadcom.com>
Message-ID: <609726a2-e5ec-fe1d-4ee6-39db3d71b1f2@broadcom.com>
Date:   Thu, 26 Jul 2018 13:00:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180726192651.GK10686@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

On 18-07-26 12:26 PM, Andrew Lunn wrote:
>> +static void mdio_mux_iproc_config_clk(struct iproc_mdiomux_desc *md)
>> +{
>> +	u32 val;
>> +	u32 divisor;
>> +
>> +	if (md->core_clk) {
>> +		divisor = clk_get_rate(md->core_clk) / MDIO_OPERATING_FREQUENCY;
> 
> /**
>  * clk_get_rate - obtain the current clock rate (in Hz) for a clock source.
>  * 		  This is only valid once the clock source has been enabled.
>  * @clk: clock source
>  */
> unsigned long clk_get_rate(struct clk *clk);
> 
> It is generally good practice to call clk_prepare_enable() sometime
> before clk_get_rate() to ensure the clock is ticking, and to show this
> driver is making use of the clock, so it does not get turned off.

Will add 'clk_prepare_enable()' to the probe.

Thanks
Arun

> 
>> +		divisor = divisor / (MDIO_RATE_ADJ_DIVIDENT + 1);
>> +		val = divisor;
>> +		val |= MDIO_RATE_ADJ_DIVIDENT << MDIO_RATE_ADJ_DIVIDENT_SHIFT;
>> +		writel(val, md->base + MDIO_RATE_ADJ_EXT_OFFSET);
>> +		writel(val, md->base + MDIO_RATE_ADJ_INT_OFFSET);
>> +	}
>> +}
