Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32656C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2B82064A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2B82064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbeH2Oq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 10:46:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:15406 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbeH2Oq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 10:46:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 03:50:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,301,1531810800"; 
   d="scan'208";a="66029671"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.98]) ([10.237.72.98])
  by fmsmga007.fm.intel.com with ESMTP; 29 Aug 2018 03:49:53 -0700
Subject: Re: [PATCH V7 6/9] mmc: sdhci: Add Auto CMD Auto Select support
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
 <1535526184-32718-7-git-send-email-zhang.chunyan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <6a704ff7-82aa-bc69-e7e3-a941a40ac524@intel.com>
Date:   Wed, 29 Aug 2018 13:48:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535526184-32718-7-git-send-email-zhang.chunyan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/18 10:03, Chunyan Zhang wrote:
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

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 49 ++++++++++++++++++++++++++++++++++++++----------
>  drivers/mmc/host/sdhci.h |  2 ++
>  2 files changed, 41 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 604bf4c..62d843ac90 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1095,6 +1095,43 @@ static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
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
> +	u16 ctrl2;
> +
> +	/*
> +	 * In case of Version 4.10 or later, use of 'Auto CMD Auto
> +	 * Select' is recommended rather than use of 'Auto CMD12
> +	 * Enable' or 'Auto CMD23 Enable'.
> +	 */
> +	if (host->version >= SDHCI_SPEC_410 && (use_cmd12 || use_cmd23)) {
> +		*mode |= SDHCI_TRNS_AUTO_SEL;
> +
> +		ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +		if (use_cmd23)
> +			ctrl2 |= SDHCI_CMD23_ENABLE;
> +		else
> +			ctrl2 &= ~SDHCI_CMD23_ENABLE;
> +		sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
> +
> +		return;
> +	}
> +
> +	/*
> +	 * If we are sending CMD23, CMD12 never gets sent
> +	 * on successful completion (so no Auto-CMD12).
> +	 */
> +	if (use_cmd12)
> +		*mode |= SDHCI_TRNS_AUTO_CMD12;
> +	else if (use_cmd23)
> +		*mode |= SDHCI_TRNS_AUTO_CMD23;
> +}
> +
>  static void sdhci_set_transfer_mode(struct sdhci_host *host,
>  	struct mmc_command *cmd)
>  {
> @@ -1123,17 +1160,9 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
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
> +		sdhci_auto_cmd_select(host, cmd, &mode);
> +		if (cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23))
>  			sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
> -		}
>  	}
>  
>  	if (data->flags & MMC_DATA_READ)
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index f7a1079..4a19ff8 100644
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

