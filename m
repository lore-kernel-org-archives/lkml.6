Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E361C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED64120862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aee0z5ga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED64120862
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388490AbeHAVnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 17:43:01 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:41601 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbeHAVnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 17:43:01 -0400
Received: by mail-qk0-f193.google.com with SMTP id d22-v6so13539085qkc.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 12:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VAQpO/2PmXTIH4qyW8FM6srFLZYI8wg6jEotexmMA0Q=;
        b=aee0z5gaE/RFQfOJBt8zVCKucGhuYHpl6WRX/roMK2fUbRExPmvsCLvL/LzIN+bjrW
         Xg3sC7uUkypxQDFYi0DcmNun1E95bs4dfNYIxLM2miAjVTmlBR2qQ4DqHlq+0mCCwjV0
         Pdx9WAlSA/Ml9cpEBlmdQ5qTnY8pGVqaaLvxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VAQpO/2PmXTIH4qyW8FM6srFLZYI8wg6jEotexmMA0Q=;
        b=stMLRuwd88XWZTaiNgbrwiPBvDOu6ZYFWkU+6H10lyW13C0COR+RDY7H0YQ7kt8tR4
         3Nl3vqaFjxRKjxNR/KR8m/jNU8LINIPpwfUY8qJa6FrTRhnMouOtbzz7F2NV6KyUf9Mn
         vkCQKx10+zuGxsySmghmCneC+to+lDhOWOBo4BB488iKpSB8TwdWuRFN7NXa85Wdy7wq
         Pu3RuoAWT1scqNFvKom2TAIc0XibiS4m3giCUVAl67NBaidL55FQp/NBeN3QJ+K/tg+m
         01/xfuT0XukDYhWa+wSmoE7pcnfAEldAZFjCdLKyg2BjXA/Keqc8Hh0rzFp9OLspyJll
         YkoA==
X-Gm-Message-State: AOUpUlGB4Hbd0fkqwPZ/gNq9ZOZrSayKgNrYY2+S9fcE1P9l9HMHpFS/
        orb5ryNoPWwAIbZdtpFYDIjPlRsQAQ3Fjw==
X-Google-Smtp-Source: AAOMgpdt8PFbmfdGK9sdAtl4Tu2pPmnHLPjKr/pkMTWWeGARC7m3TObP4/vg4KDbsZzKEgehpAIRoA==
X-Received: by 2002:a37:1224:: with SMTP id c36-v6mr25614236qkh.26.1533153336911;
        Wed, 01 Aug 2018 12:55:36 -0700 (PDT)
Received: from [10.136.4.147] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id t3-v6sm13352723qtj.36.2018.08.01.12.55.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 12:55:36 -0700 (PDT)
Subject: Re: [PATCH v3 7/8] net: phy: Add support to configure clock in
 Broadcom iProc mdio mux
To:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, netdev@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
References: <1533146186-8374-1-git-send-email-arun.parameswaran@broadcom.com>
 <1533146186-8374-8-git-send-email-arun.parameswaran@broadcom.com>
 <0cc6db4f-7008-0ad3-58d7-9e93060f152f@gmail.com>
 <20180801184659.GG30658@n2100.armlinux.org.uk>
From:   Arun Parameswaran <arun.parameswaran@broadcom.com>
Message-ID: <9af7e7a3-54d4-8802-f64a-fc4f9c49c8b9@broadcom.com>
Date:   Wed, 1 Aug 2018 12:55:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180801184659.GG30658@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell, Florian,

On 18-08-01 11:46 AM, Russell King - ARM Linux wrote:
> On Wed, Aug 01, 2018 at 11:40:33AM -0700, Florian Fainelli wrote:
>> On 08/01/2018 10:56 AM, Arun Parameswaran wrote:
>>>  static int iproc_mdio_wait_for_idle(void __iomem *base, bool result)
>>> @@ -204,6 +225,20 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
>>>  		return -ENOMEM;
>>>  	}
>>>  
>>> +	md->core_clk = devm_clk_get(&pdev->dev, NULL);
>>> +	if (IS_ERR(md->core_clk)) {
>>> +		if (PTR_ERR(md->core_clk) == -EPROBE_DEFER)
>>> +			return -EPROBE_DEFER;
>>> +
>>> +		md->core_clk = NULL;
>>
>> I would simplify this a bit:
>>
>> 	if (IS_ERR(md->core_clk) && PTR_ERR(md->core_clk) == -EPROBE_DEFER)
> 
> Even better is:
> 
> 	if (md->core_clk == ERR_PTR(-EPROBE_DEFER))
> 

The clock is an optional parameter. But I realize, that I did not handle all
the error cases.

My intention was to proceed with probe if the clock is not found in the DT.
If the clock is specified in the DT, make use of it.

So, should I modify to something like:

md->core_clk = devm_clk_get(&pdev->dev, NULL);
if (md->core_clk == ERR_PTR(-ENOENT)) {
	/* clock is optional, without it the default
	 * rate divider register values will be used
	 */
	md->core_clk = NULL;
} else if (IS_ERR(md->core_clk)) {
	return PTR_ERR(md->core_clk);
} else {
	rc = clk_prepare_enable(md->core_clk);
	...
}

Thanks
Arun
