Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754712AbeCGSbC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 13:31:02 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41682 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753949AbeCGSbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 13:31:01 -0500
X-Google-Smtp-Source: AG47ELsSD7xzP+7ASUwKEBtjIyLld9EWgOPFuTHx8LPXi6THa7gA+ZUTed8rhHSJOcRKoh7jw9IIHQ==
Date: Wed, 7 Mar 2018 10:30:59 -0800
From: Matthias Kaehlcke <mka@chromium.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] ARM: LTO: avoid THUMB2_KERNEL+LTO
Message-ID: <20180307183059.GA57047@google.com>
References: <20180220215954.4092811-1-arnd@arndb.de>
 <20180220215954.4092811-3-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180220215954.4092811-3-arnd@arndb.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, Feb 20, 2018 at 10:59:49PM +0100 Arnd Bergmann ha dit:

> Trying to build an LTO-Enabled kernel with Thumb2 instructions failed
> horribly for me, with an endless output of things like
> 
> ccVnNycO.s:2665: Error: thumb conditional instruction should be in IT block -- `bxne lr'
> ccVnNycO.s:7128: Error: thumb conditional instruction should be in IT block -- `strexeq r5,r2,[r3]'
> ccVnNycO.s:7258: Error: thumb conditional instruction should be in IT block -- `strexeq lr,r0,[r3]'
> ccVnNycO.s:17380: Error: thumb conditional instruction should be in IT block -- `strexeq r1,r2,[r6]'
> ccVnNycO.s:19163: Error: thumb conditional instruction should be in IT block -- `strexeq r8,r6,[r3]'
> ccVnNycO.s:22722: Error: thumb conditional instruction should be in IT block -- `strexeq r7,r1,[r0]'
> ccVnNycO.s:24105: conditional infixes are deprecated in unified syntax
> ccVnNycO.s:24105: Error: thumb conditional instruction should be in IT block -- `sbcccs r1,r1,r3'
> ccVnNycO.s:24105: Error: thumb conditional instruction should be in IT block -- `movcc r3,#0'
> ccVnNycO.s:24210: conditional infixes are deprecated in unified syntax
> ccVnNycO.s:24210: Error: thumb conditional instruction should be in IT block -- `sbcccs r2,r2,r3'
> ccVnNycO.s:24210: Error: thumb conditional instruction should be in IT block -- `movcc r3,#0'

For the record:

The errors about sbcccs and movcc probably stem from here:

/* We use 33-bit arithmetic here... */
#define __range_ok(addr, size) ({ \
        unsigned long flag, roksum; \
        __chk_user_ptr(addr);   \
        __asm__("adds %1, %2, %3; sbcccs %1, %1, %0; movcc %0, #0" \
                : "=&r" (flag), "=&r" (roksum) \
                : "r" (addr), "Ir" (size), "0" (current_thread_info()->addr_limit) \
                : "cc"); \
        flag; })

arch/arm/include/asm/uaccess.h

I stumbled across this when trying to build a 32-bit ARM kernel with
clang. This post has some more information:

https://lists.linuxfoundation.org/pipermail/llvmlinux/2012-November/000073.html

"This is a problem with the above Linux inline ASM code, not with Clang,
nor with gas. It appears the new "Unified syntax" for ARM ASM code now
used by gas doesn't allow the use of conditional infixes anymore (the CC
part)."

Unfortunately I'm probably not fluent enough with ARM inline assembly
to come up with a good alternative.

Matthias

> I did not investigate this too much, disabling Thumb2 support when LTO is
> set lets me build randconfig kernels.
> 
> Since ARM_SINGLE_ARMV7M is Thumb2-only, I have to disallow LTO for V7-M
> targets.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 8ed0f664f86f..fbf2c3ab9a97 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -18,7 +18,7 @@ config ARM
>  	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
>  	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT if CPU_V7
>  	select ARCH_SUPPORTS_ATOMIC_RMW
> -	select ARCH_SUPPORTS_LTO
> +	select ARCH_SUPPORTS_LTO if !ARM_SINGLE_ARMV7M
>  	select ARCH_USE_BUILTIN_BSWAP
>  	select ARCH_USE_CMPXCHG_LOCKREF
>  	select ARCH_WANT_IPC_PARSE_VERSION
> @@ -1533,6 +1533,7 @@ config SCHED_HRTICK
>  config THUMB2_KERNEL
>  	bool "Compile the kernel in Thumb-2 mode" if !CPU_THUMBONLY
>  	depends on (CPU_V7 || CPU_V7M) && !CPU_V6 && !CPU_V6K
> +	depends on !LTO
>  	default y if CPU_THUMBONLY
>  	select ARM_UNWIND
>  	help
