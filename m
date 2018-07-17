Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2EBECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A393208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A393208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbeGQLue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:50:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:40700 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730169AbeGQLud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:50:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 04:18:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,365,1526367600"; 
   d="scan'208";a="73026217"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.168]) ([10.237.72.168])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jul 2018 04:17:50 -0700
Subject: Re: [PATCH V3 5/7] mmc: sdhci: add Auto CMD Auto Select support
To:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>, zhang.lyra@gmail.com
References: <1531106398-14062-1-git-send-email-zhang.chunyan@linaro.org>
 <1531106398-14062-6-git-send-email-zhang.chunyan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <3cc11907-5248-ea5a-5e2a-f93e12ef4e68@intel.com>
Date:   Tue, 17 Jul 2018 14:16:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <1531106398-14062-6-git-send-email-zhang.chunyan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/18 06:19, Chunyan Zhang wrote:
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
>  drivers/mmc/host/sdhci.c | 39 ++++++++++++++++++++++++++++-----------
>  drivers/mmc/host/sdhci.h |  2 ++
>  2 files changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index f64e766..1ca3871 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1033,6 +1033,33 @@ static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
>  	       !mrq->cap_cmd_during_tfr;
>  }
>  
> +static inline void sdhci_auto_cmd_enable(struct sdhci_host *host,
> +					 struct mmc_command *cmd,
> +					 u16 *mode)
> +{
> +	/*
> +	 * In case of Version 4.10 or later, use of 'Auto CMD Auto
> +	 * Select' is recommended rather than use of 'Auto CMD12
> +	 * Enable' or 'Auto CMD23 Enable'.
> +	 */
> +	if (host->version >= SDHCI_SPEC_410) {
> +		*mode |= SDHCI_TRNS_AUTO_SEL;

The rules for selecting auto commands still need to be applied.  In effect:

	if (sdhci_auto_cmd12(host, cmd->mrq) &&
	    (cmd->opcode != SD_IO_RW_EXTENDED)) {
		*mode |= SDHCI_TRNS_AUTO_SEL;
	} else if (cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
		*mode |= SDHCI_TRNS_AUTO_SEL;
		sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
	}

Also the selection of Host Control 2 register CMD23 Enable should be done by
SDHCI (if supported by the card) not the Spreadtrum driver.

> +		return;
> +	}
> +
> +	/*
> +	 * If we are sending CMD23, CMD12 never gets sent
> +	 * on successful completion (so no Auto-CMD12).
> +	 */
> +	if (sdhci_auto_cmd12(host, cmd->mrq) &&
> +	    (cmd->opcode != SD_IO_RW_EXTENDED)) {
> +		*mode |= SDHCI_TRNS_AUTO_CMD12;
> +	} else if (cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
> +		*mode |= SDHCI_TRNS_AUTO_CMD23;
> +		sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
> +	}
> +}
> +
>  static void sdhci_set_transfer_mode(struct sdhci_host *host,
>  	struct mmc_command *cmd)
>  {
> @@ -1059,17 +1086,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
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
> +		sdhci_auto_cmd_enable(host, cmd, &mode);
>  	}
>  
>  	if (data->flags & MMC_DATA_READ)
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 889e48b..8263ac6 100644
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

