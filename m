Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28BFC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35C62087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733041AbfA3SVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:21:53 -0500
Received: from foss.arm.com ([217.140.101.70]:59686 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732830AbfA3SVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:21:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65E2B80D;
        Wed, 30 Jan 2019 10:21:52 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56AA63F557;
        Wed, 30 Jan 2019 10:21:51 -0800 (PST)
Date:   Wed, 30 Jan 2019 18:21:48 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Kconfig.platforms: fix warning unmet direct
 dependencies
Message-ID: <20190130182148.GO18558@fuggles.cambridge.arm.com>
References: <20190115191839.13823-1-anders.roxell@linaro.org>
 <20190125143215.GE25901@arrakis.emea.arm.com>
 <1548431829.28802.50.camel@pengutronix.de>
 <20190130084321.GB3369@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190130084321.GB3369@localhost.localdomain>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 09:43:21AM +0100, Anders Roxell wrote:
> On 2019-01-25 16:57, Lucas Stach wrote:
> > Am Freitag, den 25.01.2019, 14:32 +0000 schrieb Catalin Marinas:
> > > On Tue, Jan 15, 2019 at 08:18:39PM +0100, Anders Roxell wrote:
> > > > When ARCH_MXC get enabled, ARM64_ERRATUM_845719 will be selected and
> > > > this warning will happen when COMPAT isn't set.
> > > > 
> > > > WARNING: unmet direct dependencies detected for ARM64_ERRATUM_845719
> > > >   Depends on [n]: COMPAT [=n]
> > > >   Selected by [y]:
> > > >   - ARCH_MXC [=y]
> > > > 
> > > > Rework to add 'if COMPAT' before ARM64_ERRATUM_845719 gets selected,
> > > > since ARM64_ERRATUM_845719 depends on COMPAT.
> > > > 
> > > > > > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > > > ---
> > > >  arch/arm64/Kconfig.platforms | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> > > > index 251ecf34cb02..d4faca775d9c 100644
> > > > --- a/arch/arm64/Kconfig.platforms
> > > > +++ b/arch/arm64/Kconfig.platforms
> > > > @@ -145,7 +145,7 @@ config ARCH_MVEBU
> > > >  config ARCH_MXC
> > > > > >  	bool "ARMv8 based NXP i.MX SoC family"
> > > > > >  	select ARM64_ERRATUM_843419
> > > > > > -	select ARM64_ERRATUM_845719
> > > > > > +	select ARM64_ERRATUM_845719 if COMPAT
> > > > > >  	help
> > > > > >  	  This enables support for the ARMv8 based SoCs in the
> > > >  	  NXP i.MX family.
> > > 
> > > Actually, do we need to select the errata workarounds explicitly? That
> > > seems to be the only case where we do it (commit 930507c18304, "arm64:
> > > add basic Kconfig symbols for i.MX8"). They are default y, so we
> > > shouldn't need to force them on.
> > 
> > This is based on past experience. We've had a lot of cases were people
> > did not enable the necessary CPU errata workaround, which then usually
> > lead to very hard to debug system failures. It is on our list of things
> > to look out for now, but I would feel much better if there is just no
> > chance for a user to misconfigure the kernel in this way.
> > 
> 
> Would a better approach be to remove the 'depends on COMPAT' in the
> Kconfig and move it into the src files instead see below.

I'd prefer to keep the dependency here, because the erratum is not
applicable for native (64-bit) userspace.

I think your original patch is fine, so:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
