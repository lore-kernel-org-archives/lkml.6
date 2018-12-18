Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68575C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42AAF21873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbeLRNlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:41:49 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37421 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeLRNls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:41:48 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gZFd3-0007BL-DD; Tue, 18 Dec 2018 14:41:45 +0100
Message-ID: <1545140504.5874.25.camel@pengutronix.de>
Subject: Re: [PATCH] clk: imx: add CLK_GET_RATE_NOCACHE flag for i.MX8M
 composite clock
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 18 Dec 2018 14:41:44 +0100
In-Reply-To: <7E78DD25-BA90-4EBA-81B9-755CD89BD0BF@nxp.com>
References: <1545101396-16335-1-git-send-email-Anson.Huang@nxp.com>
         <CAOMZO5BX6PWBp_FmTsMkZJEsKpf+=N6Zyn8P_+ziis-fKR37Ng@mail.gmail.com>
        ,<1545129634.5874.20.camel@pengutronix.de>
         <7E78DD25-BA90-4EBA-81B9-755CD89BD0BF@nxp.com>
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

Hi Anson,

Am Dienstag, den 18.12.2018, 13:35 +0000 schrieb Anson Huang:
> Hi, Lucas
> 
> From Anson's iPhone 6
> 
> 
> > 在 2018年12月18日，18:40，Lucas Stach <l.stach@pengutronix.de> 写道：
> > 
> > Am Dienstag, den 18.12.2018, 08:24 -0200 schrieb Fabio Estevam:
> > > Hi Anson,
> > > 
> > > On Tue, Dec 18, 2018 at 12:56 AM Anson Huang <anson.huang@nxp.com
> > > >
> > > wrote:
> > > > 
> > > > On i.MX8M, some of the bus clocks' rate could be changed in TF-
> > > > A,
> > > 
> > > Do you mean ATF (ARM Trusted Firmware) instead?
> > 
> > TF-A is the name of the day for what was formerly known as ATF...
> > 
> > However I don't think that it's correct to just don't cache the
> > clock
> > settings. Normally the secure world firmware should not change any
> > clock settings at runtime, or it would run into all kinds of
> > conflicts
> > with the clock driver. So there are probably some well known points
> > in
> > time like a suspend or resume event when the firmware might change
> > clock settings, so we could instead use those to trigger an
> > explicit
> > invalidate of the clock caches with much lower overhead.
> > 
> > Regards,
> > Lucas
> 
> There is bus-freq feature on imx8m which is to scale ddr clock, this
> is done in ARM Trusted Firmware, for some setpoints, the DDR PLL
> clock rate must be changed directly in TF-A, but its child clock like
> dram core is unaware in Linux kernel, so the clock rate will mismatch
> with hardware, since ddr related clocks will NOT used by any module
> in Linux kernel, so it will NOT introduce any conflict.

I don't think there is anything implementing the bus frequency scaling
in mainline, right?

> Regarding about the over head, yes, the change in common composite
> clock register has too many over head for other clocks, what if I
> ONLY have dram core clock to pass the CLK_GET_RATE_NOCACHE flag to
> register the composite clock?

IMHO marking clocks under TF-A control explicitly as nocache would be
much more acceptable than doing it for every composite clock. This
seems okay for a short term solution.

Still I think that whatever is causing the bus frequency scale to
change should have a way to explicitly invalidate the clock cache for
the affected clocks eventually.

Regards,
Lucas
