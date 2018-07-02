Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8A3C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D45252B9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D45252B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752610AbeGBMPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:15:36 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56751 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751504AbeGBMPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:15:32 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fZxji-0005ZW-Lh; Mon, 02 Jul 2018 14:15:18 +0200
Message-ID: <1530533718.22468.87.camel@pengutronix.de>
Subject: Re: [PATCH 0/2] soc: imx: gpc: Power off PU domain in
 suspend/resume on 6qp
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Date:   Mon, 02 Jul 2018 14:15:18 +0200
In-Reply-To: <cover.1530530881.git.leonard.crestez@nxp.com>
References: <cover.1530530881.git.leonard.crestez@nxp.com>
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

Am Montag, den 02.07.2018, 14:52 +0300 schrieb Leonard Crestez:
> Tested by doing `rtcwake -s 5 -m mem` while running glxgears on
> etnaviv.
> 
> The first patch is required because otherwise it is not easy to reach
> pgc
> domains from the gpc itself when using new-style bindings. It's also
> easier to understand.
> 
> The use of dynamic allocation in this driver is strange. Since there
> is
> only one GPC physically present in each soc my impulse would be to
> make
> most things global and delete imx_gpc_driver.remove entirely.
> 
> With current code (even without my patches) attempting to dynamically
> remove/probe the GPC fils since since the per-pgc platform_device
> instances are not removed. I'm trying something like this:
> 
> echo 130000.gpu > /sys/bus/platform/drivers/etnaviv-gpu/unbind
> echo 134000.gpu > /sys/bus/platform/drivers/etnaviv-gpu/unbind
> echo 20dc000.gpc  > /sys/bus/platform/drivers/imx-gpc/unbind
> echo 20dc000.gpc  > /sys/bus/platform/drivers/imx-gpc/bind
> 
> But is there any usecase for dynamically removing the GPC? Instead of
> trying to fix it I'd rather delete imx_gpc_driver.remove, just like
> for gpcv2. Would anyone object to a patch doing this?

Yes, as this is taking things in wrong direction. With device-links we
are able to unbind consumer devices when a provider is removed. As the
GPC is a consumer of a regulator, not having the ability to unbind it
would break that use case.

We might still have bugs in some of those functions, but then those
should really be fixed instead of removed.

Regards,
Lucas
