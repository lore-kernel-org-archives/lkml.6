Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752387AbeDPP7M (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 11:59:12 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:42074 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750946AbeDPP7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 11:59:11 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Apr 2018 17:59:10 +0200
From: Stefan Agner <stefan@agner.ch>
To: arnd@arndb.de
Cc: robin.murphy@arm.com, nicolas.pitre@linaro.org, marc.zyngier@arm.com,
        behanw@converseincode.com, keescook@chromium.org,
        Bernhard.Rosenkranzer@linaro.org, mka@chromium.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, ard.biesheuvel@linaro.org
Subject: Re: [PATCH v2 1/6] bus: arm-cci: use asm unreachable
In-Reply-To: <20180325180959.28008-2-stefan@agner.ch>
References: <20180325180959.28008-1-stefan@agner.ch>
 <20180325180959.28008-2-stefan@agner.ch>
Message-ID: <e8746b1e0c9e5ff3f0c392a42aa533b8@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.03.2018 20:09, Stefan Agner wrote:
> Mixing asm and C code is not recommended in a naked function by
> gcc and leads to an error when using clang:
>   drivers/bus/arm-cci.c:2107:2: error: non-ASM statement in naked
>   function is not supported
>         unreachable();
>         ^
> 
> While the function is marked __naked it actually properly return
> in asm. There is no need for the unreachable() call.

Hi Arnd,

I think previously changes to this driver went through one of your
trees, can you pick this up?

--
Stefan


> 
> Suggested-by: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Changes in v2:
> - Don't add assembly ASM_UNREACHABLE, just drop unreachable()
> 
>  drivers/bus/arm-cci.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> index 5426c04fe24b..fc2da3a617ac 100644
> --- a/drivers/bus/arm-cci.c
> +++ b/drivers/bus/arm-cci.c
> @@ -2103,8 +2103,6 @@ asmlinkage void __naked cci_enable_port_for_self(void)
>  	[sizeof_struct_cpu_port] "i" (sizeof(struct cpu_port)),
>  	[sizeof_struct_ace_port] "i" (sizeof(struct cci_ace_port)),
>  	[offsetof_port_phys] "i" (offsetof(struct cci_ace_port, phys)) );
> -
> -	unreachable();
>  }
>  
>  /**
