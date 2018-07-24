Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A968ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC05205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAC05205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388349AbeGXNe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:34:56 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39649 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbeGXNe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:34:56 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fhwQe-0004oo-Q9; Tue, 24 Jul 2018 14:28:36 +0200
Message-ID: <1532435314.32306.7.camel@pengutronix.de>
Subject: Re: [PATCH v2 3/3] PCI: imx: Initial imx7d pm support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
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
Date:   Tue, 24 Jul 2018 14:28:34 +0200
In-Reply-To: <24ba42f6028a90836c73317af1f9e9be2d27ba03.camel@nxp.com>
References: <cover.1532090446.git.leonard.crestez@nxp.com>
         <e42a6bb8ff0ddd6eaa31fe381875425a3730a73f.1532090446.git.leonard.crestez@nxp.com>
         <1532338685.3163.93.camel@pengutronix.de>
         <e8be199b2d5559001a93abb52ba46c283e4454a9.camel@nxp.com>
         <1532426953.32306.5.camel@pengutronix.de>
         <24ba42f6028a90836c73317af1f9e9be2d27ba03.camel@nxp.com>
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

Am Dienstag, den 24.07.2018, 12:04 +0000 schrieb Leonard Crestez:
> On Tue, 2018-07-24 at 12:09 +0200, Lucas Stach wrote:
> > Am Montag, den 23.07.2018, 12:37 +0000 schrieb Leonard Crestez:
> > > On Mon, 2018-07-23 at 11:38 +0200, Lucas Stach wrote:
> > > > Am Freitag, den 20.07.2018, 15:47 +0300 schrieb Leonard Crestez:
> > > > > On imx7d the pcie-phy power domain is turned off in suspend and this can
> > > > > make the system hang after resume when attempting any read from PCI.
> > > > > 
> > > > > Fix this by adding minimal suspend/resume code from the nxp internal
> > > > > tree. This will prepare for powering down on suspend and reset the block
> > > > > on resume.
> > > > > 
> > > > > Code is only for imx7d but a very similar sequence can be used for
> > > > > other socs.
> > > > > 
> > > > > +static void imx6_pcie_ltssm_disable(struct device *dev)
> > > > > +{
> > > > > > > > > > +	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> > > > > +
> > > > > > > > > > +	switch (imx6_pcie->variant) {
> > > > > > > > > > +	case IMX6Q:
> > > > > > > > > > +	case IMX6SX:
> > > > > > > > > > +	case IMX6QP:
> > > > > > > > > > +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > > > > +				   IMX6Q_GPR12_PCIE_CTL_2, 0);
> > > > 
> > > > Has this been tested on i.MX6? LTSSM disable requires a more complex
> > > > sequence on this SoC to avoid hanging the system. See commit
> > > > 3e3e406e3807 "PCI: imx6: Put LTSSM in "Detect" state before disabling
> > > > it".
> > > 
> > > This patch only enables suspend/resume for imx7d with other SOCs to
> > > follow later. The ltssm_disable function is just symmetric with
> > > ltssm_enable.
> > > 
> > > The 6Q parts are affected by errata "ERR005723 PCIe: PCIe does not
> > > support L2 power down [i.MX 6Dual/6Quad Only]".
> > > 
> > > This design error seems to have the same root cause as your problem (no
> > > dedicated reset control) so this works out quite nicely: the solution
> > > is to never power down pci on affected chips.
> > 
> > I don't quite like code that looks like it is doing the right thing,
> > but then doesn't. Can we at least emit a warning that there might be
> > dragons if anyone tries to call this on i.MX6?
> 
> But the function will indeed toggle the right bits to initiate ltssm
> disabling. If this is not useful or can't be used right then it's the
> caller's problem :)

I don't agree with that. I would expect a function that is called
ltssm_disable to do so in a way that is safe on the hardware that it
claims to handle, which in case of i.MX6 means bashing the LTSSM into
detect state before toggling the GPR bit.

> I can add a default: clause to the switch which returns -ENOSYS and let
> IMX6Q fall that way, would that be OK? This would also help when adding
> new variants.

Yes, given that there is currently no way to test this on i.MX6,
returning -ENOSYS sound much better. This at least tells anyone who
intends to use this function that there is indeed missing functionality
there.

Regards,
Lucas
