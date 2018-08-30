Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBC4C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84BC320645
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84BC320645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbeH3MhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:37:24 -0400
Received: from mga09.intel.com ([134.134.136.24]:38766 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727688AbeH3MhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:37:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 01:36:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,306,1531810800"; 
   d="scan'208";a="253109906"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.98]) ([10.237.72.98])
  by orsmga005.jf.intel.com with ESMTP; 30 Aug 2018 01:36:19 -0700
Subject: Re: [PATCH V8 7/9] mmc: sdhci: SDMA may use Auto-CMD23 in v4 mode
To:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@unisoc.com>,
        Jason Wu <jason.wu@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
References: <1535617305-16952-1-git-send-email-zhang.chunyan@linaro.org>
 <1535617305-16952-8-git-send-email-zhang.chunyan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <4931d113-1af0-26ed-ae96-8ccd1be99334@intel.com>
Date:   Thu, 30 Aug 2018 11:34:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535617305-16952-8-git-send-email-zhang.chunyan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/18 11:21, Chunyan Zhang wrote:
> When Host Version 4 Enable is set to 1, SDMA uses ADMA System Address
> register (05Fh-058h) instead of using register (000h-004h) to indicate
> its system address of data location. The register (000h-004h) is
> re-assigned to 32-bit Block Count and Auto CMD23 argument, so then SDMA
> may use Auto CMD23.
> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 62d843ac90..606d331 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3834,10 +3834,13 @@ int sdhci_setup_host(struct sdhci_host *host)
>  	if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
>  		host->flags |= SDHCI_AUTO_CMD12;
>  
> -	/* Auto-CMD23 stuff only works in ADMA or PIO. */
> +	/*
> +	 * For v3 mode, Auto-CMD23 stuff only works in ADMA or PIO.
> +	 * For v4 mode, SDMA may use Auto-CMD23 as well.
> +	 */
>  	if ((host->version >= SDHCI_SPEC_300) &&
>  	    ((host->flags & SDHCI_USE_ADMA) ||
> -	     !(host->flags & SDHCI_USE_SDMA)) &&
> +	     !(host->flags & SDHCI_USE_SDMA) || host->v4_mode) &&
>  	     !(host->quirks2 & SDHCI_QUIRK2_ACMD23_BROKEN)) {
>  		host->flags |= SDHCI_AUTO_CMD23;
>  		DBG("Auto-CMD23 available\n");
> 

