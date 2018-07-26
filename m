Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE78C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2290320671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FZ2BsmFs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2290320671
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732096AbeGZUnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:43:46 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41864 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732070AbeGZUnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:43:45 -0400
Received: by mail-qt0-f193.google.com with SMTP id e19-v6so2732159qtp.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 12:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hRwck6ZkONKAemZayiYEBk934fW7eFTiv+b6ZxOTlJ4=;
        b=FZ2BsmFsykJli5deeLlOwxJSW7q/0UtUpV/EwE6VDbI7n5sYevoS4SgLHkg2U6Hn/5
         U0r5D13/fWXXsdaTPpvnL70GrJojkfjnMd4uERKs2K4n4rPWeHmLGzlCoezIOpgVocPm
         sAS0NHWCSmolvahOaA5MP5pT80LlsT9tctaPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hRwck6ZkONKAemZayiYEBk934fW7eFTiv+b6ZxOTlJ4=;
        b=c69zDifpHLx959MagBURgkT1ENyFPHMaqNWwrYTxSo0p98e8sidyLCxNfRXi4XlxUl
         FG2JNiFVQeYYwijAcZktLTkYpX/J6jD+wiZP8qYX+q2zCzpBtF5f29loTSjWTk8PtFPm
         jsELV/GiAdWvv+SgBF+GzZ+C4QknT0IkEe61ba0aaRSxOSfJfmzrqzGhgCsNmBMqAymD
         ejGP6N/MjuErlElt60mJJL3kzn9nw2K3DbxJQP17xjdny5ewUJeRP+Nh/qE7l984TZl1
         yMGPwYEyAvHeiF5TuBqu/bA6VTxkOuU7ozGX5EdezvIORT9sRTAGaN1F3upN/2snJ1WB
         Uf7Q==
X-Gm-Message-State: AOUpUlFbauNDcArvuGJbdkmq2Y+CGMBgZHK7bWIox3gZ8EiisVbrf7QR
        A2P0uU6lTSDIJhZrvoqTSDwbmQ==
X-Google-Smtp-Source: AAOMgpezVMdb9A68hxvWkD2wsq7/OFI14Qx1Yw2/2QBkBJpbSoivKzz9ZBIaptEx2K45V4Hsu0WTpA==
X-Received: by 2002:a0c:95ad:: with SMTP id s42-v6mr2944896qvs.18.1532633130055;
        Thu, 26 Jul 2018 12:25:30 -0700 (PDT)
Received: from [10.136.8.248] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id l84-v6sm1739271qki.69.2018.07.26.12.25.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 12:25:28 -0700 (PDT)
Subject: Re: [PATCH 2/7] net: phy: Fix the register offsets in Broadcom iProc
 mdio mux driver
To:     Arun Parameswaran <arun.parameswaran@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>
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
 <6188441f-670d-7644-361b-7a5e8e06c9c2@broadcom.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <eeaf777f-e0ea-fb41-5a5e-4ab42a35e10f@broadcom.com>
Date:   Thu, 26 Jul 2018 12:25:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6188441f-670d-7644-361b-7a5e8e06c9c2@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/2018 12:16 PM, Arun Parameswaran wrote:
> 
> 
> On 18-07-26 12:06 PM, Andrew Lunn wrote:
>> On Thu, Jul 26, 2018 at 11:36:19AM -0700, Arun Parameswaran wrote:
>>> Modify the register offsets in the Broadcom iProc mdio mux to start
>>> from the top of the register address space.
>>>
>>> Earlier the base address specified was from the middle of the block's
>>> register space. The base address will now point to the start of the
>>> mdio's address space. The offsets have been fixed to match this.
>>
>> Hi Arun
>>
>> Did you consider a change something like:
> That looks good. I will make this change to the patch.
> 
> Thanks
> Arun

To make it backward compatible, then length of the resource also needs 
to be adjusted from 0x14 to 0x250 in the driver?

Otherwise you will end up accessing areas out of 0x14 defined in old DT 
that is not mapped?

Thanks,

Ray

>>
>> diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mux-bcm-iproc.c
>> index 0831b7142df7..2d53e609498c 100644
>> --- a/drivers/net/phy/mdio-mux-bcm-iproc.c
>> +++ b/drivers/net/phy/mdio-mux-bcm-iproc.c
>> @@ -169,6 +169,12 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
>>          md->dev = &pdev->dev;
>>   
>>          res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +
>> +       if (res->start & 0xfff != 0) {
>> +               dev_info(&pdev->dev, "Please upgrade your device tree blob.\n");
>> +               res->start &= ~0xfff;
>> +       }
>> +
>>          md->base = devm_ioremap_resource(&pdev->dev, res);
>>          if (IS_ERR(md->base)) {
>>                  dev_err(&pdev->dev, "failed to ioremap register\n");
>>
>>
>> 	Andrew
>>
