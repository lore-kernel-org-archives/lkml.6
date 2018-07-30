Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E58FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E2520873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E2520873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbeG3Ok4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:40:56 -0400
Received: from mga18.intel.com ([134.134.136.126]:46034 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbeG3Ok4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:40:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 06:06:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,422,1526367600"; 
   d="scan'208";a="71684175"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.168]) ([10.237.72.168])
  by fmsmga002.fm.intel.com with ESMTP; 30 Jul 2018 06:05:58 -0700
Subject: Re: [PATCH V4 1/7] mmc: sdhci: add sd host v4 mode
To:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>,
        Jason Wu <jason.wu@unisoc.com>, zhang.lyra@gmail.com
References: <1532340508-8749-1-git-send-email-zhang.chunyan@linaro.org>
 <1532340508-8749-2-git-send-email-zhang.chunyan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <87ecfb68-775a-2a17-5b42-ae02b354e3d7@intel.com>
Date:   Mon, 30 Jul 2018 16:04:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <1532340508-8749-2-git-send-email-zhang.chunyan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/18 13:08, Chunyan Zhang wrote:
> For SD host controller version 4.00 or later ones, there're two
> modes of implementation - Version 3.00 compatible mode or
> Version 4 mode.  This patch introduced an interface to enable
> v4 mode.
> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c | 28 ++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.h |  5 +++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 1c828e0..cab5350 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -123,6 +123,30 @@ EXPORT_SYMBOL_GPL(sdhci_dumpregs);
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
> + * Vendor's Host Controller which supports v4 mode can call
> + * this function to enable v4 mode before calling
> + * __sdhci_add_host().
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
> @@ -224,6 +248,10 @@ static void sdhci_do_reset(struct sdhci_host *host, u8 mask)
>  
>  		/* Resetting the controller clears many */
>  		host->preset_enabled = false;
> +
> +		if (host->v4_mode)
> +			sdhci_do_enable_v4_mode(host);

Instead of sdhci_do_reset() I would rather add this to sdhci_init() and
__sdhci_read_caps()

> +
>  	}
>  }
>  
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 23966f8..519d939 100644
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
> @@ -565,6 +566,9 @@ struct sdhci_host {
>  
>  	u64			data_timeout;
>  
> +	/* Host Version 4 Enable */
> +	bool			v4_mode;

Let's put this with the other bools i.e. after bool irq_wake_enabled;

> +
>  	unsigned long private[0] ____cacheline_aligned;
>  };
>  
> @@ -747,5 +751,6 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
>  		   int *data_error);
>  
>  void sdhci_dumpregs(struct sdhci_host *host);
> +void sdhci_enable_v4_mode(struct sdhci_host *host);
>  
>  #endif /* __SDHCI_HW_H */
> 

