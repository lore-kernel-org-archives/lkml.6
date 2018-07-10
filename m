Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6A3C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A82420878
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A82420878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933528AbeGJIFy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 04:05:54 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34967 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933409AbeGJIFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 04:05:52 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fcneb-0004jZ-6S; Tue, 10 Jul 2018 10:05:45 +0200
Message-ID: <1531209943.3163.31.camel@pengutronix.de>
Subject: Re: [PATCH v3] soc: imx: gpc: Turn PU domain on/off in sleep on 6qp
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>
Date:   Tue, 10 Jul 2018 10:05:43 +0200
In-Reply-To: <CAPDyKFqb6eZ2SYG612yqiNisv7UV1q3UHYfZfemmvv9Q4w=Png@mail.gmail.com>
References: <ab0c7997bdb0caf6fe7e842315bb9565c2cb059d.1530895248.git.leonard.crestez@nxp.com>
         <CAPDyKFqb6eZ2SYG612yqiNisv7UV1q3UHYfZfemmvv9Q4w=Png@mail.gmail.com>
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

Am Dienstag, den 10.07.2018, 00:27 +0200 schrieb Ulf Hansson:
> > On 6 July 2018 at 18:46, Leonard Crestez <leonard.crestez@nxp.com> wrote:
> > On imx6qp power gating on the PU domain is disabled because of errata
> > ERR009619. However power gating during suspend/resume can still be
> > performed.
> 
> Sounds a bit hand wavy. Exactly why can it be done during system suspend/resume?

Power gating this domain in normal operation may introduce a glitch in
unrelated modules, potentially disturbing a running display scanout.
This is not a concern when the whole system enters suspend state, so
it's safe to do in this case.

Regards,
Lucas

> > 
> > Enable this by implementing SLEEP_PM_OPS in imx_pgc_power_domain_driver.
> > 
> > In order to ensure correct ordering add device links from devices inside
> > the PU domain to the pgc platform_device.
> 
> In genpd, the PM domain gets powered off after all device's
> corresponding ->suspend_noirq() callback has been invoked - and it
> also considers if there are some wakeup settings enabled, possibly
> avoiding to do the power off.
> 
> It sound like the imx's power domain driver ->power_off|on() callback
> should deal with this, to make get a consistent behavior. I understand
> that you currently can't tell under what circumstances the
> ->power_off|on() callbacks are being invoked, that may need some
> changes in genpd.
> 
> Currently we have a flag, GENPD_FLAG_ALWAYS_ON which makes genpd to
> always prevent power off. Perhaps we should add a new flag
> "GENPD_FLAG_RUNTIME_ON", which makes genpd to call the
> ->power_on|off() callbacks, but only during system wide PM.
> 
> Thoughts?

Yes, this might work for this case.

Regards,
Lucas
