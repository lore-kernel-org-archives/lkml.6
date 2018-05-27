Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032584AbeE0DBP (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 23:01:15 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:58716 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032539AbeE0DBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 23:01:14 -0400
Date: Sun, 27 May 2018 13:01:11 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Guenter Roeck <linux@roeck-us.net>
cc: Joshua Thompson <funaho@jurai.org>, Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] m68k: set dma and coherent masks for Macintosh SONIC
 based ethernet
In-Reply-To: <1527378785-13326-1-git-send-email-linux@roeck-us.net>
Message-ID: <alpine.LNX.2.21.1805271212480.9@nippy.intranet>
References: <1527378785-13326-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 May 2018, Guenter Roeck wrote:

> As of commit 205e1b7f51e4 ("dma-mapping: warn when there is no
> coherent_dma_mask") the NatSemi SONIC Ethernet driver is issuing the
> following warning on driver initialization on Macintosh q800 systems.
> 
> SONIC ethernet @50f0a000, MAC 08:00:07:12:34:56, IRQ 3
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at ./include/linux/dma-mapping.h:516 macsonic_init+0x6a/0x15a
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper Not tainted 4.17.0-rc6-mac-00286-g527f47c #1
> Stack from 0781fdd8:
>         0781fdd8 003615b3 000181ba 000005c4 07a24cbc 00000000 00000000 000020e8
> 	07a24800 002c196c 0001824e 00334c06 00000204 001f782a 00000009 00000000
> 	00000000 003358d9 001f782a 00334c06 00000204 00000003 00000000 07a24800
> 	002b5cb6 000372ec 001f8b1a 07a24800 00359203 50f0a000 07a14a48 00000003
> 	00000000 07845c0a 0039dcca 003c835c 003c835c 0035b924 001c19de 07845c00
> 	07845c0a 0039dcca 001c06dc 07845c0a 0781fed8 00000007 0054d040 07845c0a
> Call Trace: [<000181ba>] __warn+0xc0/0xc2
>  [<000020e8>] do_one_initcall+0x0/0x140
>  [<0001824e>] warn_slowpath_null+0x26/0x2c
>  [<001f782a>] macsonic_init+0x6a/0x15a
>  [<001f782a>] macsonic_init+0x6a/0x15a
>  [<002b5cb6>] memcmp+0x0/0x2a
>  [<000372ec>] printk+0x0/0x18
>  [<001f8b1a>] mac_sonic_platform_probe+0x380/0x404
> 
> As per the warning the coherent_dma_mask is not set on this device.
> There is nothing special about the DMA memory coherency on this hardware
> so we can just set the mask to 32bits in the platform data for the FEC
> ethernet devices.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Finn Thain <fthain@telegraphics.com.au>

Geert, assuming that Guenter's patch is acceptable, would you also accept 
a similar patch for the "macmace" platform device?

> ---
> Modeled after f61e64310b75 ("m68k: set dma and coherent masks for platform
> FEC ethernets"). 
> 
> RFC: Is "nothing special about the DMA memory coherency" correect ?
> 

As I understand it, "cache-coherence" is meaningless unless you have 
multiple CPU cores and caches. If there's only one CPU core, its cache 
can't be said to be "coherent" or "non-coherent". Moreover, DMA (direct 
memory access) concerns an IO device and a memory, not a cache, so the 
term "coherent dma" is bogus IMHO.

-- 

>  arch/m68k/mac/config.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
> index 0c3275aa0197..8e0476daddb8 100644
> --- a/arch/m68k/mac/config.c
> +++ b/arch/m68k/mac/config.c
> @@ -17,6 +17,7 @@
>  #include <linux/tty.h>
>  #include <linux/console.h>
>  #include <linux/interrupt.h>
> +#include <linux/dma-mapping.h>
>  /* keyb */
>  #include <linux/random.h>
>  #include <linux/delay.h>
> @@ -971,6 +972,15 @@ static const struct resource mac_scsi_ccl_rsrc[] __initconst = {
>  	},
>  };
>  
> +static struct platform_device macsonic_dev = {
> +	.name           = "macsonic",
> +	.id             = -1,
> +	.dev            = {
> +		.dma_mask = &macsonic_dev.dev.coherent_dma_mask,
> +		.coherent_dma_mask = DMA_BIT_MASK(32),
> +	},
> +};
> +
>  int __init mac_platform_init(void)
>  {
>  	u8 *swim_base;
> @@ -1088,7 +1098,7 @@ int __init mac_platform_init(void)
>  
>  	if (macintosh_config->ether_type == MAC_ETHER_SONIC ||
>  	    macintosh_config->expansion_type == MAC_EXP_PDS_COMM)
> -		platform_device_register_simple("macsonic", -1, NULL, 0);
> +		platform_device_register(&macsonic_dev);
>  
>  	if (macintosh_config->expansion_type == MAC_EXP_PDS ||
>  	    macintosh_config->expansion_type == MAC_EXP_PDS_COMM)
> -- 
> 2.7.4
> 
