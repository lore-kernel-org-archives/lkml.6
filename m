Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCDBC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844E6208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844E6208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbeH0Otu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 10:49:50 -0400
Received: from mga18.intel.com ([134.134.136.126]:33931 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbeH0Otu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 10:49:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 04:03:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,295,1531810800"; 
   d="scan'208";a="66281277"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.137]) ([10.237.72.137])
  by fmsmga008.fm.intel.com with ESMTP; 27 Aug 2018 04:03:35 -0700
Subject: Re: [PATCH v2 11/40] mmc: sdhci: Add a quirk to skip clearing the
 transfer mode register on tuning
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
 <1533924522-1037-12-git-send-email-avienamo@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <d603be8f-986a-80e1-d98a-daea9c9684aa@intel.com>
Date:   Mon, 27 Aug 2018 14:01:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533924522-1037-12-git-send-email-avienamo@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/18 21:08, Aapo Vienamo wrote:
> Add SDHCI_QUIRK2_TUNE_SKIP_XFERRMODE_REG_PROG to skip programming the
> SDHCI_TRANSFER_MODE in sdhci_set_transfer_mode() if tuning command is
> being sent.
> 
> On Tegra210 and Tegra186 the tuning sequence hangs if the SDHCI
> transfer mode register is touched.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  drivers/mmc/host/sdhci.c | 6 ++++++
>  drivers/mmc/host/sdhci.h | 2 ++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a7b5602..04dc443 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1028,6 +1028,12 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
>  
>  	if (data == NULL) {
>  		if (host->quirks2 &
> +			SDHCI_QUIRK2_TUNE_SKIP_XFERMODE_REG_PROG &&
> +				(cmd->opcode == MMC_SEND_TUNING_BLOCK ||
> +				 cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200)) {
> +			return;
> +		}

Rather than introduce a quirk, can't we just dodge the unnecessary write e.g.

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1b3fbd9bd5c5..68af6a67e397 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1033,10 +1033,19 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 			if (cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200)
 				sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
 		} else {
-		/* clear Auto CMD settings for no data CMDs */
+			u16 orig;
+
+			/* clear Auto CMD settings for no data CMDs */
 			mode = sdhci_readw(host, SDHCI_TRANSFER_MODE);
-			sdhci_writew(host, mode & ~(SDHCI_TRNS_AUTO_CMD12 |
-				SDHCI_TRNS_AUTO_CMD23), SDHCI_TRANSFER_MODE);
+			orig = mode;
+			mode &= ~(SDHCI_TRNS_AUTO_CMD12 | SDHCI_TRNS_AUTO_CMD23);
+			/*
+			 * Do not write transfer mode unnecessarily because it
+			 * can upset some host controllers (e.g. sdhci-tregra)
+			 * during tuning.
+			 */
+			if (mode != orig)
+				sdhci_writew(host, new_mode, SDHCI_TRANSFER_MODE);
 		}
 		return;
 	}


Alternatively 

> +		if (host->quirks2 &
>  			SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD) {
>  			sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
>  		} else {
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 23966f8..0a99008 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -450,6 +450,8 @@ struct sdhci_host {
>   * obtainable timeout.
>   */
>  #define SDHCI_QUIRK2_DISABLE_HW_TIMEOUT			(1<<17)
> +/* Don't clear the SDHCI_TRANSFER_MODE register on tuning commands */
> +#define SDHCI_QUIRK2_TUNE_SKIP_XFERMODE_REG_PROG	(1<<18)
>  
>  	int irq;		/* Device IRQ */
>  	void __iomem *ioaddr;	/* Mapped address */
> 

