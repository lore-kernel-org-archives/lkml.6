Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F9CC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2FFB2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NDkI3jOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2FFB2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbeLMME6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:04:58 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42568 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbeLMME6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:04:58 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBDC4oYq130209;
        Thu, 13 Dec 2018 06:04:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544702690;
        bh=0qbt6u6jb8xj2kK79MGantiboGVhU80CuG7DrVqqars=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NDkI3jOKxD3XbRZxEXyS6pSpy5qNkFCbwSrgYknsEyoOcZ2LMu/lF3fZXamtwsppD
         JpQb/UBmip3/JorxMzDy2Aicfz+mrs2ADe1gbKayzTeVfRIhPJoyg0dHqWpI0yThSf
         47JhOtejC4k2xAX2IzJJx8xCO+HO8dU19d11i5JU=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBDC4owZ126535
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Dec 2018 06:04:50 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 13
 Dec 2018 06:04:49 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 13 Dec 2018 06:04:49 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBDC4kEU012704;
        Thu, 13 Dec 2018 06:04:47 -0600
Subject: Re: [PATCH V4 1/3] mmc: sdhci: add support for using external DMA
 devices
To:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
References: <1544519572-21921-1-git-send-email-zhang.chunyan@linaro.org>
 <1544519572-21921-2-git-send-email-zhang.chunyan@linaro.org>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <20f63513-1e45-2952-3969-9ed9ced8ec39@ti.com>
Date:   Thu, 13 Dec 2018 17:37:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544519572-21921-2-git-send-email-zhang.chunyan@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chunyan,

