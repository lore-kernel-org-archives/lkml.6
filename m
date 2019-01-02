Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7F0C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 08:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5219A21871
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 08:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="T4YgV3zd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbfABIXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 03:23:44 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52524 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbfABIXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 03:23:44 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x028NZTj081582;
        Wed, 2 Jan 2019 02:23:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1546417415;
        bh=Dbbfcr2Z83lDGzZ9bITKlN6X9XQCAz28Vy5dbqwInfE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=T4YgV3zdZP93waJPKkHhemNhe+6Exwy78EcFTbcoJLg1rJWWIh71alm1a6CbNTp70
         DwJQ8fzYzbk7qYMq2HlQyo1DOD24KczKnUddFznj0ImGSTFLUgoFuy0/UPBeLvURqb
         h50c17IBruc6tSSJuUH+1jQZcLDJOK2DnodlhFH8=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x028NZlY039848
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Jan 2019 02:23:35 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 2
 Jan 2019 02:23:35 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 2 Jan 2019 02:23:35 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x028NVUQ001262;
        Wed, 2 Jan 2019 02:23:32 -0600
Subject: Re: [PATCH V4 1/3] mmc: sdhci: add support for using external DMA
 devices
To:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>
References: <1544519572-21921-1-git-send-email-zhang.chunyan@linaro.org>
 <1544519572-21921-2-git-send-email-zhang.chunyan@linaro.org>
 <0e683aef-383c-8200-0059-44a9abb654b8@intel.com>
 <CAAfSe-tHu5m3Of6=KBCxBBH1T8=4tgN8aZP_7QaGERctECZPoQ@mail.gmail.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <f8adce24-99eb-7b65-a2f6-79536686511c@ti.com>
Date:   Wed, 2 Jan 2019 13:56:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAAfSe-tHu5m3Of6=KBCxBBH1T8=4tgN8aZP_7QaGERctECZPoQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian,

On 27/12/18 1:32 PM, Chunyan Zhang wrote:
> On Thu, 27 Dec 2018 at 15:44, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 11/12/18 11:12 AM, Chunyan Zhang wrote:
>>> Some standard SD host controllers can support both external dma
>>> controllers as well as ADMA/SDMA in which the SD host controller
>>> acts as DMA master. TI's omap controller is the case as an example.
>>>
>>> Currently the generic SDHCI code supports ADMA/SDMA integrated in
>>> the host controller but does not have any support for external DMA
>>> controllers implemented using dmaengine, meaning that custom code is
>>> needed for any systems that use an external DMA controller with SDHCI.
>>>
>>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>>
>> FYI, I am waiting on successful testing before reviewing these patches again.
> 
> Yeah, that makes sense, thanks Adrian!
> 
> I intend to send out another new patchset after the holidays.
> After had another look at omap_hsmmc, I knew something need to be
> modified (emailed Faiz about this privately), but I was still not sure
> if it can fix the problem Faiz found.
> 

I am currently working on moving am335 and am43 devices from omap_hsmmc
to sdhci-omap driver. External DMA would be an integral part of this.
The plan is to post these patches as a part of my series after testing
on all those devices.

Thanks,
Faiz
