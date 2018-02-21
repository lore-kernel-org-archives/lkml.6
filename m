Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeBUD0Z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 22:26:25 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:43487 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbeBUD0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 22:26:24 -0500
X-Google-Smtp-Source: AH8x225ji07hhB5/c0LlJ1Hmtm+0TjwC8mhlRScv5SR3Z19I1pDiia4w/D59cSEnmQw/NBS32UxY7Q==
Date: Tue, 20 Feb 2018 22:26:22 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
cc: Andi Kleen <ak@linux.intel.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] ARM: fix __inflate_kernel_data stack warning for
 LTO
In-Reply-To: <20180220215954.4092811-6-arnd@arndb.de>
Message-ID: <nycvar.YSQ.7.76.1802202218240.31644@knanqh.ubzr>
References: <20180220215954.4092811-1-arnd@arndb.de> <20180220215954.4092811-6-arnd@arndb.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2018, Arnd Bergmann wrote:

> Commit ca8b5d97d6bf ("ARM: XIP kernel: store .data compressed in ROM")
> moved the decompressor workspace to the stack and added a compiler
> flag to avoid the stack size warning.
> 
> With LTO, that warning comes back. Moving the workspace into an initdata
> variable avoids that warning but presumably also undoes the optimization.

Not only that, but it will probably crash at run time. What this code 
does is uncompressing initialized data to memory, _including_ initdata. 
So you'll end up overwriting your inflate_state while decompressing.

> We could also try disabling the warning locally in that file with
> _Pragma("GCC disagnostic"), but we lack a little bit of infrastructure
> to do that nicely.

Your patch #1/7 showed issues with the final part of this feature 
anyway, so my suggestion for that patch will take care of this one too 
for the time being.

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/kernel/Makefile            | 3 ---
>  arch/arm/kernel/head-inflate-data.c | 3 ++-
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> index b59ac4bf82b8..2e8d40d442a2 100644
> --- a/arch/arm/kernel/Makefile
> +++ b/arch/arm/kernel/Makefile
> @@ -88,9 +88,6 @@ head-y			:= head$(MMUEXT).o
>  obj-$(CONFIG_DEBUG_LL)	+= debug.o
>  obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
>  
> -# This is executed very early using a temporary stack when no memory allocator
> -# nor global data is available. Everything has to be allocated on the stack.
> -CFLAGS_head-inflate-data.o := $(call cc-option,-Wframe-larger-than=10240)
>  obj-$(CONFIG_XIP_DEFLATED_DATA) += head-inflate-data.o
>  
>  obj-$(CONFIG_ARM_VIRT_EXT)	+= hyp-stub.o
> diff --git a/arch/arm/kernel/head-inflate-data.c b/arch/arm/kernel/head-inflate-data.c
> index 6dd0ce5e6058..b208c4541bd1 100644
> --- a/arch/arm/kernel/head-inflate-data.c
> +++ b/arch/arm/kernel/head-inflate-data.c
> @@ -35,10 +35,11 @@ extern char _sdata[];
>   * stack then there is no need to clean up before returning.
>   */
>  
> +static __initdata struct inflate_state state;
> +
>  int __init __inflate_kernel_data(void)
>  {
>  	struct z_stream_s stream, *strm = &stream;
> -	struct inflate_state state;
>  	char *in = __data_loc;
>  	int rc;
>  
> -- 
> 2.9.0
> 
> 
