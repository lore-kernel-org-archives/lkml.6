Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934104AbeCENvP convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 08:51:15 -0500
Received: from mail.bootlin.com ([62.4.15.54]:57707 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933502AbeCENvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 08:51:13 -0500
Date: Mon, 5 Mar 2018 14:51:10 +0100
From: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LABBE Corentin <clabbe.montjoie@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        quentin.schulz@bootlin.com
Subject: Re: [PATCH v4 10/10] ARM: sunxi: smp: Add initialization of CNTVOFF
Message-ID: <20180305145110.2f43802a@dell-desktop.home>
In-Reply-To: <20180305083114.dwqfdqlziwptfnxq@flea.lan>
References: <20180223133742.26044-1-mylene.josserand@bootlin.com>
        <20180223133742.26044-11-mylene.josserand@bootlin.com>
        <CAGb2v67SuK9Xr7_dVb7RVGXUJwYRKnTiJwDrOJ-Su5CXmm7HXA@mail.gmail.com>
        <20180226101252.ozdsxjvawgkemz2c@flea.lan>
        <CAGb2v64SaBR-_nL9S20eXe57r_kJTiqSg-di=_mZrv3Yx2-2JA@mail.gmail.com>
        <20180305085148.1de2a99c@dell-desktop.home>
        <20180305083114.dwqfdqlziwptfnxq@flea.lan>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, 5 Mar 2018 09:31:14 +0100
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> On Mon, Mar 05, 2018 at 08:51:48AM +0100, Mylène Josserand wrote:
> > > >> > diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
> > > >> > index 5e9602ce1573..4bb041492b54 100644
> > > >> > --- a/arch/arm/mach-sunxi/sunxi.c
> > > >> > +++ b/arch/arm/mach-sunxi/sunxi.c
> > > >> > @@ -37,8 +37,12 @@ static const char * const sun6i_board_dt_compat[] = {
> > > >> >  };
> > > >> >
> > > >> >  extern void __init sun6i_reset_init(void);
> > > >> > +extern void sunxi_init_cntvoff(void);
> > > >> > +
> > > >> >  static void __init sun6i_timer_init(void)
> > > >> >  {
> > > >> > +       sunxi_init_cntvoff();    
> > > >>
> > > >> You should check the enable-method to see if PSCI is set or not,
> > > >> as an indicator whether the kernel is booted secure or non-secure.    
> > > >
> > > > It's an indicator, but it's not really a perfect one. You could very
> > > > well have your kernel booted in non-secure, without PSCI. Or even with
> > > > PSCI, but without the SMP ops.
> > > >
> > > > We have a quite big number of these cases already, where, depending on
> > > > the configuration, we might not have access to the device we write to,
> > > > the number of hacks to just enable that device for non-secure is a
> > > > good example of that.    
> > > 
> > > I wouldn't consider them hacks though. The hardware gives the option
> > > to have control of many devices delegated solely to secure-only, or
> > > secure/non-secure. Our present model is to support everything we can
> > > in Linux directly, instead of through some firmware interface to a
> > > non-existent firmware.  
> > 
> > I am not sure to understand what is the conclusion about it.
> > Should I use "psci"/enable-method or should I use another mechanism to
> > detect we are in secure/non-secure (if it exists)?
> > 
> > Otherwise, for the moment, I can use machine-compatible on sun8i-a83t
> > and we will see later how we can handle it in a better way.  
> 
> Can't we have another approach here?
> 
> If we use an enable-method (and we should), instead of having it tied
> to the machine compatible, the SMP setup code will run only if our
> enable-method is the one we set up. If PSCI is in use, the
> enable-method is not going to be the one defined here, and the code
> will not run.
> 
> So why not just move that call to the SMP ops setup function, just
> like renesas does?
> 
> Maxime
> 

Okay, I will update my series and handle the differences using
enable-method instead of machine-compatible.

Best regards,

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
