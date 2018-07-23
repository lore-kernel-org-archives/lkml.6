Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E4AECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31CF720846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31CF720846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388204AbeGWKie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 06:38:34 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59953 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388043AbeGWKie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 06:38:34 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fhXI7-0002F7-Bt; Mon, 23 Jul 2018 11:38:07 +0200
Message-ID: <1532338685.3163.93.camel@pengutronix.de>
Subject: Re: [PATCH v2 3/3] PCI: imx: Initial imx7d pm support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, kernel@pengutronix.de,
        linux-imx@nxp.com
Date:   Mon, 23 Jul 2018 11:38:05 +0200
In-Reply-To: <e42a6bb8ff0ddd6eaa31fe381875425a3730a73f.1532090446.git.leonard.crestez@nxp.com>
References: <cover.1532090446.git.leonard.crestez@nxp.com>
         <e42a6bb8ff0ddd6eaa31fe381875425a3730a73f.1532090446.git.leonard.crestez@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leonard,

Am Freitag, den 20.07.2018, 15:47 +0300 schrieb Leonard Crestez:
> On imx7d the pcie-phy power domain is turned off in suspend and this can
> make the system hang after resume when attempting any read from PCI.
> 
> Fix this by adding minimal suspend/resume code from the nxp internal
> tree. This will prepare for powering down on suspend and reset the block
> on resume.
> 
> Code is only for imx7d but a very similar sequence can be used for
> other socs.
> 
> > The original author is mostly Richard Zhu <hongxing.zhu@nxp.com>, this
> patch adjusts the code to the upstream imx7d implemention using reset
> controls and power domains.
> 
> > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 95 +++++++++++++++++++++++++--
>  1 file changed, 90 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 80f604602783..daebee905108 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -540,10 +540,27 @@ static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
>  
> >  	dev_err(dev, "Speed change timeout\n");
> >  	return -EINVAL;
>  }
>  
> +static void imx6_pcie_ltssm_enable(struct device *dev)
> +{
> > +	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> +
> > +	switch (imx6_pcie->variant) {
> > +	case IMX6Q:
> > +	case IMX6SX:
> > +	case IMX6QP:
> > +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > +				   IMX6Q_GPR12_PCIE_CTL_2,
> > +				   IMX6Q_GPR12_PCIE_CTL_2);
> > +		break;
> > +	case IMX7D:
> > +		reset_control_deassert(imx6_pcie->apps_reset);
> > +	}
> +}
> +
>  static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
>  {
> >  	struct dw_pcie *pci = imx6_pcie->pci;
> >  	struct device *dev = pci->dev;
> >  	u32 tmp;
> @@ -558,15 +575,11 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
> >  	tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
> >  	tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1;
> >  	dw_pcie_writel_dbi(pci, PCIE_RC_LCR, tmp);
>  
> >  	/* Start LTSSM. */
> > -	if (imx6_pcie->variant == IMX7D)
> > -		reset_control_deassert(imx6_pcie->apps_reset);
> > -	else
> > -		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > -				   IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
> > +	imx6_pcie_ltssm_enable(dev);
>  
> >  	ret = imx6_pcie_wait_for_link(imx6_pcie);
> >  	if (ret)
> >  		goto err_reset_phy;
>  
> @@ -681,10 +694,81 @@ static int imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
>  
>  static const struct dw_pcie_ops dw_pcie_ops = {
> >  	.link_up = imx6_pcie_link_up,
>  };
>  
> +#ifdef CONFIG_PM_SLEEP
> +static void imx6_pcie_ltssm_disable(struct device *dev)
> +{
> > +	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> +
> > +	switch (imx6_pcie->variant) {
> > +	case IMX6Q:
> > +	case IMX6SX:
> > +	case IMX6QP:
> > +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +				   IMX6Q_GPR12_PCIE_CTL_2, 0);

Has this been tested on i.MX6? LTSSM disable requires a more complex
sequence on this SoC to avoid hanging the system. See commit
3e3e406e3807 "PCI: imx6: Put LTSSM in "Detect" state before disabling
it".

Note that implementing the correct sequence requires the core clocks to
  still be on when disabling LTSSM, so would need to switch ordering of
the function calls in imx6_pcie_suspend_noirq.

> +		break;
> > +	case IMX7D:
> > +		reset_control_assert(imx6_pcie->apps_reset);
> > +		break;
> > +	}
> +}
> +
> +static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
> +{
> > +	clk_disable_unprepare(imx6_pcie->pcie);
> > +	clk_disable_unprepare(imx6_pcie->pcie_phy);
> > +	clk_disable_unprepare(imx6_pcie->pcie_bus);
> +
> > +	if (imx6_pcie->variant == IMX7D) {
> > +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > +				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> > +				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> > +	}
> +}
> +
> +static int imx6_pcie_suspend_noirq(struct device *dev)
> +{
> > +	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> +
> > +	if (imx6_pcie->variant != IMX7D)
> > +		return 0;
> +
> > +	imx6_pcie_clk_disable(imx6_pcie);
> > +	imx6_pcie_ltssm_disable(dev);
> +
> > +	return 0;
> +}
> +
> +static int imx6_pcie_resume_noirq(struct device *dev)
> +{
> > +	int ret = 0;
> > +	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> > +	struct pcie_port *pp = &imx6_pcie->pci->pp;
> +
> > +	if (imx6_pcie->variant != IMX7D)
> > +		return 0;
> +
> > +	imx6_pcie_assert_core_reset(imx6_pcie);
> > +	imx6_pcie_init_phy(imx6_pcie);
> > +	imx6_pcie_deassert_core_reset(imx6_pcie);
> > +	dw_pcie_setup_rc(pp);
> +
> > +	ret = imx6_pcie_establish_link(imx6_pcie);
> > +	if (ret < 0)
> +		pr_err("pcie link is down after resume.\n");

dev_err(), please.

Regards,
Lucas

> +
> > +	return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops imx6_pcie_pm_ops = {
> > +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(imx6_pcie_suspend_noirq,
> > +				      imx6_pcie_resume_noirq)
> +};
> +
>  static int imx6_pcie_probe(struct platform_device *pdev)
>  {
> >  	struct device *dev = &pdev->dev;
> >  	struct dw_pcie *pci;
> >  	struct imx6_pcie *imx6_pcie;
> @@ -847,10 +931,11 @@ static const struct of_device_id imx6_pcie_of_match[] = {
>  static struct platform_driver imx6_pcie_driver = {
> >  	.driver = {
> > >  		.name	= "imx6q-pcie",
> >  		.of_match_table = imx6_pcie_of_match,
> >  		.suppress_bind_attrs = true,
> > +		.pm = &imx6_pcie_pm_ops,
> >  	},
> >  	.probe    = imx6_pcie_probe,
> >  	.shutdown = imx6_pcie_shutdown,
>  };
>  
