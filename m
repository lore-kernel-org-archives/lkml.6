Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B76C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C5A20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HbFLU1ZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C5A20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732553AbeHAX6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:58:07 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33958 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732233AbeHAX6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:58:07 -0400
Received: by mail-qt0-f194.google.com with SMTP id m13-v6so219986qth.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 15:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fjsov7j9018AgqeCfIjNCbpCYWOjMNGjsD+QV0+OgoQ=;
        b=HbFLU1ZKbB0eAR/zcafrIoDnpMTmIfNlU8QV0xTNwYZe+NkfRNcoTefqY42Ans8F7E
         tbu2krY7/Tmjimzw8E3X0GHl/QtvLTdfe7W+AE3DXigb1xyCk4epIijpk3Vk2TjmEofd
         hB/6BXb6QIBcrX13EhvAHIdV8bLzCf7X2DeG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fjsov7j9018AgqeCfIjNCbpCYWOjMNGjsD+QV0+OgoQ=;
        b=SWe03kYb096UOD+AjfRAP6O2gmOUcVPNM+da4Npb3FXAeSmc86BmVDacDB9O4hrJ6v
         79m3URlOBydtKwj1dZady+An3LTDz1AzSaJXCr5OrH7vwS+8HomL2zKQniUloJ0nehXd
         yV4gDL43CDDDdOBgfs791YqiiL1XlfCVPyA8ZS5vBinpE/A3Jk7zS6iBanozmgLDH/PG
         fHvr8EXXjjuZTa8+MoEJlPscSrPkWSbVMV7WMzKYSfU1IajudD4czBRxmzLbrEaNMNMl
         Q5mWZ62DQBMrqG8D98BxJ4wFovzOGyDdKetuDi5KR0PqZpUG6Dlcxc09RUdzuONigi5y
         CoNw==
X-Gm-Message-State: AOUpUlEvQtVqb2iZ7cMLnfUa+exrIFQwswdmul3XRgYq5l4wNv56a7Y9
        uajF9I7jrEzn32rE4PfDN7FHkw==
X-Google-Smtp-Source: AAOMgpdTHxUCSA8GCG4EO5SFE0cM4WnFWgxHM5zMbPbGanJ6ycBOofacbHWg0Zx6q8L6pkcUVHhThA==
X-Received: by 2002:aed:2a06:: with SMTP id c6-v6mr225907qtd.50.1533161411510;
        Wed, 01 Aug 2018 15:10:11 -0700 (PDT)
Received: from [10.136.4.147] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id p18-v6sm186804qtp.3.2018.08.01.15.10.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 15:10:11 -0700 (PDT)
Subject: Re: [PATCH v3 7/8] net: phy: Add support to configure clock in
 Broadcom iProc mdio mux
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
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
 <9af7e7a3-54d4-8802-f64a-fc4f9c49c8b9@broadcom.com>
 <20180801200712.GD19257@lunn.ch>
 <20180801202313.GH30658@n2100.armlinux.org.uk>
 <20180801203846.GE19257@lunn.ch>
 <8133c1f0-addc-5c48-7a6a-44b0d106c425@broadcom.com>
 <20180801215511.GG19257@lunn.ch>
From:   Arun Parameswaran <arun.parameswaran@broadcom.com>
Message-ID: <af188f23-bbef-ed90-b42d-a680c07f3fd2@broadcom.com>
Date:   Wed, 1 Aug 2018 15:10:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180801215511.GG19257@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 18-08-01 02:55 PM, Andrew Lunn wrote:
>> md->core_clk = devm_clk_get(&pdev->dev, NULL);
>> if (md->core_clk == ERR_PTR(-ENOENT) || md->core_clk == ERR_PTR(-EINVAL)) {
>> 	/* clock is optional, without it the default
>> 	 * rate divider register values will be used
>> 	 */
>> 	md->core_clk = NULL;
>> } else if (IS_ERR(md->core_clk)) {
>> 	return PTR_ERR(md->core_clk);
>> } else {
>> 	rc = clk_prepare_enable(md->core_clk);
>> 	...
>> }
> 
> As Florian pointed out, the clk_ API is happy to take a NULL pointer
> for a clock. So you don't need this last else.
> 
>     Andrew
> 
I do return with an error from the probe if the clk_prepare_enable() fails,
so I was calling the prepare with a valid clock.

In the other places where I used the clock, the return values were being
ignored.

The 'else' part should have been, I apologize for the confusion.

if (md->core_clk == ERR_PTR(-ENOENT) || md->core_clk == ERR_PTR(-EINVAL)) {
 	/* clock is optional, without it the default
 	 * rate divider register values will be used
 	 */
 	md->core_clk = NULL;
} else if (IS_ERR(md->core_clk)) {
 	return PTR_ERR(md->core_clk);
} else {
	rc = clk_prepare_enable(md->core_clk);
	if (rc) {
		dev_err(&pdev->dev, "failed to enable core clk\n");
		return rc;
	}
}


Thanks
Arun
