Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F95E13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B8F20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B8F20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbeG3Omo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:42:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:64363 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbeG3Omo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:42:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 06:07:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,422,1526367600"; 
   d="scan'208";a="71684708"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.168]) ([10.237.72.168])
  by fmsmga002.fm.intel.com with ESMTP; 30 Jul 2018 06:07:46 -0700
Subject: Re: [PATCH V4 5/7] mmc: sdhci: add Auto CMD Auto Select support
To:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>,
        Jason Wu <jason.wu@unisoc.com>, zhang.lyra@gmail.com
References: <1532340508-8749-1-git-send-email-zhang.chunyan@linaro.org>
 <1532340508-8749-6-git-send-email-zhang.chunyan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <33ceb61c-3e09-c336-e9b9-87c01336f56c@intel.com>
Date:   Mon, 30 Jul 2018 16:06:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <1532340508-8749-6-git-send-email-zhang.chunyan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/18 13:08, Chunyan Zhang wrote:
> As SD Host Controller Specification v4.10 documents:
> Host Controller Version 4.10 defines this "Auto CMD Auto Select" mode.
> Selection of Auto CMD depends on setting of CMD23 Enable in the Host
> Control 2 register which indicates whether card supports CMD23. If CMD23
> Enable =1, Auto CMD23 is used and if CMD23 Enable =0, Auto CMD12 is
> used. In case of Version 4.10 or later, use of Auto CMD Auto Select is
> recommended rather than use of Auto CMD12 Enable or Auto CMD23
> Enable.
> 
> This patch add this new mode support.
> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c | 61 +++++++++++++++++++++++++++++++++++++++---------
>  drivers/mmc/host/sdhci.h |  2 ++
>  2 files changed, 52 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 5acea3d..5c60590 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -311,6 +311,23 @@ static void sdhci_config_dma(struct sdhci_host *host)
>  	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>  }
>  
> +static void sdhci_enable_cmd23(struct sdhci_host *host)
> +{
> +	u16 ctrl2;
> +
> +	/*
> +	 * This is used along with "Auto CMD Auto Select" feature,
> +	 * which is introduced from v4.10, if card supports CMD23,
> +	 * Auto CMD23 should be used instead of Auto CMD12.
> +	 */
> +	if (host->version >= SDHCI_SPEC_410 &&
> +	    (host->mmc->caps & MMC_CAP_CMD23)) {

That is the host capability.  It needs to be the card capability.

> +		ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +		ctrl2 |= SDHCI_CMD23_ENABLE;
> +		sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
> +	}
> +}
> +
>  static void sdhci_init(struct sdhci_host *host, int soft)
>  {
>  	struct mmc_host *mmc = host->mmc;
> @@ -329,6 +346,8 @@ static void sdhci_init(struct sdhci_host *host, int soft)
>  		host->clock = 0;
>  		mmc->ops->set_ios(mmc, &mmc->ios);
>  	}
> +
> +	sdhci_enable_cmd23(host);
>  }
>  
>  static void sdhci_reinit(struct sdhci_host *host)
> @@ -1093,6 +1112,36 @@ static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
>  	       !mrq->cap_cmd_during_tfr;
>  }
>  
> +static inline void sdhci_auto_cmd_select(struct sdhci_host *host,
> +					 struct mmc_command *cmd,
> +					 u16 *mode)
> +{
> +	bool use_cmd12 = sdhci_auto_cmd12(host, cmd->mrq) &&
> +			 (cmd->opcode != SD_IO_RW_EXTENDED);
> +	bool use_cmd23 = cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23);
> +
> +	/*
> +	 * In case of Version 4.10 or later, use of 'Auto CMD Auto
> +	 * Select' is recommended rather than use of 'Auto CMD12
> +	 * Enable' or 'Auto CMD23 Enable'.
> +	 */
> +	if (host->version >= SDHCI_SPEC_410 && (use_cmd12 || use_cmd23)) {
> +		*mode |= SDHCI_TRNS_AUTO_SEL;

As noted in patch 4, the CMD23 argument is not just the block count for eMMC.

> +		return;
> +	}
> +
> +	/*
> +	 * If we are sending CMD23, CMD12 never gets sent
> +	 * on successful completion (so no Auto-CMD12).
> +	 */
> +	if (use_cmd12) {
> +		*mode |= SDHCI_TRNS_AUTO_CMD12;
> +	} else if (use_cmd23) {
> +		*mode |= SDHCI_TRNS_AUTO_CMD23;
> +		sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
> +	}
> +}
> +
>  static void sdhci_set_transfer_mode(struct sdhci_host *host,
>  	struct mmc_command *cmd)
>  {
> @@ -1119,17 +1168,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
>  
>  	if (mmc_op_multi(cmd->opcode) || data->blocks > 1) {
>  		mode = SDHCI_TRNS_BLK_CNT_EN | SDHCI_TRNS_MULTI;
> -		/*
> -		 * If we are sending CMD23, CMD12 never gets sent
> -		 * on successful completion (so no Auto-CMD12).
> -		 */
> -		if (sdhci_auto_cmd12(host, cmd->mrq) &&
> -		    (cmd->opcode != SD_IO_RW_EXTENDED))
> -			mode |= SDHCI_TRNS_AUTO_CMD12;
> -		else if (cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
> -			mode |= SDHCI_TRNS_AUTO_CMD23;
> -			sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
> -		}
> +		sdhci_auto_cmd_select(host, cmd, &mode);
>  	}
>  
>  	if (data->flags & MMC_DATA_READ)
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 81aae07..a8f4ec2 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -42,6 +42,7 @@
>  #define  SDHCI_TRNS_BLK_CNT_EN	0x02
>  #define  SDHCI_TRNS_AUTO_CMD12	0x04
>  #define  SDHCI_TRNS_AUTO_CMD23	0x08
> +#define  SDHCI_TRNS_AUTO_SEL	0x0C
>  #define  SDHCI_TRNS_READ	0x10
>  #define  SDHCI_TRNS_MULTI	0x20
>  
> @@ -185,6 +186,7 @@
>  #define   SDHCI_CTRL_DRV_TYPE_D		0x0030
>  #define  SDHCI_CTRL_EXEC_TUNING		0x0040
>  #define  SDHCI_CTRL_TUNED_CLK		0x0080
> +#define  SDHCI_CMD23_ENABLE		0x0800
>  #define  SDHCI_CTRL_V4_MODE		0x1000
>  #define  SDHCI_CTRL_64BIT_ADDR		0x2000
>  #define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
> 

