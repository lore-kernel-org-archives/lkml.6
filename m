Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410DDC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB07E20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gLF4wTVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB07E20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731572AbeGZUev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:34:51 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39035 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbeGZUeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:34:50 -0400
Received: by mail-qt0-f196.google.com with SMTP id q12-v6so2699100qtp.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 12:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HROb7uR6HpyqTxx/WO9Gs2EAvacXPRY/CsmN1QYlcEA=;
        b=gLF4wTVcCNWRjLbB9gMjHUvrKWfMYPWye3tkXX0lGQjqbGS/bCoD5jPjGjmjl9jJ2t
         fYF216E+swCezy6gRrUBsugkCHr2pwzD7CJ17QmSWxQHPuul/WNd3/WeIMcLxgGZvi5Z
         1JlC18hwhAd9HKwmakTrCCjSBKSt10gUR7NsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HROb7uR6HpyqTxx/WO9Gs2EAvacXPRY/CsmN1QYlcEA=;
        b=Vufkc2akbCETlqyLdnCx43Bzh8cRDziAgjxEfT69cw2DDYWh4fM3Bx/IGs3bGAYE6K
         WA7ClNVnQcpJo6Ht1bqgELUyPKxfwNPYbKcSjHgdtP091l431KynPCbFmGBz4UltjmlU
         G4O8ZtgagEHTkNpSIoegxHJSzUkqe/HEPbmqSwbb6544fnSz2eBxvSFFtvHHVjLhSd4z
         dwQrUkPlIwtX9gvMlu+MoC/Dw2Ok2ekqlZ7jlUZI/8PmazI5Pbe2sjBeME3DRpomf8rn
         3MK8edLrvKB/Nm9kB5LBHhwviGYysx+12pdwLpE7/FPDGkZlICDshgGjsWB0TMc4tN7q
         eCOA==
X-Gm-Message-State: AOUpUlH0c7zQODWigyk6Lbw9n2bcdwiop+YIioiBguHItiQcHvgBCH9s
        eSQolP4gUi0KRoQWlRylEYmwNw==
X-Google-Smtp-Source: AAOMgpcFlm/tRGKc6QqBwdS99YZlv9F9YS69MVBlA2ryjl0VnlsgtkLM4a5KERHfxK/oqpA8XDqg0g==
X-Received: by 2002:a0c:ae89:: with SMTP id j9-v6mr2938831qvd.174.1532632596690;
        Thu, 26 Jul 2018 12:16:36 -0700 (PDT)
Received: from [10.136.4.147] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id v57-v6sm1501794qtc.75.2018.07.26.12.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 12:16:36 -0700 (PDT)
Subject: Re: [PATCH 2/7] net: phy: Fix the register offsets in Broadcom iProc
 mdio mux driver
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
 <1532630184-29450-3-git-send-email-arun.parameswaran@broadcom.com>
 <20180726190636.GG10686@lunn.ch>
From:   Arun Parameswaran <arun.parameswaran@broadcom.com>
Message-ID: <6188441f-670d-7644-361b-7a5e8e06c9c2@broadcom.com>
Date:   Thu, 26 Jul 2018 12:16:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180726190636.GG10686@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18-07-26 12:06 PM, Andrew Lunn wrote:
> On Thu, Jul 26, 2018 at 11:36:19AM -0700, Arun Parameswaran wrote:
>> Modify the register offsets in the Broadcom iProc mdio mux to start
>> from the top of the register address space.
>>
>> Earlier the base address specified was from the middle of the block's
>> register space. The base address will now point to the start of the
>> mdio's address space. The offsets have been fixed to match this.
> 
> Hi Arun
> 
> Did you consider a change something like:
That looks good. I will make this change to the patch.

Thanks
Arun
> 
> diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mux-bcm-iproc.c
> index 0831b7142df7..2d53e609498c 100644
> --- a/drivers/net/phy/mdio-mux-bcm-iproc.c
> +++ b/drivers/net/phy/mdio-mux-bcm-iproc.c
> @@ -169,6 +169,12 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
>         md->dev = &pdev->dev;
>  
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +       if (res->start & 0xfff != 0) {
> +               dev_info(&pdev->dev, "Please upgrade your device tree blob.\n");
> +               res->start &= ~0xfff;
> +       }
> +
>         md->base = devm_ioremap_resource(&pdev->dev, res);
>         if (IS_ERR(md->base)) {
>                 dev_err(&pdev->dev, "failed to ioremap register\n");
> 
> 
> 	Andrew
> 
