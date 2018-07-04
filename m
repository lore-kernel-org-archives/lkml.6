Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEA3C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE2923CFD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE2923CFD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbeGDQfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:35:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40526 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752260AbeGDQfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:35:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DD8E1595;
        Wed,  4 Jul 2018 09:35:34 -0700 (PDT)
Received: from red-moon (unknown [10.1.206.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 029F23F5AD;
        Wed,  4 Jul 2018 09:35:31 -0700 (PDT)
Date:   Wed, 4 Jul 2018 17:37:23 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
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
Subject: Re: [PATCH 2/2] PCI: imx: Initial imx7d pm support
Message-ID: <20180704163723.GB13155@red-moon>
References: <cover.1527621510.git.leonard.crestez@nxp.com>
 <a6176c8bcfbca08ce4e93e304bdcd48c4600f8e2.1527621510.git.leonard.crestez@nxp.com>
 <1528468422.26356.20.camel@pengutronix.de>
 <02207512447db4585a4e879e2a059ba223d57dbe.camel@nxp.com>
 <1530607328.22468.102.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1530607328.22468.102.camel@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 10:42:08AM +0200, Lucas Stach wrote:
> Am Montag, den 02.07.2018, 17:18 +0000 schrieb Leonard Crestez:
> > On Fri, 2018-06-08 at 16:33 +0200, Lucas Stach wrote:
> > > Am Dienstag, den 29.05.2018, 22:39 +0300 schrieb Leonard Crestez:
> > > > On imx7d the phy is turned off in suspend and must be reset on resume.
> > > > Right now lspci -v fails after a suspend/resume cycle, fix this by
> > > > adding minimal suspend/resume code from the nxp vendor tree.
> > > > 
> > > > This is currently only enabled for imx7 but the same sequence can be
> > > > applied to other imx pcie variants.
> > > > +#ifdef CONFIG_PM_SLEEP
> > > > +static int imx6_pcie_suspend_noirq(struct device *dev)
> > > > +{
> > > > > > > +	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> > > > +
> > > > +	if (imx6_pcie->variant == IMX7D) {
> > > 
> > > Instead of this large indented block, please just have an early return
> > > at the start of this function, like:
> > > 
> > > if (imx6_pcie->variant != IMX7D)
> > > 	return 0;
> > > 
> > > Same for the resume function.
> > 
> > OK. The resume sequence is mostly the same for all SOCs where it
> > applies.
> > 
> > > > +static int imx6_pcie_resume_noirq(struct device *dev)
> > > > +{
> > > > > > > +	int ret = 0;
> > > > > > > +	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> > > > > > > +	struct pcie_port *pp = &imx6_pcie->pci->pp;
> > > > 
> > > > +
> > > > > > > +	if (imx6_pcie->variant == IMX7D) {
> > > > +		imx6_pcie_ltssm_disable(dev);
> > > 
> > > The LTSSM disable seems misplaced here. I would have expected it to be
> > > in the suspend function.
> > 
> > This is a requirement for reinitializing the core: LTSSM needs to be
> > turned off during initialization.
> 
> If you disable LTSSM during suspend, it should be off when entering
> this resume function, no?
> 
> > > > +		/*
> > > > > > > +		 * controller maybe turn off, re-configure again
> > > > > > > +		 */
> > > > > > > +		dw_pcie_setup_rc(pp);
> > > > +
> > > > > > > +		imx6_pcie_ltssm_enable(dev);
> > > > +
> > > > > > > +		ret = imx6_pcie_wait_for_link(imx6_pcie);
> > > > > > > +		if (ret < 0)
> > > > +			pr_info("pcie link is down after resume.\n");
> > > 
> > > If the PHY has been powered down and LTSSM stopped I guess we need to
> > > do the full imx6_pcie_establish_link() dance again here to reliably re-
> > > establish the link. The above seems unsafe.
> > 
> > What imx6_pcie_establish_link does additionally is some workaround for
> > link gen detection. I agree that it should be included.
> > 
> > This would make resume mostly the same as imx_pcie_host_init except for
> > dw_pcie_msi_init; that needs to be saved/restored separately.
> 
> Right, so maybe we can even cut down on lines of code by splitting and
> reusing existing functions.
> 
> > 
> > Another issue that should be discussed here is that on 6sx and 7d the
> > gpc PCIE power domain is not defined correctly: the PCIE block is in
> > the DISPMIX domain on both SOCs and it is only PCIE_PHY which has a
> > separate power domain.
> > 
> > This matters: enabling power-gating for displays will break pcie if
> > this relationship is not taken into account. Here are some options:
> > 
> > 1) Make &pd_pcie a child of &pd_disp by hacking into gpc probe
> > functions and calling pm_genpd_add_subdomain. Not very nice.
> > 
> > 2) Support nesting PGCs in GPC code? Lots of code and still an
> > incorrect representation of hardware.
> > 
> > 3) Set power-domains = <&pd_disp> and enable runtime PM on &pd_pcie?
> > 
> > 4) Add separate devices for the pcie-phy. These would be mostly empty
> > but still different, for example on imx6sx the PHY is not even
> > accessible on the bus but only though PCIE registers.
> 
> 5) Take a look at the linux-pm list. ;) The power domain framework has
> just gained support for multiple power domains per device. I think that
>  is the right solution for this, as like you mentioned the PHY isn't
> really a separate block on i.MX6, but part of the PCIe controller
> device.

From the discussion I take this as there is going to be a v2 so
I will mark this as Changes Requested, please let me know if that's
a problem.

Thanks,
Lorenzo
