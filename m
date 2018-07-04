Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE8DC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA84224491
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MoB26GxV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA84224491
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753411AbeGDNfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:35:17 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52142 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752933AbeGDNfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:35:15 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w64DYkOO019237;
        Wed, 4 Jul 2018 08:34:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530711286;
        bh=Yc0cmkIQG/6qG4GKdNJyO0SaCl/cg6CEgs/ihH+DrYU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=MoB26GxVARD0VB5UTm6astELNihxR5+Uf7qUNDw0Dy4C89Z2HUbFuI4fAcPtaQIQv
         qkzWssmo9hRzfNiRCtTcrHwW05zHxwKG9hlQyQoNaLzxNe8sN7bwLavAnbV+qnoahP
         Tp3Nqqy0sl/8CMYkQ1UjWuGScU8wtegFNIMzA0d0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w64DYkvl014296;
        Wed, 4 Jul 2018 08:34:46 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 4 Jul
 2018 08:34:46 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 4 Jul 2018 08:34:46 -0500
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w64DYgAL028128;
        Wed, 4 Jul 2018 08:34:43 -0500
Subject: Re: [PATCH v3 4/6] bus: ti-sysc: Add support for software reset
To:     Tony Lindgren <tony@atomide.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <mark.rutland@arm.com>,
        <paul@pwsan.com>, <t-kristo@ti.com>, <robh+dt@kernel.org>,
        <bcousson@baylibre.com>
References: <a169ba7f-53f2-cf9a-a9ee-daffd6b53279@ti.com>
 <20180608062158.GI5738@atomide.com>
 <acdfef83-8778-e8f4-e423-ed04a9a8a649@ti.com>
 <20180611060957.GN5738@atomide.com>
 <f460481f-85a9-2a41-a894-6f25122dee8a@ti.com>
 <20180611062904.GO5738@atomide.com>
 <89d55b0b-fe9e-793b-2694-25755ac2bc15@ti.com>
 <20180611070332.GP5738@atomide.com> <20180703070743.GG112168@atomide.com>
 <ee54c3ea-6200-33dd-83da-491f5fdd9f5c@ti.com>
 <20180703073139.GN112168@atomide.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <1138704c-b7a4-391f-3404-e1bd25a4a0ff@ti.com>
Date:   Wed, 4 Jul 2018 19:06:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180703073139.GN112168@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 03 July 2018 01:01 PM, Tony Lindgren wrote:
> * Faiz Abbas <faiz_abbas@ti.com> [180703 07:31]:
>> Hi,
>>
>> On Tuesday 03 July 2018 12:37 PM, Tony Lindgren wrote:
>>> * Tony Lindgren <tony@atomide.com> [180611 07:06]:
>>>> * Faiz Abbas <faiz_abbas@ti.com> [180611 06:48]:
>>>>> Hi,
>>>>>
>>>>> On Monday 11 June 2018 11:59 AM, Tony Lindgren wrote:
>>>>>> * Faiz Abbas <faiz_abbas@ti.com> [180611 06:28]:
>>>>>>> Great. I thought I completely misunderstood you. But I don't see what
>>>>>>> adding another function will accomplish. A QUIRK flag used in the same
>>>>>>> function would work well enough>
>>>>>> Fine with me as long as the function stays simple for both
>>>>>> syss and sysc reset.
>>>>>>
>>>>>
>>>>>
>>>>> In general a reset status bit being in sysstatus is the norm and it
>>>>> being in sysconfig should be the "quirk" for which a flag needs to be
>>>>> added. What do you think?
>>>>
>>>> Sure makes sense to me.
>>>>
>>>>> As an aside, naming bitshifts by the name of the platform they were
>>>>> originally added in seems weird. There should be some generic mask
>>>>> saying "soft reset is the 0th bit". Currently I am using
>>>>> SYSC_OMAP4_SOFTRESET for a dra76x module. I guess it depends on how many
>>>>> different sysconfig types we have.
>>>>
>>>> Sure we could have a macro for that.
>>>
>>> So what's the conclusion on this one? Are you going to do one
>>> more version of the ti-sysc driver patch?
>>>
>>
>> Yes. I have just now been able to get back to this. Will post a v4 by
>> tomorrow.
> 
> OK thanks!
> 

After taking a second look at this thread, I don't see anything big to
be modified.

We both agree that "reset status bit in sysconfig register" is the quirk
case which can be added once such an IP is discovered in ti-sysc.

All I need to change is SYSC_OMAP4_SOFTRESET to SYSC_SOFT_RESET_SHIFT_0
for better readability and rebase it to the latest mainline.

Do reply if you differ on the above.

Thanks,
Faiz
