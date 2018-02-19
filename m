Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753154AbeBSQZY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 11:25:24 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39700 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752775AbeBSQZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 11:25:23 -0500
Subject: Re: [PATCH v3 1/3] Kconfig : Remove HAS_IOMEM dependency for Graphics
 support
To: Farhan Ali <alifm@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: geert@linux-m68k.org, borntraeger@de.ibm.com, tomi.valkeinen@ti.com,
        b.zolnierkie@samsung.com
References: <cover.1519053920.git.alifm@linux.vnet.ibm.com>
 <2beec7645bac82e7bdef4f6df0b9f4fe28696575.1519053920.git.alifm@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cce8b082-c780-3559-4491-c39eb09482b0@redhat.com>
Date: Mon, 19 Feb 2018 17:25:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2beec7645bac82e7bdef4f6df0b9f4fe28696575.1519053920.git.alifm@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.02.2018 16:47, Farhan Ali wrote:
> The 'commit e25df1205f37 ("[S390] Kconfig: menus with depends on HAS_IOMEM.")'
> added the HAS_IOMEM dependecy for "Graphics support". This disabled the
> "Graphics support" menu for S390. But if we enable VT layer for S390,
> we would also need to enable the dummy console. So let's remove the
> HAS_IOMEM dependency.
> 
> Move this dependency to sub menu items and console drivers that use
> io memory.
> 
> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
> ---
>  drivers/video/Kconfig         | 21 +++++++++++----------
>  drivers/video/console/Kconfig |  4 ++--
>  2 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 3c20af9..8f10915 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -3,7 +3,6 @@
>  #
>  
>  menu "Graphics support"
> -	depends on HAS_IOMEM
>  
>  config HAVE_FB_ATMEL
>  	bool
> @@ -11,20 +10,22 @@ config HAVE_FB_ATMEL
>  config SH_LCD_MIPI_DSI
>  	bool
>  
> -source "drivers/char/agp/Kconfig"
> +if HAS_IOMEM
> +	source "drivers/char/agp/Kconfig"
>  
> -source "drivers/gpu/vga/Kconfig"
> +	source "drivers/gpu/vga/Kconfig"
>  
> -source "drivers/gpu/host1x/Kconfig"
> -source "drivers/gpu/ipu-v3/Kconfig"
> +	source "drivers/gpu/host1x/Kconfig"
> +	source "drivers/gpu/ipu-v3/Kconfig"
>  
> -source "drivers/gpu/drm/Kconfig"
> +	source "drivers/gpu/drm/Kconfig"
>  
> -menu "Frame buffer Devices"
> -source "drivers/video/fbdev/Kconfig"
> -endmenu
> +	menu "Frame buffer Devices"
> +	source "drivers/video/fbdev/Kconfig"
> +	endmenu
>  
> -source "drivers/video/backlight/Kconfig"
> +        source "drivers/video/backlight/Kconfig"
> +endif
>  
>  config VGASTATE
>         tristate
> diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
> index 7f1f1fb..0023b16 100644
> --- a/drivers/video/console/Kconfig
> +++ b/drivers/video/console/Kconfig
> @@ -85,7 +85,7 @@ config MDA_CONSOLE
>  
>  config SGI_NEWPORT_CONSOLE
>          tristate "SGI Newport Console support"
> -        depends on SGI_IP22 
> +        depends on SGI_IP22 && HAS_IOMEM
>          select FONT_SUPPORT
>          help
>            Say Y here if you want the console on the Newport aka XL graphics
> @@ -153,7 +153,7 @@ config FRAMEBUFFER_CONSOLE_ROTATION
>  
>  config STI_CONSOLE
>          bool "STI text console"
> -        depends on PARISC
> +        depends on PARISC && HAS_IOMEM
>          select FONT_SUPPORT
>          default y
>          help
> 

Maybe config VGA_CONSOLE should depend on HAS_IOMEM, too? I think you
can hardly use a VGA card without IOMEM, can you?
Anyway, this approach now looks reasonable to me, so either way, feel
free to add my:

Reviewed-by: Thomas Huth <thuth@redhat.com>
