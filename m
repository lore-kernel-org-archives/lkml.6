Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190B4C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C405B2238E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C405B2238E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754606AbeGCI45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:56:57 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59587 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754359AbeGCI4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:56:55 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1faH7A-0008OF-7n; Tue, 03 Jul 2018 10:56:48 +0200
Message-ID: <1530608207.22468.104.camel@pengutronix.de>
Subject: Re: [PATCH 15/15] arm: dts: imx: Add missing OPP properties for CPUs
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Shawn Guo <shawnguo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     arm@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, chris.redpath@arm.com,
        ionela.voinescu@arm.com, linux-arm-kernel@lists.infradead.org
Date:   Tue, 03 Jul 2018 10:56:47 +0200
In-Reply-To: <20180703071215.GM4348@dragon>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
         <264124e14b966a1bbc07c364fbd89fc55aa765e6.1527244201.git.viresh.kumar@linaro.org>
         <1527248760.3472.6.camel@pengutronix.de>
         <20180528110739.ewmhlf72sl7u5ju7@vireshk-i7> <20180703071215.GM4348@dragon>
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

Hi Shawn,

Am Dienstag, den 03.07.2018, 15:12 +0800 schrieb Shawn Guo:
> On Mon, May 28, 2018 at 04:37:39PM +0530, Viresh Kumar wrote:
> > Hi Lucas,
> > 
> > On 25-05-18, 13:46, Lucas Stach wrote:
> > > This is a lot of duplicate information for what is effectively a shared
> > >  cluster wide thing. This does absolutely not _feel_ right.
> > 
> > I cannot agree more :)
> > 
> > > What problem are you solving here? Why do we need all this duplicate
> > > information? Why can't we fix it by falling back to looking at cpu0 if
> > > needed?
> > 
> > Let me try explaining one of the problem scenarios to you as your
> > platform is a single cluster one. Make cpufreq driver as module, don't
> > insert it, hotplug out CPU0 and now insert the cpufreq driver. The
> > cpufreq core will try adding the cpufreq policy for CPU1 but wouldn't
> > find the required information in the DT node of CPU1 and so will fail
> > or behave incorrectly.
> > 
> > We can't look at CPU0 as we don't know they are related at all.
> > Nothing tells that to us. The right solution to fix the duplication is
> > to move to OPP-v2 bindings, which allow us to create a single OPP
> > table node and refer to it from all the CPU nodes. Because in case of
> > imx platforms getting updated here, we use the old and some platforms
> > specific frequency tables, we have to duplicate it everywhere.
> > 
> > But looking from DT otherwise, all the device should anyway have all
> > the information required right in their node. That can be simplified
> > with things like phandle to opp-v2 node, but still everything needs to
> > be there. We shouldn't really rely on other CPU nodes to make it work.
> > That would be an incomplete definition of the hardware IMHO.
> 
> Lucas,
> 
> Are you fine with the patch now considering the respond from Viresh?

I still don't like the huge duplication of information in the DT, but I
agree that it's currently necessary for correctness. Long term I hope
we can get away from cpufreq-imx6 and the custom SoC OPPs, which would
allow us to switch over to OPPv2.

So patch is:
Reluctantly-acked-by: Lucas Stach <l.stach@pengutronix.de>

Regards,
Lucas
