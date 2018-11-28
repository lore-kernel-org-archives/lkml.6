Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5DFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D35B2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lYpiKIbd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D35B2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbeK2EB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:01:26 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40550 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbeK2EBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:01:25 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wASGx0Lx025271;
        Wed, 28 Nov 2018 10:59:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543424340;
        bh=eOkKijLLhi/0RTiv42MS8Cw42Cdt10FccWGUM7O3kr8=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=lYpiKIbdYKhXL3peGNMa/YIjLJUUOyC3W++xom/GeiDYoA5nV2qCu2hWUKivFJ3dq
         Ph7+tpdyVRk0Xv/23IDsMMtNz+TyYT1WZMYwQkhSzVQbRTJEcUEvHhXw51Tl2NKSL/
         Ofksci+MsWT+tk6JKv24j/YRT0dKJmZ8hBHANluA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wASGx0ni066446
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Nov 2018 10:59:00 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 28
 Nov 2018 10:59:00 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 28 Nov 2018 10:59:00 -0600
Received: from [172.22.97.99] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wASGwsjV026257;
        Wed, 28 Nov 2018 10:58:55 -0600
Subject: Re: [PATCH v2 0/3] Add support for using external dma in SDHCI
From:   "Rizvi, Mohammad Faiz Abbas" <faiz_abbas@ti.com>
To:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, <broonie@kernel.org>
References: <1542007566-9449-1-git-send-email-zhang.chunyan@linaro.org>
 <fb8a9eb6-82a1-1299-489f-9fed4ee48a02@ti.com>
Message-ID: <5a45f520-03b0-3679-2175-a19681062bf6@ti.com>
Date:   Wed, 28 Nov 2018 22:28:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <fb8a9eb6-82a1-1299-489f-9fed4ee48a02@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Mark Brown

Chunyan,

On 11/21/2018 5:17 PM, Faiz Abbas wrote:
> Hi Chunyan,
> 
> On 12/11/18 12:56 PM, Chunyan Zhang wrote:
>> Currently the generic SDHCI code in the Linux kernel supports the SD
>> standard DMA integrated into the host controller but does not have any
>> support for external DMA controllers implemented using dmaengine meaning
>> that custom code is needed for any systems that use a generic DMA
>> controller with SDHCI which in practice means any SDHCI controller that
>> doesn't have an integrated DMA controller so we should have this as a
>> generic feature.
>>
>> There are already a number of controller specific drivers that have dmaengine
>> code, and some could use sdhci.c actually, but needed to implement mmc_ops->request()
>> in their specific driver for sending command with external dma using dmaengine
>> framework, with this patchset, them will take advantage of the generic support.
>> TI's omap controller is the case as an example.
>>
>> Any comments are very appreciated.
>>
> 
> This is great. It helps us move am335x and am43xx platforms to
> sdhci-omap. What platforms have you tested this on?
> 

Gentle ping on this. I tried testing these with an am335x-evm board. In 
their current condition, the card fails to enumerate altogether. The 
changes suggested by Adrian should fix this. Let me know when you post a v3.

Thanks,
Faiz
