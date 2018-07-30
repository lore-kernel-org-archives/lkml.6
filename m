Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A5E16256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACBC220881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cK8LrSx1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACBC220881
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbeG3SdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:33:06 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:44576 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeG3SdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:33:05 -0400
Received: by mail-qk0-f194.google.com with SMTP id v17-v6so8247839qkb.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 09:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6woCotw0Oe1q82X4dVyME3qEhFpM4cTrkDGE/TBOSAU=;
        b=cK8LrSx1guD/eWwnHBdVpR5ymgltmLvCkr1wkDu3zqTPiQRKrAQYwNCb/d1vjySZS7
         zlDzJhrsht+gvZRIF2Yxvq3FEcItzZ0m0DNMqV/NgBqg5LKNoHdacz2vaG9d6NHN4JUT
         ZmhBRU1F3LY7vnQgFjo3O8Q9eBMELDImmZUok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6woCotw0Oe1q82X4dVyME3qEhFpM4cTrkDGE/TBOSAU=;
        b=jksMlYDAlk2gycbbO9mwXV4uujtqaRYQkOLRkMLUgHLCwBt65N2hLpLYDGeaJY5EI2
         V/RmHste370u2kWeFie0KMDSNrKtNd69uDYC3sqRbsVFNKTzIaSbKeEfVSXc21dTVOzf
         IHruoOiQl0w2H2BEB2PPykj/ko8eVi8eN6Gq+CEaVY1AUN9rIGBo37J+gW4cD9YhCimP
         FAdH46qB81GZZ9TfjeS3Ih2LSLvElMOPjq2AV185MAgsVk4ve0R7efqp+dKSur7mrMOr
         RcTDg9AVWqvHsR5ZoOc5xm/XxzydDRT++a4W42Vr6AHfo1UkEtE68QlQ2K+eefaCW0kM
         AcDA==
X-Gm-Message-State: AOUpUlGJmiuQX0z3GNWuJFETi+6/OqJMpdUrSP1MKbpTiuLBRMFaALif
        yTUCp1sm37CK62CRgLb4Xrk0bg==
X-Google-Smtp-Source: AAOMgpfunBL7RGyprPxFQPDjXk9QtBH7EOKDaMjyzdfuZjf3BBI7N/kBD5F0Jhep+6GIsntcDbmO2g==
X-Received: by 2002:a37:a24f:: with SMTP id l76-v6mr15850791qke.406.1532969831636;
        Mon, 30 Jul 2018 09:57:11 -0700 (PDT)
Received: from [10.136.4.147] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id s31-v6sm4608289qtg.19.2018.07.30.09.57.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 09:57:11 -0700 (PDT)
Subject: Re: [PATCH v2 0/7] Add clock config and pm support to bcm iProc mdio
 mux
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
 <20180728213233.GH4792@lunn.ch>
From:   Arun Parameswaran <arun.parameswaran@broadcom.com>
Message-ID: <53a99d1b-f945-2ab6-d564-d4837fb8639d@broadcom.com>
Date:   Mon, 30 Jul 2018 09:57:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180728213233.GH4792@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

On 18-07-28 02:32 PM, Andrew Lunn wrote:
> On Fri, Jul 27, 2018 at 02:23:26PM -0700, Arun Parameswaran wrote:
>> Hi,
>> The patchset is based on David Miller's "net-next" repo.
>>
>> The patchset extends the Broadcom iProc mdio mux to add support for
>> suspend/resume and the ability to configure the internal clock
>> divider. The patchset also sets the scan control register to
>> disable external master access.
> 
> Hi Arun
> 
> It would be good to modify the .dtsi files to make use of the new
> clock properties.
> 
The clock is done primarily for the newer Omega SoC. I hope, we will
upstream the devicetree file for Omega soon.

The existing NS2 and Stingray SoC's, default to proper values in the
hardware registers, so they did not need to specify the clock. They
will also work over sleep cycles for the same reason.

But, I will ask around to see if we can add the clock for those
SoC's as well.

Thanks
Arun

>       Andrew
> 

