Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D50C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA00B20C09
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA00B20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732211AbeHWPWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 11:22:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:14311 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729417AbeHWPWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 11:22:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2018 04:53:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,278,1531810800"; 
   d="scan'208";a="256610600"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.137]) ([10.237.72.137])
  by fmsmga005.fm.intel.com with ESMTP; 23 Aug 2018 04:53:08 -0700
Subject: Re: [PATCH v4 3/3] mmc: sdhci-of-dwcmshc: solve 128MB DMA boundary
 limitation
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180823180549.78e508db@xhacker.debian>
 <20180823180926.444b34b5@xhacker.debian>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <6302a5a4-35cf-3d8f-fcac-a15141fcf1d0@intel.com>
Date:   Thu, 23 Aug 2018 14:51:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180823180926.444b34b5@xhacker.debian>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/18 13:09, Jisheng Zhang wrote:
> When using DMA, if the DMA addr spans 128MB boundary, we have to split
> the DMA transfer into two so that each one doesn't exceed the boundary.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 39 +++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 1b7cd144fb01..df0a3aeabe19 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -8,21 +8,48 @@
>   */
>  
>  #include <linux/clk.h>
> +#include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/sizes.h>
>  
>  #include "sdhci-pltfm.h"
>  
> +#define BOUNDARY_OK(addr, len) \
> +	((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
> +
>  struct dwcmshc_priv {
>  	struct clk	*bus_clk;
>  };
>  
> +/*
> + * If DMA addr spans 128MB boundary, we split the DMA transfer into two
> + * so that the DMA transfer doesn't exceed the boundary.
> + */
> +static void dwcmshc_adma_write_desc(struct sdhci_host *host, void **desc,
> +				    dma_addr_t addr, int len, unsigned int cmd)
> +{
> +	int tmplen, offset;
> +
> +	if (likely(!len || BOUNDARY_OK(addr, len)))
> +		sdhci_adma_write_desc(host, desc, addr, len, cmd);

Doesn't this need a return? i.e.

		return;
	}

> +
> +	offset = addr & (SZ_128M - 1);
> +	tmplen = SZ_128M - offset;
> +	sdhci_adma_write_desc(host, desc, addr, tmplen, cmd);
> +
> +	addr += tmplen;
> +	len -= tmplen;
> +	sdhci_adma_write_desc(host, desc, addr, len, cmd);
> +}
> +
>  static const struct sdhci_ops sdhci_dwcmshc_ops = {
>  	.set_clock		= sdhci_set_clock,
>  	.set_bus_width		= sdhci_set_bus_width,
>  	.set_uhs_signaling	= sdhci_set_uhs_signaling,
>  	.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
>  	.reset			= sdhci_reset,
> +	.adma_write_desc	= dwcmshc_adma_write_desc,
>  };
>  
>  static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
> @@ -36,12 +63,24 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	struct sdhci_host *host;
>  	struct dwcmshc_priv *priv;
>  	int err;
> +	u32 extra;
>  
>  	host = sdhci_pltfm_init(pdev, &sdhci_dwcmshc_pdata,
>  				sizeof(struct dwcmshc_priv));
>  	if (IS_ERR(host))
>  		return PTR_ERR(host);
>  
> +	/*
> +	 * The DMA table descriptor count is calculated as the maximum
> +	 * number of segments times 2, to allow for an alignment
> +	 * descriptor for each segment, plus 1 for a nop end descriptor,
> +	 * plus extra number for cross 128M boundary handling.
> +	 */
> +	extra = DIV_ROUND_UP(totalram_pages, SZ_128M / PAGE_SIZE);

You are assuming here that totalram_pages gives you the highest physical
page number.  Is that true?

> +	if (extra > SDHCI_MAX_SEGS)
> +		extra = SDHCI_MAX_SEGS;
> +	host->adma_table_cnt = SDHCI_MAX_SEGS * 2 + 1 + extra;

That should be:

	host->adma_table_cnt += extra;

> +
>  	pltfm_host = sdhci_priv(host);
>  	priv = sdhci_pltfm_priv(pltfm_host);
>  
> 

