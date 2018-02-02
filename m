Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752019AbeBBQjh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 11:39:37 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37601 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751718AbeBBQj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 11:39:28 -0500
X-Google-Smtp-Source: AH8x227BV4E4S9wY7ClikoZcyptJR5nfT+NBp0//HjQbAmMMPCFnuldrHsoycz+rYSeDk6TtRFvIXQ==
Date: Fri, 2 Feb 2018 11:39:26 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
cc: Russell King <linux@armlinux.org.uk>, Andi Kleen <ak@linux.intel.com>,
        Richard Earnshaw <rearnsha@gcc.gnu.org>,
        Tamar Christina <tnfchris@gcc.gnu.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: xscale: fix gcc-8 build
In-Reply-To: <20180202150756.420422-2-arnd@arndb.de>
Message-ID: <nycvar.YSQ.7.76.1802021138460.1842@knanqh.ubzr>
References: <20180202150756.420422-1-arnd@arndb.de> <20180202150756.420422-2-arnd@arndb.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Feb 2018, Arnd Bergmann wrote:

> We use a hack in xscale-cp0.c to allow building it for ARMv4 while
> also using ARMv5TE and iWMMXt specific inline assembly, by
> adding a top-level asm statement.
> 
> Unfortunately that hack no longer works with gcc-8, since it will
> revert back to the normal architecture. The recommended way of
> handling this is to use __attribute__((target("armv5te"))) on the
> functions that need it, or #pragma GCC target("arch=armv5te").
> Either of those work with gcc-8, but not earlier versions, and
> it seems worse to combine that with the old hack.
> 
> Instead, this adds the .arch statement to each inline assembler
> statement that needs it individually. That is also slightly uglier
> than the previous hack, but it works with all compiler versions
> and documents better why we need the override in the first place.
> 
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84129
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Nicolas Pitre <nico@linaro.org>


> ---
>  arch/arm/kernel/xscale-cp0.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/kernel/xscale-cp0.c b/arch/arm/kernel/xscale-cp0.c
> index 77a2eef72115..e06a2f6dac4f 100644
> --- a/arch/arm/kernel/xscale-cp0.c
> +++ b/arch/arm/kernel/xscale-cp0.c
> @@ -17,11 +17,10 @@
>  #include <asm/thread_notify.h>
>  #include <asm/cputype.h>
>  
> -asm("	.arch armv5te\n");
> -
>  static inline void dsp_save_state(u32 *state)
>  {
>  	__asm__ __volatile__ (
> +		".arch	armv5te\n\t"
>  		"mrrc	p0, 0, %0, %1, c0\n"
>  		: "=r" (state[0]), "=r" (state[1]));
>  }
> @@ -29,6 +28,7 @@ static inline void dsp_save_state(u32 *state)
>  static inline void dsp_load_state(u32 *state)
>  {
>  	__asm__ __volatile__ (
> +		".arch	armv5te\n\t"
>  		"mcrr	p0, 0, %0, %1, c0\n"
>  		: : "r" (state[0]), "r" (state[1]));
>  }
> @@ -134,7 +134,8 @@ static int __init cpu_has_iwmmxt(void)
>  	 *	tmrrc	%0, %1, wR0
>  	 */
>  	__asm__ __volatile__ (
> -		"mcrr	p0, 0, %2, %3, c0\n"
> +		".arch	armv5te\n\t"
> +		"mcrr	p0, 0, %2, %3, c0\n\t"
>  		"mrrc	p0, 0, %0, %1, c0\n"
>  		: "=r" (lo), "=r" (hi)
>  		: "r" (0), "r" (0x100));
> -- 
> 2.9.0
> 
> 
