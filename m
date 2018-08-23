Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FABDC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 12:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA1F2154E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 12:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EA1F2154E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731316AbeHWQ0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 12:26:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:47814 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727714AbeHWQ0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 12:26:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2018 05:51:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,278,1531810800"; 
   d="scan'208";a="256621695"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.137]) ([10.237.72.137])
  by fmsmga005.fm.intel.com with ESMTP; 23 Aug 2018 05:51:52 -0700
Subject: Re: [PATCH V5 06/10] mmc: sdhci: Disable auto-CMD23 if stuff bits is
 set in CMD23 argument
To:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@unisoc.com>,
        Jason Wu <jason.wu@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
References: <1534406064-10065-1-git-send-email-zhang.chunyan@linaro.org>
 <1534406064-10065-7-git-send-email-zhang.chunyan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <9de08b30-cb92-01c6-caf3-c4abc3591dcf@intel.com>
Date:   Thu, 23 Aug 2018 15:50:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534406064-10065-7-git-send-email-zhang.chunyan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/18 10:54, Chunyan Zhang wrote:
> For version 4.10 and aboves, SDHCI_ARGUMENT2 is also uses to indicate
> 32-bit number of blocks, it doesn't support stuff bits in argument of
> CMD23, but only block count for the following command (CMD18/25).
> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c | 9 +++++++++
>  drivers/mmc/host/sdhci.h | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index b3328ee..a72ad0d 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1729,6 +1729,15 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  		}
>  	}
>  
> +	/*
> +	 * For version 4.10 and above, ARGUMENT2 register is also used as 32-bit
> +	 * block count register which don't support stuff bits of CMD23 argument
> +	 */
> +	if (host->version >= SDHCI_SPEC_410 &&
> +	    mrq->sbc && (mrq->sbc->arg & SDHCI_ARG2_STUFF) &&
> +	    (host->flags & SDHCI_AUTO_CMD23))
> +		host->flags &= ~SDHCI_AUTO_CMD23;

I would prefer this be done in sdhci-sprd.c by hooking ->request().  Someone
sent a patch recently to export sdhci_request().

> +
>  	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
>  		mrq->cmd->error = -ENOMEDIUM;
>  		sdhci_finish_mrq(host, mrq);
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index d34971ac..daf8c1e 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -28,6 +28,7 @@
>  
>  #define SDHCI_DMA_ADDRESS	0x00
>  #define SDHCI_ARGUMENT2		SDHCI_DMA_ADDRESS
> +#define  SDHCI_ARG2_STUFF	GENMASK(31, 16)
>  #define SDHCI_32BIT_BLK_CNT	SDHCI_DMA_ADDRESS
>  
>  #define SDHCI_BLOCK_SIZE	0x04
> 

