Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CA2160A325
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E828820870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E828820870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbeG3ROT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:14:19 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49763 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeG3ROT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:14:19 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1fkAFo-0002iT-QV; Mon, 30 Jul 2018 17:38:36 +0200
Message-ID: <1532965111.3471.14.camel@pengutronix.de>
Subject: Re: [PATCH 0/9] Add Reset Controller support for Actions Semi Owl
 SoCs
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        linux-clk@vger.kernel.org, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br, sravanhome@gmail.com
Date:   Mon, 30 Jul 2018 17:38:31 +0200
In-Reply-To: <20180730151131.GA28633@mani>
References: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
         <c3ae668a-6bcc-a0eb-1e00-14ef9d607316@suse.de>
         <20180730151131.GA28633@mani>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-30 at 20:41 +0530, Manivannan Sadhasivam wrote:
> Hi Andreas,
> 
> On Mon, Jul 30, 2018 at 12:26:07PM +0200, Andreas Färber wrote:
> > Hi Mani,
> > 
> > Am 27.07.2018 um 20:45 schrieb Manivannan Sadhasivam:
> > > This patchset adds Reset Controller (RMU) support for Actions Semi
> > > Owl SoCs, S900 and S700. For the Owl SoCs, RMU has been integrated into
> > > the clock subsystem in hardware. Hence, in software we integrate RMU
> > > support into common clock driver inorder to maintain compatibility.
> > 
> > Can this not be placed into drivers/reset/ by using mfd-simple with a
> > sub-node in DT?
> > 
> 
> Actually I was not sure where to place this reset controller driver. When I
> looked into other similar ones such as sunxi, they just integrated into the
> clk subsystem. So I just chose that path. But yeah, this is hacky!
> 
> But this RMU is not MFD by any means. Since the CMU (Clock) and RMU (Reset)
> are two separate IPs inside SoC, we shouldn't describe it as a MFD driver. Since
> RMU has only 2 registers, the HW designers decided to use up the CMU memory
> map. So, maybe syscon would be best option I think. What is your opinion?

Using syscon seems cleaner than stuffing the regmap into owl_clk_desc.

> Even if we go for syscon, we should place the reset driver within clk
> framework as I can see other SoCs like Mediatek are doing the same. But again
> I'm not sure!

Me neither. If the CMU and RMU are really separate and only share the
memory map, a syscon driver could live in drivers/reset without
problems.
It's only when there are interactions between clocks and resets that you
really want to have the reset driver integrated with clk.

regards
Philipp
