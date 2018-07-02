Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74B5C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE56325E30
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE56325E30
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752554AbeGBN6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:58:32 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53939 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751493AbeGBN6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:58:30 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fZzLX-0001FM-1h; Mon, 02 Jul 2018 15:58:27 +0200
Message-ID: <1530539906.22468.92.camel@pengutronix.de>
Subject: Re: [PATCH 0/2] soc: imx: gpc: Power off PU domain in
 suspend/resume on 6qp
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Robin Gong <yibin.gong@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Date:   Mon, 02 Jul 2018 15:58:26 +0200
In-Reply-To: <8dc9a2359f65b570a8a94aad5e8113dfd642e441.camel@nxp.com>
References: <cover.1530530881.git.leonard.crestez@nxp.com>
         <1530533718.22468.87.camel@pengutronix.de>
         <8dc9a2359f65b570a8a94aad5e8113dfd642e441.camel@nxp.com>
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

Am Montag, den 02.07.2018, 13:49 +0000 schrieb Leonard Crestez:
> On Mon, 2018-07-02 at 14:15 +0200, Lucas Stach wrote:
> > Am Montag, den 02.07.2018, 14:52 +0300 schrieb Leonard Crestez:
> > > With current code (even without my patches) attempting to dynamically
> > > remove/probe the GPC fils since since the per-pgc platform_device
> > > instances are not removed. I'm trying something like this:
> > > 
> > > echo 130000.gpu > /sys/bus/platform/drivers/etnaviv-gpu/unbind
> > > echo 134000.gpu > /sys/bus/platform/drivers/etnaviv-gpu/unbind
> > > echo 20dc000.gpc  > /sys/bus/platform/drivers/imx-gpc/unbind
> > > echo 20dc000.gpc  > /sys/bus/platform/drivers/imx-gpc/bind
> > > 
> > > But is there any usecase for dynamically removing the GPC? Instead of
> > > trying to fix it I'd rather delete imx_gpc_driver.remove, just like
> > > for gpcv2. Would anyone object to a patch doing this?
> > 
> > Yes, as this is taking things in wrong direction. With device-links we
> > are able to unbind consumer devices when a provider is removed. As the
> > GPC is a consumer of a regulator, not having the ability to unbind it
> > would break that use case.
> 
> The GPC is a "consumer" of the LDO regulators which are built into the
> SOC. Why would you want to unbind any of this stuff?

Which in turn might be consumers of external regulators, which may have
a module driver that can be reloaded by the user at will.

> I don't understand the usecase, maybe you can elaborate?

You could make that argument for almost every device on a SoC, yet the
explicit default in Linux is for device drivers to be hot-pluggable.

Anything that changes the system layout at Linux runtime, like
devicetree overlays or dynamic system partition solutions like
Jailhouse depend on driver/device hotplug to work. I know that there
are quite a few bugs in this area, because it's less tested than other
code paths, but I'm unwilling to accept that we are actively going in
the direction of breaking this stuff.

Regards,
Lucas
