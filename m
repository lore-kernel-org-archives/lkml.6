Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F08C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D09C20C0F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D09C20C0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbeHVOVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 10:21:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:65278 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbeHVOVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 10:21:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2018 03:56:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,273,1531810800"; 
   d="scan'208";a="79096601"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.137]) ([10.237.72.137])
  by fmsmga002.fm.intel.com with ESMTP; 22 Aug 2018 03:56:34 -0700
Subject: Re: [PATCH 1/2] mmc: sdhci: Export sdhci_request()
To:     Aapo Vienamo <avienamo@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1534757013-4524-1-git-send-email-avienamo@nvidia.com>
 <1534757013-4524-2-git-send-email-avienamo@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <96cc4c64-088d-a2ca-44d2-615e8af9cadd@intel.com>
Date:   Wed, 22 Aug 2018 13:54:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534757013-4524-2-git-send-email-avienamo@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/18 12:23, Aapo Vienamo wrote:
> Allow SDHCI drivers to hook code before and after sdhci_request() by
> making it externally visible.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 3 ++-
>  drivers/mmc/host/sdhci.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index da47f7b..1e0c0a6 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1636,7 +1636,7 @@ EXPORT_SYMBOL_GPL(sdhci_set_power);
>   *                                                                           *
>  \*****************************************************************************/
>  
> -static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  {
>  	struct sdhci_host *host;
>  	int present;
> @@ -1675,6 +1675,7 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  	mmiowb();
>  	spin_unlock_irqrestore(&host->lock, flags);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_request);
>  
>  void sdhci_set_bus_width(struct sdhci_host *host, int width)
>  {
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index cc963a5..73c4744 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -729,6 +729,7 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
>  		     unsigned short vdd);
>  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
>  			   unsigned short vdd);
> +void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
>  void sdhci_set_bus_width(struct sdhci_host *host, int width);
>  void sdhci_reset(struct sdhci_host *host, u8 mask);
>  void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
> 

