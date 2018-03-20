Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751656AbeCTXbA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 19:31:00 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:36280 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751343AbeCTXa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 19:30:58 -0400
Date: Tue, 20 Mar 2018 23:30:46 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Stefan Agner <stefan@agner.ch>
Cc: ard.biesheuvel@linaro.org, arnd@arndb.de, nicolas.pitre@linaro.org,
        marc.zyngier@arm.com, behanw@converseincode.com, keescook@chromium.org,
        Bernhard.Rosenkranzer@linaro.org, mka@chromium.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] bus: arm-cci: use asm unreachable
Message-ID: <20180320233046.GL2743@n2100.armlinux.org.uk>
References: <20180320230206.25289-1-stefan@agner.ch>
 <20180320230206.25289-2-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320230206.25289-2-stefan@agner.ch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 12:02:02AM +0100, Stefan Agner wrote:
> Mixing asm and C code is not recommended in a naked function by
> gcc and leads to an error when using clang:
>   drivers/bus/arm-cci.c:2107:2: error: non-ASM statement in naked
>   function is not supported
>         unreachable();
>         ^
> 
> Instead of using the unreachable() macro use the assember variant
> ASM_UNREACHABLE.  This will no longer emit __builtin_unreachable(),
> but since the function is naked and its return type is void it seems
> not to have aversive effects.

I think that unreachable() there is rather silly - this function
*does* return, and the comments say as much.  Just delete the silly
"unreachable()", there's no need to put an ASM_UNREACHABLE in there.

The function is not declared as not returning, and nothing in this
file uses it anyway - it's called from the mcpm code, which also
_does_ expect this function to return (if it doesn't, then we're
basically saying the CPU that called it is dead.)

> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/bus/arm-cci.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> index 5426c04fe24b..ee9da86fec47 100644
> --- a/drivers/bus/arm-cci.c
> +++ b/drivers/bus/arm-cci.c
> @@ -2084,6 +2084,7 @@ asmlinkage void __naked cci_enable_port_for_self(void)
>  
>  "	mov	r0, #0 \n"
>  "	bx	lr \n"
> +	ASM_UNREACHABLE
>  
>  "	.align	2 \n"
>  "5:	.word	cpu_port - . \n"
> @@ -2103,8 +2104,6 @@ asmlinkage void __naked cci_enable_port_for_self(void)
>  	[sizeof_struct_cpu_port] "i" (sizeof(struct cpu_port)),
>  	[sizeof_struct_ace_port] "i" (sizeof(struct cci_ace_port)),
>  	[offsetof_port_phys] "i" (offsetof(struct cci_ace_port, phys)) );
> -
> -	unreachable();
>  }
>  
>  /**
> -- 
> 2.16.2
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
