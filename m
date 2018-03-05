Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbeCEHvy convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 02:51:54 -0500
Received: from mail.bootlin.com ([62.4.15.54]:47518 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752527AbeCEHvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 02:51:51 -0500
Date: Mon, 5 Mar 2018 08:51:48 +0100
From: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LABBE Corentin <clabbe.montjoie@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        quentin.schulz@bootlin.com
Subject: Re: [PATCH v4 10/10] ARM: sunxi: smp: Add initialization of CNTVOFF
Message-ID: <20180305085148.1de2a99c@dell-desktop.home>
In-Reply-To: <CAGb2v64SaBR-_nL9S20eXe57r_kJTiqSg-di=_mZrv3Yx2-2JA@mail.gmail.com>
References: <20180223133742.26044-1-mylene.josserand@bootlin.com>
        <20180223133742.26044-11-mylene.josserand@bootlin.com>
        <CAGb2v67SuK9Xr7_dVb7RVGXUJwYRKnTiJwDrOJ-Su5CXmm7HXA@mail.gmail.com>
        <20180226101252.ozdsxjvawgkemz2c@flea.lan>
        <CAGb2v64SaBR-_nL9S20eXe57r_kJTiqSg-di=_mZrv3Yx2-2JA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, 26 Feb 2018 18:25:10 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> On Mon, Feb 26, 2018 at 6:12 PM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > On Sat, Feb 24, 2018 at 12:17:13AM +0800, Chen-Yu Tsai wrote:  
> >> On Fri, Feb 23, 2018 at 9:37 PM, Mylène Josserand
> >> <mylene.josserand@bootlin.com> wrote:  
> >> > On Cortex-A7, the CNTVOFF register from arch timer is uninitialized.
> >> > It should be done by the bootloader but it is currently not the case,
> >> > even for boot CPU because this SoC is booting in secure mode.
> >> > It leads to an random offset value meaning that each CPU will have a
> >> > different time, which isn't working very well.
> >> >
> >> > Add assembly code used for boot CPU and secondary CPU cores to make
> >> > sure that the CNTVOFF register is initialized.
> >> >
> >> > Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> >> > ---
> >> >  arch/arm/mach-sunxi/headsmp.S | 21 +++++++++++++++++++++
> >> >  arch/arm/mach-sunxi/sunxi.c   |  4 ++++
> >> >  2 files changed, 25 insertions(+)
> >> >
> >> > diff --git a/arch/arm/mach-sunxi/headsmp.S b/arch/arm/mach-sunxi/headsmp.S
> >> > index d5c97e945e69..605896251927 100644
> >> > --- a/arch/arm/mach-sunxi/headsmp.S
> >> > +++ b/arch/arm/mach-sunxi/headsmp.S
> >> > @@ -65,9 +65,30 @@ ENTRY(sunxi_mc_smp_cluster_cache_enable)
> >> >         first: .word sunxi_mc_smp_first_comer - .
> >> >  ENDPROC(sunxi_mc_smp_cluster_cache_enable)
> >> >
> >> > +ENTRY(sunxi_init_cntvoff)
> >> > +       /*
> >> > +        * CNTVOFF has to be initialized either from non-secure Hypervisor
> >> > +        * mode or secure Monitor mode with SCR.NS==1. If TrustZone is enabled
> >> > +        * then it should be handled by the secure code
> >> > +        */
> >> > +       cps     #MON_MODE
> >> > +       mrc     p15, 0, r1, c1, c1, 0           /* Get Secure Config */
> >> > +       orr     r0, r1, #1
> >> > +       mcr     p15, 0, r0, c1, c1, 0           /* Set Non Secure bit */
> >> > +       instr_sync
> >> > +       mov     r0, #0
> >> > +       mcrr    p15, 4, r0, r0, c14             /* CNTVOFF = 0 */
> >> > +       instr_sync
> >> > +       mcr     p15, 0, r1, c1, c1, 0           /* Set Secure bit */
> >> > +       instr_sync
> >> > +       cps     #SVC_MODE
> >> > +       ret     lr
> >> > +ENDPROC(sunxi_init_cntvoff)  
> >>
> >> There is no need to move all the assembly into a separate file, just
> >> to add this function. Everything can be inlined as a naked function.
> >> The "instr_sync" macro can be replaced with "isb", which is what it
> >> expands to anyway.
> >>
> >> I really want to keep everything self-contained without global symbols,
> >> and in C files if possible.  
> >
> > What is the rationale for keeping it in C files (beside the global
> > symbols)? Because the syntax is quite ugly, and it's much easier to
> > read, review and amend using a separate file.  
> 
> Global symbols and keeping everything in one place I guess.
> This symbol would be used in a few places, so I suppose having it
> in a separate assembly file would be OK.

Okay so I will keep it in a separate file.

> 
> >> >  #ifdef CONFIG_SMP
> >> >  ENTRY(sunxi_boot)
> >> >         bl      sunxi_mc_smp_cluster_cache_enable
> >> > +       bl      sunxi_init_cntvoff
> >> >         b       secondary_startup
> >> >  ENDPROC(sunxi_boot)
> >> >
> >> > diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
> >> > index 5e9602ce1573..4bb041492b54 100644
> >> > --- a/arch/arm/mach-sunxi/sunxi.c
> >> > +++ b/arch/arm/mach-sunxi/sunxi.c
> >> > @@ -37,8 +37,12 @@ static const char * const sun6i_board_dt_compat[] = {
> >> >  };
> >> >
> >> >  extern void __init sun6i_reset_init(void);
> >> > +extern void sunxi_init_cntvoff(void);
> >> > +
> >> >  static void __init sun6i_timer_init(void)
> >> >  {
> >> > +       sunxi_init_cntvoff();  
> >>
> >> You should check the enable-method to see if PSCI is set or not,
> >> as an indicator whether the kernel is booted secure or non-secure.  
> >
> > It's an indicator, but it's not really a perfect one. You could very
> > well have your kernel booted in non-secure, without PSCI. Or even with
> > PSCI, but without the SMP ops.
> >
> > We have a quite big number of these cases already, where, depending on
> > the configuration, we might not have access to the device we write to,
> > the number of hacks to just enable that device for non-secure is a
> > good example of that.  
> 
> I wouldn't consider them hacks though. The hardware gives the option
> to have control of many devices delegated solely to secure-only, or
> secure/non-secure. Our present model is to support everything we can
> in Linux directly, instead of through some firmware interface to a
> non-existent firmware.

I am not sure to understand what is the conclusion about it.
Should I use "psci"/enable-method or should I use another mechanism to
detect we are in secure/non-secure (if it exists)?

Otherwise, for the moment, I can use machine-compatible on sun8i-a83t
and we will see later how we can handle it in a better way.

Thank you in advance,

Best regards,

Mylène

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com


> 
> ChenYu
> 
> >> AFAIK trying to set CNTVOFF under non-secure would be very bad.  
> >
> > Just like any other access we do :/
> >
> > Maxime
> >
> > --
> > Maxime Ripard, Bootlin (formerly Free Electrons)
> > Embedded Linux and Kernel engineering
> > https://bootlin.com  
