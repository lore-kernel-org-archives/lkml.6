Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C7DC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2522820852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2522820852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388320AbeGXLPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:15:04 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33531 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbeGXLPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:15:03 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fhuFp-0006Pk-1m; Tue, 24 Jul 2018 12:09:17 +0200
Message-ID: <1532426953.32306.5.camel@pengutronix.de>
Subject: Re: [PATCH v2 3/3] PCI: imx: Initial imx7d pm support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc:     "A.s. Dong" <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Date:   Tue, 24 Jul 2018 12:09:13 +0200
In-Reply-To: <e8be199b2d5559001a93abb52ba46c283e4454a9.camel@nxp.com>
References: <cover.1532090446.git.leonard.crestez@nxp.com>
         <e42a6bb8ff0ddd6eaa31fe381875425a3730a73f.1532090446.git.leonard.crestez@nxp.com>
         <1532338685.3163.93.camel@pengutronix.de>
         <e8be199b2d5559001a93abb52ba46c283e4454a9.camel@nxp.com>
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

Am Montag, den 23.07.2018, 12:37 +0000 schrieb Leonard Crestez:
> On Mon, 2018-07-23 at 11:38 +0200, Lucas Stach wrote:
> > Hi Leonard,
> > 
> > Am Freitag, den 20.07.2018, 15:47 +0300 schrieb Leonard Crestez:
> > > On imx7d the pcie-phy power domain is turned off in suspend and this can
> > > make the system hang after resume when attempting any read from PCI.
> > > 
> > > Fix this by adding minimal suspend/resume code from the nxp internal
> > > tree. This will prepare for powering down on suspend and reset the block
> > > on resume.
> > > 
> > > Code is only for imx7d but a very similar sequence can be used for
> > > other socs.
> > > 
> > > +static void imx6_pcie_ltssm_disable(struct device *dev)
> > > +{
> > > > > > +	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> > > +
> > > > > > +	switch (imx6_pcie->variant) {
> > > > > > +	case IMX6Q:
> > > > > > +	case IMX6SX:
> > > > > > +	case IMX6QP:
> > > > > > +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > > +				   IMX6Q_GPR12_PCIE_CTL_2, 0);
> > 
> > Has this been tested on i.MX6? LTSSM disable requires a more complex
> > sequence on this SoC to avoid hanging the system. See commit
> > 3e3e406e3807 "PCI: imx6: Put LTSSM in "Detect" state before disabling
> > it".
> 
> This patch only enables suspend/resume for imx7d with other SOCs to
> follow later. The ltssm_disable function is just symmetric with
> ltssm_enable.
> 
> The 6Q parts are affected by errata "ERR005723 PCIe: PCIe does not
> support L2 power down [i.MX 6Dual/6Quad Only]".
> 
> This design error seems to have the same root cause as your problem (no
> dedicated reset control) so this works out quite nicely: the solution
> is to never power down pci on affected chips.

I don't quite like code that looks like it is doing the right thing,
but then doesn't. Can we at least emit a warning that there might be
dragons if anyone tries to call this on i.MX6?

> > > +static int imx6_pcie_resume_noirq(struct device *dev)
> > > +{
> > > > > > +	int ret = 0;
> > > > > > +	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> > > > > > +	struct pcie_port *pp = &imx6_pcie->pci->pp;
> > > +
> > > > > > +	if (imx6_pcie->variant != IMX7D)
> > > > > > +		return 0;
> > > +
> > > > > > +	imx6_pcie_assert_core_reset(imx6_pcie);
> > > > > > +	imx6_pcie_init_phy(imx6_pcie);
> > > > > > +	imx6_pcie_deassert_core_reset(imx6_pcie);
> > > > > > +	dw_pcie_setup_rc(pp);
> > > +
> > > > > > +	ret = imx6_pcie_establish_link(imx6_pcie);
> > > > > > +	if (ret < 0)
> > > +		pr_err("pcie link is down after resume.\n");
> > 
> > dev_err(), please.
> 
> The imx6_pcie_establish_link function already seems to link error
> information so the message could be dropped. However it's still helpful
> to know that those pci link errors are specifically related to resume.
> 
> Fabio suggested I propagate the return code but I'm not sure that's
> helpful since "link down" is what happens when the slot is empty and
> this is clearly not a "error" or "failure". It's not clear if "slot
> empty" can be distinguished in some way.

I don't think we have a generic way to distinguish between the two
cases.

> I'll switch to dev_info and drop the error code, is this OK?

Yes, that's fine with me.

> 
> One aspect that I skipped is PME_Turn_Off support: The PCI standard
> mandates that this is sent before entering L2/L3 and the designware
> core supports this but it's not part of this patch.
> 
> Is it fine if I post this separately or should it be part of the same
> series? The turnoff bit is in IOMUX gpr for imx6 but SRC for imx7 so it
> would require additional patches in reset, dts and then pci.

IMO it is fine to have this as a follow on patchset.

Regards,
Lucas
