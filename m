Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A207DC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F54420673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QWyQrkiX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F54420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731231AbeGZUip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:38:45 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:46475 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730399AbeGZUip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:38:45 -0400
Received: by mail-qt0-f194.google.com with SMTP id d4-v6so2708159qtn.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 12:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MfF2aZ6zveK0N4r6/NwAyQvGg154hFigMjWtLj0yAHQ=;
        b=QWyQrkiX2YohTcjESz8fsfFFvtipu48baTX4mGBHcrYDz2KU3c+xBX/7q36yedmabW
         MtQFe9dmlNhKFwMSy2EE6EluvGMUlPNmr00p9t9xQob5f6JOzEVL8BQI7vdQFDVDLw0x
         WjZ/Ho1RoUcaz5WLgzA6BkUe3g/LiPpdLRIhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MfF2aZ6zveK0N4r6/NwAyQvGg154hFigMjWtLj0yAHQ=;
        b=dzuXKQBxl8GGxZGGBzoTtCqtEVyIQDkoCeG1gmoFxQhS7BVMnEHJX0bD/jkD3i90DY
         MdzkrgbeE5t4jLCBQimaY795/jgBnqC6t+3ftbBzXgpQcyaQjBQm2+JFCX7z3k0CVn25
         eNfsnFzsI5dcJtN3MCtrHfPN35D+wPiSBqZgWb1ezSRBV5oRjEqd2g0dHfCxnXys79tV
         RRd20QNW6VDX1WJT7I1/lGbk14Qy4Uq+QdAegBS9DmeGbTgA5WXC0vt3dRuJpanxI1sq
         HWUbuS8CpaqLZ+qePggJdLtP754MRcNU0YfPUJ4Cu0OSlNpc3HxU3w87u3rdV2h7Bob6
         rkWA==
X-Gm-Message-State: AOUpUlGZTjoq+z9NU6NO3/960gQgzYwaRKLxXXaO4R1nIAX/kHTr3bMb
        6MArgGFOQVqH+eIWNXZfI3KU4A==
X-Google-Smtp-Source: AAOMgpfcQMDmsducCoB01HgJr/YUIJCztaOqD/UuGmgzS3ZuvwfCHcDa8GUXB9wg4d+QiA3qgfvGZA==
X-Received: by 2002:ac8:4085:: with SMTP id p5-v6mr3220366qtl.14.1532632831126;
        Thu, 26 Jul 2018 12:20:31 -0700 (PDT)
Received: from [10.136.4.147] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id s31-v6sm1524129qtc.68.2018.07.26.12.20.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 12:20:30 -0700 (PDT)
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
 <20180726191340.GH10686@lunn.ch>
From:   Arun Parameswaran <arun.parameswaran@broadcom.com>
Message-ID: <8c163cc7-aa52-4a17-9cba-762c8542e721@broadcom.com>
Date:   Thu, 26 Jul 2018 12:20:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180726191340.GH10686@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18-07-26 12:13 PM, Andrew Lunn wrote:
>> @@ -175,6 +198,12 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
>>  		return PTR_ERR(md->base);
>>  	}
>>  
>> +	md->core_clk = devm_clk_get(&pdev->dev, NULL);
>> +	if (IS_ERR(md->core_clk)) {
>> +		dev_info(&pdev->dev, "core_clk not specified\n");
>> +		md->core_clk = NULL;
>> +	}
>> +
> 
> In the binding, you say the clock is optional. This is a rather strong
> message for something which is optional. I think it would be better to
> not output anything.
> 
>     Andrew
> 
Will remove the message.

Thanks
Arun
