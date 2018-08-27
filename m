Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B6CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1608208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1608208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeH0PNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 11:13:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:50922 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbeH0PNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 11:13:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 04:27:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,295,1531810800"; 
   d="scan'208";a="66285369"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.137]) ([10.237.72.137])
  by fmsmga008.fm.intel.com with ESMTP; 27 Aug 2018 04:27:27 -0700
Subject: Re: [PATCH v2 25/40] mmc: sdhci: Add a quirk to disable card clock
 during tuning
To:     Aapo Vienamo <avienamo@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Stefan Agner <stefan@agner.ch>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
 <1533924522-1037-26-git-send-email-avienamo@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <b0b761ac-00fb-5a79-7a38-89b08c620c02@intel.com>
Date:   Mon, 27 Aug 2018 14:25:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533924522-1037-26-git-send-email-avienamo@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/18 21:08, Aapo Vienamo wrote:
> Add a quirk to disable card clock when the tuning command is sent.
> 
> This has to be done to prevent the SDHCI controller from hanging on
> Tegra210. Without the quirk enabled there appears to be around 10%
> chance that the tuning sequence will fail and time out due to the
> controller locking up.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  drivers/mmc/host/sdhci.c | 15 +++++++++++++++
>  drivers/mmc/host/sdhci.h |  2 ++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 04dc443..166b16f 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2175,6 +2175,7 @@ static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
>  	struct mmc_request mrq = {};
>  	unsigned long flags;
>  	u32 b = host->sdma_boundary;
> +	u16 clk;
>  
>  	spin_lock_irqsave(&host->lock, flags);
>  
> @@ -2183,6 +2184,13 @@ static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
>  	cmd.mrq = &mrq;
>  
>  	mrq.cmd = &cmd;
> +
> +	if (host->quirks2 & SDHCI_QUIRK2_TUNE_DIS_CARD_CLK) {
> +		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +		clk &= ~SDHCI_CLOCK_CARD_EN;
> +		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);

Rather than using a quirk, could you use the sdhci I/O accessors to disable
the clock before the tuning comment is written, udelay(1), and then enable
it again?

> +	}
> +
>  	/*
>  	 * In response to CMD19, the card sends 64 bytes of tuning
>  	 * block to the Host Controller. So we set the block size
> @@ -2213,6 +2221,13 @@ static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
>  	mmiowb();
>  	spin_unlock_irqrestore(&host->lock, flags);
>  
> +	if (host->quirks2 & SDHCI_QUIRK2_TUNE_DIS_CARD_CLK) {
> +		udelay(1);
> +		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +		clk |= SDHCI_CLOCK_CARD_EN;
> +		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +	}
> +
>  	/* Wait for Buffer Read Ready interrupt */
>  	wait_event_timeout(host->buf_ready_int, (host->tuning_done == 1),
>  			   msecs_to_jiffies(50));
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0a99008..cc411b0 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -452,6 +452,8 @@ struct sdhci_host {
>  #define SDHCI_QUIRK2_DISABLE_HW_TIMEOUT			(1<<17)
>  /* Don't clear the SDHCI_TRANSFER_MODE register on tuning commands */
>  #define SDHCI_QUIRK2_TUNE_SKIP_XFERMODE_REG_PROG	(1<<18)
> +/* Disable card clock during tuning */
> +#define SDHCI_QUIRK2_TUNE_DIS_CARD_CLK			(1<<19)
>  
>  	int irq;		/* Device IRQ */
>  	void __iomem *ioaddr;	/* Mapped address */
> 

