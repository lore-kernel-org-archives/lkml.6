Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CD6C04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066C72087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 066C72087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbeKUAK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:10:29 -0500
Received: from mga01.intel.com ([192.55.52.88]:35291 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbeKUAK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:10:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 05:41:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,257,1539673200"; 
   d="scan'208";a="107820276"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.130]) ([10.237.72.130])
  by fmsmga004.fm.intel.com with ESMTP; 20 Nov 2018 05:41:14 -0800
Subject: Re: [PATCH v2 1/3] mmc: sdhci: add support for using external DMA
 devices
To:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
References: <1542007566-9449-1-git-send-email-zhang.chunyan@linaro.org>
 <1542007566-9449-2-git-send-email-zhang.chunyan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <84836600-c705-9ac3-297e-bb67a611daca@intel.com>
Date:   Tue, 20 Nov 2018 15:39:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542007566-9449-2-git-send-email-zhang.chunyan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/18 9:26 AM, Chunyan Zhang wrote:
> Some standard SD host controllers can support both external dma
> controllers as well as ADMA/SDMA in which the SD host controller
> acts as DMA master. TI's omap controller is the case as an example.
> 
> Currently the generic SDHCI code supports ADMA/SDMA integrated in
> the host controller but does not have any support for external DMA
> controllers implemented using dmaengine, meaning that custom code is
> needed for any systems that use an external DMA controller with SDHCI.

I still think you probably need to reset the DMA if there are transfer
errors - perhaps you could comment on that.  Also there are some comments below.

> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> ---
>  drivers/mmc/host/Kconfig |  13 ++++
>  drivers/mmc/host/sdhci.c | 181 ++++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/mmc/host/sdhci.h |   8 +++
>  3 files changed, 201 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 1b58739..7bf3eff 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -977,3 +977,16 @@ config MMC_SDHCI_OMAP
>  	  If you have a controller with this interface, say Y or M here.
>  
>  	  If unsure, say N.
> +
> +config MMC_SDHCI_EXTERNAL_DMA
> +        bool "Support external DMA in standard SD host controller"

It would be simpler if the drivers that needed it just selected it e.g.

config MMC_SDHCI_OMAP
	tristate "TI SDHCI Controller Support"
	depends on MMC_SDHCI_PLTFM && OF
	select MMC_SDHCI_EXTERNAL_DMA if DMA_ENGINE

> +	depends on MMC_SDHCI
> +	depends on DMA_ENGINE
> +	help
> +	  This is an option for using external DMA device via dmaengine
> +	  framework.
> +
> +	  If you have a controller which support using external DMA device
> +	  for data transfer, can say Y.
> +
> +	  If unsure, say N.
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 99bdae5..853cc98 100644
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
> @@ -1309,6 +1310,158 @@ static void sdhci_del_timer(struct sdhci_host *host, struct mmc_request *mrq)
>  		del_timer(&host->timer);
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
> +	int ret = 0, i;
> +	struct dma_async_tx_descriptor *desc;
> +	struct mmc_data *data = cmd->data;

cmd->data might be NULL?  Have you tested this?

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
> +static void sdhci_external_dma_prepare_data(struct sdhci_host *host,
> +					    struct mmc_command *cmd)
> +{
> +	if (sdhci_external_dma_setup(host, cmd)) {
> +		sdhci_external_dma_release(host);
> +		pr_err("%s: Failed to setup external DMA, switch to the DMA/PIO which standard SDHCI provides.\n",
> +		       mmc_hostname(host->mmc));
> +	} else {
> +		/* Prepare for using external dma */
> +		host->flags |= SDHCI_REQ_USE_DMA;
> +	}
> +
> +	sdhci_prepare_data(host, cmd);
> +}
> +
> +static void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
> +					    struct mmc_command *cmd)
> +{
> +	struct dma_chan *chan = sdhci_external_dma_channel(host, cmd->data);

cmd->data might be NULL?  Have you tested this?

> +
> +	if (cmd->opcode != MMC_SET_BLOCK_COUNT) {

I would have thought:

	if (cmd->data)

> +		sdhci_set_timeout(host, cmd);
> +		dma_async_issue_pending(chan);
> +	}
> +}
> +#else
> +static int sdhci_external_dma_init(struct sdhci_host *host)
> +{
> +	return 0;

That should return an error, perhaps -EOPNOTSUPP.

> +}
> +
> +static void sdhci_external_dma_release(struct sdhci_host *host)
> +{}
> +
> +static void sdhci_external_dma_prepare_data(struct sdhci_host *host,
> +					    struct mmc_command *cmd)
> +{
> +	/* If SDHCI_EXTDMA not supported, PIO will be used */

SDHCI_EXTDMA is now MMC_SDHCI_EXTERNAL_DMA

> +	sdhci_prepare_data(host, cmd);
> +}
> +
> +static void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
> +					    struct mmc_command *cmd)
> +{}
> +#endif
> +
> +void sdhci_switch_external_dma(struct sdhci_host *host, bool en)
> +{
> +	host->use_external_dma = en;
> +}
> +EXPORT_SYMBOL_GPL(sdhci_switch_external_dma);
> +
>  void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  {
>  	int flags;
> @@ -1355,7 +1508,10 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  		host->data_cmd = cmd;
>  	}
>  
> -	sdhci_prepare_data(host, cmd);
> +	if (host->use_external_dma)
> +		sdhci_external_dma_prepare_data(host, cmd);
> +	else
> +		sdhci_prepare_data(host, cmd);
>  
>  	sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);
>  
> @@ -1397,6 +1553,9 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  		timeout += 10 * HZ;
>  	sdhci_mod_timer(host, cmd->mrq, timeout);
>  
> +	if (host->use_external_dma)
> +		sdhci_external_dma_pre_transfer(host, cmd);
> +
>  	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
>  }
>  EXPORT_SYMBOL_GPL(sdhci_send_command);
> @@ -4133,6 +4292,19 @@ int sdhci_setup_host(struct sdhci_host *host)
>  			return ret;
>  	}
>  
> +	if (host->use_external_dma) {
> +		ret = sdhci_external_dma_init(host);
> +		if (ret == -EPROBE_DEFER)
> +			goto unreg;
> +
> +		/*
> +		 * Fall back to use the DMA/PIO integrated in standard SDHCI
> +		 * instead of external DMA devices.
> +		 */
> +		if (ret)
> +			sdhci_switch_external_dma(host, false);
> +	}
> +
>  	return 0;
>  
>  unreg:
> @@ -4161,6 +4333,10 @@ void sdhci_cleanup_host(struct sdhci_host *host)
>  		dma_free_coherent(mmc_dev(mmc), host->align_buffer_sz +
>  				  host->adma_table_sz, host->align_buffer,
>  				  host->align_addr);
> +
> +	if (host->use_external_dma)
> +		sdhci_external_dma_release(host);
> +
>  	host->adma_table = NULL;
>  	host->align_buffer = NULL;
>  }
> @@ -4295,6 +4471,9 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
>  				  host->adma_table_sz, host->align_buffer,
>  				  host->align_addr);
>  
> +	if (host->use_external_dma)
> +		sdhci_external_dma_release(host);
> +
>  	host->adma_table = NULL;
>  	host->align_buffer = NULL;
>  }
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
>  #endif /* __SDHCI_HW_H */
> 

