Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E40EECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D842154C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D842154C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389978AbeIUSpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 14:45:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44748 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389022AbeIUSpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 14:45:03 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id I541MdCS5VRc; Fri, 21 Sep 2018 14:56:16 +0200 (CEST)
Received: from nazgul.tnic (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9297A1EC0347;
        Fri, 21 Sep 2018 14:56:16 +0200 (CEST)
Date:   Fri, 21 Sep 2018 14:56:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, mchehab@kernel.org,
        michal.simek@xilinx.com, leoyang.li@nxp.com, sudeep.holla@arm.com,
        amit.kucheria@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 5/7] edac: synopsys: Add EDAC ECC support for ZynqMP
 DDRC
Message-ID: <20180921125527.GE30439@nazgul.tnic>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
 <1537194305-9243-6-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1537194305-9243-6-git-send-email-manish.narani@xilinx.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 07:55:03PM +0530, Manish Narani wrote:
> Add EDAC ECC support for ZynqMP DDRC IP. The IP supports interrupts for
> corrected and uncorrected errors. Add interrupt handlers for the same.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/edac/Kconfig         |   2 +-
>  drivers/edac/synopsys_edac.c | 304 ++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 287 insertions(+), 19 deletions(-)

...

> @@ -639,7 +878,7 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
>  	struct mem_ctl_info *mci;
>  	void __iomem *baseaddr;
>  	struct resource *res;
> -	int rc;
> +	int rc, irq;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	baseaddr = devm_ioremap_resource(&pdev->dev, res);
> @@ -673,6 +912,28 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
>  
>  	edac_mc_init(mci, pdev);
>  
> +	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {

This whole chunk together with the if, looks like it could be a separate
function called maybe request_irq() or so.

> +		irq = platform_get_irq(pdev, 0);
> +		if (irq < 0) {
> +			edac_printk(KERN_ERR, EDAC_MC,
> +					"No irq %d in DT\n", irq);

Align arguments on opening brace.

Then, here it is "irq"...

> +			rc = irq;
> +			goto free_edac_mc;
> +		}
> +
> +		rc = devm_request_irq(&pdev->dev, irq,
> +			synps_edac_intr_handler,
> +			0, dev_name(&pdev->dev), mci);

Also align on opening brace.

> +		if (rc < 0) {
> +			edac_printk(KERN_ERR, EDAC_MC, "Failed to request Irq\n");

... here it is "Irq".

I'd say it should be "IRQ" everywhere.

> +			goto free_edac_mc;
> +		}
> +
> +		/* Enable UE/CE Interrupts */
> +		writel((DDR_QOSUE_MASK | DDR_QOSCE_MASK),
> +			priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
> +	}
> +
>  	rc = edac_mc_add_mc(mci);
>  	if (rc) {
>  		edac_printk(KERN_ERR, EDAC_MC,
> @@ -684,7 +945,8 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
>  	 * Start capturing the correctable and uncorrectable errors. A write of
>  	 * 0 starts the counters.
>  	 */
> -	writel(0x0, baseaddr + ECC_CTRL_OFST);
> +	if (!(priv->p_data->quirks & DDR_ECC_INTR_SUPPORT))
> +		writel(0x0, baseaddr + ECC_CTRL_OFST);
>  	return rc;
>  
>  free_edac_mc:
> @@ -702,7 +964,13 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
>  static int synps_edac_mc_remove(struct platform_device *pdev)
>  {
>  	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
> +	struct synps_edac_priv *priv;
>  
> +	priv = mci->pvt_info;
> +	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT)
> +		/* Disable UE/CE Interrupts */
> +		writel((DDR_QOSUE_MASK | DDR_QOSCE_MASK),
> +			priv->baseaddr + DDR_QOS_IRQ_DB_OFST);

This could be a disable_irq() function. Makes the code easier to follow.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
