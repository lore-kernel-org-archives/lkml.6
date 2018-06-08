Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 4xRtItOTGlsbegAAmS7hNA
	; Fri, 08 Jun 2018 14:33:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7CC8D6089E; Fri,  8 Jun 2018 14:33:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E227C606FA;
	Fri,  8 Jun 2018 14:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E227C606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeFHOdx (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 10:33:53 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49845 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbeFHOdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 10:33:51 -0400
Received: from weser.hi.pengutronix.de ([2001:67c:670:100:fa0f:41ff:fe58:4010])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fRISY-0005Qu-Da; Fri, 08 Jun 2018 16:33:46 +0200
Message-ID: <1528468422.26356.20.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] PCI: imx: Initial imx7d pm support
From: Lucas Stach <l.stach@pengutronix.de>
To: Leonard Crestez <leonard.crestez@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Abel Vesa <abel.vesa@nxp.com>
Date: Fri, 08 Jun 2018 16:33:42 +0200
In-Reply-To: <a6176c8bcfbca08ce4e93e304bdcd48c4600f8e2.1527621510.git.leonard.crestez@nxp.com>
References: <cover.1527621510.git.leonard.crestez@nxp.com>
         <a6176c8bcfbca08ce4e93e304bdcd48c4600f8e2.1527621510.git.leonard.crestez@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:fa0f:41ff:fe58:4010
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 29.05.2018, 22:39 +0300 schrieb Leonard Crestez:
> On imx7d the phy is turned off in suspend and must be reset on resume.
> Right now lspci -v fails after a suspend/resume cycle, fix this by
> adding minimal suspend/resume code from the nxp vendor tree.
> 
> This is currently only enabled for imx7 but the same sequence can be
> applied to other imx pcie variants.
> 
> Tested on imx7d-sabresd with an Intel 5622ANHMW wireless pcie adapter.
> 
> > The original author is mostly Richard Zhu <hongxing.zhu@nxp.com>, this
> patch adjusts the code to the upstream imx7d implemention using reset
> controls and power domains.
> 
> > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/pci/dwc/pci-imx6.c | 94 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 89 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
> index 4818ef875f8a..ff6077eeb387 100644
> --- a/drivers/pci/dwc/pci-imx6.c
> +++ b/drivers/pci/dwc/pci-imx6.c
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
> @@ -681,10 +694,80 @@ static int imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
>  
>  static const struct dw_pcie_ops dw_pcie_ops = {
> >  	.link_up = imx6_pcie_link_up,
>  };
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int imx6_pcie_suspend_noirq(struct device *dev)
> +{
> > +	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> +
> +	if (imx6_pcie->variant == IMX7D) {

Instead of this large indented block, please just have an early return
at the start of this function, like:

if (imx6_pcie->variant != IMX7D)
	return 0;

Same for the resume function.

> +		/* Disable clks */
> > +		clk_disable_unprepare(imx6_pcie->pcie);
> > +		clk_disable_unprepare(imx6_pcie->pcie_phy);
> > +		clk_disable_unprepare(imx6_pcie->pcie_bus);
> > +		/* turn off external osc input */
> > +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > +				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> > +				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> > +	}
> +
> > +	return 0;
> +}
> +
> +static void imx6_pcie_ltssm_disable(struct device *dev)
> +{
> > +	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> +
> > +	switch (imx6_pcie->variant) {
> > +	case IMX6Q:
> > +	case IMX6SX:
> > +	case IMX6QP:
> > +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > +				   IMX6Q_GPR12_PCIE_CTL_2, 0);
> > +		break;
> > +	case IMX7D:
> > +		reset_control_assert(imx6_pcie->apps_reset);
> > +		break;
> > +	}
> +}
> +
> +static int imx6_pcie_resume_noirq(struct device *dev)
> +{
> > +	int ret = 0;
> > +	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> > +	struct pcie_port *pp = &imx6_pcie->pci->pp;
> +
> > +	if (imx6_pcie->variant == IMX7D) {
> > +		imx6_pcie_ltssm_disable(dev);

The LTSSM disable seems misplaced here. I would have expected it to be
in the suspend function.

> +		imx6_pcie_assert_core_reset(imx6_pcie);
> > +		imx6_pcie_init_phy(imx6_pcie);
> > +		imx6_pcie_deassert_core_reset(imx6_pcie);
> +
> > +		/*
> > +		 * controller maybe turn off, re-configure again
> > +		 */
> > +		dw_pcie_setup_rc(pp);
> +
> > +		imx6_pcie_ltssm_enable(dev);
> +
> > +		ret = imx6_pcie_wait_for_link(imx6_pcie);
> > +		if (ret < 0)
> +			pr_info("pcie link is down after resume.\n");

If the PHY has been powered down and LTSSM stopped I guess we need to
do the full imx6_pcie_establish_link() dance again here to reliably re-
establish the link. The above seems unsafe.

> +	}
> +
> > +	return 0;
> +}
> +
> +static const struct dev_pm_ops imx6_pcie_pm_ops = {
> > +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(imx6_pcie_suspend_noirq,
> > +				      imx6_pcie_resume_noirq)
> +};
> +#endif

This structure must be outside of the ifdef, or you'll break the build
on !CONFIG_PM_SLEEP.

>  static int imx6_pcie_probe(struct platform_device *pdev)
>  {
> >  	struct device *dev = &pdev->dev;
> >  	struct dw_pcie *pci;
> >  	struct imx6_pcie *imx6_pcie;
> @@ -847,10 +930,11 @@ static const struct of_device_id imx6_pcie_of_match[] = {
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

Regards,
Lucas
