Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932783AbeCJAHf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 19:07:35 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38090 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751325AbeCJAHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 19:07:32 -0500
X-Google-Smtp-Source: AG47ELvhyCgRQlNqvTOqb2O2gR8maAsKAhgc1wVR+BnKTeLxS3TSAnNZP4EqyY7z8E4m4jwzN3LYXw==
From: Eugeniu Rosca <roscaeugeniu@gmail.com>
X-Google-Original-From: Eugeniu Rosca <erosca@de.adit-jv.com>
Date: Sat, 10 Mar 2018 01:07:27 +0100
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Petr Vorel <petr.vorel@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kconfig: make unmet dependency warnings readable
Message-ID: <20180310000727.GA8881@example.com>
References: <1520333499-31854-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520333499-31854-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

Thanks for constantly improving the user experience of Kconfig.
Just one small remark below.

On Tue, Mar 06, 2018 at 07:51:39PM +0900, Masahiro Yamada wrote:
> Currently, the unmet dependency warnings end up with endlessly long
> expressions, most of which are false positives.
> 
> Here is test code to demonstrate how it currently works.
> 
> [Test Case]
> 
>   config DEP1
>           def_bool y
> 
>   config DEP2
>           def_bool n
> 
>   config A
>           bool "A"
>           select E
> 
>   config B
>           bool "B"
>           depends on DEP2
>           select E
> 
>   config C
>           bool "C"
>           depends on DEP1 && DEP2
>           select E
> 
>   config D
>           def_bool n
> 	  select E
> 
>   config E
>           bool
>           depends on DEP1 && DEP2
> 
> [Result]
> 
>   $ make allyesconfig
>   scripts/kconfig/conf  --allyesconfig Kconfig
>   warning: (A && B && D) selects E which has unmet direct
>   dependencies (DEP1 && DEP2)
> 
> Here, I see some points to be improved.
> 
> First, '(A || B || D)' would make more sense than '(A && B && D)'.
> I am not sure if this is intentional, but expr_simplify_unmet_dep()
> turns OR expressions into AND, like follows:
> 
>         case E_OR:
>                 return expr_alloc_and(
> 
> Second, we see false positives.  'A' is a real unmet dependency.
> 'B' is false positive because 'DEP1' is fixed to 'y', and 'B' depends
> on 'DEP2'.  'C' was correctly dropped by expr_simplify_unmet_dep().
> 'D' is also false positive because it has no chance to be enabled.
> Current expr_simplify_unmet_dep() cannot avoid those false positives.
> 
> After all, I decided to use the same helpers as used for printing
> reverse dependencies in the help.
> 
> With this commit, unreadable warnings in the real world:
> 
> $ make ARCH=score allyesconfig
> scripts/kconfig/conf  --allyesconfig Kconfig
> warning: (HWSPINLOCK_QCOM && AHCI_MTK && STMMAC_PLATFORM && DWMAC_IPQ806X
> && DWMAC_LPC18XX && DWMAC_OXNAS && DWMAC_ROCKCHIP && DWMAC_SOCFPGA && DWMA
> C_STI && TI_CPSW && PINCTRL_GEMINI && PINCTRL_OXNAS && PINCTRL_ROCKCHIP &&
>  PINCTRL_DOVE && PINCTRL_ARMADA_37XX && PINCTRL_STM32 && S3C2410_WATCHDOG
> && VIDEO_OMAP3 && VIDEO_S5P_FIMC && USB_XHCI_MTK && RTC_DRV_AT91SAM9 && LP
> C18XX_DMAMUX && VIDEO_OMAP4 && COMMON_CLK_GEMINI && COMMON_CLK_ASPEED && C
> OMMON_CLK_NXP && COMMON_CLK_OXNAS && COMMON_CLK_BOSTON && ATMEL_ST && QCOM
> _ADSP_PIL && QCOM_Q6V5_PIL && QCOM_GSBI && ATMEL_EBI && ST_IRQCHIP && RESE
> T_IMX7 && PHY_HI6220_USB && PHY_RALINK_USB && PHY_ROCKCHIP_PCIE && PHY_DA8
> XX_USB) selects MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)
> warning: (PINCTRL_AT91 && PINCTRL_AT91PIO4 && PINCTRL_OXNAS && PINCTRL_PIS
> TACHIO && PINCTRL_PIC32 && PINCTRL_MESON && PINCTRL_NOMADIK && PINCTRL_MTK
>  && PINCTRL_MT7622 && GPIO_TB10X) selects OF_GPIO which has unmet direct d
> ependencies (GPIOLIB && OF && HAS_IOMEM)
> warning: (FAULT_INJECTION_STACKTRACE_FILTER && LATENCYTOP && LOCKDEP) sele
> cts FRAME_POINTER which has unmet direct dependencies (DEBUG_KERNEL && (CR
> IS || M68K || FRV || UML || SUPERH || BLACKFIN || MN10300 || METAG) || ARC
> H_WANT_FRAME_POINTERS)
> 
> will be turned into:
> 
> $ make ARCH=score allyesconfig
> scripts/kconfig/conf  --allyesconfig Kconfig
> 
> WARNING:
>  Unmet direct dependencies detected for MFD_SYSCON
>  Depends on:
>     HAS_IOMEM [=n]
>  Selected by [y]:
>   - PINCTRL_STM32 [=y] && PINCTRL [=y] && (ARCH_STM32 || COMPILE_TEST [=y])
> && OF [=y]
>   - RTC_DRV_AT91SAM9 [=y] && RTC_CLASS [=y] && (ARCH_AT91 || COMPILE_TEST
> [=y])
>   - ATMEL_ST [=y] && GENERIC_CLOCKEVENTS [=y]
>   - RESET_IMX7 [=y] && RESET_CONTROLLER [=y]
>   - PHY_HI6220_USB [=y] && (ARCH_HISI && ARM64 || COMPILE_TEST [=y])
>   - PHY_RALINK_USB [=y] && (RALINK || COMPILE_TEST [=y])
>   - PHY_ROCKCHIP_PCIE [=y] && (ARCH_ROCKCHIP && OF [=y] || COMPILE_TEST
> [=y])
> 
> WARNING:
>  Unmet direct dependencies detected for OF_GPIO
>  Depends on:
>     GPIOLIB [=y] && OF [=y] && HAS_IOMEM [=n]
>  Selected by [y]:
>   - PINCTRL_MTK [=y] && PINCTRL [=y] && (ARCH_MEDIATEK || COMPILE_TEST
> [=y]) && OF [=y]
>   - PINCTRL_MT7622 [=y] && PINCTRL [=y] && (ARCH_MEDIATEK || COMPILE_TEST
> [=y]) && OF [=y] && (ARM64 || COMPILE_TEST [=y])
> 
> WARNING:
>  Unmet direct dependencies detected for FRAME_POINTER
>  Depends on:
>     DEBUG_KERNEL [=y] && (CRIS || M68K || FRV || UML || SUPERH || BLACKFIN
>  || MN10300 || METAG) || ARCH_WANT_FRAME_POINTERS [=n]
>  Selected by [y]:
>   - LATENCYTOP [=y] && DEBUG_KERNEL [=y] && STACKTRACE_SUPPORT [=y] &&
> PROC_FS [=y] && !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM_UNWIND &&
> !ARC && !X86
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>   - update test case
> 
>  scripts/kconfig/expr.c   | 29 -----------------------------
>  scripts/kconfig/expr.h   |  1 -
>  scripts/kconfig/symbol.c | 33 +++++++++++++++++++++------------
>  3 files changed, 21 insertions(+), 42 deletions(-)
> 
> diff --git a/scripts/kconfig/expr.c b/scripts/kconfig/expr.c
> index 49376e1..235e179 100644
> --- a/scripts/kconfig/expr.c
> +++ b/scripts/kconfig/expr.c
> @@ -1150,35 +1150,6 @@ expr_get_leftmost_symbol(const struct expr *e)
>  	return expr_copy(e);
>  }
>  
> -/*
> - * Given expression `e1' and `e2', returns the leaf of the longest
> - * sub-expression of `e1' not containing 'e2.
> - */
> -struct expr *expr_simplify_unmet_dep(struct expr *e1, struct expr *e2)
> -{
> -	struct expr *ret;
> -
> -	switch (e1->type) {
> -	case E_OR:
> -		return expr_alloc_and(
> -		    expr_simplify_unmet_dep(e1->left.expr, e2),
> -		    expr_simplify_unmet_dep(e1->right.expr, e2));
> -	case E_AND: {
> -		struct expr *e;
> -		e = expr_alloc_and(expr_copy(e1), expr_copy(e2));
> -		e = expr_eliminate_dups(e);
> -		ret = (!expr_eq(e, e1)) ? e1 : NULL;
> -		expr_free(e);
> -		break;
> -		}
> -	default:
> -		ret = e1;
> -		break;
> -	}
> -
> -	return expr_get_leftmost_symbol(ret);

It looks like expr_get_leftmost_symbol() has no more callers left and
could be removed with this patch?

Thanks,
Eugeniu.
