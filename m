Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4879C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F66D20855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfAXMKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 07:10:23 -0500
Received: from mga18.intel.com ([134.134.136.126]:45407 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727616AbfAXMKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 07:10:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2019 04:10:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,516,1539673200"; 
   d="scan'208";a="140932427"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jan 2019 04:10:19 -0800
Subject: Re: [PATCH 4/7] mmc: sdhci: Add quirk for disabling DTO during erase
 command
To:     Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     zhang.chunyan@linaro.org, kishon@ti.com, mark.rutland@arm.com,
        robh+dt@kernel.org, ulf.hansson@linaro.org
References: <20190111110851.6805-1-faiz_abbas@ti.com>
 <20190111110851.6805-5-faiz_abbas@ti.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <8c5875db-016c-c416-7356-d7a26d8d2a0e@intel.com>
Date:   Thu, 24 Jan 2019 14:08:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190111110851.6805-5-faiz_abbas@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/19 1:08 PM, Faiz Abbas wrote:
> Some controllers might prematurely issue a data timeout during an erase
> command. Add a quirk to disable the interrupt when an erase command is
> issued.

I might have already asked this, but would it be possible to use the
existing SDHCI_QUIRK2_DISABLE_HW_TIMEOUT quirk?

> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/mmc/host/sdhci.c | 8 ++++++++
>  drivers/mmc/host/sdhci.h | 2 ++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 4a9044c06e21..cfd716aee552 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1560,6 +1560,14 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  	/* Initially, a command has no error */
>  	cmd->error = 0;
>  
> +	if (cmd->opcode == MMC_ERASE &&
> +	    (host->quirks2 & SDHCI_QUIRK2_DISABLE_DTO_FOR_ERASE)) {
> +		mask = sdhci_readl(host, SDHCI_INT_ENABLE);
> +		mask &= ~SDHCI_INT_DATA_TIMEOUT;
> +		sdhci_writel(host, mask, SDHCI_INT_ENABLE);
> +		sdhci_writel(host, mask, SDHCI_SIGNAL_ENABLE);
> +	}
> +
>  	if ((host->quirks2 & SDHCI_QUIRK2_STOP_WITH_TC) &&
>  	    cmd->opcode == MMC_STOP_TRANSMISSION)
>  		cmd->flags |= MMC_RSP_BUSY;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 7a52823ebef4..d0c6d4fe5371 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -479,6 +479,8 @@ struct sdhci_host {
>   * block count.
>   */
>  #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
> +/* Controller needs to disable DTO for erase command */
> +#define SDHCI_QUIRK2_DISABLE_DTO_FOR_ERASE		(1<<19)
>  
>  	int irq;		/* Device IRQ */
>  	void __iomem *ioaddr;	/* Mapped address */
> 

