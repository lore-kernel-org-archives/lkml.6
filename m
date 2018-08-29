Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF24C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA50204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA50204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbeH2O5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 10:57:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:2716 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbeH2O5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 10:57:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 04:01:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,303,1531810800"; 
   d="scan'208";a="66031902"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.98]) ([10.237.72.98])
  by fmsmga007.fm.intel.com with ESMTP; 29 Aug 2018 04:01:26 -0700
Subject: Re: [PATCH V7 7/9] mmc: sdhci: SDMA may use Auto-CMD23 in v4 mode
To:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@unisoc.com>,
        Jason Wu <jason.wu@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
References: <1535526184-32718-1-git-send-email-zhang.chunyan@linaro.org>
 <1535526184-32718-8-git-send-email-zhang.chunyan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <a38f8d87-a373-5de4-c3b5-bba68f8ffeec@intel.com>
Date:   Wed, 29 Aug 2018 13:59:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535526184-32718-8-git-send-email-zhang.chunyan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/18 10:03, Chunyan Zhang wrote:
> When Host Version 4 Enable is set to 1, SDMA uses ADMA System Address
> register (05Fh-058h) instead of using register (000h-004h) to indicate
> its system address of data location. The register (000h-004h) is
> re-assigned to 32-bit Block Count and Auto CMD23 argument, so then SDMA
> may use Auto CMD23.
> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 62d843ac90..ac92e0f 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3834,10 +3834,14 @@ int sdhci_setup_host(struct sdhci_host *host)
>  	if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
>  		host->flags |= SDHCI_AUTO_CMD12;
>  
> -	/* Auto-CMD23 stuff only works in ADMA or PIO. */
> +	/*
> +	 * For v3 mode, Auto-CMD23 stuff only works in ADMA or PIO;

; -> .

> +	 * For v4 mode, SDMA may use Auto-CMD23 as well.
> +	 */
>  	if ((host->version >= SDHCI_SPEC_300) &&
>  	    ((host->flags & SDHCI_USE_ADMA) ||
> -	     !(host->flags & SDHCI_USE_SDMA)) &&
> +	     (!host->v4_mode && !(host->flags & SDHCI_USE_SDMA)) ||
> +	     (host->v4_mode && (host->flags & SDHCI_USE_SDMA))) &&
>  	     !(host->quirks2 & SDHCI_QUIRK2_ACMD23_BROKEN)) {

This is over complicated.  We can use auto-CMD23 if not using SDMA or if in
v4_mode i.e.

	if (host->version >= SDHCI_SPEC_300 &&
	    (!(host->flags & SDHCI_USE_SDMA) || host->v4_mode) &&
	    !(host->quirks2 & SDHCI_QUIRK2_ACMD23_BROKEN)) {

>  		host->flags |= SDHCI_AUTO_CMD23;
>  		DBG("Auto-CMD23 available\n");
> 

