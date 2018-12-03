Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50913C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2A920881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wc5i15zV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F2A920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbeLCJBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:01:16 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:46456 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeLCJBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:01:15 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB390xUj081434;
        Mon, 3 Dec 2018 03:00:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543827659;
        bh=NSbB7LXLr4DaEi7N4+RxfTyXcDQoXWIoHFD9UUSFEps=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=wc5i15zV5GZk4GZBL8wjpr4/htRle7BccVWhcVFM6rB0swAfWkNKzWZDLMSe4Eabr
         OKurcF05wGa6slWXZ6tVyL0tGCW4/IkZboDPKvzN9e1lEx8FTZHroXE7y3Ie8FglZb
         hkT5hRBvP+rU87mqEuT44HAShiUum4QvhMGI2OuE=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB390xg8086995
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Dec 2018 03:00:59 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 3
 Dec 2018 03:00:59 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 3 Dec 2018 03:00:59 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB390tTV031263;
        Mon, 3 Dec 2018 03:00:56 -0600
Subject: Re: [PATCH V3 1/3] mmc: sdhci: add support for using external DMA
 devices
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
References: <1542007566-9449-2-git-send-email-zhang.chunyan@linaro.org>
 <1543471664-22856-1-git-send-email-zhang.chunyan@linaro.org>
 <cb2cdfb9-f3e6-72cd-2d55-734b08ea3e15@intel.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <42f994b2-ba98-8160-6eef-11eeb8a10f5e@ti.com>
Date:   Mon, 3 Dec 2018 14:33:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <cb2cdfb9-f3e6-72cd-2d55-734b08ea3e15@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chunyan,

On 29/11/18 2:53 PM, Adrian Hunter wrote:
> On 29/11/18 8:07 AM, Chunyan Zhang wrote:
>> Some standard SD host controllers can support both external dma
>> controllers as well as ADMA/SDMA in which the SD host controller
>> acts as DMA master. TI's omap controller is the case as an example.
>>
>> Currently the generic SDHCI code supports ADMA/SDMA integrated in
>> the host controller but does not have any support for external DMA
>> controllers implemented using dmaengine, meaning that custom code is
>> needed for any systems that use an external DMA controller with SDHCI.
>>
>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>> ---
>>  drivers/mmc/host/Kconfig |  14 ++++
>>  drivers/mmc/host/sdhci.c | 185 ++++++++++++++++++++++++++++++++++++++++++++++-
>>  drivers/mmc/host/sdhci.h |   8 ++
>>  3 files changed, 206 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index 1b58739..4183f43 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -969,6 +969,7 @@ config MMC_SDHCI_XENON
>>  config MMC_SDHCI_OMAP
>>  	tristate "TI SDHCI Controller Support">>  	depends on MMC_SDHCI_PLTFM && OF
>> +	select MMC_SDHCI_EXTERNAL_DMA if DMA_ENGINE


This should be in patch 2.

Thanks,
Faiz
