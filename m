Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BDEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C913121735
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C913121735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbeH0K4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 06:56:35 -0400
Received: from mga07.intel.com ([134.134.136.100]:47215 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbeH0K4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 06:56:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 00:11:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,294,1531810800"; 
   d="scan'208";a="83661460"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.137]) ([10.237.72.137])
  by fmsmga004.fm.intel.com with ESMTP; 27 Aug 2018 00:09:20 -0700
Subject: Re: [PATCH V6 5/9] mmc: sdhci: Add 32-bit block count support for v4
 mode
To:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@unisoc.com>,
        Jason Wu <jason.wu@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
References: <1535102428-20332-1-git-send-email-zhang.chunyan@linaro.org>
 <1535102428-20332-6-git-send-email-zhang.chunyan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <f209e114-152c-65e0-4c24-53252818ab5d@intel.com>
Date:   Mon, 27 Aug 2018 10:07:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535102428-20332-6-git-send-email-zhang.chunyan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/18 12:20, Chunyan Zhang wrote:
> Host Controller Version 4.10 re-defines SDMA System Address register
> as 32-bit Block Count for v4 mode, and SDMA uses ADMA System
> Address register (05Fh-058h) instead if v4 mode is enabled. Also
> when using 32-bit block count, 16-bit block count register need
> to be set to zero.
> 
> Since using 32-bit Block Count would cause problems for auto-cmd23,
> it can be chosen via host->quirk2.
> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c | 15 ++++++++++++++-
>  drivers/mmc/host/sdhci.h |  3 +++
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 38d083c..05f9fff 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1073,7 +1073,20 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>  	/* Set the DMA boundary value and block size */
>  	sdhci_writew(host, SDHCI_MAKE_BLKSZ(host->sdma_boundary, data->blksz),
>  		     SDHCI_BLOCK_SIZE);
> -	sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
> +
> +	/*
> +	 * For Version 4.10 onwards, if v4 mode is enabled, 16-bit Block Count
> +	 * register need to be set to zero, 32-bit Block Count register would
> +	 * be selected.
> +	 */
> +	if (host->version >= SDHCI_SPEC_410 && host->v4_mode &&
> +	    !(host->quirks2 & SDHCI_QUIRK2_BROKEN_32BIT_BLK_CNT)) {

Because 32-bit block count is problematic but also not essential, I would
prefer to do the quirk the other way around. i.e. SDHCI_QUIRK2_USE_32BIT_BLK_CNT

I would also add a comment to the definition of
SDHCI_QUIRK2_USE_32BIT_BLK_CNT, like:

32-bit block count may not support eMMC where upper bits of CMD23 are used
for other purposes.  Consequently we support 16-bit block count by default.
Otherwise, SDHCI_QUIRK2_USE_32BIT_BLK_CNT can be selected to use 32-bit
block count.

> +		if (sdhci_readw(host, SDHCI_BLOCK_COUNT))
> +			sdhci_writew(host, 0, SDHCI_BLOCK_COUNT);
> +		sdhci_writew(host, data->blocks, SDHCI_32BIT_BLK_CNT);
> +	} else {
> +		sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
> +	}
>  }
>  
>  static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index f3b9ebc..0a1e25f 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -28,6 +28,7 @@
>  
>  #define SDHCI_DMA_ADDRESS	0x00
>  #define SDHCI_ARGUMENT2		SDHCI_DMA_ADDRESS
> +#define SDHCI_32BIT_BLK_CNT	SDHCI_DMA_ADDRESS
>  
>  #define SDHCI_BLOCK_SIZE	0x04
>  #define  SDHCI_MAKE_BLKSZ(dma, blksz) (((dma & 0x7) << 12) | (blksz & 0xFFF))
> @@ -462,6 +463,8 @@ struct sdhci_host {
>   * obtainable timeout.
>   */
>  #define SDHCI_QUIRK2_DISABLE_HW_TIMEOUT			(1<<17)
> +/* Controller broken with using 32-bit block count in v4_mode */
> +#define SDHCI_QUIRK2_BROKEN_32BIT_BLK_CNT		(1<<18)
>  
>  	int irq;		/* Device IRQ */
>  	void __iomem *ioaddr;	/* Mapped address */
> 

