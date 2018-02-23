Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751797AbeBWQRi convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 11:17:38 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37257 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbeBWQRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 11:17:36 -0500
X-Google-Smtp-Source: AH8x2278pGo/5jMJ4ykHx25OnEDedyTZ+2GQR3CX4ttrD7olcFa8hVUWw2s7mYIBdwl6VppmZEka6w==
MIME-Version: 1.0
In-Reply-To: <20180223133742.26044-11-mylene.josserand@bootlin.com>
References: <20180223133742.26044-1-mylene.josserand@bootlin.com> <20180223133742.26044-11-mylene.josserand@bootlin.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Sat, 24 Feb 2018 00:17:13 +0800
X-Gmail-Original-Message-ID: <CAGb2v67SuK9Xr7_dVb7RVGXUJwYRKnTiJwDrOJ-Su5CXmm7HXA@mail.gmail.com>
Message-ID: <CAGb2v67SuK9Xr7_dVb7RVGXUJwYRKnTiJwDrOJ-Su5CXmm7HXA@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] ARM: sunxi: smp: Add initialization of CNTVOFF
To: =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@bootlin.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LABBE Corentin <clabbe.montjoie@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        quentin.schulz@bootlin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 9:37 PM, Mylène Josserand
<mylene.josserand@bootlin.com> wrote:
> On Cortex-A7, the CNTVOFF register from arch timer is uninitialized.
> It should be done by the bootloader but it is currently not the case,
> even for boot CPU because this SoC is booting in secure mode.
> It leads to an random offset value meaning that each CPU will have a
> different time, which isn't working very well.
>
> Add assembly code used for boot CPU and secondary CPU cores to make
> sure that the CNTVOFF register is initialized.
>
> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> ---
>  arch/arm/mach-sunxi/headsmp.S | 21 +++++++++++++++++++++
>  arch/arm/mach-sunxi/sunxi.c   |  4 ++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/arch/arm/mach-sunxi/headsmp.S b/arch/arm/mach-sunxi/headsmp.S
> index d5c97e945e69..605896251927 100644
> --- a/arch/arm/mach-sunxi/headsmp.S
> +++ b/arch/arm/mach-sunxi/headsmp.S
> @@ -65,9 +65,30 @@ ENTRY(sunxi_mc_smp_cluster_cache_enable)
>         first: .word sunxi_mc_smp_first_comer - .
>  ENDPROC(sunxi_mc_smp_cluster_cache_enable)
>
> +ENTRY(sunxi_init_cntvoff)
> +       /*
> +        * CNTVOFF has to be initialized either from non-secure Hypervisor
> +        * mode or secure Monitor mode with SCR.NS==1. If TrustZone is enabled
> +        * then it should be handled by the secure code
> +        */
> +       cps     #MON_MODE
> +       mrc     p15, 0, r1, c1, c1, 0           /* Get Secure Config */
> +       orr     r0, r1, #1
> +       mcr     p15, 0, r0, c1, c1, 0           /* Set Non Secure bit */
> +       instr_sync
> +       mov     r0, #0
> +       mcrr    p15, 4, r0, r0, c14             /* CNTVOFF = 0 */
> +       instr_sync
> +       mcr     p15, 0, r1, c1, c1, 0           /* Set Secure bit */
> +       instr_sync
> +       cps     #SVC_MODE
> +       ret     lr
> +ENDPROC(sunxi_init_cntvoff)

There is no need to move all the assembly into a separate file, just
to add this function. Everything can be inlined as a naked function.
The "instr_sync" macro can be replaced with "isb", which is what it
expands to anyway.

I really want to keep everything self-contained without global symbols,
and in C files if possible.

> +
>  #ifdef CONFIG_SMP
>  ENTRY(sunxi_boot)
>         bl      sunxi_mc_smp_cluster_cache_enable
> +       bl      sunxi_init_cntvoff
>         b       secondary_startup
>  ENDPROC(sunxi_boot)
>
> diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
> index 5e9602ce1573..4bb041492b54 100644
> --- a/arch/arm/mach-sunxi/sunxi.c
> +++ b/arch/arm/mach-sunxi/sunxi.c
> @@ -37,8 +37,12 @@ static const char * const sun6i_board_dt_compat[] = {
>  };
>
>  extern void __init sun6i_reset_init(void);
> +extern void sunxi_init_cntvoff(void);
> +
>  static void __init sun6i_timer_init(void)
>  {
> +       sunxi_init_cntvoff();

You should check the enable-method to see if PSCI is set or not,
as an indicator whether the kernel is booted secure or non-secure.
AFAIK trying to set CNTVOFF under non-secure would be very bad.


Regards
ChenYu

> +
>         of_clk_init(NULL);
>         if (IS_ENABLED(CONFIG_RESET_CONTROLLER))
>                 sun6i_reset_init();
> --
> 2.11.0
>
