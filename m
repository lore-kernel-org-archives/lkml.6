Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268C8C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49322082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E49322082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbeLCNsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:48:32 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41576 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeLCNsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 08:48:32 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB3DlHFs130307;
        Mon, 3 Dec 2018 07:47:17 -0600
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB3DlHOg016526
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Dec 2018 07:47:17 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 3
 Dec 2018 07:47:17 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 3 Dec 2018 07:47:17 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB3DlEpt012528;
        Mon, 3 Dec 2018 07:47:14 -0600
Subject: Re: [PATCH v2 2/3] mmc: sdhci-omap: Add using external dma
To:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
References: <1542007566-9449-1-git-send-email-zhang.chunyan@linaro.org>
 <1542007566-9449-3-git-send-email-zhang.chunyan@linaro.org>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <8c54a77e-564d-40fc-32fe-eb4cee0181f1@ti.com>
Date:   Mon, 3 Dec 2018 19:20:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542007566-9449-3-git-send-email-zhang.chunyan@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chunyan,

On 12/11/18 12:56 PM, Chunyan Zhang wrote:
> sdhci-omap can support both external dma controller via dmaengine framework
> as well as ADMA which standard SD host controller provides.
> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> ---
>  drivers/mmc/host/sdhci-omap.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 88347ce..ccc79f2 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -896,6 +896,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
>  	const struct of_device_id *match;
>  	struct sdhci_omap_data *data;
>  	const struct soc_device_attribute *soc;
> +	struct resource *regs;
>  
>  	match = of_match_device(omap_sdhci_match, dev);
>  	if (!match)
> @@ -908,6 +909,10 @@ static int sdhci_omap_probe(struct platform_device *pdev)
>  	}
>  	offset = data->offset;
>  
> +	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!regs)
> +		return -ENXIO;
> +
>  	host = sdhci_pltfm_init(pdev, &sdhci_omap_pdata,
>  				sizeof(*omap_host));
>  	if (IS_ERR(host)) {
> @@ -924,6 +929,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
>  	omap_host->timing = MMC_TIMING_LEGACY;
>  	omap_host->flags = data->flags;
>  	host->ioaddr += offset;
> +	host->mapbase = regs->start;
>  
>  	mmc = host->mmc;
>  	sdhci_get_of_property(pdev);
> @@ -991,6 +997,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
>  	host->mmc_host_ops.execute_tuning = sdhci_omap_execute_tuning;
>  	host->mmc_host_ops.enable_sdio_irq = sdhci_omap_enable_sdio_irq;
>  
> +	sdhci_switch_external_dma(host, true);

You should give the user a choice based on a dt property whether to use
ADMA or use external DMA. We might still want to use external DMA for
some platforms and ADMA for other platforms.

Thanks,
Faiz
