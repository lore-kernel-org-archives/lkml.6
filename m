Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9994C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 04:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B381B206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 04:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B381B206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730948AbeKTPUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 10:20:20 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46384 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730276AbeKTPUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 10:20:20 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAK4r8XR113701;
        Mon, 19 Nov 2018 22:53:08 -0600
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAK4r8Ec086979
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Nov 2018 22:53:08 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 19
 Nov 2018 22:53:08 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 19 Nov 2018 22:53:08 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAK4r6pB015006;
        Mon, 19 Nov 2018 22:53:07 -0600
Subject: Re: [PATCH 1/4] mmc: sdhci-omap: Fix DCRC error handling during
 tuning
To:     Faiz Abbas <faiz_abbas@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>
References: <20181119111618.2745-1-faiz_abbas@ti.com>
 <20181119111618.2745-2-faiz_abbas@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <b4568cfc-55c6-9dfc-6d26-1efc999e95ec@ti.com>
Date:   Tue, 20 Nov 2018 10:23:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181119111618.2745-2-faiz_abbas@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/11/18 4:46 PM, Faiz Abbas wrote:
> Commit 7d33c3581536 ("mmc: sdhci-omap: Workaround for Errata i802")
> disabled DCRC interrupts during tuning. This write to the interrupt
> enable register gets overwritten in sdhci_prepare_data() and the
> interrupt is not in fact disabled. Fix this by disabling the interrupt
> in the host->ier variable.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>   drivers/mmc/host/sdhci-omap.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 88347ce78f23..87138067e334 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -290,7 +290,6 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
>   	u32 start_window = 0, max_window = 0;
>   	u8 cur_match, prev_match = 0;
>   	u32 length = 0, max_len = 0;
> -	u32 ier = host->ier;
>   	u32 phase_delay = 0;
>   	int ret = 0;
>   	u32 reg;
> @@ -317,9 +316,7 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
>   	 * during the tuning procedure. So disable it during the
>   	 * tuning procedure.
>   	 */
> -	ier &= ~SDHCI_INT_DATA_CRC;
> -	sdhci_writel(host, ier, SDHCI_INT_ENABLE);
> -	sdhci_writel(host, ier, SDHCI_SIGNAL_ENABLE);
> +	host->ier &= ~SDHCI_INT_DATA_CRC;
>   
>   	while (phase_delay <= MAX_PHASE_DELAY) {
>   		sdhci_omap_set_dll(omap_host, phase_delay);
> @@ -366,6 +363,8 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
>   
>   ret:
>   	sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> +	/* Reenable forbidden interrupt */
> +	host->ier |= SDHCI_INT_DATA_CRC;

It's better to have a backup of host->ier and restore the value here (in 
case DATA_CRC is disabled for other cases).

Thanks
Kishon
