Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8D6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5639920989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bx2+/s8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5639920989
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbeKUUKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:10:08 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50228 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbeKUUKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:10:08 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAL9aM18106750;
        Wed, 21 Nov 2018 03:36:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542792982;
        bh=+pjQzllsoqj/Lp/Rp2pjPsBZ7yAVWCg2dGcV3M/83SI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bx2+/s8YnDfW0i0apmzKzUtYy/onBBR5WakWizthBMR/0/RXRxrNDETHD0SLibI2J
         lrjo9RX/gFEKfZ44Hb3dC1dNAfOCk8NRz3OlhJTzb5riDA6QmYY8z3/yC1wCp2PO4p
         E0xt6x5o1uD9+vGonmR55RzKZWrGAz8bYcsci4Ms=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAL9aMpE068177
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Nov 2018 03:36:22 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 21
 Nov 2018 03:36:21 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 21 Nov 2018 03:36:21 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAL9aJPS007135;
        Wed, 21 Nov 2018 03:36:20 -0600
Subject: Re: [PATCH 1/4] mmc: sdhci-omap: Fix DCRC error handling during
 tuning
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>
References: <20181119111618.2745-1-faiz_abbas@ti.com>
 <20181119111618.2745-2-faiz_abbas@ti.com>
 <b4568cfc-55c6-9dfc-6d26-1efc999e95ec@ti.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <c4c73144-eed1-2f34-953f-85da5b7ba955@ti.com>
Date:   Wed, 21 Nov 2018 15:09:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <b4568cfc-55c6-9dfc-6d26-1efc999e95ec@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

On 20/11/18 10:23 AM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On 19/11/18 4:46 PM, Faiz Abbas wrote:
>> Commit 7d33c3581536 ("mmc: sdhci-omap: Workaround for Errata i802")
>> disabled DCRC interrupts during tuning. This write to the interrupt
>> enable register gets overwritten in sdhci_prepare_data() and the
>> interrupt is not in fact disabled. Fix this by disabling the interrupt
>> in the host->ier variable.
>>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> ---
>>   drivers/mmc/host/sdhci-omap.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-omap.c
>> b/drivers/mmc/host/sdhci-omap.c
>> index 88347ce78f23..87138067e334 100644
>> --- a/drivers/mmc/host/sdhci-omap.c
>> +++ b/drivers/mmc/host/sdhci-omap.c
>> @@ -290,7 +290,6 @@ static int sdhci_omap_execute_tuning(struct
>> mmc_host *mmc, u32 opcode)
>>       u32 start_window = 0, max_window = 0;
>>       u8 cur_match, prev_match = 0;
>>       u32 length = 0, max_len = 0;
>> -    u32 ier = host->ier;
>>       u32 phase_delay = 0;
>>       int ret = 0;
>>       u32 reg;
>> @@ -317,9 +316,7 @@ static int sdhci_omap_execute_tuning(struct
>> mmc_host *mmc, u32 opcode)
>>        * during the tuning procedure. So disable it during the
>>        * tuning procedure.
>>        */
>> -    ier &= ~SDHCI_INT_DATA_CRC;
>> -    sdhci_writel(host, ier, SDHCI_INT_ENABLE);
>> -    sdhci_writel(host, ier, SDHCI_SIGNAL_ENABLE);
>> +    host->ier &= ~SDHCI_INT_DATA_CRC;
>>         while (phase_delay <= MAX_PHASE_DELAY) {
>>           sdhci_omap_set_dll(omap_host, phase_delay);
>> @@ -366,6 +363,8 @@ static int sdhci_omap_execute_tuning(struct
>> mmc_host *mmc, u32 opcode)
>>     ret:
>>       sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
>> +    /* Reenable forbidden interrupt */
>> +    host->ier |= SDHCI_INT_DATA_CRC;
> 
> It's better to have a backup of host->ier and restore the value here (in
> case DATA_CRC is disabled for other cases).
> 

host->ier is modified everywhere during an mmc request. I would not
expect it to hold its value after so many tuning commands. I can add a
bool to check of DCRC was enabled before and only then re-enable it.

Thanks,
Faiz
