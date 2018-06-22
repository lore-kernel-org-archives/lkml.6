Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AA0C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0465247F8
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0465247F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934371AbeFVTl5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 15:41:57 -0400
Received: from mga14.intel.com ([192.55.52.115]:60673 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934096AbeFVTl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 15:41:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 12:41:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,258,1526367600"; 
   d="scan'208";a="49173058"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.168]) ([10.237.72.168])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jun 2018 12:41:39 -0700
Subject: Re: [PATCH V2 5/7] mmc: sdhci: add CMD23 support for v4 mode
To:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>, zhang.lyra@gmail.com
References: <1529028255-6022-1-git-send-email-zhang.chunyan@linaro.org>
 <1529028255-6022-6-git-send-email-zhang.chunyan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2c91af23-da14-ed70-91b3-d7bfb06f3141@intel.com>
Date:   Fri, 22 Jun 2018 22:40:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529028255-6022-6-git-send-email-zhang.chunyan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/15/2018 05:04 AM, Chunyan Zhang wrote:
> Host Driver Version 4.10 adds a new bit in Host Control 2 Register
> for selecting Auto CMD23 or Auto CMD12 for ADMA3 data transfer.

We don't support ADMA3.  It would require changes to the block driver.
So is this change needed?

> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c | 16 +++++++++++++++-
>  drivers/mmc/host/sdhci.h |  1 +
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index b8ee124..3b2af7e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -954,6 +954,20 @@ static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
>  	       !mrq->cap_cmd_during_tfr;
>  }
>  
> +static inline void sdhci_set_auto_cmd23(struct sdhci_host *host,
> +					struct mmc_command *cmd)
> +{
> +	u16 ctrl2;
> +
> +	if (host->v4_mode) {

Isn't this only for a V4.1 controller, and doesn't the mode have to be "Auto
Cmd Auto Select"?


> +		ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +		ctrl2 |= SDHCI_CMD23_ENABLE;
> +		sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
> +	} else {
> +		sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
> +	}
> +}
> +
>  static void sdhci_set_transfer_mode(struct sdhci_host *host,
>  	struct mmc_command *cmd)
>  {
> @@ -989,7 +1003,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
>  			mode |= SDHCI_TRNS_AUTO_CMD12;
>  		else if (cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
>  			mode |= SDHCI_TRNS_AUTO_CMD23;
> -			sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
> +			sdhci_set_auto_cmd23(host, cmd);
>  		}
>  	}
>  
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 1e84539..d5e1c10 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -185,6 +185,7 @@
>  #define   SDHCI_CTRL_DRV_TYPE_D		0x0030
>  #define  SDHCI_CTRL_EXEC_TUNING		0x0040
>  #define  SDHCI_CTRL_TUNED_CLK		0x0080
> +#define  SDHCI_CMD23_ENABLE		0x0800
>  #define  SDHCI_CTRL_V4_MODE		0x1000
>  #define  SDHCI_CTRL_64BIT_ADDR		0x2000
>  #define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
> 

