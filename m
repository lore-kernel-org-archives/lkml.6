Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbeEBN2p convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 09:28:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51773 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751100AbeEBN2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 09:28:40 -0400
Date: Wed, 2 May 2018 15:28:37 +0200
From: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: linux@armlinux.org.uk, wens@csie.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, robh+dt@kernel.org, horms@verge.net.au,
        geert@linux-m68k.org, magnus.damm@gmail.com,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 07/12] ARM: sunxi: Add initialization of CNTVOFF
Message-ID: <20180502152837.379c376a@dell-desktop.home>
In-Reply-To: <20180502130842.pecjwahxrvx5addq@flea>
References: <20180501123131.7738-1-mylene.josserand@bootlin.com>
        <20180501123131.7738-8-mylene.josserand@bootlin.com>
        <20180502130842.pecjwahxrvx5addq@flea>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Wed, 2 May 2018 15:08:42 +0200
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> On Tue, May 01, 2018 at 02:31:26PM +0200, Mylène Josserand wrote:
> > Add the initialization of CNTVOFF for sun8i-a83t.
> > 
> > For boot CPU, create a new machine that handles this
> > function's call in an "init_early" callback. We need to initialize
> > CNTVOFF before the arch timer's initialization otherwise, it will
> > not be taken into account and fails to boot correctly.
> > Because of that, this function can't be called in SMP's early_initcall
> > function which is called after timer's init.
> > 
> > For secondary CPUs, add this function into secondary_startup
> > assembly entry.
> > 
> > Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> > Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > ---
> >  arch/arm/mach-sunxi/headsmp.S |  1 +
> >  arch/arm/mach-sunxi/sunxi.c   | 20 +++++++++++++++++++-
> >  2 files changed, 20 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-sunxi/headsmp.S b/arch/arm/mach-sunxi/headsmp.S
> > index 37dc772701f3..32d76be98541 100644
> > --- a/arch/arm/mach-sunxi/headsmp.S
> > +++ b/arch/arm/mach-sunxi/headsmp.S
> > @@ -71,6 +71,7 @@ ENDPROC(sunxi_mc_smp_cluster_cache_enable)
> >  
> >  ENTRY(sunxi_mc_smp_secondary_startup)
> >  	bl	sunxi_mc_smp_cluster_cache_enable
> > +	bl	secure_cntvoff_init
> >  	b	secondary_startup
> >  ENDPROC(sunxi_mc_smp_secondary_startup)
> >  
> > diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
> > index 5e9602ce1573..2770a31a9278 100644
> > --- a/arch/arm/mach-sunxi/sunxi.c
> > +++ b/arch/arm/mach-sunxi/sunxi.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/platform_device.h>
> >  
> >  #include <asm/mach/arch.h>
> > +#include <asm/secure_cntvoff.h>
> >  
> >  static const char * const sunxi_board_dt_compat[] = {
> >  	"allwinner,sun4i-a10",
> > @@ -62,7 +63,6 @@ MACHINE_END
> >  static const char * const sun8i_board_dt_compat[] = {
> >  	"allwinner,sun8i-a23",
> >  	"allwinner,sun8i-a33",
> > -	"allwinner,sun8i-a83t",
> >  	"allwinner,sun8i-h2-plus",
> >  	"allwinner,sun8i-h3",
> >  	"allwinner,sun8i-r40",
> > @@ -75,6 +75,24 @@ DT_MACHINE_START(SUN8I_DT, "Allwinner sun8i Family")
> >  	.dt_compat	= sun8i_board_dt_compat,
> >  MACHINE_END
> >  
> > +void __init sun8i_a83t_cntvoff_init(void)
> > +{
> > +#ifdef CONFIG_SMP
> > +	secure_cntvoff_init();
> > +#endif
> > +}
> > +
> > +static const char * const sun8i_a83t_cntvoff_board_dt_compat[] = {
> > +	"allwinner,sun8i-a83t",
> > +	NULL,
> > +};
> > +
> > +DT_MACHINE_START(SUN8I_CNTVOFF_DT, "Allwinner sun8i-a83t board")  
> 
> I put my Acked-by on the condition that you would fix this. And you
> still didn't.

Grrr, stupid me.
I modified the names of functions but I forgot the machine. Sorry
about that.

Best regards,

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
