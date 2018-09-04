Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9144EC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 482D020661
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482D020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbeIDVYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 17:24:51 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52850 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbeIDVYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 17:24:51 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 43o6G1UEj_uI; Tue,  4 Sep 2018 18:58:33 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC9A500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc9:a500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7D3571EC0253;
        Tue,  4 Sep 2018 18:58:33 +0200 (CEST)
Date:   Tue, 4 Sep 2018 18:58:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com,
        mchehab@kernel.org, leoyang.li@nxp.com, amit.kucheria@linaro.org,
        olof@lixom.net, sgoud@xilinx.com, anirudh@xilinx.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH v5 1/4] edac: synps: Add platform specific structures for
 ddrc controller
Message-ID: <20180904165828.GM32615@zn.tnic>
References: <1535722070-10394-1-git-send-email-manish.narani@xilinx.com>
 <1535722070-10394-2-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1535722070-10394-2-git-send-email-manish.narani@xilinx.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 06:57:47PM +0530, Manish Narani wrote:
> Add platform specific structures, so that we can add different IP
> support later using quirks.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/edac/synopsys_edac.c | 78 +++++++++++++++++++++++++++++++++-----------
>  1 file changed, 59 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> index 0c9c59e..2470d35 100644
> --- a/drivers/edac/synopsys_edac.c
> +++ b/drivers/edac/synopsys_edac.c
> @@ -22,6 +22,8 @@
>  #include <linux/edac.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>  
>  #include "edac_module.h"
>  
> @@ -130,6 +132,7 @@ struct synps_ecc_status {
>   * @baseaddr:	Base address of the DDR controller
>   * @message:	Buffer for framing the event specific info
>   * @stat:	ECC status information
> + * @p_data:	Pointer to platform data
>   * @ce_cnt:	Correctable Error count
>   * @ue_cnt:	Uncorrectable Error count
>   */
> @@ -137,24 +140,47 @@ struct synps_edac_priv {
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

Kill all that "function pointer" fluff. Here's how I've changed it:

/**
 * struct synps_platform_data -  synps platform data structure
 * @edac_geterror_info: edac error info
 * @edac_get_mtype:     get mtype
 * @edac_get_dtype:     get dtype
 * @edac_get_eccstate:  get ECC state
 * @quirks:             to differentiate IPs
 */

Shorter, quicker to read/scan/etc...

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

All sentences end with a fullstop. Check all your patches.

Also, it is not "ecc" it is "ECC". Also go over all your patches.

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

Please sort function local variables declaration in a reverse christmas
tree order:

	<type> longest_variable_name;
	<type> shorter_var_name;
	<type> even_shorter;
	<type> i;

>  
> +	if (!priv)
> +		return 1;

Why are you even checking this here?

synps_edac_check() is merrily dereferencing it - if anything we will
explode there already.

> +
> +	base = priv->baseaddr;
> +	p = &priv->stat;
> +
>  	regval = readl(base + STAT_OFST);
>  	if (!regval)
>  		return 1;
> @@ -240,9 +266,10 @@ static void synps_edac_handle_error(struct mem_ctl_info *mci,
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
> @@ -362,6 +389,7 @@ static int synps_edac_init_csrows(struct mem_ctl_info *mci)
>  	struct csrow_info *csi;
>  	struct dimm_info *dimm;
>  	struct synps_edac_priv *priv = mci->pvt_info;
> +	const struct synps_platform_data *p_data = priv->p_data;
>  	u32 size;
>  	int row, j;
>  
> @@ -370,12 +398,12 @@ static int synps_edac_init_csrows(struct mem_ctl_info *mci)

That function returns 0 unconditionally. Make it a void in a prepatch.

>  		size = synps_edac_get_memsize();
>  
>  		for (j = 0; j < csi->nr_channels; j++) {
> -			dimm            = csi->channels[j]->dimm;
> -			dimm->edac_mode = EDAC_FLAG_SECDED;
> -			dimm->mtype     = synps_edac_get_mtype(priv->baseaddr);
> -			dimm->nr_pages  = (size >> PAGE_SHIFT) / csi->nr_channels;
> -			dimm->grain     = SYNPS_EDAC_ERR_GRAIN;
> -			dimm->dtype     = synps_edac_get_dtype(priv->baseaddr);
> +			dimm		= csi->channels[j]->dimm;
> +			dimm->edac_mode	= EDAC_FLAG_SECDED;
> +			dimm->mtype	= p_data->edac_get_mtype(priv->baseaddr);
> +			dimm->nr_pages	= (size >> PAGE_SHIFT) / csi->nr_channels;
> +			dimm->grain	= SYNPS_EDAC_ERR_GRAIN;
> +			dimm->dtype	= p_data->edac_get_dtype(priv->baseaddr);
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
> @@ -440,13 +483,15 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
>  	int rc;
>  	struct resource *res;
>  	void __iomem *baseaddr;
> +	const struct synps_platform_data *p_data;

Please sort function local variables declaration in a reverse christmas
tree order:

	<type> longest_variable_name;
	<type> shorter_var_name;
	<type> even_shorter;
	<type> i;

>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	baseaddr = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(baseaddr))
>  		return PTR_ERR(baseaddr);
>  
> -	if (!synps_edac_get_eccstate(baseaddr)) {
> +	p_data = of_device_get_match_data(&pdev->dev);
> +	if (!(p_data->edac_get_eccstate(baseaddr))) {

Too many parentheses:

	if (!p_data->...

is enough.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
