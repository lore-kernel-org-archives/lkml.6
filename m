Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6C6C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9F5214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ayTiuiqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbfA1LQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:16:37 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57848 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfA1LQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 06:16:36 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0SBGUDW027824;
        Mon, 28 Jan 2019 05:16:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548674190;
        bh=kOnXROCcOfTZQvSiyMmTbZICo0hQwvnfd3wKXaMZnWY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ayTiuiqs3EDmIzk4D0Au2goOhYB3LuxUNtdu40MwUpM4uFjJ6E6XRH7NmQzIDwCjd
         LjjKx337fxkMHFIJaJY4NP2wzWSa6GYzJe1PWagtaEBTAOzm+UQmrjUdl2E75r6YvA
         sZI74K7NuE8IT2kcIPtriEFieslugUIc7fqV7pHo=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0SBGUIl129636
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Jan 2019 05:16:30 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 28
 Jan 2019 05:16:29 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 28 Jan 2019 05:16:29 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0SBGQjs013666;
        Mon, 28 Jan 2019 05:16:27 -0600
Subject: Re: [PATCH 4/7] mmc: sdhci: Add quirk for disabling DTO during erase
 command
To:     Adrian Hunter <adrian.hunter@intel.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     <zhang.chunyan@linaro.org>, <kishon@ti.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <ulf.hansson@linaro.org>
References: <20190111110851.6805-1-faiz_abbas@ti.com>
 <20190111110851.6805-5-faiz_abbas@ti.com>
 <8c5875db-016c-c416-7356-d7a26d8d2a0e@intel.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <3ca3f7d3-cc75-f616-4c13-b044c8e52d4d@ti.com>
Date:   Mon, 28 Jan 2019 16:49:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <8c5875db-016c-c416-7356-d7a26d8d2a0e@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On 24/01/19 5:38 PM, Adrian Hunter wrote:
> On 11/01/19 1:08 PM, Faiz Abbas wrote:
>> Some controllers might prematurely issue a data timeout during an erase
>> command. Add a quirk to disable the interrupt when an erase command is
>> issued.
> 
> I might have already asked this, but would it be possible to use the
> existing SDHCI_QUIRK2_DISABLE_HW_TIMEOUT quirk?

This looks promising. Let me look into this. In any case, I should
probably move this to something like sdhci_set_timeout and use
sdhci_set_data_timeout_irq().

I was following 93caf8e69eac ("omap_hsmmc: add erase capability") for
adding this.

Thanks,
Faiz

> 
>>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> ---
>>  drivers/mmc/host/sdhci.c | 8 ++++++++
>>  drivers/mmc/host/sdhci.h | 2 ++
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 4a9044c06e21..cfd716aee552 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1560,6 +1560,14 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>>  	/* Initially, a command has no error */
>>  	cmd->error = 0;
>>  
>> +	if (cmd->opcode == MMC_ERASE &&
>> +	    (host->quirks2 & SDHCI_QUIRK2_DISABLE_DTO_FOR_ERASE)) {
>> +		mask = sdhci_readl(host, SDHCI_INT_ENABLE);
>> +		mask &= ~SDHCI_INT_DATA_TIMEOUT;
>> +		sdhci_writel(host, mask, SDHCI_INT_ENABLE);
>> +		sdhci_writel(host, mask, SDHCI_SIGNAL_ENABLE);
>> +	}
>> +
>>  	if ((host->quirks2 & SDHCI_QUIRK2_STOP_WITH_TC) &&
>>  	    cmd->opcode == MMC_STOP_TRANSMISSION)
>>  		cmd->flags |= MMC_RSP_BUSY;
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 7a52823ebef4..d0c6d4fe5371 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -479,6 +479,8 @@ struct sdhci_host {
>>   * block count.
>>   */
>>  #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
>> +/* Controller needs to disable DTO for erase command */
>> +#define SDHCI_QUIRK2_DISABLE_DTO_FOR_ERASE		(1<<19)
>>  
>>  	int irq;		/* Device IRQ */
>>  	void __iomem *ioaddr;	/* Mapped address */
>>
> 
