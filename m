Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108CBC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8721208B3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8721208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933115AbeFULYV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 07:24:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:21143 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932998AbeFULYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 07:24:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 04:24:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,251,1526367600"; 
   d="scan'208";a="48788701"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.168]) ([10.237.72.168])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jun 2018 04:24:15 -0700
Subject: Re: [PATCH V2 2/7] mmc: sdhci: made changes for System Address
 register of SDMA
To:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>, zhang.lyra@gmail.com
References: <1529028255-6022-1-git-send-email-zhang.chunyan@linaro.org>
 <1529028255-6022-3-git-send-email-zhang.chunyan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2eb994d3-7f23-6ff8-4740-7a444a581e9d@intel.com>
Date:   Thu, 21 Jun 2018 14:22:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1529028255-6022-3-git-send-email-zhang.chunyan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/18 05:04, Chunyan Zhang wrote:
> According to the SD host controller specification version 4.10, when
> Host Version 4 is enabled, SDMA uses ADMA System Address register
> (05Fh-058h) instead of using SDMA System Address register to
> support both 32-bit and 64-bit addressing.
> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index cf5695f..f57201f 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -805,6 +805,7 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>  static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>  {
>  	u8 ctrl;
> +	u32 reg;

reg could just be an int.

>  	struct mmc_data *data = cmd->data;
>  
>  	if (sdhci_data_line_cmd(cmd))
> @@ -894,8 +895,10 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>  					     SDHCI_ADMA_ADDRESS_HI);
>  		} else {
>  			WARN_ON(sg_cnt != 1);
> +			reg = host->v4_mode ? SDHCI_ADMA_ADDRESS :
> +				SDHCI_DMA_ADDRESS;
>  			sdhci_writel(host, sdhci_sdma_address(host),
> -				     SDHCI_DMA_ADDRESS);
> +				     reg);

Shouldn't we support 64-bit SDMA in version 4 mode?


>  		}
>  	}
>  
> @@ -2721,6 +2724,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>  		 */
>  		if (intmask & SDHCI_INT_DMA_END) {
>  			u32 dmastart, dmanow;
> +			u32 reg;
>  
>  			dmastart = sdhci_sdma_address(host);
>  			dmanow = dmastart + host->data->bytes_xfered;
> @@ -2733,7 +2737,9 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>  			host->data->bytes_xfered = dmanow - dmastart;
>  			DBG("DMA base 0x%08x, transferred 0x%06x bytes, next 0x%08x\n",
>  			    dmastart, host->data->bytes_xfered, dmanow);
> -			sdhci_writel(host, dmanow, SDHCI_DMA_ADDRESS);
> +			reg = host->v4_mode ? SDHCI_ADMA_ADDRESS :
> +				SDHCI_DMA_ADDRESS;
> +			sdhci_writel(host, dmanow, reg);

Shouldn't we support 64-bit SDMA in version 4 mode?

>  		}
>  
>  		if (intmask & SDHCI_INT_DATA_END) {
> 

