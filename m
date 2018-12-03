Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B17C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B384206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="q5aqGeOM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B384206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbeLCN4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:56:30 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34600 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbeLCN4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 08:56:30 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB3DtH6D035033;
        Mon, 3 Dec 2018 07:55:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543845317;
        bh=5+3+S8v0hBrjjYVeuzncQ4PaQduRXxRJ/bcrU4uUAVI=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=q5aqGeOMGhX9uh8fZISoB8DLshMoH645ttXBs/Dbz30S/qaCMwRcOTQBKMkYBpWWF
         DmtU6T6E2OKtUMNRCU8OeI2VnkOcu9gzvfAw7Lxh/GDLx32wvIf5twHkoxCraX0kbz
         ZL6CUNhm/ve0jYTVUZt/3vo29mNRCV4noC8fepqg=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB3DtHxU025088
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Dec 2018 07:55:17 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 3
 Dec 2018 07:55:17 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 3 Dec 2018 07:55:17 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB3DtD7h012802;
        Mon, 3 Dec 2018 07:55:14 -0600
Subject: Re: [PATCH V3 1/3] mmc: sdhci: add support for using external DMA
 devices
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
References: <1542007566-9449-2-git-send-email-zhang.chunyan@linaro.org>
 <1543471664-22856-1-git-send-email-zhang.chunyan@linaro.org>
 <f198a61f-40e8-973a-5541-a1bc1dc347de@ti.com>
Message-ID: <b771f900-cdd6-5cdf-c3ad-f8b034582439@ti.com>
Date:   Mon, 3 Dec 2018 19:28:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <f198a61f-40e8-973a-5541-a1bc1dc347de@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/12/18 5:45 PM, Faiz Abbas wrote:
> Hi,
> 
>> +static void sdhci_external_dma_prepare_data(struct sdhci_host *host,
>> +					    struct mmc_command *cmd)
>> +{
> 
> Please add a condition for data == NULL here. This was already pointed
> out by Adrian in v2.
> 
> My test with an am335x-evm failed with these patches. Looks like the
> very first SDIO commands failing.
> 
> https://pastebin.ubuntu.com/p/Y2RDjSKpgd/
> 
> Currently am335x-evm is using omap_hsmmc driver. I added the following
> patch to make it work with sdhci_omap.
> 
> https://pastebin.ubuntu.com/p/VTGrCbJxY3/
> 
> Will look deeper into this. Please ping if you need any more information.
> 

So I disabled DMA in the driver altogether and still got the same
messages on am335x-evm in PIO mode. Looks like something more is
required for it to be supported.

I instead shifted to a dra71-evm which supports both ADMA and external
DMA. Here is the log:

https://pastebin.ubuntu.com/p/mcJmgcjQsp/

The interface fundamentally works but it complains with the following error:

[3.111693] Failed to request TX DMA channel.


Thanks,
Faiz

