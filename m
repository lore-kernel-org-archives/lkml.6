Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A751C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB712064A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB712064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbeH2Onk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 10:43:40 -0400
Received: from mga12.intel.com ([192.55.52.136]:22379 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbeH2Onj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 10:43:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 03:47:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,301,1531810800"; 
   d="scan'208";a="66029304"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.98]) ([10.237.72.98])
  by fmsmga007.fm.intel.com with ESMTP; 29 Aug 2018 03:45:54 -0700
Subject: Re: [PATCH V7 2/9] mmc: sdhci: Add sd host v4 mode
To:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@unisoc.com>,
        Jason Wu <jason.wu@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
References: <1535526184-32718-1-git-send-email-zhang.chunyan@linaro.org>
 <1535526184-32718-3-git-send-email-zhang.chunyan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <9e5ea176-1d13-3ac6-ad09-3b748a398f17@intel.com>
Date:   Wed, 29 Aug 2018 13:44:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535526184-32718-3-git-send-email-zhang.chunyan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/18 10:02, Chunyan Zhang wrote:
> For SD host controller version 4.00 or later ones, there're two
> modes of implementation - Version 3.00 compatible mode or
> Version 4 mode.  This patch introduced an interface to enable
> v4 mode.
> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 29 +++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.h |  3 +++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 01bf88c..0c61105 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -123,6 +123,29 @@ EXPORT_SYMBOL_GPL(sdhci_dumpregs);
>   *                                                                           *
>  \*****************************************************************************/
>  
> +static void sdhci_do_enable_v4_mode(struct sdhci_host *host)
> +{
> +	u16 ctrl2;
> +
> +	ctrl2 = sdhci_readb(host, SDHCI_HOST_CONTROL2);
> +	if (ctrl2 & SDHCI_CTRL_V4_MODE)
> +		return;
> +
> +	ctrl2 |= SDHCI_CTRL_V4_MODE;
> +	sdhci_writeb(host, ctrl2, SDHCI_HOST_CONTROL);
> +}
> +
> +/*
> + * This can be called before sdhci_add_host() by Vendor's host controller
> + * driver to enable v4 mode if supported.
> + */
> +void sdhci_enable_v4_mode(struct sdhci_host *host)
> +{
> +	host->v4_mode = true;
> +	sdhci_do_enable_v4_mode(host);
> +}
> +EXPORT_SYMBOL_GPL(sdhci_enable_v4_mode);
> +
>  static inline bool sdhci_data_line_cmd(struct mmc_command *cmd)
>  {
>  	return cmd->data || cmd->flags & MMC_RSP_BUSY;
> @@ -252,6 +275,9 @@ static void sdhci_init(struct sdhci_host *host, int soft)
>  	else
>  		sdhci_do_reset(host, SDHCI_RESET_ALL);
>  
> +	if (host->v4_mode)
> +		sdhci_do_enable_v4_mode(host);
> +
>  	sdhci_set_default_irqs(host);
>  
>  	host->cqe_on = false;
> @@ -3378,6 +3404,9 @@ void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps, u32 *caps1)
>  
>  	sdhci_do_reset(host, SDHCI_RESET_ALL);
>  
> +	if (host->v4_mode)
> +		sdhci_do_enable_v4_mode(host);
> +
>  	of_property_read_u64(mmc_dev(host->mmc)->of_node,
>  			     "sdhci-caps-mask", &dt_caps_mask);
>  	of_property_read_u64(mmc_dev(host->mmc)->of_node,
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index dbd48a8..61611e3 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -184,6 +184,7 @@
>  #define   SDHCI_CTRL_DRV_TYPE_D		0x0030
>  #define  SDHCI_CTRL_EXEC_TUNING		0x0040
>  #define  SDHCI_CTRL_TUNED_CLK		0x0080
> +#define  SDHCI_CTRL_V4_MODE		0x1000
>  #define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
>  
>  #define SDHCI_CAPABILITIES	0x40
> @@ -504,6 +505,7 @@ struct sdhci_host {
>  	bool preset_enabled;	/* Preset is enabled */
>  	bool pending_reset;	/* Cmd/data reset is pending */
>  	bool irq_wake_enabled;	/* IRQ wakeup is enabled */
> +	bool v4_mode;		/* Host Version 4 Enable */
>  
>  	struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];	/* Requests done */
>  	struct mmc_command *cmd;	/* Current command */
> @@ -752,6 +754,7 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
>  		   int *data_error);
>  
>  void sdhci_dumpregs(struct sdhci_host *host);
> +void sdhci_enable_v4_mode(struct sdhci_host *host);
>  
>  void sdhci_start_tuning(struct sdhci_host *host);
>  void sdhci_end_tuning(struct sdhci_host *host);
> 

