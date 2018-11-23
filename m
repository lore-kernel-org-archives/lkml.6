Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AEBC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0DE2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QSaCHEoE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0DE2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409149AbeKWUYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:24:30 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:43336 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390381AbeKWUY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:24:29 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAN9esZR054552;
        Fri, 23 Nov 2018 03:40:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542966054;
        bh=Rl8/yy7BYysMmSLBzsx+bs03/qujR+2vnGNzx0EY5OA=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=QSaCHEoE+Zpm+Eh7VLFelwD6H4h5dMmkC5saSM7P7CPhLTLUowYArhRqoQRoxtwUR
         Q/U8XXAuyT5T9hoqhBEAE90IP6C8+QrSHkK29GNr3b/kvjGrG3Jug7Tlhmoyv+hkjK
         Hft0HgGrX0T8IXyLLSlBulxd5rvV3JUGXnoAEpR4=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAN9esQb033163
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Nov 2018 03:40:54 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 23
 Nov 2018 03:40:53 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 23 Nov 2018 03:40:53 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAN9enJx005715;
        Fri, 23 Nov 2018 03:40:50 -0600
Subject: Re: [PATCH 11/17] soc: ti: pruss: add pruss_get()/put() API
To:     Arnd Bergmann <arnd@arndb.de>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-12-git-send-email-rogerq@ti.com>
 <CAK8P3a0Nvdtq-TjK+1CGaOB+voyr-eky+h01n5i0z=8rB9PaHw@mail.gmail.com>
CC:     Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
        Beno??t Cousson <bcousson@baylibre.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Suman Anna <s-anna@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Tero Kristo <t-kristo@ti.com>, <nsaulnier@ti.com>,
        <jreeder@ti.com>, Murali Karicheri <m-karicheri2@ti.com>,
        <woods.technical@gmail.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5BF7CB20.7060502@ti.com>
Date:   Fri, 23 Nov 2018 11:40:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0Nvdtq-TjK+1CGaOB+voyr-eky+h01n5i0z=8rB9PaHw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/18 10:20, Arnd Bergmann wrote:
> On Thu, Nov 22, 2018 at 12:41 PM Roger Quadros <rogerq@ti.com> wrote:
> 
>> +
>> +       if (IS_ERR_OR_NULL(rproc))
>> +               return ERR_PTR(-EINVAL);
> 
> 
> Any usage of  IS_ERR_OR_NULL() tends to be an indication of a badly
> designed API. Please change this to allow only one of the two to be passed
> around.

The user of this API has to call pru_rproc_get() which never returns NULL.
So IS_ERR() should suffice here.

> 
>        Arnd
> 

cheers,
-roger

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
