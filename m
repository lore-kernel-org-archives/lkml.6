Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8021C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B7CD208AC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B7CD208AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeH1LnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 07:43:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:42515 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbeH1LnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 07:43:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2018 00:52:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,298,1531810800"; 
   d="scan'208";a="66534065"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.137]) ([10.237.72.137])
  by fmsmga008.fm.intel.com with ESMTP; 28 Aug 2018 00:52:46 -0700
Subject: Re: [PATCH v5 3/3] mmc: sdhci-of-dwcmshc: solve 128MB DMA boundary
 limitation
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180827162026.3901de27@xhacker.debian>
 <20180827162419.61afe238@xhacker.debian>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <9739a083-cb2f-1cba-19c1-1c4e0d03eedd@intel.com>
Date:   Tue, 28 Aug 2018 10:51:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180827162419.61afe238@xhacker.debian>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/08/18 11:24, Jisheng Zhang wrote:
> When using DMA, if the DMA addr spans 128MB boundary, we have to split
> the DMA transfer into two so that each one doesn't exceed the boundary.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 41 +++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 1b7cd144fb01..cfbdae8703a1 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -8,21 +8,50 @@
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
> + * so that each DMA transfer doesn't exceed the boundary.
> + */
> +static void dwcmshc_adma_write_desc(struct sdhci_host *host, void **desc,
> +				    dma_addr_t addr, int len, unsigned int cmd)
> +{
> +	int tmplen, offset;
> +
> +	if (likely(!len || BOUNDARY_OK(addr, len))) {
> +		sdhci_adma_write_desc(host, desc, addr, len, cmd);
> +		return;
> +	}
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
> @@ -36,12 +65,24 @@ static int dwcmshc_probe(struct platform_device *pdev)
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

The amount of RAM is not necessarily the same as the highest physical
address.  I think what you really want is max_pfn or max_possible_pfn

> +	if (extra > SDHCI_MAX_SEGS)
> +		extra = SDHCI_MAX_SEGS;
> +	host->adma_table_cnt += extra;
> +
>  	pltfm_host = sdhci_priv(host);
>  	priv = sdhci_pltfm_priv(pltfm_host);
>  
> 

