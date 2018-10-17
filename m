Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5496ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B647B21528
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B647B21528
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbeJRA13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 20:27:29 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59860 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbeJRA13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 20:27:29 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8i0FJnpDnZyx; Wed, 17 Oct 2018 18:30:40 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC91B00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc9:1b00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C3731EC0104;
        Wed, 17 Oct 2018 18:30:40 +0200 (CEST)
Date:   Wed, 17 Oct 2018 18:30:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com,
        mchehab@kernel.org, amit.kucheria@linaro.org, sudeep.holla@arm.com,
        olof@lixom.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v9 4/6] edac: synopsys: Add EDAC ECC support for ZynqMP
 DDRC
Message-ID: <20181017163026.GF22535@zn.tnic>
References: <1539581388-23963-1-git-send-email-manish.narani@xilinx.com>
 <1539581388-23963-5-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1539581388-23963-5-git-send-email-manish.narani@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 10:59:46AM +0530, Manish Narani wrote:
> Add EDAC ECC support for ZynqMP DDRC IP. The IP supports interrupts for
> corrected and uncorrected errors. Add interrupt handlers for the same.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/edac/Kconfig         |   2 +-
>  drivers/edac/synopsys_edac.c | 324 ++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 308 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 57304b2..7c40eb2 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -441,7 +441,7 @@ config EDAC_ALTERA_SDMMC
>  
>  config EDAC_SYNOPSYS
>  	tristate "Synopsys DDR Memory Controller"
> -	depends on ARCH_ZYNQ
> +	depends on ARCH_ZYNQ || ARCH_ZYNQMP
>  	help
>  	  Support for error detection and correction on the Synopsys DDR
>  	  memory controller.
> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> index d1999e0..603c4bd 100644
> --- a/drivers/edac/synopsys_edac.c
> +++ b/drivers/edac/synopsys_edac.c
> @@ -22,6 +22,7 @@
>  #include <linux/edac.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/interrupt.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  
> @@ -272,6 +273,8 @@
>   * @bank:	Bank number.
>   * @bitpos:	Bit position.
>   * @data:	Data causing the error.
> + * @bankgrpnr:	Bank group number.
> + * @blknr:	Block number.
>   */
>  struct ecc_error_info {
>  	u32 row;
> @@ -279,6 +282,8 @@ struct ecc_error_info {
>  	u32 bank;
>  	u32 bitpos;
>  	u32 data;
> +	u32 bankgrpnr;
> +	u32 blknr;
>  };
>  
>  /**
> @@ -385,6 +390,66 @@ static int zynq_get_error_info(struct synps_edac_priv *priv)
>  }
>  
>  /**
> + * zynqmp_get_error_info - Get the current ECC error info.
> + * @priv:	DDR memory controller private instance data.
> + *
> + * Return: one if there is no error otherwise returns zero.
> + */
> +static int zynqmp_get_error_info(struct synps_edac_priv *priv)
> +{
> +	struct synps_ecc_status *p;
> +	u32 regval, clearval = 0;
> +	void __iomem *base;
> +
> +	base = priv->baseaddr;
> +	p = &priv->stat;
> +
> +	regval = readl(base + ECC_STAT_OFST);
> +	if (!regval)
> +		return 1;
> +
> +	p->ce_cnt = (regval & ECC_STAT_CECNT_MASK) >> ECC_STAT_CECNT_SHIFT;
> +	p->ue_cnt = (regval & ECC_STAT_UECNT_MASK) >> ECC_STAT_UECNT_SHIFT;
> +	p->ceinfo.bitpos = (regval & ECC_STAT_BITNUM_MASK);
> +
> +	regval = readl(base + ECC_CEADDR0_OFST);
> +	if (!p->ce_cnt)
> +		goto ue_err;

This check should happen right under the p->ce_cnt assignment a couple
of lines above it. Otherwise the readl() is useless if you jump to the
ue_err label.

IOW, those two readl()'s should happen *after* the ce/ue_cnt checks.

> +
> +	p->ceinfo.row = (regval & ECC_CEADDR0_RW_MASK);
> +	regval = readl(base + ECC_CEADDR1_OFST);
> +	p->ceinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
> +					ECC_CEADDR1_BNKNR_SHIFT;
> +	p->ceinfo.bankgrpnr = (regval &	ECC_CEADDR1_BNKGRP_MASK) >>
> +					ECC_CEADDR1_BNKGRP_SHIFT;
> +	p->ceinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
> +	p->ceinfo.data = readl(base + ECC_CSYND0_OFST);
> +	edac_dbg(2, "ECCCSYN0: 0x%08X ECCCSYN1: 0x%08X ECCCSYN2: 0x%08X\n",
> +		 readl(base + ECC_CSYND0_OFST), readl(base + ECC_CSYND1_OFST),
> +		 readl(base + ECC_CSYND2_OFST));
> +ue_err:
> +	regval = readl(base + ECC_UEADDR0_OFST);
> +	if (!p->ue_cnt)
> +		goto out;
> +
> +	p->ueinfo.row = (regval & ECC_CEADDR0_RW_MASK);
> +	regval = readl(base + ECC_UEADDR1_OFST);
> +	p->ueinfo.bankgrpnr = (regval & ECC_CEADDR1_BNKGRP_MASK) >>
> +					ECC_CEADDR1_BNKGRP_SHIFT;
> +	p->ueinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
> +					ECC_CEADDR1_BNKNR_SHIFT;
> +	p->ueinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
> +	p->ueinfo.data = readl(base + ECC_UESYND0_OFST);
> +out:
> +	clearval = ECC_CTRL_CLR_CE_ERR | ECC_CTRL_CLR_CE_ERRCNT;
> +	clearval |= ECC_CTRL_CLR_UE_ERR | ECC_CTRL_CLR_UE_ERRCNT;
> +	writel(clearval, base + ECC_CLR_OFST);
> +	writel(0x0, base + ECC_CLR_OFST);
> +
> +	return 0;
> +}
> +

...

> +static int setup_irq(struct mem_ctl_info *mci,
> +			  struct platform_device *pdev)

Align arguments on the opening brace.

> +{
> +	struct synps_edac_priv *priv = mci->pvt_info;
> +	int ret, irq;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		edac_printk(KERN_ERR, EDAC_MC,
> +			    "No IRQ %d in DT\n", irq);
> +		return irq;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, irq, intr_handler,
> +			       0, dev_name(&pdev->dev), mci);
> +	if (ret < 0) {
> +		edac_printk(KERN_ERR, EDAC_MC, "Failed to request IRQ\n");
> +		return ret;
> +	}
> +
> +	enable_intr(priv);
> +
> +	return 0;
> +}
> +
>  static const struct synps_platform_data zynq_edac_def = {
>  	.get_error_info	= zynq_get_error_info,
>  	.get_mtype	= zynq_get_mtype,
> @@ -613,9 +872,26 @@ static const struct synps_platform_data zynq_edac_def = {
>  	.quirks		= 0,
>  };
>  
> +static const struct synps_platform_data zynqmp_edac_def = {
> +	.get_error_info	= zynqmp_get_error_info,
> +	.get_mtype	= zynqmp_get_mtype,
> +	.get_dtype	= zynqmp_get_dtype,
> +	.get_ecc_state	= zynqmp_get_ecc_state,
> +	.quirks		= DDR_ECC_INTR_SUPPORT,
> +};
> +
>  static const struct of_device_id synps_edac_match[] = {
> -	{ .compatible = "xlnx,zynq-ddrc-a05", .data = (void *)&zynq_edac_def },
> -	{ /* end of table */ }
> +	{
> +		.compatible = "xlnx,zynq-ddrc-a05",
> +		.data = (void *)&zynq_edac_def
> +	},
> +	{
> +		.compatible = "xlnx,zynqmp-ddrc-2.40a",
> +		.data = (void *)&zynqmp_edac_def
> +	},
> +	{
> +		/* end of table */
> +	}
>  };
>  
>  MODULE_DEVICE_TABLE(of, synps_edac_match);
> @@ -674,6 +950,12 @@ static int mc_probe(struct platform_device *pdev)
>  
>  	mc_init(mci, pdev);
>  
> +	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
> +		rc = setup_irq(mci, pdev);
> +		if (rc)
> +			goto free_edac_mc;
> +	}
> +
>  	rc = edac_mc_add_mc(mci);
>  	if (rc) {
>  		edac_printk(KERN_ERR, EDAC_MC,
> @@ -685,7 +967,9 @@ static int mc_probe(struct platform_device *pdev)
>  	 * Start capturing the correctable and uncorrectable errors. A write of
>  	 * 0 starts the counters.
>  	 */
> -	writel(0x0, baseaddr + ECC_CTRL_OFST);
> +	if (!(priv->p_data->quirks & DDR_ECC_INTR_SUPPORT))
> +		writel(0x0, baseaddr + ECC_CTRL_OFST);
> +
>  	return rc;
>  
>  free_edac_mc:
> @@ -703,6 +987,12 @@ static int mc_probe(struct platform_device *pdev)
>  static int mc_remove(struct platform_device *pdev)
>  {
>  	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
> +	struct synps_edac_priv *priv;
> +
> +	priv = mci->pvt_info;

Or simply:

	struct synps_edac_priv *priv = mci->pvt_info;

> +	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT)
> +		disable_intr(priv);
>  
>  	edac_mc_del_mc(&pdev->dev);
>  	edac_mc_free(mci);
> -- 
> 2.1.1
> 

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
