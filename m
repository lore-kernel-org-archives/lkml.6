Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B76516256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3562083E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="doORg11K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3562083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731535AbeG3SZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:25:21 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36131 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbeG3SZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:25:21 -0400
Received: by mail-qk0-f195.google.com with SMTP id a132-v6so8244761qkg.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 09:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BKk9Q69RwQjWvdHWuxZRr+tH8jq+w3Ah7bWyX8qbHmc=;
        b=doORg11Kxwok8IzHEkGZu4FXqMT7fUGQdSZEEB3PdceIXtUPvqos5jit2VXcFGSCSu
         lRFqRy4xTx8bWCBeV9b4NU0S/rbUR1p/qNLB7pAdNtNgB1Z8eGw3tMiDNJxrSYaY1TPV
         aJtxqeDsd4lQ2RGBfkBC6VYsk0MOR+4liwDoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BKk9Q69RwQjWvdHWuxZRr+tH8jq+w3Ah7bWyX8qbHmc=;
        b=sE7ZZy6ju9FYqw148TN/pNlF76qQ53/im/9Mc0321mgGc/lrbHNuEjuBdRntD0QSzZ
         1QVv5f07DjLK+5vT7ge1eWN8ARdc5HAEhHr1/lk7pWaD+rY3l1Eh74z7hjtkIJFA6Qrp
         pmsKqsc0ru09Cqtzwk1upQchAh3CcmcLAEd3h7LaoBi3sypw4RisTGDuuobm2qzlsWs7
         bdArTaozihC94QnWpWYOG1ZacWG5HWheoEYleMdhP7A6ImYtuldafNvAEF3/UMpx157R
         W4UCbxM7V1fxIQ28bOWfC5qsFxfTAtr1uHNsjO5cgOYBOWomFo2ISq8tqOEsHG/xUZpq
         SxUw==
X-Gm-Message-State: AOUpUlHSsnB4nDyL1YBywxQsZlSifVOFe4IvDnbXxUMfMpGvEyZa7hrO
        KEiV5boShJlYoQnXCkoh+uwjDg==
X-Google-Smtp-Source: AAOMgpdLEKsiMCAklUislL/kIBIUUGVDi9ExpkGWqKGdN9o5K1B1DmHJ7jPJBShKXK+V16/gfzmm0Q==
X-Received: by 2002:a37:4fcd:: with SMTP id d196-v6mr16616369qkb.323.1532969369097;
        Mon, 30 Jul 2018 09:49:29 -0700 (PDT)
Received: from [10.136.4.147] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id l22-v6sm9501794qkh.72.2018.07.30.09.49.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 09:49:28 -0700 (PDT)
Subject: Re: [PATCH v2 6/7] net: phy: Add support to configure clock in
 Broadcom iProc mdio mux
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
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532726613-6483-7-git-send-email-arun.parameswaran@broadcom.com>
 <20180728212224.GF4792@lunn.ch>
From:   Arun Parameswaran <arun.parameswaran@broadcom.com>
Message-ID: <d19bb673-9088-bbee-ce9f-f2a4d8f404bf@broadcom.com>
Date:   Mon, 30 Jul 2018 09:49:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180728212224.GF4792@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 18-07-28 02:22 PM, Andrew Lunn wrote:
>> @@ -198,10 +219,22 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
>>  		return PTR_ERR(md->base);
>>  	}
>>  
>> +	md->core_clk = devm_clk_get(&pdev->dev, NULL);
>> +	if (IS_ERR(md->core_clk)) {
>> +		md->core_clk = NULL;
>> +	} else {
>> +		rc = clk_prepare_enable(md->core_clk);
>> +		if (rc) {
>> +			dev_err(&pdev->dev, "failed to enable core clk\n");
>> +			return rc;
>> +		}
>> +	}
>> +
>>  	md->mii_bus = mdiobus_alloc();
>>  	if (!md->mii_bus) {
>>  		dev_err(&pdev->dev, "mdiomux bus alloc failed\n");
>> -		return -ENOMEM;
>> +		rc = -ENOMEM;
>> +		goto out;
> 
> Hi Arun
> 
> There is a devm_mdiobus_alloc() which could make the cleanup on error
> simple.
> 
Should I do this as a separate patch ?

Thanks
Arun
>>  	}
>>  
>>  	bus = md->mii_bus;
>> @@ -217,7 +250,7 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
>>  	rc = mdiobus_register(bus);
>>  	if (rc) {
>>  		dev_err(&pdev->dev, "mdiomux registration failed\n");
>> -		goto out;
>> +		goto out_alloc;
>>  	}
>>  
>>  	platform_set_drvdata(pdev, md);
>> @@ -236,8 +269,11 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
>>  
>>  out_register:
>>  	mdiobus_unregister(bus);
>> -out:
>> +out_alloc:
>>  	mdiobus_free(bus);
>> +out:
>> +	if (md->core_clk)
>> +		clk_disable_unprepare(md->core_clk);
>>  	return rc;
>>  }
> 
>    Andrew
> 
