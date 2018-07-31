Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5330EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0719220857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bVfb+Bmk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0719220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731943AbeGaTcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 15:32:54 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35031 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729782AbeGaTcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 15:32:54 -0400
Received: by mail-qk0-f195.google.com with SMTP id u21-v6so10839598qku.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 10:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vuv1/DUiY3yElibysTszEqkNUuWpYgpH5IqsSB8eSps=;
        b=bVfb+BmkdJVfKRFZ6vUISI5VX/S2p2JZTcN1RVSWfzDYkwNH/XFEfnom/wb1h6IBwb
         MTWnFp105e1SZDrYPr1ElD+83KyDhEnWgD4m+Ua1Udp/XwkSsN4GrbyZlxKOYFrbpuQ5
         ALV2Ox/ggcY388JBNT7Y0ohimFmJjwfmusVho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vuv1/DUiY3yElibysTszEqkNUuWpYgpH5IqsSB8eSps=;
        b=EtvhSLeTQRg/1Q8rTOURT6MNw2aLQa0460gA1veMZURLvJLABVZhlyY/tHTGCBlvSp
         30zOcWNqeooRw+PnriHK4nFdHIdQzJBjPAlXfSGbUDqro2yBxi+1d2RVFsjQ9rNJ6uEw
         dTnG1/GSEo0NrFcuBW+S8C2s16wC94swgXn3iNF42P+v9OJDCqzd6DCmwaqwbgZ911Hn
         ePRWNCk3tzNCbQToLAHeA9SDlVL69PPNQuMP2wUdiJ4HTWzAA+o8i2VmvKEqjAvHMrH7
         Qi+OnnboEZkMhQ5k/I7r4TPA107eicfQas0cYUv/T/HoifUCOqX2nPWs9VZfWUYb+AY8
         UfPA==
X-Gm-Message-State: AOUpUlE/g+FmSk1/WbOCIPzJSwIEsy8be2I8r/sQJcUFW3EoA+BvT6Sp
        USuLJ1G5rH+gK48aIreSaocWjg==
X-Google-Smtp-Source: AAOMgpfgDp6b5o8Y+2ceay5ZcQatyGnFtN5SllZWeNTbXZd/sciUNi5QfXLwbji+bkI9McfSODfP+g==
X-Received: by 2002:a37:6e01:: with SMTP id j1-v6mr21502393qkc.70.1533059488668;
        Tue, 31 Jul 2018 10:51:28 -0700 (PDT)
Received: from [10.136.4.147] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id n25-v6sm8275867qtp.94.2018.07.31.10.51.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 10:51:28 -0700 (PDT)
Subject: Re: [PATCH v2 7/7] net: phy: Add pm support to Broadcom iProc mdio
 mux driver
To:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532726613-6483-8-git-send-email-arun.parameswaran@broadcom.com>
 <8d732031-c5e8-d6ea-5b61-3b9baf79796f@gmail.com>
From:   Arun Parameswaran <arun.parameswaran@broadcom.com>
Message-ID: <f298c64e-d8de-0e6d-3c4d-f62b257329f9@broadcom.com>
Date:   Tue, 31 Jul 2018 10:51:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <8d732031-c5e8-d6ea-5b61-3b9baf79796f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On 18-07-30 03:53 PM, Florian Fainelli wrote:
> On 07/27/2018 02:23 PM, Arun Parameswaran wrote:
>> Add support for suspend and resume to the Broadcom iProc mdio
>> mux driver.
>>
>> Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
>> ---
>>  drivers/net/phy/mdio-mux-bcm-iproc.c | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mux-bcm-iproc.c
>> index 51d1003..d89dce0 100644
>> --- a/drivers/net/phy/mdio-mux-bcm-iproc.c
>> +++ b/drivers/net/phy/mdio-mux-bcm-iproc.c
>> @@ -290,6 +290,33 @@ static int mdio_mux_iproc_remove(struct platform_device *pdev)
>>  	return 0;
>>  }
>>  
>> +#ifdef CONFIG_PM_SLEEP
>> +static int mdio_mux_iproc_suspend(struct device *dev)
>> +{
>> +	struct iproc_mdiomux_desc *md = dev_get_drvdata(dev);
>> +
>> +	if (md->core_clk)
>> +		clk_disable_unprepare(md->core_clk);
> 
> Since you are assigning md->core_clk to NULL in case clk_get() returned
> an error, checking for md->core_clk is not necessary since the Linux
> common clock framework perform that NULL check already.
> 
Will remove the check.

I am working on Andrew's comments (which will add one more patch to the series).
I will send the whole patchset again, with reviewed-by tags (From Florian
and Andrew on the ones that apply).

Thanks
Arun
