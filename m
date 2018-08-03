Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F03FC43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 01:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8E021717
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 01:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Pn9waIHf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A8E021717
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732328AbeHCDsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 23:48:03 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59736 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731967AbeHCDsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 23:48:02 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w731qZo3063912;
        Thu, 2 Aug 2018 20:52:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1533261155;
        bh=AWWZKZv2WOgIbdkA9s/f1lQMXa2TIPvKaordSVHEN9c=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Pn9waIHfFHomI1iQKUrImfhIC1KMeeIz6n1uD2VHGOudjqlre1SOOx0B1NOAu7yRf
         OaLTM/KRZzqe0wL6YHnqxc4Thk3d9/Xzdj+qFsDP4zfChrNhlQYstNLg0zSbNQCMeO
         ZlHlhXFYZLXH/dKkqWKX4N5njZk20rw1d7vjNHXE=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w731qZGT032203;
        Thu, 2 Aug 2018 20:52:35 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 2 Aug
 2018 20:52:35 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 2 Aug 2018 20:52:35 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w731qZ0V005103;
        Thu, 2 Aug 2018 20:52:35 -0500
Subject: Re: [RFC PATCH 6/8] gpio: omap: Add get/set_multiple() callbacks
To:     Linus Walleij <linus.walleij@linaro.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        ext Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>
CC:     Boris Brezillon <boris.brezillon@bootlin.com>,
        =?UTF-8?Q?Miqu=c3=a8l_Raynal?= <miquel.raynal@bootlin.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Mark Vasut <marek.vasut@gmail.com>,
        <linux-mtd@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180718235710.18242-7-jmkrzyszt@gmail.com>
 <CACRpkdbH9Vu12RckQPKhGgyJnyxaQ04d5qa9srHwneP3SS6FAA@mail.gmail.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <7a28e14e-8bdc-1408-2464-ad3a0d2f3116@ti.com>
Date:   Thu, 2 Aug 2018 20:52:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdbH9Vu12RckQPKhGgyJnyxaQ04d5qa9srHwneP3SS6FAA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/29/2018 03:29 PM, Linus Walleij wrote:
> On Thu, Jul 19, 2018 at 1:56 AM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> 
>> This should make applications utilizing whole banks work faster.
>>
>> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> 
> This patch looks good to me and I have an urge to just apply it.
> 
> Can we get some feedback from the maintainers?
> 

Acked-by: Grygorii Strashko <grygorii.strashko@ti.com>
-- 
regards,
-grygorii
