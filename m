Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37ADDC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE66A24DFF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE66A24DFF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754560AbeGCImQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:42:16 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39197 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753560AbeGCImN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:42:13 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1faGt0-0006rg-MJ; Tue, 03 Jul 2018 10:42:10 +0200
Message-ID: <1530607328.22468.102.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] PCI: imx: Initial imx7d pm support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Anson Huang <anson.huang@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date:   Tue, 03 Jul 2018 10:42:08 +0200
In-Reply-To: <02207512447db4585a4e879e2a059ba223d57dbe.camel@nxp.com>
References: <cover.1527621510.git.leonard.crestez@nxp.com>
         <a6176c8bcfbca08ce4e93e304bdcd48c4600f8e2.1527621510.git.leonard.crestez@nxp.com>
         <1528468422.26356.20.camel@pengutronix.de>
         <02207512447db4585a4e879e2a059ba223d57dbe.camel@nxp.com>
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

Am Montag, den 02.07.2018, 17:18 +0000 schrieb Leonard Crestez:
> On Fri, 2018-06-08 at 16:33 +0200, Lucas Stach wrote:
> > Am Dienstag, den 29.05.2018, 22:39 +0300 schrieb Leonard Crestez:
> > > On imx7d the phy is turned off in suspend and must be reset on resume.
> > > Right now lspci -v fails after a suspend/resume cycle, fix this by
> > > adding minimal suspend/resume code from the nxp vendor tree.
> > > 
> > > This is currently only enabled for imx7 but the same sequence can be
> > > applied to other imx pcie variants.
> > > +#ifdef CONFIG_PM_SLEEP
> > > +static int imx6_pcie_suspend_noirq(struct device *dev)
> > > +{
> > > > > > +	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> > > +
> > > +	if (imx6_pcie->variant == IMX7D) {
> > 
> > Instead of this large indented block, please just have an early return
> > at the start of this function, like:
> > 
> > if (imx6_pcie->variant != IMX7D)
> > 	return 0;
> > 
> > Same for the resume function.
> 
> OK. The resume sequence is mostly the same for all SOCs where it
> applies.
> 
> > > +static int imx6_pcie_resume_noirq(struct device *dev)
> > > +{
> > > > > > +	int ret = 0;
> > > > > > +	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> > > > > > +	struct pcie_port *pp = &imx6_pcie->pci->pp;
> > > 
> > > +
> > > > > > +	if (imx6_pcie->variant == IMX7D) {
> > > +		imx6_pcie_ltssm_disable(dev);
> > 
> > The LTSSM disable seems misplaced here. I would have expected it to be
> > in the suspend function.
> 
> This is a requirement for reinitializing the core: LTSSM needs to be
> turned off during initialization.

If you disable LTSSM during suspend, it should be off when entering
this resume function, no?

> > > +		/*
> > > > > > +		 * controller maybe turn off, re-configure again
> > > > > > +		 */
> > > > > > +		dw_pcie_setup_rc(pp);
> > > +
> > > > > > +		imx6_pcie_ltssm_enable(dev);
> > > +
> > > > > > +		ret = imx6_pcie_wait_for_link(imx6_pcie);
> > > > > > +		if (ret < 0)
> > > +			pr_info("pcie link is down after resume.\n");
> > 
> > If the PHY has been powered down and LTSSM stopped I guess we need to
> > do the full imx6_pcie_establish_link() dance again here to reliably re-
> > establish the link. The above seems unsafe.
> 
> What imx6_pcie_establish_link does additionally is some workaround for
> link gen detection. I agree that it should be included.
> 
> This would make resume mostly the same as imx_pcie_host_init except for
> dw_pcie_msi_init; that needs to be saved/restored separately.

Right, so maybe we can even cut down on lines of code by splitting and
reusing existing functions.

> 
> Another issue that should be discussed here is that on 6sx and 7d the
> gpc PCIE power domain is not defined correctly: the PCIE block is in
> the DISPMIX domain on both SOCs and it is only PCIE_PHY which has a
> separate power domain.
> 
> This matters: enabling power-gating for displays will break pcie if
> this relationship is not taken into account. Here are some options:
> 
> 1) Make &pd_pcie a child of &pd_disp by hacking into gpc probe
> functions and calling pm_genpd_add_subdomain. Not very nice.
> 
> 2) Support nesting PGCs in GPC code? Lots of code and still an
> incorrect representation of hardware.
> 
> 3) Set power-domains = <&pd_disp> and enable runtime PM on &pd_pcie?
> 
> 4) Add separate devices for the pcie-phy. These would be mostly empty
> but still different, for example on imx6sx the PHY is not even
> accessible on the bus but only though PCIE registers.

5) Take a look at the linux-pm list. ;) The power domain framework has
just gained support for multiple power domains per device. I think that
 is the right solution for this, as like you mentioned the PHY isn't
really a separate block on i.MX6, but part of the PCIe controller
device.

Regards,
Lucas
