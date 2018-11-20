Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD4BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A50A20671
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LrHhgcaz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A50A20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeKTUf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:35:29 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58688 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeKTUf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:35:29 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAKA6bT7048269;
        Tue, 20 Nov 2018 04:06:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542708397;
        bh=st1wmS97hcI8VjZoTGm8GuDrZ/ekpNFP9w2qqupKLBg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=LrHhgcaz/IpuzQTJBvc+lWR/lh5/kBinFL3BNzq9WYL4VcHWAVPLE8YwCDSh3r1e4
         mlx6iz6IXKRZbe7vD+8Zo1JA4hqthmkbXYtVXtcWomDa9xBDz47g26C1Pz+UQDrIB9
         lP/y8dFdK2GfjLXk1R2rMS6vMpUMowXeXIUCLaHs=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAKA6al5130666
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Nov 2018 04:06:36 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 20
 Nov 2018 04:06:36 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 20 Nov 2018 04:06:36 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAKA6Wfa029020;
        Tue, 20 Nov 2018 04:06:33 -0600
Subject: Re: [PATCH] mmc: core: Remove timeout when enabling cache
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sjoerd Simons <sjoerd.simons@collabora.co.uk>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        <kernel@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hongjie Fang <hongjiefang@asrmicro.com>,
        Bastian Stender <bst@pengutronix.de>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Harish Jenny K N <harish_kandiga@mentor.com>,
        Simon Horman <horms+renesas@verge.net.au>
References: <20181106133007.12318-1-sjoerd.simons@collabora.co.uk>
 <9051c212-6e2a-bc39-3686-693e6cd87f1d@ti.com>
 <303b49cbb5b687d6b6a7ad4048eda459586c0806.camel@collabora.co.uk>
 <20181107084741.GA31092@kunai>
 <CAPDyKFpedP1f4XZYvebFCuooYrBa2ux9F9mYRNi1Q=M-5eJ0Rg@mail.gmail.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <327f0d23-efd7-a8e3-23d8-945132573c06@ti.com>
Date:   Tue, 20 Nov 2018 15:39:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpedP1f4XZYvebFCuooYrBa2ux9F9mYRNi1Q=M-5eJ0Rg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uffe,

On 20/11/18 2:54 PM, Ulf Hansson wrote:
> On 7 November 2018 at 09:47, Wolfram Sang <wsa@the-dreams.de> wrote:
>>
>>> That also happens to be one of the cards we deploy; However i did
>>> wonder about adding a quirk but decided against it as it was not clear
>>> to me from the specification that CACHE ON really is meant to complete
>>> within GENERIC_CMD6_TIMEOUT. That and i fret about ending up in hit-a-
>>> mole games as the failure is really quite tedious (boot failure).
>>
>> I agree that we should use the more defensive variant as a default. I
>> mean there should be no performance regression since most cards will
>> respond just faster, or? The only downside I could see is that we might
>> miss a real timeout with no bounds set and might get stuck?
> 
> Well, you have a point, but still it's kind of nice to know which
> cards are behaving well and which ones that doesn't. Hence I think I
> prefer to stick using a quirk, unless you have a strong opinion.
> 
> Note that, in this case we can use CMD13 to poll for busy, which then
> means it also works for those hosts that doesn't support HW busy
> detection, without getting additional delays. If this hasn't been the
> case, we must be using a quirk, but now we are more free to choose.
> 
>> Maybe it is
>> worth contacting eMMC spec people to at least know what is the expected
>> behaviour?
> 
> According to the spec, the GENERIC_CMD6_TIMEOUT should be sufficient.
> So this card is not conforming to the spec, I think it's as simple as
> that.
> 

Is the QUIRK patch acceptable as it is or do you require some sort of
errata from the card manufacturers?

Thanks,
Faiz
