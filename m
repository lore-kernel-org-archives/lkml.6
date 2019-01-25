Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB666C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2895218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbfAYP5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 10:57:15 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37431 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728503AbfAYP5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 10:57:13 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gn3qv-0001w3-QD; Fri, 25 Jan 2019 16:57:09 +0100
Message-ID: <1548431829.28802.50.camel@pengutronix.de>
Subject: Re: [PATCH] arm64: Kconfig.platforms: fix warning unmet direct
 dependencies
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Anders Roxell <anders.roxell@linaro.org>
Cc:     will.deacon@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 25 Jan 2019 16:57:09 +0100
In-Reply-To: <20190125143215.GE25901@arrakis.emea.arm.com>
References: <20190115191839.13823-1-anders.roxell@linaro.org>
         <20190125143215.GE25901@arrakis.emea.arm.com>
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

Am Freitag, den 25.01.2019, 14:32 +0000 schrieb Catalin Marinas:
> On Tue, Jan 15, 2019 at 08:18:39PM +0100, Anders Roxell wrote:
> > When ARCH_MXC get enabled, ARM64_ERRATUM_845719 will be selected and
> > this warning will happen when COMPAT isn't set.
> > 
> > WARNING: unmet direct dependencies detected for ARM64_ERRATUM_845719
> >   Depends on [n]: COMPAT [=n]
> >   Selected by [y]:
> >   - ARCH_MXC [=y]
> > 
> > Rework to add 'if COMPAT' before ARM64_ERRATUM_845719 gets selected,
> > since ARM64_ERRATUM_845719 depends on COMPAT.
> > 
> > > > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  arch/arm64/Kconfig.platforms | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> > index 251ecf34cb02..d4faca775d9c 100644
> > --- a/arch/arm64/Kconfig.platforms
> > +++ b/arch/arm64/Kconfig.platforms
> > @@ -145,7 +145,7 @@ config ARCH_MVEBU
> >  config ARCH_MXC
> > > >  	bool "ARMv8 based NXP i.MX SoC family"
> > > >  	select ARM64_ERRATUM_843419
> > > > -	select ARM64_ERRATUM_845719
> > > > +	select ARM64_ERRATUM_845719 if COMPAT
> > > >  	help
> > > >  	  This enables support for the ARMv8 based SoCs in the
> >  	  NXP i.MX family.
> 
> Actually, do we need to select the errata workarounds explicitly? That
> seems to be the only case where we do it (commit 930507c18304, "arm64:
> add basic Kconfig symbols for i.MX8"). They are default y, so we
> shouldn't need to force them on.

This is based on past experience. We've had a lot of cases were people
did not enable the necessary CPU errata workaround, which then usually
lead to very hard to debug system failures. It is on our list of things
to look out for now, but I would feel much better if there is just no
chance for a user to misconfigure the kernel in this way.

Regards,
Lucas