On 11/12/18 2:42 PM, Chunyan Zhang wrote:
> Some standard SD host controllers can support both external dma
> controllers as well as ADMA/SDMA in which the SD host controller
> acts as DMA master. TI's omap controller is the case as an example.
> 
> Currently the generic SDHCI code supports ADMA/SDMA integrated in
> the host controller but does not have any support for external DMA
> controllers implemented using dmaengine, meaning that custom code is
> needed for any systems that use an external DMA controller with SDHCI.
> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> ---
>  drivers/mmc/host/Kconfig |   3 +
>  drivers/mmc/host/sdhci.c | 250 ++++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/mmc/host/sdhci.h |   8 ++
>  3 files changed, 260 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 1b58739..3101da6 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -977,3 +977,6 @@ config MMC_SDHCI_OMAP
>  	  If you have a controller with this interface, say Y or M here.
>  
>  	  If unsure, say N.
> +
> +config MMC_SDHCI_EXTERNAL_DMA
> +        bool
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 99bdae5..3162e60 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -14,6 +14,7 @@
>   */
>  
>  #include <linux/delay.h>
> +#include <linux/dmaengine.h>
>  #include <linux/ktime.h>
>  #include <linux/highmem.h>
>  #include <linux/io.h>
> @@ -1097,6 +1098,221 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>  	}
>  }
>  
> +#if IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)
> +static int sdhci_external_dma_init(struct sdhci_host *host)
> +{
> +	int ret = 0;
> +	struct mmc_host *mmc = host->mmc;
> +
> +	host->tx_chan = dma_request_chan(mmc->parent, "tx");
> +	if (IS_ERR(host->tx_chan)) {
> +		ret = PTR_ERR(host->tx_chan);
> +		if (ret != -EPROBE_DEFER)
> +			pr_warn("Failed to request TX DMA channel.\n");
> +		host->tx_chan = NULL;
> +		return ret;
> +	}
> +
> +	host->rx_chan = dma_request_chan(mmc->parent, "rx");
> +	if (IS_ERR(host->rx_chan)) {
> +		if (host->tx_chan) {
> +			dma_release_channel(host->tx_chan);
> +			host->tx_chan = NULL;
> +		}
> +
> +		ret = PTR_ERR(host->rx_chan);
> +		if (ret != -EPROBE_DEFER)
> +			pr_warn("Failed to request RX DMA channel.\n");
> +		host->rx_chan = NULL;
> +	}
> +
> +	return ret;
> +}
> +
> +static inline struct dma_chan *
> +sdhci_external_dma_channel(struct sdhci_host *host, struct mmc_data *data)
> +{
> +	return data->flags & MMC_DATA_WRITE ? host->tx_chan : host->rx_chan;
> +}
> +
> +static int sdhci_external_dma_setup(struct sdhci_host *host,
> +				    struct mmc_command *cmd)
> +{
> +	int ret, i;
> +	struct dma_async_tx_descriptor *desc;
> +	struct mmc_data *data = cmd->data;
> +	struct dma_chan *chan;
> +	struct dma_slave_config cfg;
> +	dma_cookie_t cookie;
> +
> +	if (!host->mapbase)
> +		return -EINVAL;
> +
> +	cfg.src_addr = host->mapbase + SDHCI_BUFFER;
> +	cfg.dst_addr = host->mapbase + SDHCI_BUFFER;
> +	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	cfg.src_maxburst = data->blksz / 4;
> +	cfg.dst_maxburst = data->blksz / 4;
> +
> +	/* Sanity check: all the SG entries must be aligned by block size. */
> +	for (i = 0; i < data->sg_len; i++) {
> +		if ((data->sg + i)->length % data->blksz)
> +			return -EINVAL;
> +	}
> +
> +	chan = sdhci_external_dma_channel(host, data);
> +
> +	ret = dmaengine_slave_config(chan, &cfg);
> +	if (ret)
> +		return ret;
> +
> +	desc = dmaengine_prep_slave_sg(chan, data->sg, data->sg_len,
> +				       mmc_get_dma_dir(data),
> +				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +	if (!desc)
> +		return -EINVAL;
> +
> +	desc->callback = NULL;
> +	desc->callback_param = NULL;
> +
> +	cookie = dmaengine_submit(desc);
> +	if (cookie < 0)
> +		ret = cookie;
> +
> +	return ret;
> +}
> +
> +static void sdhci_external_dma_release(struct sdhci_host *host)
> +{
> +	if (host->tx_chan) {
> +		dma_release_channel(host->tx_chan);
> +		host->tx_chan = NULL;
> +	}
> +
> +	if (host->rx_chan) {
> +		dma_release_channel(host->rx_chan);
> +		host->rx_chan = NULL;
> +	}
> +
> +	sdhci_switch_external_dma(host, false);
> +}
> +
> +static int __sdhci_external_dma_prepare_data(struct sdhci_host *host,
> +					     struct mmc_command *cmd)
> +{
> +	struct mmc_data *data = cmd->data;
> +	int sg_cnt;
> +
> +	host->data_timeout = 0;
> +
> +	if (sdhci_data_line_cmd(cmd))
> +		sdhci_set_timeout(host, cmd);
> +
> +	WARN_ON(host->data);
> +
> +	/* Sanity checks */
> +	WARN_ON(data->blksz * data->blocks > 524288);
> +	WARN_ON(data->blksz > host->mmc->max_blk_size);
> +	WARN_ON(data->blocks > 65535);
> +
> +	host->flags |= SDHCI_REQ_USE_DMA;
> +	host->data = data;
> +	host->data_early = 0;
> +	host->data->bytes_xfered = 0;
> +
> +	sg_cnt = sdhci_pre_dma_transfer(host, data, COOKIE_MAPPED);
> +	if (sg_cnt <= 0)
> +		return -EINVAL;
> +
> +	sdhci_set_transfer_irqs(host);
> +
> +	/*
> +	 * For Version 4.10 onwards, if v4 mode is enabled, 32-bit Block Count
> +	 * can be supported, in that case 16-bit block count register must be 0.
> +	 */
> +	if (host->version >= SDHCI_SPEC_410 && host->v4_mode &&
> +	    (host->quirks2 & SDHCI_QUIRK2_USE_32BIT_BLK_CNT)) {
> +		if (sdhci_readw(host, SDHCI_BLOCK_COUNT))
> +			sdhci_writew(host, 0, SDHCI_BLOCK_COUNT);
> +		sdhci_writew(host, data->blocks, SDHCI_32BIT_BLK_CNT);
> +	} else {
> +		sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
> +	}
> +
> +	return 0;
> +}
> +
> +static void sdhci_external_dma_prepare_data(struct sdhci_host *host,
> +					    struct mmc_command *cmd)
> +{
> +	struct mmc_data *data = cmd->data;
> +
> +	if (!data)
> +		return;
> +
> +	if (sdhci_external_dma_setup(host, cmd) ||
> +	    __sdhci_external_dma_prepare_data(host, cmd)) {
> +		sdhci_external_dma_release(host);
> +		pr_err("%s: Cannot use external DMA, switch to the DMA/PIO which standard SDHCI provides.\n",
> +		       mmc_hostname(host->mmc));
> +		sdhci_prepare_data(host, cmd);
> +	}
> +}
> +
> +static void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
> +					    struct mmc_command *cmd)
> +{
> +	struct dma_chan *chan = sdhci_external_dma_channel(host, cmd->data);

Again, cmd->data can be NULL.

Even after fixing above, I get some l3_noc issues.

[    3.589896] omap_l3_noc 44000000.ocp: L3 application error: target 5
mod:1 (unclearable)
[    3.598157] omap_l3_noc 44000000.ocp: L3 debug error: target 5 mod:1
(unclearable)
[    3.630934] softirq: Attempt to kill tasklet from interrupt
[    3.636790] mmc0: error -84 whilst initialising SD card

Full log: https://pastebin.ubuntu.com/p/wdG88hX5By/

I am in the process of debugging this. Please ping if you need any
further logs.

Thanks,
Faiz


