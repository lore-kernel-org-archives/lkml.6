Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98810C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED42208A1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KSa6+JkW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED42208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754565AbeGCH20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:28:26 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38100 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753554AbeGCH2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:28:24 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w637S3Qh051841;
        Tue, 3 Jul 2018 02:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530602883;
        bh=1+2AyS5aCij+UClqa57DLxZr5mGzZnFXZEWs9qLuFTE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KSa6+JkWfipuUKHSv14baphmfP9eLs+GVtQ4AmLo7QSDERXs+Z3/hFjlodqty2da6
         c2w/PnUZEGyRr7DKq6RUiXZFk304aHExYk6gvppcsdGJ6L/0+pSisVZOFXri2+zR/6
         Mm/oXLmEcwjN4QnVuq9M9Q9g3M5dv49RA+jwrY2U=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w637S3Yd008669;
        Tue, 3 Jul 2018 02:28:03 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 3 Jul
 2018 02:28:02 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 3 Jul 2018 02:28:02 -0500
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w637RwDW016707;
        Tue, 3 Jul 2018 02:27:59 -0500
Subject: Re: [PATCH v3 4/6] bus: ti-sysc: Add support for software reset
To:     Tony Lindgren <tony@atomide.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <mark.rutland@arm.com>,
        <paul@pwsan.com>, <t-kristo@ti.com>, <robh+dt@kernel.org>,
        <bcousson@baylibre.com>
References: <20180606060826.14671-5-faiz_abbas@ti.com>
 <20180607073530.GH5738@atomide.com>
 <a169ba7f-53f2-cf9a-a9ee-daffd6b53279@ti.com>
 <20180608062158.GI5738@atomide.com>
 <acdfef83-8778-e8f4-e423-ed04a9a8a649@ti.com>
 <20180611060957.GN5738@atomide.com>
 <f460481f-85a9-2a41-a894-6f25122dee8a@ti.com>
 <20180611062904.GO5738@atomide.com>
 <89d55b0b-fe9e-793b-2694-25755ac2bc15@ti.com>
 <20180611070332.GP5738@atomide.com> <20180703070743.GG112168@atomide.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <ee54c3ea-6200-33dd-83da-491f5fdd9f5c@ti.com>
Date:   Tue, 3 Jul 2018 12:59:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180703070743.GG112168@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 03 July 2018 12:37 PM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [180611 07:06]:
>> * Faiz Abbas <faiz_abbas@ti.com> [180611 06:48]:
>>> Hi,
>>>
>>> On Monday 11 June 2018 11:59 AM, Tony Lindgren wrote:
>>>> * Faiz Abbas <faiz_abbas@ti.com> [180611 06:28]:
>>>>> Great. I thought I completely misunderstood you. But I don't see what
>>>>> adding another function will accomplish. A QUIRK flag used in the same
>>>>> function would work well enough>
>>>> Fine with me as long as the function stays simple for both
>>>> syss and sysc reset.
>>>>
>>>
>>>
>>> In general a reset status bit being in sysstatus is the norm and it
>>> being in sysconfig should be the "quirk" for which a flag needs to be
>>> added. What do you think?
>>
>> Sure makes sense to me.
>>
>>> As an aside, naming bitshifts by the name of the platform they were
>>> originally added in seems weird. There should be some generic mask
>>> saying "soft reset is the 0th bit". Currently I am using
>>> SYSC_OMAP4_SOFTRESET for a dra76x module. I guess it depends on how many
>>> different sysconfig types we have.
>>
>> Sure we could have a macro for that.
> 
> So what's the conclusion on this one? Are you going to do one
> more version of the ti-sysc driver patch?
> 

Yes. I have just now been able to get back to this. Will post a v4 by
tomorrow.

Thanks,
Faiz
