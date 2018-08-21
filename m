Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DAEC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA6D214C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA6D214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbeHUQ07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 12:26:59 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49222 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbeHUQ07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 12:26:59 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id k6-_Pm1fzaa6; Tue, 21 Aug 2018 15:06:35 +0200 (CEST)
Received: from nazgul.tnic (77-85-47-250.ip.btc-net.bg [77.85.47.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BA6191EC028D;
        Tue, 21 Aug 2018 15:06:21 +0200 (CEST)
Date:   Tue, 21 Aug 2018 15:06:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, michal.simek@xilinx.com, mchehab@kernel.org,
        mdf@kernel.org, edgar.iglesias@xilinx.com,
        shubhrajyoti.datta@xilinx.com, naga.sureshkumar.relli@xilinx.com,
        bharat.kumar.gogada@xilinx.com, stefan.krsmanovic@aggios.com,
        sgoud@xilinx.com, anirudh@xilinx.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v4 1/4] edac: synps: Add platform specific structures for
 ddrc controller
Message-ID: <20180821130638.GC30528@nazgul.tnic>
References: <1533374735-16662-1-git-send-email-manish.narani@xilinx.com>
 <1533374735-16662-2-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1533374735-16662-2-git-send-email-manish.narani@xilinx.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2018 at 02:55:32PM +0530, Manish Narani wrote:
> Add platform specific structures, so that we can add different IP
> support later using quirks.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/edac/synopsys_edac.c | 83 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 65 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> index 0c9c59e..b3c54e7 100644
> --- a/drivers/edac/synopsys_edac.c
> +++ b/drivers/edac/synopsys_edac.c
> @@ -22,6 +22,7 @@
>  #include <linux/edac.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/of.h>
>  
>  #include "edac_module.h"
>  
> @@ -130,6 +131,7 @@ struct synps_ecc_status {
>   * @baseaddr:	Base address of the DDR controller
>   * @message:	Buffer for framing the event specific info
>   * @stat:	ECC status information
> + * @p_data:	Pointer to platform data
>   * @ce_cnt:	Correctable Error count
>   * @ue_cnt:	Uncorrectable Error count
>   */
> @@ -137,24 +139,47 @@ struct synps_edac_priv {
>  	void __iomem *baseaddr;
>  	char message[SYNPS_EDAC_MSG_SIZE];
>  	struct synps_ecc_status stat;
> +	const struct synps_platform_data *p_data;
>  	u32 ce_cnt;
>  	u32 ue_cnt;
>  };
>  
>  /**
> + * struct synps_platform_data -  synps platform data structure
> + * @edac_geterror_info:	function pointer to synps edac error info
> + * @edac_get_mtype:	function pointer to synps edac mtype
> + * @edac_get_dtype:	function pointer to synps edac dtype
> + * @edac_get_eccstate:	function pointer to synps edac eccstate
> + * @quirks:		to differentiate IPs
> + */
> +struct synps_platform_data {
> +	int (*edac_geterror_info)(struct synps_edac_priv *priv);
> +	enum mem_type (*edac_get_mtype)(const void __iomem *base);
> +	enum dev_type (*edac_get_dtype)(const void __iomem *base);
> +	bool (*edac_get_eccstate)(void __iomem *base);
> +	int quirks;
> +};
> +
> +/**
>   * synps_edac_geterror_info - Get the current ecc error info
> - * @base:	Pointer to the base address of the ddr memory controller
> - * @p:		Pointer to the synopsys ecc status structure
> + * @priv:	Pointer to DDR memory controller private instance data
>   *
>   * Determines there is any ecc error or not
>   *
>   * Return: one if there is no error otherwise returns zero
>   */
> -static int synps_edac_geterror_info(void __iomem *base,
> -				    struct synps_ecc_status *p)
> +static int synps_edac_geterror_info(struct synps_edac_priv *priv)
>  {
> +	void __iomem *base;
> +	struct synps_ecc_status *p;
>  	u32 regval, clearval = 0;
>  
> +	if (!priv)
> +		return 1;
> +
> +	base = priv->baseaddr;
> +	p = &priv->stat;
> +
>  	regval = readl(base + STAT_OFST);
>  	if (!regval)
>  		return 1;
> @@ -240,9 +265,10 @@ static void synps_edac_handle_error(struct mem_ctl_info *mci,
>  static void synps_edac_check(struct mem_ctl_info *mci)
>  {
>  	struct synps_edac_priv *priv = mci->pvt_info;
> +	const struct synps_platform_data *p_data = priv->p_data;
>  	int status;
>  
> -	status = synps_edac_geterror_info(priv->baseaddr, &priv->stat);
> +	status = p_data->edac_geterror_info(priv);
>  	if (status)
>  		return;
>  
> @@ -362,6 +388,7 @@ static int synps_edac_init_csrows(struct mem_ctl_info *mci)
>  	struct csrow_info *csi;
>  	struct dimm_info *dimm;
>  	struct synps_edac_priv *priv = mci->pvt_info;
> +	const struct synps_platform_data *p_data = priv->p_data;
>  	u32 size;
>  	int row, j;
>  
> @@ -370,12 +397,13 @@ static int synps_edac_init_csrows(struct mem_ctl_info *mci)
>  		size = synps_edac_get_memsize();
>  
>  		for (j = 0; j < csi->nr_channels; j++) {
> -			dimm            = csi->channels[j]->dimm;
> +			dimm = csi->channels[j]->dimm;
>  			dimm->edac_mode = EDAC_FLAG_SECDED;
> -			dimm->mtype     = synps_edac_get_mtype(priv->baseaddr);
> -			dimm->nr_pages  = (size >> PAGE_SHIFT) / csi->nr_channels;
> -			dimm->grain     = SYNPS_EDAC_ERR_GRAIN;
> -			dimm->dtype     = synps_edac_get_dtype(priv->baseaddr);
> +			dimm->mtype = p_data->edac_get_mtype(priv->baseaddr);
> +			dimm->nr_pages = (size >> PAGE_SHIFT) /
> +						csi->nr_channels;

Why do you have to break that line? Just let it stick out.

And why can't you keep the nice vertical alignment on the '=' signs for
better readability?

> +			dimm->grain = SYNPS_EDAC_ERR_GRAIN;
> +			dimm->dtype = p_data->edac_get_dtype(priv->baseaddr);
>  		}
>  	}
>  
> @@ -423,6 +451,21 @@ static int synps_edac_mc_init(struct mem_ctl_info *mci,
>  	return status;
>  }
>  
> +static const struct synps_platform_data zynq_edac_def = {
> +	.edac_geterror_info	= synps_edac_geterror_info,
> +	.edac_get_mtype		= synps_edac_get_mtype,
> +	.edac_get_dtype		= synps_edac_get_dtype,
> +	.edac_get_eccstate	= synps_edac_get_eccstate,
> +	.quirks			= 0,

... like you've done here, for example.

> +};
> +
> +static const struct of_device_id synps_edac_match[] = {
> +	{ .compatible = "xlnx,zynq-ddrc-a05", .data = (void *)&zynq_edac_def },
> +	{ /* end of table */ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, synps_edac_match);
> +
>  /**
>   * synps_edac_mc_probe - Check controller and bind driver
>   * @pdev:	Pointer to the platform_device struct
> @@ -440,13 +483,22 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
>  	int rc;
>  	struct resource *res;
>  	void __iomem *baseaddr;
> +	const struct of_device_id *match;
> +	const struct synps_platform_data *p_data;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	baseaddr = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(baseaddr))
>  		return PTR_ERR(baseaddr);
>  
> -	if (!synps_edac_get_eccstate(baseaddr)) {
> +	match = of_match_node(synps_edac_match, pdev->dev.of_node);
> +	if (!match && !match->data) {
> +		dev_err(&pdev->dev, "of_match_node() failed\n");

That error message is not really helpful.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
