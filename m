Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187DBC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43FF21726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfAWH3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:29:14 -0500
Received: from mga07.intel.com ([134.134.136.100]:32116 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfAWH3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:29:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2019 23:29:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,510,1539673200"; 
   d="scan'208";a="110338454"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by orsmga006.jf.intel.com with ESMTP; 22 Jan 2019 23:29:09 -0800
Subject: Re: [PATCH V10 3/4] mmc: sdhci: Add ADMA3 DMA support for V4 enabled
 host
To:     Sowjanya Komatineni <skomatineni@nvidia.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, mperttunen@nvidia.com,
        chunyan.zhang@unisoc.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, ulf.hansson@linaro.org
Cc:     anrao@nvidia.com, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <1548186993-6229-1-git-send-email-skomatineni@nvidia.com>
 <1548186993-6229-3-git-send-email-skomatineni@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <459c7d2e-38a6-cfe1-f3d0-a6ecdc2de0a9@intel.com>
Date:   Wed, 23 Jan 2019 09:27:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548186993-6229-3-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/01/19 9:56 PM, Sowjanya Komatineni wrote:
> Below are the supported DMA types in Host Control1 Register
> with Version 4 enable
> b'00 - SDMA
> b'01 - Not Used
> b'10 - ADMA2
> b'11 - ADMA2 or ADMA3
> 
> ADMA3 uses Command Descriptor to issue an SD command.
> A multi-block data transfer is performed by using a pair of CMD
> descriptor and ADMA2 descriptor.
> 
> ADMA3 performs multiple of multi-block data transfer by using
> Integrated Descriptor which is more suitable for Command Queuing
> to fetch both Command and Transfer descriptors.
> 
> Host Capabilities register indiactes the supports of ADMA3 DMA.

indiactes -> indicates

> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  [V10]: Changes are same as V9 except this series has SDHCI core changes
> 	into seperate patch 
> 
>  drivers/mmc/host/sdhci.c | 9 ++++++++-
>  drivers/mmc/host/sdhci.h | 2 ++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a22e11a65658..c6afe793399e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3353,7 +3353,14 @@ void sdhci_cqe_enable(struct mmc_host *mmc)
>  
>  	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>  	ctrl &= ~SDHCI_CTRL_DMA_MASK;
> -	if (host->flags & SDHCI_USE_64_BIT_DMA)
> +	/*
> +	 * Host from V4.10 supports ADMA3 DMA type.
> +	 * ADMA3 performs integrated descriptor which is more suitable
> +	 * for cmd queuing to fetch both command and transfer descriptors.
> +	 */
> +	if (host->v4_mode && (host->caps1 & SDHCI_CAN_DO_ADMA3))
> +		ctrl |= SDHCI_CTRL_ADMA3;
> +	else if (host->flags & SDHCI_USE_64_BIT_DMA)
>  		ctrl |= SDHCI_CTRL_ADMA64;
>  	else
>  		ctrl |= SDHCI_CTRL_ADMA32;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 6cc9a3c2ac66..4070be49d947 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -88,6 +88,7 @@
>  #define   SDHCI_CTRL_ADMA1	0x08
>  #define   SDHCI_CTRL_ADMA32	0x10
>  #define   SDHCI_CTRL_ADMA64	0x18
> +#define   SDHCI_CTRL_ADMA3	0x18
>  #define   SDHCI_CTRL_8BITBUS	0x20
>  #define  SDHCI_CTRL_CDTEST_INS	0x40
>  #define  SDHCI_CTRL_CDTEST_EN	0x80
> @@ -230,6 +231,7 @@
>  #define  SDHCI_RETUNING_MODE_SHIFT		14
>  #define  SDHCI_CLOCK_MUL_MASK	0x00FF0000
>  #define  SDHCI_CLOCK_MUL_SHIFT	16
> +#define  SDHCI_CAN_DO_ADMA3	0x08000000
>  #define  SDHCI_SUPPORT_HS400	0x80000000 /* Non-standard */
>  
>  #define SDHCI_CAPABILITIES_1	0x44
> 

