Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF9AFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B9020881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B9020881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbeG3Omn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:42:43 -0400
Received: from mga14.intel.com ([192.55.52.115]:64363 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbeG3Omn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:42:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 06:07:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,422,1526367600"; 
   d="scan'208";a="71684642"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.168]) ([10.237.72.168])
  by fmsmga002.fm.intel.com with ESMTP; 30 Jul 2018 06:07:28 -0700
Subject: Re: [PATCH V4 4/7] mmc: sdhci: add 32-bit block count support for v4
 mode
To:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>,
        Jason Wu <jason.wu@unisoc.com>, zhang.lyra@gmail.com
References: <1532340508-8749-5-git-send-email-zhang.chunyan@linaro.org>
 <1532400671-23429-1-git-send-email-zhang.chunyan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <3e586922-c5e8-fb3c-233e-06836f4dad48@intel.com>
Date:   Mon, 30 Jul 2018 16:05:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <1532400671-23429-1-git-send-email-zhang.chunyan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/18 05:51, Chunyan Zhang wrote:
> Host Controller Version 4.10 re-defines SDMA System Address register
> as 32-bit Block Count for v4 mode, and SDMA uses ADMA System
> Address register (05Fh-058h) instead if v4 mode is enabled. Also
> when using 32-bit block count, 16-bit block count register need
> to be set to zero.
> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c | 14 +++++++++++++-
>  drivers/mmc/host/sdhci.h |  1 +
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 920d8ec..c272a2b 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1070,7 +1070,19 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
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
> +	if (host->version >= SDHCI_SPEC_410 && host->v4_mode) {
> +		if (sdhci_readw(host, SDHCI_BLOCK_COUNT))
> +			sdhci_writew(host, 0, SDHCI_BLOCK_COUNT);
> +		sdhci_writew(host, data->blocks, SDHCI_32BIT_BLK_CNT);

So this is also SDHCI_ARGUMENT2 which is why there is a conflict with
auto-CMD23.  We need to write SDHCI_32BIT_BLK_CNT only once, but also cater
for eMMC which uses the CMD23 argument for more than just block count.

> +	} else {
> +		sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
> +	}
>  }
>  
>  static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 23318ff..81aae07 100644
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
> 

