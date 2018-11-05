Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E6BC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 04:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D1B72081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 04:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="r6l9ch7v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D1B72081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbeKENno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 08:43:44 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36070 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbeKENnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 08:43:43 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA54PtlY087524;
        Sun, 4 Nov 2018 22:25:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1541391955;
        bh=yS6WWCLTyJYPFndKlcCRRbHfB+WYqTLZzLAnK10A8Io=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=r6l9ch7v2v6/2Lm1Vr16XN3OrqJwD39aIqLBY3uC9ykXZMq4PNQgWrXCu0HlxLwul
         APFSEwWiYOQeLZAkgKBwsATm8Mpc88nnDQkHt+I+SpTWDLGAXQ0FYheD4GgQn2lVQH
         VnKoElEpqExCBUhrtfG/jMIuAt7XnmGLA/k19Ay8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA54PtZ5048341
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 4 Nov 2018 22:25:55 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Sun, 4 Nov
 2018 22:25:54 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Sun, 4 Nov 2018 22:25:54 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA54Ppds027531;
        Sun, 4 Nov 2018 22:25:52 -0600
Subject: Re: [PATCH RFC 2/3] mmc: sdhci-omap: Add using external dma
To:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
References: <1541387810-24867-1-git-send-email-zhang.chunyan@linaro.org>
 <1541387810-24867-3-git-send-email-zhang.chunyan@linaro.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <be0a18e8-8ee6-4d4e-6dcc-6ba6e39033c9@ti.com>
Date:   Mon, 5 Nov 2018 09:55:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1541387810-24867-3-git-send-email-zhang.chunyan@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05/11/18 8:46 AM, Chunyan Zhang wrote:
> sdhci-omap can support both external dma controllers via dmaengine
> framework as well as ADMA in which the controller acts as DMA master.
> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> ---
>  drivers/mmc/host/sdhci-omap.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 88347ce..0a8162c 100644
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
> +	sdhci_switch_extdma(host, true);

A number of devices using sdhci-omap supports ADMA. So switching to external
DMA shouldn't be unconditional.

IMHO sdhci.c should see if the device supports ADMA or SDMA. If not it should
try switching to external DMA and if external DMA too is not supported, it
should use PIO.

Thanks
Kishon
