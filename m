Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752569AbeBUIoy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 03:44:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45416 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752442AbeBUIow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 03:44:52 -0500
Subject: Re: [PATCH v3 1/3] Kconfig : Remove HAS_IOMEM dependency for Graphics
 support
To: Farhan Ali <alifm@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: geert@linux-m68k.org, tomi.valkeinen@ti.com, thuth@redhat.com,
        b.zolnierkie@samsung.com
References: <cover.1519053920.git.alifm@linux.vnet.ibm.com>
 <2beec7645bac82e7bdef4f6df0b9f4fe28696575.1519053920.git.alifm@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 21 Feb 2018 09:44:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2beec7645bac82e7bdef4f6df0b9f4fe28696575.1519053920.git.alifm@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18022108-0008-0000-0000-000004D29CA6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022108-0009-0000-0000-00001E65A34B
Message-Id: <f9ac0bc2-6c36-748a-9d71-44b6481ff261@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-21_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802210106
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/19/2018 04:47 PM, Farhan Ali wrote:
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

This patch is part of todays linux-next and so far no fallout was reported.
Shall I take that patch via the s390kvm tree (then I would like to have
an ack. Bart?) or is anybody on cc willing to take this?

Christian



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
