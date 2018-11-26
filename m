Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FFBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9072086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="t4cIGTr0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB9072086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbeKZUnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 15:43:01 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:43072 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbeKZUnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 15:43:00 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAQ9nJPo021384;
        Mon, 26 Nov 2018 03:49:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543225759;
        bh=u76TlQpPsm+1e7kgGekCZ9xvT0awBuq6MaFcju4bxPk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=t4cIGTr02ImJ1csOVMMTRSxndFCfOFQyjLPwYyzqQC2TTFKnAG8b2lSBrdvm6xqPK
         53M44hWRFZfZK0MYS6uEWKI++V80Yr4UtYV/nJBOXhLkXk/VZ3pPD2AOuGVESc1/wn
         C7Vcg09XVZN68ttREfVKXw3VMulJCfgZ/UJ1887M=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAQ9nJCr053359
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Nov 2018 03:49:19 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 26
 Nov 2018 03:49:19 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 26 Nov 2018 03:49:19 -0600
Received: from [172.22.5.0] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ9nEfC024156;
        Mon, 26 Nov 2018 03:49:15 -0600
Subject: Re: omap5 fixing palmas IRQ_TYPE_NONE warning leads to gpadc timeouts
To:     Thierry Reding <treding@nvidia.com>,
        Tony Lindgren <tony@atomide.com>
CC:     Jon Hunter <jonathanh@nvidia.com>,
        Belisko Marek <marek.belisko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        "Dr. H. Nikolaus Schaller" <hns@goldelico.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
References: <CAAfyv35bat+t6awL-VRigAoaUTySwOgZkQMs=W9mEKQ6VDW3FA@mail.gmail.com>
 <20180703084516.GT112168@atomide.com>
 <CAAfyv37F1s8Cg=pfxiN0dA6YEX7KMB-+uifjRoqAdKGWLeYEwA@mail.gmail.com>
 <20181113180656.GE53235@atomide.com>
 <46d271b2-35d3-6353-c530-3292cdac53ab@ti.com>
 <20181119161906.GP53235@atomide.com> <20181119171406.GQ53235@atomide.com>
 <725df8e7-4aff-3751-d0b0-809b89e882e5@nvidia.com>
 <20181123164827.GE53235@atomide.com> <20181126093625.GA10878@ulmo>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <d3f17ac6-c13b-5b5f-a482-b565b130f1ba@ti.com>
Date:   Mon, 26 Nov 2018 11:49:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181126093625.GA10878@ulmo>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thierry,

On 11/26/18 11:36 AM, Thierry Reding wrote:
> On Fri, Nov 23, 2018 at 08:48:27AM -0800, Tony Lindgren wrote:
>> * Jon Hunter <jonathanh@nvidia.com> [181120 11:14]:
>>> On 19/11/2018 17:14, Tony Lindgren wrote:
>>>> Well so commit 7e9d474954f4 ("ARM: tegra: Correct polarity for
>>>> Tegra114 PMIC interrupt") states that tegra114 inverts the
>>>> polarity of the PMIC interrupt. So adding Jon and Thierry to Cc.
>>>
>>> Yes Tegra can invert the polarity of the PMIC interrupt.
>>
>> So is there some IP on Tegra called "Tegra PMC" that is
>> inverting the interrupt? Or is the "Tegra PMC" that commit
>> 7e9d474954f4 mentions just the palmas configuration for
>> inverting the interrupt?
> 
> Yes, there's indeed an IP called PMC (Power-Management Controller) on
> Tegra. It has a special input that is usually wired up to the PMIC
> interrupt and a bit in the control register that configures the polarity
> of that interrupt. If the PMIC generates a low-active interrupt we
> usually set that bit to make sure it is properly sampled by the PMC.
> 
> The symptoms of this being incorrectly configured is usually an
> interrupt storm on the PMIC interrupt, which I think typically results
> in the system not booting at all, or taking a very long time to boot
> because of that storm.
> 
>> The problem I'm having is With omap5 where I can only get the
>> PMIC interrupts working with IRQ_TYPE_LEVEL_HIGH if
>> PALMAS_POLARITY_CTRL_INT_POLARITY is not set unlike for
>> Tegra.
> 
> Does somebody have access to the Palmas documentation? That should
> pretty clearly state what the default polarity is and what it changes to
> if you set the interrupt polarity bit.

The register map documentation I have states the following:
bit7 INT_POLARITY Select the polarity of the INT output line
0: Interrupt line (INT) is low when interrupt is pending (default) RW
1: Interrupt line (INT) is high when interrupt is pending

By default the Palmas irq is active low.

> From what you're saying it sounds like either the logic is the wrong way
> around in the Palmas MFD driver (and we correct it by switching it back
> to the correct polarity in the PMC) or that you'd need to find some way
> of inverting in on OMAP5.
> 
> Thierry
> 

- Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
