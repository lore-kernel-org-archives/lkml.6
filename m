Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D83FC43444
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9D320874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="lk0i2XcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbeLQMrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:47:49 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:39939 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbeLQMrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:47:49 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 8BD6825B781;
        Mon, 17 Dec 2018 23:47:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1545050866; bh=SIOkPqYHIIBf7aOm6TXhz5l5ydX/VofJ79rGHsLaJrw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lk0i2XcKitIcQBe451MVAEU8U5ek2MLa4oB0EJRzcTiJTr108bYs2G0XZz41RavYd
         CvSWCRSjwLa7nB1IVvWYnJEeVGmRTOQl59sP+tkEzoGa7qOqi850Tliii+UwnHaLvC
         L3GTo4lqDtrCmxeWtIcHDk6cQKOfHTlUYZ8bkmEs=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id DC27694048A; Mon, 17 Dec 2018 13:47:44 +0100 (CET)
Date:   Mon, 17 Dec 2018 13:47:44 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: shmobile: fix build regressions
Message-ID: <20181217124743.xcp7amqn6ucmy2l6@verge.net.au>
References: <20181210210033.3276054-1-arnd@arndb.de>
 <CAMuHMdV9Xp6J0oiYxYn+5SxmqnOLX78rTts2E7dmH4xzLe_KTg@mail.gmail.com>
 <20181212103032.ejjr6itnyb6uzck5@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212103032.ejjr6itnyb6uzck5@verge.net.au>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 11:30:33AM +0100, Simon Horman wrote:
> On Tue, Dec 11, 2018 at 09:58:05AM +0100, Geert Uytterhoeven wrote:
> > Hi Arnd,
> > 
> > On Mon, Dec 10, 2018 at 10:00 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > A number of Kconfig options have become available now to random ARM
> > > platforms outside of ARCH_MULTIPLATFORM, which now causes Kconfig
> > > warnings, and other build errors when those select options that
> > > lack additonal dependencies, e.g.:
> > >
> > > WARNING: unmet direct dependencies detected for HAVE_ARM_ARCH_TIMER
> > >   Depends on [n]: CPU_V7 [=n]
> > >   Selected by [y]:
> > >   - ARCH_RCAR_GEN2 [=y] && SOC_RENESAS [=y]
> > >   - ARCH_R8A73A4 [=y] && SOC_RENESAS [=y] && ARM [=y]
> > >
> > > WARNING: unmet direct dependencies detected for SYS_SUPPORTS_EM_STI
> > >   Depends on [n]: GENERIC_CLOCKEVENTS [=n]
> > >   Selected by [y]:
> > >   - ARCH_EMEV2 [=y] && SOC_RENESAS [=y] && ARM [=y]
> > >
> > > Put the old dependency on ARCH_RENESAS back for the moment to restore
> > > the previous behavior.
> > >
> > > Fixes: 062887bf5ef7 ("ARM: shmobile: Move SoC Kconfig symbols to drivers/soc/renesas/")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > >  drivers/soc/renesas/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
> > > index 4d8012e1205c..68bfca6f20dd 100644
> > > --- a/drivers/soc/renesas/Kconfig
> > > +++ b/drivers/soc/renesas/Kconfig
> > > @@ -44,7 +44,7 @@ config ARCH_RZN1
> > >         bool
> > >         select ARM_AMBA
> > >
> > > -if ARM
> > > +if ARM && ARCH_RENESAS
> > 
> > After a closer look, I think restricting this from ARM to ARCH_MULTI_V7
> > should work, too (ARCH_MULTI_V7 selects CPU_V7, and ARCH_MULTIPLATFORM
> > selects GENERIC_CLOCKEVENTS).
> 
> Hi Arnd,
> 
> what is your preferred way forwards here?
> I'm tempted to take your patch as-is and then work on
> refining the dependency as a follow-up.

I have gone ahead and applied Arnd's patch as a fix for v4.21.
It seems like the safest option for a fix.
