Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF60C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7005B2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QdoLPWf+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7005B2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbeLDKig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:38:36 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:48570 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbeLDKig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:38:36 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB4AcTb2026591;
        Tue, 4 Dec 2018 04:38:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543919909;
        bh=bRgLyaRcKZ/kesJRlA39/0dJLLBW1qnez5tzo7GjSqg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QdoLPWf+IIDVEkBFPDo7jqNS+XSgzj9vd8JhSFRAhWPXAalpe8s9/r8OKamk8rKJ5
         ri7ScUu5gDvpary3I/eKR5IVuATyCa1/MtUSy4hWMoYEy8h80mWU7NrSzG2vTm8swR
         vf1WneUK+jkhqbh9RuNNw0ct1WkH4vsGXmL8d2cE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB4AcTak063763
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Dec 2018 04:38:29 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 4
 Dec 2018 04:38:29 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 4 Dec 2018 04:38:29 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB4AcPPW000306;
        Tue, 4 Dec 2018 04:38:26 -0600
Subject: Re: [PATCH V3 1/3] mmc: sdhci: add support for using external DMA
 devices
To:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
References: <1543908270-13953-1-git-send-email-zhang.chunyan@linaro.org>
 <1543908270-13953-2-git-send-email-zhang.chunyan@linaro.org>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <5167ffb5-77f8-ab66-2eca-602df5f4e3e8@ti.com>
Date:   Tue, 4 Dec 2018 16:11:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543908270-13953-2-git-send-email-zhang.chunyan@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04/12/18 12:54 PM, Chunyan Zhang wrote:
> Some standard SD host controllers can support both external dma
> controllers as well as ADMA/SDMA in which the SD host controller
> acts as DMA master. TI's omap controller is the case as an example.
> 
> Currently the generic SDHCI code supports ADMA/SDMA integrated in
> the host controller but does not have any support for external DMA
> controllers implemented using dmaengine, meaning that custom code is
> needed for any systems that use an external DMA controller with SDHCI.
> 
...

> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index b001cf4..8e50a97 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -475,6 +475,7 @@ struct sdhci_host {
>  
>  	int irq;		/* Device IRQ */
>  	void __iomem *ioaddr;	/* Mapped address */
> +	phys_addr_t mapbase;	/* physical address base */
>  	char *bounce_buffer;	/* For packing SDMA reads/writes */
>  	dma_addr_t bounce_addr;
>  	unsigned int bounce_buffer_size;
> @@ -524,6 +525,7 @@ struct sdhci_host {
>  	bool pending_reset;	/* Cmd/data reset is pending */
>  	bool irq_wake_enabled;	/* IRQ wakeup is enabled */
>  	bool v4_mode;		/* Host Version 4 Enable */
> +	bool use_external_dma;
>  
>  	struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];	/* Requests done */
>  	struct mmc_command *cmd;	/* Current command */
> @@ -552,6 +554,11 @@ struct sdhci_host {
>  	struct timer_list timer;	/* Timer for timeouts */
>  	struct timer_list data_timer;	/* Timer for data timeouts */
>  
> +#if IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)
> +	struct dma_chan	*rx_chan;
> +	struct dma_chan	*tx_chan;
> +#endif
> +
>  	u32 caps;		/* CAPABILITY_0 */
>  	u32 caps1;		/* CAPABILITY_1 */
>  	bool read_caps;		/* Capability flags have been read */
> @@ -785,5 +792,6 @@ void sdhci_start_tuning(struct sdhci_host *host);
>  void sdhci_end_tuning(struct sdhci_host *host);
>  void sdhci_reset_tuning(struct sdhci_host *host);
>  void sdhci_send_tuning(struct sdhci_host *host, u32 opcode);
> +void sdhci_switch_external_dma(struct sdhci_host *host, bool en);
>  

Can you also add a new attribute in sdhci_host->flags for external dma
in this file? The log still shows

[    3.675028] mmc2: SDHCI controller on 4809c000.mmc [4809c000.mmc]
using ADMA

when using external dma.

Thanks,
Faiz
