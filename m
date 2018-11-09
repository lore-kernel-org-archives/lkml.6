Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BECC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 05:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9F920855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 05:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9F920855
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeKIPHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 10:07:21 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40922 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbeKIPHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 10:07:20 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA95SIAN086255;
        Thu, 8 Nov 2018 23:28:18 -0600
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA95SI3q129122
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 23:28:18 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 8 Nov
 2018 23:28:18 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 8 Nov 2018 23:28:18 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA95SEMo004744;
        Thu, 8 Nov 2018 23:28:15 -0600
Subject: Re: [PATCH RFC 2/3] mmc: sdhci-omap: Add using external dma
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
References: <1541387810-24867-1-git-send-email-zhang.chunyan@linaro.org>
 <1541387810-24867-3-git-send-email-zhang.chunyan@linaro.org>
 <be0a18e8-8ee6-4d4e-6dcc-6ba6e39033c9@ti.com>
 <CAK8P3a2X4tbx_R-5VgfApF-UPmJ_XuzH3hO_uVAfffC6h8WrJw@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <44e1a97e-0446-283f-72f7-fd8d39a74b0f@ti.com>
Date:   Fri, 9 Nov 2018 10:57:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2X4tbx_R-5VgfApF-UPmJ_XuzH3hO_uVAfffC6h8WrJw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 06/11/18 6:21 PM, Arnd Bergmann wrote:
> On 11/5/18, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>> On 05/11/18 8:46 AM, Chunyan Zhang wrote:
>>>
>>> +	sdhci_switch_extdma(host, true);
>>
>> A number of devices using sdhci-omap supports ADMA. So switching to
>> external
>> DMA shouldn't be unconditional.
>>
>> IMHO sdhci.c should see if the device supports ADMA or SDMA. If not it
>> should
>> try switching to external DMA and if external DMA too is not supported, it
>> should use PIO.
> 
> What's the reasoning for preferring ADMA/SDMA over external DMA if
> both are supported?

Generally from our experiments we've found ADMA gives better throughput than
DMA. I have to ascertain the actual reasons for that.
> 
> I'd expect that if the external DMA for some reason is worse than
> ADMA, we just wouldn't list it in the DT at all, but if it's listed and
> ADMA also works, then the driver should try to use it before falling
> back to ADMA.

I would agree that for newer dtbs. However if you consider omap_hsmmc, external
DMA bindings are already added in dt. If we try to switch to sdhci-omap with
the same bindings, systems with older dtbs will use external DMA and give
lesser throughput.

Thanks
Kishon
