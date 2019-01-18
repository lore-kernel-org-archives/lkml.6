Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEA4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601422086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TV2C7/Wd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfARLVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:21:03 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43845 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfARLVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 06:21:03 -0500
Received: by mail-ed1-f65.google.com with SMTP id f9so10820837eds.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 03:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JMG4oj1f5vKZQG5rJv7bL2EEaGeOs6kq6RkpIjSxq+M=;
        b=TV2C7/Wd2U7tdpE6v3ghKxPQzBvPYGEsT6dt3RVj2PaI2el3ChxnbvvM0Io/CASv4o
         +1JACG9X8Osnvjl4C1ZOHvGZRsJL42lSjisyDttjrnRdN2pkqkvUGpUCOh8TOjWNfCgY
         8jAB9XapOBapiRyp1MquaRgqJ9kTMpX3AJJ94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=JMG4oj1f5vKZQG5rJv7bL2EEaGeOs6kq6RkpIjSxq+M=;
        b=VsJSTtwm+Lot6j9Zfr081+ScBBtA9IJACYoXTnn83k3JLDMPwklpPHVfQlX1WmwcdU
         gK2dqIdPzrAbsA6tjLfnhsmnDvy7e67s4aiQ8UfzzWVUP1iSLTycrMG1KiEVLaocExSg
         IfHLIdrN6aitVQaB22qG0bJeTxKcMhMDvJNA8R7EjrSq+ZXfYJjoIdB/W6lc+42ISDSO
         5x3XFCisCgGR/osXqLPjyQtHntLYKi6gaSn/+XZvK84HI0QWqgFwfkOURTITL69ohozj
         jsyXXeZcOdWduM8134DHsCWn3G00OSgd6hN1p2WgYstVN8WeLwerKc6NiBvkkMEO9FzM
         r0Aw==
X-Gm-Message-State: AJcUukdPe269ytsrB+0ezXAuqXuRiLdzB3fjBxk2nOMAF5UT93XC1V+W
        HuXZG1E8WPeTT3Boku85rBr17UWC79Q=
X-Google-Smtp-Source: ALg8bN46zUhDMhXTVN+g7SfE7RT1CIFXzsbVxIC00HHn717a2h88qomuobO3IbQmzOqNJc7l/keeEg==
X-Received: by 2002:a17:906:2d51:: with SMTP id e17-v6mr13555952eji.143.1547810431956;
        Fri, 18 Jan 2019 03:20:31 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id w10sm7032751eda.77.2019.01.18.03.20.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 03:20:30 -0800 (PST)
Date:   Fri, 18 Jan 2019 12:20:28 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnaud Patard <arnaud.patard@rtp-net.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH] staging: xgifb: delete the driver
Message-ID: <20190118112028.GG3271@phenom.ffwll.local>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnaud Patard <arnaud.patard@rtp-net.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20190118100828.GA5143@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118100828.GA5143@kroah.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 11:08:28AM +0100, Greg Kroah-Hartman wrote:
> There has not been any real work done on cleaning this driver up and
> getting it out of the staging tree in years.  Also, no new fb drivers
> are being added to the tree, so it should be converted into a drm driver
> as well.
> 
> Due to the lack of interest in this codebase, just drop it.
> 
> Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
> Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Reported-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  MAINTAINERS                         |    5 -
>  drivers/staging/Kconfig             |    2 -
>  drivers/staging/Makefile            |    1 -
>  drivers/staging/xgifb/Kconfig       |   11 -
>  drivers/staging/xgifb/Makefile      |    4 -
>  drivers/staging/xgifb/TODO          |   16 -
>  drivers/staging/xgifb/XGI_main.h    |  365 --
>  drivers/staging/xgifb/XGI_main_26.c | 2084 ----------
>  drivers/staging/xgifb/XGIfb.h       |  109 -
>  drivers/staging/xgifb/vb_def.h      |  257 --
>  drivers/staging/xgifb/vb_init.c     | 1367 -------
>  drivers/staging/xgifb/vb_init.h     |    6 -
>  drivers/staging/xgifb/vb_setmode.c  | 5528 ---------------------------
>  drivers/staging/xgifb/vb_setmode.h  |   24 -
>  drivers/staging/xgifb/vb_struct.h   |  165 -
>  drivers/staging/xgifb/vb_table.h    | 2513 ------------
>  drivers/staging/xgifb/vb_util.h     |   46 -
>  drivers/staging/xgifb/vgatypes.h    |   51 -
>  18 files changed, 12554 deletions(-)
>  delete mode 100644 drivers/staging/xgifb/Kconfig
>  delete mode 100644 drivers/staging/xgifb/Makefile
>  delete mode 100644 drivers/staging/xgifb/TODO
>  delete mode 100644 drivers/staging/xgifb/XGI_main.h
>  delete mode 100644 drivers/staging/xgifb/XGI_main_26.c
>  delete mode 100644 drivers/staging/xgifb/XGIfb.h
>  delete mode 100644 drivers/staging/xgifb/vb_def.h
>  delete mode 100644 drivers/staging/xgifb/vb_init.c
>  delete mode 100644 drivers/staging/xgifb/vb_init.h
>  delete mode 100644 drivers/staging/xgifb/vb_setmode.c
>  delete mode 100644 drivers/staging/xgifb/vb_setmode.h
>  delete mode 100644 drivers/staging/xgifb/vb_struct.h
>  delete mode 100644 drivers/staging/xgifb/vb_table.h
>  delete mode 100644 drivers/staging/xgifb/vb_util.h
>  delete mode 100644 drivers/staging/xgifb/vgatypes.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4d04cebb4a71..399c36fc4db5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14471,11 +14471,6 @@ L:	linux-wireless@vger.kernel.org
>  S:	Supported
>  F:	drivers/staging/wilc1000/
>  
> -STAGING - XGI Z7,Z9,Z11 PCI DISPLAY DRIVER
> -M:	Arnaud Patard <arnaud.patard@rtp-net.org>
> -S:	Odd Fixes
> -F:	drivers/staging/xgifb/
> -
>  STAGING SUBSYSTEM
>  M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
> diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
> index 46af55acda16..c0901b96cfe4 100644
> --- a/drivers/staging/Kconfig
> +++ b/drivers/staging/Kconfig
> @@ -56,8 +56,6 @@ source "drivers/staging/iio/Kconfig"
>  
>  source "drivers/staging/sm750fb/Kconfig"
>  
> -source "drivers/staging/xgifb/Kconfig"
> -
>  source "drivers/staging/emxx_udc/Kconfig"
>  
>  source "drivers/staging/speakup/Kconfig"
> diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
> index cc5530cc996b..57c6bce13ff4 100644
> --- a/drivers/staging/Makefile
> +++ b/drivers/staging/Makefile
> @@ -20,7 +20,6 @@ obj-$(CONFIG_VT6656)		+= vt6656/
>  obj-$(CONFIG_VME_BUS)		+= vme/
>  obj-$(CONFIG_IIO)		+= iio/
>  obj-$(CONFIG_FB_SM750)		+= sm750fb/
> -obj-$(CONFIG_FB_XGI)		+= xgifb/
>  obj-$(CONFIG_USB_EMXX)		+= emxx_udc/
>  obj-$(CONFIG_SPEAKUP)		+= speakup/
>  obj-$(CONFIG_MFD_NVEC)		+= nvec/
> diff --git a/drivers/staging/xgifb/Kconfig b/drivers/staging/xgifb/Kconfig
> deleted file mode 100644
> index bb0ca5974ea0..000000000000
> --- a/drivers/staging/xgifb/Kconfig
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -config FB_XGI
> -	tristate "XGI display support"
> -	depends on FB && PCI
> -	select FB_CFB_FILLRECT
> -	select FB_CFB_COPYAREA
> -	select FB_CFB_IMAGEBLIT
> -	help
> -	  This driver supports notebooks with XGI Z7,Z9,Z11 PCI chips.
> -	  Say Y if you have such a graphics card.
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called xgifb.ko
> diff --git a/drivers/staging/xgifb/Makefile b/drivers/staging/xgifb/Makefile
> deleted file mode 100644
> index 964a843c4521..000000000000
> --- a/drivers/staging/xgifb/Makefile
> +++ /dev/null
> @@ -1,4 +0,0 @@
> -obj-$(CONFIG_FB_XGI)  += xgifb.o
> -
> -xgifb-y := XGI_main_26.o vb_init.o vb_setmode.o
> -
> diff --git a/drivers/staging/xgifb/TODO b/drivers/staging/xgifb/TODO
> deleted file mode 100644
> index a1e25957bf1b..000000000000
> --- a/drivers/staging/xgifb/TODO
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -This drivers still needs a lot of work. I can list all cleanups to do but it's
> -going to be long. So, I'm writing "cleanups" and not the list.
> -
> -Arnaud
> -
> -TODO:
> -- clean ups
> -- sort out dup ids with SiS driver
> -- remove useless/wrong/unused code...
> -- get rid of non-linux related stuff
> -
> -This needs to become a drm driver, the fbdev subsystem doesn't take new drivers
> -anymore.
> -
> -Please send patches to:
> -Arnaud Patard <arnaud.patard@rtp-net.org>
> diff --git a/drivers/staging/xgifb/XGI_main.h b/drivers/staging/xgifb/XGI_main.h
> deleted file mode 100644
> index e19a8291cb2a..000000000000
> --- a/drivers/staging/xgifb/XGI_main.h
> +++ /dev/null
> @@ -1,365 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _XGIFB_MAIN
> -#define _XGIFB_MAIN
> -/* ------------------- Constant Definitions ------------------------- */
> -#include "XGIfb.h"
> -#include "vb_def.h"
> -
> -#define PCI_DEVICE_ID_XGI_42      0x042
> -#define PCI_DEVICE_ID_XGI_27      0x027
> -
> -static const struct pci_device_id xgifb_pci_table[] = {
> -	{PCI_DEVICE(PCI_VENDOR_ID_XGI, PCI_DEVICE_ID_XGI_20)},
> -	{PCI_DEVICE(PCI_VENDOR_ID_XGI, PCI_DEVICE_ID_XGI_27)},
> -	{PCI_DEVICE(PCI_VENDOR_ID_XGI, PCI_DEVICE_ID_XGI_40)},
> -	{PCI_DEVICE(PCI_VENDOR_ID_XGI, PCI_DEVICE_ID_XGI_42)},
> -	{0}
> -};
> -
> -MODULE_DEVICE_TABLE(pci, xgifb_pci_table);
> -
> -#define IND_XGI_SCRATCH_REG_CR30  0x30  /* CRs */
> -#define IND_XGI_SCRATCH_REG_CR31  0x31
> -#define IND_XGI_SCRATCH_REG_CR32  0x32
> -#define IND_XGI_SCRATCH_REG_CR33  0x33
> -#define IND_XGI_LCD_PANEL         0x36
> -#define IND_XGI_SCRATCH_REG_CR37  0x37
> -
> -#define XGI_DRAM_SIZE_MASK     0xF0  /*SR14 */
> -#define XGI_DRAM_SIZE_1MB      0x00
> -#define XGI_DRAM_SIZE_2MB      0x01
> -#define XGI_DRAM_SIZE_4MB      0x02
> -#define XGI_DRAM_SIZE_8MB      0x03
> -#define XGI_DRAM_SIZE_16MB     0x04
> -#define XGI_DRAM_SIZE_32MB     0x05
> -#define XGI_DRAM_SIZE_64MB     0x06
> -#define XGI_DRAM_SIZE_128MB    0x07
> -#define XGI_DRAM_SIZE_256MB    0x08
> -
> -/* ------------------- Global Variables ----------------------------- */
> -
> -/* display status */
> -static int XGIfb_crt1off;
> -static int XGIfb_forcecrt1 = -1;
> -
> -/* global flags */
> -static int XGIfb_tvmode;
> -static int enable_dstn;
> -static int XGIfb_ypan = -1;
> -
> -/* TW: CRT2 type (for overriding autodetection) */
> -static int XGIfb_crt2type = -1;
> -/* PR: Tv plug type (for overriding autodetection) */
> -static int XGIfb_tvplug = -1;
> -
> -#define MD_XGI315 1
> -
> -/* mode table */
> -static const struct _XGIbios_mode {
> -	u8 mode_no;
> -	u16 vesa_mode_no_1;  /* "XGI defined" VESA mode number */
> -	u16 vesa_mode_no_2;  /* Real VESA mode numbers */
> -	u16 xres;
> -	u16 yres;
> -	u16 bpp;
> -	u8  chipset;
> -} XGIbios_mode[] = {
> -	{ 0x56, 0x0000, 0x0000,  320,  240, 16, MD_XGI315 },
> -	{ 0x5A, 0x0000, 0x0000,  320,  480,  8, MD_XGI315 },
> -	{ 0x5B, 0x0000, 0x0000,  320,  480, 16, MD_XGI315 },
> -	{ 0x2E, 0x0101, 0x0101,  640,  480,  8, MD_XGI315 },
> -	{ 0x44, 0x0111, 0x0111,  640,  480, 16, MD_XGI315 },
> -	{ 0x62, 0x013a, 0x0112,  640,  480, 32, MD_XGI315 },
> -	{ 0x31, 0x0000, 0x0000,  720,  480,  8, MD_XGI315 },
> -	{ 0x33, 0x0000, 0x0000,  720,  480, 16, MD_XGI315 },
> -	{ 0x35, 0x0000, 0x0000,  720,  480, 32, MD_XGI315 },
> -	{ 0x32, 0x0000, 0x0000,  720,  576,  8, MD_XGI315 },
> -	{ 0x34, 0x0000, 0x0000,  720,  576, 16, MD_XGI315 },
> -	{ 0x36, 0x0000, 0x0000,  720,  576, 32, MD_XGI315 },
> -	{ 0x36, 0x0000, 0x0000,  720,  576, 32, MD_XGI315 },
> -	{ 0x70, 0x0000, 0x0000,  800,  480,  8, MD_XGI315 },
> -	{ 0x7a, 0x0000, 0x0000,  800,  480, 16, MD_XGI315 },
> -	{ 0x76, 0x0000, 0x0000,  800,  480, 32, MD_XGI315 },
> -	{ 0x30, 0x0103, 0x0103,  800,  600,  8, MD_XGI315 },
> -#define DEFAULT_MODE              17 /* index for 800x600x16 */
> -	{ 0x47, 0x0114, 0x0114,  800,  600, 16, MD_XGI315 },
> -	{ 0x63, 0x013b, 0x0115,  800,  600, 32, MD_XGI315 },
> -	{ 0x71, 0x0000, 0x0000, 1024,  576,  8, MD_XGI315 },
> -	{ 0x74, 0x0000, 0x0000, 1024,  576, 16, MD_XGI315 },
> -	{ 0x77, 0x0000, 0x0000, 1024,  576, 32, MD_XGI315 },
> -	{ 0x77, 0x0000, 0x0000, 1024,  576, 32, MD_XGI315 },
> -	{ 0x20, 0x0000, 0x0000, 1024,  600,  8, },
> -	{ 0x21, 0x0000, 0x0000, 1024,  600, 16, },
> -	{ 0x22, 0x0000, 0x0000, 1024,  600, 32, },
> -	{ 0x38, 0x0105, 0x0105, 1024,  768,  8, MD_XGI315 },
> -	{ 0x4A, 0x0117, 0x0117, 1024,  768, 16, MD_XGI315 },
> -	{ 0x64, 0x013c, 0x0118, 1024,  768, 32, MD_XGI315 },
> -	{ 0x64, 0x013c, 0x0118, 1024,  768, 32, MD_XGI315 },
> -	{ 0x23, 0x0000, 0x0000, 1152,  768,  8, },
> -	{ 0x24, 0x0000, 0x0000, 1152,  768, 16, },
> -	{ 0x25, 0x0000, 0x0000, 1152,  768, 32, },
> -	{ 0x79, 0x0000, 0x0000, 1280,  720,  8, MD_XGI315 },
> -	{ 0x75, 0x0000, 0x0000, 1280,  720, 16, MD_XGI315 },
> -	{ 0x78, 0x0000, 0x0000, 1280,  720, 32, MD_XGI315 },
> -	{ 0x23, 0x0000, 0x0000, 1280,  768,  8, MD_XGI315 },
> -	{ 0x24, 0x0000, 0x0000, 1280,  768, 16, MD_XGI315 },
> -	{ 0x25, 0x0000, 0x0000, 1280,  768, 32, MD_XGI315 },
> -	{ 0x7C, 0x0000, 0x0000, 1280,  960,  8, MD_XGI315 },
> -	{ 0x7D, 0x0000, 0x0000, 1280,  960, 16, MD_XGI315 },
> -	{ 0x7E, 0x0000, 0x0000, 1280,  960, 32, MD_XGI315 },
> -	{ 0x3A, 0x0107, 0x0107, 1280, 1024,  8, MD_XGI315 },
> -	{ 0x4D, 0x011a, 0x011a, 1280, 1024, 16, MD_XGI315 },
> -	{ 0x65, 0x013d, 0x011b, 1280, 1024, 32, MD_XGI315 },
> -	{ 0x26, 0x0000, 0x0000, 1400, 1050,  8, MD_XGI315 },
> -	{ 0x27, 0x0000, 0x0000, 1400, 1050, 16, MD_XGI315 },
> -	{ 0x28, 0x0000, 0x0000, 1400, 1050, 32, MD_XGI315 },
> -	{ 0x3C, 0x0130, 0x011c, 1600, 1200,  8, MD_XGI315 },
> -	{ 0x3D, 0x0131, 0x011e, 1600, 1200, 16, MD_XGI315 },
> -	{ 0x66, 0x013e, 0x011f, 1600, 1200, 32, MD_XGI315 },
> -	{ 0x68, 0x013f, 0x0000, 1920, 1440,  8, MD_XGI315 },
> -	{ 0x69, 0x0140, 0x0000, 1920, 1440, 16, MD_XGI315 },
> -	{ 0x6B, 0x0141, 0x0000, 1920, 1440, 32, MD_XGI315 },
> -	{ 0x6c, 0x0000, 0x0000, 2048, 1536,  8, MD_XGI315 },
> -	{ 0x6d, 0x0000, 0x0000, 2048, 1536, 16, MD_XGI315 },
> -	{ 0x6e, 0x0000, 0x0000, 2048, 1536, 32, MD_XGI315 },
> -	{ 0 },
> -};
> -
> -static const unsigned short XGI310paneltype[] = {
> -	 LCD_UNKNOWN,   LCD_800x600, LCD_1024x768, LCD_1280x1024,
> -	 LCD_640x480,  LCD_1024x600, LCD_1152x864,  LCD_1280x960,
> -	LCD_1152x768, LCD_1400x1050, LCD_1280x768, LCD_1600x1200,
> -	LCD_1024x768,  LCD_1024x768, LCD_1024x768};
> -
> -static const struct _XGI_crt2type {
> -	char name[10];
> -	int type_no;
> -	int tvplug_no;
> -} XGI_crt2type[] = {
> -	{"NONE",	0,		-1},
> -	{"LCD",		XGIFB_DISP_LCD,	-1},
> -	{"TV",		XGIFB_DISP_TV,	-1},
> -	{"VGA",		XGIFB_DISP_CRT,	-1},
> -	{"SVIDEO",	XGIFB_DISP_TV,	TVPLUG_SVIDEO},
> -	{"COMPOSITE",	XGIFB_DISP_TV,	TVPLUG_COMPOSITE},
> -	{"SCART",	XGIFB_DISP_TV,	TVPLUG_SCART},
> -	{"none",	0,		-1},
> -	{"lcd",		XGIFB_DISP_LCD,	-1},
> -	{"tv",		XGIFB_DISP_TV,	-1},
> -	{"vga",		XGIFB_DISP_CRT,	-1},
> -	{"svideo",	XGIFB_DISP_TV,	TVPLUG_SVIDEO},
> -	{"composite",	XGIFB_DISP_TV,	TVPLUG_COMPOSITE},
> -	{"scart",	XGIFB_DISP_TV,	TVPLUG_SCART},
> -	{"\0",		-1,		-1}
> -};
> -
> -/* TV standard */
> -static const struct _XGI_tvtype {
> -	char name[6];
> -	int type_no;
> -} XGI_tvtype[] = {
> -	{"PAL",		1},
> -	{"NTSC",	2},
> -	{"pal",		1},
> -	{"ntsc",	2},
> -	{"\0",	       -1}
> -};
> -
> -static const struct _XGI_vrate {
> -	u16 idx;
> -	u16 xres;
> -	u16 yres;
> -	u16 refresh;
> -} XGIfb_vrate[] = {
> -	{1,  640,  480,  60}, {2,  640,  480,  72},
> -	{3,  640,  480,  75}, {4,  640,  480,  85},
> -
> -	{5,  640,  480, 100}, {6,  640,  480, 120},
> -	{7,  640,  480, 160}, {8,  640,  480, 200},
> -
> -	{1,  720,  480,  60},
> -	{1,  720,  576,  58},
> -	{1,  800,  480,  60}, {2,  800,  480,  75}, {3,  800,  480,  85},
> -	{1,  800,  600,  60}, {2,  800,  600,  72}, {3,  800,  600,  75},
> -	{4,  800,  600,  85}, {5,  800,  600, 100},
> -	{6,  800,  600, 120}, {7,  800,  600, 160},
> -
> -	{1, 1024,  768,  60}, {2, 1024,  768,  70}, {3, 1024,  768,  75},
> -	{4, 1024,  768,  85}, {5, 1024,  768, 100}, {6, 1024,  768, 120},
> -	{1, 1024,  576,  60}, {2, 1024,  576,  75}, {3, 1024,  576,  85},
> -	{1, 1024,  600,  60},
> -	{1, 1152,  768,  60},
> -	{1, 1280,  720,  60}, {2, 1280,  720,  75}, {3, 1280,  720,  85},
> -	{1, 1280,  768,  60},
> -	{1, 1280, 1024,  60}, {2, 1280, 1024,  75}, {3, 1280, 1024,  85},
> -	{1, 1280,  960,  70},
> -	{1, 1400, 1050,  60},
> -	{1, 1600, 1200,  60}, {2, 1600, 1200,  65},
> -	{3, 1600, 1200,  70}, {4, 1600, 1200,  75},
> -
> -	{5, 1600, 1200,  85}, {6, 1600, 1200, 100},
> -	{7, 1600, 1200, 120},
> -
> -	{1, 1920, 1440,  60}, {2, 1920, 1440,  65},
> -	{3, 1920, 1440,  70}, {4, 1920, 1440,  75},
> -
> -	{5, 1920, 1440,  85}, {6, 1920, 1440, 100},
> -	{1, 2048, 1536,  60}, {2, 2048, 1536,  65},
> -	{3, 2048, 1536,  70}, {4, 2048, 1536,  75},
> -
> -	{5, 2048, 1536,  85},
> -	{0,    0,    0,   0}
> -};
> -
> -static const struct _XGI_TV_filter {
> -	u8 filter[9][4];
> -} XGI_TV_filter[] = {
> -	{ { {0x00, 0x00, 0x00, 0x40},  /* NTSCFilter_0 */
> -	    {0x00, 0xE0, 0x10, 0x60},
> -	    {0x00, 0xEE, 0x10, 0x44},
> -	    {0x00, 0xF4, 0x10, 0x38},
> -	    {0xF8, 0xF4, 0x18, 0x38},
> -	    {0xFC, 0xFB, 0x14, 0x2A},
> -	    {0x00, 0x00, 0x10, 0x20},
> -	    {0x00, 0x04, 0x10, 0x18},
> -	    {0xFF, 0xFF, 0xFF, 0xFF} } },
> -	{ { {0x00, 0x00, 0x00, 0x40},  /* NTSCFilter_1 */
> -	    {0x00, 0xE0, 0x10, 0x60},
> -	    {0x00, 0xEE, 0x10, 0x44},
> -	    {0x00, 0xF4, 0x10, 0x38},
> -	    {0xF8, 0xF4, 0x18, 0x38},
> -	    {0xFC, 0xFB, 0x14, 0x2A},
> -	    {0x00, 0x00, 0x10, 0x20},
> -	    {0x00, 0x04, 0x10, 0x18},
> -	    {0xFF, 0xFF, 0xFF, 0xFF} } },
> -	{ { {0x00, 0x00, 0x00, 0x40},  /* NTSCFilter_2 */
> -	    {0xF5, 0xEE, 0x1B, 0x44},
> -	    {0xF8, 0xF4, 0x18, 0x38},
> -	    {0xEB, 0x04, 0x25, 0x18},
> -	    {0xF1, 0x05, 0x1F, 0x16},
> -	    {0xF6, 0x06, 0x1A, 0x14},
> -	    {0xFA, 0x06, 0x16, 0x14},
> -	    {0x00, 0x04, 0x10, 0x18},
> -	    {0xFF, 0xFF, 0xFF, 0xFF} } },
> -	{ { {0x00, 0x00, 0x00, 0x40},  /* NTSCFilter_3 */
> -	    {0xF1, 0x04, 0x1F, 0x18},
> -	    {0xEE, 0x0D, 0x22, 0x06},
> -	    {0xF7, 0x06, 0x19, 0x14},
> -	    {0xF4, 0x0B, 0x1C, 0x0A},
> -	    {0xFA, 0x07, 0x16, 0x12},
> -	    {0xF9, 0x0A, 0x17, 0x0C},
> -	    {0x00, 0x07, 0x10, 0x12},
> -	    {0xFF, 0xFF, 0xFF, 0xFF} } },
> -	{ { {0x00, 0x00, 0x00, 0x40},  /* NTSCFilter_4 */
> -	    {0x00, 0xE0, 0x10, 0x60},
> -	    {0x00, 0xEE, 0x10, 0x44},
> -	    {0x00, 0xF4, 0x10, 0x38},
> -	    {0xF8, 0xF4, 0x18, 0x38},
> -	    {0xFC, 0xFB, 0x14, 0x2A},
> -	    {0x00, 0x00, 0x10, 0x20},
> -	    {0x00, 0x04, 0x10, 0x18},
> -	    {0xFF, 0xFF, 0xFF, 0xFF} } },
> -	{ { {0x00, 0x00, 0x00, 0x40},  /* NTSCFilter_5 */
> -	    {0xF5, 0xEE, 0x1B, 0x44},
> -	    {0xF8, 0xF4, 0x18, 0x38},
> -	    {0xEB, 0x04, 0x25, 0x18},
> -	    {0xF1, 0x05, 0x1F, 0x16},
> -	    {0xF6, 0x06, 0x1A, 0x14},
> -	    {0xFA, 0x06, 0x16, 0x14},
> -	    {0x00, 0x04, 0x10, 0x18},
> -	    {0xFF, 0xFF, 0xFF, 0xFF} } },
> -	{ { {0x00, 0x00, 0x00, 0x40},  /* NTSCFilter_6 */
> -	    {0xEB, 0x04, 0x25, 0x18},
> -	    {0xE7, 0x0E, 0x29, 0x04},
> -	    {0xEE, 0x0C, 0x22, 0x08},
> -	    {0xF6, 0x0B, 0x1A, 0x0A},
> -	    {0xF9, 0x0A, 0x17, 0x0C},
> -	    {0xFC, 0x0A, 0x14, 0x0C},
> -	    {0x00, 0x08, 0x10, 0x10},
> -	    {0xFF, 0xFF, 0xFF, 0xFF} } },
> -	{ { {0x00, 0x00, 0x00, 0x40},  /* NTSCFilter_7 */
> -	    {0xEC, 0x02, 0x24, 0x1C},
> -	    {0xF2, 0x04, 0x1E, 0x18},
> -	    {0xEB, 0x15, 0x25, 0xF6},
> -	    {0xF4, 0x10, 0x1C, 0x00},
> -	    {0xF8, 0x0F, 0x18, 0x02},
> -	    {0x00, 0x04, 0x10, 0x18},
> -	    {0x01, 0x06, 0x0F, 0x14},
> -	    {0xFF, 0xFF, 0xFF, 0xFF} } },
> -	{ { {0x00, 0x00, 0x00, 0x40},  /* PALFilter_0 */
> -	    {0x00, 0xE0, 0x10, 0x60},
> -	    {0x00, 0xEE, 0x10, 0x44},
> -	    {0x00, 0xF4, 0x10, 0x38},
> -	    {0xF8, 0xF4, 0x18, 0x38},
> -	    {0xFC, 0xFB, 0x14, 0x2A},
> -	    {0x00, 0x00, 0x10, 0x20},
> -	    {0x00, 0x04, 0x10, 0x18},
> -	    {0xFF, 0xFF, 0xFF, 0xFF} } },
> -	{ { {0x00, 0x00, 0x00, 0x40},  /* PALFilter_1 */
> -	    {0x00, 0xE0, 0x10, 0x60},
> -	    {0x00, 0xEE, 0x10, 0x44},
> -	    {0x00, 0xF4, 0x10, 0x38},
> -	    {0xF8, 0xF4, 0x18, 0x38},
> -	    {0xFC, 0xFB, 0x14, 0x2A},
> -	    {0x00, 0x00, 0x10, 0x20},
> -	    {0x00, 0x04, 0x10, 0x18},
> -	    {0xFF, 0xFF, 0xFF, 0xFF} } },
> -	{ { {0x00, 0x00, 0x00, 0x40},  /* PALFilter_2 */
> -	    {0xF5, 0xEE, 0x1B, 0x44},
> -	    {0xF8, 0xF4, 0x18, 0x38},
> -	    {0xF1, 0xF7, 0x01, 0x32},
> -	    {0xF5, 0xFB, 0x1B, 0x2A},
> -	    {0xF9, 0xFF, 0x17, 0x22},
> -	    {0xFB, 0x01, 0x15, 0x1E},
> -	    {0x00, 0x04, 0x10, 0x18},
> -	    {0xFF, 0xFF, 0xFF, 0xFF} } },
> -	{ { {0x00, 0x00, 0x00, 0x40},  /* PALFilter_3 */
> -	    {0xF5, 0xFB, 0x1B, 0x2A},
> -	    {0xEE, 0xFE, 0x22, 0x24},
> -	    {0xF3, 0x00, 0x1D, 0x20},
> -	    {0xF9, 0x03, 0x17, 0x1A},
> -	    {0xFB, 0x02, 0x14, 0x1E},
> -	    {0xFB, 0x04, 0x15, 0x18},
> -	    {0x00, 0x06, 0x10, 0x14},
> -	    {0xFF, 0xFF, 0xFF, 0xFF} } },
> -	{ { {0x00, 0x00, 0x00, 0x40},  /* PALFilter_4 */
> -	    {0x00, 0xE0, 0x10, 0x60},
> -	    {0x00, 0xEE, 0x10, 0x44},
> -	    {0x00, 0xF4, 0x10, 0x38},
> -	    {0xF8, 0xF4, 0x18, 0x38},
> -	    {0xFC, 0xFB, 0x14, 0x2A},
> -	    {0x00, 0x00, 0x10, 0x20},
> -	    {0x00, 0x04, 0x10, 0x18},
> -	    {0xFF, 0xFF, 0xFF, 0xFF} } },
> -	{ { {0x00, 0x00, 0x00, 0x40},  /* PALFilter_5 */
> -	    {0xF5, 0xEE, 0x1B, 0x44},
> -	    {0xF8, 0xF4, 0x18, 0x38},
> -	    {0xF1, 0xF7, 0x1F, 0x32},
> -	    {0xF5, 0xFB, 0x1B, 0x2A},
> -	    {0xF9, 0xFF, 0x17, 0x22},
> -	    {0xFB, 0x01, 0x15, 0x1E},
> -	    {0x00, 0x04, 0x10, 0x18},
> -	    {0xFF, 0xFF, 0xFF, 0xFF} } },
> -	{ { {0x00, 0x00, 0x00, 0x40},  /* PALFilter_6 */
> -	    {0xF5, 0xEE, 0x1B, 0x2A},
> -	    {0xEE, 0xFE, 0x22, 0x24},
> -	    {0xF3, 0x00, 0x1D, 0x20},
> -	    {0xF9, 0x03, 0x17, 0x1A},
> -	    {0xFB, 0x02, 0x14, 0x1E},
> -	    {0xFB, 0x04, 0x15, 0x18},
> -	    {0x00, 0x06, 0x10, 0x14},
> -	    {0xFF, 0xFF, 0xFF, 0xFF} } },
> -	{ { {0x00, 0x00, 0x00, 0x40},  /* PALFilter_7 */
> -	    {0xF5, 0xEE, 0x1B, 0x44},
> -	    {0xF8, 0xF4, 0x18, 0x38},
> -	    {0xFC, 0xFB, 0x14, 0x2A},
> -	    {0xEB, 0x05, 0x25, 0x16},
> -	    {0xF1, 0x05, 0x1F, 0x16},
> -	    {0xFA, 0x07, 0x16, 0x12},
> -	    {0x00, 0x07, 0x10, 0x12},
> -	    {0xFF, 0xFF, 0xFF, 0xFF} } }
> -};
> -
> -static int           filter = -1;
> -
> -#endif
> diff --git a/drivers/staging/xgifb/XGI_main_26.c b/drivers/staging/xgifb/XGI_main_26.c
> deleted file mode 100644
> index 217c6bb82c0d..000000000000
> --- a/drivers/staging/xgifb/XGI_main_26.c
> +++ /dev/null
> @@ -1,2084 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * XG20, XG21, XG40, XG42 frame buffer device
> - * for Linux kernels  2.5.x, 2.6.x
> - * Base on TW's sis fbdev code.
> - */
> -
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
> -#include <linux/sizes.h>
> -#include <linux/module.h>
> -#include <linux/pci.h>
> -
> -#include "XGI_main.h"
> -#include "vb_init.h"
> -#include "vb_util.h"
> -#include "vb_setmode.h"
> -
> -#define Index_CR_GPIO_Reg1 0x48
> -#define Index_CR_GPIO_Reg3 0x4a
> -
> -#define GPIOG_EN    BIT(6)
> -#define GPIOG_READ  BIT(1)
> -
> -static char *forcecrt2type;
> -static char *mode;
> -static int vesa = -1;
> -static unsigned int refresh_rate;
> -
> -/* -------------------- Macro definitions ---------------------------- */
> -
> -#ifdef DEBUG
> -static void dumpVGAReg(struct xgifb_video_info *xgifb_info)
> -{
> -	struct vb_device_info *vb = &xgifb_info->dev_info;
> -	u8 i, reg;
> -
> -	xgifb_reg_set(vb->P3c4, 0x05, 0x86);
> -
> -	for (i = 0; i < 0x4f; i++) {
> -		reg = xgifb_reg_get(vb->P3c4, i);
> -		pr_debug("o 3c4 %x\n", i);
> -		pr_debug("i 3c5 => %x\n", reg);
> -	}
> -
> -	for (i = 0; i < 0xF0; i++) {
> -		reg = xgifb_reg_get(vb->P3d4, i);
> -		pr_debug("o 3d4 %x\n", i);
> -		pr_debug("i 3d5 => %x\n", reg);
> -	}
> -}
> -#else
> -static inline void dumpVGAReg(struct xgifb_video_info *xgifb_info)
> -{
> -}
> -#endif
> -
> -/* --------------- Hardware Access Routines -------------------------- */
> -
> -static int XGIfb_mode_rate_to_dclock(struct vb_device_info *XGI_Pr,
> -				     struct xgi_hw_device_info *HwDeviceExtension,
> -				     unsigned char modeno)
> -{
> -	unsigned short ModeNo = modeno;
> -	unsigned short ModeIdIndex = 0, ClockIndex = 0;
> -	unsigned short RefreshRateTableIndex = 0;
> -
> -	InitTo330Pointer(HwDeviceExtension->jChipType, XGI_Pr);
> -
> -	XGI_SearchModeID(ModeNo, &ModeIdIndex);
> -
> -	RefreshRateTableIndex = XGI_GetRatePtrCRT2(HwDeviceExtension, ModeNo,
> -						   ModeIdIndex, XGI_Pr);
> -
> -	ClockIndex = XGI330_RefIndex[RefreshRateTableIndex].Ext_CRTVCLK;
> -
> -	return XGI_VCLKData[ClockIndex].CLOCK * 1000;
> -}
> -
> -static int XGIfb_mode_rate_to_ddata(struct vb_device_info *XGI_Pr,
> -				    struct xgi_hw_device_info *HwDeviceExtension,
> -				    unsigned char modeno, u32 *left_margin,
> -				    u32 *right_margin, u32 *upper_margin,
> -				    u32 *lower_margin, u32 *hsync_len,
> -				    u32 *vsync_len, u32 *sync, u32 *vmode)
> -{
> -	unsigned short ModeNo = modeno;
> -	unsigned short ModeIdIndex, index = 0;
> -	unsigned short RefreshRateTableIndex = 0;
> -
> -	unsigned short VRE, VBE, VRS, VDE;
> -	unsigned short HRE, HBE, HRS, HDE;
> -	unsigned char sr_data, cr_data, cr_data2;
> -	int B, C, D, F, temp, j;
> -
> -	InitTo330Pointer(HwDeviceExtension->jChipType, XGI_Pr);
> -	if (!XGI_SearchModeID(ModeNo, &ModeIdIndex))
> -		return 0;
> -	RefreshRateTableIndex = XGI_GetRatePtrCRT2(HwDeviceExtension, ModeNo,
> -						   ModeIdIndex, XGI_Pr);
> -	index = XGI330_RefIndex[RefreshRateTableIndex].Ext_CRT1CRTC;
> -
> -	sr_data = XGI_CRT1Table[index].CR[5];
> -
> -	HDE = XGI330_RefIndex[RefreshRateTableIndex].XRes >> 3;
> -
> -	cr_data = XGI_CRT1Table[index].CR[3];
> -
> -	/* Horizontal retrace (=sync) start */
> -	HRS = (cr_data & 0xff) | ((unsigned short)(sr_data & 0xC0) << 2);
> -	F = HRS - HDE - 3;
> -
> -	sr_data = XGI_CRT1Table[index].CR[6];
> -
> -	cr_data = XGI_CRT1Table[index].CR[2];
> -
> -	cr_data2 = XGI_CRT1Table[index].CR[4];
> -
> -	/* Horizontal blank end */
> -	HBE = (cr_data & 0x1f) | ((unsigned short)(cr_data2 & 0x80) >> 2)
> -			| ((unsigned short)(sr_data & 0x03) << 6);
> -
> -	/* Horizontal retrace (=sync) end */
> -	HRE = (cr_data2 & 0x1f) | ((sr_data & 0x04) << 3);
> -
> -	temp = HBE - ((HDE - 1) & 255);
> -	B = (temp > 0) ? temp : (temp + 256);
> -
> -	temp = HRE - ((HDE + F + 3) & 63);
> -	C = (temp > 0) ? temp : (temp + 64);
> -
> -	D = B - F - C;
> -
> -	*left_margin = D * 8;
> -	*right_margin = F * 8;
> -	*hsync_len = C * 8;
> -
> -	sr_data = XGI_CRT1Table[index].CR[14];
> -
> -	cr_data2 = XGI_CRT1Table[index].CR[9];
> -
> -	VDE = XGI330_RefIndex[RefreshRateTableIndex].YRes;
> -
> -	cr_data = XGI_CRT1Table[index].CR[10];
> -
> -	/* Vertical retrace (=sync) start */
> -	VRS = (cr_data & 0xff) | ((unsigned short)(cr_data2 & 0x04) << 6)
> -			| ((unsigned short)(cr_data2 & 0x80) << 2)
> -			| ((unsigned short)(sr_data & 0x08) << 7);
> -	F = VRS + 1 - VDE;
> -
> -	cr_data = XGI_CRT1Table[index].CR[13];
> -
> -	/* Vertical blank end */
> -	VBE = (cr_data & 0xff) | ((unsigned short)(sr_data & 0x10) << 4);
> -	temp = VBE - ((VDE - 1) & 511);
> -	B = (temp > 0) ? temp : (temp + 512);
> -
> -	cr_data = XGI_CRT1Table[index].CR[11];
> -
> -	/* Vertical retrace (=sync) end */
> -	VRE = (cr_data & 0x0f) | ((sr_data & 0x20) >> 1);
> -	temp = VRE - ((VDE + F - 1) & 31);
> -	C = (temp > 0) ? temp : (temp + 32);
> -
> -	D = B - F - C;
> -
> -	*upper_margin = D;
> -	*lower_margin = F;
> -	*vsync_len = C;
> -
> -	if (XGI330_RefIndex[RefreshRateTableIndex].Ext_InfoFlag & 0x8000)
> -		*sync &= ~FB_SYNC_VERT_HIGH_ACT;
> -	else
> -		*sync |= FB_SYNC_VERT_HIGH_ACT;
> -
> -	if (XGI330_RefIndex[RefreshRateTableIndex].Ext_InfoFlag & 0x4000)
> -		*sync &= ~FB_SYNC_HOR_HIGH_ACT;
> -	else
> -		*sync |= FB_SYNC_HOR_HIGH_ACT;
> -
> -	*vmode = FB_VMODE_NONINTERLACED;
> -	if (XGI330_RefIndex[RefreshRateTableIndex].Ext_InfoFlag & 0x0080) {
> -		*vmode = FB_VMODE_INTERLACED;
> -	} else {
> -		j = 0;
> -		while (XGI330_EModeIDTable[j].Ext_ModeID != 0xff) {
> -			if (XGI330_EModeIDTable[j].Ext_ModeID ==
> -			    XGI330_RefIndex[RefreshRateTableIndex].ModeID) {
> -				if (XGI330_EModeIDTable[j].Ext_ModeFlag &
> -				    DoubleScanMode) {
> -					*vmode = FB_VMODE_DOUBLE;
> -				}
> -				break;
> -			}
> -			j++;
> -		}
> -	}
> -
> -	return 1;
> -}
> -
> -void XGIRegInit(struct vb_device_info *XGI_Pr, unsigned long BaseAddr)
> -{
> -	XGI_Pr->P3c4 = BaseAddr + 0x14;
> -	XGI_Pr->P3d4 = BaseAddr + 0x24;
> -	XGI_Pr->P3c0 = BaseAddr + 0x10;
> -	XGI_Pr->P3ce = BaseAddr + 0x1e;
> -	XGI_Pr->P3c2 = BaseAddr + 0x12;
> -	XGI_Pr->P3cc = BaseAddr + 0x1c;
> -	XGI_Pr->P3ca = BaseAddr + 0x1a;
> -	XGI_Pr->P3c6 = BaseAddr + 0x16;
> -	XGI_Pr->P3c7 = BaseAddr + 0x17;
> -	XGI_Pr->P3c8 = BaseAddr + 0x18;
> -	XGI_Pr->P3c9 = BaseAddr + 0x19;
> -	XGI_Pr->P3da = BaseAddr + 0x2A;
> -	XGI_Pr->Part0Port = BaseAddr + XGI_CRT2_PORT_00;
> -	/* Digital video interface registers (LCD) */
> -	XGI_Pr->Part1Port = BaseAddr + SIS_CRT2_PORT_04;
> -	/* 301 TV Encoder registers */
> -	XGI_Pr->Part2Port = BaseAddr + SIS_CRT2_PORT_10;
> -	/* 301 Macrovision registers */
> -	XGI_Pr->Part3Port = BaseAddr + SIS_CRT2_PORT_12;
> -	/* 301 VGA2 (and LCD) registers */
> -	XGI_Pr->Part4Port = BaseAddr + SIS_CRT2_PORT_14;
> -	/* 301 palette address port registers */
> -	XGI_Pr->Part5Port = BaseAddr + SIS_CRT2_PORT_14 + 2;
> -}
> -
> -/* ------------------ Internal helper routines ----------------- */
> -
> -static int XGIfb_GetXG21DefaultLVDSModeIdx(struct xgifb_video_info *xgifb_info)
> -{
> -	int i = 0;
> -
> -	while ((XGIbios_mode[i].mode_no != 0) &&
> -	       (XGIbios_mode[i].xres <= xgifb_info->lvds_data.LVDSHDE)) {
> -		if ((XGIbios_mode[i].xres == xgifb_info->lvds_data.LVDSHDE) &&
> -		    (XGIbios_mode[i].yres == xgifb_info->lvds_data.LVDSVDE) &&
> -		    (XGIbios_mode[i].bpp == 8)) {
> -			return i;
> -		}
> -		i++;
> -	}
> -
> -	return -1;
> -}
> -
> -static void XGIfb_search_mode(struct xgifb_video_info *xgifb_info,
> -			      const char *name)
> -{
> -	unsigned int xres;
> -	unsigned int yres;
> -	unsigned int bpp;
> -	int i;
> -
> -	if (sscanf(name, "%ux%ux%u", &xres, &yres, &bpp) != 3)
> -		goto invalid_mode;
> -
> -	if (bpp == 24)
> -		bpp = 32; /* That's for people who mix up color and fb depth. */
> -
> -	for (i = 0; XGIbios_mode[i].mode_no != 0; i++)
> -		if (XGIbios_mode[i].xres == xres &&
> -		    XGIbios_mode[i].yres == yres &&
> -		    XGIbios_mode[i].bpp == bpp) {
> -			xgifb_info->mode_idx = i;
> -			return;
> -		}
> -invalid_mode:
> -	pr_info("Invalid mode '%s'\n", name);
> -}
> -
> -static void XGIfb_search_vesamode(struct xgifb_video_info *xgifb_info,
> -				  unsigned int vesamode)
> -{
> -	int i = 0;
> -
> -	if (vesamode == 0)
> -		goto invalid;
> -
> -	vesamode &= 0x1dff; /* Clean VESA mode number from other flags */
> -
> -	while (XGIbios_mode[i].mode_no != 0) {
> -		if ((XGIbios_mode[i].vesa_mode_no_1 == vesamode) ||
> -		    (XGIbios_mode[i].vesa_mode_no_2 == vesamode)) {
> -			xgifb_info->mode_idx = i;
> -			return;
> -		}
> -		i++;
> -	}
> -
> -invalid:
> -	pr_info("Invalid VESA mode 0x%x'\n", vesamode);
> -}
> -
> -static int XGIfb_validate_mode(struct xgifb_video_info *xgifb_info, int myindex)
> -{
> -	u16 xres, yres;
> -	struct xgi_hw_device_info *hw_info = &xgifb_info->hw_info;
> -	unsigned long required_mem;
> -
> -	if (xgifb_info->chip == XG21) {
> -		if (xgifb_info->display2 == XGIFB_DISP_LCD) {
> -			xres = xgifb_info->lvds_data.LVDSHDE;
> -			yres = xgifb_info->lvds_data.LVDSVDE;
> -			if (XGIbios_mode[myindex].xres > xres)
> -				return -1;
> -			if (XGIbios_mode[myindex].yres > yres)
> -				return -1;
> -			if ((XGIbios_mode[myindex].xres < xres) &&
> -			    (XGIbios_mode[myindex].yres < yres)) {
> -				if (XGIbios_mode[myindex].bpp > 8)
> -					return -1;
> -			}
> -		}
> -		goto check_memory;
> -	}
> -
> -	/* FIXME: for now, all is valid on XG27 */
> -	if (xgifb_info->chip == XG27)
> -		goto check_memory;
> -
> -	if (!(XGIbios_mode[myindex].chipset & MD_XGI315))
> -		return -1;
> -
> -	switch (xgifb_info->display2) {
> -	case XGIFB_DISP_LCD:
> -		switch (hw_info->ulCRT2LCDType) {
> -		case LCD_640x480:
> -			xres = 640;
> -			yres = 480;
> -			break;
> -		case LCD_800x600:
> -			xres = 800;
> -			yres = 600;
> -			break;
> -		case LCD_1024x600:
> -			xres = 1024;
> -			yres = 600;
> -			break;
> -		case LCD_1024x768:
> -			xres = 1024;
> -			yres = 768;
> -			break;
> -		case LCD_1152x768:
> -			xres = 1152;
> -			yres = 768;
> -			break;
> -		case LCD_1280x960:
> -			xres = 1280;
> -			yres = 960;
> -			break;
> -		case LCD_1280x768:
> -			xres = 1280;
> -			yres = 768;
> -			break;
> -		case LCD_1280x1024:
> -			xres = 1280;
> -			yres = 1024;
> -			break;
> -		case LCD_1400x1050:
> -			xres = 1400;
> -			yres = 1050;
> -			break;
> -		case LCD_1600x1200:
> -			xres = 1600;
> -			yres = 1200;
> -			break;
> -		default:
> -			xres = 0;
> -			yres = 0;
> -			break;
> -		}
> -		if (XGIbios_mode[myindex].xres > xres)
> -			return -1;
> -		if (XGIbios_mode[myindex].yres > yres)
> -			return -1;
> -		if ((hw_info->ulExternalChip == 0x01) || /* LVDS */
> -		    (hw_info->ulExternalChip == 0x05)) { /* LVDS+Chrontel */
> -			switch (XGIbios_mode[myindex].xres) {
> -			case 512:
> -				if (XGIbios_mode[myindex].yres != 512)
> -					return -1;
> -				if (hw_info->ulCRT2LCDType == LCD_1024x600)
> -					return -1;
> -				break;
> -			case 640:
> -				if ((XGIbios_mode[myindex].yres != 400) &&
> -				    (XGIbios_mode[myindex].yres	!= 480))
> -					return -1;
> -				break;
> -			case 800:
> -				if (XGIbios_mode[myindex].yres != 600)
> -					return -1;
> -				break;
> -			case 1024:
> -				if ((XGIbios_mode[myindex].yres != 600) &&
> -				    (XGIbios_mode[myindex].yres != 768))
> -					return -1;
> -				if ((XGIbios_mode[myindex].yres == 600) &&
> -				    (hw_info->ulCRT2LCDType != LCD_1024x600))
> -					return -1;
> -				break;
> -			case 1152:
> -				if ((XGIbios_mode[myindex].yres) != 768)
> -					return -1;
> -				if (hw_info->ulCRT2LCDType != LCD_1152x768)
> -					return -1;
> -				break;
> -			case 1280:
> -				if ((XGIbios_mode[myindex].yres != 768) &&
> -				    (XGIbios_mode[myindex].yres != 1024))
> -					return -1;
> -				if ((XGIbios_mode[myindex].yres == 768) &&
> -				    (hw_info->ulCRT2LCDType != LCD_1280x768))
> -					return -1;
> -				break;
> -			case 1400:
> -				if (XGIbios_mode[myindex].yres != 1050)
> -					return -1;
> -				break;
> -			case 1600:
> -				if (XGIbios_mode[myindex].yres != 1200)
> -					return -1;
> -				break;
> -			default:
> -				return -1;
> -			}
> -		} else {
> -			switch (XGIbios_mode[myindex].xres) {
> -			case 512:
> -				if (XGIbios_mode[myindex].yres != 512)
> -					return -1;
> -				break;
> -			case 640:
> -				if ((XGIbios_mode[myindex].yres != 400) &&
> -				    (XGIbios_mode[myindex].yres != 480))
> -					return -1;
> -				break;
> -			case 800:
> -				if (XGIbios_mode[myindex].yres != 600)
> -					return -1;
> -				break;
> -			case 1024:
> -				if (XGIbios_mode[myindex].yres != 768)
> -					return -1;
> -				break;
> -			case 1280:
> -				if ((XGIbios_mode[myindex].yres != 960) &&
> -				    (XGIbios_mode[myindex].yres != 1024))
> -					return -1;
> -				if (XGIbios_mode[myindex].yres == 960) {
> -					if (hw_info->ulCRT2LCDType ==
> -					    LCD_1400x1050)
> -						return -1;
> -				}
> -				break;
> -			case 1400:
> -				if (XGIbios_mode[myindex].yres != 1050)
> -					return -1;
> -				break;
> -			case 1600:
> -				if (XGIbios_mode[myindex].yres != 1200)
> -					return -1;
> -				break;
> -			default:
> -				return -1;
> -			}
> -		}
> -		break;
> -	case XGIFB_DISP_TV:
> -		switch (XGIbios_mode[myindex].xres) {
> -		case 512:
> -		case 640:
> -		case 800:
> -			break;
> -		case 720:
> -			if (xgifb_info->TV_type == TVMODE_NTSC) {
> -				if (XGIbios_mode[myindex].yres != 480)
> -					return -1;
> -			} else if (xgifb_info->TV_type == TVMODE_PAL) {
> -				if (XGIbios_mode[myindex].yres != 576)
> -					return -1;
> -			}
> -			/* LVDS/CHRONTEL does not support 720 */
> -			if (xgifb_info->hasVB == HASVB_LVDS_CHRONTEL ||
> -			    xgifb_info->hasVB == HASVB_CHRONTEL) {
> -				return -1;
> -			}
> -			break;
> -		case 1024:
> -			if (xgifb_info->TV_type == TVMODE_NTSC) {
> -				if (XGIbios_mode[myindex].bpp == 32)
> -					return -1;
> -			}
> -			break;
> -		default:
> -			return -1;
> -		}
> -		break;
> -	case XGIFB_DISP_CRT:
> -		if (XGIbios_mode[myindex].xres > 1280)
> -			return -1;
> -		break;
> -	case XGIFB_DISP_NONE:
> -		break;
> -	}
> -
> -check_memory:
> -	required_mem = XGIbios_mode[myindex].xres * XGIbios_mode[myindex].yres *
> -		       XGIbios_mode[myindex].bpp / 8;
> -	if (required_mem > xgifb_info->video_size)
> -		return -1;
> -	return myindex;
> -}
> -
> -static void XGIfb_search_crt2type(const char *name)
> -{
> -	int i = 0;
> -
> -	if (!name)
> -		return;
> -
> -	while (XGI_crt2type[i].type_no != -1) {
> -		if (!strcmp(name, XGI_crt2type[i].name)) {
> -			XGIfb_crt2type = XGI_crt2type[i].type_no;
> -			XGIfb_tvplug = XGI_crt2type[i].tvplug_no;
> -			break;
> -		}
> -		i++;
> -	}
> -	if (XGIfb_crt2type < 0)
> -		pr_info("Invalid CRT2 type: %s\n", name);
> -}
> -
> -static u8 XGIfb_search_refresh_rate(struct xgifb_video_info *xgifb_info,
> -				    unsigned int rate)
> -{
> -	u16 xres, yres;
> -	int i = 0;
> -
> -	xres = XGIbios_mode[xgifb_info->mode_idx].xres;
> -	yres = XGIbios_mode[xgifb_info->mode_idx].yres;
> -
> -	xgifb_info->rate_idx = 0;
> -
> -	while (XGIfb_vrate[i].idx != 0 && XGIfb_vrate[i].xres <= xres) {
> -		/* Skip values with xres or yres less than specified */
> -		if ((XGIfb_vrate[i].yres != yres) ||
> -		    (XGIfb_vrate[i].xres != xres)) {
> -			i++;
> -			continue;
> -		}
> -		if (XGIfb_vrate[i].refresh == rate) {
> -			xgifb_info->rate_idx = XGIfb_vrate[i].idx;
> -			break;
> -		} else if (XGIfb_vrate[i].refresh > rate) {
> -			if (XGIfb_vrate[i].refresh - rate <= 3) {
> -				pr_debug("Adjusting rate from %d up to %d\n",
> -					rate, XGIfb_vrate[i].refresh);
> -				xgifb_info->rate_idx = XGIfb_vrate[i].idx;
> -				xgifb_info->refresh_rate =
> -					XGIfb_vrate[i].refresh;
> -			} else if ((XGIfb_vrate[i].idx != 1) &&
> -				   (rate - XGIfb_vrate[i - 1].refresh <= 2)) {
> -				pr_debug("Adjusting rate from %d down to %d\n",
> -					rate, XGIfb_vrate[i - 1].refresh);
> -				xgifb_info->rate_idx = XGIfb_vrate[i - 1].idx;
> -				xgifb_info->refresh_rate =
> -					XGIfb_vrate[i - 1].refresh;
> -			}
> -			break;
> -		} else if (rate - XGIfb_vrate[i].refresh <= 2) {
> -			pr_debug("Adjusting rate from %d down to %d\n",
> -				rate, XGIfb_vrate[i].refresh);
> -			xgifb_info->rate_idx = XGIfb_vrate[i].idx;
> -			break;
> -		}
> -		i++;
> -	}
> -
> -	if (xgifb_info->rate_idx > 0)
> -		return xgifb_info->rate_idx;
> -	pr_info("Unsupported rate %d for %dx%d\n",
> -		rate, xres, yres);
> -	return 0;
> -}
> -
> -static void XGIfb_search_tvstd(const char *name)
> -{
> -	int i = 0;
> -
> -	if (!name)
> -		return;
> -
> -	while (XGI_tvtype[i].type_no != -1) {
> -		if (!strcmp(name, XGI_tvtype[i].name)) {
> -			XGIfb_tvmode = XGI_tvtype[i].type_no;
> -			break;
> -		}
> -		i++;
> -	}
> -}
> -
> -/* ----------- FBDev related routines for all series ----------- */
> -
> -static void XGIfb_bpp_to_var(struct xgifb_video_info *xgifb_info,
> -			     struct fb_var_screeninfo *var)
> -{
> -	switch (var->bits_per_pixel) {
> -	case 8:
> -		var->red.offset = 0;
> -		var->green.offset = 0;
> -		var->blue.offset = 0;
> -		var->red.length = 6;
> -		var->green.length = 6;
> -		var->blue.length = 6;
> -		xgifb_info->video_cmap_len = 256;
> -		break;
> -	case 16:
> -		var->red.offset = 11;
> -		var->red.length = 5;
> -		var->green.offset = 5;
> -		var->green.length = 6;
> -		var->blue.offset = 0;
> -		var->blue.length = 5;
> -		var->transp.offset = 0;
> -		var->transp.length = 0;
> -		xgifb_info->video_cmap_len = 16;
> -		break;
> -	case 32:
> -		var->red.offset = 16;
> -		var->red.length = 8;
> -		var->green.offset = 8;
> -		var->green.length = 8;
> -		var->blue.offset = 0;
> -		var->blue.length = 8;
> -		var->transp.offset = 24;
> -		var->transp.length = 8;
> -		xgifb_info->video_cmap_len = 16;
> -		break;
> -	}
> -}
> -
> -/* --------------------- SetMode routines ------------------------- */
> -
> -static void XGIfb_pre_setmode(struct xgifb_video_info *xgifb_info)
> -{
> -	struct vb_device_info *vb = &xgifb_info->dev_info;
> -	u8 cr30 = 0, cr31 = 0;
> -
> -	cr31 = xgifb_reg_get(vb->P3d4, 0x31);
> -	cr31 &= ~0x60;
> -
> -	switch (xgifb_info->display2) {
> -	case XGIFB_DISP_CRT:
> -		cr30 = SIS_VB_OUTPUT_CRT2 | SIS_SIMULTANEOUS_VIEW_ENABLE;
> -		cr31 |= SIS_DRIVER_MODE;
> -		break;
> -	case XGIFB_DISP_LCD:
> -		cr30 = SIS_VB_OUTPUT_LCD | SIS_SIMULTANEOUS_VIEW_ENABLE;
> -		cr31 |= SIS_DRIVER_MODE;
> -		break;
> -	case XGIFB_DISP_TV:
> -		if (xgifb_info->TV_type == TVMODE_HIVISION)
> -			cr30 = SIS_VB_OUTPUT_HIVISION
> -					| SIS_SIMULTANEOUS_VIEW_ENABLE;
> -		else if (xgifb_info->TV_plug == TVPLUG_SVIDEO)
> -			cr30 = SIS_VB_OUTPUT_SVIDEO
> -					| SIS_SIMULTANEOUS_VIEW_ENABLE;
> -		else if (xgifb_info->TV_plug == TVPLUG_COMPOSITE)
> -			cr30 = SIS_VB_OUTPUT_COMPOSITE
> -					| SIS_SIMULTANEOUS_VIEW_ENABLE;
> -		else if (xgifb_info->TV_plug == TVPLUG_SCART)
> -			cr30 = SIS_VB_OUTPUT_SCART
> -					| SIS_SIMULTANEOUS_VIEW_ENABLE;
> -		cr31 |= SIS_DRIVER_MODE;
> -
> -		if (XGIfb_tvmode == 1 || xgifb_info->TV_type == TVMODE_PAL)
> -			cr31 |= 0x01;
> -		else
> -			cr31 &= ~0x01;
> -		break;
> -	default: /* disable CRT2 */
> -		cr30 = 0x00;
> -		cr31 |= (SIS_DRIVER_MODE | SIS_VB_OUTPUT_DISABLE);
> -	}
> -
> -	xgifb_reg_set(vb->P3d4, IND_XGI_SCRATCH_REG_CR30, cr30);
> -	xgifb_reg_set(vb->P3d4, IND_XGI_SCRATCH_REG_CR31, cr31);
> -	xgifb_reg_set(vb->P3d4, IND_XGI_SCRATCH_REG_CR33,
> -		      (xgifb_info->rate_idx & 0x0F));
> -}
> -
> -static void XGIfb_post_setmode(struct xgifb_video_info *xgifb_info)
> -{
> -	struct vb_device_info *vb = &xgifb_info->dev_info;
> -	u8 reg;
> -	unsigned char doit = 1;
> -
> -	if (xgifb_info->video_bpp == 8) {
> -		/*
> -		 * We can't switch off CRT1 on LVDS/Chrontel
> -		 * in 8bpp Modes
> -		 */
> -		if ((xgifb_info->hasVB == HASVB_LVDS) ||
> -		    (xgifb_info->hasVB == HASVB_LVDS_CHRONTEL)) {
> -			doit = 0;
> -		}
> -		/*
> -		 * We can't switch off CRT1 on 301B-DH
> -		 * in 8bpp Modes if using LCD
> -		 */
> -		if (xgifb_info->display2 == XGIFB_DISP_LCD)
> -			doit = 0;
> -	}
> -
> -	/* We can't switch off CRT1 if bridge is in slave mode */
> -	if (xgifb_info->hasVB != HASVB_NONE) {
> -		reg = xgifb_reg_get(vb->Part1Port, 0x00);
> -
> -		if ((reg & 0x50) == 0x10)
> -			doit = 0;
> -
> -	} else {
> -		XGIfb_crt1off = 0;
> -	}
> -
> -	reg = xgifb_reg_get(vb->P3d4, 0x17);
> -	if ((XGIfb_crt1off) && (doit))
> -		reg &= ~0x80;
> -	else
> -		reg |= 0x80;
> -	xgifb_reg_set(vb->P3d4, 0x17, reg);
> -
> -	xgifb_reg_and(vb->P3c4, IND_SIS_RAMDAC_CONTROL, ~0x04);
> -
> -	if (xgifb_info->display2 == XGIFB_DISP_TV &&
> -	    xgifb_info->hasVB == HASVB_301) {
> -		reg = xgifb_reg_get(vb->Part4Port, 0x01);
> -
> -		if (reg < 0xB0) { /* Set filter for XGI301 */
> -			int filter_tb;
> -
> -			switch (xgifb_info->video_width) {
> -			case 320:
> -				filter_tb = (xgifb_info->TV_type ==
> -					     TVMODE_NTSC) ? 4 : 12;
> -				break;
> -			case 640:
> -				filter_tb = (xgifb_info->TV_type ==
> -					     TVMODE_NTSC) ? 5 : 13;
> -				break;
> -			case 720:
> -				filter_tb = (xgifb_info->TV_type ==
> -					     TVMODE_NTSC) ? 6 : 14;
> -				break;
> -			case 800:
> -				filter_tb = (xgifb_info->TV_type ==
> -					     TVMODE_NTSC) ? 7 : 15;
> -				break;
> -			default:
> -				filter_tb = 0;
> -				filter = -1;
> -				break;
> -			}
> -			xgifb_reg_or(vb->Part1Port, SIS_CRT2_WENABLE_315, 0x01);
> -
> -			if (xgifb_info->TV_type == TVMODE_NTSC) {
> -				xgifb_reg_and(vb->Part2Port, 0x3a, 0x1f);
> -
> -				if (xgifb_info->TV_plug == TVPLUG_SVIDEO) {
> -					xgifb_reg_and(vb->Part2Port, 0x30, 0xdf);
> -
> -				} else if (xgifb_info->TV_plug
> -						== TVPLUG_COMPOSITE) {
> -					xgifb_reg_or(vb->Part2Port, 0x30, 0x20);
> -
> -					switch (xgifb_info->video_width) {
> -					case 640:
> -						xgifb_reg_set(vb->Part2Port,
> -							      0x35,
> -							      0xEB);
> -						xgifb_reg_set(vb->Part2Port,
> -							      0x36,
> -							      0x04);
> -						xgifb_reg_set(vb->Part2Port,
> -							      0x37,
> -							      0x25);
> -						xgifb_reg_set(vb->Part2Port,
> -							      0x38,
> -							      0x18);
> -						break;
> -					case 720:
> -						xgifb_reg_set(vb->Part2Port,
> -							      0x35,
> -							      0xEE);
> -						xgifb_reg_set(vb->Part2Port,
> -							      0x36,
> -							      0x0C);
> -						xgifb_reg_set(vb->Part2Port,
> -							      0x37,
> -							      0x22);
> -						xgifb_reg_set(vb->Part2Port,
> -							      0x38,
> -							      0x08);
> -						break;
> -					case 800:
> -						xgifb_reg_set(vb->Part2Port,
> -							      0x35,
> -							      0xEB);
> -						xgifb_reg_set(vb->Part2Port,
> -							      0x36,
> -							      0x15);
> -						xgifb_reg_set(vb->Part2Port,
> -							      0x37,
> -							      0x25);
> -						xgifb_reg_set(vb->Part2Port,
> -							      0x38,
> -							      0xF6);
> -						break;
> -					}
> -				}
> -
> -			} else if (xgifb_info->TV_type == TVMODE_PAL) {
> -				xgifb_reg_and(vb->Part2Port, 0x3A, 0x1F);
> -
> -				if (xgifb_info->TV_plug == TVPLUG_SVIDEO) {
> -					xgifb_reg_and(vb->Part2Port, 0x30, 0xDF);
> -
> -				} else if (xgifb_info->TV_plug
> -						== TVPLUG_COMPOSITE) {
> -					xgifb_reg_or(vb->Part2Port, 0x30, 0x20);
> -
> -					switch (xgifb_info->video_width) {
> -					case 640:
> -						xgifb_reg_set(vb->Part2Port,
> -							      0x35,
> -							      0xF1);
> -						xgifb_reg_set(vb->Part2Port,
> -							      0x36,
> -							      0xF7);
> -						xgifb_reg_set(vb->Part2Port,
> -							      0x37,
> -							      0x1F);
> -						xgifb_reg_set(vb->Part2Port,
> -							      0x38,
> -							      0x32);
> -						break;
> -					case 720:
> -						xgifb_reg_set(vb->Part2Port,
> -							      0x35,
> -							      0xF3);
> -						xgifb_reg_set(vb->Part2Port,
> -							      0x36,
> -							      0x00);
> -						xgifb_reg_set(vb->Part2Port,
> -							      0x37,
> -							      0x1D);
> -						xgifb_reg_set(vb->Part2Port,
> -							      0x38,
> -							      0x20);
> -						break;
> -					case 800:
> -						xgifb_reg_set(vb->Part2Port,
> -							      0x35,
> -							      0xFC);
> -						xgifb_reg_set(vb->Part2Port,
> -							      0x36,
> -							      0xFB);
> -						xgifb_reg_set(vb->Part2Port,
> -							      0x37,
> -							      0x14);
> -						xgifb_reg_set(vb->Part2Port,
> -							      0x38,
> -							      0x2A);
> -						break;
> -					}
> -				}
> -			}
> -
> -			if ((filter >= 0) && (filter <= 7)) {
> -				const u8 *f = XGI_TV_filter[filter_tb].filter[filter];
> -
> -				pr_debug("FilterTable[%d]-%d: %*ph\n",
> -					 filter_tb, filter, 4, f);
> -				xgifb_reg_set(vb->Part2Port, 0x35, f[0]);
> -				xgifb_reg_set(vb->Part2Port, 0x36, f[1]);
> -				xgifb_reg_set(vb->Part2Port, 0x37, f[2]);
> -				xgifb_reg_set(vb->Part2Port, 0x38, f[3]);
> -			}
> -		}
> -	}
> -}
> -
> -static int XGIfb_do_set_var(struct fb_var_screeninfo *var, int isactive,
> -			    struct fb_info *info)
> -{
> -	struct xgifb_video_info *xgifb_info = info->par;
> -	struct vb_device_info *vb = &xgifb_info->dev_info;
> -	struct xgi_hw_device_info *hw_info = &xgifb_info->hw_info;
> -	unsigned int htotal = var->left_margin + var->xres + var->right_margin
> -			+ var->hsync_len;
> -	unsigned int vtotal = var->upper_margin + var->yres + var->lower_margin
> -			+ var->vsync_len;
> -#if defined(__BIG_ENDIAN)
> -	u8 cr_data;
> -#endif
> -	unsigned int drate = 0, hrate = 0;
> -	int found_mode = 0;
> -	int old_mode;
> -
> -	info->var.xres_virtual = var->xres_virtual;
> -	info->var.yres_virtual = var->yres_virtual;
> -	info->var.bits_per_pixel = var->bits_per_pixel;
> -
> -	if ((var->vmode & FB_VMODE_MASK) == FB_VMODE_NONINTERLACED)
> -		vtotal <<= 1;
> -	else if ((var->vmode & FB_VMODE_MASK) == FB_VMODE_DOUBLE)
> -		vtotal <<= 2;
> -
> -	if (!htotal || !vtotal) {
> -		pr_debug("Invalid 'var' information\n");
> -		return -EINVAL;
> -	}
> -	pr_debug("var->pixclock=%d, htotal=%d, vtotal=%d\n",
> -		 var->pixclock, htotal, vtotal);
> -
> -	if (var->pixclock) {
> -		drate = 1000000000 / var->pixclock;
> -		hrate = (drate * 1000) / htotal;
> -		xgifb_info->refresh_rate = (unsigned int)(hrate * 2
> -				/ vtotal);
> -	} else {
> -		xgifb_info->refresh_rate = 60;
> -	}
> -
> -	pr_debug("Change mode to %dx%dx%d-%dHz\n",
> -		 var->xres, var->yres, var->bits_per_pixel,
> -		 xgifb_info->refresh_rate);
> -
> -	old_mode = xgifb_info->mode_idx;
> -	xgifb_info->mode_idx = 0;
> -
> -	while ((XGIbios_mode[xgifb_info->mode_idx].mode_no != 0) &&
> -	       (XGIbios_mode[xgifb_info->mode_idx].xres <= var->xres)) {
> -		if ((XGIbios_mode[xgifb_info->mode_idx].xres == var->xres) &&
> -		    (XGIbios_mode[xgifb_info->mode_idx].yres == var->yres) &&
> -		    (XGIbios_mode[xgifb_info->mode_idx].bpp
> -						== var->bits_per_pixel)) {
> -			found_mode = 1;
> -			break;
> -		}
> -		xgifb_info->mode_idx++;
> -	}
> -
> -	if (found_mode)
> -		xgifb_info->mode_idx = XGIfb_validate_mode(xgifb_info,
> -							xgifb_info->mode_idx);
> -	else
> -		xgifb_info->mode_idx = -1;
> -
> -	if (xgifb_info->mode_idx < 0) {
> -		pr_err("Mode %dx%dx%d not supported\n",
> -		       var->xres, var->yres, var->bits_per_pixel);
> -		xgifb_info->mode_idx = old_mode;
> -		return -EINVAL;
> -	}
> -
> -	if (XGIfb_search_refresh_rate(xgifb_info,
> -				      xgifb_info->refresh_rate) == 0) {
> -		xgifb_info->rate_idx = 1;
> -		xgifb_info->refresh_rate = 60;
> -	}
> -
> -	if (isactive) {
> -		XGIfb_pre_setmode(xgifb_info);
> -		if (XGISetModeNew(xgifb_info, hw_info,
> -				  XGIbios_mode[xgifb_info->mode_idx].mode_no)
> -					== 0) {
> -			pr_err("Setting mode[0x%x] failed\n",
> -			       XGIbios_mode[xgifb_info->mode_idx].mode_no);
> -			return -EINVAL;
> -		}
> -		info->fix.line_length = (info->var.xres_virtual
> -				* info->var.bits_per_pixel) >> 6;
> -
> -		xgifb_reg_set(vb->P3c4, IND_SIS_PASSWORD, SIS_PASSWORD);
> -
> -		xgifb_reg_set(vb->P3d4, 0x13, (info->fix.line_length & 0x00ff));
> -		xgifb_reg_set(vb->P3c4, 0x0E,
> -			      (info->fix.line_length & 0xff00) >> 8);
> -
> -		XGIfb_post_setmode(xgifb_info);
> -
> -		pr_debug("Set new mode: %dx%dx%d-%d\n",
> -			 XGIbios_mode[xgifb_info->mode_idx].xres,
> -			 XGIbios_mode[xgifb_info->mode_idx].yres,
> -			 XGIbios_mode[xgifb_info->mode_idx].bpp,
> -			 xgifb_info->refresh_rate);
> -
> -		xgifb_info->video_bpp = XGIbios_mode[xgifb_info->mode_idx].bpp;
> -		xgifb_info->video_vwidth = info->var.xres_virtual;
> -		xgifb_info->video_width =
> -			XGIbios_mode[xgifb_info->mode_idx].xres;
> -		xgifb_info->video_vheight = info->var.yres_virtual;
> -		xgifb_info->video_height =
> -			XGIbios_mode[xgifb_info->mode_idx].yres;
> -		xgifb_info->org_x = 0;
> -		xgifb_info->org_y = 0;
> -		xgifb_info->video_linelength = info->var.xres_virtual
> -				* (xgifb_info->video_bpp >> 3);
> -		switch (xgifb_info->video_bpp) {
> -		case 8:
> -			xgifb_info->DstColor = 0x0000;
> -			xgifb_info->XGI310_AccelDepth = 0x00000000;
> -			xgifb_info->video_cmap_len = 256;
> -#if defined(__BIG_ENDIAN)
> -			cr_data = xgifb_reg_get(vb->P3d4, 0x4D);
> -			xgifb_reg_set(vb->P3d4, 0x4D, (cr_data & 0xE0));
> -#endif
> -			break;
> -		case 16:
> -			xgifb_info->DstColor = 0x8000;
> -			xgifb_info->XGI310_AccelDepth = 0x00010000;
> -#if defined(__BIG_ENDIAN)
> -			cr_data = xgifb_reg_get(vb->P3d4, 0x4D);
> -			xgifb_reg_set(vb->P3d4, 0x4D, ((cr_data & 0xE0) | 0x0B));
> -#endif
> -			xgifb_info->video_cmap_len = 16;
> -			break;
> -		case 32:
> -			xgifb_info->DstColor = 0xC000;
> -			xgifb_info->XGI310_AccelDepth = 0x00020000;
> -			xgifb_info->video_cmap_len = 16;
> -#if defined(__BIG_ENDIAN)
> -			cr_data = xgifb_reg_get(vb->P3d4, 0x4D);
> -			xgifb_reg_set(vb->P3d4, 0x4D, ((cr_data & 0xE0) | 0x15));
> -#endif
> -			break;
> -		default:
> -			xgifb_info->video_cmap_len = 16;
> -			pr_err("Unsupported depth %d\n",
> -			       xgifb_info->video_bpp);
> -			break;
> -		}
> -	}
> -	XGIfb_bpp_to_var(xgifb_info, var); /* update ARGB info */
> -
> -	dumpVGAReg(xgifb_info);
> -	return 0;
> -}
> -
> -static int XGIfb_pan_var(struct fb_var_screeninfo *var, struct fb_info *info)
> -{
> -	struct xgifb_video_info *xgifb_info = info->par;
> -	struct vb_device_info *vb = &xgifb_info->dev_info;
> -	unsigned int base;
> -
> -	base = var->yoffset * info->var.xres_virtual + var->xoffset;
> -
> -	/* calculate base bpp dep. */
> -	switch (info->var.bits_per_pixel) {
> -	case 16:
> -		base >>= 1;
> -		break;
> -	case 32:
> -		break;
> -	case 8:
> -	default:
> -		base >>= 2;
> -		break;
> -	}
> -
> -	xgifb_reg_set(vb->P3c4, IND_SIS_PASSWORD, SIS_PASSWORD);
> -
> -	xgifb_reg_set(vb->P3d4, 0x0D, base & 0xFF);
> -	xgifb_reg_set(vb->P3d4, 0x0C, (base >> 8) & 0xFF);
> -	xgifb_reg_set(vb->P3c4, 0x0D, (base >> 16) & 0xFF);
> -	xgifb_reg_set(vb->P3c4, 0x37, (base >> 24) & 0x03);
> -	xgifb_reg_and_or(vb->P3c4, 0x37, 0xDF, (base >> 21) & 0x04);
> -
> -	if (xgifb_info->display2 != XGIFB_DISP_NONE) {
> -		xgifb_reg_or(vb->Part1Port, SIS_CRT2_WENABLE_315, 0x01);
> -		xgifb_reg_set(vb->Part1Port, 0x06, (base & 0xFF));
> -		xgifb_reg_set(vb->Part1Port, 0x05, ((base >> 8) & 0xFF));
> -		xgifb_reg_set(vb->Part1Port, 0x04, ((base >> 16) & 0xFF));
> -		xgifb_reg_and_or(vb->Part1Port, 0x02, 0x7F,
> -				 ((base >> 24) & 0x01) << 7);
> -	}
> -	return 0;
> -}
> -
> -static int XGIfb_open(struct fb_info *info, int user)
> -{
> -	return 0;
> -}
> -
> -static int XGIfb_release(struct fb_info *info, int user)
> -{
> -	return 0;
> -}
> -
> -/* similar to sisfb_get_cmap_len */
> -static int XGIfb_get_cmap_len(const struct fb_var_screeninfo *var)
> -{
> -	return (var->bits_per_pixel == 8) ? 256 : 16;
> -}
> -
> -static int XGIfb_setcolreg(unsigned int regno, unsigned int red,
> -			   unsigned int green, unsigned int blue,
> -			   unsigned int transp, struct fb_info *info)
> -{
> -	struct xgifb_video_info *xgifb_info = info->par;
> -	struct vb_device_info *vb = &xgifb_info->dev_info;
> -
> -	if (regno >= XGIfb_get_cmap_len(&info->var))
> -		return 1;
> -
> -	switch (info->var.bits_per_pixel) {
> -	case 8:
> -		outb(regno, vb->P3c8);
> -		outb((red >> 10), vb->P3c9);
> -		outb((green >> 10), vb->P3c9);
> -		outb((blue >> 10), vb->P3c9);
> -		if (xgifb_info->display2 != XGIFB_DISP_NONE) {
> -			outb(regno, vb->Part5Port);
> -			outb((red >> 8), (vb->Part5Port + 1));
> -			outb((green >> 8), (vb->Part5Port + 1));
> -			outb((blue >> 8), (vb->Part5Port + 1));
> -		}
> -		break;
> -	case 16:
> -		((u32 *)(info->pseudo_palette))[regno] = ((red & 0xf800))
> -				| ((green & 0xfc00) >> 5) | ((blue & 0xf800)
> -				>> 11);
> -		break;
> -	case 32:
> -		red >>= 8;
> -		green >>= 8;
> -		blue >>= 8;
> -		((u32 *)(info->pseudo_palette))[regno] = (red << 16) | (green
> -				<< 8) | (blue);
> -		break;
> -	}
> -	return 0;
> -}
> -
> -/* ----------- FBDev related routines for all series ---------- */
> -
> -static int XGIfb_get_fix(struct fb_fix_screeninfo *fix, int con,
> -			 struct fb_info *info)
> -{
> -	struct xgifb_video_info *xgifb_info = info->par;
> -
> -	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
> -
> -	strncpy(fix->id, "XGI", sizeof(fix->id) - 1);
> -
> -	/* if register_framebuffer has been called, we must lock */
> -	if (atomic_read(&info->count))
> -		mutex_lock(&info->mm_lock);
> -
> -	fix->smem_start = xgifb_info->video_base;
> -	fix->smem_len = xgifb_info->video_size;
> -
> -	/* if register_framebuffer has been called, we can unlock */
> -	if (atomic_read(&info->count))
> -		mutex_unlock(&info->mm_lock);
> -
> -	fix->type = FB_TYPE_PACKED_PIXELS;
> -	fix->type_aux = 0;
> -	if (xgifb_info->video_bpp == 8)
> -		fix->visual = FB_VISUAL_PSEUDOCOLOR;
> -	else
> -		fix->visual = FB_VISUAL_DIRECTCOLOR;
> -	fix->xpanstep = 0;
> -	if (XGIfb_ypan)
> -		fix->ypanstep = 1;
> -	fix->ywrapstep = 0;
> -	fix->line_length = xgifb_info->video_linelength;
> -	fix->mmio_start = xgifb_info->mmio_base;
> -	fix->mmio_len = xgifb_info->mmio_size;
> -	fix->accel = FB_ACCEL_SIS_XABRE;
> -
> -	return 0;
> -}
> -
> -static int XGIfb_set_par(struct fb_info *info)
> -{
> -	int err;
> -
> -	err = XGIfb_do_set_var(&info->var, 1, info);
> -	if (err)
> -		return err;
> -	XGIfb_get_fix(&info->fix, -1, info);
> -	return 0;
> -}
> -
> -static int XGIfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
> -{
> -	struct xgifb_video_info *xgifb_info = info->par;
> -	unsigned int htotal = var->left_margin + var->xres + var->right_margin
> -			+ var->hsync_len;
> -	unsigned int vtotal = 0;
> -	unsigned int drate = 0, hrate = 0;
> -	int found_mode = 0;
> -	int search_idx;
> -
> -	if ((var->vmode & FB_VMODE_MASK) == FB_VMODE_NONINTERLACED) {
> -		vtotal = var->upper_margin + var->yres + var->lower_margin
> -				+ var->vsync_len;
> -		vtotal <<= 1;
> -	} else if ((var->vmode & FB_VMODE_MASK) == FB_VMODE_DOUBLE) {
> -		vtotal = var->upper_margin + var->yres + var->lower_margin
> -				+ var->vsync_len;
> -		vtotal <<= 2;
> -	} else if ((var->vmode & FB_VMODE_MASK) == FB_VMODE_INTERLACED) {
> -		vtotal = var->upper_margin + (var->yres / 2)
> -				+ var->lower_margin + var->vsync_len;
> -	} else
> -		vtotal = var->upper_margin + var->yres + var->lower_margin
> -				+ var->vsync_len;
> -
> -	if (!(htotal) || !(vtotal)) {
> -		pr_debug("No valid timing data\n");
> -		return -EINVAL;
> -	}
> -
> -	if (var->pixclock && htotal && vtotal) {
> -		drate = 1000000000 / var->pixclock;
> -		hrate = (drate * 1000) / htotal;
> -		xgifb_info->refresh_rate =
> -			(unsigned int)(hrate * 2 / vtotal);
> -		pr_debug(
> -			"%s: pixclock = %d ,htotal=%d, vtotal=%d\n"
> -			"%s: drate=%d, hrate=%d, refresh_rate=%d\n",
> -			__func__, var->pixclock, htotal, vtotal,
> -			__func__, drate, hrate, xgifb_info->refresh_rate);
> -	} else {
> -		xgifb_info->refresh_rate = 60;
> -	}
> -
> -	search_idx = 0;
> -	while ((XGIbios_mode[search_idx].mode_no != 0) &&
> -	       (XGIbios_mode[search_idx].xres <= var->xres)) {
> -		if ((XGIbios_mode[search_idx].xres == var->xres) &&
> -		    (XGIbios_mode[search_idx].yres == var->yres) &&
> -		    (XGIbios_mode[search_idx].bpp == var->bits_per_pixel)) {
> -			if (XGIfb_validate_mode(xgifb_info, search_idx) > 0) {
> -				found_mode = 1;
> -				break;
> -			}
> -		}
> -		search_idx++;
> -	}
> -
> -	if (!found_mode) {
> -		pr_err("%dx%dx%d is no valid mode\n",
> -		       var->xres, var->yres, var->bits_per_pixel);
> -		search_idx = 0;
> -		while (XGIbios_mode[search_idx].mode_no != 0) {
> -			if ((var->xres <= XGIbios_mode[search_idx].xres) &&
> -			    (var->yres <= XGIbios_mode[search_idx].yres) &&
> -			    (var->bits_per_pixel ==
> -			     XGIbios_mode[search_idx].bpp)) {
> -				if (XGIfb_validate_mode(xgifb_info,
> -							search_idx) > 0) {
> -					found_mode = 1;
> -					break;
> -				}
> -			}
> -			search_idx++;
> -		}
> -		if (found_mode) {
> -			var->xres = XGIbios_mode[search_idx].xres;
> -			var->yres = XGIbios_mode[search_idx].yres;
> -			pr_debug("Adapted to mode %dx%dx%d\n",
> -				 var->xres, var->yres, var->bits_per_pixel);
> -
> -		} else {
> -			pr_err("Failed to find similar mode to %dx%dx%d\n",
> -			       var->xres, var->yres, var->bits_per_pixel);
> -			return -EINVAL;
> -		}
> -	}
> -
> -	/* Adapt RGB settings */
> -	XGIfb_bpp_to_var(xgifb_info, var);
> -
> -	if (!XGIfb_ypan) {
> -		if (var->xres != var->xres_virtual)
> -			var->xres_virtual = var->xres;
> -		if (var->yres != var->yres_virtual)
> -			var->yres_virtual = var->yres;
> -	}
> -
> -	/* Truncate offsets to maximum if too high */
> -	if (var->xoffset > var->xres_virtual - var->xres)
> -		var->xoffset = var->xres_virtual - var->xres - 1;
> -
> -	if (var->yoffset > var->yres_virtual - var->yres)
> -		var->yoffset = var->yres_virtual - var->yres - 1;
> -
> -	/* Set everything else to 0 */
> -	var->red.msb_right = 0;
> -	var->green.msb_right = 0;
> -	var->blue.msb_right = 0;
> -	var->transp.offset = 0;
> -	var->transp.length = 0;
> -	var->transp.msb_right = 0;
> -
> -	return 0;
> -}
> -
> -static int XGIfb_pan_display(struct fb_var_screeninfo *var,
> -			     struct fb_info *info)
> -{
> -	int err;
> -
> -	if (var->xoffset > (info->var.xres_virtual - info->var.xres))
> -		return -EINVAL;
> -	if (var->yoffset > (info->var.yres_virtual - info->var.yres))
> -		return -EINVAL;
> -
> -	if (var->vmode & FB_VMODE_YWRAP) {
> -		if (var->yoffset >= info->var.yres_virtual || var->xoffset)
> -			return -EINVAL;
> -	} else if (var->xoffset + info->var.xres > info->var.xres_virtual ||
> -		   var->yoffset + info->var.yres > info->var.yres_virtual) {
> -		return -EINVAL;
> -	}
> -	err = XGIfb_pan_var(var, info);
> -	if (err < 0)
> -		return err;
> -
> -	info->var.xoffset = var->xoffset;
> -	info->var.yoffset = var->yoffset;
> -	if (var->vmode & FB_VMODE_YWRAP)
> -		info->var.vmode |= FB_VMODE_YWRAP;
> -	else
> -		info->var.vmode &= ~FB_VMODE_YWRAP;
> -
> -	return 0;
> -}
> -
> -static int XGIfb_blank(int blank, struct fb_info *info)
> -{
> -	struct xgifb_video_info *xgifb_info = info->par;
> -	struct vb_device_info *vb = &xgifb_info->dev_info;
> -	u8 reg;
> -
> -	reg = xgifb_reg_get(vb->P3d4, 0x17);
> -
> -	if (blank > 0)
> -		reg &= 0x7f;
> -	else
> -		reg |= 0x80;
> -
> -	xgifb_reg_set(vb->P3d4, 0x17, reg);
> -	xgifb_reg_set(vb->P3c4, 0x00, 0x01); /* Synchronous Reset */
> -	xgifb_reg_set(vb->P3c4, 0x00, 0x03); /* End Reset */
> -	return 0;
> -}
> -
> -static struct fb_ops XGIfb_ops = {
> -	.owner = THIS_MODULE,
> -	.fb_open = XGIfb_open,
> -	.fb_release = XGIfb_release,
> -	.fb_check_var = XGIfb_check_var,
> -	.fb_set_par = XGIfb_set_par,
> -	.fb_setcolreg = XGIfb_setcolreg,
> -	.fb_pan_display = XGIfb_pan_display,
> -	.fb_blank = XGIfb_blank,
> -	.fb_fillrect = cfb_fillrect,
> -	.fb_copyarea = cfb_copyarea,
> -	.fb_imageblit = cfb_imageblit,
> -};
> -
> -/* ---------------- Chip generation dependent routines ---------------- */
> -
> -/* for XGI 315/550/650/740/330 */
> -
> -static int XGIfb_get_dram_size(struct xgifb_video_info *xgifb_info)
> -{
> -	struct vb_device_info *vb = &xgifb_info->dev_info;
> -	u8 ChannelNum, tmp;
> -	u8 reg = 0;
> -
> -	/* xorg driver sets 32MB * 1 channel */
> -	if (xgifb_info->chip == XG27)
> -		xgifb_reg_set(vb->P3c4, IND_SIS_DRAM_SIZE, 0x51);
> -
> -	reg = xgifb_reg_get(vb->P3c4, IND_SIS_DRAM_SIZE);
> -	if (!reg)
> -		return -1;
> -
> -	switch ((reg & XGI_DRAM_SIZE_MASK) >> 4) {
> -	case XGI_DRAM_SIZE_1MB:
> -		xgifb_info->video_size = 0x100000;
> -		break;
> -	case XGI_DRAM_SIZE_2MB:
> -		xgifb_info->video_size = 0x200000;
> -		break;
> -	case XGI_DRAM_SIZE_4MB:
> -		xgifb_info->video_size = 0x400000;
> -		break;
> -	case XGI_DRAM_SIZE_8MB:
> -		xgifb_info->video_size = 0x800000;
> -		break;
> -	case XGI_DRAM_SIZE_16MB:
> -		xgifb_info->video_size = 0x1000000;
> -		break;
> -	case XGI_DRAM_SIZE_32MB:
> -		xgifb_info->video_size = 0x2000000;
> -		break;
> -	case XGI_DRAM_SIZE_64MB:
> -		xgifb_info->video_size = 0x4000000;
> -		break;
> -	case XGI_DRAM_SIZE_128MB:
> -		xgifb_info->video_size = 0x8000000;
> -		break;
> -	case XGI_DRAM_SIZE_256MB:
> -		xgifb_info->video_size = 0x10000000;
> -		break;
> -	default:
> -		return -1;
> -	}
> -
> -	tmp = (reg & 0x0c) >> 2;
> -	switch (xgifb_info->chip) {
> -	case XG20:
> -	case XG21:
> -	case XG27:
> -		ChannelNum = 1;
> -		break;
> -
> -	case XG42:
> -		if (reg & 0x04)
> -			ChannelNum = 2;
> -		else
> -			ChannelNum = 1;
> -		break;
> -
> -	case XG40:
> -	default:
> -		if (tmp == 2)
> -			ChannelNum = 2;
> -		else if (tmp == 3)
> -			ChannelNum = 3;
> -		else
> -			ChannelNum = 1;
> -		break;
> -	}
> -
> -	xgifb_info->video_size = xgifb_info->video_size * ChannelNum;
> -
> -	pr_info("SR14=%x DramSzie %x ChannelNum %x\n",
> -		reg, xgifb_info->video_size, ChannelNum);
> -	return 0;
> -}
> -
> -static void XGIfb_detect_VB(struct xgifb_video_info *xgifb_info)
> -{
> -	struct vb_device_info *vb = &xgifb_info->dev_info;
> -	u8 cr32, temp = 0;
> -
> -	xgifb_info->TV_plug = 0;
> -	xgifb_info->TV_type = 0;
> -
> -	cr32 = xgifb_reg_get(vb->P3d4, IND_XGI_SCRATCH_REG_CR32);
> -
> -	if ((cr32 & SIS_CRT1) && !XGIfb_crt1off) {
> -		XGIfb_crt1off = 0;
> -	} else {
> -		if (cr32 & 0x5F)
> -			XGIfb_crt1off = 1;
> -		else
> -			XGIfb_crt1off = 0;
> -	}
> -
> -	if (!xgifb_info->display2_force) {
> -		if (cr32 & SIS_VB_TV)
> -			xgifb_info->display2 = XGIFB_DISP_TV;
> -		else if (cr32 & SIS_VB_LCD)
> -			xgifb_info->display2 = XGIFB_DISP_LCD;
> -		else if (cr32 & SIS_VB_CRT2)
> -			xgifb_info->display2 = XGIFB_DISP_CRT;
> -		else
> -			xgifb_info->display2 = XGIFB_DISP_NONE;
> -	}
> -
> -	if (XGIfb_tvplug != -1) {
> -		/* Override with option */
> -		xgifb_info->TV_plug = XGIfb_tvplug;
> -	} else if (cr32 & SIS_VB_HIVISION) {
> -		xgifb_info->TV_type = TVMODE_HIVISION;
> -		xgifb_info->TV_plug = TVPLUG_SVIDEO;
> -	} else if (cr32 & SIS_VB_SVIDEO) {
> -		xgifb_info->TV_plug = TVPLUG_SVIDEO;
> -	} else if (cr32 & SIS_VB_COMPOSITE) {
> -		xgifb_info->TV_plug = TVPLUG_COMPOSITE;
> -	} else if (cr32 & SIS_VB_SCART) {
> -		xgifb_info->TV_plug = TVPLUG_SCART;
> -	}
> -
> -	if (xgifb_info->TV_type == 0) {
> -		temp = xgifb_reg_get(vb->P3d4, 0x38);
> -		if (temp & 0x10)
> -			xgifb_info->TV_type = TVMODE_PAL;
> -		else
> -			xgifb_info->TV_type = TVMODE_NTSC;
> -	}
> -
> -	/* Copy forceCRT1 option to CRT1off if option is given */
> -	if (XGIfb_forcecrt1 != -1) {
> -		if (XGIfb_forcecrt1)
> -			XGIfb_crt1off = 0;
> -		else
> -			XGIfb_crt1off = 1;
> -	}
> -}
> -
> -static bool XGIfb_has_VB(struct xgifb_video_info *xgifb_info)
> -{
> -	u8 vb_chipid;
> -
> -	vb_chipid = xgifb_reg_get(xgifb_info->dev_info.Part4Port, 0x00);
> -	switch (vb_chipid) {
> -	case 0x01:
> -		xgifb_info->hasVB = HASVB_301;
> -		break;
> -	case 0x02:
> -		xgifb_info->hasVB = HASVB_302;
> -		break;
> -	default:
> -		xgifb_info->hasVB = HASVB_NONE;
> -		return false;
> -	}
> -	return true;
> -}
> -
> -static void XGIfb_get_VB_type(struct xgifb_video_info *xgifb_info)
> -{
> -	u8 reg;
> -
> -	if (!XGIfb_has_VB(xgifb_info)) {
> -		reg = xgifb_reg_get(xgifb_info->dev_info.P3d4,
> -				    IND_XGI_SCRATCH_REG_CR37);
> -		switch ((reg & SIS_EXTERNAL_CHIP_MASK) >> 1) {
> -		case SIS_EXTERNAL_CHIP_LVDS:
> -			xgifb_info->hasVB = HASVB_LVDS;
> -			break;
> -		case SIS_EXTERNAL_CHIP_LVDS_CHRONTEL:
> -			xgifb_info->hasVB = HASVB_LVDS_CHRONTEL;
> -			break;
> -		default:
> -			break;
> -		}
> -	}
> -}
> -
> -static int __init xgifb_optval(char *fullopt, int validx)
> -{
> -	unsigned long lres;
> -
> -	if (kstrtoul(fullopt + validx, 0, &lres) < 0 || lres > INT_MAX) {
> -		pr_err("Invalid value for option: %s\n", fullopt);
> -		return 0;
> -	}
> -	return lres;
> -}
> -
> -static int __init XGIfb_setup(char *options)
> -{
> -	char *this_opt;
> -
> -	if (!options || !*options)
> -		return 0;
> -
> -	pr_info("Options: %s\n", options);
> -
> -	while ((this_opt = strsep(&options, ",")) != NULL) {
> -		if (!*this_opt)
> -			continue;
> -
> -		if (!strncmp(this_opt, "mode:", 5)) {
> -			mode = this_opt + 5;
> -		} else if (!strncmp(this_opt, "vesa:", 5)) {
> -			vesa = xgifb_optval(this_opt, 5);
> -		} else if (!strncmp(this_opt, "vrate:", 6)) {
> -			refresh_rate = xgifb_optval(this_opt, 6);
> -		} else if (!strncmp(this_opt, "rate:", 5)) {
> -			refresh_rate = xgifb_optval(this_opt, 5);
> -		} else if (!strncmp(this_opt, "crt1off", 7)) {
> -			XGIfb_crt1off = 1;
> -		} else if (!strncmp(this_opt, "filter:", 7)) {
> -			filter = xgifb_optval(this_opt, 7);
> -		} else if (!strncmp(this_opt, "forcecrt2type:", 14)) {
> -			XGIfb_search_crt2type(this_opt + 14);
> -		} else if (!strncmp(this_opt, "forcecrt1:", 10)) {
> -			XGIfb_forcecrt1 = xgifb_optval(this_opt, 10);
> -		} else if (!strncmp(this_opt, "tvmode:", 7)) {
> -			XGIfb_search_tvstd(this_opt + 7);
> -		} else if (!strncmp(this_opt, "tvstandard:", 11)) {
> -			XGIfb_search_tvstd(this_opt + 7);
> -		} else if (!strncmp(this_opt, "dstn", 4)) {
> -			enable_dstn = 1;
> -			/* DSTN overrules forcecrt2type */
> -			XGIfb_crt2type = XGIFB_DISP_LCD;
> -		} else if (!strncmp(this_opt, "noypan", 6)) {
> -			XGIfb_ypan = 0;
> -		} else {
> -			mode = this_opt;
> -		}
> -	}
> -	return 0;
> -}
> -
> -static int xgifb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> -{
> -	u8 reg, reg1;
> -	u8 CR48, CR38;
> -	int ret;
> -	struct fb_info *fb_info;
> -	struct xgifb_video_info *xgifb_info;
> -	struct vb_device_info *vb;
> -	struct xgi_hw_device_info *hw_info;
> -	unsigned long video_size_max;
> -
> -	fb_info = framebuffer_alloc(sizeof(*xgifb_info), &pdev->dev);
> -	if (!fb_info)
> -		return -ENOMEM;
> -
> -	xgifb_info = fb_info->par;
> -	vb = &xgifb_info->dev_info;
> -	hw_info = &xgifb_info->hw_info;
> -	xgifb_info->fb_info = fb_info;
> -	xgifb_info->chip_id = pdev->device;
> -	pci_read_config_byte(pdev,
> -			     PCI_REVISION_ID,
> -			     &xgifb_info->revision_id);
> -	hw_info->jChipRevision = xgifb_info->revision_id;
> -
> -	xgifb_info->pcibus = pdev->bus->number;
> -	xgifb_info->pcislot = PCI_SLOT(pdev->devfn);
> -	xgifb_info->pcifunc = PCI_FUNC(pdev->devfn);
> -	xgifb_info->subsysvendor = pdev->subsystem_vendor;
> -	xgifb_info->subsysdevice = pdev->subsystem_device;
> -
> -	video_size_max = pci_resource_len(pdev, 0);
> -	xgifb_info->video_base = pci_resource_start(pdev, 0);
> -	xgifb_info->mmio_base = pci_resource_start(pdev, 1);
> -	xgifb_info->mmio_size = pci_resource_len(pdev, 1);
> -	xgifb_info->vga_base = pci_resource_start(pdev, 2) + 0x30;
> -	dev_info(&pdev->dev, "Relocate IO address: %llx [%08lx]\n",
> -		 (u64)pci_resource_start(pdev, 2),
> -		 xgifb_info->vga_base);
> -
> -	if (pci_enable_device(pdev)) {
> -		ret = -EIO;
> -		goto error;
> -	}
> -
> -	if (XGIfb_crt2type != -1) {
> -		xgifb_info->display2 = XGIfb_crt2type;
> -		xgifb_info->display2_force = true;
> -	}
> -
> -	XGIRegInit(vb, xgifb_info->vga_base);
> -
> -	xgifb_reg_set(vb->P3c4,
> -		      IND_SIS_PASSWORD, SIS_PASSWORD);
> -	reg1 = xgifb_reg_get(vb->P3c4, IND_SIS_PASSWORD);
> -
> -	if (reg1 != 0xa1) { /* I/O error */
> -		dev_err(&pdev->dev, "I/O error\n");
> -		ret = -EIO;
> -		goto error_disable;
> -	}
> -
> -	switch (xgifb_info->chip_id) {
> -	case PCI_DEVICE_ID_XGI_20:
> -		xgifb_reg_or(vb->P3d4,
> -			     Index_CR_GPIO_Reg3, GPIOG_EN);
> -		CR48 = xgifb_reg_get(vb->P3d4,
> -				     Index_CR_GPIO_Reg1);
> -		if (CR48 & GPIOG_READ)
> -			xgifb_info->chip = XG21;
> -		else
> -			xgifb_info->chip = XG20;
> -		break;
> -	case PCI_DEVICE_ID_XGI_40:
> -		xgifb_info->chip = XG40;
> -		break;
> -	case PCI_DEVICE_ID_XGI_42:
> -		xgifb_info->chip = XG42;
> -		break;
> -	case PCI_DEVICE_ID_XGI_27:
> -		xgifb_info->chip = XG27;
> -		break;
> -	default:
> -		ret = -ENODEV;
> -		goto error_disable;
> -	}
> -
> -	dev_info(&pdev->dev, "chipid = %x\n", xgifb_info->chip);
> -	hw_info->jChipType = xgifb_info->chip;
> -
> -	if (XGIfb_get_dram_size(xgifb_info)) {
> -		xgifb_info->video_size = min_t(unsigned long, video_size_max,
> -					       SZ_16M);
> -	} else if (xgifb_info->video_size > video_size_max) {
> -		xgifb_info->video_size = video_size_max;
> -	}
> -
> -	/* Enable PCI_LINEAR_ADDRESSING and MMIO_ENABLE */
> -	xgifb_reg_or(vb->P3c4,
> -		     IND_SIS_PCI_ADDRESS_SET,
> -		     (SIS_PCI_ADDR_ENABLE | SIS_MEM_MAP_IO_ENABLE));
> -	/* Enable 2D accelerator engine */
> -	xgifb_reg_or(vb->P3c4,
> -		     IND_SIS_MODULE_ENABLE, SIS_ENABLE_2D);
> -
> -	hw_info->ulVideoMemorySize = xgifb_info->video_size;
> -
> -	if (!request_mem_region(xgifb_info->video_base,
> -				xgifb_info->video_size,
> -				"XGIfb FB")) {
> -		dev_err(&pdev->dev, "Unable request memory size %x\n",
> -			xgifb_info->video_size);
> -		dev_err(&pdev->dev,
> -			"Fatal error: Unable to reserve frame buffer memory. Is there another framebuffer driver active?\n");
> -		ret = -ENODEV;
> -		goto error_disable;
> -	}
> -
> -	if (!request_mem_region(xgifb_info->mmio_base,
> -				xgifb_info->mmio_size,
> -				"XGIfb MMIO")) {
> -		dev_err(&pdev->dev,
> -			"Fatal error: Unable to reserve MMIO region\n");
> -		ret = -ENODEV;
> -		goto error_0;
> -	}
> -
> -	xgifb_info->video_vbase =
> -		ioremap_wc(xgifb_info->video_base, xgifb_info->video_size);
> -	hw_info->pjVideoMemoryAddress =
> -		ioremap_wc(xgifb_info->video_base, xgifb_info->video_size);
> -	xgifb_info->mmio_vbase = ioremap(xgifb_info->mmio_base,
> -					 xgifb_info->mmio_size);
> -
> -	dev_info(&pdev->dev,
> -		 "Framebuffer at 0x%llx, mapped to 0x%p, size %dk\n",
> -		 (u64)xgifb_info->video_base,
> -		 xgifb_info->video_vbase,
> -		 xgifb_info->video_size / 1024);
> -
> -	dev_info(&pdev->dev,
> -		 "MMIO at 0x%llx, mapped to 0x%p, size %ldk\n",
> -		 (u64)xgifb_info->mmio_base, xgifb_info->mmio_vbase,
> -		 xgifb_info->mmio_size / 1024);
> -
> -	pci_set_drvdata(pdev, xgifb_info);
> -	if (!XGIInitNew(pdev))
> -		dev_err(&pdev->dev, "XGIInitNew() failed!\n");
> -
> -	xgifb_info->mtrr = -1;
> -
> -	xgifb_info->hasVB = HASVB_NONE;
> -	if ((xgifb_info->chip == XG20) ||
> -	    (xgifb_info->chip == XG27)) {
> -		xgifb_info->hasVB = HASVB_NONE;
> -	} else if (xgifb_info->chip == XG21) {
> -		CR38 = xgifb_reg_get(vb->P3d4, 0x38);
> -		if ((CR38 & 0xE0) == 0xC0)
> -			xgifb_info->display2 = XGIFB_DISP_LCD;
> -		else if ((CR38 & 0xE0) == 0x60)
> -			xgifb_info->hasVB = HASVB_CHRONTEL;
> -		else
> -			xgifb_info->hasVB = HASVB_NONE;
> -	} else {
> -		XGIfb_get_VB_type(xgifb_info);
> -	}
> -
> -	hw_info->ujVBChipID = VB_CHIP_UNKNOWN;
> -
> -	hw_info->ulExternalChip = 0;
> -
> -	switch (xgifb_info->hasVB) {
> -	case HASVB_301:
> -		reg = xgifb_reg_get(vb->Part4Port, 0x01);
> -		if (reg >= 0xE0) {
> -			hw_info->ujVBChipID = VB_CHIP_302LV;
> -			dev_info(&pdev->dev,
> -				 "XGI302LV bridge detected (revision 0x%02x)\n",
> -				 reg);
> -		} else if (reg >= 0xD0) {
> -			hw_info->ujVBChipID = VB_CHIP_301LV;
> -			dev_info(&pdev->dev,
> -				 "XGI301LV bridge detected (revision 0x%02x)\n",
> -				 reg);
> -		} else {
> -			hw_info->ujVBChipID = VB_CHIP_301;
> -			dev_info(&pdev->dev, "XGI301 bridge detected\n");
> -		}
> -		break;
> -	case HASVB_302:
> -		reg = xgifb_reg_get(vb->Part4Port, 0x01);
> -		if (reg >= 0xE0) {
> -			hw_info->ujVBChipID = VB_CHIP_302LV;
> -			dev_info(&pdev->dev,
> -				 "XGI302LV bridge detected (revision 0x%02x)\n",
> -				 reg);
> -		} else if (reg >= 0xD0) {
> -			hw_info->ujVBChipID = VB_CHIP_301LV;
> -			dev_info(&pdev->dev,
> -				 "XGI302LV bridge detected (revision 0x%02x)\n",
> -				 reg);
> -		} else if (reg >= 0xB0) {
> -			reg1 = xgifb_reg_get(vb->Part4Port,
> -					     0x23);
> -
> -			hw_info->ujVBChipID = VB_CHIP_302B;
> -
> -		} else {
> -			hw_info->ujVBChipID = VB_CHIP_302;
> -			dev_info(&pdev->dev, "XGI302 bridge detected\n");
> -		}
> -		break;
> -	case HASVB_LVDS:
> -		hw_info->ulExternalChip = 0x1;
> -		dev_info(&pdev->dev, "LVDS transmitter detected\n");
> -		break;
> -	case HASVB_TRUMPION:
> -		hw_info->ulExternalChip = 0x2;
> -		dev_info(&pdev->dev, "Trumpion Zurac LVDS scaler detected\n");
> -		break;
> -	case HASVB_CHRONTEL:
> -		hw_info->ulExternalChip = 0x4;
> -		dev_info(&pdev->dev, "Chrontel TV encoder detected\n");
> -		break;
> -	case HASVB_LVDS_CHRONTEL:
> -		hw_info->ulExternalChip = 0x5;
> -		dev_info(&pdev->dev,
> -			 "LVDS transmitter and Chrontel TV encoder detected\n");
> -		break;
> -	default:
> -		dev_info(&pdev->dev, "No or unknown bridge type detected\n");
> -		break;
> -	}
> -
> -	if (xgifb_info->hasVB != HASVB_NONE)
> -		XGIfb_detect_VB(xgifb_info);
> -	else if (xgifb_info->chip != XG21)
> -		xgifb_info->display2 = XGIFB_DISP_NONE;
> -
> -	if (xgifb_info->display2 == XGIFB_DISP_LCD) {
> -		if (!enable_dstn) {
> -			reg = xgifb_reg_get(vb->P3d4,
> -					    IND_XGI_LCD_PANEL);
> -			reg &= 0x0f;
> -			hw_info->ulCRT2LCDType = XGI310paneltype[reg];
> -		}
> -	}
> -
> -	xgifb_info->mode_idx = -1;
> -
> -	if (mode)
> -		XGIfb_search_mode(xgifb_info, mode);
> -	else if (vesa != -1)
> -		XGIfb_search_vesamode(xgifb_info, vesa);
> -
> -	if (xgifb_info->mode_idx >= 0)
> -		xgifb_info->mode_idx =
> -			XGIfb_validate_mode(xgifb_info, xgifb_info->mode_idx);
> -
> -	if (xgifb_info->mode_idx < 0) {
> -		if (xgifb_info->display2 == XGIFB_DISP_LCD &&
> -		    xgifb_info->chip == XG21)
> -			xgifb_info->mode_idx =
> -				XGIfb_GetXG21DefaultLVDSModeIdx(xgifb_info);
> -		else
> -			xgifb_info->mode_idx = DEFAULT_MODE;
> -	}
> -
> -	if (xgifb_info->mode_idx < 0) {
> -		dev_err(&pdev->dev, "No supported video mode found\n");
> -		ret = -EINVAL;
> -		goto error_1;
> -	}
> -
> -	/* set default refresh rate */
> -	xgifb_info->refresh_rate = refresh_rate;
> -	if (xgifb_info->refresh_rate == 0)
> -		xgifb_info->refresh_rate = 60;
> -	if (XGIfb_search_refresh_rate(xgifb_info, xgifb_info->refresh_rate) == 0) {
> -		xgifb_info->rate_idx = 1;
> -		xgifb_info->refresh_rate = 60;
> -	}
> -
> -	xgifb_info->video_bpp = XGIbios_mode[xgifb_info->mode_idx].bpp;
> -	xgifb_info->video_vwidth =
> -		xgifb_info->video_width =
> -			XGIbios_mode[xgifb_info->mode_idx].xres;
> -	xgifb_info->video_vheight =
> -		xgifb_info->video_height =
> -			XGIbios_mode[xgifb_info->mode_idx].yres;
> -	xgifb_info->org_x = 0;
> -	xgifb_info->org_y = 0;
> -	xgifb_info->video_linelength =
> -		xgifb_info->video_width *
> -		(xgifb_info->video_bpp >> 3);
> -	switch (xgifb_info->video_bpp) {
> -	case 8:
> -		xgifb_info->DstColor = 0x0000;
> -		xgifb_info->XGI310_AccelDepth = 0x00000000;
> -		xgifb_info->video_cmap_len = 256;
> -		break;
> -	case 16:
> -		xgifb_info->DstColor = 0x8000;
> -		xgifb_info->XGI310_AccelDepth = 0x00010000;
> -		xgifb_info->video_cmap_len = 16;
> -		break;
> -	case 32:
> -		xgifb_info->DstColor = 0xC000;
> -		xgifb_info->XGI310_AccelDepth = 0x00020000;
> -		xgifb_info->video_cmap_len = 16;
> -		break;
> -	default:
> -		xgifb_info->video_cmap_len = 16;
> -		pr_info("Unsupported depth %d\n",
> -			xgifb_info->video_bpp);
> -		break;
> -	}
> -
> -	pr_info("Default mode is %dx%dx%d (%dHz)\n",
> -		xgifb_info->video_width, xgifb_info->video_height,
> -		xgifb_info->video_bpp, xgifb_info->refresh_rate);
> -
> -	fb_info->var.red.length		= 8;
> -	fb_info->var.green.length	= 8;
> -	fb_info->var.blue.length	= 8;
> -	fb_info->var.activate		= FB_ACTIVATE_NOW;
> -	fb_info->var.height		= -1;
> -	fb_info->var.width		= -1;
> -	fb_info->var.vmode		= FB_VMODE_NONINTERLACED;
> -	fb_info->var.xres		= xgifb_info->video_width;
> -	fb_info->var.xres_virtual	= xgifb_info->video_width;
> -	fb_info->var.yres		= xgifb_info->video_height;
> -	fb_info->var.yres_virtual	= xgifb_info->video_height;
> -	fb_info->var.bits_per_pixel	= xgifb_info->video_bpp;
> -
> -	XGIfb_bpp_to_var(xgifb_info, &fb_info->var);
> -
> -	fb_info->var.pixclock = (u32)(1000000000 / XGIfb_mode_rate_to_dclock
> -				      (vb, hw_info,
> -				       XGIbios_mode[xgifb_info->mode_idx].mode_no));
> -
> -	if (XGIfb_mode_rate_to_ddata(vb, hw_info,
> -				     XGIbios_mode[xgifb_info->mode_idx].mode_no,
> -				     &fb_info->var.left_margin,
> -				     &fb_info->var.right_margin,
> -				     &fb_info->var.upper_margin,
> -				     &fb_info->var.lower_margin,
> -				     &fb_info->var.hsync_len,
> -				     &fb_info->var.vsync_len,
> -				     &fb_info->var.sync,
> -				     &fb_info->var.vmode)) {
> -		if ((fb_info->var.vmode & FB_VMODE_MASK) ==
> -		    FB_VMODE_INTERLACED) {
> -			fb_info->var.yres <<= 1;
> -			fb_info->var.yres_virtual <<= 1;
> -		} else if ((fb_info->var.vmode & FB_VMODE_MASK) ==
> -			   FB_VMODE_DOUBLE) {
> -			fb_info->var.pixclock >>= 1;
> -			fb_info->var.yres >>= 1;
> -			fb_info->var.yres_virtual >>= 1;
> -		}
> -	}
> -
> -	fb_info->flags = FBINFO_FLAG_DEFAULT;
> -	fb_info->screen_base = xgifb_info->video_vbase;
> -	fb_info->fbops = &XGIfb_ops;
> -	XGIfb_get_fix(&fb_info->fix, -1, fb_info);
> -	fb_info->pseudo_palette = xgifb_info->pseudo_palette;
> -
> -	fb_alloc_cmap(&fb_info->cmap, 256, 0);
> -
> -	xgifb_info->mtrr = arch_phys_wc_add(xgifb_info->video_base,
> -					    xgifb_info->video_size);
> -
> -	if (register_framebuffer(fb_info) < 0) {
> -		ret = -EINVAL;
> -		goto error_mtrr;
> -	}
> -
> -	dumpVGAReg(xgifb_info);
> -
> -	return 0;
> -
> -error_mtrr:
> -	arch_phys_wc_del(xgifb_info->mtrr);
> -error_1:
> -	iounmap(xgifb_info->mmio_vbase);
> -	iounmap(xgifb_info->video_vbase);
> -	release_mem_region(xgifb_info->mmio_base, xgifb_info->mmio_size);
> -error_0:
> -	release_mem_region(xgifb_info->video_base, xgifb_info->video_size);
> -error_disable:
> -	pci_disable_device(pdev);
> -error:
> -	framebuffer_release(fb_info);
> -	return ret;
> -}
> -
> -/* -------------------- PCI DEVICE HANDLING -------------------- */
> -
> -static void xgifb_remove(struct pci_dev *pdev)
> -{
> -	struct xgifb_video_info *xgifb_info = pci_get_drvdata(pdev);
> -	struct fb_info *fb_info = xgifb_info->fb_info;
> -
> -	unregister_framebuffer(fb_info);
> -	arch_phys_wc_del(xgifb_info->mtrr);
> -	iounmap(xgifb_info->mmio_vbase);
> -	iounmap(xgifb_info->video_vbase);
> -	release_mem_region(xgifb_info->mmio_base, xgifb_info->mmio_size);
> -	release_mem_region(xgifb_info->video_base, xgifb_info->video_size);
> -	pci_disable_device(pdev);
> -	framebuffer_release(fb_info);
> -}
> -
> -static struct pci_driver xgifb_driver = {
> -	.name = "xgifb",
> -	.id_table = xgifb_pci_table,
> -	.probe = xgifb_probe,
> -	.remove = xgifb_remove
> -};
> -
> -/* -------------------- MODULE -------------------- */
> -
> -module_param(mode, charp, 0000);
> -MODULE_PARM_DESC(mode,
> -		 "Selects the desired default display mode in the format XxYxDepth (eg. 1024x768x16).");
> -
> -module_param(forcecrt2type, charp, 0000);
> -MODULE_PARM_DESC(forcecrt2type,
> -		 "Force the second display output type. Possible values are NONE, LCD, TV, VGA, SVIDEO or COMPOSITE.");
> -
> -module_param(vesa, int, 0000);
> -MODULE_PARM_DESC(vesa,
> -		 "Selects the desired default display mode by VESA mode number (eg. 0x117).");
> -
> -module_param(filter, int, 0000);
> -MODULE_PARM_DESC(filter,
> -		 "Selects TV flicker filter type (only for systems with a SiS301 video bridge). Possible values 0-7. Default: [no filter]).");
> -
> -static int __init xgifb_init(void)
> -{
> -	char *option = NULL;
> -
> -	if (forcecrt2type)
> -		XGIfb_search_crt2type(forcecrt2type);
> -	if (fb_get_options("xgifb", &option))
> -		return -ENODEV;
> -	XGIfb_setup(option);
> -
> -	return pci_register_driver(&xgifb_driver);
> -}
> -
> -static void __exit xgifb_remove_module(void)
> -{
> -	pci_unregister_driver(&xgifb_driver);
> -	pr_debug("Module unloaded\n");
> -}
> -
> -MODULE_DESCRIPTION("Z7 Z9 Z9S Z11 framebuffer device driver");
> -MODULE_LICENSE("GPL");
> -MODULE_AUTHOR("XGITECH , Others");
> -module_init(xgifb_init);
> -module_exit(xgifb_remove_module);
> diff --git a/drivers/staging/xgifb/XGIfb.h b/drivers/staging/xgifb/XGIfb.h
> deleted file mode 100644
> index 982c676c16c6..000000000000
> --- a/drivers/staging/xgifb/XGIfb.h
> +++ /dev/null
> @@ -1,109 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _LINUX_XGIFB
> -#define _LINUX_XGIFB
> -#include "vgatypes.h"
> -#include "vb_struct.h"
> -
> -enum xgifb_display_type {
> -	XGIFB_DISP_NONE = 0,
> -	XGIFB_DISP_CRT,
> -	XGIFB_DISP_LCD,
> -	XGIFB_DISP_TV,
> -};
> -
> -#define HASVB_NONE	    0x00
> -#define HASVB_301	    0x01
> -#define HASVB_LVDS	    0x02
> -#define HASVB_TRUMPION	    0x04
> -#define HASVB_LVDS_CHRONTEL 0x10
> -#define HASVB_302	    0x20
> -#define HASVB_CHRONTEL	    0x80
> -
> -enum XGI_CHIP_TYPE {
> -	XG40 = 32,
> -	XG42,
> -	XG20 = 48,
> -	XG21,
> -	XG27,
> -};
> -
> -enum xgi_tvtype {
> -	TVMODE_NTSC = 0,
> -	TVMODE_PAL,
> -	TVMODE_HIVISION,
> -	TVTYPE_PALM,
> -	TVTYPE_PALN,
> -	TVTYPE_NTSCJ,
> -	TVMODE_TOTAL
> -};
> -
> -enum xgi_tv_plug {
> -	TVPLUG_UNKNOWN = 0,
> -	TVPLUG_COMPOSITE = 1,
> -	TVPLUG_SVIDEO = 2,
> -	TVPLUG_COMPOSITE_AND_SVIDEO = 3,
> -	TVPLUG_SCART = 4,
> -	TVPLUG_YPBPR_525i = 5,
> -	TVPLUG_YPBPR_525P = 6,
> -	TVPLUG_YPBPR_750P = 7,
> -	TVPLUG_YPBPR_1080i = 8,
> -	TVPLUG_TOTAL
> -};
> -
> -struct xgifb_video_info {
> -	struct fb_info *fb_info;
> -	struct xgi_hw_device_info hw_info;
> -	struct vb_device_info dev_info;
> -
> -	int mode_idx;
> -	int rate_idx;
> -
> -	u32 pseudo_palette[17];
> -
> -	int           chip_id;
> -	unsigned int  video_size;
> -	phys_addr_t   video_base;
> -	void __iomem *video_vbase;
> -	phys_addr_t   mmio_base;
> -	unsigned long mmio_size;
> -	void __iomem *mmio_vbase;
> -	unsigned long vga_base;
> -	int mtrr;
> -
> -	int    video_bpp;
> -	int    video_cmap_len;
> -	int    video_width;
> -	int    video_height;
> -	int    video_vwidth;
> -	int    video_vheight;
> -	int    org_x;
> -	int    org_y;
> -	int    video_linelength;
> -	unsigned int refresh_rate;
> -
> -	enum xgifb_display_type display2; /* the second display output type */
> -	bool display2_force;
> -	unsigned char hasVB;
> -	unsigned char TV_type;
> -	unsigned char TV_plug;
> -
> -	struct XGI21_LVDSCapStruct lvds_data;
> -
> -	enum XGI_CHIP_TYPE chip;
> -	unsigned char revision_id;
> -
> -	unsigned short DstColor;
> -	unsigned long  XGI310_AccelDepth;
> -	unsigned long  CommandReg;
> -
> -	unsigned int   pcibus;
> -	unsigned int   pcislot;
> -	unsigned int   pcifunc;
> -
> -	unsigned short subsysvendor;
> -	unsigned short subsysdevice;
> -
> -	char reserved[236];
> -};
> -
> -#endif
> diff --git a/drivers/staging/xgifb/vb_def.h b/drivers/staging/xgifb/vb_def.h
> deleted file mode 100644
> index 0311e2682d27..000000000000
> --- a/drivers/staging/xgifb/vb_def.h
> +++ /dev/null
> @@ -1,257 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _VB_DEF_
> -#define _VB_DEF_
> -#include "../../video/fbdev/sis/initdef.h"
> -
> -#define VB_XGI301C      0x0020 /* for 301C */
> -
> -#define SupportCRT2in301C       0x0100  /* for 301C */
> -#define SetCHTVOverScan         0x8000
> -
> -#define PanelResInfo            0x1F /* CR36 Panel Type/LCDResInfo */
> -#define Panel_1024x768x75        0x22
> -#define Panel_1280x1024x75       0x23
> -
> -#define PanelRef60Hz            0x00
> -#define PanelRef75Hz            0x20
> -
> -#define YPbPr525iVCLK           0x03B
> -#define YPbPr525iVCLK_2         0x03A
> -
> -#define XGI_CRT2_PORT_00        (0x00 - 0x030)
> -
> -#define SupportAllCRT2      0x0078
> -#define NoSupportTV         0x0070
> -#define NoSupportHiVisionTV 0x0060
> -#define NoSupportLCD        0x0058
> -
> -/* -------------- SetMode Stack/Scratch */
> -#define XGI_SetCRT2ToLCDA   0x0100
> -#define SetCRT2ToDualEdge   0x8000
> -
> -#define ReserveTVOption     0x0008
> -
> -#define SetTVLowResolution   0x0400
> -#define TVSimuMode           0x0800
> -#define RPLLDIV2XO           0x1000
> -#define NTSC1024x768         0x2000
> -#define SetTVLockMode        0x4000
> -
> -#define XGI_LCDVESATiming    0x0001 /* LCD Info/CR37 */
> -#define XGI_EnableLVDSDDA    0x0002
> -#define EnableScalingLCD     0x0008
> -#define SetPWDEnable         0x0004
> -#define SetLCDtoNonExpanding 0x0010
> -#define SetLCDDualLink       0x0100
> -#define SetLCDLowResolution  0x0200
> -
> -/* LCD Capability shampoo */
> -#define DefaultLCDCap        0x80ea
> -#define EnableLCD24bpp       0x0004 /* default */
> -#define LCDPolarity          0x00c0 /* default: SyncNN */
> -#define XGI_LCDDualLink      0x0100
> -#define EnableSpectrum       0x0200
> -#define PWDEnable            0x0400
> -#define EnableVBCLKDRVLOW    0x4000
> -#define EnablePLLSPLOW       0x8000
> -
> -#define AVIDEOSense          0x01   /* CR32 */
> -#define SVIDEOSense          0x02
> -#define SCARTSense           0x04
> -#define LCDSense             0x08
> -#define Monitor2Sense        0x10
> -#define Monitor1Sense        0x20
> -#define HiTVSense            0x40
> -
> -#define YPbPrSense           0x80   /* NEW SCRATCH */
> -
> -#define TVSense              0xc7
> -
> -#define YPbPrMode            0xe0
> -#define YPbPrMode525i        0x00
> -#define YPbPrMode525p        0x20
> -#define YPbPrMode750p        0x40
> -#define YPbPrMode1080i       0x60
> -
> -#define ScalingLCD           0x08
> -
> -#define SetYPbPr             0x04
> -
> -/* ---------------------- VUMA Information */
> -#define DisplayDeviceFromCMOS 0x10
> -
> -/* ---------------------- HK Evnet Definition */
> -#define XGI_ModeSwitchStatus  0xf0
> -#define ActiveCRT1            0x10
> -#define ActiveLCD             0x0020
> -#define ActiveTV              0x40
> -#define ActiveCRT2            0x80
> -
> -#define ActiveAVideo          0x01
> -#define ActiveSVideo          0x02
> -#define ActiveSCART           0x04
> -#define ActiveHiTV            0x08
> -#define ActiveYPbPr           0x10
> -
> -#define NTSC1024x768HT       1908
> -
> -#define YPbPrTV525iHT        1716 /* YPbPr */
> -#define YPbPrTV525iVT         525
> -#define YPbPrTV525pHT        1716
> -#define YPbPrTV525pVT         525
> -#define YPbPrTV750pHT        1650
> -#define YPbPrTV750pVT         750
> -
> -#define VCLK25_175           0x00
> -#define VCLK28_322           0x01
> -#define VCLK31_5             0x02
> -#define VCLK36               0x03
> -#define VCLK43_163           0x05
> -#define VCLK44_9             0x06
> -#define VCLK49_5             0x07
> -#define VCLK50               0x08
> -#define VCLK52_406           0x09
> -#define VCLK56_25            0x0A
> -#define VCLK68_179           0x0D
> -#define VCLK72_852           0x0E
> -#define VCLK75               0x0F
> -#define VCLK78_75            0x11
> -#define VCLK79_411           0x12
> -#define VCLK83_95            0x13
> -#define VCLK86_6             0x15
> -#define VCLK94_5             0x16
> -#define VCLK113_309          0x1B
> -#define VCLK116_406          0x1C
> -#define VCLK135_5            0x1E
> -#define VCLK139_054          0x1F
> -#define VCLK157_5            0x20
> -#define VCLK162              0x21
> -#define VCLK175              0x22
> -#define VCLK189              0x23
> -#define VCLK202_5            0x25
> -#define VCLK229_5            0x26
> -#define VCLK234              0x27
> -#define VCLK254_817          0x29
> -#define VCLK266_952          0x2B
> -#define VCLK269_655          0x2C
> -#define VCLK277_015          0x2E
> -#define VCLK291_132          0x30
> -#define VCLK291_766          0x31
> -#define VCLK315_195          0x33
> -#define VCLK323_586          0x34
> -#define VCLK330_615          0x35
> -#define VCLK340_477          0x37
> -#define VCLK375_847          0x38
> -#define VCLK388_631          0x39
> -#define VCLK125_999          0x51
> -#define VCLK148_5            0x52
> -#define VCLK217_325          0x55
> -#define XGI_YPbPr750pVCLK    0x57
> -
> -#define VCLK39_77            0x40
> -#define YPbPr525pVCLK        0x3A
> -#define NTSC1024VCLK         0x41
> -#define VCLK35_2             0x49 /* ; 800x480 */
> -#define VCLK122_61           0x4A
> -#define VCLK80_350           0x4B
> -#define VCLK107_385          0x4C
> -
> -#define RES320x200           0x00
> -#define RES320x240           0x01
> -#define RES400x300           0x02
> -#define RES512x384           0x03
> -#define RES640x400           0x04
> -#define RES640x480x60        0x05
> -#define RES640x480x72        0x06
> -#define RES640x480x75        0x07
> -#define RES640x480x85        0x08
> -#define RES640x480x100       0x09
> -#define RES640x480x120       0x0A
> -#define RES640x480x160       0x0B
> -#define RES640x480x200       0x0C
> -#define RES800x600x56        0x0D
> -#define RES800x600x60        0x0E
> -#define RES800x600x72        0x0F
> -#define RES800x600x75        0x10
> -#define RES800x600x85        0x11
> -#define RES800x600x100       0x12
> -#define RES800x600x120       0x13
> -#define RES800x600x160       0x14
> -#define RES1024x768x43       0x15
> -#define RES1024x768x60       0x16
> -#define RES1024x768x70       0x17
> -#define RES1024x768x75       0x18
> -#define RES1024x768x85       0x19
> -#define RES1024x768x100      0x1A
> -#define RES1024x768x120      0x1B
> -#define RES1280x1024x43      0x1C
> -#define RES1280x1024x60      0x1D
> -#define RES1280x1024x75      0x1E
> -#define RES1280x1024x85      0x1F
> -#define RES1600x1200x60      0x20
> -#define RES1600x1200x65      0x21
> -#define RES1600x1200x70      0x22
> -#define RES1600x1200x75      0x23
> -#define RES1600x1200x85      0x24
> -#define RES1600x1200x100     0x25
> -#define RES1600x1200x120     0x26
> -#define RES1920x1440x60      0x27
> -#define RES1920x1440x65      0x28
> -#define RES1920x1440x70      0x29
> -#define RES1920x1440x75      0x2A
> -#define RES1920x1440x85      0x2B
> -#define RES1920x1440x100     0x2C
> -#define RES2048x1536x60      0x2D
> -#define RES2048x1536x65      0x2E
> -#define RES2048x1536x70      0x2F
> -#define RES2048x1536x75      0x30
> -#define RES2048x1536x85      0x31
> -#define RES800x480x60        0x32
> -#define RES800x480x75        0x33
> -#define RES800x480x85        0x34
> -#define RES1024x576x60       0x35
> -#define RES1024x576x75       0x36
> -#define RES1024x576x85       0x37
> -#define RES1280x720x60       0x38
> -#define RES1280x720x75       0x39
> -#define RES1280x720x85       0x3A
> -#define RES1280x960x60       0x3B
> -#define RES720x480x60        0x3C
> -#define RES720x576x56        0x3D
> -#define RES856x480x79I       0x3E
> -#define RES856x480x60        0x3F
> -#define RES1280x768x60       0x40
> -#define RES1400x1050x60      0x41
> -#define RES1152x864x60       0x42
> -#define RES1152x864x75       0x43
> -#define RES1024x768x160      0x44
> -#define RES1280x960x75       0x45
> -#define RES1280x960x85       0x46
> -#define RES1280x960x120      0x47
> -
> -#define XG27_CR8F 0x0C
> -#define XG27_SR36 0x30
> -#define XG27_SR40 0x04
> -#define XG27_SR41 0x00
> -#define XG40_CRCF 0x13
> -#define XGI330_CRT2Data_1_2 0
> -#define XGI330_CRT2Data_4_D 0
> -#define XGI330_CRT2Data_4_E 0
> -#define XGI330_CRT2Data_4_10 0x80
> -#define XGI330_SR07 0x18
> -#define XGI330_SR1F 0
> -#define XGI330_SR23 0xf6
> -#define XGI330_SR24 0x0d
> -#define XGI330_SR31 0xc0
> -#define XGI330_SR32 0x11
> -#define XGI330_SR33 0
> -
> -extern const struct XGI_ExtStruct XGI330_EModeIDTable[];
> -extern const struct XGI_Ext2Struct XGI330_RefIndex[];
> -extern const struct XGI_CRT1TableStruct XGI_CRT1Table[];
> -extern const struct XGI_ECLKDataStruct XGI340_ECLKData[];
> -extern const struct SiS_VCLKData XGI_VCLKData[];
> -extern const unsigned char XGI340_CR6B[][4];
> -extern const unsigned char XGI340_AGPReg[];
> -
> -#endif
> diff --git a/drivers/staging/xgifb/vb_init.c b/drivers/staging/xgifb/vb_init.c
> deleted file mode 100644
> index ac1c815a3c5e..000000000000
> --- a/drivers/staging/xgifb/vb_init.c
> +++ /dev/null
> @@ -1,1367 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <linux/delay.h>
> -#include <linux/vmalloc.h>
> -
> -#include "XGIfb.h"
> -#include "vb_def.h"
> -#include "vb_util.h"
> -#include "vb_setmode.h"
> -#include "vb_init.h"
> -static const unsigned short XGINew_DDRDRAM_TYPE340[4][2] = {
> -	{ 16, 0x45},
> -	{  8, 0x35},
> -	{  4, 0x31},
> -	{  2, 0x21} };
> -
> -static const unsigned short XGINew_DDRDRAM_TYPE20[12][2] = {
> -	{ 128, 0x5D},
> -	{ 64, 0x59},
> -	{ 64, 0x4D},
> -	{ 32, 0x55},
> -	{ 32, 0x49},
> -	{ 32, 0x3D},
> -	{ 16, 0x51},
> -	{ 16, 0x45},
> -	{ 16, 0x39},
> -	{  8, 0x41},
> -	{  8, 0x35},
> -	{  4, 0x31} };
> -
> -#define XGIFB_ROM_SIZE	65536
> -
> -static unsigned char
> -XGINew_GetXG20DRAMType(struct xgi_hw_device_info *HwDeviceExtension,
> -		       struct vb_device_info *pVBInfo)
> -{
> -	unsigned char data, temp;
> -
> -	if (HwDeviceExtension->jChipType < XG20) {
> -		data = xgifb_reg_get(pVBInfo->P3c4, 0x39) & 0x02;
> -		if (data == 0)
> -			data = (xgifb_reg_get(pVBInfo->P3c4, 0x3A) &
> -				   0x02) >> 1;
> -		return data;
> -	} else if (HwDeviceExtension->jChipType == XG27) {
> -		temp = xgifb_reg_get(pVBInfo->P3c4, 0x3B);
> -		/* SR3B[7][3]MAA15 MAA11 (Power on Trapping) */
> -		if (((temp & 0x88) == 0x80) || ((temp & 0x88) == 0x08))
> -			data = 0; /* DDR */
> -		else
> -			data = 1; /* DDRII */
> -		return data;
> -	} else if (HwDeviceExtension->jChipType == XG21) {
> -		/* Independent GPIO control */
> -		xgifb_reg_and(pVBInfo->P3d4, 0xB4, ~0x02);
> -		usleep_range(800, 1800);
> -		xgifb_reg_or(pVBInfo->P3d4, 0x4A, 0x80); /* Enable GPIOH read */
> -		/* GPIOF 0:DVI 1:DVO */
> -		data = xgifb_reg_get(pVBInfo->P3d4, 0x48);
> -		/*
> -		 * HOTPLUG_SUPPORT
> -		 * for current XG20 & XG21, GPIOH is floating, driver will
> -		 * fix DDR temporarily
> -		 */
> -		/* DVI read GPIOH */
> -		data &= 0x01; /* 1=DDRII, 0=DDR */
> -		/* ~HOTPLUG_SUPPORT */
> -		xgifb_reg_or(pVBInfo->P3d4, 0xB4, 0x02);
> -		return data;
> -	}
> -	data = xgifb_reg_get(pVBInfo->P3d4, 0x97) & 0x01;
> -
> -	if (data == 1)
> -		data++;
> -
> -	return data;
> -}
> -
> -static void XGINew_DDR1x_MRS_340(unsigned long P3c4,
> -				 struct vb_device_info *pVBInfo)
> -{
> -	xgifb_reg_set(P3c4, 0x18, 0x01);
> -	xgifb_reg_set(P3c4, 0x19, 0x20);
> -	xgifb_reg_set(P3c4, 0x16, 0x00);
> -	xgifb_reg_set(P3c4, 0x16, 0x80);
> -
> -	usleep_range(3, 1003);
> -	xgifb_reg_set(P3c4, 0x18, 0x00);
> -	xgifb_reg_set(P3c4, 0x19, 0x20);
> -	xgifb_reg_set(P3c4, 0x16, 0x00);
> -	xgifb_reg_set(P3c4, 0x16, 0x80);
> -
> -	usleep_range(60, 1060);
> -	xgifb_reg_set(P3c4, 0x18, pVBInfo->SR18[pVBInfo->ram_type]); /* SR18 */
> -	xgifb_reg_set(P3c4, 0x19, 0x01);
> -	xgifb_reg_set(P3c4, 0x16, 0x03);
> -	xgifb_reg_set(P3c4, 0x16, 0x83);
> -	usleep_range(1, 1001);
> -	xgifb_reg_set(P3c4, 0x1B, 0x03);
> -	usleep_range(500, 1500);
> -	xgifb_reg_set(P3c4, 0x18, pVBInfo->SR18[pVBInfo->ram_type]); /* SR18 */
> -	xgifb_reg_set(P3c4, 0x19, 0x00);
> -	xgifb_reg_set(P3c4, 0x16, 0x03);
> -	xgifb_reg_set(P3c4, 0x16, 0x83);
> -	xgifb_reg_set(P3c4, 0x1B, 0x00);
> -}
> -
> -static void XGINew_SetMemoryClock(struct vb_device_info *pVBInfo)
> -{
> -	xgifb_reg_set(pVBInfo->P3c4,
> -		      0x28,
> -		      pVBInfo->MCLKData[pVBInfo->ram_type].SR28);
> -	xgifb_reg_set(pVBInfo->P3c4,
> -		      0x29,
> -		      pVBInfo->MCLKData[pVBInfo->ram_type].SR29);
> -	xgifb_reg_set(pVBInfo->P3c4,
> -		      0x2A,
> -		      pVBInfo->MCLKData[pVBInfo->ram_type].SR2A);
> -
> -	xgifb_reg_set(pVBInfo->P3c4,
> -		      0x2E,
> -		      XGI340_ECLKData[pVBInfo->ram_type].SR2E);
> -	xgifb_reg_set(pVBInfo->P3c4,
> -		      0x2F,
> -		      XGI340_ECLKData[pVBInfo->ram_type].SR2F);
> -	xgifb_reg_set(pVBInfo->P3c4,
> -		      0x30,
> -		      XGI340_ECLKData[pVBInfo->ram_type].SR30);
> -}
> -
> -static void XGINew_DDRII_Bootup_XG27(
> -			struct xgi_hw_device_info *HwDeviceExtension,
> -			unsigned long P3c4, struct vb_device_info *pVBInfo)
> -{
> -	unsigned long P3d4 = P3c4 + 0x10;
> -
> -	pVBInfo->ram_type = XGINew_GetXG20DRAMType(HwDeviceExtension, pVBInfo);
> -	XGINew_SetMemoryClock(pVBInfo);
> -
> -	/* Set Double Frequency */
> -	xgifb_reg_set(P3d4, 0x97, pVBInfo->XGINew_CR97); /* CR97 */
> -
> -	usleep_range(200, 1200);
> -
> -	xgifb_reg_set(P3c4, 0x18, 0x00); /* Set SR18 */ /* EMRS2 */
> -	xgifb_reg_set(P3c4, 0x19, 0x80); /* Set SR19 */
> -	xgifb_reg_set(P3c4, 0x16, 0x20); /* Set SR16 */
> -	usleep_range(15, 1015);
> -	xgifb_reg_set(P3c4, 0x16, 0xA0); /* Set SR16 */
> -	usleep_range(15, 1015);
> -
> -	xgifb_reg_set(P3c4, 0x18, 0x00); /* Set SR18 */ /* EMRS3 */
> -	xgifb_reg_set(P3c4, 0x19, 0xC0); /* Set SR19 */
> -	xgifb_reg_set(P3c4, 0x16, 0x20); /* Set SR16 */
> -	usleep_range(15, 1015);
> -	xgifb_reg_set(P3c4, 0x16, 0xA0); /* Set SR16 */
> -	usleep_range(15, 1015);
> -
> -	xgifb_reg_set(P3c4, 0x18, 0x00); /* Set SR18 */ /* EMRS1 */
> -	xgifb_reg_set(P3c4, 0x19, 0x40); /* Set SR19 */
> -	xgifb_reg_set(P3c4, 0x16, 0x20); /* Set SR16 */
> -	usleep_range(30, 1030);
> -	xgifb_reg_set(P3c4, 0x16, 0xA0); /* Set SR16 */
> -	usleep_range(15, 1015);
> -
> -	xgifb_reg_set(P3c4, 0x18, 0x42); /* Set SR18 */ /* MRS, DLL Enable */
> -	xgifb_reg_set(P3c4, 0x19, 0x0A); /* Set SR19 */
> -	xgifb_reg_set(P3c4, 0x16, 0x00); /* Set SR16 */
> -	usleep_range(30, 1030);
> -	xgifb_reg_set(P3c4, 0x16, 0x00); /* Set SR16 */
> -	xgifb_reg_set(P3c4, 0x16, 0x80); /* Set SR16 */
> -
> -	xgifb_reg_set(P3c4, 0x1B, 0x04); /* Set SR1B */
> -	usleep_range(60, 1060);
> -	xgifb_reg_set(P3c4, 0x1B, 0x00); /* Set SR1B */
> -
> -	xgifb_reg_set(P3c4, 0x18, 0x42); /* Set SR18 */ /* MRS, DLL Reset */
> -	xgifb_reg_set(P3c4, 0x19, 0x08); /* Set SR19 */
> -	xgifb_reg_set(P3c4, 0x16, 0x00); /* Set SR16 */
> -
> -	usleep_range(30, 1030);
> -	xgifb_reg_set(P3c4, 0x16, 0x83); /* Set SR16 */
> -	usleep_range(15, 1015);
> -
> -	xgifb_reg_set(P3c4, 0x18, 0x80); /* Set SR18 */ /* MRS, ODT */
> -	xgifb_reg_set(P3c4, 0x19, 0x46); /* Set SR19 */
> -	xgifb_reg_set(P3c4, 0x16, 0x20); /* Set SR16 */
> -	usleep_range(30, 1030);
> -	xgifb_reg_set(P3c4, 0x16, 0xA0); /* Set SR16 */
> -	usleep_range(15, 1015);
> -
> -	xgifb_reg_set(P3c4, 0x18, 0x00); /* Set SR18 */ /* EMRS */
> -	xgifb_reg_set(P3c4, 0x19, 0x40); /* Set SR19 */
> -	xgifb_reg_set(P3c4, 0x16, 0x20); /* Set SR16 */
> -	usleep_range(30, 1030);
> -	xgifb_reg_set(P3c4, 0x16, 0xA0); /* Set SR16 */
> -	usleep_range(15, 1015);
> -
> -	/* Set SR1B refresh control 000:close; 010:open */
> -	xgifb_reg_set(P3c4, 0x1B, 0x04);
> -	usleep_range(200, 1200);
> -}
> -
> -static void XGINew_DDR2_MRS_XG20(struct xgi_hw_device_info *HwDeviceExtension,
> -				 unsigned long P3c4,
> -				 struct vb_device_info *pVBInfo)
> -{
> -	unsigned long P3d4 = P3c4 + 0x10;
> -
> -	pVBInfo->ram_type = XGINew_GetXG20DRAMType(HwDeviceExtension, pVBInfo);
> -	XGINew_SetMemoryClock(pVBInfo);
> -
> -	xgifb_reg_set(P3d4, 0x97, 0x11); /* CR97 */
> -
> -	usleep_range(200, 1200);
> -	xgifb_reg_set(P3c4, 0x18, 0x00); /* EMRS2 */
> -	xgifb_reg_set(P3c4, 0x19, 0x80);
> -	xgifb_reg_set(P3c4, 0x16, 0x05);
> -	xgifb_reg_set(P3c4, 0x16, 0x85);
> -
> -	xgifb_reg_set(P3c4, 0x18, 0x00); /* EMRS3 */
> -	xgifb_reg_set(P3c4, 0x19, 0xC0);
> -	xgifb_reg_set(P3c4, 0x16, 0x05);
> -	xgifb_reg_set(P3c4, 0x16, 0x85);
> -
> -	xgifb_reg_set(P3c4, 0x18, 0x00); /* EMRS1 */
> -	xgifb_reg_set(P3c4, 0x19, 0x40);
> -	xgifb_reg_set(P3c4, 0x16, 0x05);
> -	xgifb_reg_set(P3c4, 0x16, 0x85);
> -
> -	xgifb_reg_set(P3c4, 0x18, 0x42); /* MRS1 */
> -	xgifb_reg_set(P3c4, 0x19, 0x02);
> -	xgifb_reg_set(P3c4, 0x16, 0x05);
> -	xgifb_reg_set(P3c4, 0x16, 0x85);
> -
> -	usleep_range(15, 1015);
> -	xgifb_reg_set(P3c4, 0x1B, 0x04); /* SR1B */
> -	usleep_range(30, 1030);
> -	xgifb_reg_set(P3c4, 0x1B, 0x00); /* SR1B */
> -	usleep_range(100, 1100);
> -
> -	xgifb_reg_set(P3c4, 0x18, 0x42); /* MRS1 */
> -	xgifb_reg_set(P3c4, 0x19, 0x00);
> -	xgifb_reg_set(P3c4, 0x16, 0x05);
> -	xgifb_reg_set(P3c4, 0x16, 0x85);
> -
> -	usleep_range(200, 1200);
> -}
> -
> -static void XGINew_DDR1x_MRS_XG20(unsigned long P3c4,
> -				  struct vb_device_info *pVBInfo)
> -{
> -	xgifb_reg_set(P3c4, 0x18, 0x01);
> -	xgifb_reg_set(P3c4, 0x19, 0x40);
> -	xgifb_reg_set(P3c4, 0x16, 0x00);
> -	xgifb_reg_set(P3c4, 0x16, 0x80);
> -	usleep_range(60, 1060);
> -
> -	xgifb_reg_set(P3c4, 0x18, 0x00);
> -	xgifb_reg_set(P3c4, 0x19, 0x40);
> -	xgifb_reg_set(P3c4, 0x16, 0x00);
> -	xgifb_reg_set(P3c4, 0x16, 0x80);
> -	usleep_range(60, 1060);
> -	xgifb_reg_set(P3c4, 0x18, pVBInfo->SR18[pVBInfo->ram_type]); /* SR18 */
> -	xgifb_reg_set(P3c4, 0x19, 0x01);
> -	xgifb_reg_set(P3c4, 0x16, 0x03);
> -	xgifb_reg_set(P3c4, 0x16, 0x83);
> -	usleep_range(1, 1001);
> -	xgifb_reg_set(P3c4, 0x1B, 0x03);
> -	usleep_range(500, 1500);
> -	xgifb_reg_set(P3c4, 0x18, pVBInfo->SR18[pVBInfo->ram_type]); /* SR18 */
> -	xgifb_reg_set(P3c4, 0x19, 0x00);
> -	xgifb_reg_set(P3c4, 0x16, 0x03);
> -	xgifb_reg_set(P3c4, 0x16, 0x83);
> -	xgifb_reg_set(P3c4, 0x1B, 0x00);
> -}
> -
> -static void XGINew_DDR1x_DefaultRegister(
> -		struct xgi_hw_device_info *HwDeviceExtension,
> -		unsigned long Port, struct vb_device_info *pVBInfo)
> -{
> -	unsigned long P3d4 = Port, P3c4 = Port - 0x10;
> -
> -	if (HwDeviceExtension->jChipType >= XG20) {
> -		XGINew_SetMemoryClock(pVBInfo);
> -		xgifb_reg_set(P3d4,
> -			      0x82,
> -			      pVBInfo->CR40[11][pVBInfo->ram_type]); /* CR82 */
> -		xgifb_reg_set(P3d4,
> -			      0x85,
> -			      pVBInfo->CR40[12][pVBInfo->ram_type]); /* CR85 */
> -		xgifb_reg_set(P3d4,
> -			      0x86,
> -			      pVBInfo->CR40[13][pVBInfo->ram_type]); /* CR86 */
> -
> -		xgifb_reg_set(P3d4, 0x98, 0x01);
> -		xgifb_reg_set(P3d4, 0x9A, 0x02);
> -
> -		XGINew_DDR1x_MRS_XG20(P3c4, pVBInfo);
> -	} else {
> -		XGINew_SetMemoryClock(pVBInfo);
> -
> -		switch (HwDeviceExtension->jChipType) {
> -		case XG42:
> -			/* CR82 */
> -			xgifb_reg_set(P3d4,
> -				      0x82,
> -				      pVBInfo->CR40[11][pVBInfo->ram_type]);
> -			/* CR85 */
> -			xgifb_reg_set(P3d4,
> -				      0x85,
> -				      pVBInfo->CR40[12][pVBInfo->ram_type]);
> -			/* CR86 */
> -			xgifb_reg_set(P3d4,
> -				      0x86,
> -				      pVBInfo->CR40[13][pVBInfo->ram_type]);
> -			break;
> -		default:
> -			xgifb_reg_set(P3d4, 0x82, 0x88);
> -			xgifb_reg_set(P3d4, 0x86, 0x00);
> -			/* Insert read command for delay */
> -			xgifb_reg_get(P3d4, 0x86);
> -			xgifb_reg_set(P3d4, 0x86, 0x88);
> -			xgifb_reg_get(P3d4, 0x86);
> -			xgifb_reg_set(P3d4,
> -				      0x86,
> -				      pVBInfo->CR40[13][pVBInfo->ram_type]);
> -			xgifb_reg_set(P3d4, 0x82, 0x77);
> -			xgifb_reg_set(P3d4, 0x85, 0x00);
> -
> -			/* Insert read command for delay */
> -			xgifb_reg_get(P3d4, 0x85);
> -			xgifb_reg_set(P3d4, 0x85, 0x88);
> -
> -			/* Insert read command for delay */
> -			xgifb_reg_get(P3d4, 0x85);
> -			/* CR85 */
> -			xgifb_reg_set(P3d4,
> -				      0x85,
> -				      pVBInfo->CR40[12][pVBInfo->ram_type]);
> -			/* CR82 */
> -			xgifb_reg_set(P3d4,
> -				      0x82,
> -				      pVBInfo->CR40[11][pVBInfo->ram_type]);
> -			break;
> -		}
> -
> -		xgifb_reg_set(P3d4, 0x97, 0x00);
> -		xgifb_reg_set(P3d4, 0x98, 0x01);
> -		xgifb_reg_set(P3d4, 0x9A, 0x02);
> -		XGINew_DDR1x_MRS_340(P3c4, pVBInfo);
> -	}
> -}
> -
> -static void XGINew_DDR2_DefaultRegister(
> -		struct xgi_hw_device_info *HwDeviceExtension,
> -		unsigned long Port, struct vb_device_info *pVBInfo)
> -{
> -	unsigned long P3d4 = Port, P3c4 = Port - 0x10;
> -	/*
> -	 * keep following setting sequence, each setting in
> -	 * the same reg insert idle
> -	 */
> -	xgifb_reg_set(P3d4, 0x82, 0x77);
> -	xgifb_reg_set(P3d4, 0x86, 0x00);
> -	xgifb_reg_get(P3d4, 0x86); /* Insert read command for delay */
> -	xgifb_reg_set(P3d4, 0x86, 0x88);
> -	xgifb_reg_get(P3d4, 0x86); /* Insert read command for delay */
> -	/* CR86 */
> -	xgifb_reg_set(P3d4, 0x86, pVBInfo->CR40[13][pVBInfo->ram_type]);
> -	xgifb_reg_set(P3d4, 0x82, 0x77);
> -	xgifb_reg_set(P3d4, 0x85, 0x00);
> -	xgifb_reg_get(P3d4, 0x85); /* Insert read command for delay */
> -	xgifb_reg_set(P3d4, 0x85, 0x88);
> -	xgifb_reg_get(P3d4, 0x85); /* Insert read command for delay */
> -	xgifb_reg_set(P3d4,
> -		      0x85,
> -		      pVBInfo->CR40[12][pVBInfo->ram_type]); /* CR85 */
> -	if (HwDeviceExtension->jChipType == XG27)
> -		/* CR82 */
> -		xgifb_reg_set(P3d4, 0x82, pVBInfo->CR40[11][pVBInfo->ram_type]);
> -	else
> -		xgifb_reg_set(P3d4, 0x82, 0xA8); /* CR82 */
> -
> -	xgifb_reg_set(P3d4, 0x98, 0x01);
> -	xgifb_reg_set(P3d4, 0x9A, 0x02);
> -	if (HwDeviceExtension->jChipType == XG27)
> -		XGINew_DDRII_Bootup_XG27(HwDeviceExtension, P3c4, pVBInfo);
> -	else
> -		XGINew_DDR2_MRS_XG20(HwDeviceExtension, P3c4, pVBInfo);
> -}
> -
> -static void XGI_SetDRAM_Helper(unsigned long P3d4, u8 seed, u8 temp2, u8 reg,
> -			       u8 shift_factor, u8 mask1, u8 mask2)
> -{
> -	u8 j;
> -
> -	for (j = 0; j < 4; j++) {
> -		temp2 |= (((seed >> (2 * j)) & 0x03) << shift_factor);
> -		xgifb_reg_set(P3d4, reg, temp2);
> -		xgifb_reg_get(P3d4, reg);
> -		temp2 &= mask1;
> -		temp2 += mask2;
> -	}
> -}
> -
> -static void XGINew_SetDRAMDefaultRegister340(
> -		struct xgi_hw_device_info *HwDeviceExtension,
> -		unsigned long Port, struct vb_device_info *pVBInfo)
> -{
> -	unsigned char temp, temp1, temp2, temp3, j, k;
> -
> -	unsigned long P3d4 = Port, P3c4 = Port - 0x10;
> -
> -	xgifb_reg_set(P3d4, 0x6D, pVBInfo->CR40[8][pVBInfo->ram_type]);
> -	xgifb_reg_set(P3d4, 0x68, pVBInfo->CR40[5][pVBInfo->ram_type]);
> -	xgifb_reg_set(P3d4, 0x69, pVBInfo->CR40[6][pVBInfo->ram_type]);
> -	xgifb_reg_set(P3d4, 0x6A, pVBInfo->CR40[7][pVBInfo->ram_type]);
> -
> -	/* CR6B DQS fine tune delay */
> -	temp = 0xaa;
> -	XGI_SetDRAM_Helper(P3d4, temp, 0, 0x6B, 2, 0xF0, 0x10);
> -
> -	/* CR6E DQM fine tune delay */
> -	XGI_SetDRAM_Helper(P3d4, 0, 0, 0x6E, 2, 0xF0, 0x10);
> -
> -	temp3 = 0;
> -	for (k = 0; k < 4; k++) {
> -		/* CR6E_D[1:0] select channel */
> -		xgifb_reg_and_or(P3d4, 0x6E, 0xFC, temp3);
> -		XGI_SetDRAM_Helper(P3d4, 0, 0, 0x6F, 0, 0xF8, 0x08);
> -		temp3 += 0x01;
> -	}
> -
> -	xgifb_reg_set(P3d4,
> -		      0x80,
> -		      pVBInfo->CR40[9][pVBInfo->ram_type]); /* CR80 */
> -	xgifb_reg_set(P3d4,
> -		      0x81,
> -		      pVBInfo->CR40[10][pVBInfo->ram_type]); /* CR81 */
> -
> -	temp2 = 0x80;
> -	/* CR89 terminator type select */
> -	XGI_SetDRAM_Helper(P3d4, 0, temp2, 0x89, 0, 0xF0, 0x10);
> -
> -	temp = 0;
> -	temp1 = temp & 0x03;
> -	temp2 |= temp1;
> -	xgifb_reg_set(P3d4, 0x89, temp2);
> -
> -	temp = pVBInfo->CR40[3][pVBInfo->ram_type];
> -	temp1 = temp & 0x0F;
> -	temp2 = (temp >> 4) & 0x07;
> -	temp3 = temp & 0x80;
> -	xgifb_reg_set(P3d4, 0x45, temp1); /* CR45 */
> -	xgifb_reg_set(P3d4, 0x99, temp2); /* CR99 */
> -	xgifb_reg_or(P3d4, 0x40, temp3); /* CR40_D[7] */
> -	xgifb_reg_set(P3d4,
> -		      0x41,
> -		      pVBInfo->CR40[0][pVBInfo->ram_type]); /* CR41 */
> -
> -	if (HwDeviceExtension->jChipType == XG27)
> -		xgifb_reg_set(P3d4, 0x8F, XG27_CR8F); /* CR8F */
> -
> -	for (j = 0; j <= 6; j++) /* CR90 - CR96 */
> -		xgifb_reg_set(P3d4, (0x90 + j),
> -			      pVBInfo->CR40[14 + j][pVBInfo->ram_type]);
> -
> -	for (j = 0; j <= 2; j++) /* CRC3 - CRC5 */
> -		xgifb_reg_set(P3d4, (0xC3 + j),
> -			      pVBInfo->CR40[21 + j][pVBInfo->ram_type]);
> -
> -	for (j = 0; j < 2; j++) /* CR8A - CR8B */
> -		xgifb_reg_set(P3d4, (0x8A + j),
> -			      pVBInfo->CR40[1 + j][pVBInfo->ram_type]);
> -
> -	if (HwDeviceExtension->jChipType == XG42)
> -		xgifb_reg_set(P3d4, 0x8C, 0x87);
> -
> -	xgifb_reg_set(P3d4,
> -		      0x59,
> -		      pVBInfo->CR40[4][pVBInfo->ram_type]); /* CR59 */
> -
> -	xgifb_reg_set(P3d4, 0x83, 0x09); /* CR83 */
> -	xgifb_reg_set(P3d4, 0x87, 0x00); /* CR87 */
> -	xgifb_reg_set(P3d4, 0xCF, XG40_CRCF); /* CRCF */
> -	if (pVBInfo->ram_type) {
> -		xgifb_reg_set(P3c4, 0x17, 0x80); /* SR17 DDRII */
> -		if (HwDeviceExtension->jChipType == XG27)
> -			xgifb_reg_set(P3c4, 0x17, 0x02); /* SR17 DDRII */
> -
> -	} else {
> -		xgifb_reg_set(P3c4, 0x17, 0x00); /* SR17 DDR */
> -	}
> -	xgifb_reg_set(P3c4, 0x1A, 0x87); /* SR1A */
> -
> -	temp = XGINew_GetXG20DRAMType(HwDeviceExtension, pVBInfo);
> -	if (temp == 0) {
> -		XGINew_DDR1x_DefaultRegister(HwDeviceExtension, P3d4, pVBInfo);
> -	} else {
> -		xgifb_reg_set(P3d4, 0xB0, 0x80); /* DDRII Dual frequency mode */
> -		XGINew_DDR2_DefaultRegister(HwDeviceExtension, P3d4, pVBInfo);
> -	}
> -	xgifb_reg_set(P3c4, 0x1B, 0x03); /* SR1B */
> -}
> -
> -static unsigned short XGINew_SetDRAMSize20Reg(
> -		unsigned short dram_size,
> -		struct vb_device_info *pVBInfo)
> -{
> -	unsigned short data = 0, memsize = 0;
> -	int RankSize;
> -	unsigned char ChannelNo;
> -
> -	RankSize = dram_size * pVBInfo->ram_bus / 8;
> -	data = xgifb_reg_get(pVBInfo->P3c4, 0x13);
> -	data &= 0x80;
> -
> -	if (data == 0x80)
> -		RankSize *= 2;
> -
> -	data = 0;
> -
> -	if (pVBInfo->ram_channel == 3)
> -		ChannelNo = 4;
> -	else
> -		ChannelNo = pVBInfo->ram_channel;
> -
> -	if (ChannelNo * RankSize <= 256) {
> -		while ((RankSize >>= 1) > 0)
> -			data += 0x10;
> -
> -		memsize = data >> 4;
> -
> -		/* Fix DRAM Sizing Error */
> -		xgifb_reg_set(pVBInfo->P3c4,
> -			      0x14,
> -			      (xgifb_reg_get(pVBInfo->P3c4, 0x14) & 0x0F) |
> -				(data & 0xF0));
> -		usleep_range(15, 1015);
> -	}
> -	return memsize;
> -}
> -
> -static int XGINew_ReadWriteRest(unsigned short StopAddr,
> -				unsigned short StartAddr,
> -				struct vb_device_info *pVBInfo)
> -{
> -	int i;
> -	unsigned long Position = 0;
> -	void __iomem *fbaddr = pVBInfo->FBAddr;
> -
> -	writel(Position, fbaddr + Position);
> -
> -	for (i = StartAddr; i <= StopAddr; i++) {
> -		Position = 1 << i;
> -		writel(Position, fbaddr + Position);
> -	}
> -
> -	/* Fix #1759 Memory Size error in Multi-Adapter. */
> -	usleep_range(500, 1500);
> -
> -	Position = 0;
> -
> -	if (readl(fbaddr + Position) != Position)
> -		return 0;
> -
> -	for (i = StartAddr; i <= StopAddr; i++) {
> -		Position = 1 << i;
> -		if (readl(fbaddr + Position) != Position)
> -			return 0;
> -	}
> -	return 1;
> -}
> -
> -static unsigned char XGINew_CheckFrequence(struct vb_device_info *pVBInfo)
> -{
> -	unsigned char data;
> -
> -	data = xgifb_reg_get(pVBInfo->P3d4, 0x97);
> -
> -	if ((data & 0x10) == 0) {
> -		data = xgifb_reg_get(pVBInfo->P3c4, 0x39);
> -		return (data & 0x02) >> 1;
> -	}
> -	return data & 0x01;
> -}
> -
> -static void XGINew_CheckChannel(struct xgi_hw_device_info *HwDeviceExtension,
> -				struct vb_device_info *pVBInfo)
> -{
> -	unsigned char data;
> -
> -	switch (HwDeviceExtension->jChipType) {
> -	case XG20:
> -	case XG21:
> -		data = xgifb_reg_get(pVBInfo->P3d4, 0x97);
> -		data = data & 0x01;
> -		pVBInfo->ram_channel = 1; /* XG20 "JUST" one channel */
> -
> -		if (data == 0) { /* Single_32_16 */
> -
> -			if ((HwDeviceExtension->ulVideoMemorySize - 1)
> -					> 0x1000000) {
> -				pVBInfo->ram_bus = 32; /* 32 bits */
> -				/* 22bit + 2 rank + 32bit */
> -				xgifb_reg_set(pVBInfo->P3c4, 0x13, 0xB1);
> -				xgifb_reg_set(pVBInfo->P3c4, 0x14, 0x52);
> -				usleep_range(15, 1015);
> -
> -				if (XGINew_ReadWriteRest(24, 23, pVBInfo) == 1)
> -					return;
> -
> -				if ((HwDeviceExtension->ulVideoMemorySize - 1) >
> -				    0x800000) {
> -					/* 22bit + 1 rank + 32bit */
> -					xgifb_reg_set(pVBInfo->P3c4,
> -						      0x13,
> -						      0x31);
> -					xgifb_reg_set(pVBInfo->P3c4,
> -						      0x14,
> -						      0x42);
> -					usleep_range(15, 1015);
> -
> -					if (XGINew_ReadWriteRest(23,
> -								 23,
> -								 pVBInfo) == 1)
> -						return;
> -				}
> -			}
> -
> -			if ((HwDeviceExtension->ulVideoMemorySize - 1) >
> -			    0x800000) {
> -				pVBInfo->ram_bus = 16; /* 16 bits */
> -				/* 22bit + 2 rank + 16bit */
> -				xgifb_reg_set(pVBInfo->P3c4, 0x13, 0xB1);
> -				xgifb_reg_set(pVBInfo->P3c4, 0x14, 0x41);
> -				usleep_range(15, 1015);
> -
> -				if (XGINew_ReadWriteRest(23, 22, pVBInfo) == 1)
> -					return;
> -				xgifb_reg_set(pVBInfo->P3c4,
> -					      0x13,
> -					      0x31);
> -				usleep_range(15, 1015);
> -			}
> -
> -		} else { /* Dual_16_8 */
> -			if ((HwDeviceExtension->ulVideoMemorySize - 1) >
> -			    0x800000) {
> -				pVBInfo->ram_bus = 16; /* 16 bits */
> -				/* (0x31:12x8x2) 22bit + 2 rank */
> -				xgifb_reg_set(pVBInfo->P3c4, 0x13, 0xB1);
> -				/* 0x41:16Mx16 bit */
> -				xgifb_reg_set(pVBInfo->P3c4, 0x14, 0x41);
> -				usleep_range(15, 1015);
> -
> -				if (XGINew_ReadWriteRest(23, 22, pVBInfo) == 1)
> -					return;
> -
> -				if ((HwDeviceExtension->ulVideoMemorySize - 1) >
> -				    0x400000) {
> -					/* (0x31:12x8x2) 22bit + 1 rank */
> -					xgifb_reg_set(pVBInfo->P3c4,
> -						      0x13,
> -						      0x31);
> -					/* 0x31:8Mx16 bit */
> -					xgifb_reg_set(pVBInfo->P3c4,
> -						      0x14,
> -						      0x31);
> -					usleep_range(15, 1015);
> -
> -					if (XGINew_ReadWriteRest(22,
> -								 22,
> -								 pVBInfo) == 1)
> -						return;
> -				}
> -			}
> -
> -			if ((HwDeviceExtension->ulVideoMemorySize - 1) >
> -			    0x400000) {
> -				pVBInfo->ram_bus = 8; /* 8 bits */
> -				/* (0x31:12x8x2) 22bit + 2 rank */
> -				xgifb_reg_set(pVBInfo->P3c4, 0x13, 0xB1);
> -				/* 0x30:8Mx8 bit */
> -				xgifb_reg_set(pVBInfo->P3c4, 0x14, 0x30);
> -				usleep_range(15, 1015);
> -
> -				if (XGINew_ReadWriteRest(22, 21, pVBInfo) == 1)
> -					return;
> -
> -				/* (0x31:12x8x2) 22bit + 1 rank */
> -				xgifb_reg_set(pVBInfo->P3c4,
> -					      0x13,
> -					      0x31);
> -				usleep_range(15, 1015);
> -			}
> -		}
> -		break;
> -
> -	case XG27:
> -		pVBInfo->ram_bus = 16; /* 16 bits */
> -		pVBInfo->ram_channel = 1; /* Single channel */
> -		xgifb_reg_set(pVBInfo->P3c4, 0x14, 0x51); /* 32Mx16 bit */
> -		break;
> -	case XG42:
> -		/*
> -		 * XG42 SR14 D[3] Reserve
> -		 * D[2] = 1, Dual Channel
> -		 * = 0, Single Channel
> -		 *
> -		 * It's Different from Other XG40 Series.
> -		 */
> -		if (XGINew_CheckFrequence(pVBInfo) == 1) { /* DDRII, DDR2x */
> -			pVBInfo->ram_bus = 32; /* 32 bits */
> -			pVBInfo->ram_channel = 2; /* 2 Channel */
> -			xgifb_reg_set(pVBInfo->P3c4, 0x13, 0xA1);
> -			xgifb_reg_set(pVBInfo->P3c4, 0x14, 0x44);
> -
> -			if (XGINew_ReadWriteRest(24, 23, pVBInfo) == 1)
> -				return;
> -
> -			xgifb_reg_set(pVBInfo->P3c4, 0x13, 0x21);
> -			xgifb_reg_set(pVBInfo->P3c4, 0x14, 0x34);
> -			if (XGINew_ReadWriteRest(23, 22, pVBInfo) == 1)
> -				return;
> -
> -			pVBInfo->ram_channel = 1; /* Single Channel */
> -			xgifb_reg_set(pVBInfo->P3c4, 0x13, 0xA1);
> -			xgifb_reg_set(pVBInfo->P3c4, 0x14, 0x40);
> -
> -			if (XGINew_ReadWriteRest(23, 22, pVBInfo) == 1)
> -				return;
> -			xgifb_reg_set(pVBInfo->P3c4, 0x13, 0x21);
> -			xgifb_reg_set(pVBInfo->P3c4, 0x14, 0x30);
> -		} else { /* DDR */
> -			pVBInfo->ram_bus = 64; /* 64 bits */
> -			pVBInfo->ram_channel = 1; /* 1 channels */
> -			xgifb_reg_set(pVBInfo->P3c4, 0x13, 0xA1);
> -			xgifb_reg_set(pVBInfo->P3c4, 0x14, 0x52);
> -
> -			if (XGINew_ReadWriteRest(24, 23, pVBInfo) == 1)
> -				return;
> -			xgifb_reg_set(pVBInfo->P3c4, 0x13, 0x21);
> -			xgifb_reg_set(pVBInfo->P3c4, 0x14, 0x42);
> -		}
> -
> -		break;
> -
> -	default: /* XG40 */
> -
> -		if (XGINew_CheckFrequence(pVBInfo) == 1) { /* DDRII */
> -			pVBInfo->ram_bus = 32; /* 32 bits */
> -			pVBInfo->ram_channel = 3;
> -			xgifb_reg_set(pVBInfo->P3c4, 0x13, 0xA1);
> -			xgifb_reg_set(pVBInfo->P3c4, 0x14, 0x4C);
> -
> -			if (XGINew_ReadWriteRest(25, 23, pVBInfo) == 1)
> -				return;
> -
> -			pVBInfo->ram_channel = 2; /* 2 channels */
> -			xgifb_reg_set(pVBInfo->P3c4, 0x14, 0x48);
> -
> -			if (XGINew_ReadWriteRest(24, 23, pVBInfo) == 1)
> -				return;
> -
> -			xgifb_reg_set(pVBInfo->P3c4, 0x13, 0x21);
> -			xgifb_reg_set(pVBInfo->P3c4, 0x14, 0x3C);
> -
> -			if (XGINew_ReadWriteRest(24, 23, pVBInfo) == 1) {
> -				pVBInfo->ram_channel = 3; /* 4 channels */
> -			} else {
> -				pVBInfo->ram_channel = 2; /* 2 channels */
> -				xgifb_reg_set(pVBInfo->P3c4, 0x14, 0x38);
> -			}
> -		} else { /* DDR */
> -			pVBInfo->ram_bus = 64; /* 64 bits */
> -			pVBInfo->ram_channel = 2; /* 2 channels */
> -			xgifb_reg_set(pVBInfo->P3c4, 0x13, 0xA1);
> -			xgifb_reg_set(pVBInfo->P3c4, 0x14, 0x5A);
> -
> -			if (XGINew_ReadWriteRest(25, 24, pVBInfo) == 1)
> -				return;
> -			xgifb_reg_set(pVBInfo->P3c4, 0x13, 0x21);
> -			xgifb_reg_set(pVBInfo->P3c4, 0x14, 0x4A);
> -		}
> -		break;
> -	}
> -}
> -
> -static int XGINew_DDRSizing340(struct xgi_hw_device_info *HwDeviceExtension,
> -			       struct vb_device_info *pVBInfo)
> -{
> -	u8 i, size;
> -	unsigned short memsize, start_addr;
> -	const unsigned short (*dram_table)[2];
> -
> -	xgifb_reg_set(pVBInfo->P3c4, 0x15, 0x00); /* noninterleaving */
> -	xgifb_reg_set(pVBInfo->P3c4, 0x1C, 0x00); /* nontiling */
> -	XGINew_CheckChannel(HwDeviceExtension, pVBInfo);
> -
> -	if (HwDeviceExtension->jChipType >= XG20) {
> -		dram_table = XGINew_DDRDRAM_TYPE20;
> -		size = ARRAY_SIZE(XGINew_DDRDRAM_TYPE20);
> -		start_addr = 5;
> -	} else {
> -		dram_table = XGINew_DDRDRAM_TYPE340;
> -		size = ARRAY_SIZE(XGINew_DDRDRAM_TYPE340);
> -		start_addr = 9;
> -	}
> -
> -	for (i = 0; i < size; i++) {
> -		/* SetDRAMSizingType */
> -		xgifb_reg_and_or(pVBInfo->P3c4, 0x13, 0x80, dram_table[i][1]);
> -		usleep_range(50, 1050); /* should delay 50 ns */
> -
> -		memsize = XGINew_SetDRAMSize20Reg(dram_table[i][0], pVBInfo);
> -
> -		if (memsize == 0)
> -			continue;
> -
> -		memsize += (pVBInfo->ram_channel - 2) + 20;
> -		if ((HwDeviceExtension->ulVideoMemorySize - 1) <
> -			(unsigned long)(1 << memsize))
> -			continue;
> -
> -		if (XGINew_ReadWriteRest(memsize, start_addr, pVBInfo) == 1)
> -			return 1;
> -	}
> -	return 0;
> -}
> -
> -static void XGINew_SetDRAMSize_340(struct xgifb_video_info *xgifb_info,
> -				   struct xgi_hw_device_info *HwDeviceExtension,
> -				   struct vb_device_info *pVBInfo)
> -{
> -	unsigned short data;
> -
> -	pVBInfo->FBAddr = HwDeviceExtension->pjVideoMemoryAddress;
> -
> -	XGISetModeNew(xgifb_info, HwDeviceExtension, 0x2e);
> -
> -	data = xgifb_reg_get(pVBInfo->P3c4, 0x21);
> -	/* disable read cache */
> -	xgifb_reg_set(pVBInfo->P3c4, 0x21, (unsigned short)(data & 0xDF));
> -	XGI_DisplayOff(xgifb_info, HwDeviceExtension, pVBInfo);
> -
> -	XGINew_DDRSizing340(HwDeviceExtension, pVBInfo);
> -	data = xgifb_reg_get(pVBInfo->P3c4, 0x21);
> -	/* enable read cache */
> -	xgifb_reg_set(pVBInfo->P3c4, 0x21, (unsigned short)(data | 0x20));
> -}
> -
> -static u8 *xgifb_copy_rom(struct pci_dev *dev, size_t *rom_size)
> -{
> -	void __iomem *rom_address;
> -	u8 *rom_copy;
> -
> -	rom_address = pci_map_rom(dev, rom_size);
> -	if (!rom_address)
> -		return NULL;
> -
> -	rom_copy = vzalloc(XGIFB_ROM_SIZE);
> -	if (!rom_copy)
> -		goto done;
> -
> -	*rom_size = min_t(size_t, *rom_size, XGIFB_ROM_SIZE);
> -	memcpy_fromio(rom_copy, rom_address, *rom_size);
> -
> -done:
> -	pci_unmap_rom(dev, rom_address);
> -	return rom_copy;
> -}
> -
> -static bool xgifb_read_vbios(struct pci_dev *pdev)
> -{
> -	struct xgifb_video_info *xgifb_info = pci_get_drvdata(pdev);
> -	u8 *vbios;
> -	unsigned long i;
> -	unsigned char j;
> -	struct XGI21_LVDSCapStruct *lvds;
> -	size_t vbios_size;
> -	int entry;
> -
> -	vbios = xgifb_copy_rom(pdev, &vbios_size);
> -	if (!vbios) {
> -		dev_err(&pdev->dev, "Video BIOS not available\n");
> -		return false;
> -	}
> -	if (vbios_size <= 0x65)
> -		goto error;
> -	/*
> -	 * The user can ignore the LVDS bit in the BIOS and force the display
> -	 * type.
> -	 */
> -	if (!(vbios[0x65] & 0x1) &&
> -	    (!xgifb_info->display2_force ||
> -	     xgifb_info->display2 != XGIFB_DISP_LCD)) {
> -		vfree(vbios);
> -		return false;
> -	}
> -	if (vbios_size <= 0x317)
> -		goto error;
> -	i = vbios[0x316] | (vbios[0x317] << 8);
> -	if (vbios_size <= i - 1)
> -		goto error;
> -	j = vbios[i - 1];
> -	if (j == 0)
> -		goto error;
> -	if (j == 0xff)
> -		j = 1;
> -
> -	/* Read the LVDS table index scratch register set by the BIOS. */
> -
> -	entry = xgifb_reg_get(xgifb_info->dev_info.P3d4, 0x36);
> -	if (entry >= j)
> -		entry = 0;
> -	i += entry * 25;
> -	lvds = &xgifb_info->lvds_data;
> -	if (vbios_size <= i + 24)
> -		goto error;
> -	lvds->LVDS_Capability	= vbios[i]	| (vbios[i + 1] << 8);
> -	lvds->LVDSHT		= vbios[i + 2]	| (vbios[i + 3] << 8);
> -	lvds->LVDSVT		= vbios[i + 4]	| (vbios[i + 5] << 8);
> -	lvds->LVDSHDE		= vbios[i + 6]	| (vbios[i + 7] << 8);
> -	lvds->LVDSVDE		= vbios[i + 8]	| (vbios[i + 9] << 8);
> -	lvds->LVDSHFP		= vbios[i + 10]	| (vbios[i + 11] << 8);
> -	lvds->LVDSVFP		= vbios[i + 12]	| (vbios[i + 13] << 8);
> -	lvds->LVDSHSYNC		= vbios[i + 14]	| (vbios[i + 15] << 8);
> -	lvds->LVDSVSYNC		= vbios[i + 16]	| (vbios[i + 17] << 8);
> -	lvds->VCLKData1		= vbios[i + 18];
> -	lvds->VCLKData2		= vbios[i + 19];
> -	lvds->PSC_S1		= vbios[i + 20];
> -	lvds->PSC_S2		= vbios[i + 21];
> -	lvds->PSC_S3		= vbios[i + 22];
> -	lvds->PSC_S4		= vbios[i + 23];
> -	lvds->PSC_S5		= vbios[i + 24];
> -	vfree(vbios);
> -	return true;
> -error:
> -	dev_err(&pdev->dev, "Video BIOS corrupted\n");
> -	vfree(vbios);
> -	return false;
> -}
> -
> -static void XGINew_ChkSenseStatus(struct vb_device_info *pVBInfo)
> -{
> -	unsigned short tempbx = 0, temp, tempcx, CR3CData;
> -
> -	temp = xgifb_reg_get(pVBInfo->P3d4, 0x32);
> -
> -	if (temp & Monitor1Sense)
> -		tempbx |= ActiveCRT1;
> -	if (temp & LCDSense)
> -		tempbx |= ActiveLCD;
> -	if (temp & Monitor2Sense)
> -		tempbx |= ActiveCRT2;
> -	if (temp & TVSense) {
> -		tempbx |= ActiveTV;
> -		if (temp & AVIDEOSense)
> -			tempbx |= (ActiveAVideo << 8);
> -		if (temp & SVIDEOSense)
> -			tempbx |= (ActiveSVideo << 8);
> -		if (temp & SCARTSense)
> -			tempbx |= (ActiveSCART << 8);
> -		if (temp & HiTVSense)
> -			tempbx |= (ActiveHiTV << 8);
> -		if (temp & YPbPrSense)
> -			tempbx |= (ActiveYPbPr << 8);
> -	}
> -
> -	tempcx = xgifb_reg_get(pVBInfo->P3d4, 0x3d);
> -	tempcx |= (xgifb_reg_get(pVBInfo->P3d4, 0x3e) << 8);
> -
> -	if (tempbx & tempcx) {
> -		CR3CData = xgifb_reg_get(pVBInfo->P3d4, 0x3c);
> -		if (!(CR3CData & DisplayDeviceFromCMOS))
> -			tempcx = 0x1FF0;
> -	} else {
> -		tempcx = 0x1FF0;
> -	}
> -
> -	tempbx &= tempcx;
> -	xgifb_reg_set(pVBInfo->P3d4, 0x3d, (tempbx & 0x00FF));
> -	xgifb_reg_set(pVBInfo->P3d4, 0x3e, ((tempbx & 0xFF00) >> 8));
> -}
> -
> -static void XGINew_SetModeScratch(struct vb_device_info *pVBInfo)
> -{
> -	unsigned short temp, tempcl = 0, tempch = 0, CR31Data, CR38Data;
> -
> -	temp = xgifb_reg_get(pVBInfo->P3d4, 0x3d);
> -	temp |= xgifb_reg_get(pVBInfo->P3d4, 0x3e) << 8;
> -	temp |= (xgifb_reg_get(pVBInfo->P3d4, 0x31) & (DriverMode >> 8)) << 8;
> -
> -	if (pVBInfo->IF_DEF_CRT2Monitor == 1) {
> -		if (temp & ActiveCRT2)
> -			tempcl = SetCRT2ToRAMDAC;
> -	}
> -
> -	if (temp & ActiveLCD) {
> -		tempcl |= SetCRT2ToLCD;
> -		if (temp & DriverMode) {
> -			if (temp & ActiveTV) {
> -				tempch = SetToLCDA | EnableDualEdge;
> -				temp ^= SetCRT2ToLCD;
> -
> -				if ((temp >> 8) & ActiveAVideo)
> -					tempcl |= SetCRT2ToAVIDEO;
> -				if ((temp >> 8) & ActiveSVideo)
> -					tempcl |= SetCRT2ToSVIDEO;
> -				if ((temp >> 8) & ActiveSCART)
> -					tempcl |= SetCRT2ToSCART;
> -
> -				if (pVBInfo->IF_DEF_HiVision == 1) {
> -					if ((temp >> 8) & ActiveHiTV)
> -						tempcl |= SetCRT2ToHiVision;
> -				}
> -
> -				if (pVBInfo->IF_DEF_YPbPr == 1) {
> -					if ((temp >> 8) & ActiveYPbPr)
> -						tempch |= SetYPbPr;
> -				}
> -			}
> -		}
> -	} else {
> -		if ((temp >> 8) & ActiveAVideo)
> -			tempcl |= SetCRT2ToAVIDEO;
> -		if ((temp >> 8) & ActiveSVideo)
> -			tempcl |= SetCRT2ToSVIDEO;
> -		if ((temp >> 8) & ActiveSCART)
> -			tempcl |= SetCRT2ToSCART;
> -
> -		if (pVBInfo->IF_DEF_HiVision == 1) {
> -			if ((temp >> 8) & ActiveHiTV)
> -				tempcl |= SetCRT2ToHiVision;
> -		}
> -
> -		if (pVBInfo->IF_DEF_YPbPr == 1) {
> -			if ((temp >> 8) & ActiveYPbPr)
> -				tempch |= SetYPbPr;
> -		}
> -	}
> -
> -	tempcl |= SetSimuScanMode;
> -	if ((!(temp & ActiveCRT1)) && ((temp & ActiveLCD) ||
> -				       (temp & ActiveTV) ||
> -				       (temp & ActiveCRT2)))
> -		tempcl ^= (SetSimuScanMode | SwitchCRT2);
> -	if ((temp & ActiveLCD) && (temp & ActiveTV))
> -		tempcl ^= (SetSimuScanMode | SwitchCRT2);
> -	xgifb_reg_set(pVBInfo->P3d4, 0x30, tempcl);
> -
> -	CR31Data = xgifb_reg_get(pVBInfo->P3d4, 0x31);
> -	CR31Data &= ~(SetNotSimuMode >> 8);
> -	if (!(temp & ActiveCRT1))
> -		CR31Data |= (SetNotSimuMode >> 8);
> -	CR31Data &= ~(DisableCRT2Display >> 8);
> -	if (!((temp & ActiveLCD) || (temp & ActiveTV) || (temp & ActiveCRT2)))
> -		CR31Data |= (DisableCRT2Display >> 8);
> -	xgifb_reg_set(pVBInfo->P3d4, 0x31, CR31Data);
> -
> -	CR38Data = xgifb_reg_get(pVBInfo->P3d4, 0x38);
> -	CR38Data &= ~SetYPbPr;
> -	CR38Data |= tempch;
> -	xgifb_reg_set(pVBInfo->P3d4, 0x38, CR38Data);
> -}
> -
> -static unsigned short XGINew_SenseLCD(struct xgi_hw_device_info
> -							*HwDeviceExtension,
> -				      struct vb_device_info *pVBInfo)
> -{
> -	unsigned short temp = HwDeviceExtension->ulCRT2LCDType;
> -
> -	switch (HwDeviceExtension->ulCRT2LCDType) {
> -	case LCD_640x480:
> -	case LCD_1024x600:
> -	case LCD_1152x864:
> -	case LCD_1280x960:
> -	case LCD_1152x768:
> -	case LCD_1920x1440:
> -	case LCD_2048x1536:
> -		temp = 0; /* overwrite used ulCRT2LCDType */
> -		break;
> -	case LCD_UNKNOWN: /* unknown lcd, do nothing */
> -		return 0;
> -	}
> -	xgifb_reg_and_or(pVBInfo->P3d4, 0x36, 0xF0, temp);
> -	return 1;
> -}
> -
> -static void XGINew_GetXG21Sense(struct pci_dev *pdev,
> -				struct vb_device_info *pVBInfo)
> -{
> -	struct xgifb_video_info *xgifb_info = pci_get_drvdata(pdev);
> -	unsigned char Temp;
> -
> -	if (xgifb_read_vbios(pdev)) { /* For XG21 LVDS */
> -		xgifb_reg_or(pVBInfo->P3d4, 0x32, LCDSense);
> -		/* LVDS on chip */
> -		xgifb_reg_and_or(pVBInfo->P3d4, 0x38, ~0xE0, 0xC0);
> -	} else {
> -		/* Enable GPIOA/B read */
> -		xgifb_reg_and_or(pVBInfo->P3d4, 0x4A, ~0x03, 0x03);
> -		Temp = xgifb_reg_get(pVBInfo->P3d4, 0x48) & 0xC0;
> -		if (Temp == 0xC0) { /* DVI & DVO GPIOA/B pull high */
> -			XGINew_SenseLCD(&xgifb_info->hw_info, pVBInfo);
> -			xgifb_reg_or(pVBInfo->P3d4, 0x32, LCDSense);
> -			/* Enable read GPIOF */
> -			xgifb_reg_and_or(pVBInfo->P3d4, 0x4A, ~0x20, 0x20);
> -			if (xgifb_reg_get(pVBInfo->P3d4, 0x48) & 0x04)
> -				Temp = 0xA0; /* Only DVO on chip */
> -			else
> -				Temp = 0x80; /* TMDS on chip */
> -			xgifb_reg_and_or(pVBInfo->P3d4, 0x38, ~0xE0, Temp);
> -			/* Disable read GPIOF */
> -			xgifb_reg_and(pVBInfo->P3d4, 0x4A, ~0x20);
> -		}
> -	}
> -}
> -
> -static void XGINew_GetXG27Sense(struct vb_device_info *pVBInfo)
> -{
> -	unsigned char Temp, bCR4A;
> -
> -	bCR4A = xgifb_reg_get(pVBInfo->P3d4, 0x4A);
> -	/* Enable GPIOA/B/C read */
> -	xgifb_reg_and_or(pVBInfo->P3d4, 0x4A, ~0x07, 0x07);
> -	Temp = xgifb_reg_get(pVBInfo->P3d4, 0x48) & 0x07;
> -	xgifb_reg_set(pVBInfo->P3d4, 0x4A, bCR4A);
> -
> -	if (Temp <= 0x02) {
> -		/* LVDS setting */
> -		xgifb_reg_and_or(pVBInfo->P3d4, 0x38, ~0xE0, 0xC0);
> -		xgifb_reg_set(pVBInfo->P3d4, 0x30, 0x21);
> -	} else {
> -		/* TMDS/DVO setting */
> -		xgifb_reg_and_or(pVBInfo->P3d4, 0x38, ~0xE0, 0xA0);
> -	}
> -	xgifb_reg_or(pVBInfo->P3d4, 0x32, LCDSense);
> -}
> -
> -static unsigned char GetXG21FPBits(struct vb_device_info *pVBInfo)
> -{
> -	unsigned char CR38, CR4A, temp;
> -
> -	CR4A = xgifb_reg_get(pVBInfo->P3d4, 0x4A);
> -	/* enable GPIOE read */
> -	xgifb_reg_and_or(pVBInfo->P3d4, 0x4A, ~0x10, 0x10);
> -	CR38 = xgifb_reg_get(pVBInfo->P3d4, 0x38);
> -	temp = 0;
> -	if ((CR38 & 0xE0) > 0x80) {
> -		temp = xgifb_reg_get(pVBInfo->P3d4, 0x48);
> -		temp &= 0x08;
> -		temp >>= 3;
> -	}
> -
> -	xgifb_reg_set(pVBInfo->P3d4, 0x4A, CR4A);
> -
> -	return temp;
> -}
> -
> -static unsigned char GetXG27FPBits(struct vb_device_info *pVBInfo)
> -{
> -	unsigned char CR4A, temp;
> -
> -	CR4A = xgifb_reg_get(pVBInfo->P3d4, 0x4A);
> -	/* enable GPIOA/B/C read */
> -	xgifb_reg_and_or(pVBInfo->P3d4, 0x4A, ~0x03, 0x03);
> -	temp = xgifb_reg_get(pVBInfo->P3d4, 0x48);
> -	if (temp > 2)
> -		temp = ((temp & 0x04) >> 1) | ((~temp) & 0x01);
> -
> -	xgifb_reg_set(pVBInfo->P3d4, 0x4A, CR4A);
> -
> -	return temp;
> -}
> -
> -static bool xgifb_bridge_is_on(struct vb_device_info *vb_info)
> -{
> -	u8 flag;
> -
> -	flag = xgifb_reg_get(vb_info->Part4Port, 0x00);
> -	return flag == 1 || flag == 2;
> -}
> -
> -unsigned char XGIInitNew(struct pci_dev *pdev)
> -{
> -	struct xgifb_video_info *xgifb_info = pci_get_drvdata(pdev);
> -	struct xgi_hw_device_info *HwDeviceExtension = &xgifb_info->hw_info;
> -	struct vb_device_info VBINF;
> -	struct vb_device_info *pVBInfo = &VBINF;
> -	unsigned char i, temp = 0, temp1;
> -
> -	pVBInfo->FBAddr = HwDeviceExtension->pjVideoMemoryAddress;
> -
> -	if (!pVBInfo->FBAddr) {
> -		dev_dbg(&pdev->dev, "pVBInfo->FBAddr == 0\n");
> -		return 0;
> -	}
> -
> -	XGIRegInit(pVBInfo, xgifb_info->vga_base);
> -
> -	outb(0x67, pVBInfo->P3c2);
> -
> -	InitTo330Pointer(HwDeviceExtension->jChipType, pVBInfo);
> -
> -	/* Openkey */
> -	xgifb_reg_set(pVBInfo->P3c4, 0x05, 0x86);
> -
> -	/* GetXG21Sense (GPIO) */
> -	if (HwDeviceExtension->jChipType == XG21)
> -		XGINew_GetXG21Sense(pdev, pVBInfo);
> -
> -	if (HwDeviceExtension->jChipType == XG27)
> -		XGINew_GetXG27Sense(pVBInfo);
> -
> -	/* Reset Extended register */
> -
> -	for (i = 0x06; i < 0x20; i++)
> -		xgifb_reg_set(pVBInfo->P3c4, i, 0);
> -
> -	for (i = 0x21; i <= 0x27; i++)
> -		xgifb_reg_set(pVBInfo->P3c4, i, 0);
> -
> -	for (i = 0x31; i <= 0x3B; i++)
> -		xgifb_reg_set(pVBInfo->P3c4, i, 0);
> -
> -	/* Auto over driver for XG42 */
> -	if (HwDeviceExtension->jChipType == XG42)
> -		xgifb_reg_set(pVBInfo->P3c4, 0x3B, 0xC0);
> -
> -	for (i = 0x79; i <= 0x7C; i++)
> -		xgifb_reg_set(pVBInfo->P3d4, i, 0);
> -
> -	if (HwDeviceExtension->jChipType >= XG20)
> -		xgifb_reg_set(pVBInfo->P3d4, 0x97, pVBInfo->XGINew_CR97);
> -
> -	/* SetDefExt1Regs begin */
> -	xgifb_reg_set(pVBInfo->P3c4, 0x07, XGI330_SR07);
> -	if (HwDeviceExtension->jChipType == XG27) {
> -		xgifb_reg_set(pVBInfo->P3c4, 0x40, XG27_SR40);
> -		xgifb_reg_set(pVBInfo->P3c4, 0x41, XG27_SR41);
> -	}
> -	xgifb_reg_set(pVBInfo->P3c4, 0x11, 0x0F);
> -	xgifb_reg_set(pVBInfo->P3c4, 0x1F, XGI330_SR1F);
> -	/* Frame buffer can read/write SR20 */
> -	xgifb_reg_set(pVBInfo->P3c4, 0x20, 0xA0);
> -	/* H/W request for slow corner chip */
> -	xgifb_reg_set(pVBInfo->P3c4, 0x36, 0x70);
> -	if (HwDeviceExtension->jChipType == XG27)
> -		xgifb_reg_set(pVBInfo->P3c4, 0x36, XG27_SR36);
> -
> -	if (HwDeviceExtension->jChipType < XG20) {
> -		u32 Temp;
> -
> -		/* Set AGP customize registers (in SetDefAGPRegs) Start */
> -		for (i = 0x47; i <= 0x4C; i++)
> -			xgifb_reg_set(pVBInfo->P3d4,
> -				      i,
> -				      XGI340_AGPReg[i - 0x47]);
> -
> -		for (i = 0x70; i <= 0x71; i++)
> -			xgifb_reg_set(pVBInfo->P3d4,
> -				      i,
> -				      XGI340_AGPReg[6 + i - 0x70]);
> -
> -		for (i = 0x74; i <= 0x77; i++)
> -			xgifb_reg_set(pVBInfo->P3d4,
> -				      i,
> -				      XGI340_AGPReg[8 + i - 0x74]);
> -
> -		pci_read_config_dword(pdev, 0x50, &Temp);
> -		Temp >>= 20;
> -		Temp &= 0xF;
> -
> -		if (Temp == 1)
> -			xgifb_reg_set(pVBInfo->P3d4, 0x48, 0x20); /* CR48 */
> -	} /* != XG20 */
> -
> -	/* Set PCI */
> -	xgifb_reg_set(pVBInfo->P3c4, 0x23, XGI330_SR23);
> -	xgifb_reg_set(pVBInfo->P3c4, 0x24, XGI330_SR24);
> -	xgifb_reg_set(pVBInfo->P3c4, 0x25, 0);
> -
> -	if (HwDeviceExtension->jChipType < XG20) {
> -		/* Set VB */
> -		XGI_UnLockCRT2(pVBInfo);
> -		/* disable VideoCapture */
> -		xgifb_reg_and_or(pVBInfo->Part0Port, 0x3F, 0xEF, 0x00);
> -		xgifb_reg_set(pVBInfo->Part1Port, 0x00, 0x00);
> -		/* chk if BCLK>=100MHz */
> -		temp1 = xgifb_reg_get(pVBInfo->P3d4, 0x7B);
> -
> -		xgifb_reg_set(pVBInfo->Part1Port,
> -			      0x02, XGI330_CRT2Data_1_2);
> -
> -		xgifb_reg_set(pVBInfo->Part1Port, 0x2E, 0x08); /* use VB */
> -	} /* != XG20 */
> -
> -	xgifb_reg_set(pVBInfo->P3c4, 0x27, 0x1F);
> -
> -	if ((HwDeviceExtension->jChipType == XG42) &&
> -	    XGINew_GetXG20DRAMType(HwDeviceExtension, pVBInfo) != 0) {
> -		/* Not DDR */
> -		xgifb_reg_set(pVBInfo->P3c4,
> -			      0x31,
> -			      (XGI330_SR31 & 0x3F) | 0x40);
> -		xgifb_reg_set(pVBInfo->P3c4,
> -			      0x32,
> -			      (XGI330_SR32 & 0xFC) | 0x01);
> -	} else {
> -		xgifb_reg_set(pVBInfo->P3c4, 0x31, XGI330_SR31);
> -		xgifb_reg_set(pVBInfo->P3c4, 0x32, XGI330_SR32);
> -	}
> -	xgifb_reg_set(pVBInfo->P3c4, 0x33, XGI330_SR33);
> -
> -	if (HwDeviceExtension->jChipType < XG20) {
> -		if (xgifb_bridge_is_on(pVBInfo)) {
> -			xgifb_reg_set(pVBInfo->Part2Port, 0x00, 0x1C);
> -			xgifb_reg_set(pVBInfo->Part4Port,
> -				      0x0D, XGI330_CRT2Data_4_D);
> -			xgifb_reg_set(pVBInfo->Part4Port,
> -				      0x0E, XGI330_CRT2Data_4_E);
> -			xgifb_reg_set(pVBInfo->Part4Port,
> -				      0x10, XGI330_CRT2Data_4_10);
> -			xgifb_reg_set(pVBInfo->Part4Port, 0x0F, 0x3F);
> -			XGI_LockCRT2(pVBInfo);
> -		}
> -	} /* != XG20 */
> -
> -	XGI_SenseCRT1(pVBInfo);
> -
> -	if (HwDeviceExtension->jChipType == XG21) {
> -		xgifb_reg_and_or(pVBInfo->P3d4,
> -				 0x32,
> -				 ~Monitor1Sense,
> -				 Monitor1Sense); /* Z9 default has CRT */
> -		temp = GetXG21FPBits(pVBInfo);
> -		xgifb_reg_and_or(pVBInfo->P3d4, 0x37, ~0x01, temp);
> -	}
> -	if (HwDeviceExtension->jChipType == XG27) {
> -		xgifb_reg_and_or(pVBInfo->P3d4,
> -				 0x32,
> -				 ~Monitor1Sense,
> -				 Monitor1Sense); /* Z9 default has CRT */
> -		temp = GetXG27FPBits(pVBInfo);
> -		xgifb_reg_and_or(pVBInfo->P3d4, 0x37, ~0x03, temp);
> -	}
> -
> -	pVBInfo->ram_type = XGINew_GetXG20DRAMType(HwDeviceExtension, pVBInfo);
> -
> -	XGINew_SetDRAMDefaultRegister340(HwDeviceExtension,
> -					 pVBInfo->P3d4,
> -					 pVBInfo);
> -
> -	XGINew_SetDRAMSize_340(xgifb_info, HwDeviceExtension, pVBInfo);
> -
> -	xgifb_reg_set(pVBInfo->P3c4, 0x22, 0xfa);
> -	xgifb_reg_set(pVBInfo->P3c4, 0x21, 0xa3);
> -
> -	XGINew_ChkSenseStatus(pVBInfo);
> -	XGINew_SetModeScratch(pVBInfo);
> -
> -	xgifb_reg_set(pVBInfo->P3d4, 0x8c, 0x87);
> -
> -	return 1;
> -} /* end of init */
> diff --git a/drivers/staging/xgifb/vb_init.h b/drivers/staging/xgifb/vb_init.h
> deleted file mode 100644
> index 2f8a70133ebd..000000000000
> --- a/drivers/staging/xgifb/vb_init.h
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _VBINIT_
> -#define _VBINIT_
> -unsigned char XGIInitNew(struct pci_dev *pdev);
> -void XGIRegInit(struct vb_device_info *XGI_Pr, unsigned long BaseAddr);
> -#endif
> diff --git a/drivers/staging/xgifb/vb_setmode.c b/drivers/staging/xgifb/vb_setmode.c
> deleted file mode 100644
> index 3782f8641bf2..000000000000
> --- a/drivers/staging/xgifb/vb_setmode.c
> +++ /dev/null
> @@ -1,5528 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <linux/delay.h>
> -#include "XGIfb.h"
> -
> -#include "vb_def.h"
> -#include "vb_init.h"
> -#include "vb_util.h"
> -#include "vb_table.h"
> -#include "vb_setmode.h"
> -
> -#define  IndexMask 0xff
> -#define TVCLKBASE_315_25 (TVCLKBASE_315 + 25)
> -
> -static const unsigned short XGINew_VGA_DAC[] = {
> -	0x00, 0x10, 0x04, 0x14, 0x01, 0x11, 0x09, 0x15,
> -	0x2A, 0x3A, 0x2E, 0x3E, 0x2B, 0x3B, 0x2F, 0x3F,
> -	0x00, 0x05, 0x08, 0x0B, 0x0E, 0x11, 0x14, 0x18,
> -	0x1C, 0x20, 0x24, 0x28, 0x2D, 0x32, 0x38, 0x3F,
> -	0x00, 0x10, 0x1F, 0x2F, 0x3F, 0x1F, 0x27, 0x2F,
> -	0x37, 0x3F, 0x2D, 0x31, 0x36, 0x3A, 0x3F, 0x00,
> -	0x07, 0x0E, 0x15, 0x1C, 0x0E, 0x11, 0x15, 0x18,
> -	0x1C, 0x14, 0x16, 0x18, 0x1A, 0x1C, 0x00, 0x04,
> -	0x08, 0x0C, 0x10, 0x08, 0x0A, 0x0C, 0x0E, 0x10,
> -	0x0B, 0x0C, 0x0D, 0x0F, 0x10};
> -
> -void InitTo330Pointer(unsigned char ChipType, struct vb_device_info *pVBInfo)
> -{
> -	pVBInfo->MCLKData = XGI340New_MCLKData;
> -
> -	pVBInfo->LCDResInfo = 0;
> -	pVBInfo->LCDTypeInfo = 0;
> -	pVBInfo->LCDInfo = 0;
> -	pVBInfo->VBInfo = 0;
> -	pVBInfo->TVInfo = 0;
> -
> -	pVBInfo->SR18 = XGI340_SR18;
> -	pVBInfo->CR40 = XGI340_cr41;
> -
> -	if (ChipType < XG20)
> -		XGI_GetVBType(pVBInfo);
> -
> -	/* 310 customization related */
> -	if ((pVBInfo->VBType & VB_SIS301LV) || (pVBInfo->VBType & VB_SIS302LV))
> -		pVBInfo->LCDCapList = XGI_LCDDLCapList;
> -	else
> -		pVBInfo->LCDCapList = XGI_LCDCapList;
> -
> -	if (ChipType >= XG20)
> -		pVBInfo->XGINew_CR97 = 0x10;
> -
> -	if (ChipType == XG27) {
> -		unsigned char temp;
> -
> -		pVBInfo->MCLKData = XGI27New_MCLKData;
> -		pVBInfo->CR40 = XGI27_cr41;
> -		pVBInfo->XGINew_CR97 = 0xc1;
> -		pVBInfo->SR18 = XG27_SR18;
> -
> -		/* Z11m DDR */
> -		temp = xgifb_reg_get(pVBInfo->P3c4, 0x3B);
> -		/* SR3B[7][3]MAA15 MAA11 (Power on Trapping) */
> -		if (((temp & 0x88) == 0x80) || ((temp & 0x88) == 0x08))
> -			pVBInfo->XGINew_CR97 = 0x80;
> -	}
> -}
> -
> -static void XGI_SetSeqRegs(struct vb_device_info *pVBInfo)
> -{
> -	unsigned char SRdata, i;
> -
> -	xgifb_reg_set(pVBInfo->P3c4, 0x00, 0x03); /* Set SR0 */
> -
> -	for (i = 0; i < 4; i++) {
> -		/* Get SR1,2,3,4 from file */
> -		/* SR1 is with screen off 0x20 */
> -		SRdata = XGI330_StandTable.SR[i];
> -		/* Set SR 1 2 3 4 */
> -		xgifb_reg_set(pVBInfo->P3c4, i + 1, SRdata);
> -	}
> -}
> -
> -static void XGI_SetCRTCRegs(struct vb_device_info *pVBInfo)
> -{
> -	unsigned char CRTCdata;
> -	unsigned short i;
> -
> -	CRTCdata = xgifb_reg_get(pVBInfo->P3d4, 0x11);
> -	CRTCdata &= 0x7f;
> -	xgifb_reg_set(pVBInfo->P3d4, 0x11, CRTCdata); /* Unlock CRTC */
> -
> -	for (i = 0; i <= 0x18; i++) {
> -		/* Get CRTC from file */
> -		CRTCdata = XGI330_StandTable.CRTC[i];
> -		xgifb_reg_set(pVBInfo->P3d4, i, CRTCdata); /* Set CRTC(3d4) */
> -	}
> -}
> -
> -static void XGI_SetATTRegs(unsigned short ModeIdIndex,
> -			   struct vb_device_info *pVBInfo)
> -{
> -	unsigned char ARdata;
> -	unsigned short i, modeflag;
> -
> -	modeflag = XGI330_EModeIDTable[ModeIdIndex].Ext_ModeFlag;
> -
> -	for (i = 0; i <= 0x13; i++) {
> -		ARdata = XGI330_StandTable.ATTR[i];
> -
> -		if ((modeflag & Charx8Dot) && i == 0x13) { /* ifndef Dot9 */
> -			if (pVBInfo->VBInfo & XGI_SetCRT2ToLCDA) {
> -				ARdata = 0;
> -			} else if ((pVBInfo->VBInfo &
> -				   (SetCRT2ToTV | SetCRT2ToLCD)) &&
> -				   (pVBInfo->VBInfo & SetInSlaveMode)) {
> -				ARdata = 0;
> -			}
> -		}
> -
> -		inb(pVBInfo->P3da); /* reset 3da */
> -		outb(i, pVBInfo->P3c0); /* set index */
> -		outb(ARdata, pVBInfo->P3c0); /* set data */
> -	}
> -
> -	inb(pVBInfo->P3da); /* reset 3da */
> -	outb(0x14, pVBInfo->P3c0); /* set index */
> -	outb(0x00, pVBInfo->P3c0); /* set data */
> -	inb(pVBInfo->P3da); /* Enable Attribute */
> -	outb(0x20, pVBInfo->P3c0);
> -}
> -
> -static void XGI_SetGRCRegs(struct vb_device_info *pVBInfo)
> -{
> -	unsigned char GRdata;
> -	unsigned short i;
> -
> -	for (i = 0; i <= 0x08; i++) {
> -		/* Get GR from file */
> -		GRdata = XGI330_StandTable.GRC[i];
> -		xgifb_reg_set(pVBInfo->P3ce, i, GRdata); /* Set GR(3ce) */
> -	}
> -
> -	if (pVBInfo->ModeType > ModeVGA) {
> -		GRdata = xgifb_reg_get(pVBInfo->P3ce, 0x05);
> -		GRdata &= 0xBF; /* 256 color disable */
> -		xgifb_reg_set(pVBInfo->P3ce, 0x05, GRdata);
> -	}
> -}
> -
> -static void XGI_ClearExt1Regs(struct vb_device_info *pVBInfo)
> -{
> -	unsigned short i;
> -
> -	for (i = 0x0A; i <= 0x0E; i++)
> -		xgifb_reg_set(pVBInfo->P3c4, i, 0x00); /* Clear SR0A-SR0E */
> -}
> -
> -static unsigned char XGI_SetDefaultVCLK(struct vb_device_info *pVBInfo)
> -{
> -	xgifb_reg_and_or(pVBInfo->P3c4, 0x31, ~0x30, 0x20);
> -	xgifb_reg_set(pVBInfo->P3c4, 0x2B, XGI_VCLKData[0].SR2B);
> -	xgifb_reg_set(pVBInfo->P3c4, 0x2C, XGI_VCLKData[0].SR2C);
> -
> -	xgifb_reg_and_or(pVBInfo->P3c4, 0x31, ~0x30, 0x10);
> -	xgifb_reg_set(pVBInfo->P3c4, 0x2B, XGI_VCLKData[1].SR2B);
> -	xgifb_reg_set(pVBInfo->P3c4, 0x2C, XGI_VCLKData[1].SR2C);
> -
> -	xgifb_reg_and(pVBInfo->P3c4, 0x31, ~0x30);
> -	return 0;
> -}
> -
> -static unsigned char XGI_AjustCRT2Rate(unsigned short ModeIdIndex,
> -				       unsigned short RefreshRateTableIndex,
> -				       unsigned short *i,
> -		struct vb_device_info *pVBInfo)
> -{
> -	unsigned short tempax, tempbx, resinfo, modeflag, infoflag;
> -
> -	modeflag = XGI330_EModeIDTable[ModeIdIndex].Ext_ModeFlag;
> -	resinfo = XGI330_EModeIDTable[ModeIdIndex].Ext_RESINFO;
> -	tempbx = XGI330_RefIndex[RefreshRateTableIndex + (*i)].ModeID;
> -	tempax = 0;
> -
> -	if (pVBInfo->VBInfo & SetCRT2ToRAMDAC) {
> -		tempax |= SupportRAMDAC2;
> -
> -		if (pVBInfo->VBType & VB_XGI301C)
> -			tempax |= SupportCRT2in301C;
> -	}
> -
> -	/* 301b */
> -	if (pVBInfo->VBInfo & (SetCRT2ToLCD | XGI_SetCRT2ToLCDA)) {
> -		tempax |= SupportLCD;
> -
> -		if (pVBInfo->LCDResInfo != Panel_1280x1024 &&
> -		    pVBInfo->LCDResInfo != Panel_1280x960 &&
> -		    (pVBInfo->LCDInfo & LCDNonExpanding) &&
> -		    resinfo >= 9)
> -			return 0;
> -	}
> -
> -	if (pVBInfo->VBInfo & SetCRT2ToHiVision) { /* for HiTV */
> -		tempax |= SupportHiVision;
> -		if ((pVBInfo->VBInfo & SetInSlaveMode) &&
> -		    ((resinfo == 4) ||
> -		     (resinfo == 3 && (pVBInfo->SetFlag & TVSimuMode)) ||
> -		     (resinfo > 7)))
> -			return 0;
> -	} else if (pVBInfo->VBInfo & (SetCRT2ToAVIDEO | SetCRT2ToSVIDEO |
> -				      SetCRT2ToSCART | SetCRT2ToYPbPr525750 |
> -				      SetCRT2ToHiVision)) {
> -		tempax |= SupportTV;
> -
> -		if (pVBInfo->VBType & (VB_SIS301B | VB_SIS302B | VB_SIS301LV |
> -				       VB_SIS302LV | VB_XGI301C))
> -			tempax |= SupportTV1024;
> -
> -		if (!(pVBInfo->VBInfo & TVSetPAL) &&
> -		    (modeflag & NoSupportSimuTV) &&
> -		    (pVBInfo->VBInfo & SetInSlaveMode) &&
> -		    !(pVBInfo->VBInfo & SetNotSimuMode))
> -			return 0;
> -	}
> -
> -	for (; XGI330_RefIndex[RefreshRateTableIndex + (*i)].ModeID ==
> -	       tempbx; (*i)--) {
> -		infoflag = XGI330_RefIndex[RefreshRateTableIndex + (*i)].Ext_InfoFlag;
> -		if (infoflag & tempax)
> -			return 1;
> -
> -		if ((*i) == 0)
> -			break;
> -	}
> -
> -	for ((*i) = 0;; (*i)++) {
> -		infoflag = XGI330_RefIndex[RefreshRateTableIndex + (*i)].Ext_InfoFlag;
> -		if (XGI330_RefIndex[RefreshRateTableIndex + (*i)].ModeID
> -				!= tempbx) {
> -			return 0;
> -		}
> -
> -		if (infoflag & tempax)
> -			return 1;
> -	}
> -	return 1;
> -}
> -
> -static void XGI_SetSync(unsigned short RefreshRateTableIndex,
> -			struct vb_device_info *pVBInfo)
> -{
> -	unsigned short sync, temp;
> -
> -	/* di+0x00 */
> -	sync = XGI330_RefIndex[RefreshRateTableIndex].Ext_InfoFlag >> 8;
> -	sync &= 0xC0;
> -	temp = 0x2F;
> -	temp |= sync;
> -	outb(temp, pVBInfo->P3c2); /* Set Misc(3c2) */
> -}
> -
> -static void XGI_SetCRT1Timing_H(struct vb_device_info *pVBInfo,
> -				struct xgi_hw_device_info *HwDeviceExtension)
> -{
> -	unsigned char data, data1, pushax;
> -	unsigned short i, j;
> -
> -	/* unlock cr0-7 */
> -	data = xgifb_reg_get(pVBInfo->P3d4, 0x11);
> -	data &= 0x7F;
> -	xgifb_reg_set(pVBInfo->P3d4, 0x11, data);
> -
> -	data = pVBInfo->TimingH.data[0];
> -	xgifb_reg_set(pVBInfo->P3d4, 0, data);
> -
> -	for (i = 0x01; i <= 0x04; i++) {
> -		data = pVBInfo->TimingH.data[i];
> -		xgifb_reg_set(pVBInfo->P3d4, (unsigned short)(i + 1), data);
> -	}
> -
> -	for (i = 0x05; i <= 0x06; i++) {
> -		data = pVBInfo->TimingH.data[i];
> -		xgifb_reg_set(pVBInfo->P3c4, (unsigned short)(i + 6), data);
> -	}
> -
> -	j = xgifb_reg_get(pVBInfo->P3c4, 0x0e);
> -	j &= 0x1F;
> -	data = pVBInfo->TimingH.data[7];
> -	data &= 0xE0;
> -	data |= j;
> -	xgifb_reg_set(pVBInfo->P3c4, 0x0e, data);
> -
> -	if (HwDeviceExtension->jChipType >= XG20) {
> -		data = xgifb_reg_get(pVBInfo->P3d4, 0x04);
> -		data = data - 1;
> -		xgifb_reg_set(pVBInfo->P3d4, 0x04, data);
> -		data = xgifb_reg_get(pVBInfo->P3d4, 0x05);
> -		data1 = data;
> -		data1 &= 0xE0;
> -		data &= 0x1F;
> -		if (data == 0) {
> -			pushax = data;
> -			data = xgifb_reg_get(pVBInfo->P3c4, 0x0c);
> -			data &= 0xFB;
> -			xgifb_reg_set(pVBInfo->P3c4, 0x0c, data);
> -			data = pushax;
> -		}
> -		data = data - 1;
> -		data |= data1;
> -		xgifb_reg_set(pVBInfo->P3d4, 0x05, data);
> -		data = xgifb_reg_get(pVBInfo->P3c4, 0x0e);
> -		data >>= 5;
> -		data = data + 3;
> -		if (data > 7)
> -			data = data - 7;
> -		data <<= 5;
> -		xgifb_reg_and_or(pVBInfo->P3c4, 0x0e, ~0xE0, data);
> -	}
> -}
> -
> -static void XGI_SetCRT1Timing_V(unsigned short ModeIdIndex,
> -				struct vb_device_info *pVBInfo)
> -{
> -	unsigned char data;
> -	unsigned short i, j;
> -
> -	for (i = 0x00; i <= 0x01; i++) {
> -		data = pVBInfo->TimingV.data[i];
> -		xgifb_reg_set(pVBInfo->P3d4, (unsigned short)(i + 6), data);
> -	}
> -
> -	for (i = 0x02; i <= 0x03; i++) {
> -		data = pVBInfo->TimingV.data[i];
> -		xgifb_reg_set(pVBInfo->P3d4, (unsigned short)(i + 0x0e), data);
> -	}
> -
> -	for (i = 0x04; i <= 0x05; i++) {
> -		data = pVBInfo->TimingV.data[i];
> -		xgifb_reg_set(pVBInfo->P3d4, (unsigned short)(i + 0x11), data);
> -	}
> -
> -	j = xgifb_reg_get(pVBInfo->P3c4, 0x0a);
> -	j &= 0xC0;
> -	data = pVBInfo->TimingV.data[6];
> -	data &= 0x3F;
> -	data |= j;
> -	xgifb_reg_set(pVBInfo->P3c4, 0x0a, data);
> -
> -	data = pVBInfo->TimingV.data[6];
> -	data &= 0x80;
> -	data >>= 2;
> -
> -	i = XGI330_EModeIDTable[ModeIdIndex].Ext_ModeFlag;
> -	i &= DoubleScanMode;
> -	if (i)
> -		data |= 0x80;
> -
> -	j = xgifb_reg_get(pVBInfo->P3d4, 0x09);
> -	j &= 0x5F;
> -	data |= j;
> -	xgifb_reg_set(pVBInfo->P3d4, 0x09, data);
> -}
> -
> -static void XGI_SetCRT1CRTC(unsigned short ModeIdIndex,
> -			    unsigned short RefreshRateTableIndex,
> -			    struct vb_device_info *pVBInfo,
> -			    struct xgi_hw_device_info *HwDeviceExtension)
> -{
> -	unsigned char index, data;
> -	unsigned short i;
> -
> -	/* Get index */
> -	index = XGI330_RefIndex[RefreshRateTableIndex].Ext_CRT1CRTC;
> -	index = index & IndexMask;
> -
> -	data = xgifb_reg_get(pVBInfo->P3d4, 0x11);
> -	data &= 0x7F;
> -	xgifb_reg_set(pVBInfo->P3d4, 0x11, data); /* Unlock CRTC */
> -
> -	for (i = 0; i < 8; i++)
> -		pVBInfo->TimingH.data[i]
> -				= XGI_CRT1Table[index].CR[i];
> -
> -	for (i = 0; i < 7; i++)
> -		pVBInfo->TimingV.data[i]
> -				= XGI_CRT1Table[index].CR[i + 8];
> -
> -	XGI_SetCRT1Timing_H(pVBInfo, HwDeviceExtension);
> -
> -	XGI_SetCRT1Timing_V(ModeIdIndex, pVBInfo);
> -
> -	if (pVBInfo->ModeType > 0x03)
> -		xgifb_reg_set(pVBInfo->P3d4, 0x14, 0x4F);
> -}
> -
> -/*
> - * Function : XGI_SetXG21CRTC
> - * Input : Stand or enhance CRTC table
> - * Output : Fill CRT Hsync/Vsync to SR2E/SR2F/SR30/SR33/SR34/SR3F
> - * Description : Set LCD timing
> - */
> -static void XGI_SetXG21CRTC(unsigned short RefreshRateTableIndex,
> -			    struct vb_device_info *pVBInfo)
> -{
> -	unsigned char index, Tempax, Tempbx, Tempcx, Tempdx;
> -	unsigned short Temp1, Temp2, Temp3;
> -
> -	index = XGI330_RefIndex[RefreshRateTableIndex].Ext_CRT1CRTC;
> -	/* Tempax: CR4 HRS */
> -	Tempax = XGI_CRT1Table[index].CR[3];
> -	Tempcx = Tempax; /* Tempcx: HRS */
> -	/* SR2E[7:0]->HRS */
> -	xgifb_reg_set(pVBInfo->P3c4, 0x2E, Tempax);
> -
> -	Tempdx = XGI_CRT1Table[index].CR[5]; /* SRB */
> -	Tempdx &= 0xC0; /* Tempdx[7:6]: SRB[7:6] */
> -	Temp1 = Tempdx; /* Temp1[7:6]: HRS[9:8] */
> -	Temp1 <<= 2; /* Temp1[9:8]: HRS[9:8] */
> -	Temp1 |= Tempax; /* Temp1[9:0]: HRS[9:0] */
> -
> -	Tempax = XGI_CRT1Table[index].CR[4]; /* CR5 HRE */
> -	Tempax &= 0x1F; /* Tempax[4:0]: HRE[4:0] */
> -
> -	Tempbx = XGI_CRT1Table[index].CR[6]; /* SRC */
> -	Tempbx &= 0x04; /* Tempbx[2]: HRE[5] */
> -	Tempbx <<= 3; /* Tempbx[5]: HRE[5] */
> -	Tempax |= Tempbx; /* Tempax[5:0]: HRE[5:0] */
> -
> -	Temp2 = Temp1 & 0x3C0; /* Temp2[9:6]: HRS[9:6] */
> -	Temp2 |= Tempax; /* Temp2[9:0]: HRE[9:0] */
> -
> -	Tempcx &= 0x3F; /* Tempcx[5:0]: HRS[5:0] */
> -	if (Tempax < Tempcx) /* HRE < HRS */
> -		Temp2 |= 0x40; /* Temp2 + 0x40 */
> -
> -	Temp2 &= 0xFF;
> -	Tempax = (unsigned char)Temp2; /* Tempax: HRE[7:0] */
> -	Tempax <<= 2; /* Tempax[7:2]: HRE[5:0] */
> -	Tempdx >>= 6; /* Tempdx[7:6]->[1:0] HRS[9:8] */
> -	Tempax |= Tempdx; /* HRE[5:0]HRS[9:8] */
> -	/* SR2F D[7:2]->HRE, D[1:0]->HRS */
> -	xgifb_reg_set(pVBInfo->P3c4, 0x2F, Tempax);
> -	xgifb_reg_and_or(pVBInfo->P3c4, 0x30, 0xE3, 00);
> -
> -	/* CR10 VRS */
> -	Tempax = XGI_CRT1Table[index].CR[10];
> -	Tempbx = Tempax; /* Tempbx: VRS */
> -	Tempax &= 0x01; /* Tempax[0]: VRS[0] */
> -	xgifb_reg_or(pVBInfo->P3c4, 0x33, Tempax); /* SR33[0]->VRS[0] */
> -	/* CR7[2][7] VRE */
> -	Tempax = XGI_CRT1Table[index].CR[9];
> -	Tempcx = Tempbx >> 1; /* Tempcx[6:0]: VRS[7:1] */
> -	Tempdx = Tempax & 0x04; /* Tempdx[2]: CR7[2] */
> -	Tempdx <<= 5; /* Tempdx[7]: VRS[8] */
> -	Tempcx |= Tempdx; /* Tempcx[7:0]: VRS[8:1] */
> -	xgifb_reg_set(pVBInfo->P3c4, 0x34, Tempcx); /* SR34[8:1]->VRS */
> -
> -	Temp1 = Tempdx; /* Temp1[7]: Tempdx[7] */
> -	Temp1 <<= 1; /* Temp1[8]: VRS[8] */
> -	Temp1 |= Tempbx; /* Temp1[8:0]: VRS[8:0] */
> -	Tempax &= 0x80;
> -	Temp2 = Tempax << 2; /* Temp2[9]: VRS[9] */
> -	Temp1 |= Temp2; /* Temp1[9:0]: VRS[9:0] */
> -	/* Tempax: SRA */
> -	Tempax = XGI_CRT1Table[index].CR[14];
> -	Tempax &= 0x08; /* Tempax[3]: VRS[3] */
> -	Temp2 = Tempax;
> -	Temp2 <<= 7; /* Temp2[10]: VRS[10] */
> -	Temp1 |= Temp2; /* Temp1[10:0]: VRS[10:0] */
> -
> -	/* Tempax: CR11 VRE */
> -	Tempax = XGI_CRT1Table[index].CR[11];
> -	Tempax &= 0x0F; /* Tempax[3:0]: VRE[3:0] */
> -	/* Tempbx: SRA */
> -	Tempbx = XGI_CRT1Table[index].CR[14];
> -	Tempbx &= 0x20; /* Tempbx[5]: VRE[5] */
> -	Tempbx >>= 1; /* Tempbx[4]: VRE[4] */
> -	Tempax |= Tempbx; /* Tempax[4:0]: VRE[4:0] */
> -	Temp2 = Temp1 & 0x7E0; /* Temp2[10:5]: VRS[10:5] */
> -	Temp2 |= Tempax; /* Temp2[10:5]: VRE[10:5] */
> -
> -	Temp3 = Temp1 & 0x1F; /* Temp3[4:0]: VRS[4:0] */
> -	if (Tempax < Temp3) /* VRE < VRS */
> -		Temp2 |= 0x20; /* VRE + 0x20 */
> -
> -	Temp2 &= 0xFF;
> -	Tempax = (unsigned char)Temp2; /* Tempax: VRE[7:0] */
> -	Tempax <<= 2; /* Tempax[7:0]; VRE[5:0]00 */
> -	Temp1 &= 0x600; /* Temp1[10:9]: VRS[10:9] */
> -	Temp1 >>= 9; /* Temp1[1:0]: VRS[10:9] */
> -	Tempbx = (unsigned char)Temp1;
> -	Tempax |= Tempbx; /* Tempax[7:0]: VRE[5:0]VRS[10:9] */
> -	Tempax &= 0x7F;
> -	/* SR3F D[7:2]->VRE D[1:0]->VRS */
> -	xgifb_reg_set(pVBInfo->P3c4, 0x3F, Tempax);
> -}
> -
> -static void XGI_SetXG27CRTC(unsigned short RefreshRateTableIndex,
> -			    struct vb_device_info *pVBInfo)
> -{
> -	unsigned short index, Tempax, Tempbx, Tempcx;
> -
> -	index = XGI330_RefIndex[RefreshRateTableIndex].Ext_CRT1CRTC;
> -	/* Tempax: CR4 HRS */
> -	Tempax = XGI_CRT1Table[index].CR[3];
> -	Tempbx = Tempax; /* Tempbx: HRS[7:0] */
> -	/* SR2E[7:0]->HRS */
> -	xgifb_reg_set(pVBInfo->P3c4, 0x2E, Tempax);
> -
> -	/* SR0B */
> -	Tempax = XGI_CRT1Table[index].CR[5];
> -	Tempax &= 0xC0; /* Tempax[7:6]: SR0B[7:6]: HRS[9:8] */
> -	Tempbx |= Tempax << 2; /* Tempbx: HRS[9:0] */
> -
> -	Tempax = XGI_CRT1Table[index].CR[4]; /* CR5 HRE */
> -	Tempax &= 0x1F; /* Tempax[4:0]: HRE[4:0] */
> -	Tempcx = Tempax; /* Tempcx: HRE[4:0] */
> -
> -	Tempax = XGI_CRT1Table[index].CR[6]; /* SRC */
> -	Tempax &= 0x04; /* Tempax[2]: HRE[5] */
> -	Tempax <<= 3; /* Tempax[5]: HRE[5] */
> -	Tempcx |= Tempax; /* Tempcx[5:0]: HRE[5:0] */
> -
> -	Tempbx = Tempbx & 0x3C0; /* Tempbx[9:6]: HRS[9:6] */
> -	Tempbx |= Tempcx; /* Tempbx: HRS[9:6]HRE[5:0] */
> -
> -	/* Tempax: CR4 HRS */
> -	Tempax = XGI_CRT1Table[index].CR[3];
> -	Tempax &= 0x3F; /* Tempax: HRS[5:0] */
> -	if (Tempcx <= Tempax) /* HRE[5:0] < HRS[5:0] */
> -		Tempbx += 0x40; /* Tempbx= Tempbx + 0x40 : HRE[9:0]*/
> -
> -	Tempax = XGI_CRT1Table[index].CR[5]; /* SR0B */
> -	Tempax &= 0xC0; /* Tempax[7:6]: SR0B[7:6]: HRS[9:8]*/
> -	Tempax >>= 6; /* Tempax[1:0]: HRS[9:8]*/
> -	Tempax |= (Tempbx << 2) & 0xFF; /* Tempax[7:2]: HRE[5:0] */
> -	/* SR2F [7:2][1:0]: HRE[5:0]HRS[9:8] */
> -	xgifb_reg_set(pVBInfo->P3c4, 0x2F, Tempax);
> -	xgifb_reg_and_or(pVBInfo->P3c4, 0x30, 0xE3, 00);
> -
> -	/* CR10 VRS */
> -	Tempax = XGI_CRT1Table[index].CR[10];
> -	/* SR34[7:0]->VRS[7:0] */
> -	xgifb_reg_set(pVBInfo->P3c4, 0x34, Tempax);
> -
> -	Tempcx = Tempax; /* Tempcx <= VRS[7:0] */
> -	/* CR7[7][2] VRS[9][8] */
> -	Tempax = XGI_CRT1Table[index].CR[9];
> -	Tempbx = Tempax; /* Tempbx <= CR07[7:0] */
> -	Tempax = Tempax & 0x04; /* Tempax[2]: CR7[2]: VRS[8] */
> -	Tempax >>= 2; /* Tempax[0]: VRS[8] */
> -	/* SR35[0]: VRS[8] */
> -	xgifb_reg_and_or(pVBInfo->P3c4, 0x35, ~0x01, Tempax);
> -	Tempcx |= Tempax << 8; /* Tempcx <= VRS[8:0] */
> -	Tempcx |= (Tempbx & 0x80) << 2; /* Tempcx <= VRS[9:0] */
> -	/* Tempax: SR0A */
> -	Tempax = XGI_CRT1Table[index].CR[14];
> -	Tempax &= 0x08; /* SR0A[3] VRS[10] */
> -	Tempcx |= Tempax << 7; /* Tempcx <= VRS[10:0] */
> -
> -	/* Tempax: CR11 VRE */
> -	Tempax = XGI_CRT1Table[index].CR[11];
> -	Tempax &= 0x0F; /* Tempax[3:0]: VRE[3:0] */
> -	/* Tempbx: SR0A */
> -	Tempbx = XGI_CRT1Table[index].CR[14];
> -	Tempbx &= 0x20; /* Tempbx[5]: SR0A[5]: VRE[4] */
> -	Tempbx >>= 1; /* Tempbx[4]: VRE[4] */
> -	Tempax |= Tempbx; /* Tempax[4:0]: VRE[4:0] */
> -	Tempbx = Tempcx; /* Tempbx: VRS[10:0] */
> -	Tempbx &= 0x7E0; /* Tempbx[10:5]: VRS[10:5] */
> -	Tempbx |= Tempax; /* Tempbx: VRS[10:5]VRE[4:0] */
> -
> -	if (Tempbx <= Tempcx) /* VRE <= VRS */
> -		Tempbx |= 0x20; /* VRE + 0x20 */
> -
> -	/* Tempax: Tempax[7:0]; VRE[5:0]00 */
> -	Tempax = (Tempbx << 2) & 0xFF;
> -	/* SR3F[7:2]:VRE[5:0] */
> -	xgifb_reg_and_or(pVBInfo->P3c4, 0x3F, ~0xFC, Tempax);
> -	Tempax = Tempcx >> 8;
> -	/* SR35[2:0]:VRS[10:8] */
> -	xgifb_reg_and_or(pVBInfo->P3c4, 0x35, ~0x07, Tempax);
> -}
> -
> -static void XGI_SetXG27FPBits(struct vb_device_info *pVBInfo)
> -{
> -	unsigned char temp;
> -
> -	/* D[1:0] 01: 18bit, 00: dual 12, 10: single 24 */
> -	temp = xgifb_reg_get(pVBInfo->P3d4, 0x37);
> -	temp = (temp & 3) << 6;
> -	/* SR06[7]0: dual 12/1: single 24 [6] 18bit Dither <= 0 h/w recommend */
> -	xgifb_reg_and_or(pVBInfo->P3c4, 0x06, ~0xc0, temp & 0x80);
> -	/* SR09[7] enable FP output, SR09[6] 1: sigle 18bits, 0: 24bits */
> -	xgifb_reg_and_or(pVBInfo->P3c4, 0x09, ~0xc0, temp | 0x80);
> -}
> -
> -static void xgifb_set_lcd(int chip_id,
> -			  struct vb_device_info *pVBInfo,
> -			  unsigned short RefreshRateTableIndex)
> -{
> -	unsigned short temp;
> -
> -	xgifb_reg_set(pVBInfo->P3d4, 0x2E, 0x00);
> -	xgifb_reg_set(pVBInfo->P3d4, 0x2F, 0x00);
> -	xgifb_reg_set(pVBInfo->P3d4, 0x46, 0x00);
> -	xgifb_reg_set(pVBInfo->P3d4, 0x47, 0x00);
> -
> -	if (chip_id == XG27) {
> -		temp = xgifb_reg_get(pVBInfo->P3d4, 0x37);
> -		if ((temp & 0x03) == 0) { /* dual 12 */
> -			xgifb_reg_set(pVBInfo->P3d4, 0x46, 0x13);
> -			xgifb_reg_set(pVBInfo->P3d4, 0x47, 0x13);
> -		}
> -	}
> -
> -	if (chip_id == XG27) {
> -		XGI_SetXG27FPBits(pVBInfo);
> -	} else {
> -		temp = xgifb_reg_get(pVBInfo->P3d4, 0x37);
> -		if (temp & 0x01) {
> -			/* 18 bits FP */
> -			xgifb_reg_or(pVBInfo->P3c4, 0x06, 0x40);
> -			xgifb_reg_or(pVBInfo->P3c4, 0x09, 0x40);
> -		}
> -	}
> -
> -	xgifb_reg_or(pVBInfo->P3c4, 0x1E, 0x01); /* Negative blank polarity */
> -
> -	xgifb_reg_and(pVBInfo->P3c4, 0x30, ~0x20); /* Hsync polarity */
> -	xgifb_reg_and(pVBInfo->P3c4, 0x35, ~0x80); /* Vsync polarity */
> -
> -	temp = XGI330_RefIndex[RefreshRateTableIndex].Ext_InfoFlag;
> -	if (temp & 0x4000) {
> -		/* Hsync polarity */
> -		xgifb_reg_or(pVBInfo->P3c4, 0x30, 0x20);
> -	}
> -	if (temp & 0x8000) {
> -		/* Vsync polarity */
> -		xgifb_reg_or(pVBInfo->P3c4, 0x35, 0x80);
> -	}
> -}
> -
> -/*
> - * Function : XGI_UpdateXG21CRTC
> - * Input :
> - * Output : CRT1 CRTC
> - * Description : Modify CRT1 Hsync/Vsync to fix LCD mode timing
> - */
> -static void XGI_UpdateXG21CRTC(unsigned short ModeNo,
> -			       struct vb_device_info *pVBInfo,
> -			       unsigned short RefreshRateTableIndex)
> -{
> -	int index = -1;
> -
> -	xgifb_reg_and(pVBInfo->P3d4, 0x11, 0x7F); /* Unlock CR0~7 */
> -	if (ModeNo == 0x2E &&
> -	    (XGI330_RefIndex[RefreshRateTableIndex].Ext_CRT1CRTC ==
> -								RES640x480x60))
> -		index = 12;
> -	else if (ModeNo == 0x2E &&
> -		 (XGI330_RefIndex[RefreshRateTableIndex].Ext_CRT1CRTC ==
> -								RES640x480x72))
> -		index = 13;
> -	else if (ModeNo == 0x2F)
> -		index = 14;
> -	else if (ModeNo == 0x50)
> -		index = 15;
> -	else if (ModeNo == 0x59)
> -		index = 16;
> -
> -	if (index != -1) {
> -		xgifb_reg_set(pVBInfo->P3d4, 0x02,
> -			      XGI_UpdateCRT1Table[index].CR02);
> -		xgifb_reg_set(pVBInfo->P3d4, 0x03,
> -			      XGI_UpdateCRT1Table[index].CR03);
> -		xgifb_reg_set(pVBInfo->P3d4, 0x15,
> -			      XGI_UpdateCRT1Table[index].CR15);
> -		xgifb_reg_set(pVBInfo->P3d4, 0x16,
> -			      XGI_UpdateCRT1Table[index].CR16);
> -	}
> -}
> -
> -static void XGI_SetCRT1DE(unsigned short ModeIdIndex,
> -			  unsigned short RefreshRateTableIndex,
> -			  struct vb_device_info *pVBInfo)
> -{
> -	unsigned short resindex, tempax, tempbx, tempcx, temp, modeflag;
> -
> -	unsigned char data;
> -
> -	resindex = XGI330_EModeIDTable[ModeIdIndex].Ext_RESINFO;
> -
> -	modeflag = XGI330_EModeIDTable[ModeIdIndex].Ext_ModeFlag;
> -	tempax = XGI330_ModeResInfo[resindex].HTotal;
> -	tempbx = XGI330_ModeResInfo[resindex].VTotal;
> -
> -	if (modeflag & HalfDCLK)
> -		tempax >>= 1;
> -
> -	if (modeflag & HalfDCLK)
> -		tempax <<= 1;
> -
> -	temp = XGI330_RefIndex[RefreshRateTableIndex].Ext_InfoFlag;
> -
> -	if (temp & InterlaceMode)
> -		tempbx >>= 1;
> -
> -	if (modeflag & DoubleScanMode)
> -		tempbx <<= 1;
> -
> -	tempcx = 8;
> -
> -	tempax /= tempcx;
> -	tempax -= 1;
> -	tempbx -= 1;
> -	tempcx = tempax;
> -	temp = xgifb_reg_get(pVBInfo->P3d4, 0x11);
> -	data = xgifb_reg_get(pVBInfo->P3d4, 0x11);
> -	data &= 0x7F;
> -	xgifb_reg_set(pVBInfo->P3d4, 0x11, data); /* Unlock CRTC */
> -	xgifb_reg_set(pVBInfo->P3d4, 0x01, (unsigned short)(tempcx & 0xff));
> -	xgifb_reg_and_or(pVBInfo->P3d4, 0x0b, ~0x0c,
> -			 (unsigned short)((tempcx & 0x0ff00) >> 10));
> -	xgifb_reg_set(pVBInfo->P3d4, 0x12, (unsigned short)(tempbx & 0xff));
> -	tempax = 0;
> -	tempbx >>= 8;
> -
> -	if (tempbx & 0x01)
> -		tempax |= 0x02;
> -
> -	if (tempbx & 0x02)
> -		tempax |= 0x40;
> -
> -	xgifb_reg_and_or(pVBInfo->P3d4, 0x07, ~0x42, tempax);
> -	data = xgifb_reg_get(pVBInfo->P3d4, 0x07);
> -	tempax = 0;
> -
> -	if (tempbx & 0x04)
> -		tempax |= 0x02;
> -
> -	xgifb_reg_and_or(pVBInfo->P3d4, 0x0a, ~0x02, tempax);
> -	xgifb_reg_set(pVBInfo->P3d4, 0x11, temp);
> -}
> -
> -static void XGI_SetCRT1Offset(unsigned short ModeNo,
> -			      unsigned short ModeIdIndex,
> -			      unsigned short RefreshRateTableIndex,
> -			      struct xgi_hw_device_info *HwDeviceExtension,
> -			      struct vb_device_info *pVBInfo)
> -{
> -	unsigned short temp, ah, al, temp2, i, DisplayUnit;
> -
> -	/* GetOffset */
> -	temp = XGI330_EModeIDTable[ModeIdIndex].Ext_ModeInfo;
> -	temp >>= 8;
> -	temp = XGI330_ScreenOffset[temp];
> -
> -	temp2 = XGI330_RefIndex[RefreshRateTableIndex].Ext_InfoFlag;
> -	temp2 &= InterlaceMode;
> -
> -	if (temp2)
> -		temp <<= 1;
> -
> -	temp2 = pVBInfo->ModeType - ModeEGA;
> -
> -	switch (temp2) {
> -	case 0:
> -		temp2 = 1;
> -		break;
> -	case 1:
> -		temp2 = 2;
> -		break;
> -	case 2:
> -		temp2 = 4;
> -		break;
> -	case 3:
> -		temp2 = 4;
> -		break;
> -	case 4:
> -		temp2 = 6;
> -		break;
> -	case 5:
> -		temp2 = 8;
> -		break;
> -	default:
> -		break;
> -	}
> -
> -	if ((ModeNo >= 0x26) && (ModeNo <= 0x28))
> -		temp = temp * temp2 + temp2 / 2;
> -	else
> -		temp *= temp2;
> -
> -	/* SetOffset */
> -	DisplayUnit = temp;
> -	temp2 = temp;
> -	temp >>= 8; /* ah */
> -	temp &= 0x0F;
> -	i = xgifb_reg_get(pVBInfo->P3c4, 0x0E);
> -	i &= 0xF0;
> -	i |= temp;
> -	xgifb_reg_set(pVBInfo->P3c4, 0x0E, i);
> -
> -	temp = (unsigned char)temp2;
> -	temp &= 0xFF; /* al */
> -	xgifb_reg_set(pVBInfo->P3d4, 0x13, temp);
> -
> -	/* SetDisplayUnit */
> -	temp2 = XGI330_RefIndex[RefreshRateTableIndex].Ext_InfoFlag;
> -	temp2 &= InterlaceMode;
> -	if (temp2)
> -		DisplayUnit >>= 1;
> -
> -	DisplayUnit <<= 5;
> -	ah = (DisplayUnit & 0xff00) >> 8;
> -	al = DisplayUnit & 0x00ff;
> -	if (al == 0)
> -		ah += 1;
> -	else
> -		ah += 2;
> -
> -	if (HwDeviceExtension->jChipType >= XG20)
> -		if ((ModeNo == 0x4A) | (ModeNo == 0x49))
> -			ah -= 1;
> -
> -	xgifb_reg_set(pVBInfo->P3c4, 0x10, ah);
> -}
> -
> -static unsigned short XGI_GetVCLK2Ptr(unsigned short ModeIdIndex,
> -				      unsigned short RefreshRateTableIndex,
> -				      struct vb_device_info *pVBInfo)
> -{
> -	unsigned short VCLKIndex, modeflag;
> -
> -	/* si+Ext_ResInfo */
> -	modeflag = XGI330_EModeIDTable[ModeIdIndex].Ext_ModeFlag;
> -
> -	if (pVBInfo->VBInfo & (SetCRT2ToLCD | XGI_SetCRT2ToLCDA)) { /* 301b */
> -		if (pVBInfo->LCDResInfo != Panel_1024x768)
> -			/* LCDXlat2VCLK */
> -			VCLKIndex = VCLK108_2_315 + 5;
> -		else
> -			VCLKIndex = VCLK65_315 + 2; /* LCDXlat1VCLK */
> -	} else if (pVBInfo->VBInfo & SetCRT2ToHiVision) {
> -		if (pVBInfo->SetFlag & RPLLDIV2XO)
> -			VCLKIndex = TVCLKBASE_315_25 + HiTVVCLKDIV2;
> -		else
> -			VCLKIndex = TVCLKBASE_315_25 + HiTVVCLK;
> -
> -		if (pVBInfo->SetFlag & TVSimuMode) {
> -			if (modeflag & Charx8Dot)
> -				VCLKIndex = TVCLKBASE_315_25 + HiTVSimuVCLK;
> -			else
> -				VCLKIndex = TVCLKBASE_315_25 + HiTVTextVCLK;
> -		}
> -
> -		/* 301lv */
> -		if (pVBInfo->VBType & VB_SIS301LV) {
> -			if (pVBInfo->SetFlag & RPLLDIV2XO)
> -				VCLKIndex = YPbPr525iVCLK_2;
> -			else
> -				VCLKIndex = YPbPr525iVCLK;
> -		}
> -	} else if (pVBInfo->VBInfo & SetCRT2ToTV) {
> -		if (pVBInfo->SetFlag & RPLLDIV2XO)
> -			VCLKIndex = TVCLKBASE_315_25 + TVVCLKDIV2;
> -		else
> -			VCLKIndex = TVCLKBASE_315_25 + TVVCLK;
> -	} else { /* for CRT2 */
> -		/* di+Ext_CRTVCLK */
> -		VCLKIndex = XGI330_RefIndex[RefreshRateTableIndex].Ext_CRTVCLK;
> -		VCLKIndex &= IndexMask;
> -	}
> -
> -	return VCLKIndex;
> -}
> -
> -static void XGI_SetCRT1VCLK(unsigned short ModeIdIndex,
> -			    struct xgi_hw_device_info *HwDeviceExtension,
> -			    unsigned short RefreshRateTableIndex,
> -			    struct vb_device_info *pVBInfo)
> -{
> -	unsigned char index, data;
> -	unsigned short vclkindex;
> -
> -	if ((pVBInfo->IF_DEF_LVDS == 0) &&
> -	    (pVBInfo->VBType & (VB_SIS301B | VB_SIS302B | VB_SIS301LV |
> -				VB_SIS302LV | VB_XGI301C)) &&
> -	    (pVBInfo->VBInfo & XGI_SetCRT2ToLCDA)) {
> -		vclkindex = XGI_GetVCLK2Ptr(ModeIdIndex, RefreshRateTableIndex,
> -					    pVBInfo);
> -		data = xgifb_reg_get(pVBInfo->P3c4, 0x31) & 0xCF;
> -		xgifb_reg_set(pVBInfo->P3c4, 0x31, data);
> -		data = XGI_VBVCLKData[vclkindex].Part4_A;
> -		xgifb_reg_set(pVBInfo->P3c4, 0x2B, data);
> -		data = XGI_VBVCLKData[vclkindex].Part4_B;
> -		xgifb_reg_set(pVBInfo->P3c4, 0x2C, data);
> -		xgifb_reg_set(pVBInfo->P3c4, 0x2D, 0x01);
> -	} else {
> -		index = XGI330_RefIndex[RefreshRateTableIndex].Ext_CRTVCLK;
> -		data = xgifb_reg_get(pVBInfo->P3c4, 0x31) & 0xCF;
> -		xgifb_reg_set(pVBInfo->P3c4, 0x31, data);
> -		xgifb_reg_set(pVBInfo->P3c4, 0x2B, XGI_VCLKData[index].SR2B);
> -		xgifb_reg_set(pVBInfo->P3c4, 0x2C, XGI_VCLKData[index].SR2C);
> -		xgifb_reg_set(pVBInfo->P3c4, 0x2D, 0x01);
> -	}
> -
> -	if (HwDeviceExtension->jChipType >= XG20) {
> -		if (XGI330_EModeIDTable[ModeIdIndex].Ext_ModeFlag &
> -		    HalfDCLK) {
> -			data = xgifb_reg_get(pVBInfo->P3c4, 0x2B);
> -			xgifb_reg_set(pVBInfo->P3c4, 0x2B, data);
> -			data = xgifb_reg_get(pVBInfo->P3c4, 0x2C);
> -			index = data;
> -			index &= 0xE0;
> -			data &= 0x1F;
> -			data <<= 1;
> -			data += 1;
> -			data |= index;
> -			xgifb_reg_set(pVBInfo->P3c4, 0x2C, data);
> -		}
> -	}
> -}
> -
> -static void XGI_SetXG21FPBits(struct vb_device_info *pVBInfo)
> -{
> -	unsigned char temp;
> -
> -	temp = xgifb_reg_get(pVBInfo->P3d4, 0x37); /* D[0] 1: 18bit */
> -	temp = (temp & 1) << 6;
> -	/* SR06[6] 18bit Dither */
> -	xgifb_reg_and_or(pVBInfo->P3c4, 0x06, ~0x40, temp);
> -	/* SR09[7] enable FP output, SR09[6] 1: sigle 18bits, 0: dual 12bits */
> -	xgifb_reg_and_or(pVBInfo->P3c4, 0x09, ~0xc0, temp | 0x80);
> -}
> -
> -static void XGI_SetCRT1FIFO(struct xgi_hw_device_info *HwDeviceExtension,
> -			    struct vb_device_info *pVBInfo)
> -{
> -	unsigned short data;
> -
> -	data = xgifb_reg_get(pVBInfo->P3c4, 0x3D);
> -	data &= 0xfe;
> -	xgifb_reg_set(pVBInfo->P3c4, 0x3D, data); /* disable auto-threshold */
> -
> -	xgifb_reg_set(pVBInfo->P3c4, 0x08, 0x34);
> -	data = xgifb_reg_get(pVBInfo->P3c4, 0x09);
> -	data &= 0xC0;
> -	xgifb_reg_set(pVBInfo->P3c4, 0x09, data | 0x30);
> -	data = xgifb_reg_get(pVBInfo->P3c4, 0x3D);
> -	data |= 0x01;
> -	xgifb_reg_set(pVBInfo->P3c4, 0x3D, data);
> -
> -	if (HwDeviceExtension->jChipType == XG21)
> -		XGI_SetXG21FPBits(pVBInfo); /* Fix SR9[7:6] can't read back */
> -}
> -
> -static void XGI_SetVCLKState(struct xgi_hw_device_info *HwDeviceExtension,
> -			     unsigned short RefreshRateTableIndex,
> -			     struct vb_device_info *pVBInfo)
> -{
> -	unsigned short data, data2 = 0;
> -	short VCLK;
> -
> -	unsigned char index;
> -
> -	index = XGI330_RefIndex[RefreshRateTableIndex].Ext_CRTVCLK;
> -	index &= IndexMask;
> -	VCLK = XGI_VCLKData[index].CLOCK;
> -
> -	data = xgifb_reg_get(pVBInfo->P3c4, 0x32);
> -	data &= 0xf3;
> -	if (VCLK >= 200)
> -		data |= 0x0c; /* VCLK > 200 */
> -
> -	if (HwDeviceExtension->jChipType >= XG20)
> -		data &= ~0x04; /* 2 pixel mode */
> -
> -	xgifb_reg_set(pVBInfo->P3c4, 0x32, data);
> -
> -	if (HwDeviceExtension->jChipType < XG20) {
> -		data = xgifb_reg_get(pVBInfo->P3c4, 0x1F);
> -		data &= 0xE7;
> -		if (VCLK < 200)
> -			data |= 0x10;
> -		xgifb_reg_set(pVBInfo->P3c4, 0x1F, data);
> -	}
> -
> -	data2 = 0x00;
> -
> -	xgifb_reg_and_or(pVBInfo->P3c4, 0x07, 0xFC, data2);
> -	if (HwDeviceExtension->jChipType >= XG27)
> -		xgifb_reg_and_or(pVBInfo->P3c4, 0x40, 0xFC, data2 & 0x03);
> -}
> -
> -static void XGI_SetCRT1ModeRegs(struct xgi_hw_device_info *HwDeviceExtension,
> -				unsigned short ModeIdIndex,
> -				unsigned short RefreshRateTableIndex,
> -				struct vb_device_info *pVBInfo)
> -{
> -	unsigned short data, data2, data3, infoflag = 0, modeflag, resindex,
> -			xres;
> -
> -	modeflag = XGI330_EModeIDTable[ModeIdIndex].Ext_ModeFlag;
> -	infoflag = XGI330_RefIndex[RefreshRateTableIndex].Ext_InfoFlag;
> -
> -	if (xgifb_reg_get(pVBInfo->P3d4, 0x31) & 0x01)
> -		xgifb_reg_and_or(pVBInfo->P3c4, 0x1F, 0x3F, 0x00);
> -
> -	data = infoflag;
> -	data2 = 0;
> -	data2 |= 0x02;
> -	data3 = pVBInfo->ModeType - ModeVGA;
> -	data3 <<= 2;
> -	data2 |= data3;
> -	data &= InterlaceMode;
> -
> -	if (data)
> -		data2 |= 0x20;
> -
> -	xgifb_reg_and_or(pVBInfo->P3c4, 0x06, ~0x3F, data2);
> -	resindex = XGI330_EModeIDTable[ModeIdIndex].Ext_RESINFO;
> -	xres = XGI330_ModeResInfo[resindex].HTotal; /* xres->ax */
> -
> -	data = 0x0000;
> -	if (infoflag & InterlaceMode) {
> -		if (xres == 1024)
> -			data = 0x0035;
> -		else if (xres == 1280)
> -			data = 0x0048;
> -	}
> -
> -	xgifb_reg_and_or(pVBInfo->P3d4, 0x19, 0xFF, data);
> -	xgifb_reg_and_or(pVBInfo->P3d4, 0x19, 0xFC, 0);
> -
> -	if (modeflag & HalfDCLK)
> -		xgifb_reg_and_or(pVBInfo->P3c4, 0x01, 0xF7, 0x08);
> -
> -	data2 = 0;
> -
> -	if (modeflag & LineCompareOff)
> -		data2 |= 0x08;
> -
> -	xgifb_reg_and_or(pVBInfo->P3c4, 0x0F, ~0x48, data2);
> -	data = 0x60;
> -	data = data ^ 0x60;
> -	data = data ^ 0xA0;
> -	xgifb_reg_and_or(pVBInfo->P3c4, 0x21, 0x1F, data);
> -
> -	XGI_SetVCLKState(HwDeviceExtension, RefreshRateTableIndex, pVBInfo);
> -
> -	data = xgifb_reg_get(pVBInfo->P3d4, 0x31);
> -
> -	if (HwDeviceExtension->jChipType == XG27) {
> -		if (data & 0x40)
> -			data = 0x2c;
> -		else
> -			data = 0x6c;
> -		xgifb_reg_set(pVBInfo->P3d4, 0x52, data);
> -		xgifb_reg_or(pVBInfo->P3d4, 0x51, 0x10);
> -	} else if (HwDeviceExtension->jChipType >= XG20) {
> -		if (data & 0x40)
> -			data = 0x33;
> -		else
> -			data = 0x73;
> -		xgifb_reg_set(pVBInfo->P3d4, 0x52, data);
> -		xgifb_reg_set(pVBInfo->P3d4, 0x51, 0x02);
> -	} else {
> -		if (data & 0x40)
> -			data = 0x2c;
> -		else
> -			data = 0x6c;
> -		xgifb_reg_set(pVBInfo->P3d4, 0x52, data);
> -	}
> -}
> -
> -static void XGI_WriteDAC(unsigned short dl,
> -			 unsigned short ah,
> -			 unsigned short al,
> -			 unsigned short dh,
> -			 struct vb_device_info *pVBInfo)
> -{
> -	unsigned short bh, bl;
> -
> -	bh = ah;
> -	bl = al;
> -
> -	if (dl != 0) {
> -		swap(bh, dh);
> -		if (dl == 1)
> -			swap(bl, dh);
> -		else
> -			swap(bl, bh);
> -	}
> -	outb((unsigned short)dh, pVBInfo->P3c9);
> -	outb((unsigned short)bh, pVBInfo->P3c9);
> -	outb((unsigned short)bl, pVBInfo->P3c9);
> -}
> -
> -static void XGI_LoadDAC(struct vb_device_info *pVBInfo)
> -{
> -	unsigned short data, data2, i, k, m, n, o, si, di, bx, dl, al, ah, dh;
> -	const unsigned short *table = XGINew_VGA_DAC;
> -
> -	outb(0xFF, pVBInfo->P3c6);
> -	outb(0x00, pVBInfo->P3c8);
> -
> -	for (i = 0; i < 16; i++) {
> -		data = table[i];
> -
> -		for (k = 0; k < 3; k++) {
> -			data2 = 0;
> -
> -			if (data & 0x01)
> -				data2 = 0x2A;
> -
> -			if (data & 0x02)
> -				data2 += 0x15;
> -
> -			outb(data2, pVBInfo->P3c9);
> -			data >>= 2;
> -		}
> -	}
> -
> -	for (i = 16; i < 32; i++) {
> -		data = table[i];
> -
> -		for (k = 0; k < 3; k++)
> -			outb(data, pVBInfo->P3c9);
> -	}
> -
> -	si = 32;
> -
> -	for (m = 0; m < 9; m++) {
> -		di = si;
> -		bx = si + 0x04;
> -		dl = 0;
> -
> -		for (n = 0; n < 3; n++) {
> -			for (o = 0; o < 5; o++) {
> -				dh = table[si];
> -				ah = table[di];
> -				al = table[bx];
> -				si++;
> -				XGI_WriteDAC(dl, ah, al, dh, pVBInfo);
> -			}
> -
> -			si -= 2;
> -
> -			for (o = 0; o < 3; o++) {
> -				dh = table[bx];
> -				ah = table[di];
> -				al = table[si];
> -				si--;
> -				XGI_WriteDAC(dl, ah, al, dh, pVBInfo);
> -			}
> -
> -			dl++;
> -		}
> -
> -		si += 5;
> -	}
> -}
> -
> -static void XGI_GetLVDSResInfo(unsigned short ModeIdIndex,
> -			       struct vb_device_info *pVBInfo)
> -{
> -	unsigned short resindex, xres, yres, modeflag;
> -
> -	/* si+Ext_ResInfo */
> -	modeflag = XGI330_EModeIDTable[ModeIdIndex].Ext_RESINFO;
> -
> -	/* si+Ext_ResInfo */
> -	resindex = XGI330_EModeIDTable[ModeIdIndex].Ext_RESINFO;
> -
> -	xres = XGI330_ModeResInfo[resindex].HTotal;
> -	yres = XGI330_ModeResInfo[resindex].VTotal;
> -
> -	if (modeflag & HalfDCLK)
> -		xres <<= 1;
> -
> -	if (modeflag & DoubleScanMode)
> -		yres <<= 1;
> -
> -	if (xres == 720)
> -		xres = 640;
> -
> -	pVBInfo->VGAHDE = xres;
> -	pVBInfo->HDE = xres;
> -	pVBInfo->VGAVDE = yres;
> -	pVBInfo->VDE = yres;
> -}
> -
> -static void const *XGI_GetLcdPtr(struct XGI330_LCDDataTablStruct const *table,
> -				 unsigned short ModeIdIndex,
> -				 struct vb_device_info *pVBInfo)
> -{
> -	unsigned short i, tempdx, tempbx, modeflag;
> -
> -	tempbx = 0;
> -
> -	modeflag = XGI330_EModeIDTable[ModeIdIndex].Ext_ModeFlag;
> -
> -	i = 0;
> -
> -	while (table[i].PANELID != 0xff) {
> -		tempdx = pVBInfo->LCDResInfo;
> -		if (tempbx & 0x0080) { /* OEMUtil */
> -			tempbx &= ~0x0080;
> -			tempdx = pVBInfo->LCDTypeInfo;
> -		}
> -
> -		if (pVBInfo->LCDInfo & EnableScalingLCD)
> -			tempdx &= ~PanelResInfo;
> -
> -		if (table[i].PANELID == tempdx) {
> -			tempbx = table[i].MASK;
> -			tempdx = pVBInfo->LCDInfo;
> -
> -			if (modeflag & HalfDCLK)
> -				tempdx |= SetLCDLowResolution;
> -
> -			tempbx &= tempdx;
> -			if (tempbx == table[i].CAP)
> -				break;
> -		}
> -		i++;
> -	}
> -
> -	return table[i].DATAPTR;
> -}
> -
> -static struct SiS_TVData const *XGI_GetTVPtr(
> -	unsigned short ModeIdIndex,
> -	unsigned short RefreshRateTableIndex,
> -	struct vb_device_info *pVBInfo)
> -{
> -	unsigned short i, tempdx, tempal, modeflag;
> -
> -	modeflag = XGI330_EModeIDTable[ModeIdIndex].Ext_ModeFlag;
> -	tempal = XGI330_RefIndex[RefreshRateTableIndex].Ext_CRT2CRTC;
> -	tempal = tempal & 0x3f;
> -	tempdx = pVBInfo->TVInfo;
> -
> -	if (pVBInfo->VBInfo & SetInSlaveMode)
> -		tempdx = tempdx | SetTVLockMode;
> -
> -	if (modeflag & HalfDCLK)
> -		tempdx = tempdx | SetTVLowResolution;
> -
> -	i = 0;
> -
> -	while (XGI_TVDataTable[i].MASK != 0xffff) {
> -		if ((tempdx & XGI_TVDataTable[i].MASK) ==
> -			XGI_TVDataTable[i].CAP)
> -			break;
> -		i++;
> -	}
> -
> -	return &XGI_TVDataTable[i].DATAPTR[tempal];
> -}
> -
> -static void XGI_GetLVDSData(unsigned short ModeIdIndex,
> -			    struct vb_device_info *pVBInfo)
> -{
> -	struct SiS_LVDSData const *LCDPtr;
> -
> -	if (!(pVBInfo->VBInfo & (SetCRT2ToLCD | XGI_SetCRT2ToLCDA)))
> -		return;
> -
> -	LCDPtr = XGI_GetLcdPtr(XGI_EPLLCDDataPtr, ModeIdIndex, pVBInfo);
> -	pVBInfo->VGAHT	= LCDPtr->VGAHT;
> -	pVBInfo->VGAVT	= LCDPtr->VGAVT;
> -	pVBInfo->HT	= LCDPtr->LCDHT;
> -	pVBInfo->VT	= LCDPtr->LCDVT;
> -
> -	if (pVBInfo->LCDInfo & (SetLCDtoNonExpanding | EnableScalingLCD))
> -		return;
> -
> -	if ((pVBInfo->LCDResInfo == Panel_1024x768) ||
> -	    (pVBInfo->LCDResInfo == Panel_1024x768x75)) {
> -		pVBInfo->HDE = 1024;
> -		pVBInfo->VDE = 768;
> -	} else if ((pVBInfo->LCDResInfo == Panel_1280x1024) ||
> -		   (pVBInfo->LCDResInfo == Panel_1280x1024x75)) {
> -		pVBInfo->HDE = 1280;
> -		pVBInfo->VDE = 1024;
> -	} else if (pVBInfo->LCDResInfo == Panel_1400x1050) {
> -		pVBInfo->HDE = 1400;
> -		pVBInfo->VDE = 1050;
> -	} else {
> -		pVBInfo->HDE = 1600;
> -		pVBInfo->VDE = 1200;
> -	}
> -}
> -
> -static void XGI_ModCRT1Regs(unsigned short ModeIdIndex,
> -			    struct xgi_hw_device_info *HwDeviceExtension,
> -			    struct vb_device_info *pVBInfo)
> -{
> -	unsigned short i;
> -	struct XGI_LVDSCRT1HDataStruct const *LCDPtr = NULL;
> -	struct XGI_LVDSCRT1VDataStruct const *LCDPtr1 = NULL;
> -
> -	if (pVBInfo->VBInfo & (SetCRT2ToLCD | XGI_SetCRT2ToLCDA)) {
> -		LCDPtr = XGI_GetLcdPtr(xgifb_epllcd_crt1_h, ModeIdIndex,
> -				       pVBInfo);
> -
> -		for (i = 0; i < 8; i++)
> -			pVBInfo->TimingH.data[i] = LCDPtr[0].Reg[i];
> -	}
> -
> -	XGI_SetCRT1Timing_H(pVBInfo, HwDeviceExtension);
> -
> -	if (pVBInfo->VBInfo & (SetCRT2ToLCD | XGI_SetCRT2ToLCDA)) {
> -		LCDPtr1 = XGI_GetLcdPtr(xgifb_epllcd_crt1_v, ModeIdIndex,
> -					pVBInfo);
> -		for (i = 0; i < 7; i++)
> -			pVBInfo->TimingV.data[i] = LCDPtr1[0].Reg[i];
> -	}
> -
> -	XGI_SetCRT1Timing_V(ModeIdIndex, pVBInfo);
> -}
> -
> -static unsigned short XGI_GetLCDCapPtr(struct vb_device_info *pVBInfo)
> -{
> -	unsigned char tempal, tempah, tempbl, i;
> -
> -	tempah = xgifb_reg_get(pVBInfo->P3d4, 0x36);
> -	tempal = tempah & 0x0F;
> -	tempah = tempah & 0xF0;
> -	i = 0;
> -	tempbl = pVBInfo->LCDCapList[i].LCD_ID;
> -
> -	while (tempbl != 0xFF) {
> -		if (tempbl & 0x80) { /* OEMUtil */
> -			tempal = tempah;
> -			tempbl = tempbl & ~(0x80);
> -		}
> -
> -		if (tempal == tempbl)
> -			break;
> -
> -		i++;
> -
> -		tempbl = pVBInfo->LCDCapList[i].LCD_ID;
> -	}
> -
> -	return i;
> -}
> -
> -static unsigned short XGI_GetLCDCapPtr1(struct vb_device_info *pVBInfo)
> -{
> -	unsigned short tempah, tempal, tempbl, i;
> -
> -	tempal = pVBInfo->LCDResInfo;
> -	tempah = pVBInfo->LCDTypeInfo;
> -
> -	i = 0;
> -	tempbl = pVBInfo->LCDCapList[i].LCD_ID;
> -
> -	while (tempbl != 0xFF) {
> -		if ((tempbl & 0x80) && (tempbl != 0x80)) {
> -			tempal = tempah;
> -			tempbl &= ~0x80;
> -		}
> -
> -		if (tempal == tempbl)
> -			break;
> -
> -		i++;
> -		tempbl = pVBInfo->LCDCapList[i].LCD_ID;
> -	}
> -
> -	if (tempbl == 0xFF) {
> -		pVBInfo->LCDResInfo = Panel_1024x768;
> -		pVBInfo->LCDTypeInfo = 0;
> -		i = 0;
> -	}
> -
> -	return i;
> -}
> -
> -static void XGI_GetLCDSync(unsigned short *HSyncWidth,
> -			   unsigned short *VSyncWidth,
> -			   struct vb_device_info *pVBInfo)
> -{
> -	unsigned short Index;
> -
> -	Index = XGI_GetLCDCapPtr(pVBInfo);
> -	*HSyncWidth = pVBInfo->LCDCapList[Index].LCD_HSyncWidth;
> -	*VSyncWidth = pVBInfo->LCDCapList[Index].LCD_VSyncWidth;
> -}
> -
> -static void XGI_SetLVDSRegs(unsigned short ModeIdIndex,
> -			    struct vb_device_info *pVBInfo)
> -{
> -	unsigned short tempbx, tempax, tempcx, tempdx, push1, push2, modeflag;
> -	unsigned long temp, temp1, temp2, temp3, push3;
> -	struct XGI330_LCDDataDesStruct2 const *LCDPtr1 = NULL;
> -
> -	modeflag = XGI330_EModeIDTable[ModeIdIndex].Ext_ModeFlag;
> -	LCDPtr1 = XGI_GetLcdPtr(XGI_EPLLCDDesDataPtr, ModeIdIndex, pVBInfo);
> -
> -	XGI_GetLCDSync(&tempax, &tempbx, pVBInfo);
> -	push1 = tempbx;
> -	push2 = tempax;
> -
> -	/* GetLCDResInfo */
> -	if ((pVBInfo->LCDResInfo == Panel_1024x768) ||
> -	    (pVBInfo->LCDResInfo == Panel_1024x768x75)) {
> -		tempax = 1024;
> -		tempbx = 768;
> -	} else if ((pVBInfo->LCDResInfo == Panel_1280x1024) ||
> -		   (pVBInfo->LCDResInfo == Panel_1280x1024x75)) {
> -		tempax = 1280;
> -		tempbx = 1024;
> -	} else if (pVBInfo->LCDResInfo == Panel_1400x1050) {
> -		tempax = 1400;
> -		tempbx = 1050;
> -	} else {
> -		tempax = 1600;
> -		tempbx = 1200;
> -	}
> -
> -	if (pVBInfo->LCDInfo & SetLCDtoNonExpanding) {
> -		pVBInfo->HDE = tempax;
> -		pVBInfo->VDE = tempbx;
> -		pVBInfo->VGAHDE = tempax;
> -		pVBInfo->VGAVDE = tempbx;
> -	}
> -
> -	tempax = pVBInfo->HT;
> -
> -	tempbx = LCDPtr1->LCDHDES;
> -
> -	tempcx = pVBInfo->HDE;
> -	tempbx = tempbx & 0x0fff;
> -	tempcx += tempbx;
> -
> -	if (tempcx >= tempax)
> -		tempcx -= tempax;
> -
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x1A, tempbx & 0x07);
> -
> -	tempcx >>= 3;
> -	tempbx >>= 3;
> -
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x16,
> -		      (unsigned short)(tempbx & 0xff));
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x17,
> -		      (unsigned short)(tempcx & 0xff));
> -
> -	tempax = pVBInfo->HT;
> -
> -	tempbx = LCDPtr1->LCDHRS;
> -
> -	tempcx = push2;
> -
> -	if (pVBInfo->LCDInfo & EnableScalingLCD)
> -		tempcx = LCDPtr1->LCDHSync;
> -
> -	tempcx += tempbx;
> -
> -	if (tempcx >= tempax)
> -		tempcx -= tempax;
> -
> -	tempax = tempbx & 0x07;
> -	tempax >>= 5;
> -	tempcx >>= 3;
> -	tempbx >>= 3;
> -
> -	tempcx &= 0x1f;
> -	tempax |= tempcx;
> -
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x15, tempax);
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x14,
> -		      (unsigned short)(tempbx & 0xff));
> -
> -	tempax = pVBInfo->VT;
> -	tempbx = LCDPtr1->LCDVDES;
> -	tempcx = pVBInfo->VDE;
> -
> -	tempbx = tempbx & 0x0fff;
> -	tempcx += tempbx;
> -	if (tempcx >= tempax)
> -		tempcx -= tempax;
> -
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x1b,
> -		      (unsigned short)(tempbx & 0xff));
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x1c,
> -		      (unsigned short)(tempcx & 0xff));
> -
> -	tempbx = (tempbx >> 8) & 0x07;
> -	tempcx = (tempcx >> 8) & 0x07;
> -
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x1d,
> -		      (unsigned short)((tempcx << 3) | tempbx));
> -
> -	tempax = pVBInfo->VT;
> -	tempbx = LCDPtr1->LCDVRS;
> -
> -	tempcx = push1;
> -
> -	if (pVBInfo->LCDInfo & EnableScalingLCD)
> -		tempcx = LCDPtr1->LCDVSync;
> -
> -	tempcx += tempbx;
> -	if (tempcx >= tempax)
> -		tempcx -= tempax;
> -
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x18,
> -		      (unsigned short)(tempbx & 0xff));
> -	xgifb_reg_and_or(pVBInfo->Part1Port, 0x19, ~0x0f,
> -			 (unsigned short)(tempcx & 0x0f));
> -
> -	tempax = ((tempbx >> 8) & 0x07) << 3;
> -
> -	tempbx = pVBInfo->VGAVDE;
> -	if (tempbx != pVBInfo->VDE)
> -		tempax |= 0x40;
> -
> -	if (pVBInfo->LCDInfo & XGI_EnableLVDSDDA)
> -		tempax |= 0x40;
> -
> -	xgifb_reg_and_or(pVBInfo->Part1Port, 0x1a, 0x07, tempax);
> -
> -	tempbx = pVBInfo->VDE;
> -	tempax = pVBInfo->VGAVDE;
> -
> -	temp = tempax; /* 0430 ylshieh */
> -	temp1 = (temp << 18) / tempbx;
> -
> -	tempdx = (unsigned short)((temp << 18) % tempbx);
> -
> -	if (tempdx != 0)
> -		temp1 += 1;
> -
> -	temp2 = temp1;
> -	push3 = temp2;
> -
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x37,	(unsigned short)(temp2 & 0xff));
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x36,	(unsigned short)((temp2 >> 8) & 0xff));
> -
> -	tempbx = (unsigned short)(temp2 >> 16);
> -	tempax = tempbx & 0x03;
> -
> -	tempbx = pVBInfo->VGAVDE;
> -	if (tempbx == pVBInfo->VDE)
> -		tempax |= 0x04;
> -
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x35, tempax);
> -
> -	if (pVBInfo->VBType & VB_XGI301C) {
> -		temp2 = push3;
> -		xgifb_reg_set(pVBInfo->Part4Port,
> -			      0x3c,
> -			      (unsigned short)(temp2 & 0xff));
> -		xgifb_reg_set(pVBInfo->Part4Port,
> -			      0x3b,
> -			      (unsigned short)((temp2 >> 8) &
> -			      0xff));
> -		tempbx = (unsigned short)(temp2 >> 16);
> -		xgifb_reg_and_or(pVBInfo->Part4Port, 0x3a, ~0xc0,
> -				 (unsigned short)((tempbx & 0xff) << 6));
> -
> -		tempcx = pVBInfo->VGAVDE;
> -		if (tempcx == pVBInfo->VDE)
> -			xgifb_reg_and_or(pVBInfo->Part4Port, 0x30, ~0x0c, 0x00);
> -		else
> -			xgifb_reg_and_or(pVBInfo->Part4Port, 0x30, ~0x0c, 0x08);
> -	}
> -
> -	tempcx = pVBInfo->VGAHDE;
> -	tempbx = pVBInfo->HDE;
> -
> -	temp1 = tempcx << 16;
> -
> -	tempax = (unsigned short)(temp1 / tempbx);
> -
> -	if ((tempbx & 0xffff) == (tempcx & 0xffff))
> -		tempax = 65535;
> -
> -	temp3 = tempax;
> -	temp1 = pVBInfo->VGAHDE << 16;
> -
> -	temp1 /= temp3;
> -	temp3 <<= 16;
> -	temp1 -= 1;
> -
> -	temp3 = (temp3 & 0xffff0000) + (temp1 & 0xffff);
> -
> -	tempax = (unsigned short)(temp3 & 0xff);
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x1f, tempax);
> -
> -	temp1 = pVBInfo->VGAVDE << 18;
> -	temp1 = temp1 / push3;
> -	tempbx = (unsigned short)(temp1 & 0xffff);
> -
> -	if (pVBInfo->LCDResInfo == Panel_1024x768)
> -		tempbx -= 1;
> -
> -	tempax = ((tempbx >> 8) & 0xff) << 3;
> -	tempax |= (unsigned short)((temp3 >> 8) & 0x07);
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x20,
> -		      (unsigned short)(tempax & 0xff));
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x21,
> -		      (unsigned short)(tempbx & 0xff));
> -
> -	temp3 >>= 16;
> -
> -	if (modeflag & HalfDCLK)
> -		temp3 >>= 1;
> -
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x22,
> -		      (unsigned short)((temp3 >> 8) & 0xff));
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x23,
> -		      (unsigned short)(temp3 & 0xff));
> -}
> -
> -/*
> - * Function : XGI_GETLCDVCLKPtr
> - * Input :
> - * Output : al -> VCLK Index
> - * Description :
> - */
> -static void XGI_GetLCDVCLKPtr(unsigned char *di_0, unsigned char *di_1,
> -			      struct vb_device_info *pVBInfo)
> -{
> -	unsigned short index;
> -
> -	if (pVBInfo->VBInfo & (SetCRT2ToLCD | XGI_SetCRT2ToLCDA)) {
> -		index = XGI_GetLCDCapPtr1(pVBInfo);
> -
> -		if (pVBInfo->VBInfo & SetCRT2ToLCD) { /* LCDB */
> -			*di_0 = pVBInfo->LCDCapList[index].LCUCHAR_VCLKData1;
> -			*di_1 = pVBInfo->LCDCapList[index].LCUCHAR_VCLKData2;
> -		} else { /* LCDA */
> -			*di_0 = pVBInfo->LCDCapList[index].LCDA_VCLKData1;
> -			*di_1 = pVBInfo->LCDCapList[index].LCDA_VCLKData2;
> -		}
> -	}
> -}
> -
> -static unsigned char XGI_GetVCLKPtr(unsigned short RefreshRateTableIndex,
> -				    unsigned short ModeIdIndex,
> -				    struct vb_device_info *pVBInfo)
> -{
> -	unsigned short index, modeflag;
> -	unsigned char tempal;
> -
> -	/* si+Ext_ResInfo */
> -	modeflag = XGI330_EModeIDTable[ModeIdIndex].Ext_ModeFlag;
> -
> -	if ((pVBInfo->SetFlag & ProgrammingCRT2) &&
> -	    !(pVBInfo->LCDInfo & EnableScalingLCD)) { /* {LCDA/LCDB} */
> -		index = XGI_GetLCDCapPtr(pVBInfo);
> -		tempal = pVBInfo->LCDCapList[index].LCD_VCLK;
> -
> -		if (pVBInfo->VBInfo & (SetCRT2ToLCD | XGI_SetCRT2ToLCDA))
> -			return tempal;
> -
> -		/* {TV} */
> -		if (pVBInfo->VBType &
> -		    (VB_SIS301B |
> -		     VB_SIS302B |
> -		     VB_SIS301LV |
> -		     VB_SIS302LV |
> -		     VB_XGI301C)) {
> -			if (pVBInfo->VBInfo & SetCRT2ToHiVision) {
> -				tempal = TVCLKBASE_315 + HiTVVCLKDIV2;
> -				if (!(pVBInfo->TVInfo & RPLLDIV2XO))
> -					tempal = TVCLKBASE_315 + HiTVVCLK;
> -				if (pVBInfo->TVInfo & TVSimuMode) {
> -					tempal = TVCLKBASE_315 + HiTVSimuVCLK;
> -					if (!(modeflag & Charx8Dot))
> -						tempal = TVCLKBASE_315 +
> -								HiTVTextVCLK;
> -				}
> -				return tempal;
> -			}
> -
> -			if (pVBInfo->TVInfo & TVSetYPbPr750p)
> -				return XGI_YPbPr750pVCLK;
> -
> -			if (pVBInfo->TVInfo & TVSetYPbPr525p)
> -				return YPbPr525pVCLK;
> -
> -			tempal = NTSC1024VCLK;
> -
> -			if (!(pVBInfo->TVInfo & NTSC1024x768)) {
> -				tempal = TVCLKBASE_315 + TVVCLKDIV2;
> -				if (!(pVBInfo->TVInfo & RPLLDIV2XO))
> -					tempal = TVCLKBASE_315 + TVVCLK;
> -			}
> -
> -			if (pVBInfo->VBInfo & SetCRT2ToTV)
> -				return tempal;
> -		}
> -	} /* {End of VB} */
> -
> -	inb((pVBInfo->P3ca + 0x02));
> -	return XGI330_RefIndex[RefreshRateTableIndex].Ext_CRTVCLK;
> -}
> -
> -static void XGI_GetVCLKLen(unsigned char tempal, unsigned char *di_0,
> -			   unsigned char *di_1, struct vb_device_info *pVBInfo)
> -{
> -	if (pVBInfo->VBType & (VB_SIS301 | VB_SIS301B | VB_SIS302B
> -			| VB_SIS301LV | VB_SIS302LV | VB_XGI301C)) {
> -		if (!(pVBInfo->VBInfo & XGI_SetCRT2ToLCDA) &&
> -		    (pVBInfo->SetFlag & ProgrammingCRT2)) {
> -			*di_0 = XGI_VBVCLKData[tempal].Part4_A;
> -			*di_1 = XGI_VBVCLKData[tempal].Part4_B;
> -		}
> -	} else {
> -		*di_0 = XGI_VCLKData[tempal].SR2B;
> -		*di_1 = XGI_VCLKData[tempal].SR2C;
> -	}
> -}
> -
> -static void XGI_SetCRT2ECLK(unsigned short ModeIdIndex,
> -			    unsigned short RefreshRateTableIndex,
> -			    struct vb_device_info *pVBInfo)
> -{
> -	unsigned char di_0, di_1, tempal;
> -	int i;
> -
> -	tempal = XGI_GetVCLKPtr(RefreshRateTableIndex, ModeIdIndex, pVBInfo);
> -	XGI_GetVCLKLen(tempal, &di_0, &di_1, pVBInfo);
> -	XGI_GetLCDVCLKPtr(&di_0, &di_1, pVBInfo);
> -
> -	for (i = 0; i < 4; i++) {
> -		xgifb_reg_and_or(pVBInfo->P3d4, 0x31, ~0x30,
> -				 (unsigned short)(0x10 * i));
> -		if (!(pVBInfo->VBInfo & XGI_SetCRT2ToLCDA) &&
> -		    !(pVBInfo->VBInfo & SetInSlaveMode)) {
> -			xgifb_reg_set(pVBInfo->P3c4, 0x2e, di_0);
> -			xgifb_reg_set(pVBInfo->P3c4, 0x2f, di_1);
> -		} else {
> -			xgifb_reg_set(pVBInfo->P3c4, 0x2b, di_0);
> -			xgifb_reg_set(pVBInfo->P3c4, 0x2c, di_1);
> -		}
> -	}
> -}
> -
> -static void XGI_UpdateModeInfo(struct vb_device_info *pVBInfo)
> -{
> -	unsigned short tempcl, tempch, temp, tempbl, tempax;
> -
> -	if (pVBInfo->VBType & (VB_SIS301B | VB_SIS302B | VB_SIS301LV
> -			| VB_SIS302LV | VB_XGI301C)) {
> -		tempcl = 0;
> -		tempch = 0;
> -		temp = xgifb_reg_get(pVBInfo->P3c4, 0x01);
> -
> -		if (!(temp & 0x20)) {
> -			temp = xgifb_reg_get(pVBInfo->P3d4, 0x17);
> -			if (temp & 0x80) {
> -				temp = xgifb_reg_get(pVBInfo->P3d4, 0x53);
> -				if (!(temp & 0x40))
> -					tempcl |= ActiveCRT1;
> -			}
> -		}
> -
> -		temp = xgifb_reg_get(pVBInfo->Part1Port, 0x2e);
> -		temp &= 0x0f;
> -
> -		if (!(temp == 0x08)) {
> -			/* Check ChannelA */
> -			tempax = xgifb_reg_get(pVBInfo->Part1Port, 0x13);
> -			if (tempax & 0x04)
> -				tempcl = tempcl | ActiveLCD;
> -
> -			temp &= 0x05;
> -
> -			if (!(tempcl & ActiveLCD)) {
> -				if (temp == 0x01)
> -					tempcl |= ActiveCRT2;
> -			}
> -
> -			if (temp == 0x04)
> -				tempcl |= ActiveLCD;
> -
> -			if (temp == 0x05) {
> -				temp = xgifb_reg_get(pVBInfo->Part2Port, 0x00);
> -
> -				if (!(temp & 0x08))
> -					tempch |= ActiveAVideo;
> -
> -				if (!(temp & 0x04))
> -					tempch |= ActiveSVideo;
> -
> -				if (temp & 0x02)
> -					tempch |= ActiveSCART;
> -
> -				if (pVBInfo->VBInfo & SetCRT2ToHiVision) {
> -					if (temp & 0x01)
> -						tempch |= ActiveHiTV;
> -				}
> -
> -				if (pVBInfo->VBInfo & SetCRT2ToYPbPr525750) {
> -					temp = xgifb_reg_get(
> -							pVBInfo->Part2Port,
> -							0x4d);
> -
> -					if (temp & 0x10)
> -						tempch |= ActiveYPbPr;
> -				}
> -
> -				if (tempch != 0)
> -					tempcl |= ActiveTV;
> -			}
> -		}
> -
> -		temp = xgifb_reg_get(pVBInfo->P3d4, 0x3d);
> -		if (tempcl & ActiveLCD) {
> -			if ((pVBInfo->SetFlag & ReserveTVOption)) {
> -				if (temp & ActiveTV)
> -					tempcl |= ActiveTV;
> -			}
> -		}
> -		temp = tempcl;
> -		tempbl = ~XGI_ModeSwitchStatus;
> -		xgifb_reg_and_or(pVBInfo->P3d4, 0x3d, tempbl, temp);
> -
> -		if (!(pVBInfo->SetFlag & ReserveTVOption))
> -			xgifb_reg_set(pVBInfo->P3d4, 0x3e, tempch);
> -	}
> -}
> -
> -void XGI_GetVBType(struct vb_device_info *pVBInfo)
> -{
> -	unsigned short flag, tempbx, tempah;
> -
> -	tempbx = VB_SIS302B;
> -	flag = xgifb_reg_get(pVBInfo->Part4Port, 0x00);
> -	if (flag == 0x02)
> -		goto finish;
> -
> -	tempbx = VB_SIS301;
> -	flag = xgifb_reg_get(pVBInfo->Part4Port, 0x01);
> -	if (flag < 0xB0)
> -		goto finish;
> -
> -	tempbx = VB_SIS301B;
> -	if (flag < 0xC0)
> -		goto bigger_than_0xB0;
> -
> -	tempbx = VB_XGI301C;
> -	if (flag < 0xD0)
> -		goto bigger_than_0xB0;
> -
> -	tempbx = VB_SIS301LV;
> -	if (flag < 0xE0)
> -		goto bigger_than_0xB0;
> -
> -	tempbx = VB_SIS302LV;
> -	tempah = xgifb_reg_get(pVBInfo->Part4Port, 0x39);
> -	if (tempah != 0xFF)
> -		tempbx = VB_XGI301C;
> -
> -bigger_than_0xB0:
> -	if (tempbx & (VB_SIS301B | VB_SIS302B)) {
> -		flag = xgifb_reg_get(pVBInfo->Part4Port, 0x23);
> -		if (!(flag & 0x02))
> -			tempbx = tempbx | VB_NoLCD;
> -	}
> -
> -finish:
> -	pVBInfo->VBType = tempbx;
> -}
> -
> -static void XGI_GetVBInfo(unsigned short ModeIdIndex,
> -			  struct vb_device_info *pVBInfo)
> -{
> -	unsigned short tempax, push, tempbx, temp, modeflag;
> -
> -	modeflag = XGI330_EModeIDTable[ModeIdIndex].Ext_ModeFlag;
> -	pVBInfo->SetFlag = 0;
> -	pVBInfo->ModeType = modeflag & ModeTypeMask;
> -	tempbx = 0;
> -
> -	if (!(pVBInfo->VBType & 0xFFFF))
> -		return;
> -
> -	/* Check Display Device */
> -	temp = xgifb_reg_get(pVBInfo->P3d4, 0x30);
> -	tempbx = tempbx | temp;
> -	temp = xgifb_reg_get(pVBInfo->P3d4, 0x31);
> -	push = temp;
> -	push <<= 8;
> -	tempax = temp << 8;
> -	tempbx = tempbx | tempax;
> -	temp = SetCRT2ToDualEdge | SetCRT2ToYPbPr525750 | XGI_SetCRT2ToLCDA
> -		| SetInSlaveMode | DisableCRT2Display;
> -	temp = 0xFFFF ^ temp;
> -	tempbx &= temp;
> -
> -	temp = xgifb_reg_get(pVBInfo->P3d4, 0x38);
> -
> -	if (pVBInfo->VBType & (VB_SIS302B | VB_SIS301LV | VB_SIS302LV |
> -			       VB_XGI301C)) {
> -		if (temp & EnableDualEdge) {
> -			tempbx |= SetCRT2ToDualEdge;
> -			if (temp & SetToLCDA)
> -				tempbx |= XGI_SetCRT2ToLCDA;
> -		}
> -	}
> -
> -	if (pVBInfo->VBType & (VB_SIS301LV | VB_SIS302LV | VB_XGI301C)) {
> -		if (temp & SetYPbPr) {
> -			/* shampoo add for new scratch */
> -			temp = xgifb_reg_get(pVBInfo->P3d4, 0x35);
> -			temp &= YPbPrMode;
> -			tempbx |= SetCRT2ToHiVision;
> -
> -			if (temp != YPbPrMode1080i) {
> -				tempbx &= ~SetCRT2ToHiVision;
> -				tempbx |= SetCRT2ToYPbPr525750;
> -			}
> -		}
> -	}
> -
> -	tempax = push; /* restore CR31 */
> -
> -	temp = 0x09FC;
> -
> -	if (!(tempbx & temp)) {
> -		tempax |= DisableCRT2Display;
> -		tempbx = 0;
> -	}
> -
> -	if (!(pVBInfo->VBType & VB_NoLCD)) {
> -		if (tempbx & XGI_SetCRT2ToLCDA) {
> -			if (tempbx & SetSimuScanMode)
> -				tempbx &= (~(SetCRT2ToLCD | SetCRT2ToRAMDAC |
> -					     SwitchCRT2));
> -			else
> -				tempbx &= (~(SetCRT2ToLCD | SetCRT2ToRAMDAC |
> -					     SetCRT2ToTV | SwitchCRT2));
> -		}
> -	}
> -
> -	/* shampoo add */
> -	/* for driver abnormal */
> -	if (!(tempbx & (SwitchCRT2 | SetSimuScanMode))) {
> -		if (tempbx & SetCRT2ToRAMDAC) {
> -			tempbx &= (0xFF00 | SetCRT2ToRAMDAC |
> -				   SwitchCRT2 | SetSimuScanMode);
> -			tempbx &= (0x00FF | (~SetCRT2ToYPbPr525750));
> -		}
> -	}
> -
> -	if (!(pVBInfo->VBType & VB_NoLCD)) {
> -		if (tempbx & SetCRT2ToLCD) {
> -			tempbx &= (0xFF00 | SetCRT2ToLCD | SwitchCRT2 |
> -				   SetSimuScanMode);
> -			tempbx &= (0x00FF | (~SetCRT2ToYPbPr525750));
> -		}
> -	}
> -
> -	if (tempbx & SetCRT2ToSCART) {
> -		tempbx &= (0xFF00 | SetCRT2ToSCART | SwitchCRT2 |
> -			   SetSimuScanMode);
> -		tempbx &= (0x00FF | (~SetCRT2ToYPbPr525750));
> -	}
> -
> -	if (tempbx & SetCRT2ToYPbPr525750)
> -		tempbx &= (0xFF00 | SwitchCRT2 | SetSimuScanMode);
> -
> -	if (tempbx & SetCRT2ToHiVision)
> -		tempbx &= (0xFF00 | SetCRT2ToHiVision | SwitchCRT2 |
> -			   SetSimuScanMode);
> -
> -	if (tempax & DisableCRT2Display) { /* Set Display Device Info */
> -		if (!(tempbx & (SwitchCRT2 | SetSimuScanMode)))
> -			tempbx = DisableCRT2Display;
> -	}
> -
> -	if (!(tempbx & DisableCRT2Display)) {
> -		if (!(tempbx & DriverMode) || !(modeflag & CRT2Mode)) {
> -			if (!(tempbx & XGI_SetCRT2ToLCDA))
> -				tempbx |= (SetInSlaveMode | SetSimuScanMode);
> -		}
> -
> -		/* LCD+TV can't support in slave mode
> -		 * (Force LCDA+TV->LCDB)
> -		 */
> -		if ((tempbx & SetInSlaveMode) && (tempbx & XGI_SetCRT2ToLCDA)) {
> -			tempbx ^= (SetCRT2ToLCD | XGI_SetCRT2ToLCDA |
> -				   SetCRT2ToDualEdge);
> -			pVBInfo->SetFlag |= ReserveTVOption;
> -		}
> -	}
> -
> -	pVBInfo->VBInfo = tempbx;
> -}
> -
> -static void XGI_GetTVInfo(unsigned short ModeIdIndex,
> -			  struct vb_device_info *pVBInfo)
> -{
> -	unsigned short tempbx = 0, resinfo = 0, modeflag, index1;
> -
> -	if (pVBInfo->VBInfo & SetCRT2ToTV) {
> -		modeflag = XGI330_EModeIDTable[ModeIdIndex].Ext_ModeFlag;
> -		resinfo = XGI330_EModeIDTable[ModeIdIndex].Ext_RESINFO;
> -
> -		tempbx = xgifb_reg_get(pVBInfo->P3d4, 0x35);
> -		if (tempbx & TVSetPAL) {
> -			tempbx &= (SetCHTVOverScan |
> -				   TVSetPALM |
> -				   TVSetPALN |
> -				   TVSetPAL);
> -			if (tempbx & TVSetPALM)
> -				/* set to NTSC if PAL-M */
> -				tempbx &= ~TVSetPAL;
> -		} else {
> -			tempbx &= (SetCHTVOverScan |
> -				   TVSetNTSCJ |
> -				   TVSetPAL);
> -		}
> -
> -		if (pVBInfo->VBInfo & SetCRT2ToSCART)
> -			tempbx |= TVSetPAL;
> -
> -		if (pVBInfo->VBInfo & SetCRT2ToYPbPr525750) {
> -			index1 = xgifb_reg_get(pVBInfo->P3d4, 0x35);
> -			index1 &= YPbPrMode;
> -
> -			if (index1 == YPbPrMode525i)
> -				tempbx |= TVSetYPbPr525i;
> -
> -			if (index1 == YPbPrMode525p)
> -				tempbx = tempbx | TVSetYPbPr525p;
> -			if (index1 == YPbPrMode750p)
> -				tempbx = tempbx | TVSetYPbPr750p;
> -		}
> -
> -		if (pVBInfo->VBInfo & SetCRT2ToHiVision)
> -			tempbx = tempbx | TVSetHiVision | TVSetPAL;
> -
> -		if ((pVBInfo->VBInfo & SetInSlaveMode) &&
> -		    (!(pVBInfo->VBInfo & SetNotSimuMode)))
> -			tempbx |= TVSimuMode;
> -
> -		if (!(tempbx & TVSetPAL) && (modeflag > 13) && (resinfo == 8)) {
> -			/* NTSC 1024x768, */
> -			tempbx |= NTSC1024x768;
> -		}
> -
> -		tempbx |= RPLLDIV2XO;
> -
> -		if (pVBInfo->VBInfo & SetCRT2ToHiVision) {
> -			if (pVBInfo->VBInfo & SetInSlaveMode)
> -				tempbx &= (~RPLLDIV2XO);
> -		} else if (tempbx & (TVSetYPbPr525p | TVSetYPbPr750p)) {
> -			tempbx &= (~RPLLDIV2XO);
> -		} else if (!(pVBInfo->VBType & (VB_SIS301B | VB_SIS302B |
> -						VB_SIS301LV | VB_SIS302LV |
> -						VB_XGI301C))) {
> -			if (tempbx & TVSimuMode)
> -				tempbx &= (~RPLLDIV2XO);
> -		}
> -	}
> -	pVBInfo->TVInfo = tempbx;
> -}
> -
> -static unsigned char XGI_GetLCDInfo(unsigned short ModeIdIndex,
> -				    struct vb_device_info *pVBInfo)
> -{
> -	unsigned short temp, tempax, tempbx, resinfo = 0, LCDIdIndex;
> -
> -	pVBInfo->LCDResInfo = 0;
> -	pVBInfo->LCDTypeInfo = 0;
> -	pVBInfo->LCDInfo = 0;
> -
> -	/* si+Ext_ResInfo */
> -	resinfo = XGI330_EModeIDTable[ModeIdIndex].Ext_RESINFO;
> -	temp = xgifb_reg_get(pVBInfo->P3d4, 0x36); /* Get LCD Res.Info */
> -	tempbx = temp & 0x0F;
> -
> -	if (tempbx == 0)
> -		tempbx = Panel_1024x768; /* default */
> -
> -	/* LCD75 */
> -	if ((tempbx == Panel_1024x768) || (tempbx == Panel_1280x1024)) {
> -		if (pVBInfo->VBInfo & DriverMode) {
> -			tempax = xgifb_reg_get(pVBInfo->P3d4, 0x33);
> -			if (pVBInfo->VBInfo & XGI_SetCRT2ToLCDA)
> -				tempax &= 0x0F;
> -			else
> -				tempax >>= 4;
> -
> -			if ((resinfo == 6) || (resinfo == 9)) {
> -				if (tempax >= 3)
> -					tempbx |= PanelRef75Hz;
> -			} else if ((resinfo == 7) || (resinfo == 8)) {
> -				if (tempax >= 4)
> -					tempbx |= PanelRef75Hz;
> -			}
> -		}
> -	}
> -
> -	pVBInfo->LCDResInfo = tempbx;
> -
> -	/* End of LCD75 */
> -
> -	if (!(pVBInfo->VBInfo & (SetCRT2ToLCD | XGI_SetCRT2ToLCDA)))
> -		return 0;
> -
> -	tempbx = 0;
> -
> -	temp = xgifb_reg_get(pVBInfo->P3d4, 0x37);
> -
> -	temp &= (ScalingLCD | LCDNonExpanding | LCDSyncBit | SetPWDEnable);
> -
> -	tempbx |= temp;
> -
> -	LCDIdIndex = XGI_GetLCDCapPtr1(pVBInfo);
> -
> -	tempax = pVBInfo->LCDCapList[LCDIdIndex].LCD_Capability;
> -
> -	if (((pVBInfo->VBType & VB_SIS302LV) ||
> -	     (pVBInfo->VBType & VB_XGI301C)) && (tempax & XGI_LCDDualLink))
> -		tempbx |= SetLCDDualLink;
> -
> -	if ((pVBInfo->LCDResInfo == Panel_1400x1050) &&
> -	    (pVBInfo->VBInfo & SetCRT2ToLCD) && (resinfo == 9) &&
> -	    !(tempbx & EnableScalingLCD))
> -		/*
> -		 * set to center in 1280x1024 LCDB
> -		 * for Panel_1400x1050
> -		 */
> -		tempbx |= SetLCDtoNonExpanding;
> -
> -	if (pVBInfo->VBInfo & SetInSlaveMode) {
> -		if (pVBInfo->VBInfo & SetNotSimuMode)
> -			tempbx |= XGI_LCDVESATiming;
> -	} else {
> -		tempbx |= XGI_LCDVESATiming;
> -	}
> -
> -	pVBInfo->LCDInfo = tempbx;
> -
> -	return 1;
> -}
> -
> -unsigned char XGI_SearchModeID(unsigned short ModeNo,
> -			       unsigned short *ModeIdIndex)
> -{
> -	for (*ModeIdIndex = 0;; (*ModeIdIndex)++) {
> -		if (XGI330_EModeIDTable[*ModeIdIndex].Ext_ModeID == ModeNo)
> -			break;
> -		if (XGI330_EModeIDTable[*ModeIdIndex].Ext_ModeID == 0xFF)
> -			return 0;
> -	}
> -
> -	return 1;
> -}
> -
> -static unsigned char XG21GPIODataTransfer(unsigned char ujDate)
> -{
> -	unsigned char ujRet = 0;
> -	unsigned char i = 0;
> -
> -	for (i = 0; i < 8; i++) {
> -		ujRet <<= 1;
> -		ujRet |= (ujDate >> i) & 1;
> -	}
> -
> -	return ujRet;
> -}
> -
> -/*
> - * output
> - *	bl[5] : LVDS signal
> - *	bl[1] : LVDS backlight
> - *	bl[0] : LVDS VDD
> - */
> -static unsigned char XGI_XG21GetPSCValue(struct vb_device_info *pVBInfo)
> -{
> -	unsigned char CR4A, temp;
> -
> -	CR4A = xgifb_reg_get(pVBInfo->P3d4, 0x4A);
> -	xgifb_reg_and(pVBInfo->P3d4, 0x4A, ~0x23); /* enable GPIO write */
> -
> -	temp = xgifb_reg_get(pVBInfo->P3d4, 0x48);
> -
> -	temp = XG21GPIODataTransfer(temp);
> -	temp &= 0x23;
> -	xgifb_reg_set(pVBInfo->P3d4, 0x4A, CR4A);
> -	return temp;
> -}
> -
> -/*
> - * output
> - *	bl[5] : LVDS signal
> - *	bl[1] : LVDS backlight
> - *	bl[0] : LVDS VDD
> - */
> -static unsigned char XGI_XG27GetPSCValue(struct vb_device_info *pVBInfo)
> -{
> -	unsigned char CR4A, CRB4, temp;
> -
> -	CR4A = xgifb_reg_get(pVBInfo->P3d4, 0x4A);
> -	xgifb_reg_and(pVBInfo->P3d4, 0x4A, ~0x0C); /* enable GPIO write */
> -
> -	temp = xgifb_reg_get(pVBInfo->P3d4, 0x48);
> -
> -	temp &= 0x0C;
> -	temp >>= 2;
> -	xgifb_reg_set(pVBInfo->P3d4, 0x4A, CR4A);
> -	CRB4 = xgifb_reg_get(pVBInfo->P3d4, 0xB4);
> -	temp |= ((CRB4 & 0x04) << 3);
> -	return temp;
> -}
> -
> -/*
> - * input
> - *	bl[5] : 1;LVDS signal on
> - *	bl[1] : 1;LVDS backlight on
> - *	bl[0] : 1:LVDS VDD on
> - *	bh: 100000b : clear bit 5, to set bit5
> - *	    000010b : clear bit 1, to set bit1
> - *	    000001b : clear bit 0, to set bit0
> - */
> -static void XGI_XG21BLSignalVDD(unsigned short tempbh, unsigned short tempbl,
> -				struct vb_device_info *pVBInfo)
> -{
> -	unsigned char CR4A, temp;
> -
> -	CR4A = xgifb_reg_get(pVBInfo->P3d4, 0x4A);
> -	tempbh &= 0x23;
> -	tempbl &= 0x23;
> -	xgifb_reg_and(pVBInfo->P3d4, 0x4A, ~tempbh); /* enable GPIO write */
> -
> -	if (tempbh & 0x20) {
> -		temp = (tempbl >> 4) & 0x02;
> -
> -		/* CR B4[1] */
> -		xgifb_reg_and_or(pVBInfo->P3d4, 0xB4, ~0x02, temp);
> -	}
> -
> -	temp = xgifb_reg_get(pVBInfo->P3d4, 0x48);
> -
> -	temp = XG21GPIODataTransfer(temp);
> -	temp &= ~tempbh;
> -	temp |= tempbl;
> -	xgifb_reg_set(pVBInfo->P3d4, 0x48, temp);
> -}
> -
> -static void XGI_XG27BLSignalVDD(unsigned short tempbh, unsigned short tempbl,
> -				struct vb_device_info *pVBInfo)
> -{
> -	unsigned char CR4A, temp;
> -	unsigned short tempbh0, tempbl0;
> -
> -	tempbh0 = tempbh;
> -	tempbl0 = tempbl;
> -	tempbh0 &= 0x20;
> -	tempbl0 &= 0x20;
> -	tempbh0 >>= 3;
> -	tempbl0 >>= 3;
> -
> -	if (tempbh & 0x20) {
> -		temp = (tempbl >> 4) & 0x02;
> -
> -		/* CR B4[1] */
> -		xgifb_reg_and_or(pVBInfo->P3d4, 0xB4, ~0x02, temp);
> -	}
> -	xgifb_reg_and_or(pVBInfo->P3d4, 0xB4, ~tempbh0, tempbl0);
> -
> -	CR4A = xgifb_reg_get(pVBInfo->P3d4, 0x4A);
> -	tempbh &= 0x03;
> -	tempbl &= 0x03;
> -	tempbh <<= 2;
> -	tempbl <<= 2; /* GPIOC,GPIOD */
> -	xgifb_reg_and(pVBInfo->P3d4, 0x4A, ~tempbh); /* enable GPIO write */
> -	xgifb_reg_and_or(pVBInfo->P3d4, 0x48, ~tempbh, tempbl);
> -}
> -
> -static void XGI_DisplayOn(struct xgifb_video_info *xgifb_info,
> -			  struct xgi_hw_device_info *pXGIHWDE,
> -			  struct vb_device_info *pVBInfo)
> -{
> -	xgifb_reg_and_or(pVBInfo->P3c4, 0x01, 0xDF, 0x00);
> -	if (pXGIHWDE->jChipType == XG21) {
> -		if (pVBInfo->IF_DEF_LVDS == 1) {
> -			if (!(XGI_XG21GetPSCValue(pVBInfo) & 0x1)) {
> -				/* LVDS VDD on */
> -				XGI_XG21BLSignalVDD(0x01, 0x01, pVBInfo);
> -				mdelay(xgifb_info->lvds_data.PSC_S2);
> -			}
> -			if (!(XGI_XG21GetPSCValue(pVBInfo) & 0x20))
> -				/* LVDS signal on */
> -				XGI_XG21BLSignalVDD(0x20, 0x20, pVBInfo);
> -			mdelay(xgifb_info->lvds_data.PSC_S3);
> -			/* LVDS backlight on */
> -			XGI_XG21BLSignalVDD(0x02, 0x02, pVBInfo);
> -		} else {
> -			/* DVO/DVI signal on */
> -			XGI_XG21BLSignalVDD(0x20, 0x20, pVBInfo);
> -		}
> -	}
> -
> -	if (pXGIHWDE->jChipType == XG27) {
> -		if (pVBInfo->IF_DEF_LVDS == 1) {
> -			if (!(XGI_XG27GetPSCValue(pVBInfo) & 0x1)) {
> -				/* LVDS VDD on */
> -				XGI_XG27BLSignalVDD(0x01, 0x01, pVBInfo);
> -				mdelay(xgifb_info->lvds_data.PSC_S2);
> -			}
> -			if (!(XGI_XG27GetPSCValue(pVBInfo) & 0x20))
> -				/* LVDS signal on */
> -				XGI_XG27BLSignalVDD(0x20, 0x20, pVBInfo);
> -			mdelay(xgifb_info->lvds_data.PSC_S3);
> -			/* LVDS backlight on */
> -			XGI_XG27BLSignalVDD(0x02, 0x02, pVBInfo);
> -		} else {
> -			/* DVO/DVI signal on */
> -			XGI_XG27BLSignalVDD(0x20, 0x20, pVBInfo);
> -		}
> -	}
> -}
> -
> -void XGI_DisplayOff(struct xgifb_video_info *xgifb_info,
> -		    struct xgi_hw_device_info *pXGIHWDE,
> -		    struct vb_device_info *pVBInfo)
> -{
> -	if (pXGIHWDE->jChipType == XG21) {
> -		if (pVBInfo->IF_DEF_LVDS == 1) {
> -			/* LVDS backlight off */
> -			XGI_XG21BLSignalVDD(0x02, 0x00, pVBInfo);
> -			mdelay(xgifb_info->lvds_data.PSC_S3);
> -		} else {
> -			/* DVO/DVI signal off */
> -			XGI_XG21BLSignalVDD(0x20, 0x00, pVBInfo);
> -		}
> -	}
> -
> -	if (pXGIHWDE->jChipType == XG27) {
> -		if ((XGI_XG27GetPSCValue(pVBInfo) & 0x2)) {
> -			/* LVDS backlight off */
> -			XGI_XG27BLSignalVDD(0x02, 0x00, pVBInfo);
> -			mdelay(xgifb_info->lvds_data.PSC_S3);
> -		}
> -
> -		if (pVBInfo->IF_DEF_LVDS == 0) {
> -			/* DVO/DVI signal off */
> -			XGI_XG27BLSignalVDD(0x20, 0x00, pVBInfo);
> -		}
> -	}
> -
> -	xgifb_reg_and_or(pVBInfo->P3c4, 0x01, 0xDF, 0x20);
> -}
> -
> -static void XGI_WaitDisply(struct vb_device_info *pVBInfo)
> -{
> -	while ((inb(pVBInfo->P3da) & 0x01))
> -		break;
> -
> -	while (!(inb(pVBInfo->P3da) & 0x01))
> -		break;
> -}
> -
> -static void XGI_AutoThreshold(struct vb_device_info *pVBInfo)
> -{
> -	xgifb_reg_or(pVBInfo->Part1Port, 0x01, 0x40);
> -}
> -
> -static void XGI_SaveCRT2Info(unsigned short ModeNo,
> -			     struct vb_device_info *pVBInfo)
> -{
> -	unsigned short temp1, temp2;
> -
> -	/* reserve CR34 for CRT1 Mode No */
> -	xgifb_reg_set(pVBInfo->P3d4, 0x34, ModeNo);
> -	temp1 = (pVBInfo->VBInfo & SetInSlaveMode) >> 8;
> -	temp2 = ~(SetInSlaveMode >> 8);
> -	xgifb_reg_and_or(pVBInfo->P3d4, 0x31, temp2, temp1);
> -}
> -
> -static void XGI_GetCRT2ResInfo(unsigned short ModeIdIndex,
> -			       struct vb_device_info *pVBInfo)
> -{
> -	unsigned short xres, yres, modeflag, resindex;
> -
> -	resindex = XGI330_EModeIDTable[ModeIdIndex].Ext_RESINFO;
> -	xres = XGI330_ModeResInfo[resindex].HTotal; /* xres->ax */
> -	yres = XGI330_ModeResInfo[resindex].VTotal; /* yres->bx */
> -	/* si+St_ModeFlag */
> -	modeflag = XGI330_EModeIDTable[ModeIdIndex].Ext_ModeFlag;
> -
> -	if (modeflag & HalfDCLK)
> -		xres *= 2;
> -
> -	if (modeflag & DoubleScanMode)
> -		yres *= 2;
> -
> -	if (!(pVBInfo->VBInfo & SetCRT2ToLCD))
> -		goto exit;
> -
> -	if (pVBInfo->LCDResInfo == Panel_1600x1200) {
> -		if (!(pVBInfo->LCDInfo & XGI_LCDVESATiming)) {
> -			if (yres == 1024)
> -				yres = 1056;
> -		}
> -	}
> -
> -	if (pVBInfo->LCDResInfo == Panel_1280x1024) {
> -		if (yres == 400)
> -			yres = 405;
> -		else if (yres == 350)
> -			yres = 360;
> -
> -		if (pVBInfo->LCDInfo & XGI_LCDVESATiming) {
> -			if (yres == 360)
> -				yres = 375;
> -		}
> -	}
> -
> -	if (pVBInfo->LCDResInfo == Panel_1024x768) {
> -		if (!(pVBInfo->LCDInfo & XGI_LCDVESATiming)) {
> -			if (!(pVBInfo->LCDInfo & LCDNonExpanding)) {
> -				if (yres == 350)
> -					yres = 357;
> -				else if (yres == 400)
> -					yres = 420;
> -				else if (yres == 480)
> -					yres = 525;
> -			}
> -		}
> -	}
> -
> -	if (xres == 720)
> -		xres = 640;
> -
> -exit:
> -	pVBInfo->VGAHDE = xres;
> -	pVBInfo->HDE = xres;
> -	pVBInfo->VGAVDE = yres;
> -	pVBInfo->VDE = yres;
> -}
> -
> -static unsigned char XGI_IsLCDDualLink(struct vb_device_info *pVBInfo)
> -{
> -	if ((pVBInfo->VBInfo & (SetCRT2ToLCD | XGI_SetCRT2ToLCDA)) &&
> -	    (pVBInfo->LCDInfo & SetLCDDualLink)) /* shampoo0129 */
> -		return 1;
> -
> -	return 0;
> -}
> -
> -static void XGI_GetRAMDAC2DATA(unsigned short ModeIdIndex,
> -			       unsigned short RefreshRateTableIndex,
> -			       struct vb_device_info *pVBInfo)
> -{
> -	unsigned short tempax, tempbx, temp1, temp2, modeflag = 0, tempcx,
> -			CRT1Index;
> -
> -	pVBInfo->RVBHCMAX = 1;
> -	pVBInfo->RVBHCFACT = 1;
> -	modeflag = XGI330_EModeIDTable[ModeIdIndex].Ext_ModeFlag;
> -	CRT1Index = XGI330_RefIndex[RefreshRateTableIndex].Ext_CRT1CRTC;
> -	CRT1Index &= IndexMask;
> -	temp1 = (unsigned short)XGI_CRT1Table[CRT1Index].CR[0];
> -	temp2 = (unsigned short)XGI_CRT1Table[CRT1Index].CR[5];
> -	tempax = (temp1 & 0xFF) | ((temp2 & 0x03) << 8);
> -	tempbx = (unsigned short)XGI_CRT1Table[CRT1Index].CR[8];
> -	tempcx = (unsigned short)XGI_CRT1Table[CRT1Index].CR[14] << 8;
> -	tempcx &= 0x0100;
> -	tempcx <<= 2;
> -	tempbx |= tempcx;
> -	temp1 = (unsigned short)XGI_CRT1Table[CRT1Index].CR[9];
> -
> -	if (temp1 & 0x01)
> -		tempbx |= 0x0100;
> -
> -	if (temp1 & 0x20)
> -		tempbx |= 0x0200;
> -	tempax += 5;
> -
> -	if (modeflag & Charx8Dot)
> -		tempax *= 8;
> -	else
> -		tempax *= 9;
> -
> -	pVBInfo->VGAHT = tempax;
> -	pVBInfo->HT = tempax;
> -	tempbx++;
> -	pVBInfo->VGAVT = tempbx;
> -	pVBInfo->VT = tempbx;
> -}
> -
> -static void XGI_GetCRT2Data(unsigned short ModeIdIndex,
> -			    unsigned short RefreshRateTableIndex,
> -			    struct vb_device_info *pVBInfo)
> -{
> -	unsigned short tempax = 0, tempbx = 0, modeflag, resinfo;
> -
> -	struct SiS_LCDData const *LCDPtr = NULL;
> -
> -	/* si+Ext_ResInfo */
> -	modeflag = XGI330_EModeIDTable[ModeIdIndex].Ext_ModeFlag;
> -	resinfo = XGI330_EModeIDTable[ModeIdIndex].Ext_RESINFO;
> -	pVBInfo->NewFlickerMode = 0;
> -	pVBInfo->RVBHRS = 50;
> -
> -	if (pVBInfo->VBInfo & SetCRT2ToRAMDAC) {
> -		XGI_GetRAMDAC2DATA(ModeIdIndex, RefreshRateTableIndex, pVBInfo);
> -		return;
> -	}
> -
> -	if (pVBInfo->VBInfo & (SetCRT2ToLCD | XGI_SetCRT2ToLCDA)) {
> -		LCDPtr = XGI_GetLcdPtr(XGI_LCDDataTable, ModeIdIndex,
> -				       pVBInfo);
> -
> -		pVBInfo->RVBHCMAX = LCDPtr->RVBHCMAX;
> -		pVBInfo->RVBHCFACT = LCDPtr->RVBHCFACT;
> -		pVBInfo->VGAHT = LCDPtr->VGAHT;
> -		pVBInfo->VGAVT = LCDPtr->VGAVT;
> -		pVBInfo->HT = LCDPtr->LCDHT;
> -		pVBInfo->VT = LCDPtr->LCDVT;
> -
> -		if (pVBInfo->LCDResInfo == Panel_1024x768) {
> -			tempax = 1024;
> -			tempbx = 768;
> -
> -			if (!(pVBInfo->LCDInfo & XGI_LCDVESATiming)) {
> -				if (pVBInfo->VGAVDE == 357)
> -					tempbx = 527;
> -				else if (pVBInfo->VGAVDE == 420)
> -					tempbx = 620;
> -				else if (pVBInfo->VGAVDE == 525)
> -					tempbx = 775;
> -				else if (pVBInfo->VGAVDE == 600)
> -					tempbx = 775;
> -			}
> -		} else if (pVBInfo->LCDResInfo == Panel_1024x768x75) {
> -			tempax = 1024;
> -			tempbx = 768;
> -		} else if (pVBInfo->LCDResInfo == Panel_1280x1024) {
> -			tempax = 1280;
> -			if (pVBInfo->VGAVDE == 360)
> -				tempbx = 768;
> -			else if (pVBInfo->VGAVDE == 375)
> -				tempbx = 800;
> -			else if (pVBInfo->VGAVDE == 405)
> -				tempbx = 864;
> -			else
> -				tempbx = 1024;
> -		} else if (pVBInfo->LCDResInfo == Panel_1280x1024x75) {
> -			tempax = 1280;
> -			tempbx = 1024;
> -		} else if (pVBInfo->LCDResInfo == Panel_1280x960) {
> -			tempax = 1280;
> -			if (pVBInfo->VGAVDE == 350)
> -				tempbx = 700;
> -			else if (pVBInfo->VGAVDE == 400)
> -				tempbx = 800;
> -			else if (pVBInfo->VGAVDE == 1024)
> -				tempbx = 960;
> -			else
> -				tempbx = 960;
> -		} else if (pVBInfo->LCDResInfo == Panel_1400x1050) {
> -			tempax = 1400;
> -			tempbx = 1050;
> -
> -			if (pVBInfo->VGAVDE == 1024) {
> -				tempax = 1280;
> -				tempbx = 1024;
> -			}
> -		} else if (pVBInfo->LCDResInfo == Panel_1600x1200) {
> -			tempax = 1600;
> -			tempbx = 1200; /* alan 10/14/2003 */
> -			if (!(pVBInfo->LCDInfo & XGI_LCDVESATiming)) {
> -				if (pVBInfo->VGAVDE == 350)
> -					tempbx = 875;
> -				else if (pVBInfo->VGAVDE == 400)
> -					tempbx = 1000;
> -			}
> -		}
> -
> -		if (pVBInfo->LCDInfo & LCDNonExpanding) {
> -			tempax = pVBInfo->VGAHDE;
> -			tempbx = pVBInfo->VGAVDE;
> -		}
> -
> -		pVBInfo->HDE = tempax;
> -		pVBInfo->VDE = tempbx;
> -		return;
> -	}
> -
> -	if (pVBInfo->VBInfo & (SetCRT2ToTV)) {
> -		struct SiS_TVData const *TVPtr;
> -
> -		TVPtr = XGI_GetTVPtr(ModeIdIndex, RefreshRateTableIndex,
> -				     pVBInfo);
> -
> -		pVBInfo->RVBHCMAX = TVPtr->RVBHCMAX;
> -		pVBInfo->RVBHCFACT = TVPtr->RVBHCFACT;
> -		pVBInfo->VGAHT = TVPtr->VGAHT;
> -		pVBInfo->VGAVT = TVPtr->VGAVT;
> -		pVBInfo->HDE = TVPtr->TVHDE;
> -		pVBInfo->VDE = TVPtr->TVVDE;
> -		pVBInfo->RVBHRS = TVPtr->RVBHRS;
> -		pVBInfo->NewFlickerMode = TVPtr->FlickerMode;
> -
> -		if (pVBInfo->VBInfo & SetCRT2ToHiVision) {
> -			if (resinfo == 0x08)
> -				pVBInfo->NewFlickerMode = 0x40;
> -			else if (resinfo == 0x09)
> -				pVBInfo->NewFlickerMode = 0x40;
> -			else if (resinfo == 0x12)
> -				pVBInfo->NewFlickerMode = 0x40;
> -
> -			if (pVBInfo->VGAVDE == 350)
> -				pVBInfo->TVInfo |= TVSimuMode;
> -
> -			tempax = ExtHiTVHT;
> -			tempbx = ExtHiTVVT;
> -
> -			if (pVBInfo->VBInfo & SetInSlaveMode) {
> -				if (pVBInfo->TVInfo & TVSimuMode) {
> -					tempax = StHiTVHT;
> -					tempbx = StHiTVVT;
> -
> -					if (!(modeflag & Charx8Dot)) {
> -						tempax = StHiTextTVHT;
> -						tempbx = StHiTextTVVT;
> -					}
> -				}
> -			}
> -		} else if (pVBInfo->VBInfo & SetCRT2ToYPbPr525750) {
> -			if (pVBInfo->TVInfo & TVSetYPbPr750p) {
> -				tempax = YPbPrTV750pHT; /* Ext750pTVHT */
> -				tempbx = YPbPrTV750pVT; /* Ext750pTVVT */
> -			}
> -
> -			if (pVBInfo->TVInfo & TVSetYPbPr525p) {
> -				tempax = YPbPrTV525pHT; /* Ext525pTVHT */
> -				tempbx = YPbPrTV525pVT; /* Ext525pTVVT */
> -			} else if (pVBInfo->TVInfo & TVSetYPbPr525i) {
> -				tempax = YPbPrTV525iHT; /* Ext525iTVHT */
> -				tempbx = YPbPrTV525iVT; /* Ext525iTVVT */
> -				if (pVBInfo->TVInfo & NTSC1024x768)
> -					tempax = NTSC1024x768HT;
> -			}
> -		} else {
> -			tempax = PALHT;
> -			tempbx = PALVT;
> -			if (!(pVBInfo->TVInfo & TVSetPAL)) {
> -				tempax = NTSCHT;
> -				tempbx = NTSCVT;
> -				if (pVBInfo->TVInfo & NTSC1024x768)
> -					tempax = NTSC1024x768HT;
> -			}
> -		}
> -
> -		pVBInfo->HT = tempax;
> -		pVBInfo->VT = tempbx;
> -	}
> -}
> -
> -static void XGI_SetCRT2VCLK(unsigned short ModeIdIndex,
> -			    unsigned short RefreshRateTableIndex,
> -			    struct vb_device_info *pVBInfo)
> -{
> -	unsigned char di_0, di_1, tempal;
> -
> -	tempal = XGI_GetVCLKPtr(RefreshRateTableIndex, ModeIdIndex, pVBInfo);
> -	XGI_GetVCLKLen(tempal, &di_0, &di_1, pVBInfo);
> -	XGI_GetLCDVCLKPtr(&di_0, &di_1, pVBInfo);
> -
> -	if (pVBInfo->VBType & VB_SIS301) { /* shampoo 0129 */
> -		/* 301 */
> -		xgifb_reg_set(pVBInfo->Part4Port, 0x0A, 0x10);
> -		xgifb_reg_set(pVBInfo->Part4Port, 0x0B, di_1);
> -		xgifb_reg_set(pVBInfo->Part4Port, 0x0A, di_0);
> -	} else { /* 301b/302b/301lv/302lv */
> -		xgifb_reg_set(pVBInfo->Part4Port, 0x0A, di_0);
> -		xgifb_reg_set(pVBInfo->Part4Port, 0x0B, di_1);
> -	}
> -
> -	xgifb_reg_set(pVBInfo->Part4Port, 0x00, 0x12);
> -
> -	if (pVBInfo->VBInfo & SetCRT2ToRAMDAC)
> -		xgifb_reg_or(pVBInfo->Part4Port, 0x12, 0x28);
> -	else
> -		xgifb_reg_or(pVBInfo->Part4Port, 0x12, 0x08);
> -}
> -
> -static unsigned short XGI_GetColorDepth(unsigned short ModeIdIndex)
> -{
> -	unsigned short ColorDepth[6] = { 1, 2, 4, 4, 6, 8 };
> -	short index;
> -	unsigned short modeflag;
> -
> -	modeflag = XGI330_EModeIDTable[ModeIdIndex].Ext_ModeFlag;
> -	index = (modeflag & ModeTypeMask) - ModeEGA;
> -
> -	if (index < 0)
> -		index = 0;
> -
> -	return ColorDepth[index];
> -}
> -
> -static unsigned short XGI_GetOffset(unsigned short ModeNo,
> -				    unsigned short ModeIdIndex,
> -				    unsigned short RefreshRateTableIndex)
> -{
> -	unsigned short temp, colordepth, modeinfo, index, infoflag,
> -			ColorDepth[] = { 0x01, 0x02, 0x04 };
> -
> -	modeinfo = XGI330_EModeIDTable[ModeIdIndex].Ext_ModeInfo;
> -	infoflag = XGI330_RefIndex[RefreshRateTableIndex].Ext_InfoFlag;
> -
> -	index = (modeinfo >> 8) & 0xFF;
> -
> -	temp = XGI330_ScreenOffset[index];
> -
> -	if (infoflag & InterlaceMode)
> -		temp <<= 1;
> -
> -	colordepth = XGI_GetColorDepth(ModeIdIndex);
> -
> -	if ((ModeNo >= 0x7C) && (ModeNo <= 0x7E)) {
> -		temp = ModeNo - 0x7C;
> -		colordepth = ColorDepth[temp];
> -		temp = 0x6B;
> -		if (infoflag & InterlaceMode)
> -			temp <<= 1;
> -	}
> -	return temp * colordepth;
> -}
> -
> -static void XGI_SetCRT2Offset(unsigned short ModeNo,
> -			      unsigned short ModeIdIndex,
> -			      unsigned short RefreshRateTableIndex,
> -			      struct vb_device_info *pVBInfo)
> -{
> -	unsigned short offset;
> -	unsigned char temp;
> -
> -	if (pVBInfo->VBInfo & SetInSlaveMode)
> -		return;
> -
> -	offset = XGI_GetOffset(ModeNo, ModeIdIndex, RefreshRateTableIndex);
> -	temp = (unsigned char)(offset & 0xFF);
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x07, temp);
> -	temp = (unsigned char)((offset & 0xFF00) >> 8);
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x09, temp);
> -	temp = (unsigned char)(((offset >> 3) & 0xFF) + 1);
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x03, temp);
> -}
> -
> -static void XGI_SetCRT2FIFO(struct vb_device_info *pVBInfo)
> -{
> -	/* threshold high ,disable auto threshold */
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x01, 0x3B);
> -	/* threshold low default 04h */
> -	xgifb_reg_and_or(pVBInfo->Part1Port, 0x02, ~(0x3F), 0x04);
> -}
> -
> -static void XGI_PreSetGroup1(unsigned short ModeNo, unsigned short ModeIdIndex,
> -			     unsigned short RefreshRateTableIndex,
> -			     struct vb_device_info *pVBInfo)
> -{
> -	u8 tempcx;
> -
> -	XGI_SetCRT2Offset(ModeNo, ModeIdIndex, RefreshRateTableIndex, pVBInfo);
> -	XGI_SetCRT2FIFO(pVBInfo);
> -
> -	for (tempcx = 4; tempcx < 7; tempcx++)
> -		xgifb_reg_set(pVBInfo->Part1Port, tempcx, 0x0);
> -
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x50, 0x00);
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x02, 0x44); /* temp 0206 */
> -}
> -
> -static void XGI_SetGroup1(unsigned short ModeIdIndex,
> -			  unsigned short RefreshRateTableIndex,
> -			  struct vb_device_info *pVBInfo)
> -{
> -	unsigned short temp = 0, tempax = 0, tempbx = 0, tempcx = 0,
> -			pushbx = 0, CRT1Index, modeflag;
> -
> -	CRT1Index = XGI330_RefIndex[RefreshRateTableIndex].Ext_CRT1CRTC;
> -	CRT1Index &= IndexMask;
> -	modeflag = XGI330_EModeIDTable[ModeIdIndex].Ext_ModeFlag;
> -
> -	/* bainy change table name */
> -	if (modeflag & HalfDCLK) {
> -		/* BTVGA2HT 0x08,0x09 */
> -		temp = (pVBInfo->VGAHT / 2 - 1) & 0x0FF;
> -		xgifb_reg_set(pVBInfo->Part1Port, 0x08, temp);
> -		temp = (((pVBInfo->VGAHT / 2 - 1) & 0xFF00) >> 8) << 4;
> -		xgifb_reg_and_or(pVBInfo->Part1Port, 0x09, ~0x0F0, temp);
> -		/* BTVGA2HDEE 0x0A,0x0C */
> -		temp = (pVBInfo->VGAHDE / 2 + 16) & 0x0FF;
> -		xgifb_reg_set(pVBInfo->Part1Port, 0x0A, temp);
> -		tempcx = ((pVBInfo->VGAHT - pVBInfo->VGAHDE) / 2) >> 2;
> -		pushbx = pVBInfo->VGAHDE / 2 + 16;
> -		tempcx >>= 1;
> -		tempbx = pushbx + tempcx; /* bx BTVGA@HRS 0x0B,0x0C */
> -		tempcx += tempbx;
> -
> -		if (pVBInfo->VBInfo & SetCRT2ToRAMDAC) {
> -			tempbx = XGI_CRT1Table[CRT1Index].CR[4];
> -			tempbx |= ((XGI_CRT1Table[CRT1Index].CR[14] &
> -						0xC0) << 2);
> -			tempbx = (tempbx - 3) << 3; /* (VGAHRS-3)*8 */
> -			tempcx = XGI_CRT1Table[CRT1Index].CR[5];
> -			tempcx &= 0x1F;
> -			temp = XGI_CRT1Table[CRT1Index].CR[15];
> -			temp = (temp & 0x04) << (5 - 2); /* VGAHRE D[5] */
> -			tempcx = ((tempcx | temp) - 3) << 3; /* (VGAHRE-3)*8 */
> -		}
> -
> -		tempbx += 4;
> -		tempcx += 4;
> -
> -		if (tempcx > (pVBInfo->VGAHT / 2))
> -			tempcx = pVBInfo->VGAHT / 2;
> -
> -		temp = tempbx & 0x00FF;
> -
> -		xgifb_reg_set(pVBInfo->Part1Port, 0x0B, temp);
> -	} else {
> -		temp = (pVBInfo->VGAHT - 1) & 0x0FF; /* BTVGA2HT 0x08,0x09 */
> -		xgifb_reg_set(pVBInfo->Part1Port, 0x08, temp);
> -		temp = (((pVBInfo->VGAHT - 1) & 0xFF00) >> 8) << 4;
> -		xgifb_reg_and_or(pVBInfo->Part1Port, 0x09, ~0x0F0, temp);
> -		/* BTVGA2HDEE 0x0A,0x0C */
> -		temp = (pVBInfo->VGAHDE + 16) & 0x0FF;
> -		xgifb_reg_set(pVBInfo->Part1Port, 0x0A, temp);
> -		tempcx = (pVBInfo->VGAHT - pVBInfo->VGAHDE) >> 2; /* cx */
> -		pushbx = pVBInfo->VGAHDE + 16;
> -		tempcx >>= 1;
> -		tempbx = pushbx + tempcx; /* bx BTVGA@HRS 0x0B,0x0C */
> -		tempcx += tempbx;
> -
> -		if (pVBInfo->VBInfo & SetCRT2ToRAMDAC) {
> -			tempbx = XGI_CRT1Table[CRT1Index].CR[3];
> -			tempbx |= ((XGI_CRT1Table[CRT1Index].CR[5] &
> -						0xC0) << 2);
> -			tempbx = (tempbx - 3) << 3; /* (VGAHRS-3)*8 */
> -			tempcx = XGI_CRT1Table[CRT1Index].CR[4];
> -			tempcx &= 0x1F;
> -			temp = XGI_CRT1Table[CRT1Index].CR[6];
> -			temp = (temp & 0x04) << (5 - 2); /* VGAHRE D[5] */
> -			tempcx = ((tempcx | temp) - 3) << 3; /* (VGAHRE-3)*8 */
> -			tempbx += 16;
> -			tempcx += 16;
> -		}
> -
> -		if (tempcx > pVBInfo->VGAHT)
> -			tempcx = pVBInfo->VGAHT;
> -
> -		temp = tempbx & 0x00FF;
> -		xgifb_reg_set(pVBInfo->Part1Port, 0x0B, temp);
> -	}
> -
> -	tempax = (tempax & 0x00FF) | (tempbx & 0xFF00);
> -	tempbx = pushbx;
> -	tempbx = (tempbx & 0x00FF) | ((tempbx & 0xFF00) << 4);
> -	tempax |= (tempbx & 0xFF00);
> -	temp = (tempax & 0xFF00) >> 8;
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x0C, temp);
> -	temp = tempcx & 0x00FF;
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x0D, temp);
> -	tempcx = pVBInfo->VGAVT - 1;
> -	temp = tempcx & 0x00FF;
> -
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x0E, temp);
> -	tempbx = pVBInfo->VGAVDE - 1;
> -	temp = tempbx & 0x00FF;
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x0F, temp);
> -	temp = ((tempbx & 0xFF00) << 3) >> 8;
> -	temp |= ((tempcx & 0xFF00) >> 8);
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x12, temp);
> -
> -	/* BTVGA2VRS 0x10,0x11 */
> -	tempbx = (pVBInfo->VGAVT + pVBInfo->VGAVDE) >> 1;
> -	/* BTVGA2VRE 0x11 */
> -	tempcx = ((pVBInfo->VGAVT - pVBInfo->VGAVDE) >> 4) + tempbx + 1;
> -
> -	if (pVBInfo->VBInfo & SetCRT2ToRAMDAC) {
> -		tempbx = XGI_CRT1Table[CRT1Index].CR[10];
> -		temp = XGI_CRT1Table[CRT1Index].CR[9];
> -
> -		if (temp & 0x04)
> -			tempbx |= 0x0100;
> -
> -		if (temp & 0x080)
> -			tempbx |= 0x0200;
> -
> -		temp = XGI_CRT1Table[CRT1Index].CR[14];
> -
> -		if (temp & 0x08)
> -			tempbx |= 0x0400;
> -
> -		temp = XGI_CRT1Table[CRT1Index].CR[11];
> -		tempcx = (tempcx & 0xFF00) | (temp & 0x00FF);
> -	}
> -
> -	temp = tempbx & 0x00FF;
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x10, temp);
> -	temp = ((tempbx & 0xFF00) >> 8) << 4;
> -	temp = (tempcx & 0x000F) | (temp);
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x11, temp);
> -	tempax = 0;
> -
> -	if (modeflag & DoubleScanMode)
> -		tempax |= 0x80;
> -
> -	if (modeflag & HalfDCLK)
> -		tempax |= 0x40;
> -
> -	xgifb_reg_and_or(pVBInfo->Part1Port, 0x2C, ~0x0C0, tempax);
> -}
> -
> -static unsigned short XGI_GetVGAHT2(struct vb_device_info *pVBInfo)
> -{
> -	unsigned long tempax, tempbx;
> -
> -	tempbx = ((pVBInfo->VGAVT - pVBInfo->VGAVDE) * pVBInfo->RVBHCMAX)
> -			& 0xFFFF;
> -	tempax = (pVBInfo->VT - pVBInfo->VDE) * pVBInfo->RVBHCFACT;
> -	tempax = (tempax * pVBInfo->HT) / tempbx;
> -
> -	return (unsigned short)tempax;
> -}
> -
> -static void XGI_SetLockRegs(unsigned short ModeNo, unsigned short ModeIdIndex,
> -			    struct vb_device_info *pVBInfo)
> -{
> -	unsigned short push1, push2, tempax, tempbx = 0, tempcx, temp, resinfo,
> -			modeflag;
> -
> -	/* si+Ext_ResInfo */
> -	modeflag = XGI330_EModeIDTable[ModeIdIndex].Ext_ModeFlag;
> -	resinfo = XGI330_EModeIDTable[ModeIdIndex].Ext_RESINFO;
> -
> -	if (!(pVBInfo->VBInfo & SetInSlaveMode))
> -		return;
> -
> -	temp = 0xFF; /* set MAX HT */
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x03, temp);
> -	tempcx = 0x08;
> -
> -	if (pVBInfo->VBType & (VB_SIS301LV | VB_SIS302LV | VB_XGI301C))
> -		modeflag |= Charx8Dot;
> -
> -	tempax = pVBInfo->VGAHDE; /* 0x04 Horizontal Display End */
> -
> -	if (modeflag & HalfDCLK)
> -		tempax >>= 1;
> -
> -	tempax = (tempax / tempcx) - 1;
> -	tempbx |= ((tempax & 0x00FF) << 8);
> -	temp = tempax & 0x00FF;
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x04, temp);
> -
> -	temp = (tempbx & 0xFF00) >> 8;
> -
> -	if (pVBInfo->VBInfo & SetCRT2ToTV) {
> -		if (!(pVBInfo->VBType & (VB_SIS301B | VB_SIS302B | VB_SIS301LV
> -				| VB_SIS302LV | VB_XGI301C)))
> -			temp += 2;
> -
> -		if ((pVBInfo->VBInfo & SetCRT2ToHiVision) &&
> -		    !(pVBInfo->VBType & VB_SIS301LV) && (resinfo == 7))
> -			temp -= 2;
> -	}
> -
> -	/* 0x05 Horizontal Display Start */
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x05, temp);
> -	/* 0x06 Horizontal Blank end */
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x06, 0x03);
> -
> -	if (!(pVBInfo->VBInfo & DisableCRT2Display)) { /* 030226 bainy */
> -		if (pVBInfo->VBInfo & SetCRT2ToTV)
> -			tempax = pVBInfo->VGAHT;
> -		else
> -			tempax = XGI_GetVGAHT2(pVBInfo);
> -	}
> -
> -	if (tempax >= pVBInfo->VGAHT)
> -		tempax = pVBInfo->VGAHT;
> -
> -	if (modeflag & HalfDCLK)
> -		tempax >>= 1;
> -
> -	tempax = (tempax / tempcx) - 5;
> -	tempcx = tempax; /* 20030401 0x07 horizontal Retrace Start */
> -	if (pVBInfo->VBInfo & SetCRT2ToHiVision) {
> -		temp = (tempbx & 0x00FF) - 1;
> -		if (!(modeflag & HalfDCLK)) {
> -			temp -= 6;
> -			if (pVBInfo->TVInfo & TVSimuMode) {
> -				temp -= 4;
> -				temp -= 10;
> -			}
> -		}
> -	} else {
> -		tempbx = (tempbx & 0xFF00) >> 8;
> -		tempcx = (tempcx + tempbx) >> 1;
> -		temp = (tempcx & 0x00FF) + 2;
> -
> -		if (pVBInfo->VBInfo & SetCRT2ToTV) {
> -			temp -= 1;
> -			if (!(modeflag & HalfDCLK)) {
> -				if ((modeflag & Charx8Dot)) {
> -					temp += 4;
> -					if (pVBInfo->VGAHDE >= 800)
> -						temp -= 6;
> -				}
> -			}
> -		} else if (!(modeflag & HalfDCLK)) {
> -			temp -= 4;
> -			if (pVBInfo->LCDResInfo != Panel_1280x960 &&
> -			    pVBInfo->VGAHDE >= 800) {
> -				temp -= 7;
> -				if (pVBInfo->VGAHDE >= 1280 &&
> -				    pVBInfo->LCDResInfo != Panel_1280x960 &&
> -				    (pVBInfo->LCDInfo & LCDNonExpanding))
> -					temp += 28;
> -			}
> -		}
> -	}
> -
> -	/* 0x07 Horizontal Retrace Start */
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x07, temp);
> -	/* 0x08 Horizontal Retrace End */
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x08, 0);
> -
> -	if (pVBInfo->VBInfo & SetCRT2ToTV) {
> -		if (pVBInfo->TVInfo & TVSimuMode) {
> -			if (ModeNo == 0x50) {
> -				if (pVBInfo->TVInfo == SetNTSCTV) {
> -					xgifb_reg_set(pVBInfo->Part1Port,
> -						      0x07, 0x30);
> -					xgifb_reg_set(pVBInfo->Part1Port,
> -						      0x08, 0x03);
> -				} else {
> -					xgifb_reg_set(pVBInfo->Part1Port,
> -						      0x07, 0x2f);
> -					xgifb_reg_set(pVBInfo->Part1Port,
> -						      0x08, 0x02);
> -				}
> -			}
> -		}
> -	}
> -
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x18, 0x03); /* 0x18 SR0B */
> -	xgifb_reg_and_or(pVBInfo->Part1Port, 0x19, 0xF0, 0x00);
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x09, 0xFF); /* 0x09 Set Max VT */
> -
> -	tempbx = pVBInfo->VGAVT;
> -	push1 = tempbx;
> -	tempcx = 0x121;
> -	tempbx = pVBInfo->VGAVDE; /* 0x0E Vertical Display End */
> -
> -	if (tempbx == 357)
> -		tempbx = 350;
> -	if (tempbx == 360)
> -		tempbx = 350;
> -	if (tempbx == 375)
> -		tempbx = 350;
> -	if (tempbx == 405)
> -		tempbx = 400;
> -	if (tempbx == 525)
> -		tempbx = 480;
> -
> -	push2 = tempbx;
> -
> -	if (pVBInfo->VBInfo & SetCRT2ToLCD) {
> -		if (pVBInfo->LCDResInfo == Panel_1024x768) {
> -			if (!(pVBInfo->LCDInfo & XGI_LCDVESATiming)) {
> -				if (tempbx == 350)
> -					tempbx += 5;
> -				if (tempbx == 480)
> -					tempbx += 5;
> -			}
> -		}
> -	}
> -	tempbx--;
> -	tempbx--;
> -	temp = tempbx & 0x00FF;
> -	/* 0x10 vertical Blank Start */
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x10, temp);
> -	tempbx = push2;
> -	tempbx--;
> -	temp = tempbx & 0x00FF;
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x0E, temp);
> -
> -	if (tempbx & 0x0100)
> -		tempcx |= 0x0002;
> -
> -	tempax = 0x000B;
> -
> -	if (modeflag & DoubleScanMode)
> -		tempax |= 0x08000;
> -
> -	if (tempbx & 0x0200)
> -		tempcx |= 0x0040;
> -
> -	temp = (tempax & 0xFF00) >> 8;
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x0B, temp);
> -
> -	if (tempbx & 0x0400)
> -		tempcx |= 0x0600;
> -
> -	/* 0x11 Vertical Blank End */
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x11, 0x00);
> -
> -	tempax = push1;
> -	tempax -= tempbx; /* 0x0C Vertical Retrace Start */
> -	tempax >>= 2;
> -	push1 = tempax; /* push ax */
> -
> -	if (resinfo != 0x09) {
> -		tempax <<= 1;
> -		tempbx += tempax;
> -	}
> -
> -	if (pVBInfo->VBInfo & SetCRT2ToHiVision) {
> -		if ((pVBInfo->VBType & VB_SIS301LV) &&
> -		    !(pVBInfo->TVInfo & TVSetHiVision)) {
> -			if ((pVBInfo->TVInfo & TVSimuMode) &&
> -			    (pVBInfo->TVInfo & TVSetPAL)) {
> -				if (!(pVBInfo->VBType & VB_SIS301LV) ||
> -				    !(pVBInfo->TVInfo &
> -				      (TVSetYPbPr525p |
> -				       TVSetYPbPr750p |
> -				       TVSetHiVision)))
> -					tempbx += 40;
> -			}
> -		} else {
> -			tempbx -= 10;
> -		}
> -	} else if (pVBInfo->TVInfo & TVSimuMode) {
> -		if (pVBInfo->TVInfo & TVSetPAL) {
> -			if (pVBInfo->VBType & VB_SIS301LV) {
> -				if (!(pVBInfo->TVInfo &
> -				    (TVSetYPbPr525p |
> -				     TVSetYPbPr750p |
> -				     TVSetHiVision)))
> -					tempbx += 40;
> -			} else {
> -				tempbx += 40;
> -			}
> -		}
> -	}
> -	tempax = push1;
> -	tempax >>= 2;
> -	tempax++;
> -	tempax += tempbx;
> -	push1 = tempax; /* push ax */
> -
> -	if ((pVBInfo->TVInfo & TVSetPAL)) {
> -		if (tempbx <= 513) {
> -			if (tempax >= 513)
> -				tempbx = 513;
> -		}
> -	}
> -
> -	temp = tempbx & 0x00FF;
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x0C, temp);
> -	tempbx--;
> -	temp = tempbx & 0x00FF;
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x10, temp);
> -
> -	if (tempbx & 0x0100)
> -		tempcx |= 0x0008;
> -
> -	if (tempbx & 0x0200)
> -		xgifb_reg_and_or(pVBInfo->Part1Port, 0x0B, 0x0FF, 0x20);
> -
> -	tempbx++;
> -
> -	if (tempbx & 0x0100)
> -		tempcx |= 0x0004;
> -
> -	if (tempbx & 0x0200)
> -		tempcx |= 0x0080;
> -
> -	if (tempbx & 0x0400)
> -		tempcx |= 0x0C00;
> -
> -	tempbx = push1; /* pop ax */
> -	temp = tempbx & 0x00FF;
> -	temp &= 0x0F;
> -	/* 0x0D vertical Retrace End */
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x0D, temp);
> -
> -	if (tempbx & 0x0010)
> -		tempcx |= 0x2000;
> -
> -	temp = tempcx & 0x00FF;
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x0A, temp); /* 0x0A CR07 */
> -	temp = (tempcx & 0x0FF00) >> 8;
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x17, temp); /* 0x17 SR0A */
> -	tempax = modeflag;
> -	temp = (tempax & 0xFF00) >> 8;
> -
> -	temp = (temp >> 1) & 0x09;
> -
> -	if (pVBInfo->VBType & (VB_SIS301LV | VB_SIS302LV | VB_XGI301C))
> -		temp |= 0x01;
> -
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x16, temp); /* 0x16 SR01 */
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x0F, 0); /* 0x0F CR14 */
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x12, 0); /* 0x12 CR17 */
> -
> -	if (pVBInfo->LCDInfo & LCDRGB18Bit)
> -		temp = 0x80;
> -	else
> -		temp = 0x00;
> -
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x1A, temp); /* 0x1A SR0E */
> -}
> -
> -static void XGI_SetGroup2(unsigned short ModeNo, unsigned short ModeIdIndex,
> -			  struct vb_device_info *pVBInfo)
> -{
> -	unsigned short i, j, tempax, tempbx, tempcx, temp, push1, push2,
> -			modeflag;
> -	unsigned char const *TimingPoint;
> -
> -	unsigned long longtemp, tempeax, tempebx, temp2, tempecx;
> -
> -	/* si+Ext_ResInfo */
> -	modeflag = XGI330_EModeIDTable[ModeIdIndex].Ext_ModeFlag;
> -
> -	tempax = 0;
> -
> -	if (!(pVBInfo->VBInfo & SetCRT2ToAVIDEO))
> -		tempax |= 0x0800;
> -
> -	if (!(pVBInfo->VBInfo & SetCRT2ToSVIDEO))
> -		tempax |= 0x0400;
> -
> -	if (pVBInfo->VBInfo & SetCRT2ToSCART)
> -		tempax |= 0x0200;
> -
> -	if (!(pVBInfo->TVInfo & TVSetPAL))
> -		tempax |= 0x1000;
> -
> -	if (pVBInfo->VBInfo & SetCRT2ToHiVision)
> -		tempax |= 0x0100;
> -
> -	if (pVBInfo->TVInfo & (TVSetYPbPr525p | TVSetYPbPr750p))
> -		tempax &= 0xfe00;
> -
> -	tempax = (tempax & 0xff00) >> 8;
> -
> -	xgifb_reg_set(pVBInfo->Part2Port, 0x0, tempax);
> -	TimingPoint = XGI330_NTSCTiming;
> -
> -	if (pVBInfo->TVInfo & TVSetPAL)
> -		TimingPoint = XGI330_PALTiming;
> -
> -	if (pVBInfo->VBInfo & SetCRT2ToHiVision) {
> -		TimingPoint = XGI330_HiTVExtTiming;
> -
> -		if (pVBInfo->VBInfo & SetInSlaveMode)
> -			TimingPoint = XGI330_HiTVSt2Timing;
> -
> -		if (pVBInfo->SetFlag & TVSimuMode)
> -			TimingPoint = XGI330_HiTVSt1Timing;
> -
> -		if (!(modeflag & Charx8Dot))
> -			TimingPoint = XGI330_HiTVTextTiming;
> -	}
> -
> -	if (pVBInfo->VBInfo & SetCRT2ToYPbPr525750) {
> -		if (pVBInfo->TVInfo & TVSetYPbPr525i)
> -			TimingPoint = XGI330_YPbPr525iTiming;
> -
> -		if (pVBInfo->TVInfo & TVSetYPbPr525p)
> -			TimingPoint = XGI330_YPbPr525pTiming;
> -
> -		if (pVBInfo->TVInfo & TVSetYPbPr750p)
> -			TimingPoint = XGI330_YPbPr750pTiming;
> -	}
> -
> -	for (i = 0x01, j = 0; i <= 0x2D; i++, j++)
> -		xgifb_reg_set(pVBInfo->Part2Port, i, TimingPoint[j]);
> -
> -	for (i = 0x39; i <= 0x45; i++, j++)
> -		/* di->temp2[j] */
> -		xgifb_reg_set(pVBInfo->Part2Port, i, TimingPoint[j]);
> -
> -	if (pVBInfo->VBInfo & SetCRT2ToTV)
> -		xgifb_reg_and_or(pVBInfo->Part2Port, 0x3A, 0x1F, 0x00);
> -
> -	temp = pVBInfo->NewFlickerMode;
> -	temp &= 0x80;
> -	xgifb_reg_and_or(pVBInfo->Part2Port, 0x0A, 0xFF, temp);
> -
> -	if (pVBInfo->TVInfo & TVSetPAL)
> -		tempax = 520;
> -	else
> -		tempax = 440;
> -
> -	if (pVBInfo->VDE <= tempax) {
> -		tempax -= pVBInfo->VDE;
> -		tempax >>= 2;
> -		tempax = (tempax & 0x00FF) | ((tempax & 0x00FF) << 8);
> -		push1 = tempax;
> -		temp = (tempax & 0xFF00) >> 8;
> -		temp += (unsigned short)TimingPoint[0];
> -
> -		if (pVBInfo->VBType & (VB_SIS301B | VB_SIS302B | VB_SIS301LV
> -				| VB_SIS302LV | VB_XGI301C)) {
> -			if (pVBInfo->VBInfo & (SetCRT2ToAVIDEO
> -					| SetCRT2ToSVIDEO | SetCRT2ToSCART
> -					| SetCRT2ToYPbPr525750)) {
> -				tempcx = pVBInfo->VGAHDE;
> -				if (tempcx >= 1024) {
> -					temp = 0x17; /* NTSC */
> -					if (pVBInfo->TVInfo & TVSetPAL)
> -						temp = 0x19; /* PAL */
> -				}
> -			}
> -		}
> -
> -		xgifb_reg_set(pVBInfo->Part2Port, 0x01, temp);
> -		tempax = push1;
> -		temp = (tempax & 0xFF00) >> 8;
> -		temp += TimingPoint[1];
> -
> -		if (pVBInfo->VBType & (VB_SIS301B | VB_SIS302B | VB_SIS301LV
> -				| VB_SIS302LV | VB_XGI301C)) {
> -			if ((pVBInfo->VBInfo & (SetCRT2ToAVIDEO
> -					| SetCRT2ToSVIDEO | SetCRT2ToSCART
> -					| SetCRT2ToYPbPr525750))) {
> -				tempcx = pVBInfo->VGAHDE;
> -				if (tempcx >= 1024) {
> -					temp = 0x1D; /* NTSC */
> -					if (pVBInfo->TVInfo & TVSetPAL)
> -						temp = 0x52; /* PAL */
> -				}
> -			}
> -		}
> -		xgifb_reg_set(pVBInfo->Part2Port, 0x02, temp);
> -	}
> -
> -	/* 301b */
> -	tempcx = pVBInfo->HT;
> -
> -	if (XGI_IsLCDDualLink(pVBInfo))
> -		tempcx >>= 1;
> -
> -	tempcx -= 2;
> -	temp = tempcx & 0x00FF;
> -	xgifb_reg_set(pVBInfo->Part2Port, 0x1B, temp);
> -
> -	temp = (tempcx & 0xFF00) >> 8;
> -	xgifb_reg_and_or(pVBInfo->Part2Port, 0x1D, ~0x0F, temp);
> -
> -	tempcx = pVBInfo->HT >> 1;
> -	push1 = tempcx; /* push cx */
> -	tempcx += 7;
> -
> -	if (pVBInfo->VBInfo & SetCRT2ToHiVision)
> -		tempcx -= 4;
> -
> -	temp = tempcx & 0x00FF;
> -	temp <<= 4;
> -	xgifb_reg_and_or(pVBInfo->Part2Port, 0x22, 0x0F, temp);
> -
> -	tempbx = TimingPoint[j] | ((TimingPoint[j + 1]) << 8);
> -	tempbx += tempcx;
> -	push2 = tempbx;
> -	temp = tempbx & 0x00FF;
> -	xgifb_reg_set(pVBInfo->Part2Port, 0x24, temp);
> -	temp = (tempbx & 0xFF00) >> 8;
> -	temp <<= 4;
> -	xgifb_reg_and_or(pVBInfo->Part2Port, 0x25, 0x0F, temp);
> -
> -	tempbx = push2;
> -	tempbx = tempbx + 8;
> -	if (pVBInfo->VBInfo & SetCRT2ToHiVision) {
> -		tempbx = tempbx - 4;
> -		tempcx = tempbx;
> -	}
> -
> -	temp = (tempbx & 0x00FF) << 4;
> -	xgifb_reg_and_or(pVBInfo->Part2Port, 0x29, 0x0F, temp);
> -
> -	j += 2;
> -	tempcx += (TimingPoint[j] | ((TimingPoint[j + 1]) << 8));
> -	temp = tempcx & 0x00FF;
> -	xgifb_reg_set(pVBInfo->Part2Port, 0x27, temp);
> -	temp = ((tempcx & 0xFF00) >> 8) << 4;
> -	xgifb_reg_and_or(pVBInfo->Part2Port, 0x28, 0x0F, temp);
> -
> -	tempcx += 8;
> -	if (pVBInfo->VBInfo & SetCRT2ToHiVision)
> -		tempcx -= 4;
> -
> -	temp = tempcx & 0xFF;
> -	temp <<= 4;
> -	xgifb_reg_and_or(pVBInfo->Part2Port, 0x2A, 0x0F, temp);
> -
> -	tempcx = push1; /* pop cx */
> -	j += 2;
> -	temp = TimingPoint[j] | ((TimingPoint[j + 1]) << 8);
> -	tempcx -= temp;
> -	temp = tempcx & 0x00FF;
> -	temp <<= 4;
> -	xgifb_reg_and_or(pVBInfo->Part2Port, 0x2D, 0x0F, temp);
> -
> -	tempcx -= 11;
> -
> -	if (!(pVBInfo->VBInfo & SetCRT2ToTV)) {
> -		tempax = XGI_GetVGAHT2(pVBInfo);
> -		tempcx = tempax - 1;
> -	}
> -	temp = tempcx & 0x00FF;
> -	xgifb_reg_set(pVBInfo->Part2Port, 0x2E, temp);
> -
> -	tempbx = pVBInfo->VDE;
> -
> -	if (pVBInfo->VGAVDE == 360)
> -		tempbx = 746;
> -	if (pVBInfo->VGAVDE == 375)
> -		tempbx = 746;
> -	if (pVBInfo->VGAVDE == 405)
> -		tempbx = 853;
> -
> -	if (pVBInfo->VBInfo & SetCRT2ToTV) {
> -		if (pVBInfo->VBType &
> -		    (VB_SIS301LV | VB_SIS302LV | VB_XGI301C)) {
> -			if (!(pVBInfo->TVInfo &
> -			    (TVSetYPbPr525p | TVSetYPbPr750p)))
> -				tempbx >>= 1;
> -		} else {
> -			tempbx >>= 1;
> -		}
> -	}
> -
> -	tempbx -= 2;
> -	temp = tempbx & 0x00FF;
> -
> -	if (pVBInfo->VBInfo & SetCRT2ToHiVision) {
> -		if (pVBInfo->VBType & VB_SIS301LV) {
> -			if (pVBInfo->TVInfo & TVSetHiVision) {
> -				if (pVBInfo->VBInfo & SetInSlaveMode) {
> -					if (ModeNo == 0x2f)
> -						temp += 1;
> -				}
> -			}
> -		} else if (pVBInfo->VBInfo & SetInSlaveMode) {
> -			if (ModeNo == 0x2f)
> -				temp += 1;
> -		}
> -	}
> -
> -	xgifb_reg_set(pVBInfo->Part2Port, 0x2F, temp);
> -
> -	temp = (tempcx & 0xFF00) >> 8;
> -	temp |= ((tempbx & 0xFF00) >> 8) << 6;
> -
> -	if (!(pVBInfo->VBInfo & SetCRT2ToHiVision)) {
> -		if (pVBInfo->VBType & VB_SIS301LV) {
> -			if (pVBInfo->TVInfo & TVSetHiVision) {
> -				temp |= 0x10;
> -
> -				if (!(pVBInfo->VBInfo & SetCRT2ToSVIDEO))
> -					temp |= 0x20;
> -			}
> -		} else {
> -			temp |= 0x10;
> -			if (!(pVBInfo->VBInfo & SetCRT2ToSVIDEO))
> -				temp |= 0x20;
> -		}
> -	}
> -
> -	xgifb_reg_set(pVBInfo->Part2Port, 0x30, temp);
> -
> -	if (pVBInfo->VBType & (VB_SIS301B | VB_SIS302B | VB_SIS301LV
> -			| VB_SIS302LV | VB_XGI301C)) { /* TV gatingno */
> -		tempbx = pVBInfo->VDE;
> -		tempcx = tempbx - 2;
> -
> -		if (pVBInfo->VBInfo & SetCRT2ToTV) {
> -			if (!(pVBInfo->TVInfo & (TVSetYPbPr525p
> -					| TVSetYPbPr750p)))
> -				tempbx >>= 1;
> -		}
> -
> -		if (pVBInfo->VBType & (VB_SIS302LV | VB_XGI301C)) {
> -			temp = 0;
> -			if (tempcx & 0x0400)
> -				temp |= 0x20;
> -
> -			if (tempbx & 0x0400)
> -				temp |= 0x40;
> -
> -			xgifb_reg_set(pVBInfo->Part4Port, 0x10, temp);
> -		}
> -
> -		temp = (((tempbx - 3) & 0x0300) >> 8) << 5;
> -		xgifb_reg_set(pVBInfo->Part2Port, 0x46, temp);
> -		temp = (tempbx - 3) & 0x00FF;
> -		xgifb_reg_set(pVBInfo->Part2Port, 0x47, temp);
> -	}
> -
> -	tempbx = tempbx & 0x00FF;
> -
> -	if (!(modeflag & HalfDCLK)) {
> -		tempcx = pVBInfo->VGAHDE;
> -		if (tempcx >= pVBInfo->HDE) {
> -			tempbx |= 0x2000;
> -			tempax &= 0x00FF;
> -		}
> -	}
> -
> -	tempcx = 0x0101;
> -
> -	if (pVBInfo->VBInfo & SetCRT2ToTV) { /* 301b */
> -		if (pVBInfo->VGAHDE >= 1024) {
> -			tempcx = 0x1920;
> -			if (pVBInfo->VGAHDE >= 1280) {
> -				tempcx = 0x1420;
> -				tempbx = tempbx & 0xDFFF;
> -			}
> -		}
> -	}
> -
> -	if (!(tempbx & 0x2000)) {
> -		if (modeflag & HalfDCLK)
> -			tempcx = (tempcx & 0xFF00) | ((tempcx & 0x00FF) << 1);
> -
> -		push1 = tempbx;
> -		tempeax = pVBInfo->VGAHDE;
> -		tempebx = (tempcx & 0xFF00) >> 8;
> -		longtemp = tempeax * tempebx;
> -		tempecx = tempcx & 0x00FF;
> -		longtemp = longtemp / tempecx;
> -
> -		/* 301b */
> -		tempecx = 8 * 1024;
> -
> -		if (pVBInfo->VBType & (VB_SIS301B | VB_SIS302B | VB_SIS301LV
> -				| VB_SIS302LV | VB_XGI301C)) {
> -			tempecx = tempecx * 8;
> -		}
> -
> -		longtemp = longtemp * tempecx;
> -		tempecx = pVBInfo->HDE;
> -		temp2 = longtemp % tempecx;
> -		tempeax = longtemp / tempecx;
> -		if (temp2 != 0)
> -			tempeax += 1;
> -
> -		tempax = (unsigned short)tempeax;
> -
> -		/* 301b */
> -		if (pVBInfo->VBType & (VB_SIS301B | VB_SIS302B | VB_SIS301LV
> -				| VB_SIS302LV | VB_XGI301C)) {
> -			tempcx = ((tempax & 0xFF00) >> 5) >> 8;
> -		}
> -		/* end 301b */
> -
> -		tempbx = push1;
> -		tempbx = (unsigned short)(((tempeax & 0x0000FF00) & 0x1F00)
> -				| (tempbx & 0x00FF));
> -		tempax = (unsigned short)(((tempeax & 0x000000FF) << 8)
> -				| (tempax & 0x00FF));
> -		temp = (tempax & 0xFF00) >> 8;
> -	} else {
> -		temp = (tempax & 0x00FF) >> 8;
> -	}
> -
> -	xgifb_reg_set(pVBInfo->Part2Port, 0x44, temp);
> -	temp = (tempbx & 0xFF00) >> 8;
> -	xgifb_reg_and_or(pVBInfo->Part2Port, 0x45, ~0x03F, temp);
> -	temp = tempcx & 0x00FF;
> -
> -	if (tempbx & 0x2000)
> -		temp = 0;
> -
> -	if (!(pVBInfo->VBInfo & SetCRT2ToLCD))
> -		temp |= 0x18;
> -
> -	xgifb_reg_and_or(pVBInfo->Part2Port, 0x46, ~0x1F, temp);
> -	if (pVBInfo->TVInfo & TVSetPAL) {
> -		tempbx = 0x0382;
> -		tempcx = 0x007e;
> -	} else {
> -		tempbx = 0x0369;
> -		tempcx = 0x0061;
> -	}
> -
> -	temp = tempbx & 0x00FF;
> -	xgifb_reg_set(pVBInfo->Part2Port, 0x4b, temp);
> -	temp = tempcx & 0x00FF;
> -	xgifb_reg_set(pVBInfo->Part2Port, 0x4c, temp);
> -
> -	temp = ((tempcx & 0xFF00) >> 8) & 0x03;
> -	temp <<= 2;
> -	temp |= ((tempbx & 0xFF00) >> 8) & 0x03;
> -
> -	if (pVBInfo->VBInfo & SetCRT2ToYPbPr525750) {
> -		temp |= 0x10;
> -
> -		if (pVBInfo->TVInfo & TVSetYPbPr525p)
> -			temp |= 0x20;
> -
> -		if (pVBInfo->TVInfo & TVSetYPbPr750p)
> -			temp |= 0x60;
> -	}
> -
> -	xgifb_reg_set(pVBInfo->Part2Port, 0x4d, temp);
> -	temp = xgifb_reg_get(pVBInfo->Part2Port, 0x43); /* 301b change */
> -	xgifb_reg_set(pVBInfo->Part2Port, 0x43, (unsigned short)(temp - 3));
> -
> -	if (!(pVBInfo->TVInfo & (TVSetYPbPr525p | TVSetYPbPr750p))) {
> -		if (pVBInfo->TVInfo & NTSC1024x768) {
> -			TimingPoint = XGI_NTSC1024AdjTime;
> -			for (i = 0x1c, j = 0; i <= 0x30; i++, j++) {
> -				xgifb_reg_set(pVBInfo->Part2Port, i,
> -					      TimingPoint[j]);
> -			}
> -			xgifb_reg_set(pVBInfo->Part2Port, 0x43, 0x72);
> -		}
> -	}
> -
> -	/* Modify for 301C PALM Support */
> -	if (pVBInfo->VBType & VB_XGI301C) {
> -		if (pVBInfo->TVInfo & TVSetPALM)
> -			xgifb_reg_and_or(pVBInfo->Part2Port, 0x4E, ~0x08,
> -					 0x08); /* PALM Mode */
> -	}
> -
> -	if (pVBInfo->TVInfo & TVSetPALM) {
> -		tempax = xgifb_reg_get(pVBInfo->Part2Port, 0x01);
> -		tempax--;
> -		xgifb_reg_and(pVBInfo->Part2Port, 0x01, tempax);
> -
> -		xgifb_reg_and(pVBInfo->Part2Port, 0x00, 0xEF);
> -	}
> -
> -	if (pVBInfo->VBInfo & SetCRT2ToHiVision) {
> -		if (!(pVBInfo->VBInfo & SetInSlaveMode))
> -			xgifb_reg_set(pVBInfo->Part2Port, 0x0B, 0x00);
> -	}
> -}
> -
> -static void XGI_SetLCDRegs(unsigned short ModeIdIndex,
> -			   struct vb_device_info *pVBInfo)
> -{
> -	unsigned short pushbx, tempax, tempbx, tempcx, temp, tempah,
> -			tempbh, tempch;
> -
> -	struct XGI_LCDDesStruct const *LCDBDesPtr = NULL;
> -
> -	/* si+Ext_ResInfo */
> -	if (!(pVBInfo->VBInfo & SetCRT2ToLCD))
> -		return;
> -
> -	tempbx = pVBInfo->HDE; /* RHACTE=HDE-1 */
> -
> -	if (XGI_IsLCDDualLink(pVBInfo))
> -		tempbx >>= 1;
> -
> -	tempbx -= 1;
> -	temp = tempbx & 0x00FF;
> -	xgifb_reg_set(pVBInfo->Part2Port, 0x2C, temp);
> -	temp = (tempbx & 0xFF00) >> 8;
> -	temp <<= 4;
> -	xgifb_reg_and_or(pVBInfo->Part2Port, 0x2B, 0x0F, temp);
> -	temp = 0x01;
> -
> -	xgifb_reg_set(pVBInfo->Part2Port, 0x0B, temp);
> -	tempbx = pVBInfo->VDE; /* RTVACTEO=(VDE-1)&0xFF */
> -	tempbx--;
> -	temp = tempbx & 0x00FF;
> -	xgifb_reg_set(pVBInfo->Part2Port, 0x03, temp);
> -	temp = ((tempbx & 0xFF00) >> 8) & 0x07;
> -	xgifb_reg_and_or(pVBInfo->Part2Port, 0x0C, ~0x07, temp);
> -
> -	tempcx = pVBInfo->VT - 1;
> -	temp = tempcx & 0x00FF; /* RVTVT=VT-1 */
> -	xgifb_reg_set(pVBInfo->Part2Port, 0x19, temp);
> -	temp = (tempcx & 0xFF00) >> 8;
> -	temp <<= 5;
> -	xgifb_reg_set(pVBInfo->Part2Port, 0x1A, temp);
> -	xgifb_reg_and_or(pVBInfo->Part2Port, 0x09, 0xF0, 0x00);
> -	xgifb_reg_and_or(pVBInfo->Part2Port, 0x0A, 0xF0, 0x00);
> -	xgifb_reg_and_or(pVBInfo->Part2Port, 0x17, 0xFB, 0x00);
> -	xgifb_reg_and_or(pVBInfo->Part2Port, 0x18, 0xDF, 0x00);
> -
> -	/* Customized LCDB Does not add */
> -	if ((pVBInfo->VBType & VB_SIS301LV) || (pVBInfo->VBType & VB_SIS302LV))
> -		LCDBDesPtr = XGI_GetLcdPtr(xgifb_lcddldes, ModeIdIndex,
> -					   pVBInfo);
> -	else
> -		LCDBDesPtr = XGI_GetLcdPtr(XGI_LCDDesDataTable, ModeIdIndex,
> -					   pVBInfo);
> -
> -	tempah = pVBInfo->LCDResInfo;
> -	tempah &= PanelResInfo;
> -
> -	if ((tempah == Panel_1024x768) || (tempah == Panel_1024x768x75)) {
> -		tempbx = 1024;
> -		tempcx = 768;
> -	} else if ((tempah == Panel_1280x1024) ||
> -		   (tempah == Panel_1280x1024x75)) {
> -		tempbx = 1280;
> -		tempcx = 1024;
> -	} else if (tempah == Panel_1400x1050) {
> -		tempbx = 1400;
> -		tempcx = 1050;
> -	} else {
> -		tempbx = 1600;
> -		tempcx = 1200;
> -	}
> -
> -	if (pVBInfo->LCDInfo & EnableScalingLCD) {
> -		tempbx = pVBInfo->HDE;
> -		tempcx = pVBInfo->VDE;
> -	}
> -
> -	pushbx = tempbx;
> -	tempax = pVBInfo->VT;
> -	pVBInfo->LCDHDES = LCDBDesPtr->LCDHDES;
> -	pVBInfo->LCDHRS = LCDBDesPtr->LCDHRS;
> -	pVBInfo->LCDVDES = LCDBDesPtr->LCDVDES;
> -	pVBInfo->LCDVRS = LCDBDesPtr->LCDVRS;
> -	tempbx = pVBInfo->LCDVDES;
> -	tempcx += tempbx;
> -
> -	if (tempcx >= tempax)
> -		tempcx -= tempax; /* lcdvdes */
> -
> -	temp = tempbx & 0x00FF; /* RVEQ1EQ=lcdvdes */
> -	xgifb_reg_set(pVBInfo->Part2Port, 0x05, temp);
> -	temp = tempcx & 0x00FF;
> -	xgifb_reg_set(pVBInfo->Part2Port, 0x06, temp);
> -	tempch = ((tempcx & 0xFF00) >> 8) & 0x07;
> -	tempbh = ((tempbx & 0xFF00) >> 8) & 0x07;
> -	tempah = tempch;
> -	tempah <<= 3;
> -	tempah |= tempbh;
> -	xgifb_reg_set(pVBInfo->Part2Port, 0x02, tempah);
> -
> -	/* getlcdsync() */
> -	XGI_GetLCDSync(&tempax, &tempbx, pVBInfo);
> -	tempcx = tempbx;
> -	tempax = pVBInfo->VT;
> -	tempbx = pVBInfo->LCDVRS;
> -
> -	tempcx += tempbx;
> -	if (tempcx >= tempax)
> -		tempcx -= tempax;
> -
> -	temp = tempbx & 0x00FF; /* RTVACTEE=lcdvrs */
> -	xgifb_reg_set(pVBInfo->Part2Port, 0x04, temp);
> -	temp = (tempbx & 0xFF00) >> 8;
> -	temp <<= 4;
> -	temp |= (tempcx & 0x000F);
> -	xgifb_reg_set(pVBInfo->Part2Port, 0x01, temp);
> -	tempcx = pushbx;
> -	tempax = pVBInfo->HT;
> -	tempbx = pVBInfo->LCDHDES;
> -	tempbx &= 0x0FFF;
> -
> -	if (XGI_IsLCDDualLink(pVBInfo)) {
> -		tempax >>= 1;
> -		tempbx >>= 1;
> -		tempcx >>= 1;
> -	}
> -
> -	if (pVBInfo->VBType & VB_SIS302LV)
> -		tempbx += 1;
> -
> -	if (pVBInfo->VBType & VB_XGI301C) /* tap4 */
> -		tempbx += 1;
> -
> -	tempcx += tempbx;
> -
> -	if (tempcx >= tempax)
> -		tempcx -= tempax;
> -
> -	temp = tempbx & 0x00FF;
> -	xgifb_reg_set(pVBInfo->Part2Port, 0x1F, temp); /* RHBLKE=lcdhdes */
> -	temp = ((tempbx & 0xFF00) >> 8) << 4;
> -	xgifb_reg_set(pVBInfo->Part2Port, 0x20, temp);
> -	temp = tempcx & 0x00FF;
> -	xgifb_reg_set(pVBInfo->Part2Port, 0x23, temp); /* RHEQPLE=lcdhdee */
> -	temp = (tempcx & 0xFF00) >> 8;
> -	xgifb_reg_set(pVBInfo->Part2Port, 0x25, temp);
> -
> -	XGI_GetLCDSync(&tempax, &tempbx, pVBInfo);
> -	tempcx = tempax;
> -	tempax = pVBInfo->HT;
> -	tempbx = pVBInfo->LCDHRS;
> -	if (XGI_IsLCDDualLink(pVBInfo)) {
> -		tempax >>= 1;
> -		tempbx >>= 1;
> -		tempcx >>= 1;
> -	}
> -
> -	if (pVBInfo->VBType & VB_SIS302LV)
> -		tempbx += 1;
> -
> -	tempcx += tempbx;
> -
> -	if (tempcx >= tempax)
> -		tempcx -= tempax;
> -
> -	temp = tempbx & 0x00FF; /* RHBURSTS=lcdhrs */
> -	xgifb_reg_set(pVBInfo->Part2Port, 0x1C, temp);
> -
> -	temp = (tempbx & 0xFF00) >> 8;
> -	temp <<= 4;
> -	xgifb_reg_and_or(pVBInfo->Part2Port, 0x1D, ~0x0F0, temp);
> -	temp = tempcx & 0x00FF; /* RHSYEXP2S=lcdhre */
> -	xgifb_reg_set(pVBInfo->Part2Port, 0x21, temp);
> -
> -	if (!(pVBInfo->LCDInfo & XGI_LCDVESATiming)) {
> -		if (pVBInfo->VGAVDE == 525) {
> -			if (pVBInfo->VBType & (VB_SIS301B | VB_SIS302B
> -					| VB_SIS301LV | VB_SIS302LV
> -					| VB_XGI301C))
> -				temp = 0xC6;
> -			else
> -				temp = 0xC4;
> -
> -			xgifb_reg_set(pVBInfo->Part2Port, 0x2f, temp);
> -			xgifb_reg_set(pVBInfo->Part2Port, 0x30, 0xB3);
> -		}
> -
> -		if (pVBInfo->VGAVDE == 420) {
> -			if (pVBInfo->VBType & (VB_SIS301B | VB_SIS302B
> -					| VB_SIS301LV | VB_SIS302LV
> -					| VB_XGI301C))
> -				temp = 0x4F;
> -			else
> -				temp = 0x4E;
> -			xgifb_reg_set(pVBInfo->Part2Port, 0x2f, temp);
> -		}
> -	}
> -}
> -
> -/*
> - * Function : XGI_GetTap4Ptr
> - * Input :
> - * Output : di -> Tap4 Reg. Setting Pointer
> - * Description :
> - */
> -static struct XGI301C_Tap4TimingStruct const
> -*XGI_GetTap4Ptr(unsigned short tempcx, struct vb_device_info *pVBInfo)
> -{
> -	unsigned short tempax, tempbx, i;
> -	struct XGI301C_Tap4TimingStruct const *Tap4TimingPtr;
> -
> -	if (tempcx == 0) {
> -		tempax = pVBInfo->VGAHDE;
> -		tempbx = pVBInfo->HDE;
> -	} else {
> -		tempax = pVBInfo->VGAVDE;
> -		tempbx = pVBInfo->VDE;
> -	}
> -
> -	if (tempax <= tempbx)
> -		return &xgifb_tap4_timing[0];
> -	Tap4TimingPtr = xgifb_ntsc_525_tap4_timing; /* NTSC */
> -
> -	if (pVBInfo->TVInfo & TVSetPAL)
> -		Tap4TimingPtr = PALTap4Timing;
> -
> -	if (pVBInfo->VBInfo & SetCRT2ToYPbPr525750) {
> -		if ((pVBInfo->TVInfo & TVSetYPbPr525i) ||
> -		    (pVBInfo->TVInfo & TVSetYPbPr525p))
> -			Tap4TimingPtr = xgifb_ntsc_525_tap4_timing;
> -		if (pVBInfo->TVInfo & TVSetYPbPr750p)
> -			Tap4TimingPtr = YPbPr750pTap4Timing;
> -	}
> -
> -	if (pVBInfo->VBInfo & SetCRT2ToHiVision)
> -		Tap4TimingPtr = xgifb_tap4_timing;
> -
> -	i = 0;
> -	while (Tap4TimingPtr[i].DE != 0xFFFF) {
> -		if (Tap4TimingPtr[i].DE == tempax)
> -			break;
> -		i++;
> -	}
> -	return &Tap4TimingPtr[i];
> -}
> -
> -static void XGI_SetTap4Regs(struct vb_device_info *pVBInfo)
> -{
> -	unsigned short i, j;
> -	struct XGI301C_Tap4TimingStruct const *Tap4TimingPtr;
> -
> -	if (!(pVBInfo->VBType & VB_XGI301C))
> -		return;
> -
> -	Tap4TimingPtr = XGI_GetTap4Ptr(0, pVBInfo); /* Set Horizontal Scaling */
> -	for (i = 0x80, j = 0; i <= 0xBF; i++, j++)
> -		xgifb_reg_set(pVBInfo->Part2Port, i, Tap4TimingPtr->Reg[j]);
> -
> -	if ((pVBInfo->VBInfo & SetCRT2ToTV) &&
> -	    !(pVBInfo->VBInfo & SetCRT2ToHiVision)) {
> -		/* Set Vertical Scaling */
> -		Tap4TimingPtr = XGI_GetTap4Ptr(1, pVBInfo);
> -		for (i = 0xC0, j = 0; i < 0xFF; i++, j++)
> -			xgifb_reg_set(pVBInfo->Part2Port,
> -				      i,
> -				      Tap4TimingPtr->Reg[j]);
> -	}
> -
> -	if ((pVBInfo->VBInfo & SetCRT2ToTV) &&
> -	    !(pVBInfo->VBInfo & SetCRT2ToHiVision))
> -		/* Enable V.Scaling */
> -		xgifb_reg_and_or(pVBInfo->Part2Port, 0x4E, ~0x14, 0x04);
> -	else
> -		/* Enable H.Scaling */
> -		xgifb_reg_and_or(pVBInfo->Part2Port, 0x4E, ~0x14, 0x10);
> -}
> -
> -static void XGI_SetGroup3(unsigned short ModeIdIndex,
> -			  struct vb_device_info *pVBInfo)
> -{
> -	unsigned short i;
> -	unsigned char const *tempdi;
> -	unsigned short modeflag;
> -
> -	/* si+Ext_ResInfo */
> -	modeflag = XGI330_EModeIDTable[ModeIdIndex].Ext_ModeFlag;
> -
> -	xgifb_reg_set(pVBInfo->Part3Port, 0x00, 0x00);
> -	if (pVBInfo->TVInfo & TVSetPAL) {
> -		xgifb_reg_set(pVBInfo->Part3Port, 0x13, 0xFA);
> -		xgifb_reg_set(pVBInfo->Part3Port, 0x14, 0xC8);
> -	} else {
> -		xgifb_reg_set(pVBInfo->Part3Port, 0x13, 0xF5);
> -		xgifb_reg_set(pVBInfo->Part3Port, 0x14, 0xB7);
> -	}
> -
> -	if (!(pVBInfo->VBInfo & SetCRT2ToTV))
> -		return;
> -
> -	if (pVBInfo->TVInfo & TVSetPALM) {
> -		xgifb_reg_set(pVBInfo->Part3Port, 0x13, 0xFA);
> -		xgifb_reg_set(pVBInfo->Part3Port, 0x14, 0xC8);
> -		xgifb_reg_set(pVBInfo->Part3Port, 0x3D, 0xA8);
> -	}
> -
> -	if ((pVBInfo->VBInfo & SetCRT2ToHiVision) || (pVBInfo->VBInfo
> -			& SetCRT2ToYPbPr525750)) {
> -		if (pVBInfo->TVInfo & TVSetYPbPr525i)
> -			return;
> -
> -		tempdi = XGI330_HiTVGroup3Data;
> -		if (pVBInfo->SetFlag & TVSimuMode) {
> -			tempdi = XGI330_HiTVGroup3Simu;
> -			if (!(modeflag & Charx8Dot))
> -				tempdi = XGI330_HiTVGroup3Text;
> -		}
> -
> -		if (pVBInfo->TVInfo & TVSetYPbPr525p)
> -			tempdi = XGI330_Ren525pGroup3;
> -
> -		if (pVBInfo->TVInfo & TVSetYPbPr750p)
> -			tempdi = XGI330_Ren750pGroup3;
> -
> -		for (i = 0; i <= 0x3E; i++)
> -			xgifb_reg_set(pVBInfo->Part3Port, i, tempdi[i]);
> -
> -		if (pVBInfo->VBType & VB_XGI301C) { /* Marcovision */
> -			if (pVBInfo->TVInfo & TVSetYPbPr525p)
> -				xgifb_reg_set(pVBInfo->Part3Port, 0x28, 0x3f);
> -		}
> -	}
> -}
> -
> -static void XGI_SetGroup4(unsigned short ModeIdIndex,
> -			  unsigned short RefreshRateTableIndex,
> -			  struct vb_device_info *pVBInfo)
> -{
> -	unsigned short tempax, tempcx, tempbx, modeflag, temp, temp2;
> -
> -	unsigned long tempebx, tempeax, templong;
> -
> -	/* si+Ext_ResInfo */
> -	modeflag = XGI330_EModeIDTable[ModeIdIndex].Ext_ModeFlag;
> -	temp = pVBInfo->RVBHCFACT;
> -	xgifb_reg_set(pVBInfo->Part4Port, 0x13, temp);
> -
> -	tempbx = pVBInfo->RVBHCMAX;
> -	temp = tempbx & 0x00FF;
> -	xgifb_reg_set(pVBInfo->Part4Port, 0x14, temp);
> -	temp2 = ((tempbx & 0xFF00) >> 8) << 7;
> -	tempcx = pVBInfo->VGAHT - 1;
> -	temp = tempcx & 0x00FF;
> -	xgifb_reg_set(pVBInfo->Part4Port, 0x16, temp);
> -
> -	temp = ((tempcx & 0xFF00) >> 8) << 3;
> -	temp2 |= temp;
> -
> -	tempcx = pVBInfo->VGAVT - 1;
> -	if (!(pVBInfo->VBInfo & SetCRT2ToTV))
> -		tempcx -= 5;
> -
> -	temp = tempcx & 0x00FF;
> -	xgifb_reg_set(pVBInfo->Part4Port, 0x17, temp);
> -	temp = temp2 | ((tempcx & 0xFF00) >> 8);
> -	xgifb_reg_set(pVBInfo->Part4Port, 0x15, temp);
> -	xgifb_reg_or(pVBInfo->Part4Port, 0x0D, 0x08);
> -	tempcx = pVBInfo->VBInfo;
> -	tempbx = pVBInfo->VGAHDE;
> -
> -	if (modeflag & HalfDCLK)
> -		tempbx >>= 1;
> -
> -	if (XGI_IsLCDDualLink(pVBInfo))
> -		tempbx >>= 1;
> -
> -	if (tempcx & SetCRT2ToHiVision) {
> -		temp = 0;
> -		if (tempbx <= 1024)
> -			temp = 0xA0;
> -		if (tempbx == 1280)
> -			temp = 0xC0;
> -	} else if (tempcx & SetCRT2ToTV) {
> -		temp = 0xA0;
> -		if (tempbx <= 800)
> -			temp = 0x80;
> -	} else {
> -		temp = 0x80;
> -		if (pVBInfo->VBInfo & SetCRT2ToLCD) {
> -			temp = 0;
> -			if (tempbx > 800)
> -				temp = 0x60;
> -		}
> -	}
> -
> -	if (pVBInfo->TVInfo & (TVSetYPbPr525p | TVSetYPbPr750p)) {
> -		temp = 0x00;
> -		if (pVBInfo->VGAHDE == 1280)
> -			temp = 0x40;
> -		if (pVBInfo->VGAHDE == 1024)
> -			temp = 0x20;
> -	}
> -	xgifb_reg_and_or(pVBInfo->Part4Port, 0x0E, ~0xEF, temp);
> -
> -	tempebx = pVBInfo->VDE;
> -
> -	tempcx = pVBInfo->RVBHRS;
> -	temp = tempcx & 0x00FF;
> -	xgifb_reg_set(pVBInfo->Part4Port, 0x18, temp);
> -
> -	tempeax = pVBInfo->VGAVDE;
> -	tempcx |= 0x04000;
> -
> -	if (tempeax <= tempebx) {
> -		tempcx = tempcx & (~0x4000);
> -		tempeax = pVBInfo->VGAVDE;
> -	} else {
> -		tempeax -= tempebx;
> -	}
> -
> -	templong = (tempeax * 256 * 1024) % tempebx;
> -	tempeax = (tempeax * 256 * 1024) / tempebx;
> -	tempebx = tempeax;
> -
> -	if (templong != 0)
> -		tempebx++;
> -
> -	temp = (unsigned short)(tempebx & 0x000000FF);
> -	xgifb_reg_set(pVBInfo->Part4Port, 0x1B, temp);
> -
> -	temp = (unsigned short)((tempebx & 0x0000FF00) >> 8);
> -	xgifb_reg_set(pVBInfo->Part4Port, 0x1A, temp);
> -	tempbx = (unsigned short)(tempebx >> 16);
> -	temp = tempbx & 0x00FF;
> -	temp <<= 4;
> -	temp |= ((tempcx & 0xFF00) >> 8);
> -	xgifb_reg_set(pVBInfo->Part4Port, 0x19, temp);
> -
> -	/* 301b */
> -	if (pVBInfo->VBType & (VB_SIS301B | VB_SIS302B | VB_SIS301LV
> -			| VB_SIS302LV | VB_XGI301C)) {
> -		temp = 0x0028;
> -		xgifb_reg_set(pVBInfo->Part4Port, 0x1C, temp);
> -		tempax = pVBInfo->VGAHDE;
> -		if (modeflag & HalfDCLK)
> -			tempax >>= 1;
> -
> -		if (XGI_IsLCDDualLink(pVBInfo))
> -			tempax >>= 1;
> -
> -		if (pVBInfo->VBInfo & SetCRT2ToLCD) {
> -			if (tempax > 800)
> -				tempax -= 800;
> -		} else if (pVBInfo->VGAHDE > 800) {
> -			if (pVBInfo->VGAHDE == 1024)
> -				tempax = (tempax * 25 / 32) - 1;
> -			else
> -				tempax = (tempax * 20 / 32) - 1;
> -		}
> -		tempax -= 1;
> -
> -		temp = (tempax & 0xFF00) >> 8;
> -		temp = (temp & 0x0003) << 4;
> -		xgifb_reg_set(pVBInfo->Part4Port, 0x1E, temp);
> -		temp = tempax & 0x00FF;
> -		xgifb_reg_set(pVBInfo->Part4Port, 0x1D, temp);
> -
> -		if (pVBInfo->VBInfo & (SetCRT2ToTV | SetCRT2ToHiVision)) {
> -			if (pVBInfo->VGAHDE > 800)
> -				xgifb_reg_or(pVBInfo->Part4Port, 0x1E, 0x08);
> -		}
> -		temp = 0x0036;
> -
> -		if (pVBInfo->VBInfo & SetCRT2ToTV) {
> -			if (!(pVBInfo->TVInfo & (NTSC1024x768
> -					| TVSetYPbPr525p | TVSetYPbPr750p
> -					| TVSetHiVision))) {
> -				temp |= 0x0001;
> -				if ((pVBInfo->VBInfo & SetInSlaveMode) &&
> -				    !(pVBInfo->TVInfo & TVSimuMode))
> -					temp &= (~0x0001);
> -			}
> -		}
> -
> -		xgifb_reg_and_or(pVBInfo->Part4Port, 0x1F, 0x00C0, temp);
> -		tempbx = pVBInfo->HT;
> -		if (XGI_IsLCDDualLink(pVBInfo))
> -			tempbx >>= 1;
> -		tempbx = (tempbx >> 1) - 2;
> -		temp = ((tempbx & 0x0700) >> 8) << 3;
> -		xgifb_reg_and_or(pVBInfo->Part4Port, 0x21, 0x00C0, temp);
> -		temp = tempbx & 0x00FF;
> -		xgifb_reg_set(pVBInfo->Part4Port, 0x22, temp);
> -	}
> -	/* end 301b */
> -
> -	XGI_SetCRT2VCLK(ModeIdIndex, RefreshRateTableIndex, pVBInfo);
> -}
> -
> -static void XGINew_EnableCRT2(struct vb_device_info *pVBInfo)
> -{
> -	xgifb_reg_and_or(pVBInfo->P3c4, 0x1E, 0xFF, 0x20);
> -}
> -
> -static void XGI_SetGroup5(struct vb_device_info *pVBInfo)
> -{
> -	if (pVBInfo->ModeType == ModeVGA) {
> -		if (!(pVBInfo->VBInfo & (SetInSlaveMode | LoadDACFlag
> -				| DisableCRT2Display))) {
> -			XGINew_EnableCRT2(pVBInfo);
> -		}
> -	}
> -}
> -
> -static void XGI_DisableGatingCRT(struct vb_device_info *pVBInfo)
> -{
> -	xgifb_reg_and_or(pVBInfo->P3d4, 0x63, 0xBF, 0x00);
> -}
> -
> -static unsigned char XGI_XG21CheckLVDSMode(struct xgifb_video_info *xgifb_info,
> -					   unsigned short ModeNo,
> -					   unsigned short ModeIdIndex)
> -{
> -	unsigned short xres, yres, colordepth, modeflag, resindex;
> -
> -	resindex = XGI330_EModeIDTable[ModeIdIndex].Ext_RESINFO;
> -	xres = XGI330_ModeResInfo[resindex].HTotal; /* xres->ax */
> -	yres = XGI330_ModeResInfo[resindex].VTotal; /* yres->bx */
> -	/* si+St_ModeFlag */
> -	modeflag = XGI330_EModeIDTable[ModeIdIndex].Ext_ModeFlag;
> -
> -	if (!(modeflag & Charx8Dot)) {
> -		xres /= 9;
> -		xres *= 8;
> -	}
> -
> -	if ((ModeNo > 0x13) && (modeflag & HalfDCLK))
> -		xres *= 2;
> -
> -	if ((ModeNo > 0x13) && (modeflag & DoubleScanMode))
> -		yres *= 2;
> -
> -	if (xres > xgifb_info->lvds_data.LVDSHDE)
> -		return 0;
> -
> -	if (yres > xgifb_info->lvds_data.LVDSVDE)
> -		return 0;
> -
> -	if (xres != xgifb_info->lvds_data.LVDSHDE ||
> -	    yres != xgifb_info->lvds_data.LVDSVDE) {
> -		colordepth = XGI_GetColorDepth(ModeIdIndex);
> -		if (colordepth > 2)
> -			return 0;
> -	}
> -	return 1;
> -}
> -
> -static void xgifb_set_lvds(struct xgifb_video_info *xgifb_info,
> -			   int chip_id,
> -			   unsigned short ModeIdIndex,
> -			   struct vb_device_info *pVBInfo)
> -{
> -	unsigned char temp, Miscdata;
> -	unsigned short xres, yres, modeflag, resindex;
> -	unsigned short LVDSHT, LVDSHBS, LVDSHRS, LVDSHRE, LVDSHBE;
> -	unsigned short LVDSVT, LVDSVBS, LVDSVRS, LVDSVRE, LVDSVBE;
> -	unsigned short value;
> -
> -	temp = (unsigned char)((xgifb_info->lvds_data.LVDS_Capability &
> -				(LCDPolarity << 8)) >> 8);
> -	temp &= LCDPolarity;
> -	Miscdata = inb(pVBInfo->P3cc);
> -
> -	outb((Miscdata & 0x3F) | temp, pVBInfo->P3c2);
> -
> -	temp = xgifb_info->lvds_data.LVDS_Capability & LCDPolarity;
> -	/* SR35[7] FP VSync polarity */
> -	xgifb_reg_and_or(pVBInfo->P3c4, 0x35, ~0x80, temp & 0x80);
> -	/* SR30[5] FP HSync polarity */
> -	xgifb_reg_and_or(pVBInfo->P3c4, 0x30, ~0x20, (temp & 0x40) >> 1);
> -
> -	if (chip_id == XG27)
> -		XGI_SetXG27FPBits(pVBInfo);
> -	else
> -		XGI_SetXG21FPBits(pVBInfo);
> -
> -	resindex = XGI330_EModeIDTable[ModeIdIndex].Ext_RESINFO;
> -	xres = XGI330_ModeResInfo[resindex].HTotal; /* xres->ax */
> -	yres = XGI330_ModeResInfo[resindex].VTotal; /* yres->bx */
> -	/* si+St_ModeFlag */
> -	modeflag = XGI330_EModeIDTable[ModeIdIndex].Ext_ModeFlag;
> -
> -	if (!(modeflag & Charx8Dot))
> -		xres = xres * 8 / 9;
> -
> -	LVDSHT = xgifb_info->lvds_data.LVDSHT;
> -
> -	LVDSHBS = xres + (xgifb_info->lvds_data.LVDSHDE - xres) / 2;
> -
> -	if (LVDSHBS > LVDSHT)
> -		LVDSHBS -= LVDSHT;
> -
> -	LVDSHRS = LVDSHBS + xgifb_info->lvds_data.LVDSHFP;
> -	if (LVDSHRS > LVDSHT)
> -		LVDSHRS -= LVDSHT;
> -
> -	LVDSHRE = LVDSHRS + xgifb_info->lvds_data.LVDSHSYNC;
> -	if (LVDSHRE > LVDSHT)
> -		LVDSHRE -= LVDSHT;
> -
> -	LVDSHBE = LVDSHBS + LVDSHT - xgifb_info->lvds_data.LVDSHDE;
> -
> -	LVDSVT = xgifb_info->lvds_data.LVDSVT;
> -
> -	LVDSVBS = yres + (xgifb_info->lvds_data.LVDSVDE - yres) / 2;
> -	if (modeflag & DoubleScanMode)
> -		LVDSVBS += yres / 2;
> -
> -	if (LVDSVBS > LVDSVT)
> -		LVDSVBS -= LVDSVT;
> -
> -	LVDSVRS = LVDSVBS + xgifb_info->lvds_data.LVDSVFP;
> -	if (LVDSVRS > LVDSVT)
> -		LVDSVRS -= LVDSVT;
> -
> -	LVDSVRE = LVDSVRS + xgifb_info->lvds_data.LVDSVSYNC;
> -	if (LVDSVRE > LVDSVT)
> -		LVDSVRE -= LVDSVT;
> -
> -	LVDSVBE = LVDSVBS + LVDSVT - xgifb_info->lvds_data.LVDSVDE;
> -
> -	temp = xgifb_reg_get(pVBInfo->P3d4, 0x11);
> -	xgifb_reg_set(pVBInfo->P3d4, 0x11, temp & 0x7f); /* Unlock CRTC */
> -
> -	if (!(modeflag & Charx8Dot))
> -		xgifb_reg_or(pVBInfo->P3c4, 0x1, 0x1);
> -
> -	/* HT SR0B[1:0] CR00 */
> -	value = (LVDSHT >> 3) - 5;
> -	xgifb_reg_and_or(pVBInfo->P3c4, 0x0B, ~0x03, (value & 0x300) >> 8);
> -	xgifb_reg_set(pVBInfo->P3d4, 0x0, (value & 0xFF));
> -
> -	/* HBS SR0B[5:4] CR02 */
> -	value = (LVDSHBS >> 3) - 1;
> -	xgifb_reg_and_or(pVBInfo->P3c4, 0x0B, ~0x30, (value & 0x300) >> 4);
> -	xgifb_reg_set(pVBInfo->P3d4, 0x2, (value & 0xFF));
> -
> -	/* HBE SR0C[1:0] CR05[7] CR03[4:0] */
> -	value = (LVDSHBE >> 3) - 1;
> -	xgifb_reg_and_or(pVBInfo->P3c4, 0x0C, ~0x03, (value & 0xC0) >> 6);
> -	xgifb_reg_and_or(pVBInfo->P3d4, 0x05, ~0x80, (value & 0x20) << 2);
> -	xgifb_reg_and_or(pVBInfo->P3d4, 0x03, ~0x1F, value & 0x1F);
> -
> -	/* HRS SR0B[7:6] CR04 */
> -	value = (LVDSHRS >> 3) + 2;
> -	xgifb_reg_and_or(pVBInfo->P3c4, 0x0B, ~0xC0, (value & 0x300) >> 2);
> -	xgifb_reg_set(pVBInfo->P3d4, 0x4, (value & 0xFF));
> -
> -	/* Panel HRS SR2F[1:0] SR2E[7:0]  */
> -	value--;
> -	xgifb_reg_and_or(pVBInfo->P3c4, 0x2F, ~0x03, (value & 0x300) >> 8);
> -	xgifb_reg_set(pVBInfo->P3c4, 0x2E, (value & 0xFF));
> -
> -	/* HRE SR0C[2] CR05[4:0] */
> -	value = (LVDSHRE >> 3) + 2;
> -	xgifb_reg_and_or(pVBInfo->P3c4, 0x0C, ~0x04, (value & 0x20) >> 3);
> -	xgifb_reg_and_or(pVBInfo->P3d4, 0x05, ~0x1F, value & 0x1F);
> -
> -	/* Panel HRE SR2F[7:2]  */
> -	value--;
> -	xgifb_reg_and_or(pVBInfo->P3c4, 0x2F, ~0xFC, value << 2);
> -
> -	/* VT SR0A[0] CR07[5][0] CR06 */
> -	value = LVDSVT - 2;
> -	xgifb_reg_and_or(pVBInfo->P3c4, 0x0A, ~0x01, (value & 0x400) >> 10);
> -	xgifb_reg_and_or(pVBInfo->P3d4, 0x07, ~0x20, (value & 0x200) >> 4);
> -	xgifb_reg_and_or(pVBInfo->P3d4, 0x07, ~0x01, (value & 0x100) >> 8);
> -	xgifb_reg_set(pVBInfo->P3d4, 0x06, (value & 0xFF));
> -
> -	/* VBS SR0A[2] CR09[5] CR07[3] CR15 */
> -	value = LVDSVBS - 1;
> -	xgifb_reg_and_or(pVBInfo->P3c4, 0x0A, ~0x04, (value & 0x400) >> 8);
> -	xgifb_reg_and_or(pVBInfo->P3d4, 0x09, ~0x20, (value & 0x200) >> 4);
> -	xgifb_reg_and_or(pVBInfo->P3d4, 0x07, ~0x08, (value & 0x100) >> 5);
> -	xgifb_reg_set(pVBInfo->P3d4, 0x15, (value & 0xFF));
> -
> -	/* VBE SR0A[4] CR16 */
> -	value = LVDSVBE - 1;
> -	xgifb_reg_and_or(pVBInfo->P3c4, 0x0A, ~0x10, (value & 0x100) >> 4);
> -	xgifb_reg_set(pVBInfo->P3d4, 0x16, (value & 0xFF));
> -
> -	/* VRS SR0A[3] CR7[7][2] CR10 */
> -	value = LVDSVRS - 1;
> -	xgifb_reg_and_or(pVBInfo->P3c4, 0x0A, ~0x08, (value & 0x400) >> 7);
> -	xgifb_reg_and_or(pVBInfo->P3d4, 0x07, ~0x80, (value & 0x200) >> 2);
> -	xgifb_reg_and_or(pVBInfo->P3d4, 0x07, ~0x04, (value & 0x100) >> 6);
> -	xgifb_reg_set(pVBInfo->P3d4, 0x10, (value & 0xFF));
> -
> -	if (chip_id == XG27) {
> -		/* Panel VRS SR35[2:0] SR34[7:0] */
> -		xgifb_reg_and_or(pVBInfo->P3c4, 0x35, ~0x07,
> -				 (value & 0x700) >> 8);
> -		xgifb_reg_set(pVBInfo->P3c4, 0x34, value & 0xFF);
> -	} else {
> -		/* Panel VRS SR3F[1:0] SR34[7:0] SR33[0] */
> -		xgifb_reg_and_or(pVBInfo->P3c4, 0x3F, ~0x03,
> -				 (value & 0x600) >> 9);
> -		xgifb_reg_set(pVBInfo->P3c4, 0x34, (value >> 1) & 0xFF);
> -		xgifb_reg_and_or(pVBInfo->P3d4, 0x33, ~0x01, value & 0x01);
> -	}
> -
> -	/* VRE SR0A[5] CR11[3:0] */
> -	value = LVDSVRE - 1;
> -	xgifb_reg_and_or(pVBInfo->P3c4, 0x0A, ~0x20, (value & 0x10) << 1);
> -	xgifb_reg_and_or(pVBInfo->P3d4, 0x11, ~0x0F, value & 0x0F);
> -
> -	/* Panel VRE SR3F[7:2] */
> -	if (chip_id == XG27)
> -		xgifb_reg_and_or(pVBInfo->P3c4, 0x3F, ~0xFC,
> -				 (value << 2) & 0xFC);
> -	else
> -		/* SR3F[7] has to be 0, h/w bug */
> -		xgifb_reg_and_or(pVBInfo->P3c4, 0x3F, ~0xFC,
> -				 (value << 2) & 0x7C);
> -
> -	for (temp = 0, value = 0; temp < 3; temp++) {
> -		xgifb_reg_and_or(pVBInfo->P3c4, 0x31, ~0x30, value);
> -		xgifb_reg_set(pVBInfo->P3c4,
> -			      0x2B, xgifb_info->lvds_data.VCLKData1);
> -		xgifb_reg_set(pVBInfo->P3c4,
> -			      0x2C, xgifb_info->lvds_data.VCLKData2);
> -		value += 0x10;
> -	}
> -
> -	if (!(modeflag & Charx8Dot)) {
> -		inb(pVBInfo->P3da); /* reset 3da */
> -		outb(0x13, pVBInfo->P3c0); /* set index */
> -		/* set data, panning = 0, shift left 1 dot*/
> -		outb(0x00, pVBInfo->P3c0);
> -
> -		inb(pVBInfo->P3da); /* Enable Attribute */
> -		outb(0x20, pVBInfo->P3c0);
> -
> -		inb(pVBInfo->P3da); /* reset 3da */
> -	}
> -}
> -
> -/*
> - * Function : XGI_IsLCDON
> - * Input :
> - * Output : 0 : Skip PSC Control
> - * 1: Disable PSC
> - * Description :
> - */
> -static unsigned char XGI_IsLCDON(struct vb_device_info *pVBInfo)
> -{
> -	unsigned short tempax;
> -
> -	tempax = pVBInfo->VBInfo;
> -	if (tempax & SetCRT2ToDualEdge)
> -		return 0;
> -	else if (tempax & (DisableCRT2Display | SwitchCRT2 | SetSimuScanMode))
> -		return 1;
> -
> -	return 0;
> -}
> -
> -static void XGI_DisableBridge(struct xgifb_video_info *xgifb_info,
> -			      struct xgi_hw_device_info *HwDeviceExtension,
> -			      struct vb_device_info *pVBInfo)
> -{
> -	unsigned short tempah = 0;
> -
> -	if (pVBInfo->VBType & (VB_SIS301B | VB_SIS302B | VB_SIS301LV
> -			| VB_SIS302LV | VB_XGI301C)) {
> -		tempah = 0x3F;
> -		if (!(pVBInfo->VBInfo &
> -		    (DisableCRT2Display | SetSimuScanMode))) {
> -			if (pVBInfo->VBInfo & XGI_SetCRT2ToLCDA) {
> -				if (pVBInfo->VBInfo & SetCRT2ToDualEdge)
> -					tempah = 0x7F; /* Disable Channel A */
> -			}
> -		}
> -
> -		/* disable part4_1f */
> -		xgifb_reg_and(pVBInfo->Part4Port, 0x1F, tempah);
> -
> -		if (pVBInfo->VBType & (VB_SIS302LV | VB_XGI301C)) {
> -			if (((pVBInfo->VBInfo &
> -			      (SetCRT2ToLCD | XGI_SetCRT2ToLCDA))) ||
> -				(XGI_IsLCDON(pVBInfo)))
> -				/* LVDS Driver power down */
> -				xgifb_reg_or(pVBInfo->Part4Port, 0x30, 0x80);
> -		}
> -
> -		if (pVBInfo->VBInfo & (DisableCRT2Display | XGI_SetCRT2ToLCDA |
> -				       SetSimuScanMode))
> -			XGI_DisplayOff(xgifb_info, HwDeviceExtension, pVBInfo);
> -
> -		if (pVBInfo->VBInfo & XGI_SetCRT2ToLCDA)
> -			/* Power down */
> -			xgifb_reg_and(pVBInfo->Part1Port, 0x1e, 0xdf);
> -
> -		/* disable TV as primary VGA swap */
> -		xgifb_reg_and(pVBInfo->P3c4, 0x32, 0xdf);
> -
> -		if ((pVBInfo->VBInfo & (SetSimuScanMode | SetCRT2ToDualEdge)))
> -			xgifb_reg_and(pVBInfo->Part2Port, 0x00, 0xdf);
> -
> -		if ((pVBInfo->VBInfo &
> -			(DisableCRT2Display | SetSimuScanMode)) ||
> -		    (!(pVBInfo->VBInfo & XGI_SetCRT2ToLCDA) &&
> -		    (pVBInfo->VBInfo &
> -			(SetCRT2ToRAMDAC | SetCRT2ToLCD | SetCRT2ToTV))))
> -			xgifb_reg_or(pVBInfo->Part1Port, 0x00, 0x80);
> -
> -		if ((pVBInfo->VBInfo &
> -			(DisableCRT2Display | SetSimuScanMode)) ||
> -		    (!(pVBInfo->VBInfo & XGI_SetCRT2ToLCDA)) ||
> -		    (pVBInfo->VBInfo &
> -			(SetCRT2ToRAMDAC | SetCRT2ToLCD | SetCRT2ToTV))) {
> -			/* save Part1 index 0 */
> -			tempah = xgifb_reg_get(pVBInfo->Part1Port, 0x00);
> -			/* BTDAC = 1, avoid VB reset */
> -			xgifb_reg_or(pVBInfo->Part1Port, 0x00, 0x10);
> -			/* disable CRT2 */
> -			xgifb_reg_and(pVBInfo->Part1Port, 0x1E, 0xDF);
> -			/* restore Part1 index 0 */
> -			xgifb_reg_set(pVBInfo->Part1Port, 0x00, tempah);
> -		}
> -	} else { /* {301} */
> -		if (pVBInfo->VBInfo & (SetCRT2ToLCD | SetCRT2ToTV)) {
> -			xgifb_reg_or(pVBInfo->Part1Port, 0x00, 0x80);
> -			/* Disable CRT2 */
> -			xgifb_reg_and(pVBInfo->Part1Port, 0x1E, 0xDF);
> -			/* Disable TV asPrimary VGA swap */
> -			xgifb_reg_and(pVBInfo->P3c4, 0x32, 0xDF);
> -		}
> -
> -		if (pVBInfo->VBInfo & (DisableCRT2Display | XGI_SetCRT2ToLCDA
> -				| SetSimuScanMode))
> -			XGI_DisplayOff(xgifb_info, HwDeviceExtension, pVBInfo);
> -	}
> -}
> -
> -/*
> - * Function : XGI_GetTVPtrIndex
> - * Input :
> - * Output :
> - * Description : bx 0 : ExtNTSC
> - * 1 : StNTSC
> - * 2 : ExtPAL
> - * 3 : StPAL
> - * 4 : ExtHiTV
> - * 5 : StHiTV
> - * 6 : Ext525i
> - * 7 : St525i
> - * 8 : Ext525p
> - * 9 : St525p
> - * A : Ext750p
> - * B : St750p
> - */
> -static unsigned short XGI_GetTVPtrIndex(struct vb_device_info *pVBInfo)
> -{
> -	unsigned short tempbx = 0;
> -
> -	if (pVBInfo->TVInfo & TVSetPAL)
> -		tempbx = 2;
> -	if (pVBInfo->TVInfo & TVSetHiVision)
> -		tempbx = 4;
> -	if (pVBInfo->TVInfo & TVSetYPbPr525i)
> -		tempbx = 6;
> -	if (pVBInfo->TVInfo & TVSetYPbPr525p)
> -		tempbx = 8;
> -	if (pVBInfo->TVInfo & TVSetYPbPr750p)
> -		tempbx = 10;
> -	if (pVBInfo->TVInfo & TVSimuMode)
> -		tempbx++;
> -
> -	return tempbx;
> -}
> -
> -/*
> - * Function : XGI_GetTVPtrIndex2
> - * Input :
> - * Output : bx 0 : NTSC
> - * 1 : PAL
> - * 2 : PALM
> - * 3 : PALN
> - * 4 : NTSC1024x768
> - * 5 : PAL-M 1024x768
> - * 6-7: reserved
> - * cl 0 : YFilter1
> - * 1 : YFilter2
> - * ch 0 : 301A
> - * 1 : 301B/302B/301LV/302LV
> - * Description :
> - */
> -static void XGI_GetTVPtrIndex2(unsigned short *tempbx,
> -			       unsigned char *tempcl,
> -			       unsigned char *tempch,
> -			       struct vb_device_info *pVBInfo)
> -{
> -	*tempbx = 0;
> -	*tempcl = 0;
> -	*tempch = 0;
> -
> -	if (pVBInfo->TVInfo & TVSetPAL)
> -		*tempbx = 1;
> -
> -	if (pVBInfo->TVInfo & TVSetPALM)
> -		*tempbx = 2;
> -
> -	if (pVBInfo->TVInfo & TVSetPALN)
> -		*tempbx = 3;
> -
> -	if (pVBInfo->TVInfo & NTSC1024x768) {
> -		*tempbx = 4;
> -		if (pVBInfo->TVInfo & TVSetPALM)
> -			*tempbx = 5;
> -	}
> -
> -	if (pVBInfo->VBType & (VB_SIS301B | VB_SIS302B | VB_SIS301LV
> -			| VB_SIS302LV | VB_XGI301C)) {
> -		if (!(pVBInfo->VBInfo & SetInSlaveMode) || (pVBInfo->TVInfo
> -				& TVSimuMode)) {
> -			*tempbx += 8;
> -			*tempcl += 1;
> -		}
> -	}
> -
> -	if (pVBInfo->VBType & (VB_SIS301B | VB_SIS302B | VB_SIS301LV
> -			| VB_SIS302LV | VB_XGI301C))
> -		(*tempch)++;
> -}
> -
> -static void XGI_SetDelayComp(struct vb_device_info *pVBInfo)
> -{
> -	unsigned char tempah, tempbl, tempbh;
> -
> -	if (pVBInfo->VBType & (VB_SIS301B | VB_SIS302B | VB_SIS301LV
> -			| VB_SIS302LV | VB_XGI301C)) {
> -		if (pVBInfo->VBInfo & (SetCRT2ToLCD | XGI_SetCRT2ToLCDA
> -				| SetCRT2ToTV | SetCRT2ToRAMDAC)) {
> -			tempbh = 0;
> -			tempbl = XGI301TVDelay;
> -
> -			if (pVBInfo->VBInfo & SetCRT2ToDualEdge)
> -				tempbl >>= 4;
> -			if (pVBInfo->VBInfo &
> -			    (SetCRT2ToLCD | XGI_SetCRT2ToLCDA)) {
> -				tempbh = XGI301LCDDelay;
> -
> -				if (!(pVBInfo->VBInfo & XGI_SetCRT2ToLCDA))
> -					tempbl = tempbh;
> -			}
> -
> -			tempbl &= 0x0F;
> -			tempbh &= 0xF0;
> -			tempah = xgifb_reg_get(pVBInfo->Part1Port, 0x2D);
> -
> -			if (pVBInfo->VBInfo & (SetCRT2ToRAMDAC | SetCRT2ToLCD
> -					| SetCRT2ToTV)) { /* Channel B */
> -				tempah &= 0xF0;
> -				tempah |= tempbl;
> -			}
> -
> -			if (pVBInfo->VBInfo & XGI_SetCRT2ToLCDA) {
> -				/* Channel A */
> -				tempah &= 0x0F;
> -				tempah |= tempbh;
> -			}
> -			xgifb_reg_set(pVBInfo->Part1Port, 0x2D, tempah);
> -		}
> -	}
> -}
> -
> -static void XGI_SetLCDCap_A(unsigned short tempcx,
> -			    struct vb_device_info *pVBInfo)
> -{
> -	unsigned short temp;
> -
> -	temp = xgifb_reg_get(pVBInfo->P3d4, 0x37);
> -
> -	if (temp & LCDRGB18Bit) {
> -		xgifb_reg_and_or(pVBInfo->Part1Port, 0x19, 0x0F,
> -				 /* Enable Dither */
> -				 (unsigned short)(0x20 | (tempcx & 0x00C0)));
> -		xgifb_reg_and_or(pVBInfo->Part1Port, 0x1A, 0x7F, 0x80);
> -	} else {
> -		xgifb_reg_and_or(pVBInfo->Part1Port, 0x19, 0x0F,
> -				 (unsigned short)(0x30 | (tempcx & 0x00C0)));
> -		xgifb_reg_and_or(pVBInfo->Part1Port, 0x1A, 0x7F, 0x00);
> -	}
> -}
> -
> -/*
> - * Function : XGI_SetLCDCap_B
> - * Input : cx -> LCD Capability
> - * Output :
> - * Description :
> - */
> -static void XGI_SetLCDCap_B(unsigned short tempcx,
> -			    struct vb_device_info *pVBInfo)
> -{
> -	if (tempcx & EnableLCD24bpp) { /* 24bits */
> -		xgifb_reg_and_or(pVBInfo->Part2Port, 0x1A, 0xE0,
> -				 (unsigned short)(((tempcx & 0x00ff) >> 6) | 0x0c));
> -	} else {
> -		xgifb_reg_and_or(pVBInfo->Part2Port, 0x1A, 0xE0,
> -				 (unsigned short)(((tempcx & 0x00ff) >> 6) | 0x18));
> -				  /* Enable Dither */
> -	}
> -}
> -
> -static void XGI_LongWait(struct vb_device_info *pVBInfo)
> -{
> -	unsigned short i;
> -
> -	i = xgifb_reg_get(pVBInfo->P3c4, 0x1F);
> -
> -	if (!(i & 0xC0)) {
> -		for (i = 0; i < 0xFFFF; i++) {
> -			if (!(inb(pVBInfo->P3da) & 0x08))
> -				break;
> -		}
> -
> -		for (i = 0; i < 0xFFFF; i++) {
> -			if ((inb(pVBInfo->P3da) & 0x08))
> -				break;
> -		}
> -	}
> -}
> -
> -static void SetSpectrum(struct vb_device_info *pVBInfo)
> -{
> -	unsigned short index;
> -
> -	index = XGI_GetLCDCapPtr(pVBInfo);
> -
> -	/* disable down spectrum D[4] */
> -	xgifb_reg_and(pVBInfo->Part4Port, 0x30, 0x8F);
> -	XGI_LongWait(pVBInfo);
> -	xgifb_reg_or(pVBInfo->Part4Port, 0x30, 0x20); /* reset spectrum */
> -	XGI_LongWait(pVBInfo);
> -
> -	xgifb_reg_set(pVBInfo->Part4Port, 0x31,
> -		      pVBInfo->LCDCapList[index].Spectrum_31);
> -	xgifb_reg_set(pVBInfo->Part4Port, 0x32,
> -		      pVBInfo->LCDCapList[index].Spectrum_32);
> -	xgifb_reg_set(pVBInfo->Part4Port, 0x33,
> -		      pVBInfo->LCDCapList[index].Spectrum_33);
> -	xgifb_reg_set(pVBInfo->Part4Port, 0x34,
> -		      pVBInfo->LCDCapList[index].Spectrum_34);
> -	XGI_LongWait(pVBInfo);
> -	xgifb_reg_or(pVBInfo->Part4Port, 0x30, 0x40); /* enable spectrum */
> -}
> -
> -static void XGI_SetLCDCap(struct vb_device_info *pVBInfo)
> -{
> -	unsigned short tempcx;
> -
> -	tempcx = pVBInfo->LCDCapList[XGI_GetLCDCapPtr(pVBInfo)].LCD_Capability;
> -
> -	if (pVBInfo->VBType & (VB_SIS301B | VB_SIS302B | VB_SIS301LV |
> -		VB_SIS302LV | VB_XGI301C)) {
> -		if (pVBInfo->VBType &
> -		    (VB_SIS301LV | VB_SIS302LV | VB_XGI301C)) {
> -			/* Set 301LV Capability */
> -			xgifb_reg_set(pVBInfo->Part4Port, 0x24,
> -				      (unsigned char)(tempcx & 0x1F));
> -		}
> -		/* VB Driving */
> -		xgifb_reg_and_or(pVBInfo->Part4Port, 0x0D,
> -				 ~((EnableVBCLKDRVLOW | EnablePLLSPLOW) >> 8),
> -				 (unsigned short)((tempcx & (EnableVBCLKDRVLOW |
> -				 EnablePLLSPLOW)) >> 8));
> -
> -		if (pVBInfo->VBInfo & SetCRT2ToLCD)
> -			XGI_SetLCDCap_B(tempcx, pVBInfo);
> -		else if (pVBInfo->VBInfo & XGI_SetCRT2ToLCDA)
> -			XGI_SetLCDCap_A(tempcx, pVBInfo);
> -
> -		if (pVBInfo->VBType & (VB_SIS302LV | VB_XGI301C)) {
> -			if (tempcx & EnableSpectrum)
> -				SetSpectrum(pVBInfo);
> -		}
> -	} else {
> -		/* LVDS,CH7017 */
> -		XGI_SetLCDCap_A(tempcx, pVBInfo);
> -	}
> -}
> -
> -/*
> - * Function : XGI_SetAntiFlicker
> - * Input :
> - * Output :
> - * Description : Set TV Customized Param.
> - */
> -static void XGI_SetAntiFlicker(struct vb_device_info *pVBInfo)
> -{
> -	unsigned short tempbx;
> -
> -	unsigned char tempah;
> -
> -	if (pVBInfo->TVInfo & (TVSetYPbPr525p | TVSetYPbPr750p))
> -		return;
> -
> -	tempbx = XGI_GetTVPtrIndex(pVBInfo);
> -	tempbx &= 0xFE;
> -	tempah = TVAntiFlickList[tempbx];
> -	tempah <<= 4;
> -
> -	xgifb_reg_and_or(pVBInfo->Part2Port, 0x0A, 0x8F, tempah);
> -}
> -
> -static void XGI_SetEdgeEnhance(struct vb_device_info *pVBInfo)
> -{
> -	unsigned short tempbx;
> -
> -	unsigned char tempah;
> -
> -	tempbx = XGI_GetTVPtrIndex(pVBInfo);
> -	tempbx &= 0xFE;
> -	tempah = TVEdgeList[tempbx];
> -	tempah <<= 5;
> -
> -	xgifb_reg_and_or(pVBInfo->Part2Port, 0x3A, 0x1F, tempah);
> -}
> -
> -static void XGI_SetPhaseIncr(struct vb_device_info *pVBInfo)
> -{
> -	unsigned short tempbx;
> -
> -	unsigned char tempcl, tempch;
> -
> -	unsigned long tempData;
> -
> -	XGI_GetTVPtrIndex2(&tempbx, &tempcl, &tempch, pVBInfo); /* bx, cl, ch */
> -	tempData = TVPhaseList[tempbx];
> -
> -	xgifb_reg_set(pVBInfo->Part2Port, 0x31, (unsigned short)(tempData
> -			& 0x000000FF));
> -	xgifb_reg_set(pVBInfo->Part2Port, 0x32, (unsigned short)((tempData
> -			& 0x0000FF00) >> 8));
> -	xgifb_reg_set(pVBInfo->Part2Port, 0x33, (unsigned short)((tempData
> -			& 0x00FF0000) >> 16));
> -	xgifb_reg_set(pVBInfo->Part2Port, 0x34, (unsigned short)((tempData
> -			& 0xFF000000) >> 24));
> -}
> -
> -static void XGI_SetYFilter(unsigned short ModeIdIndex,
> -			   struct vb_device_info *pVBInfo)
> -{
> -	unsigned short tempbx, index;
> -	unsigned char const *filterPtr;
> -	unsigned char tempcl, tempch, tempal;
> -
> -	XGI_GetTVPtrIndex2(&tempbx, &tempcl, &tempch, pVBInfo); /* bx, cl, ch */
> -
> -	switch (tempbx) {
> -	case 0x00:
> -	case 0x04:
> -		filterPtr = NTSCYFilter1;
> -		break;
> -
> -	case 0x01:
> -		filterPtr = PALYFilter1;
> -		break;
> -
> -	case 0x02:
> -	case 0x05:
> -	case 0x0D:
> -	case 0x03:
> -		filterPtr = xgifb_palmn_yfilter1;
> -		break;
> -
> -	case 0x08:
> -	case 0x0C:
> -	case 0x0A:
> -	case 0x0B:
> -	case 0x09:
> -		filterPtr = xgifb_yfilter2;
> -		break;
> -
> -	default:
> -		return;
> -	}
> -
> -	tempal = XGI330_EModeIDTable[ModeIdIndex].VB_ExtTVYFilterIndex;
> -	if (tempcl == 0)
> -		index = tempal * 4;
> -	else
> -		index = tempal * 7;
> -
> -	if ((tempcl == 0) && (tempch == 1)) {
> -		xgifb_reg_set(pVBInfo->Part2Port, 0x35, 0);
> -		xgifb_reg_set(pVBInfo->Part2Port, 0x36, 0);
> -		xgifb_reg_set(pVBInfo->Part2Port, 0x37, 0);
> -		xgifb_reg_set(pVBInfo->Part2Port, 0x38, filterPtr[index++]);
> -	} else {
> -		xgifb_reg_set(pVBInfo->Part2Port, 0x35, filterPtr[index++]);
> -		xgifb_reg_set(pVBInfo->Part2Port, 0x36, filterPtr[index++]);
> -		xgifb_reg_set(pVBInfo->Part2Port, 0x37, filterPtr[index++]);
> -		xgifb_reg_set(pVBInfo->Part2Port, 0x38, filterPtr[index++]);
> -	}
> -
> -	if (pVBInfo->VBType & (VB_SIS301B | VB_SIS302B | VB_SIS301LV
> -			| VB_SIS302LV | VB_XGI301C)) {
> -		xgifb_reg_set(pVBInfo->Part2Port, 0x48, filterPtr[index++]);
> -		xgifb_reg_set(pVBInfo->Part2Port, 0x49, filterPtr[index++]);
> -		xgifb_reg_set(pVBInfo->Part2Port, 0x4A, filterPtr[index++]);
> -	}
> -}
> -
> -/*
> - * Function : XGI_OEM310Setting
> - * Input :
> - * Output :
> - * Description : Customized Param. for 301
> - */
> -static void XGI_OEM310Setting(unsigned short ModeIdIndex,
> -			      struct vb_device_info *pVBInfo)
> -{
> -	XGI_SetDelayComp(pVBInfo);
> -
> -	if (pVBInfo->VBInfo & (SetCRT2ToLCD | XGI_SetCRT2ToLCDA))
> -		XGI_SetLCDCap(pVBInfo);
> -
> -	if (pVBInfo->VBInfo & SetCRT2ToTV) {
> -		XGI_SetPhaseIncr(pVBInfo);
> -		XGI_SetYFilter(ModeIdIndex, pVBInfo);
> -		XGI_SetAntiFlicker(pVBInfo);
> -
> -		if (pVBInfo->VBType & VB_SIS301)
> -			XGI_SetEdgeEnhance(pVBInfo);
> -	}
> -}
> -
> -/*
> - * Function : XGI_SetCRT2ModeRegs
> - * Input :
> - * Output :
> - * Description : Origin code for crt2group
> - */
> -static void XGI_SetCRT2ModeRegs(struct vb_device_info *pVBInfo)
> -{
> -	unsigned short tempbl;
> -	short tempcl;
> -
> -	unsigned char tempah;
> -
> -	tempah = 0;
> -	if (!(pVBInfo->VBInfo & DisableCRT2Display)) {
> -		tempah = xgifb_reg_get(pVBInfo->Part1Port, 0x00);
> -		tempah &= ~0x10; /* BTRAMDAC */
> -		tempah |= 0x40; /* BTRAM */
> -
> -		if (pVBInfo->VBInfo & (SetCRT2ToRAMDAC | SetCRT2ToTV
> -				| SetCRT2ToLCD)) {
> -			tempah = 0x40; /* BTDRAM */
> -			tempcl = pVBInfo->ModeType;
> -			tempcl -= ModeVGA;
> -			if (tempcl >= 0) {
> -				/* BT Color */
> -				tempah = 0x008 >> tempcl;
> -				if (tempah == 0)
> -					tempah = 1;
> -				tempah |= 0x040;
> -			}
> -			if (pVBInfo->VBInfo & SetInSlaveMode)
> -				tempah ^= 0x50; /* BTDAC */
> -		}
> -	}
> -
> -	xgifb_reg_set(pVBInfo->Part1Port, 0x00, tempah);
> -	tempah = 0x08;
> -	tempbl = 0xf0;
> -
> -	if (pVBInfo->VBInfo & DisableCRT2Display)
> -		goto reg_and_or;
> -
> -	tempah = 0x00;
> -	tempbl = 0xff;
> -
> -	if (!(pVBInfo->VBInfo & (SetCRT2ToRAMDAC | SetCRT2ToTV |
> -				 SetCRT2ToLCD | XGI_SetCRT2ToLCDA)))
> -		goto reg_and_or;
> -
> -	if ((pVBInfo->VBInfo & XGI_SetCRT2ToLCDA) &&
> -	    (!(pVBInfo->VBInfo & SetSimuScanMode))) {
> -		tempbl &= 0xf7;
> -		tempah |= 0x01;
> -		goto reg_and_or;
> -	}
> -
> -	if (pVBInfo->VBInfo & XGI_SetCRT2ToLCDA) {
> -		tempbl &= 0xf7;
> -		tempah |= 0x01;
> -	}
> -
> -	if (!(pVBInfo->VBInfo & (SetCRT2ToRAMDAC | SetCRT2ToTV | SetCRT2ToLCD)))
> -		goto reg_and_or;
> -
> -	tempbl &= 0xf8;
> -	tempah = 0x01;
> -
> -	if (!(pVBInfo->VBInfo & SetInSlaveMode))
> -		tempah |= 0x02;
> -
> -	if (!(pVBInfo->VBInfo & SetCRT2ToRAMDAC)) {
> -		tempah = tempah ^ 0x05;
> -		if (!(pVBInfo->VBInfo & SetCRT2ToLCD))
> -			tempah = tempah ^ 0x01;
> -	}
> -
> -	if (!(pVBInfo->VBInfo & SetCRT2ToDualEdge))
> -		tempah |= 0x08;
> -
> -reg_and_or:
> -	xgifb_reg_and_or(pVBInfo->Part1Port, 0x2e, tempbl, tempah);
> -
> -	if (pVBInfo->VBInfo & (SetCRT2ToRAMDAC | SetCRT2ToTV | SetCRT2ToLCD
> -			| XGI_SetCRT2ToLCDA)) {
> -		tempah &= (~0x08);
> -		if ((pVBInfo->ModeType == ModeVGA) && !(pVBInfo->VBInfo
> -				& SetInSlaveMode)) {
> -			tempah |= 0x010;
> -		}
> -		tempah |= 0x080;
> -
> -		if (pVBInfo->VBInfo & SetCRT2ToTV) {
> -			tempah |= 0x020;
> -			if (pVBInfo->VBInfo & DriverMode)
> -				tempah = tempah ^ 0x20;
> -		}
> -
> -		xgifb_reg_and_or(pVBInfo->Part4Port, 0x0D, ~0x0BF, tempah);
> -		tempah = 0;
> -
> -		if (pVBInfo->LCDInfo & SetLCDDualLink)
> -			tempah |= 0x40;
> -
> -		if (pVBInfo->VBInfo & SetCRT2ToTV) {
> -			if (pVBInfo->TVInfo & RPLLDIV2XO)
> -				tempah |= 0x40;
> -		}
> -
> -		if ((pVBInfo->LCDResInfo == Panel_1280x1024) ||
> -		    (pVBInfo->LCDResInfo == Panel_1280x1024x75))
> -			tempah |= 0x80;
> -
> -		if (pVBInfo->LCDResInfo == Panel_1280x960)
> -			tempah |= 0x80;
> -
> -		xgifb_reg_set(pVBInfo->Part4Port, 0x0C, tempah);
> -	}
> -
> -	if (pVBInfo->VBType & (VB_SIS301B | VB_SIS302B | VB_SIS301LV
> -			| VB_SIS302LV | VB_XGI301C)) {
> -		tempah = 0;
> -		tempbl = 0xfb;
> -
> -		if (pVBInfo->VBInfo & SetCRT2ToDualEdge) {
> -			tempbl = 0xff;
> -			if (pVBInfo->VBInfo & XGI_SetCRT2ToLCDA)
> -				tempah |= 0x04; /* shampoo 0129 */
> -		}
> -
> -		xgifb_reg_and_or(pVBInfo->Part1Port, 0x13, tempbl, tempah);
> -		tempah = 0x00;
> -		tempbl = 0xcf;
> -		if (!(pVBInfo->VBInfo & DisableCRT2Display)) {
> -			if (pVBInfo->VBInfo & SetCRT2ToDualEdge)
> -				tempah |= 0x30;
> -		}
> -
> -		xgifb_reg_and_or(pVBInfo->Part1Port, 0x2c, tempbl, tempah);
> -		tempah = 0;
> -		tempbl = 0x3f;
> -
> -		if (!(pVBInfo->VBInfo & DisableCRT2Display)) {
> -			if (pVBInfo->VBInfo & SetCRT2ToDualEdge)
> -				tempah |= 0xc0;
> -		}
> -		xgifb_reg_and_or(pVBInfo->Part4Port, 0x21, tempbl, tempah);
> -	}
> -
> -	tempah = 0;
> -	tempbl = 0x7f;
> -	if (!(pVBInfo->VBInfo & XGI_SetCRT2ToLCDA)) {
> -		tempbl = 0xff;
> -		if (!(pVBInfo->VBInfo & SetCRT2ToDualEdge))
> -			tempah |= 0x80;
> -	}
> -
> -	xgifb_reg_and_or(pVBInfo->Part4Port, 0x23, tempbl, tempah);
> -
> -	if (pVBInfo->VBType & (VB_SIS302LV | VB_XGI301C)) {
> -		if (pVBInfo->LCDInfo & SetLCDDualLink) {
> -			xgifb_reg_or(pVBInfo->Part4Port, 0x27, 0x20);
> -			xgifb_reg_or(pVBInfo->Part4Port, 0x34, 0x10);
> -		}
> -	}
> -}
> -
> -void XGI_UnLockCRT2(struct vb_device_info *pVBInfo)
> -{
> -	xgifb_reg_and_or(pVBInfo->Part1Port, 0x2f, 0xFF, 0x01);
> -}
> -
> -void XGI_LockCRT2(struct vb_device_info *pVBInfo)
> -{
> -	xgifb_reg_and_or(pVBInfo->Part1Port, 0x2F, 0xFE, 0x00);
> -}
> -
> -unsigned short XGI_GetRatePtrCRT2(struct xgi_hw_device_info *pXGIHWDE,
> -				  unsigned short ModeNo,
> -				  unsigned short ModeIdIndex,
> -				  struct vb_device_info *pVBInfo)
> -{
> -	static const u8 LCDARefreshIndex[] = {
> -		0x00, 0x00, 0x03, 0x01, 0x01, 0x01, 0x01, 0x00 };
> -
> -	unsigned short RefreshRateTableIndex, i, index, temp;
> -
> -	index = xgifb_reg_get(pVBInfo->P3d4, 0x33);
> -	index >>= pVBInfo->SelectCRT2Rate;
> -	index &= 0x0F;
> -
> -	if (pVBInfo->LCDInfo & LCDNonExpanding)
> -		index = 0;
> -
> -	if (index > 0)
> -		index--;
> -
> -	if (pVBInfo->SetFlag & ProgrammingCRT2) {
> -		if (pVBInfo->VBInfo & (SetCRT2ToLCD | XGI_SetCRT2ToLCDA)) {
> -			temp = LCDARefreshIndex[pVBInfo->LCDResInfo & 0x07];
> -
> -			if (index > temp)
> -				index = temp;
> -		}
> -	}
> -
> -	RefreshRateTableIndex = XGI330_EModeIDTable[ModeIdIndex].REFindex;
> -	ModeNo = XGI330_RefIndex[RefreshRateTableIndex].ModeID;
> -	if (pXGIHWDE->jChipType >= XG20) { /* for XG20, XG21, XG27 */
> -		if ((XGI330_RefIndex[RefreshRateTableIndex].XRes == 800) &&
> -		    (XGI330_RefIndex[RefreshRateTableIndex].YRes == 600)) {
> -			index++;
> -		}
> -		/* do the similar adjustment like XGISearchCRT1Rate() */
> -		if ((XGI330_RefIndex[RefreshRateTableIndex].XRes == 1024) &&
> -		    (XGI330_RefIndex[RefreshRateTableIndex].YRes == 768)) {
> -			index++;
> -		}
> -		if ((XGI330_RefIndex[RefreshRateTableIndex].XRes == 1280) &&
> -		    (XGI330_RefIndex[RefreshRateTableIndex].YRes == 1024)) {
> -			index++;
> -		}
> -	}
> -
> -	i = 0;
> -	do {
> -		if (XGI330_RefIndex[RefreshRateTableIndex + i].ModeID != ModeNo)
> -			break;
> -		temp = XGI330_RefIndex[RefreshRateTableIndex + i].Ext_InfoFlag;
> -		temp &= ModeTypeMask;
> -		if (temp < pVBInfo->ModeType)
> -			break;
> -		i++;
> -		index--;
> -
> -	} while (index != 0xFFFF);
> -	if (!(pVBInfo->VBInfo & SetCRT2ToRAMDAC)) {
> -		if (pVBInfo->VBInfo & SetInSlaveMode) {
> -			temp = XGI330_RefIndex[RefreshRateTableIndex + i - 1].Ext_InfoFlag;
> -			if (temp & InterlaceMode)
> -				i++;
> -		}
> -	}
> -	i--;
> -	if ((pVBInfo->SetFlag & ProgrammingCRT2)) {
> -		temp = XGI_AjustCRT2Rate(ModeIdIndex, RefreshRateTableIndex,
> -					 &i, pVBInfo);
> -	}
> -	return RefreshRateTableIndex + i;
> -}
> -
> -static void XGI_SetLCDAGroup(unsigned short ModeNo, unsigned short ModeIdIndex,
> -			     struct xgi_hw_device_info *HwDeviceExtension,
> -			     struct vb_device_info *pVBInfo)
> -{
> -	unsigned short RefreshRateTableIndex;
> -
> -	pVBInfo->SetFlag |= ProgrammingCRT2;
> -	RefreshRateTableIndex = XGI_GetRatePtrCRT2(HwDeviceExtension, ModeNo,
> -						   ModeIdIndex, pVBInfo);
> -	XGI_GetLVDSResInfo(ModeIdIndex, pVBInfo);
> -	XGI_GetLVDSData(ModeIdIndex, pVBInfo);
> -	XGI_ModCRT1Regs(ModeIdIndex, HwDeviceExtension, pVBInfo);
> -	XGI_SetLVDSRegs(ModeIdIndex, pVBInfo);
> -	XGI_SetCRT2ECLK(ModeIdIndex, RefreshRateTableIndex, pVBInfo);
> -}
> -
> -static unsigned char XGI_SetCRT2Group301(unsigned short ModeNo,
> -					 struct xgi_hw_device_info *HwDeviceExtension,
> -					 struct vb_device_info *pVBInfo)
> -{
> -	unsigned short ModeIdIndex, RefreshRateTableIndex;
> -
> -	pVBInfo->SetFlag |= ProgrammingCRT2;
> -	XGI_SearchModeID(ModeNo, &ModeIdIndex);
> -	pVBInfo->SelectCRT2Rate = 4;
> -	RefreshRateTableIndex = XGI_GetRatePtrCRT2(HwDeviceExtension, ModeNo,
> -						   ModeIdIndex, pVBInfo);
> -	XGI_SaveCRT2Info(ModeNo, pVBInfo);
> -	XGI_GetCRT2ResInfo(ModeIdIndex, pVBInfo);
> -	XGI_GetCRT2Data(ModeIdIndex, RefreshRateTableIndex, pVBInfo);
> -	XGI_PreSetGroup1(ModeNo, ModeIdIndex, RefreshRateTableIndex, pVBInfo);
> -	XGI_SetGroup1(ModeIdIndex, RefreshRateTableIndex, pVBInfo);
> -	XGI_SetLockRegs(ModeNo, ModeIdIndex, pVBInfo);
> -	XGI_SetGroup2(ModeNo, ModeIdIndex, pVBInfo);
> -	XGI_SetLCDRegs(ModeIdIndex, pVBInfo);
> -	XGI_SetTap4Regs(pVBInfo);
> -	XGI_SetGroup3(ModeIdIndex, pVBInfo);
> -	XGI_SetGroup4(ModeIdIndex, RefreshRateTableIndex, pVBInfo);
> -	XGI_SetCRT2VCLK(ModeIdIndex, RefreshRateTableIndex, pVBInfo);
> -	XGI_SetGroup5(pVBInfo);
> -	XGI_AutoThreshold(pVBInfo);
> -	return 1;
> -}
> -
> -void XGI_SenseCRT1(struct vb_device_info *pVBInfo)
> -{
> -	unsigned char CRTCData[17] = { 0x5F, 0x4F, 0x50, 0x82, 0x55, 0x81,
> -			0x0B, 0x3E, 0xE9, 0x0B, 0xDF, 0xE7, 0x04, 0x00, 0x00,
> -			0x05, 0x00 };
> -
> -	unsigned char SR01 = 0, SR1F = 0, SR07 = 0, SR06 = 0;
> -
> -	unsigned char CR17, CR63, SR31;
> -	unsigned short temp;
> -
> -	int i;
> -
> -	xgifb_reg_set(pVBInfo->P3c4, 0x05, 0x86);
> -
> -	/* to fix XG42 single LCD sense to CRT+LCD */
> -	xgifb_reg_set(pVBInfo->P3d4, 0x57, 0x4A);
> -	xgifb_reg_set(pVBInfo->P3d4, 0x53, (xgifb_reg_get(
> -			pVBInfo->P3d4, 0x53) | 0x02));
> -
> -	SR31 = xgifb_reg_get(pVBInfo->P3c4, 0x31);
> -	CR63 = xgifb_reg_get(pVBInfo->P3d4, 0x63);
> -	SR01 = xgifb_reg_get(pVBInfo->P3c4, 0x01);
> -
> -	xgifb_reg_set(pVBInfo->P3c4, 0x01, (unsigned char)(SR01 & 0xDF));
> -	xgifb_reg_set(pVBInfo->P3d4, 0x63, (unsigned char)(CR63 & 0xBF));
> -
> -	CR17 = xgifb_reg_get(pVBInfo->P3d4, 0x17);
> -	xgifb_reg_set(pVBInfo->P3d4, 0x17, (unsigned char)(CR17 | 0x80));
> -
> -	SR1F = xgifb_reg_get(pVBInfo->P3c4, 0x1F);
> -	xgifb_reg_set(pVBInfo->P3c4, 0x1F, (unsigned char)(SR1F | 0x04));
> -
> -	SR07 = xgifb_reg_get(pVBInfo->P3c4, 0x07);
> -	xgifb_reg_set(pVBInfo->P3c4, 0x07, (unsigned char)(SR07 & 0xFB));
> -	SR06 = xgifb_reg_get(pVBInfo->P3c4, 0x06);
> -	xgifb_reg_set(pVBInfo->P3c4, 0x06, (unsigned char)(SR06 & 0xC3));
> -
> -	xgifb_reg_set(pVBInfo->P3d4, 0x11, 0x00);
> -
> -	for (i = 0; i < 8; i++)
> -		xgifb_reg_set(pVBInfo->P3d4, (unsigned short)i, CRTCData[i]);
> -
> -	for (i = 8; i < 11; i++)
> -		xgifb_reg_set(pVBInfo->P3d4, (unsigned short)(i + 8),
> -			      CRTCData[i]);
> -
> -	for (i = 11; i < 13; i++)
> -		xgifb_reg_set(pVBInfo->P3d4, (unsigned short)(i + 4),
> -			      CRTCData[i]);
> -
> -	for (i = 13; i < 16; i++)
> -		xgifb_reg_set(pVBInfo->P3c4, (unsigned short)(i - 3),
> -			      CRTCData[i]);
> -
> -	xgifb_reg_set(pVBInfo->P3c4, 0x0E, (unsigned char)(CRTCData[16]
> -		      & 0xE0));
> -
> -	xgifb_reg_set(pVBInfo->P3c4, 0x31, 0x00);
> -	xgifb_reg_set(pVBInfo->P3c4, 0x2B, 0x1B);
> -	xgifb_reg_set(pVBInfo->P3c4, 0x2C, 0xE1);
> -
> -	outb(0x00, pVBInfo->P3c8);
> -
> -	for (i = 0; i < 256 * 3; i++)
> -		outb(0x0F, (pVBInfo->P3c8 + 1)); /* DAC_TEST_PARMS */
> -
> -	mdelay(1);
> -
> -	XGI_WaitDisply(pVBInfo);
> -	temp = inb(pVBInfo->P3c2);
> -
> -	if (temp & 0x10)
> -		xgifb_reg_and_or(pVBInfo->P3d4, 0x32, 0xDF, 0x20);
> -	else
> -		xgifb_reg_and_or(pVBInfo->P3d4, 0x32, 0xDF, 0x00);
> -
> -	/* avoid display something, set BLACK DAC if not restore DAC */
> -	outb(0x00, pVBInfo->P3c8);
> -
> -	for (i = 0; i < 256 * 3; i++)
> -		outb(0, (pVBInfo->P3c8 + 1));
> -
> -	xgifb_reg_set(pVBInfo->P3c4, 0x01, SR01);
> -	xgifb_reg_set(pVBInfo->P3d4, 0x63, CR63);
> -	xgifb_reg_set(pVBInfo->P3c4, 0x31, SR31);
> -
> -	xgifb_reg_set(pVBInfo->P3d4, 0x53, (xgifb_reg_get(
> -			pVBInfo->P3d4, 0x53) & 0xFD));
> -	xgifb_reg_set(pVBInfo->P3c4, 0x1F, (unsigned char)SR1F);
> -}
> -
> -static void XGI_EnableBridge(struct xgifb_video_info *xgifb_info,
> -			     struct xgi_hw_device_info *HwDeviceExtension,
> -			     struct vb_device_info *pVBInfo)
> -{
> -	unsigned short tempah;
> -
> -	if (pVBInfo->VBType & (VB_SIS301B | VB_SIS302B | VB_SIS301LV
> -			| VB_SIS302LV | VB_XGI301C)) {
> -		if (pVBInfo->VBInfo & SetCRT2ToDualEdge)
> -			/* Power on */
> -			xgifb_reg_set(pVBInfo->Part1Port, 0x1E, 0x20);
> -
> -		if (pVBInfo->VBInfo & (SetCRT2ToLCD | SetCRT2ToTV |
> -				       SetCRT2ToRAMDAC)) {
> -			tempah = xgifb_reg_get(pVBInfo->P3c4, 0x32);
> -			tempah &= 0xDF;
> -			if (pVBInfo->VBInfo & SetInSlaveMode) {
> -				if (!(pVBInfo->VBInfo & SetCRT2ToRAMDAC))
> -					tempah |= 0x20;
> -			}
> -			xgifb_reg_set(pVBInfo->P3c4, 0x32, tempah);
> -			xgifb_reg_or(pVBInfo->P3c4, 0x1E, 0x20);
> -
> -			tempah = xgifb_reg_get(pVBInfo->Part1Port, 0x2E);
> -
> -			if (!(tempah & 0x80))
> -				xgifb_reg_or(pVBInfo->Part1Port, 0x2E, 0x80);
> -			xgifb_reg_and(pVBInfo->Part1Port, 0x00, 0x7F);
> -		}
> -
> -		if (!(pVBInfo->VBInfo & DisableCRT2Display)) {
> -			xgifb_reg_and_or(pVBInfo->Part2Port, 0x00, ~0xE0,
> -					 0x20); /* shampoo 0129 */
> -			if (pVBInfo->VBType & (VB_SIS302LV | VB_XGI301C)) {
> -				if (pVBInfo->VBInfo &
> -					(SetCRT2ToLCD | XGI_SetCRT2ToLCDA))
> -					 /* LVDS PLL power on */
> -					xgifb_reg_and(pVBInfo->Part4Port, 0x2A,
> -						      0x7F);
> -				/* LVDS Driver power on */
> -				xgifb_reg_and(pVBInfo->Part4Port, 0x30, 0x7F);
> -			}
> -		}
> -
> -		tempah = 0x00;
> -
> -		if (!(pVBInfo->VBInfo & DisableCRT2Display)) {
> -			tempah = 0xc0;
> -
> -			if (!(pVBInfo->VBInfo & SetSimuScanMode) &&
> -			    (pVBInfo->VBInfo & XGI_SetCRT2ToLCDA) &&
> -			    (pVBInfo->VBInfo & SetCRT2ToDualEdge)) {
> -				tempah = tempah & 0x40;
> -				if (pVBInfo->VBInfo & XGI_SetCRT2ToLCDA)
> -					tempah = tempah ^ 0xC0;
> -			}
> -		}
> -
> -		/* EnablePart4_1F */
> -		xgifb_reg_or(pVBInfo->Part4Port, 0x1F, tempah);
> -
> -		XGI_DisableGatingCRT(pVBInfo);
> -		XGI_DisplayOn(xgifb_info, HwDeviceExtension, pVBInfo);
> -	} /* 301 */
> -	else { /* LVDS */
> -		if (pVBInfo->VBInfo & (SetCRT2ToTV | SetCRT2ToLCD
> -				| XGI_SetCRT2ToLCDA))
> -			/* enable CRT2 */
> -			xgifb_reg_or(pVBInfo->Part1Port, 0x1E, 0x20);
> -
> -		tempah = xgifb_reg_get(pVBInfo->Part1Port, 0x2E);
> -		if (!(tempah & 0x80))
> -			xgifb_reg_or(pVBInfo->Part1Port, 0x2E, 0x80);
> -
> -		xgifb_reg_and(pVBInfo->Part1Port, 0x00, 0x7F);
> -		XGI_DisplayOn(xgifb_info, HwDeviceExtension, pVBInfo);
> -	} /* End of VB */
> -}
> -
> -static void XGI_SetCRT1Group(struct xgifb_video_info *xgifb_info,
> -			     struct xgi_hw_device_info *HwDeviceExtension,
> -			     unsigned short ModeNo, unsigned short ModeIdIndex,
> -			     struct vb_device_info *pVBInfo)
> -{
> -	unsigned short RefreshRateTableIndex, temp;
> -
> -	XGI_SetSeqRegs(pVBInfo);
> -	outb(XGI330_StandTable.MISC, pVBInfo->P3c2);
> -	XGI_SetCRTCRegs(pVBInfo);
> -	XGI_SetATTRegs(ModeIdIndex, pVBInfo);
> -	XGI_SetGRCRegs(pVBInfo);
> -	XGI_ClearExt1Regs(pVBInfo);
> -
> -	if (HwDeviceExtension->jChipType == XG27) {
> -		if (pVBInfo->IF_DEF_LVDS == 0)
> -			XGI_SetDefaultVCLK(pVBInfo);
> -	}
> -
> -	temp = ~ProgrammingCRT2;
> -	pVBInfo->SetFlag &= temp;
> -	pVBInfo->SelectCRT2Rate = 0;
> -
> -	if (pVBInfo->VBType & (VB_SIS301B | VB_SIS302B | VB_SIS301LV
> -			| VB_SIS302LV | VB_XGI301C)) {
> -		if (pVBInfo->VBInfo & (SetSimuScanMode | XGI_SetCRT2ToLCDA
> -				| SetInSlaveMode)) {
> -			pVBInfo->SetFlag |= ProgrammingCRT2;
> -		}
> -	}
> -
> -	RefreshRateTableIndex = XGI_GetRatePtrCRT2(HwDeviceExtension, ModeNo,
> -						   ModeIdIndex, pVBInfo);
> -	if (RefreshRateTableIndex != 0xFFFF) {
> -		XGI_SetSync(RefreshRateTableIndex, pVBInfo);
> -		XGI_SetCRT1CRTC(ModeIdIndex, RefreshRateTableIndex,
> -				pVBInfo, HwDeviceExtension);
> -		XGI_SetCRT1DE(ModeIdIndex, RefreshRateTableIndex, pVBInfo);
> -		XGI_SetCRT1Offset(ModeNo, ModeIdIndex, RefreshRateTableIndex,
> -				  HwDeviceExtension, pVBInfo);
> -		XGI_SetCRT1VCLK(ModeIdIndex, HwDeviceExtension,
> -				RefreshRateTableIndex, pVBInfo);
> -	}
> -
> -	if (HwDeviceExtension->jChipType >= XG21) {
> -		temp = xgifb_reg_get(pVBInfo->P3d4, 0x38);
> -		if (temp & 0xA0) {
> -			if (HwDeviceExtension->jChipType == XG27)
> -				XGI_SetXG27CRTC(RefreshRateTableIndex, pVBInfo);
> -			else
> -				XGI_SetXG21CRTC(RefreshRateTableIndex, pVBInfo);
> -
> -			XGI_UpdateXG21CRTC(ModeNo, pVBInfo,
> -					   RefreshRateTableIndex);
> -
> -			xgifb_set_lcd(HwDeviceExtension->jChipType,
> -				      pVBInfo, RefreshRateTableIndex);
> -
> -			if (pVBInfo->IF_DEF_LVDS == 1)
> -				xgifb_set_lvds(xgifb_info,
> -					       HwDeviceExtension->jChipType,
> -					       ModeIdIndex, pVBInfo);
> -		}
> -	}
> -
> -	pVBInfo->SetFlag &= (~ProgrammingCRT2);
> -	XGI_SetCRT1FIFO(HwDeviceExtension, pVBInfo);
> -	XGI_SetCRT1ModeRegs(HwDeviceExtension, ModeIdIndex,
> -			    RefreshRateTableIndex, pVBInfo);
> -	XGI_LoadDAC(pVBInfo);
> -}
> -
> -unsigned char XGISetModeNew(struct xgifb_video_info *xgifb_info,
> -			    struct xgi_hw_device_info *HwDeviceExtension,
> -			    unsigned short ModeNo)
> -{
> -	unsigned short ModeIdIndex;
> -	struct vb_device_info VBINF;
> -	struct vb_device_info *pVBInfo = &VBINF;
> -
> -	pVBInfo->IF_DEF_LVDS = 0;
> -
> -	if (HwDeviceExtension->jChipType >= XG20)
> -		pVBInfo->VBType = 0; /* set VBType default 0 */
> -
> -	XGIRegInit(pVBInfo, xgifb_info->vga_base);
> -
> -	/* for x86 Linux, XG21 LVDS */
> -	if (HwDeviceExtension->jChipType == XG21) {
> -		if ((xgifb_reg_get(pVBInfo->P3d4, 0x38) & 0xE0) == 0xC0)
> -			pVBInfo->IF_DEF_LVDS = 1;
> -	}
> -	if (HwDeviceExtension->jChipType == XG27) {
> -		if ((xgifb_reg_get(pVBInfo->P3d4, 0x38) & 0xE0) == 0xC0) {
> -			if (xgifb_reg_get(pVBInfo->P3d4, 0x30) & 0x20)
> -				pVBInfo->IF_DEF_LVDS = 1;
> -		}
> -	}
> -
> -	InitTo330Pointer(HwDeviceExtension->jChipType, pVBInfo);
> -	if (ModeNo & 0x80)
> -		ModeNo = ModeNo & 0x7F;
> -	xgifb_reg_set(pVBInfo->P3c4, 0x05, 0x86);
> -
> -	if (HwDeviceExtension->jChipType < XG20)
> -		XGI_UnLockCRT2(pVBInfo);
> -
> -	XGI_SearchModeID(ModeNo, &ModeIdIndex);
> -
> -	if (HwDeviceExtension->jChipType < XG20) {
> -		XGI_GetVBInfo(ModeIdIndex, pVBInfo);
> -		XGI_GetTVInfo(ModeIdIndex, pVBInfo);
> -		XGI_GetLCDInfo(ModeIdIndex, pVBInfo);
> -		XGI_DisableBridge(xgifb_info, HwDeviceExtension, pVBInfo);
> -
> -		if (pVBInfo->VBInfo & (SetSimuScanMode | XGI_SetCRT2ToLCDA) ||
> -		    !(pVBInfo->VBInfo & SwitchCRT2)) {
> -			XGI_SetCRT1Group(xgifb_info, HwDeviceExtension, ModeNo,
> -					 ModeIdIndex, pVBInfo);
> -
> -			if (pVBInfo->VBInfo & XGI_SetCRT2ToLCDA) {
> -				XGI_SetLCDAGroup(ModeNo, ModeIdIndex,
> -						 HwDeviceExtension, pVBInfo);
> -			}
> -		}
> -
> -		if (pVBInfo->VBInfo & (SetSimuScanMode | SwitchCRT2)) {
> -			switch (HwDeviceExtension->ujVBChipID) {
> -			case VB_CHIP_301: /* fall through */
> -			case VB_CHIP_302:
> -				/* add for CRT2 */
> -				XGI_SetCRT2Group301(ModeNo, HwDeviceExtension,
> -						    pVBInfo);
> -				break;
> -
> -			default:
> -				break;
> -			}
> -		}
> -
> -		XGI_SetCRT2ModeRegs(pVBInfo);
> -		XGI_OEM310Setting(ModeIdIndex, pVBInfo); /* 0212 */
> -		XGI_EnableBridge(xgifb_info, HwDeviceExtension, pVBInfo);
> -	} /* !XG20 */
> -	else {
> -		if (pVBInfo->IF_DEF_LVDS == 1)
> -			if (!XGI_XG21CheckLVDSMode(xgifb_info, ModeNo,
> -						   ModeIdIndex))
> -				return 0;
> -
> -		pVBInfo->ModeType =
> -			XGI330_EModeIDTable[ModeIdIndex].Ext_ModeFlag
> -			& ModeTypeMask;
> -
> -		pVBInfo->SetFlag = 0;
> -		pVBInfo->VBInfo = DisableCRT2Display;
> -
> -		XGI_DisplayOff(xgifb_info, HwDeviceExtension, pVBInfo);
> -
> -		XGI_SetCRT1Group(xgifb_info, HwDeviceExtension, ModeNo,
> -				 ModeIdIndex, pVBInfo);
> -
> -		XGI_DisplayOn(xgifb_info, HwDeviceExtension, pVBInfo);
> -	}
> -
> -	XGI_UpdateModeInfo(pVBInfo);
> -
> -	if (HwDeviceExtension->jChipType < XG20)
> -		XGI_LockCRT2(pVBInfo);
> -
> -	return 1;
> -}
> diff --git a/drivers/staging/xgifb/vb_setmode.h b/drivers/staging/xgifb/vb_setmode.h
> deleted file mode 100644
> index 5904ed1f2686..000000000000
> --- a/drivers/staging/xgifb/vb_setmode.h
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _VBSETMODE_
> -#define _VBSETMODE_
> -
> -void InitTo330Pointer(unsigned char ChipType, struct vb_device_info *pVBInfo);
> -void XGI_UnLockCRT2(struct vb_device_info *pVBInfo);
> -void XGI_LockCRT2(struct vb_device_info *pVBInfo);
> -void XGI_DisplayOff(struct xgifb_video_info *xgifb_info,
> -		    struct xgi_hw_device_info *pXGIHWDE,
> -		    struct vb_device_info *pVBInfo);
> -void XGI_GetVBType(struct vb_device_info *pVBInfo);
> -void XGI_SenseCRT1(struct vb_device_info *pVBInfo);
> -unsigned char XGISetModeNew(struct xgifb_video_info *xgifb_info,
> -			    struct xgi_hw_device_info *HwDeviceExtension,
> -			    unsigned short ModeNo);
> -
> -unsigned char XGI_SearchModeID(unsigned short ModeNo,
> -			       unsigned short *ModeIdIndex);
> -unsigned short XGI_GetRatePtrCRT2(struct xgi_hw_device_info *pXGIHWDE,
> -				  unsigned short ModeNo,
> -				  unsigned short ModeIdIndex,
> -				  struct vb_device_info *pVBInfo);
> -
> -#endif
> diff --git a/drivers/staging/xgifb/vb_struct.h b/drivers/staging/xgifb/vb_struct.h
> deleted file mode 100644
> index e256f72f6d8a..000000000000
> --- a/drivers/staging/xgifb/vb_struct.h
> +++ /dev/null
> @@ -1,165 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _VB_STRUCT_
> -#define _VB_STRUCT_
> -#include "../../video/fbdev/sis/vstruct.h"
> -
> -struct XGI_LVDSCRT1HDataStruct {
> -	unsigned char Reg[8];
> -};
> -
> -struct XGI_LVDSCRT1VDataStruct {
> -	unsigned char Reg[7];
> -};
> -
> -struct XGI_ExtStruct {
> -	unsigned char Ext_ModeID;
> -	unsigned short Ext_ModeFlag;
> -	unsigned short Ext_ModeInfo;
> -	unsigned char Ext_RESINFO;
> -	unsigned char VB_ExtTVYFilterIndex;
> -	unsigned char REFindex;
> -};
> -
> -struct XGI_Ext2Struct {
> -	unsigned short Ext_InfoFlag;
> -	unsigned char Ext_CRT1CRTC;
> -	unsigned char Ext_CRTVCLK;
> -	unsigned char Ext_CRT2CRTC;
> -	unsigned char Ext_CRT2CRTC2;
> -	unsigned char  ModeID;
> -	unsigned short XRes;
> -	unsigned short YRes;
> -};
> -
> -struct XGI_ECLKDataStruct {
> -	unsigned char SR2E, SR2F, SR30;
> -	unsigned short CLOCK;
> -};
> -
> -/*add for new UNIVGABIOS*/
> -struct XGI_LCDDesStruct {
> -	unsigned short LCDHDES;
> -	unsigned short LCDHRS;
> -	unsigned short LCDVDES;
> -	unsigned short LCDVRS;
> -};
> -
> -struct XGI330_LCDDataDesStruct2 {
> -	unsigned short LCDHDES;
> -	unsigned short LCDHRS;
> -	unsigned short LCDVDES;
> -	unsigned short LCDVRS;
> -	unsigned short LCDHSync;
> -	unsigned short LCDVSync;
> -};
> -
> -struct XGI330_LCDDataTablStruct {
> -	unsigned char  PANELID;
> -	unsigned short MASK;
> -	unsigned short CAP;
> -	void const *DATAPTR;
> -};
> -
> -struct XGI330_TVDataTablStruct {
> -	unsigned short MASK;
> -	unsigned short CAP;
> -	struct SiS_TVData const *DATAPTR;
> -};
> -
> -struct XGI_TimingHStruct {
> -	unsigned char data[8];
> -};
> -
> -struct XGI_TimingVStruct {
> -	unsigned char data[7];
> -};
> -
> -struct XGI_XG21CRT1Struct {
> -	unsigned char ModeID, CR02, CR03, CR15, CR16;
> -};
> -
> -struct XGI330_LCDCapStruct {
> -	unsigned char	LCD_ID;
> -	unsigned short	LCD_Capability;
> -	unsigned char	LCD_HSyncWidth;
> -	unsigned char	LCD_VSyncWidth;
> -	unsigned char	LCD_VCLK;
> -	unsigned char	LCDA_VCLKData1;
> -	unsigned char	LCDA_VCLKData2;
> -	unsigned char	LCUCHAR_VCLKData1;
> -	unsigned char	LCUCHAR_VCLKData2;
> -	unsigned char	Spectrum_31;
> -	unsigned char	Spectrum_32;
> -	unsigned char	Spectrum_33;
> -	unsigned char	Spectrum_34;
> -};
> -
> -struct XGI21_LVDSCapStruct {
> -	unsigned short LVDS_Capability;
> -	unsigned short LVDSHT;
> -	unsigned short LVDSVT;
> -	unsigned short LVDSHDE;
> -	unsigned short LVDSVDE;
> -	unsigned short LVDSHFP;
> -	unsigned short LVDSVFP;
> -	unsigned short LVDSHSYNC;
> -	unsigned short LVDSVSYNC;
> -	unsigned char  VCLKData1;
> -	unsigned char  VCLKData2;
> -	unsigned char  PSC_S1; /* Duration between CPL on and signal on */
> -	unsigned char  PSC_S2; /* Duration signal on and Vdd on */
> -	unsigned char  PSC_S3; /* Duration between CPL off and signal off */
> -	unsigned char  PSC_S4; /* Duration signal off and Vdd off */
> -	unsigned char  PSC_S5;
> -};
> -
> -struct XGI_CRT1TableStruct {
> -	unsigned char CR[16];
> -};
> -
> -struct XGI301C_Tap4TimingStruct {
> -	unsigned short DE;
> -	unsigned char  Reg[64];   /* C0-FF */
> -};
> -
> -struct vb_device_info {
> -	unsigned long   P3c4, P3d4, P3c0, P3ce, P3c2, P3cc;
> -	unsigned long   P3ca, P3c6, P3c7, P3c8, P3c9, P3da;
> -	unsigned long   Part0Port, Part1Port, Part2Port;
> -	unsigned long   Part3Port, Part4Port, Part5Port;
> -	unsigned short   RVBHCFACT, RVBHCMAX, RVBHRS;
> -	unsigned short   VGAVT, VGAHT, VGAVDE, VGAHDE;
> -	unsigned short   VT, HT, VDE, HDE;
> -	unsigned short   LCDHRS, LCDVRS, LCDHDES, LCDVDES;
> -
> -	unsigned short   ModeType;
> -	unsigned short   IF_DEF_LVDS;
> -	unsigned short   IF_DEF_CRT2Monitor;
> -	unsigned short   IF_DEF_YPbPr;
> -	unsigned short   IF_DEF_HiVision;
> -	unsigned short   LCDResInfo, LCDTypeInfo, VBType;/*301b*/
> -	unsigned short   VBInfo, TVInfo, LCDInfo;
> -	unsigned short   SetFlag;
> -	unsigned short   NewFlickerMode;
> -	unsigned short   SelectCRT2Rate;
> -
> -	void __iomem *FBAddr;
> -
> -	unsigned char const *SR18;
> -	unsigned char const (*CR40)[3];
> -
> -	struct SiS_MCLKData const *MCLKData;
> -
> -	unsigned char   XGINew_CR97;
> -
> -	struct XGI330_LCDCapStruct const *LCDCapList;
> -
> -	struct XGI_TimingHStruct TimingH;
> -	struct XGI_TimingVStruct TimingV;
> -
> -	int ram_type;
> -	int ram_channel;
> -	int ram_bus;
> -};  /* _struct vb_device_info */
> -
> -#endif /* _VB_STRUCT_ */
> diff --git a/drivers/staging/xgifb/vb_table.h b/drivers/staging/xgifb/vb_table.h
> deleted file mode 100644
> index 42ecf7fe6766..000000000000
> --- a/drivers/staging/xgifb/vb_table.h
> +++ /dev/null
> @@ -1,2513 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _VB_TABLE_
> -#define _VB_TABLE_
> -static const struct SiS_MCLKData XGI340New_MCLKData[] = {
> -	{0x16, 0x01, 0x01, 166},
> -	{0x19, 0x02, 0x01, 124},
> -	{0x7C, 0x08, 0x01, 200},
> -};
> -
> -static const struct SiS_MCLKData XGI27New_MCLKData[] = {
> -	{0x5c, 0x23, 0x01, 166},
> -	{0x19, 0x02, 0x01, 124},
> -	{0x7C, 0x08, 0x80, 200},
> -};
> -
> -const struct XGI_ECLKDataStruct XGI340_ECLKData[] = {
> -	{0x5c, 0x23, 0x01, 166},
> -	{0x55, 0x84, 0x01, 123},
> -	{0x7C, 0x08, 0x01, 200},
> -};
> -
> -static const unsigned char XG27_SR18[3] = {
> -	0x32, 0x32, 0x42 /* SR18 */
> -};
> -
> -static const unsigned char XGI340_SR18[3] = {
> -	0x31, 0x42, 0x42 /* SR18 */
> -};
> -
> -static const unsigned char XGI340_cr41[24][3] = {
> -	{0x20, 0x50, 0x60}, /* 0 CR41 */
> -	{0xc4, 0x40, 0x84}, /* 1 CR8A */
> -	{0xc4, 0x40, 0x84}, /* 2 CR8B */
> -	{0xb5, 0xa4, 0xa4},
> -	{0xf0, 0xf0, 0xf0},
> -	{0x90, 0x90, 0x24}, /* 5 CR68 */
> -	{0x77, 0x77, 0x44}, /* 6 CR69 */
> -	{0x77, 0x77, 0x44}, /* 7 CR6A */
> -	{0xff, 0xff, 0xff}, /* 8 CR6D */
> -	{0x55, 0x55, 0x55}, /* 9 CR80 */
> -	{0x00, 0x00, 0x00}, /* 10 CR81 */
> -	{0x88, 0xa8, 0x48}, /* 11 CR82 */
> -	{0x44, 0x44, 0x77}, /* 12 CR85 */
> -	{0x48, 0x48, 0x88}, /* 13 CR86 */
> -	{0x54, 0x54, 0x44}, /* 14 CR90 */
> -	{0x54, 0x54, 0x44}, /* 15 CR91 */
> -	{0x0a, 0x0a, 0x07}, /* 16 CR92 */
> -	{0x44, 0x44, 0x44}, /* 17 CR93 */
> -	{0x10, 0x10, 0x0A}, /* 18 CR94 */
> -	{0x11, 0x11, 0x0a}, /* 19 CR95 */
> -	{0x05, 0x05, 0x05}, /* 20 CR96 */
> -	{0xf0, 0xf0, 0xf0}, /* 21 CRC3 */
> -	{0x05, 0x00, 0x02}, /* 22 CRC4 */
> -	{0x00, 0x00, 0x00}  /* 23 CRC5 */
> -};
> -
> -static const unsigned char XGI27_cr41[24][3] = {
> -	{0x20, 0x40, 0x60}, /* 0 CR41 */
> -	{0xC4, 0x40, 0x84}, /* 1 CR8A */
> -	{0xC4, 0x40, 0x84}, /* 2 CR8B */
> -	{0xB3, 0x13, 0xa4}, /* 3 CR40[7],
> -			     *   CR99[2:0],
> -			     *   CR45[3:0]
> -			     */
> -	{0xf0, 0xf5, 0xf0}, /* 4 CR59 */
> -	{0x90, 0x90, 0x24}, /* 5 CR68 */
> -	{0x77, 0x67, 0x44}, /* 6 CR69 */
> -	{0x77, 0x77, 0x44}, /* 7 CR6A */
> -	{0xff, 0xff, 0xff}, /* 8 CR6D */
> -	{0x55, 0x55, 0x55}, /* 9 CR80 */
> -	{0x00, 0x00, 0x00}, /* 10 CR81 */
> -	{0x88, 0xcc, 0x48}, /* 11 CR82 */
> -	{0x44, 0x88, 0x77}, /* 12 CR85 */
> -	{0x48, 0x88, 0x88}, /* 13 CR86 */
> -	{0x54, 0x32, 0x44}, /* 14 CR90 */
> -	{0x54, 0x33, 0x44}, /* 15 CR91 */
> -	{0x0a, 0x07, 0x07}, /* 16 CR92 */
> -	{0x44, 0x63, 0x44}, /* 17 CR93 */
> -	{0x10, 0x14, 0x0A}, /* 18 CR94 */
> -	{0x11, 0x0B, 0x0C}, /* 19 CR95 */
> -	{0x05, 0x22, 0x05}, /* 20 CR96 */
> -	{0xf0, 0xf0, 0x00}, /* 21 CRC3 */
> -	{0x05, 0x00, 0x02}, /* 22 CRC4 */
> -	{0x00, 0x00, 0x00}  /* 23 CRC5 */
> -};
> -
> -/* CR47,CR48,CR49,CR4A,CR4B,CR4C,CR70,CR71,CR74,CR75,CR76,CR77 */
> -const unsigned char XGI340_AGPReg[12] = {
> -	0x28, 0x23, 0x00, 0x20, 0x00, 0x20,
> -	0x00, 0x05, 0xd0, 0x10, 0x10, 0x00
> -};
> -
> -const struct XGI_ExtStruct XGI330_EModeIDTable[] = {
> -	{0x2e, 0x0a1b, 0x0306, 0x06, 0x05, 0x06},
> -	{0x2f, 0x0a1b, 0x0305, 0x05, 0x05, 0x05},
> -	{0x30, 0x2a1b, 0x0407, 0x07, 0x07, 0x0e},
> -	{0x31, 0x0a1b, 0x030d, 0x0d, 0x06, 0x3d},
> -	{0x32, 0x0a1b, 0x0a0e, 0x0e, 0x06, 0x3e},
> -	{0x33, 0x0a1d, 0x0a0d, 0x0d, 0x06, 0x3d},
> -	{0x34, 0x2a1d, 0x0a0e, 0x0e, 0x06, 0x3e},
> -	{0x35, 0x0a1f, 0x0a0d, 0x0d, 0x06, 0x3d},
> -	{0x36, 0x2a1f, 0x0a0e, 0x0e, 0x06, 0x3e},
> -	{0x38, 0x0a1b, 0x0508, 0x08, 0x00, 0x16},
> -	{0x3a, 0x0e3b, 0x0609, 0x09, 0x00, 0x1e},
> -	{0x3c, 0x0e3b, 0x070a, 0x0a, 0x00, 0x22}, /* mode 1600x1200
> -						   * add CRT2MODE [2003/10/07]
> -						   */
> -	{0x3d, 0x0e7d, 0x070a, 0x0a, 0x00, 0x22}, /* mode 1600x1200
> -						   * add CRT2MODE
> -						   */
> -	{0x40, 0x9a1c, 0x0000, 0x00, 0x04, 0x00},
> -	{0x41, 0x9a1d, 0x0000, 0x00, 0x04, 0x00},
> -	{0x43, 0x0a1c, 0x0306, 0x06, 0x05, 0x06},
> -	{0x44, 0x0a1d, 0x0306, 0x06, 0x05, 0x06},
> -	{0x46, 0x2a1c, 0x0407, 0x07, 0x07, 0x0e},
> -	{0x47, 0x2a1d, 0x0407, 0x07, 0x07, 0x0e},
> -	{0x49, 0x0a3c, 0x0508, 0x08, 0x00, 0x16},
> -	{0x4a, 0x0a3d, 0x0508, 0x08, 0x00, 0x16},
> -	{0x4c, 0x0e7c, 0x0609, 0x09, 0x00, 0x1e},
> -	{0x4d, 0x0e7d, 0x0609, 0x09, 0x00, 0x1e},
> -	{0x50, 0x9a1b, 0x0001, 0x01, 0x04, 0x02},
> -	{0x51, 0xba1b, 0x0103, 0x03, 0x07, 0x03},
> -	{0x52, 0x9a1b, 0x0204, 0x04, 0x00, 0x04},
> -	{0x56, 0x9a1d, 0x0001, 0x01, 0x04, 0x02},
> -	{0x57, 0xba1d, 0x0103, 0x03, 0x07, 0x03},
> -	{0x58, 0x9a1d, 0x0204, 0x04, 0x00, 0x04},
> -	{0x59, 0x9a1b, 0x0000, 0x00, 0x04, 0x00},
> -	{0x5A, 0x021b, 0x0014, 0x01, 0x04, 0x3f},
> -	{0x5B, 0x0a1d, 0x0014, 0x01, 0x04, 0x3f},
> -	{0x5d, 0x0a1d, 0x0305, 0x05, 0x07, 0x05},
> -	{0x62, 0x0a3f, 0x0306, 0x06, 0x05, 0x06},
> -	{0x63, 0x2a3f, 0x0407, 0x07, 0x07, 0x0e},
> -	{0x64, 0x0a7f, 0x0508, 0x08, 0x00, 0x16},
> -	{0x65, 0x0eff, 0x0609, 0x09, 0x00, 0x1e},
> -	{0x66, 0x0eff, 0x070a, 0x0a, 0x00, 0x22}, /* mode 1600x1200
> -						   * add CRT2MODE
> -						   */
> -	{0x68, 0x067b, 0x080b, 0x0b, 0x00, 0x29},
> -	{0x69, 0x06fd, 0x080b, 0x0b, 0x00, 0x29},
> -	{0x6b, 0x07ff, 0x080b, 0x0b, 0x00, 0x29},
> -	{0x6c, 0x067b, 0x090c, 0x0c, 0x00, 0x2f},
> -	{0x6d, 0x06fd, 0x090c, 0x0c, 0x00, 0x2f},
> -	{0x6e, 0x07ff, 0x090c, 0x0c, 0x00, 0x2f},
> -	{0x70, 0x2a1b, 0x0410, 0x10, 0x07, 0x34},
> -	{0x71, 0x0a1b, 0x0511, 0x11, 0x00, 0x37},
> -	{0x74, 0x0a1d, 0x0511, 0x11, 0x00, 0x37},
> -	{0x75, 0x0a3d, 0x0612, 0x12, 0x00, 0x3a},
> -	{0x76, 0x2a1f, 0x0410, 0x10, 0x07, 0x34},
> -	{0x77, 0x0a1f, 0x0511, 0x11, 0x00, 0x37},
> -	{0x78, 0x0a3f, 0x0612, 0x12, 0x00, 0x3a},
> -	{0x79, 0x0a3b, 0x0612, 0x12, 0x00, 0x3a},
> -	{0x7a, 0x2a1d, 0x0410, 0x10, 0x07, 0x34},
> -	{0x7b, 0x0e3b, 0x060f, 0x0f, 0x00, 0x1d},
> -	{0x7c, 0x0e7d, 0x060f, 0x0f, 0x00, 0x1d},
> -	{0x7d, 0x0eff, 0x060f, 0x0f, 0x00, 0x1d},
> -	{0x20, 0x0e3b, 0x0D16, 0x16, 0x00, 0x43},
> -	{0x21, 0x0e7d, 0x0D16, 0x16, 0x00, 0x43},
> -	{0x22, 0x0eff, 0x0D16, 0x16, 0x00, 0x43},
> -	{0x23, 0x0e3b, 0x0614, 0x14, 0x00, 0x41},
> -	{0x24, 0x0e7d, 0x0614, 0x14, 0x00, 0x41},
> -	{0x25, 0x0eff, 0x0614, 0x14, 0x00, 0x41},
> -	{0x26, 0x063b, 0x0c15, 0x15, 0x00, 0x42},
> -	{0x27, 0x067d, 0x0c15, 0x15, 0x00, 0x42},
> -	{0x28, 0x06ff, 0x0c15, 0x15, 0x00, 0x42},
> -	{0xff, 0x0000, 0x0000, 0x00, 0x00, 0x00}
> -};
> -
> -static const struct SiS_StandTable_S XGI330_StandTable = {
> -/* ExtVGATable */
> -	0x00, 0x00, 0x00, 0x0000,
> -	{0x21, 0x0f, 0x00, 0x0e}, /* 0x21 = 0x01 | (0x20 = screen off) */
> -	 0x23,
> -	{0x5f, 0x4f, 0x50, 0x82, 0x54, 0x80, 0x0b, 0x3e,
> -	 0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -	 0xea, 0x8c, 0xdf, 0x28, 0x40, 0xe7, 0x04, 0xa3,
> -	 0xff},
> -	{0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
> -	 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
> -	 0x01, 0x00, 0x00, 0x00},
> -	{0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x05, 0x0f,
> -	 0xff}
> -};
> -
> -static const struct XGI_XG21CRT1Struct XGI_UpdateCRT1Table[] = {
> -	{0x01, 0x27, 0x91, 0x8f, 0xc0},	/* 00 */
> -	{0x03, 0x4f, 0x83, 0x8f, 0xc0},	/* 01 */
> -	{0x05, 0x27, 0x91, 0x8f, 0xc0},	/* 02 */
> -	{0x06, 0x4f, 0x83, 0x8f, 0xc0},	/* 03 */
> -	{0x07, 0x4f, 0x83, 0x8f, 0xc0},	/* 04 */
> -	{0x0d, 0x27, 0x91, 0x8f, 0xc0},	/* 05 */
> -	{0x0e, 0x4f, 0x83, 0x8f, 0xc0},	/* 06 */
> -	{0x0f, 0x4f, 0x83, 0x5d, 0xc0},	/* 07 */
> -	{0x10, 0x4f, 0x83, 0x5d, 0xc0},	/* 08 */
> -	{0x11, 0x4f, 0x83, 0xdf, 0x0c},	/* 09 */
> -	{0x12, 0x4f, 0x83, 0xdf, 0x0c},	/* 10 */
> -	{0x13, 0x4f, 0x83, 0x8f, 0xc0},	/* 11 */
> -	{0x2e, 0x4f, 0x83, 0xdf, 0x0c},	/* 12 */
> -	{0x2e, 0x4f, 0x87, 0xdf, 0xc0},	/* 13 */
> -	{0x2f, 0x4f, 0x83, 0x8f, 0xc0},	/* 14 */
> -	{0x50, 0x27, 0x91, 0xdf, 0x0c},	/* 15 */
> -	{0x59, 0x27, 0x91, 0x8f, 0xc0}	/* 16 */
> -};
> -
> -const struct XGI_CRT1TableStruct XGI_CRT1Table[] = {
> -	{ {0x2d, 0x28, 0x90, 0x2c, 0x90, 0x00, 0x04, 0x00,
> -	  0xbf, 0x1f, 0x9c, 0x8e, 0x96, 0xb9, 0x30} }, /* 0x0 */
> -	{ {0x2d, 0x28, 0x90, 0x2c, 0x90, 0x00, 0x04, 0x00,
> -	  0x0b, 0x3e, 0xe9, 0x8b, 0xe7, 0x04, 0x00} }, /* 0x1 */
> -	{ {0x3D, 0x31, 0x81, 0x37, 0x1F, 0x00, 0x05, 0x00,
> -	  0x72, 0xF0, 0x58, 0x8C, 0x57, 0x73, 0xA0} }, /* 0x2 */
> -	{ {0x4F, 0x3F, 0x93, 0x45, 0x0D, 0x00, 0x01, 0x00,
> -	  0x24, 0xF5, 0x02, 0x88, 0xFF, 0x25, 0x90} }, /* 0x3 */
> -	{ {0x5F, 0x50, 0x82, 0x55, 0x81, 0x00, 0x05, 0x00,
> -	  0xBF, 0x1F, 0x9C, 0x8E, 0x96, 0xB9, 0x30} }, /* 0x4 */
> -	{ {0x5F, 0x50, 0x82, 0x55, 0x81, 0x00, 0x05, 0x00,
> -	  0x0B, 0x3E, 0xE9, 0x8B, 0xE7, 0x04, 0x00} }, /* 0x5 */
> -	{ {0x63, 0x50, 0x86, 0x56, 0x9B, 0x00, 0x01, 0x00,
> -	  0x06, 0x3E, 0xE8, 0x8B, 0xE7, 0xFF, 0x10} }, /* 0x6 */
> -	{ {0x64, 0x4F, 0x88, 0x55, 0x9D, 0x00, 0x01, 0x00,
> -	  0xF2, 0x1F, 0xE0, 0x83, 0xDF, 0xF3, 0x10} }, /* 0x7 */
> -	{ {0x63, 0x4F, 0x87, 0x5A, 0x81, 0x00, 0x05, 0x00,
> -	  0xFB, 0x1F, 0xE0, 0x83, 0xDF, 0xFC, 0x10} }, /* 0x8 */
> -	{ {0x65, 0x4F, 0x89, 0x58, 0x80, 0x00, 0x05, 0x60,
> -	  0xFB, 0x1F, 0xE0, 0x83, 0xDF, 0xFC, 0x80} }, /* 0x9 */
> -	{ {0x65, 0x4F, 0x89, 0x58, 0x80, 0x00, 0x05, 0x60,
> -	  0x01, 0x3E, 0xE0, 0x83, 0xDF, 0x02, 0x80} }, /* 0xa */
> -	{ {0x67, 0x4F, 0x8B, 0x58, 0x81, 0x00, 0x05, 0x60,
> -	  0x0D, 0x3E, 0xE0, 0x83, 0xDF, 0x0E, 0x90} }, /* 0xb */
> -	{ {0x65, 0x4F, 0x89, 0x57, 0x9F, 0x00, 0x01, 0x00,
> -	  0xFB, 0x1F, 0xE6, 0x8A, 0xDF, 0xFC, 0x10} }, /* 0xc */
> -	/* 0D (800x600,56Hz) */
> -	{ {0x7B, 0x63, 0x9F, 0x6A, 0x93, 0x00, 0x05, 0x00,
> -	/* (VCLK 36.0MHz) */
> -	  0x6F, 0xF0, 0x58, 0x8A, 0x57, 0x70, 0xA0} },
> -	/* 0E (800x600,60Hz) */
> -	{ {0x7F, 0x63, 0x83, 0x6C, 0x1C, 0x00, 0x06, 0x00,
> -	/* (VCLK 40.0MHz) */
> -	  0x72, 0xF0, 0x58, 0x8C, 0x57, 0x73, 0xA0} },
> -	/* 0F (800x600,72Hz) */
> -	{ {0x7D, 0x63, 0x81, 0x6E, 0x1D, 0x00, 0x06, 0x00,
> -	/* (VCLK 50.0MHz) */
> -	  0x98, 0xF0, 0x7C, 0x82, 0x57, 0x99, 0x80} },
> -	/* 10 (800x600,75Hz) */
> -	{ {0x7F, 0x63, 0x83, 0x69, 0x13, 0x00, 0x06, 0x00,
> -	/* (VCLK 49.5MHz) */
> -	  0x6F, 0xF0, 0x58, 0x8B, 0x57, 0x70, 0xA0} },
> -	/* 11 (800x600,85Hz) */
> -	{ {0x7E, 0x63, 0x82, 0x6B, 0x13, 0x00, 0x06, 0x00,
> -	/* (VCLK 56.25MHz) */
> -	  0x75, 0xF0, 0x58, 0x8B, 0x57, 0x76, 0xA0} },
> -	/* 12 (800x600,100Hz) */
> -	{ {0x81, 0x63, 0x85, 0x6D, 0x18, 0x00, 0x06, 0x60,
> -	/* (VCLK 75.8MHz) */
> -	  0x7A, 0xF0, 0x58, 0x8B, 0x57, 0x7B, 0xA0} },
> -	/* 13 (800x600,120Hz) */
> -	{ {0x83, 0x63, 0x87, 0x6E, 0x19, 0x00, 0x06, 0x60,
> -	/* (VCLK 79.411MHz) */
> -	  0x81, 0xF0, 0x58, 0x8B, 0x57, 0x82, 0xA0} },
> -	/* 14 (800x600,160Hz) */
> -	{ {0x85, 0x63, 0x89, 0x6F, 0x1A, 0x00, 0x06, 0x60,
> -	/* (VCLK 105.822MHz) */
> -	  0x91, 0xF0, 0x58, 0x8B, 0x57, 0x92, 0xA0} },
> -	{ {0x99, 0x7F, 0x9D, 0x84, 0x1A, 0x00, 0x02, 0x00,
> -	  0x96, 0x1F, 0x7F, 0x83, 0x7F, 0x97, 0x10} }, /* 0x15 */
> -	{ {0xA3, 0x7F, 0x87, 0x86, 0x97, 0x00, 0x02, 0x00,
> -	  0x24, 0xF5, 0x02, 0x88, 0xFF, 0x25, 0x90} }, /* 0x16 */
> -	{ {0xA1, 0x7F, 0x85, 0x86, 0x97, 0x00, 0x02, 0x00,
> -	  0x24, 0xF5, 0x02, 0x88, 0xFF, 0x25, 0x90} }, /* 0x17 */
> -	{ {0x9F, 0x7F, 0x83, 0x85, 0x91, 0x00, 0x02, 0x00,
> -	  0x1E, 0xF5, 0x00, 0x83, 0xFF, 0x1F, 0x90} }, /* 0x18 */
> -	{ {0xA7, 0x7F, 0x8B, 0x89, 0x95, 0x00, 0x02, 0x00,
> -	  0x26, 0xF5, 0x00, 0x83, 0xFF, 0x27, 0x90} }, /* 0x19 */
> -	{ {0xA9, 0x7F, 0x8D, 0x8C, 0x9A, 0x00, 0x02, 0x62,
> -	  0x2C, 0xF5, 0x00, 0x83, 0xFF, 0x2D, 0x14} }, /* 0x1a */
> -	{ {0xAB, 0x7F, 0x8F, 0x8D, 0x9B, 0x00, 0x02, 0x62,
> -	  0x35, 0xF5, 0x00, 0x83, 0xFF, 0x36, 0x14} }, /* 0x1b */
> -	{ {0xCF, 0x9F, 0x93, 0xB2, 0x01, 0x00, 0x03, 0x00,
> -	  0x14, 0xBA, 0x00, 0x83, 0xFF, 0x15, 0x00} }, /* 0x1c */
> -	{ {0xCE, 0x9F, 0x92, 0xA9, 0x17, 0x00, 0x07, 0x00,
> -	  0x28, 0x5A, 0x00, 0x83, 0xFF, 0x29, 0x89} }, /* 0x1d */
> -	{ {0xCE, 0x9F, 0x92, 0xA5, 0x17, 0x00, 0x07, 0x00,
> -	  0x28, 0x5A, 0x00, 0x83, 0xFF, 0x29, 0x89} }, /* 0x1e */
> -	{ {0xD3, 0x9F, 0x97, 0xAB, 0x1F, 0x00, 0x07, 0x00,
> -	  0x2E, 0x5A, 0x00, 0x83, 0xFF, 0x2F, 0x89} }, /* 0x1f */
> -	{ {0x09, 0xC7, 0x8D, 0xD3, 0x0B, 0x01, 0x04, 0x00,
> -	  0xE0, 0x10, 0xB0, 0x83, 0xAF, 0xE1, 0x2F} }, /* 0x20 */
> -	{ {0x09, 0xC7, 0x8D, 0xD3, 0x0B, 0x01, 0x04, 0x00,
> -	  0xE0, 0x10, 0xB0, 0x83, 0xAF, 0xE1, 0x2F} }, /* 0x21 */
> -	{ {0x09, 0xC7, 0x8D, 0xD3, 0x0B, 0x01, 0x04, 0x00,
> -	  0xE0, 0x10, 0xB0, 0x83, 0xAF, 0xE1, 0x2F} }, /* 0x22 */
> -	{ {0x09, 0xC7, 0x8D, 0xD3, 0x0B, 0x01, 0x04, 0x00,
> -	  0xE0, 0x10, 0xB0, 0x83, 0xAF, 0xE1, 0x2F} }, /* 0x23 */
> -	{ {0x09, 0xC7, 0x8D, 0xD3, 0x0B, 0x01, 0x04, 0x00,
> -	  0xE0, 0x10, 0xB0, 0x83, 0xAF, 0xE1, 0x2F} }, /* 0x24 */
> -	{ {0x09, 0xC7, 0x8D, 0xD3, 0x0B, 0x01, 0x04, 0x00,
> -	  0xE0, 0x10, 0xB0, 0x83, 0xAF, 0xE1, 0x2F} }, /* 0x25 */
> -	{ {0x09, 0xC7, 0x8D, 0xD3, 0x0B, 0x01, 0x04, 0x00,
> -	  0xE0, 0x10, 0xB0, 0x83, 0xAF, 0xE1, 0x2F} }, /* 0x26 */
> -	{ {0x40, 0xEF, 0x84, 0x03, 0x1D, 0x41, 0x01, 0x00,
> -	  0xDA, 0x1F, 0xA0, 0x83, 0x9F, 0xDB, 0x1F} }, /* 0x27 */
> -	{ {0x43, 0xEF, 0x87, 0x06, 0x00, 0x41, 0x05, 0x62,
> -	  0xD4, 0x1F, 0xA0, 0x83, 0x9F, 0xD5, 0x9F} }, /* 0x28 */
> -	{ {0x45, 0xEF, 0x89, 0x07, 0x01, 0x41, 0x05, 0x62,
> -	  0xD9, 0x1F, 0xA0, 0x83, 0x9F, 0xDA, 0x9F} }, /* 0x29 */
> -	{ {0x40, 0xEF, 0x84, 0x03, 0x1D, 0x41, 0x01, 0x00,
> -	  0xDA, 0x1F, 0xA0, 0x83, 0x9F, 0xDB, 0x1F} }, /* 0x2a */
> -	{ {0x40, 0xEF, 0x84, 0x03, 0x1D, 0x41, 0x01, 0x00,
> -	  0xDA, 0x1F, 0xA0, 0x83, 0x9F, 0xDB, 0x1F} }, /* 0x2b */
> -	{ {0x40, 0xEF, 0x84, 0x03, 0x1D, 0x41, 0x01, 0x00,
> -	  0xDA, 0x1F, 0xA0, 0x83, 0x9F, 0xDB, 0x1F} }, /* 0x2c */
> -	{ {0x59, 0xFF, 0x9D, 0x17, 0x13, 0x41, 0x05, 0x44,
> -	  0x33, 0xBA, 0x00, 0x83, 0xFF, 0x34, 0x0F} }, /* 0x2d */
> -	{ {0x5B, 0xFF, 0x9F, 0x18, 0x14, 0x41, 0x05, 0x44,
> -	  0x38, 0xBA, 0x00, 0x83, 0xFF, 0x39, 0x0F} }, /* 0x2e */
> -	{ {0x5B, 0xFF, 0x9F, 0x18, 0x14, 0x41, 0x05, 0x44,
> -	  0x3D, 0xBA, 0x00, 0x83, 0xFF, 0x3E, 0x0F} }, /* 0x2f */
> -	{ {0x5D, 0xFF, 0x81, 0x19, 0x95, 0x41, 0x05, 0x44,
> -	  0x41, 0xBA, 0x00, 0x84, 0xFF, 0x42, 0x0F} }, /* 0x30 */
> -	{ {0x55, 0xFF, 0x99, 0x0D, 0x0C, 0x41, 0x05, 0x00,
> -	  0x3E, 0xBA, 0x00, 0x84, 0xFF, 0x3F, 0x0F} }, /* 0x31 */
> -	{ {0x7F, 0x63, 0x83, 0x6C, 0x1C, 0x00, 0x06, 0x00,
> -	  0x72, 0xBA, 0x27, 0x8B, 0xDF, 0x73, 0x80} }, /* 0x32 */
> -	{ {0x7F, 0x63, 0x83, 0x69, 0x13, 0x00, 0x06, 0x00,
> -	  0x6F, 0xBA, 0x26, 0x89, 0xDF, 0x6F, 0x80} }, /* 0x33 */
> -	{ {0x7F, 0x63, 0x82, 0x6B, 0x13, 0x00, 0x06, 0x00,
> -	  0x75, 0xBA, 0x29, 0x8C, 0xDF, 0x75, 0x80} }, /* 0x34 */
> -	{ {0xA3, 0x7F, 0x87, 0x86, 0x97, 0x00, 0x02, 0x00,
> -	  0x24, 0xF1, 0xAF, 0x85, 0x3F, 0x25, 0xB0} }, /* 0x35 */
> -	{ {0x9F, 0x7F, 0x83, 0x85, 0x91, 0x00, 0x02, 0x00,
> -	  0x1E, 0xF1, 0xAD, 0x81, 0x3F, 0x1F, 0xB0} }, /* 0x36 */
> -	{ {0xA7, 0x7F, 0x88, 0x89, 0x15, 0x00, 0x02, 0x00,
> -	  0x26, 0xF1, 0xB1, 0x85, 0x3F, 0x27, 0xB0} }, /* 0x37 */
> -	{ {0xCE, 0x9F, 0x92, 0xA9, 0x17, 0x00, 0x07, 0x00,
> -	  0x28, 0xC4, 0x7A, 0x8E, 0xCF, 0x29, 0xA1} }, /* 0x38 */
> -	{ {0xCE, 0x9F, 0x92, 0xA5, 0x17, 0x00, 0x07, 0x00,
> -	  0x28, 0xD4, 0x7A, 0x8E, 0xCF, 0x29, 0xA1} }, /* 0x39 */
> -	{ {0xD3, 0x9F, 0x97, 0xAB, 0x1F, 0x00, 0x07, 0x00,
> -	  0x2E, 0xD4, 0x7D, 0x81, 0xCF, 0x2F, 0xA1} }, /* 0x3a */
> -	{ {0xDC, 0x9F, 0x00, 0xAB, 0x19, 0x00, 0x07, 0x00,
> -	  0xE6, 0xEF, 0xC0, 0xC3, 0xBF, 0xE7, 0x90} }, /* 0x3b */
> -	{ {0x6B, 0x59, 0x8F, 0x5E, 0x8C, 0x00, 0x05, 0x00,
> -	  0x0B, 0x3E, 0xE9, 0x8B, 0xE7, 0x04, 0x00} }, /* 0x3c */
> -	{ {0x7B, 0x63, 0x9F, 0x6A, 0x93, 0x00, 0x05, 0x00,
> -	  0x6F, 0xF0, 0x58, 0x8A, 0x57, 0x70, 0xA0} }, /* 0x3d */
> -	{ {0x86, 0x6A, 0x8a, 0x74, 0x06, 0x00, 0x02, 0x00,
> -	  0x8c, 0x15, 0x4f, 0x83, 0xef, 0x8d, 0x30} }, /* 0x3e */
> -	{ {0x81, 0x6A, 0x85, 0x70, 0x00, 0x00, 0x02, 0x00,
> -	  0x0f, 0x3e, 0xeb, 0x8e, 0xdf, 0x10, 0x00} }, /* 0x3f */
> -	{ {0xCE, 0x9F, 0x92, 0xA9, 0x17, 0x00, 0x07, 0x00,
> -	  0x20, 0xF5, 0x03, 0x88, 0xFF, 0x21, 0x90} }, /* 0x40 */
> -	{ {0xE6, 0xAE, 0x8A, 0xBD, 0x90, 0x00, 0x03, 0x00,
> -	  0x3D, 0x10, 0x1A, 0x8D, 0x19, 0x3E, 0x2F} }, /* 0x41 */
> -	{ {0xB9, 0x8F, 0x9D, 0x9B, 0x8A, 0x00, 0x06, 0x00,
> -	  0x7D, 0xFF, 0x60, 0x83, 0x5F, 0x7E, 0x90} }, /* 0x42 */
> -	{ {0xC3, 0x8F, 0x87, 0x9B, 0x0B, 0x00, 0x07, 0x00,
> -	  0x82, 0xFF, 0x60, 0x83, 0x5F, 0x83, 0x90} },  /* 0x43 */
> -	{ {0xAD, 0x7F, 0x91, 0x8E, 0x9C, 0x00, 0x02, 0x82,
> -	  0x49, 0xF5, 0x00, 0x83, 0xFF, 0x4A, 0x90} },  /* 0x44 */
> -	{ {0xCD, 0x9F, 0x91, 0xA7, 0x19, 0x00, 0x07, 0x60,
> -	  0xE6, 0xFF, 0xC0, 0x83, 0xBF, 0xE7, 0x90} },  /* 0x45 */
> -	{ {0xD3, 0x9F, 0x97, 0xAB, 0x1F, 0x00, 0x07, 0x60,
> -	  0xF1, 0xFF, 0xC0, 0x83, 0xBF, 0xF2, 0x90} },  /* 0x46 */
> -	{ {0xD7, 0x9F, 0x9B, 0xAC, 0x1E, 0x00, 0x07, 0x00,
> -	  0x03, 0xDE, 0xC0, 0x84, 0xBF, 0x04, 0x90} }  /* 0x47 */
> -};
> -
> -/*add for new UNIVGABIOS*/
> -static const struct SiS_LCDData XGI_StLCD1024x768Data[] = {
> -	{62,  25, 800,  546, 1344, 806},
> -	{32,  15, 930,  546, 1344, 806},
> -	{62,  25, 800,  546, 1344, 806}, /*chiawenfordot9->dot8*/
> -	{104, 45, 945,  496, 1344, 806},
> -	{62,  25, 800,  546, 1344, 806},
> -	{31,  18, 1008, 624, 1344, 806},
> -	{1,   1,  1344, 806, 1344, 806}
> -};
> -
> -static const struct SiS_LCDData XGI_ExtLCD1024x768Data[] = {
> -	{42, 25, 1536, 419, 1344, 806},
> -	{48, 25, 1536, 369, 1344, 806},
> -	{42, 25, 1536, 419, 1344, 806},
> -	{48, 25, 1536, 369, 1344, 806},
> -	{12, 5,  896,  500, 1344, 806},
> -	{42, 25, 1024, 625, 1344, 806},
> -	{1,  1,  1344, 806, 1344, 806},
> -	{12, 5,  896,  500, 1344, 806},
> -	{42, 25, 1024, 625, 1344, 806},
> -	{1,  1,  1344, 806, 1344, 806},
> -	{12, 5,  896,  500, 1344, 806},
> -	{42, 25, 1024, 625, 1344, 806},
> -	{1,  1,  1344, 806, 1344, 806}
> -};
> -
> -static const struct SiS_LCDData XGI_CetLCD1024x768Data[] = {
> -	{1, 1, 1344, 806, 1344, 806}, /* ; 00 (320x200,320x400,
> -				       *       640x200,640x400)
> -				       */
> -	{1, 1, 1344, 806, 1344, 806}, /* 01 (320x350,640x350) */
> -	{1, 1, 1344, 806, 1344, 806}, /* 02 (360x400,720x400) */
> -	{1, 1, 1344, 806, 1344, 806}, /* 03 (720x350) */
> -	{1, 1, 1344, 806, 1344, 806}, /* 04 (640x480x60Hz) */
> -	{1, 1, 1344, 806, 1344, 806}, /* 05 (800x600x60Hz) */
> -	{1, 1, 1344, 806, 1344, 806}  /* 06 (1024x768x60Hz) */
> -};
> -
> -static const struct SiS_LCDData XGI_StLCD1280x1024Data[] = {
> -	{22,  5,  800,  510,  1650, 1088},
> -	{22,  5,  800,  510,  1650, 1088},
> -	{176, 45, 900,  510,  1650, 1088},
> -	{176, 45, 900,  510,  1650, 1088},
> -	{22,  5,  800,  510,  1650, 1088},
> -	{13,  5,  1024, 675,  1560, 1152},
> -	{16,  9,  1266, 804,  1688, 1072},
> -	{1,   1,  1688, 1066, 1688, 1066}
> -};
> -
> -static const struct SiS_LCDData XGI_ExtLCD1280x1024Data[] = {
> -	{211, 60,  1024, 501,  1688, 1066},
> -	{211, 60,  1024, 508,  1688, 1066},
> -	{211, 60,  1024, 501,  1688, 1066},
> -	{211, 60,  1024, 508,  1688, 1066},
> -	{211, 60,  1024, 500,  1688, 1066},
> -	{211, 75,  1024, 625,  1688, 1066},
> -	{211, 120, 1280, 798,  1688, 1066},
> -	{1,   1,   1688, 1066, 1688, 1066}
> -};
> -
> -static const struct SiS_LCDData XGI_CetLCD1280x1024Data[] = {
> -	{1, 1, 1688, 1066, 1688, 1066}, /* 00 (320x200,320x400,
> -					 *     640x200,640x400)
> -					 */
> -	{1, 1, 1688, 1066, 1688, 1066}, /* 01 (320x350,640x350) */
> -	{1, 1, 1688, 1066, 1688, 1066}, /* 02 (360x400,720x400) */
> -	{1, 1, 1688, 1066, 1688, 1066}, /* 03 (720x350) */
> -	{1, 1, 1688, 1066, 1688, 1066}, /* 04 (640x480x60Hz) */
> -	{1, 1, 1688, 1066, 1688, 1066}, /* 05 (800x600x60Hz) */
> -	{1, 1, 1688, 1066, 1688, 1066}, /* 06 (1024x768x60Hz) */
> -	{1, 1, 1688, 1066, 1688, 1066}, /* 07 (1280x1024x60Hz) */
> -	{1, 1, 1688, 1066, 1688, 1066}  /* 08 (1400x1050x60Hz) */
> -};
> -
> -static const struct SiS_LCDData xgifb_lcd_1400x1050[] = {
> -	{211, 100, 2100, 408,  1688, 1066}, /* 00 (320x200,320x400,
> -					     *     640x200,640x400)
> -					     */
> -	{211, 64,  1536, 358,  1688, 1066}, /* 01 (320x350,640x350) */
> -	{211, 100, 2100, 408,  1688, 1066}, /* 02 (360x400,720x400) */
> -	{211, 64,  1536, 358,  1688, 1066}, /* 03 (720x350) */
> -	{211, 48,  840,  488,  1688, 1066}, /* 04 (640x480x60Hz) */
> -	{211, 72,  1008, 609,  1688, 1066}, /* 05 (800x600x60Hz) */
> -	{211, 128, 1400, 776,  1688, 1066}, /* 06 (1024x768x60Hz) */
> -	{1,   1,   1688, 1066, 1688, 1066}, /* 07 (1280x1024x60Hz
> -					     *    w/o Scaling)
> -					     */
> -	{1,   1,   1688, 1066, 1688, 1066}  /* 08 (1400x1050x60Hz) */
> -};
> -
> -static const struct SiS_LCDData XGI_ExtLCD1600x1200Data[] = {
> -	{4,  1,  1620, 420,  2160, 1250}, /* 00 (320x200,320x400,
> -					   *     640x200,640x400)
> -					   */
> -	{27, 7,  1920, 375,  2160, 1250}, /* 01 (320x350,640x350) */
> -	{4,  1,  1620, 420,  2160, 1250}, /* 02 (360x400,720x400)*/
> -	{27, 7,  1920, 375,  2160, 1250}, /* 03 (720x350) */
> -	{27, 4,  800,  500,  2160, 1250}, /* 04 (640x480x60Hz) */
> -	{4,  1,  1080, 625,  2160, 1250}, /* 05 (800x600x60Hz) */
> -	{5,  2,  1350, 800,  2160, 1250}, /* 06 (1024x768x60Hz) */
> -	{27, 16, 1500, 1064, 2160, 1250}, /* 07 (1280x1024x60Hz) */
> -	{9,  7,  1920, 1106, 2160, 1250}, /* 08 (1400x1050x60Hz) */
> -	{1,  1,  2160, 1250, 2160, 1250}  /* 09 (1600x1200x60Hz) ;302lv */
> -};
> -
> -static const struct SiS_LCDData XGI_StLCD1600x1200Data[] = {
> -	{27,  4,  800,  500,  2160, 1250}, /* 00 (320x200,320x400,
> -					    *     640x200,640x400)
> -					    */
> -	{27,  4,  800,  500,  2160, 1250}, /* 01 (320x350,640x350) */
> -	{27,  4,  800,  500,  2160, 1250}, /* 02 (360x400,720x400) */
> -	{27,  4,  800,  500,  2160, 1250}, /* 03 (720x350) */
> -	{27,  4,  800,  500,  2160, 1250}, /* 04 (320x240,640x480) */
> -	{4,   1,  1080, 625,  2160, 1250}, /* 05 (400x300,800x600) */
> -	{5,   2,  1350, 800,  2160, 1250}, /* 06 (512x384,1024x768) */
> -	{135, 88, 1600, 1100, 2160, 1250}, /* 07 (1280x1024) */
> -	{1,   1,  1800, 1500, 2160, 1250}, /* 08 (1400x1050) */
> -	{1,   1,  2160, 1250, 2160, 1250}  /* 09 (1600x1200) */
> -};
> -
> -#define XGI_CetLCD1400x1050Data XGI_CetLCD1280x1024Data
> -
> -static const struct SiS_LCDData XGI_NoScalingData[] = {
> -	{1, 1, 800,  449,  800,  449},
> -	{1, 1, 800,  449,  800,  449},
> -	{1, 1, 900,  449,  900,  449},
> -	{1, 1, 900,  449,  900,  449},
> -	{1, 1, 800,  525,  800,  525},
> -	{1, 1, 1056, 628,  1056, 628},
> -	{1, 1, 1344, 806,  1344, 806},
> -	{1, 1, 1688, 1066, 1688, 1066}
> -};
> -
> -static const struct SiS_LCDData XGI_ExtLCD1024x768x75Data[] = {
> -	{42, 25, 1536, 419, 1344, 806}, /* ; 00 (320x200,320x400,
> -					 *       640x200,640x400)
> -					 */
> -	{48, 25, 1536, 369, 1344, 806}, /* ; 01 (320x350,640x350) */
> -	{42, 25, 1536, 419, 1344, 806}, /* ; 02 (360x400,720x400) */
> -	{48, 25, 1536, 369, 1344, 806}, /* ; 03 (720x350) */
> -	{8,  5,  1312, 500, 1312, 800}, /* ; 04 (640x480x75Hz) */
> -	{41, 25, 1024, 625, 1312, 800}, /* ; 05 (800x600x75Hz) */
> -	{1,  1,  1312, 800, 1312, 800}  /* ; 06 (1024x768x75Hz) */
> -};
> -
> -static const struct SiS_LCDData XGI_CetLCD1024x768x75Data[] = {
> -	{1, 1, 1312, 800, 1312, 800}, /* ; 00 (320x200,320x400,
> -				       *       640x200,640x400)
> -				       */
> -	{1, 1, 1312, 800, 1312, 800}, /* ; 01 (320x350,640x350) */
> -	{1, 1, 1312, 800, 1312, 800}, /* ; 02 (360x400,720x400) */
> -	{1, 1, 1312, 800, 1312, 800}, /* ; 03 (720x350) */
> -	{1, 1, 1312, 800, 1312, 800}, /* ; 04 (640x480x75Hz) */
> -	{1, 1, 1312, 800, 1312, 800}, /* ; 05 (800x600x75Hz) */
> -	{1, 1, 1312, 800, 1312, 800}  /* ; 06 (1024x768x75Hz) */
> -};
> -
> -static const struct SiS_LCDData xgifb_lcd_1280x1024x75[] = {
> -	{211, 60,  1024, 501,  1688, 1066}, /* ; 00 (320x200,320x400,
> -					     *       640x200,640x400)
> -					     */
> -	{211, 60,  1024, 508,  1688, 1066}, /* ; 01 (320x350,640x350) */
> -	{211, 60,  1024, 501,  1688, 1066}, /* ; 02 (360x400,720x400) */
> -	{211, 60,  1024, 508,  1688, 1066}, /* ; 03 (720x350) */
> -	{211, 45,  768,  498,  1688, 1066}, /* ; 04 (640x480x75Hz) */
> -	{211, 75,  1024, 625,  1688, 1066}, /* ; 05 (800x600x75Hz) */
> -	{211, 120, 1280, 798,  1688, 1066}, /* ; 06 (1024x768x75Hz) */
> -	{1,   1,   1688, 1066, 1688, 1066}  /* ; 07 (1280x1024x75Hz) */
> -};
> -
> -#define XGI_CetLCD1280x1024x75Data XGI_CetLCD1280x1024Data
> -
> -static const struct SiS_LCDData XGI_NoScalingDatax75[] = {
> -	{1, 1, 800,  449,  800,  449},  /* ; 00 (320x200, 320x400,
> -					 *       640x200, 640x400)
> -					 */
> -	{1, 1, 800,  449,  800,  449},  /* ; 01 (320x350, 640x350) */
> -	{1, 1, 900,  449,  900,  449},  /* ; 02 (360x400, 720x400) */
> -	{1, 1, 900,  449,  900,  449},  /* ; 03 (720x350) */
> -	{1, 1, 840,  500,  840,  500},  /* ; 04 (640x480x75Hz) */
> -	{1, 1, 1056, 625,  1056, 625},  /* ; 05 (800x600x75Hz) */
> -	{1, 1, 1312, 800,  1312, 800},  /* ; 06 (1024x768x75Hz) */
> -	{1, 1, 1688, 1066, 1688, 1066}, /* ; 07 (1280x1024x75Hz) */
> -	{1, 1, 1688, 1066, 1688, 1066}, /* ; 08 (1400x1050x75Hz)*/
> -	{1, 1, 2160, 1250, 2160, 1250}, /* ; 09 (1600x1200x75Hz) */
> -	{1, 1, 1688, 806,  1688, 806}   /* ; 0A (1280x768x75Hz) */
> -};
> -
> -static const struct XGI_LCDDesStruct XGI_ExtLCDDes1024x768Data[] = {
> -	{9, 1057, 0,   771}, /* ; 00 (320x200,320x400,640x200,640x400) */
> -	{9, 1057, 0,   771}, /* ; 01 (320x350,640x350) */
> -	{9, 1057, 0,   771}, /* ; 02 (360x400,720x400) */
> -	{9, 1057, 0,   771}, /* ; 03 (720x350) */
> -	{9, 1057, 0,   771}, /* ; 04 (640x480x60Hz) */
> -	{9, 1057, 0,   771}, /* ; 05 (800x600x60Hz) */
> -	{9, 1057, 805, 770}  /* ; 06 (1024x768x60Hz) */
> -};
> -
> -static const struct XGI_LCDDesStruct XGI_StLCDDes1024x768Data[] = {
> -	{9, 1057, 737, 703}, /* ; 00 (320x200,320x400,640x200,640x400) */
> -	{9, 1057, 686, 651}, /* ; 01 (320x350,640x350) */
> -	{9, 1057, 737, 703}, /* ; 02 (360x400,720x400) */
> -	{9, 1057, 686, 651}, /* ; 03 (720x350) */
> -	{9, 1057, 776, 741}, /* ; 04 (640x480x60Hz) */
> -	{9, 1057, 0,   771}, /* ; 05 (800x600x60Hz) */
> -	{9, 1057, 805, 770}  /* ; 06 (1024x768x60Hz) */
> -};
> -
> -static const struct XGI_LCDDesStruct XGI_CetLCDDes1024x768Data[] = {
> -	{1152, 856,  622, 587}, /* ; 00 (320x200,320x400,640x200,640x400) */
> -	{1152, 856,  597, 562}, /* ; 01 (320x350,640x350) */
> -	{1152, 856,  622, 587}, /* ; 02 (360x400,720x400) */
> -	{1152, 856,  597, 562}, /* ; 03 (720x350) */
> -	{1152, 856,  662, 627}, /* ; 04 (640x480x60Hz) */
> -	{1232, 936,  722, 687}, /* ; 05 (800x600x60Hz) */
> -	{0,    1048, 805, 770}  /* ; 06 (1024x768x60Hz) */
> -};
> -
> -static const struct XGI_LCDDesStruct XGI_ExtLCDDLDes1280x1024Data[] = {
> -	{18, 1346, 981,  940},  /* 00 (320x200,320x400,640x200,640x400) */
> -	{18, 1346, 926,  865},  /* 01 (320x350,640x350) */
> -	{18, 1346, 981,  940},  /* 02 (360x400,720x400) */
> -	{18, 1346, 926,  865},  /* 03 (720x350) */
> -	{18, 1346, 0,    1025}, /* 04 (640x480x60Hz) */
> -	{18, 1346, 0,    1025}, /* 05 (800x600x60Hz) */
> -	{18, 1346, 1065, 1024}, /* 06 (1024x768x60Hz) */
> -	{18, 1346, 1065, 1024}  /* 07 (1280x1024x60Hz) */
> -};
> -
> -static const struct XGI_LCDDesStruct XGI_StLCDDLDes1280x1024Data[] = {
> -	{18, 1346, 970,  907},  /* 00 (320x200,320x400,640x200,640x400) */
> -	{18, 1346, 917,  854},  /* 01 (320x350,640x350) */
> -	{18, 1346, 970,  907},  /* 02 (360x400,720x400) */
> -	{18, 1346, 917,  854},  /* 03 (720x350) */
> -	{18, 1346, 0,    1025}, /* 04 (640x480x60Hz) */
> -	{18, 1346, 0,    1025}, /* 05 (800x600x60Hz) */
> -	{18, 1346, 1065, 1024}, /* 06 (1024x768x60Hz) */
> -	{18, 1346, 1065, 1024}  /* 07 (1280x1024x60Hz) */
> -};
> -
> -static const struct XGI_LCDDesStruct XGI_CetLCDDLDes1280x1024Data[] = {
> -	{1368, 1008, 752,  711}, /* 00 (320x200,320x400,640x200,640x400) */
> -	{1368, 1008, 729,  688}, /* 01 (320x350,640x350) */
> -	{1368, 1008, 752,  711}, /* 02 (360x400,720x400) */
> -	{1368, 1008, 729,  688}, /* 03 (720x350) */
> -	{1368, 1008, 794,  753}, /* 04 (640x480x60Hz) */
> -	{1448, 1068, 854,  813}, /* 05 (800x600x60Hz) */
> -	{1560, 1200, 938,  897}, /* 06 (1024x768x60Hz) */
> -	{18,   1346, 1065, 1024} /* 07 (1280x1024x60Hz) */
> -};
> -
> -static const struct XGI_LCDDesStruct XGI_ExtLCDDes1280x1024Data[] = {
> -	{9, 1337, 981,  940},  /* ; 00 (320x200,320x400,640x200,640x400) */
> -	{9, 1337, 926,  884},  /* ; 01 (320x350,640x350) alan, 2003/09/30 */
> -	{9, 1337, 981,  940},  /* ; 02 (360x400,720x400) */
> -	{9, 1337, 926,  884},  /* ; 03 (720x350) alan, 2003/09/30 */
> -	{9, 1337, 0,    1025}, /* ; 04 (640x480x60Hz) */
> -	{9, 1337, 0,    1025}, /* ; 05 (800x600x60Hz) */
> -	{9, 1337, 1065, 1024}, /* ; 06 (1024x768x60Hz) */
> -	{9, 1337, 1065, 1024}  /* ; 07 (1280x1024x60Hz) */
> -};
> -
> -static const struct XGI_LCDDesStruct XGI_StLCDDes1280x1024Data[] = {
> -	{9, 1337, 970,  907},  /* ; 00 (320x200,320x400,640x200,640x400) */
> -	{9, 1337, 917,  854},  /* ; 01 (320x350,640x350) */
> -	{9, 1337, 970,  907},  /* ; 02 (360x400,720x400) */
> -	{9, 1337, 917,  854},  /* ; 03 (720x350) */
> -	{9, 1337, 0,    1025}, /* ; 04 (640x480x60Hz) */
> -	{9, 1337, 0,    1025}, /* ; 05 (800x600x60Hz) */
> -	{9, 1337, 1065, 1024}, /* ; 06 (1024x768x60Hz) */
> -	{9, 1337, 1065, 1024}  /* ; 07 (1280x1024x60Hz) */
> -};
> -
> -static const struct XGI_LCDDesStruct XGI_CetLCDDes1280x1024Data[] = {
> -	{1368, 1008, 752,  711}, /* 00 (320x200,320x400,640x200,640x400) */
> -	{1368, 1008, 729,  688}, /* 01 (320x350,640x350) */
> -	{1368, 1008, 752,  711}, /* 02 (360x400,720x400) */
> -	{1368, 1008, 729,  688}, /* 03 (720x350) */
> -	{1368, 1008, 794,  753}, /* 04 (640x480x60Hz) */
> -	{1448, 1068, 854,  813}, /* 05 (800x600x60Hz) */
> -	{1560, 1200, 938,  897}, /* 06 (1024x768x60Hz) */
> -	{9,    1337, 1065, 1024} /* 07 (1280x1024x60Hz) */
> -};
> -
> -static const struct XGI_LCDDesStruct xgifb_lcddldes_1400x1050[] = {
> -	{18,   1464, 0,    1051}, /* 00 (320x200,320x400,640x200,640x400) */
> -	{18,   1464, 0,    1051}, /* 01 (320x350,640x350) */
> -	{18,   1464, 0,    1051}, /* 02 (360x400,720x400) */
> -	{18,   1464, 0,    1051}, /* 03 (720x350) */
> -	{18,   1464, 0,    1051}, /* 04 (640x480x60Hz) */
> -	{18,   1464, 0,    1051}, /* 05 (800x600x60Hz) */
> -	{18,   1464, 0,    1051}, /* 06 (1024x768x60Hz) */
> -	{1646, 1406, 1053, 1038}, /* 07 (1280x1024x60Hz) */
> -	{18,   1464, 0,    1051}  /* 08 (1400x1050x60Hz) */
> -};
> -
> -static const struct XGI_LCDDesStruct xgifb_lcddes_1400x1050[] = {
> -	{9,    1455, 0,    1051}, /* 00 (320x200,320x400,640x200,640x400) */
> -	{9,    1455, 0,    1051}, /* 01 (320x350,640x350) */
> -	{9,    1455, 0,    1051}, /* 02 (360x400,720x400) */
> -	{9,    1455, 0,    1051}, /* 03 (720x350) */
> -	{9,    1455, 0,    1051}, /* 04 (640x480x60Hz) */
> -	{9,    1455, 0,    1051}, /* 05 (800x600x60Hz) */
> -	{9,    1455, 0,    1051}, /* 06 (1024x768x60Hz) */
> -	{1637, 1397, 1053, 1038}, /* 07 (1280x1024x60Hz) */
> -	{9,    1455, 0,    1051}  /* 08 (1400x1050x60Hz) */
> -};
> -
> -static const struct XGI_LCDDesStruct XGI_CetLCDDes1400x1050Data[] = {
> -	{1308, 1068, 781,  766},  /* 00 (320x200,320x400,640x200,640x400) */
> -	{1308, 1068, 781,  766},  /* 01 (320x350,640x350) */
> -	{1308, 1068, 781,  766},  /* 02 (360x400,720x400) */
> -	{1308, 1068, 781,  766},  /* 03 (720x350) */
> -	{1308, 1068, 781,  766},  /* 04 (640x480x60Hz) */
> -	{1388, 1148, 841,  826},  /* 05 (800x600x60Hz) */
> -	{1490, 1250, 925,  910},  /* 06 (1024x768x60Hz) */
> -	{1646, 1406, 1053, 1038}, /* 07 (1280x1024x60Hz) */
> -	{18,   1464, 0,    1051}  /* 08 (1400x1050x60Hz) */
> -};
> -
> -static const struct XGI_LCDDesStruct XGI_CetLCDDes1400x1050Data2[] = {
> -	{0, 1448, 0, 1051}, /* 00 (320x200,320x400,640x200,640x400) */
> -	{0, 1448, 0, 1051}, /* 01 (320x350,640x350) */
> -	{0, 1448, 0, 1051}, /* 02 (360x400,720x400) */
> -	{0, 1448, 0, 1051}, /* 03 (720x350) */
> -	{0, 1448, 0, 1051}  /* 04 (640x480x60Hz) */
> -};
> -
> -static const struct XGI_LCDDesStruct XGI_ExtLCDDLDes1600x1200Data[] = {
> -	{18, 1682, 0, 1201}, /* 00 (320x200,320x400,640x200,640x400) */
> -	{18, 1682, 0, 1201}, /* 01 (320x350,640x350) */
> -	{18, 1682, 0, 1201}, /* 02 (360x400,720x400) */
> -	{18, 1682, 0, 1201}, /* 03 (720x350) */
> -	{18, 1682, 0, 1201}, /* 04 (640x480x60Hz) */
> -	{18, 1682, 0, 1201}, /* 05 (800x600x60Hz) */
> -	{18, 1682, 0, 1201}, /* 06 (1024x768x60Hz) */
> -	{18, 1682, 0, 1201}, /* 07 (1280x1024x60Hz) */
> -	{18, 1682, 0, 1201}, /* 08 (1400x1050x60Hz) */
> -	{18, 1682, 0, 1201}  /* 09 (1600x1200x60Hz) */
> -};
> -
> -static const struct XGI_LCDDesStruct XGI_StLCDDLDes1600x1200Data[] = {
> -	{18, 1682, 1150, 1101}, /* 00 (320x200,320x400,640x200,640x400) */
> -	{18, 1682, 1083, 1034}, /* 01 (320x350,640x350) */
> -	{18, 1682, 1150, 1101}, /* 02 (360x400,720x400) */
> -	{18, 1682, 1083, 1034}, /* 03 (720x350) */
> -	{18, 1682, 0,    1201}, /* 04 (640x480x60Hz) */
> -	{18, 1682, 0,    1201}, /* 05 (800x600x60Hz) */
> -	{18, 1682, 0,    1201}, /* 06 (1024x768x60Hz) */
> -	{18, 1682, 1232, 1183}, /* 07 (1280x1024x60Hz) */
> -	{18, 1682, 0,    1201}, /* 08 (1400x1050x60Hz) */
> -	{18, 1682, 0,    1201} /* 09 (1600x1200x60Hz) */
> -};
> -
> -static const struct XGI_LCDDesStruct XGI_ExtLCDDes1600x1200Data[] = {
> -	{9, 1673, 0, 1201}, /* 00 (320x200,320x400,640x200,640x400) */
> -	{9, 1673, 0, 1201}, /* 01 (320x350,640x350) */
> -	{9, 1673, 0, 1201}, /* 02 (360x400,720x400) */
> -	{9, 1673, 0, 1201}, /* 03 (720x350) */
> -	{9, 1673, 0, 1201}, /* 04 (640x480x60Hz) */
> -	{9, 1673, 0, 1201}, /* 05 (800x600x60Hz) */
> -	{9, 1673, 0, 1201}, /* 06 (1024x768x60Hz) */
> -	{9, 1673, 0, 1201}, /* 07 (1280x1024x60Hz) */
> -	{9, 1673, 0, 1201}, /* 08 (1400x1050x60Hz) */
> -	{9, 1673, 0, 1201}  /* 09 (1600x1200x60Hz) */
> -};
> -
> -static const struct XGI_LCDDesStruct XGI_StLCDDes1600x1200Data[] = {
> -	{9, 1673, 1150, 1101}, /* 00 (320x200,320x400,640x200,640x400) */
> -	{9, 1673, 1083, 1034}, /* 01 (320x350,640x350) */
> -	{9, 1673, 1150, 1101}, /* 02 (360x400,720x400) */
> -	{9, 1673, 1083, 1034}, /* 03 (720x350) */
> -	{9, 1673, 0,    1201}, /* 04 (640x480x60Hz) */
> -	{9, 1673, 0,    1201}, /* 05 (800x600x60Hz) */
> -	{9, 1673, 0,    1201}, /* 06 (1024x768x60Hz) */
> -	{9, 1673, 1232, 1183}, /* 07 (1280x1024x60Hz) */
> -	{9, 1673, 0,    1201}, /* 08 (1400x1050x60Hz) */
> -	{9, 1673, 0,    1201}  /* 09 (1600x1200x60Hz) */
> -};
> -
> -static const struct XGI330_LCDDataDesStruct2  XGI_NoScalingDesData[] = {
> -	{9, 657,  448, 405,  96,   2}, /* 00 (320x200,320x400,
> -					*     640x200,640x400)
> -					*/
> -	{9, 657,  448, 355,  96,   2}, /* 01 (320x350,640x350) */
> -	{9, 657,  448, 405,  96,   2}, /* 02 (360x400,720x400) */
> -	{9, 657,  448, 355,  96,   2}, /* 03 (720x350) */
> -	{9, 657,  1,   483,  96,   2}, /* 04 (640x480x60Hz) */
> -	{9, 849,  627, 600,  128,  4}, /* 05 (800x600x60Hz) */
> -	{9, 1057, 805, 770,  0136, 6}, /* 06 (1024x768x60Hz) */
> -	{9, 1337, 0,   1025, 112,  3}, /* 07 (1280x1024x60Hz) */
> -	{9, 1457, 0,   1051, 112,  3}, /* 08 (1400x1050x60Hz)*/
> -	{9, 1673, 0,   1201, 192,  3}, /* 09 (1600x1200x60Hz) */
> -	{9, 1337, 0,   771,  112,  6}  /* 0A (1280x768x60Hz) */
> -};
> -
> -/* ;;1024x768x75Hz */
> -static const struct XGI_LCDDesStruct xgifb_lcddes_1024x768x75[] = {
> -	{9, 1049, 0, 769}, /* ; 00 (320x200,320x400,640x200,640x400) */
> -	{9, 1049, 0, 769}, /* ; 01 (320x350,640x350) */
> -	{9, 1049, 0, 769}, /* ; 02 (360x400,720x400) */
> -	{9, 1049, 0, 769}, /* ; 03 (720x350) */
> -	{9, 1049, 0, 769}, /* ; 04 (640x480x75Hz) */
> -	{9, 1049, 0, 769}, /* ; 05 (800x600x75Hz) */
> -	{9, 1049, 0, 769}  /* ; 06 (1024x768x75Hz) */
> -};
> -
> -/* ;;1024x768x75Hz */
> -static const struct XGI_LCDDesStruct XGI_CetLCDDes1024x768x75Data[] = {
> -	{1152, 856,  622, 587}, /* ; 00 (320x200,320x400,640x200,640x400) */
> -	{1152, 856,  597, 562}, /* ; 01 (320x350,640x350) */
> -	{1192, 896,  622, 587}, /* ; 02 (360x400,720x400) */
> -	{1192, 896,  597, 562}, /* ; 03 (720x350) */
> -	{1129, 857,  656, 625}, /* ; 04 (640x480x75Hz) */
> -	{1209, 937,  716, 685}, /* ; 05 (800x600x75Hz) */
> -	{9,    1049, 0,   769}	/* ; 06 (1024x768x75Hz) */
> -};
> -
> -/* ;;1280x1024x75Hz */
> -static const struct XGI_LCDDesStruct xgifb_lcddldes_1280x1024x75[] = {
> -	{18, 1314, 0, 1025}, /* ; 00 (320x200,320x400,640x200,640x400) */
> -	{18, 1314, 0, 1025}, /* ; 01 (320x350,640x350) */
> -	{18, 1314, 0, 1025}, /* ; 02 (360x400,720x400) */
> -	{18, 1314, 0, 1025}, /* ; 03 (720x350) */
> -	{18, 1314, 0, 1025}, /* ; 04 (640x480x60Hz) */
> -	{18, 1314, 0, 1025}, /* ; 05 (800x600x60Hz) */
> -	{18, 1314, 0, 1025}, /* ; 06 (1024x768x60Hz) */
> -	{18, 1314, 0, 1025}  /* ; 07 (1280x1024x60Hz) */
> -};
> -
> -/* 1280x1024x75Hz */
> -static const struct XGI_LCDDesStruct XGI_CetLCDDLDes1280x1024x75Data[] = {
> -	{1368, 1008, 752, 711}, /* ; 00 (320x200,320x400,640x200,640x400) */
> -	{1368, 1008, 729, 688}, /* ; 01 (320x350,640x350) */
> -	{1408, 1048, 752, 711}, /* ; 02 (360x400,720x400) */
> -	{1408, 1048, 729, 688}, /* ; 03 (720x350) */
> -	{1377, 985,  794, 753}, /* ; 04 (640x480x75Hz) */
> -	{1457, 1065, 854, 813}, /* ; 05 (800x600x75Hz) */
> -	{1569, 1177, 938, 897}, /* ; 06 (1024x768x75Hz) */
> -	{18,   1314, 0,   1025} /* ; 07 (1280x1024x75Hz) */
> -};
> -
> -/* ;;1280x1024x75Hz */
> -static const struct XGI_LCDDesStruct xgifb_lcddes_1280x1024x75[] = {
> -	{9, 1305, 0, 1025}, /* ; 00 (320x200,320x400,640x200,640x400) */
> -	{9, 1305, 0, 1025}, /* ; 01 (320x350,640x350) */
> -	{9, 1305, 0, 1025}, /* ; 02 (360x400,720x400) */
> -	{9, 1305, 0, 1025}, /* ; 03 (720x350) */
> -	{9, 1305, 0, 1025}, /* ; 04 (640x480x60Hz) */
> -	{9, 1305, 0, 1025}, /* ; 05 (800x600x60Hz) */
> -	{9, 1305, 0, 1025}, /* ; 06 (1024x768x60Hz) */
> -	{9, 1305, 0, 1025}  /* ; 07 (1280x1024x60Hz) */
> -};
> -
> -/* 1280x1024x75Hz */
> -static const struct XGI_LCDDesStruct XGI_CetLCDDes1280x1024x75Data[] = {
> -	{1368, 1008, 752, 711}, /* ; 00 (320x200,320x400,640x200,640x400) */
> -	{1368, 1008, 729, 688}, /* ; 01 (320x350,640x350) */
> -	{1408, 1048, 752, 711}, /* ; 02 (360x400,720x400) */
> -	{1408, 1048, 729, 688}, /* ; 03 (720x350) */
> -	{1377, 985,  794, 753}, /* ; 04 (640x480x75Hz) */
> -	{1457, 1065, 854, 813}, /* ; 05 (800x600x75Hz) */
> -	{1569, 1177, 938, 897}, /* ; 06 (1024x768x75Hz) */
> -	{9,    1305, 0,   1025} /* ; 07 (1280x1024x75Hz) */
> -};
> -
> -/* Scaling LCD 75Hz */
> -static const struct XGI330_LCDDataDesStruct2 XGI_NoScalingDesDatax75[] =  {
> -	{9, 657,  448, 405,  96,  2}, /* ; 00 (320x200,320x400,
> -				       *       640x200,640x400)
> -				       */
> -	{9, 657,  448, 355,  96,  2}, /* ; 01 (320x350,640x350) */
> -	{9, 738,  448, 405,  108, 2}, /* ; 02 (360x400,720x400) */
> -	{9, 738,  448, 355,  108, 2}, /* ; 03 (720x350) */
> -	{9, 665,  0,   481,  64,  3}, /* ; 04 (640x480x75Hz) */
> -	{9, 825,  0,   601,  80,  3}, /* ; 05 (800x600x75Hz) */
> -	{9, 1049, 0,   769,  96,  3}, /* ; 06 (1024x768x75Hz) */
> -	{9, 1305, 0,   1025, 144, 3}, /* ; 07 (1280x1024x75Hz) */
> -	{9, 1457, 0,   1051, 112, 3}, /* ; 08 (1400x1050x60Hz)*/
> -	{9, 1673, 0,   1201, 192, 3}, /* ; 09 (1600x1200x75Hz) */
> -	{9, 1337, 0,   771,  112, 6}  /* ; 0A (1280x768x60Hz) */
> -};
> -
> -static const struct SiS_TVData XGI_StPALData[] = {
> -	{1, 1, 864, 525, 1270, 400, 100, 0, 760},
> -	{1, 1, 864, 525, 1270, 350, 100, 0, 760},
> -	{1, 1, 864, 525, 1270, 400,   0, 0, 720},
> -	{1, 1, 864, 525, 1270, 350,   0, 0, 720},
> -	{1, 1, 864, 525, 1270, 480,  50, 0, 760},
> -	{1, 1, 864, 525, 1270, 600,  50, 0,   0}
> -};
> -
> -static const struct SiS_TVData XGI_ExtPALData[] = {
> -	{2,  1, 1080, 463, 1270, 500,  50, 0,  50},
> -	{15, 7, 1152, 413, 1270, 500,  50, 0,  50},
> -	{2,  1, 1080, 463, 1270, 500,  50, 0,  50},
> -	{15, 7, 1152, 413, 1270, 500,  50, 0,  50},
> -	{2,  1,  900, 543, 1270, 500,   0, 0,  50},
> -	{4,  3, 1080, 663, 1270, 500, 438, 0, 438},
> -	{1,  1, 1125, 831, 1270, 500, 686, 0, 686}, /*301b*/
> -	{3,  2, 1080, 619, 1270, 540, 438, 0, 438}
> -};
> -
> -static const struct SiS_TVData XGI_StNTSCData[] = {
> -	{1, 1, 858, 525, 1270, 400, 50, 0, 760},
> -	{1, 1, 858, 525, 1270, 350, 50, 0, 640},
> -	{1, 1, 858, 525, 1270, 400,  0, 0, 720},
> -	{1, 1, 858, 525, 1270, 350,  0, 0, 720},
> -	{1, 1, 858, 525, 1270, 480,  0, 0, 760}
> -};
> -
> -static const struct SiS_TVData XGI_ExtNTSCData[] = {
> -	{9,     5, 1001, 453, 1270, 420, 171, 0, 171},
> -	{12,    5,  858, 403, 1270, 420, 171, 0, 171},
> -	{9,     5, 1001, 453, 1270, 420, 171, 0, 171},
> -	{12,    5,  858, 403, 1270, 420, 171, 0, 171},
> -	{143,  80,  836, 523, 1270, 420, 224, 0,   0},
> -	{143, 120, 1008, 643, 1270, 420,   0, 1,   0},
> -	{1,     1, 1120, 821, 1516, 420,   0, 1,   0}, /*301b*/
> -	{2,     1,  858, 503, 1584, 480,   0, 1,   0},
> -	{3,     2, 1001, 533, 1270, 420,   0, 0,   0}
> -};
> -
> -static const struct SiS_TVData XGI_St1HiTVData[] = {
> -	{1, 1, 892,  563, 690,  800, 0,     0, 0}, /* 00 (320x200,320x400,
> -						    *     640x200,640x400)
> -						    */
> -	{1, 1, 892,  563, 690,  700, 0,     0, 0}, /* 01 (320x350,640x350) */
> -	{1, 1, 1000, 563, 785,  800, 0,     0, 0}, /* 02 (360x400,720x400) */
> -	{1, 1, 1000, 563, 785,  700, 0,     0, 0}, /* 03 (720x350) */
> -	{1, 1, 892,  563, 690,  960, 0,     0, 0}, /* 04 (320x240,640x480) */
> -	{8, 5, 1050, 683, 1648, 960, 0x150, 1, 0}  /* 05 (400x300,800x600) */
> -};
> -
> -static const struct SiS_TVData XGI_St2HiTVData[] = {
> -	{3, 1, 840,  483, 1648, 960, 0x032, 0, 0}, /* 00 (320x200,320x400,
> -						    *     640x200,640x400)
> -						    */
> -	{1, 1, 892,  563, 690,  700, 0,     0, 0}, /* 01 (320x350,640x350) */
> -	{3, 1, 840,  483, 1648, 960, 0x032, 0, 0}, /* 02 (360x400,720x400) */
> -	{1, 1, 1000, 563, 785,  700, 0,     0, 0}, /* 03 (720x350) */
> -	{5, 2, 840,  563, 1648, 960, 0x08D, 1, 0}, /* 04 (320x240,640x480) */
> -	{8, 5, 1050, 683, 1648, 960, 0x17C, 1, 0}  /* 05 (400x300,800x600) */
> -};
> -
> -static const struct SiS_TVData XGI_ExtHiTVData[] = {
> -	{6,  1,  840,  563,  1632, 960, 0,     0, 0}, /* 00 (320x200,320x400,
> -						       *     640x200,640x400)
> -						       */
> -	{3,  1,  960,  563,  1632, 960, 0,     0, 0}, /* 01 (320x350,640x350) */
> -	{3,  1,  840,  483,  1632, 960, 0,     0, 0}, /* 02 (360x400,720x400) */
> -	{3,  1,  960,  563,  1632, 960, 0,     0, 0}, /* 03 (720x350) */
> -	{5,  1,  840,  563,  1648, 960, 0x166, 1, 0}, /* 04 (320x240,640x480) */
> -	{16, 5,  1050, 683,  1648, 960, 0x143, 1, 0}, /* 05 (400x300,800x600) */
> -	{25, 12, 1260, 851,  1648, 960, 0x032, 0, 0}, /* 06 (512x384,1024x768)*/
> -	{5,  4,  1575, 1124, 1648, 960, 0x128, 0, 0}, /* 07 (1280x1024) */
> -	{4,  1,  1050, 563,  1548, 960, 0x143, 1, 0}, /* 08 (800x480) */
> -	{5,  2,  1400, 659,  1648, 960, 0x032, 0, 0}, /* 09 (1024x576) */
> -	{8,  5,  1750, 803,  1648, 960, 0x128, 0, 0}  /* 0A (1280x720) */
> -};
> -
> -static const struct SiS_TVData XGI_ExtYPbPr525iData[] = {
> -	{  9,  5,  1001, 453, 1270, 420, 171,   0, 171},
> -	{ 12,  5,   858, 403, 1270, 420, 171,   0, 171},
> -	{  9,  5,  1001, 453, 1270, 420, 171,   0, 171},
> -	{ 12,  5,   858, 403, 1270, 420, 171,   0, 171},
> -	{143,  80,  836, 523, 1250, 420, 224,   0,   0},
> -	{143, 120, 1008, 643, 1250, 420,   0,   1,   0},
> -	{ 1,    1, 1120, 821, 1516, 420,   0,   1,   0}, /*301b*/
> -	{  2,   1,  858, 503, 1584, 480,   0,   1,   0},
> -	{  3,   2, 1001, 533, 1250, 420,   0,   0,   0}
> -};
> -
> -static const struct SiS_TVData XGI_StYPbPr525iData[] = {
> -	{1, 1, 858, 525, 1270, 400, 50, 0, 760},
> -	{1, 1, 858, 525, 1270, 350, 50, 0, 640},
> -	{1, 1, 858, 525, 1270, 400,  0, 0, 720},
> -	{1, 1, 858, 525, 1270, 350,  0, 0, 720},
> -	{1, 1, 858, 525, 1270, 480,  0, 0, 760},
> -};
> -
> -static const struct SiS_TVData XGI_ExtYPbPr525pData[] = {
> -	{  9,   5,  1001, 453, 1270, 420, 171, 0, 171},
> -	{ 12,   5,   858, 403, 1270, 420, 171, 0, 171},
> -	{  9,   5,  1001, 453, 1270, 420, 171, 0, 171},
> -	{ 12,   5,   858, 403, 1270, 420, 171, 0, 171},
> -	{143,  80,   836, 523, 1270, 420, 224, 0,   0},
> -	{143, 120,  1008, 643, 1270, 420,   0, 1,   0},
> -	{ 1,    1,  1120, 821, 1516, 420,   0, 1,   0}, /*301b*/
> -	{  2,   1,   858, 503, 1584, 480,   0, 1,   0},
> -	{  3,   2,  1001, 533, 1270, 420,   0, 0,   0}
> -};
> -
> -static const struct SiS_TVData XGI_StYPbPr525pData[] = {
> -	{1, 1, 1716, 525, 1270, 400, 50, 0, 760},
> -	{1, 1, 1716, 525, 1270, 350, 50, 0, 640},
> -	{1, 1, 1716, 525, 1270, 400,  0, 0, 720},
> -	{1, 1, 1716, 525, 1270, 350,  0, 0, 720},
> -	{1, 1, 1716, 525, 1270, 480,  0, 0, 760},
> -};
> -
> -static const struct SiS_TVData XGI_ExtYPbPr750pData[] = {
> -	{ 3, 1,  935, 470, 1130, 680,  50, 0, 0}, /* 00 (320x200,320x400,
> -						   *     640x200,640x400)
> -						   */
> -	{24, 7,  935, 420, 1130, 680,  50, 0, 0}, /* 01 (320x350,640x350) */
> -	{ 3, 1,  935, 470, 1130, 680,  50, 0, 0}, /* 02 (360x400,720x400) */
> -	{24, 7,  935, 420, 1130, 680,  50, 0, 0}, /* 03 (720x350) */
> -	{ 2, 1, 1100, 590, 1130, 640,  50, 0, 0}, /* 04 (320x240,640x480) */
> -	{ 3, 2, 1210, 690, 1130, 660,  50, 0, 0}, /* 05 (400x300,800x600) */
> -	{ 1, 1, 1375, 878, 1130, 640, 638, 0, 0}, /* 06 (1024x768) */
> -	{ 2, 1,  858, 503, 1130, 480,   0, 1, 0}, /* 07 (720x480) */
> -	{ 5, 4, 1815, 570, 1130, 660,  50, 0, 0},
> -	{ 5, 3, 1100, 686, 1130, 640,  50, 1, 0},
> -	{10, 9, 1320, 830, 1130, 640,  50, 0, 0}
> -};
> -
> -static const struct SiS_TVData XGI_StYPbPr750pData[] = {
> -	{1, 1, 1650, 750, 1280, 400, 50, 0, 760},
> -	{1, 1, 1650, 750, 1280, 350, 50, 0, 640},
> -	{1, 1, 1650, 750, 1280, 400,  0, 0, 720},
> -	{1, 1, 1650, 750, 1280, 350,  0, 0, 720},
> -	{1, 1, 1650, 750, 1280, 480,  0, 0, 760},
> -};
> -
> -static const unsigned char XGI330_NTSCTiming[] = {
> -	0x17, 0x1d, 0x03, 0x09, 0x05, 0x06, 0x0c, 0x0c,
> -	0x94, 0x49, 0x01, 0x0a, 0x06, 0x0d, 0x04, 0x0a,
> -	0x06, 0x14, 0x0d, 0x04, 0x0a, 0x00, 0x85, 0x1b,
> -	0x0c, 0x50, 0x00, 0x97, 0x00, 0xda, 0x4a, 0x17,
> -	0x7d, 0x05, 0x4b, 0x00, 0x00, 0xe2, 0x00, 0x02,
> -	0x03, 0x0a, 0x65, 0x9d, 0x08, 0x92, 0x8f, 0x40,
> -	0x60, 0x80, 0x14, 0x90, 0x8c, 0x60, 0x14, 0x50,
> -	0x00, 0x40, 0x44, 0x00, 0xdb, 0x02, 0x3b, 0x00
> -};
> -
> -static const unsigned char XGI330_PALTiming[] = {
> -	0x21, 0x5A, 0x35, 0x6e, 0x04, 0x38, 0x3d, 0x70,
> -	0x94, 0x49, 0x01, 0x12, 0x06, 0x3e, 0x35, 0x6d,
> -	0x06, 0x14, 0x3e, 0x35, 0x6d, 0x00, 0x45, 0x2b,
> -	0x70, 0x50, 0x00, 0x9b, 0x00, 0xd9, 0x5d, 0x17,
> -	0x7d, 0x05, 0x45, 0x00, 0x00, 0xe8, 0x00, 0x02,
> -	0x0d, 0x00, 0x68, 0xb0, 0x0b, 0x92, 0x8f, 0x40,
> -	0x60, 0x80, 0x14, 0x90, 0x8c, 0x60, 0x14, 0x63,
> -	0x00, 0x40, 0x3e, 0x00, 0xe1, 0x02, 0x28, 0x00
> -};
> -
> -static const unsigned char XGI330_HiTVExtTiming[] = {
> -	0x2D, 0x60, 0x2C, 0x5F, 0x08, 0x31, 0x3A, 0x64,
> -	0x28, 0x02, 0x01, 0x3D, 0x06, 0x3E, 0x35, 0x6D,
> -	0x06, 0x14, 0x3E, 0x35, 0x6D, 0x00, 0xC5, 0x3F,
> -	0x64, 0x90, 0x33, 0x8C, 0x18, 0x36, 0x3E, 0x13,
> -	0x2A, 0xDE, 0x2A, 0x44, 0x40, 0x2A, 0x44, 0x40,
> -	0x8E, 0x8E, 0x82, 0x07, 0x0B,
> -	0x92, 0x0F, 0x40, 0x60, 0x80, 0x14, 0x90, 0x8C,
> -	0x60, 0x14, 0x3D, 0x63, 0x4F,
> -	0x27, 0x00, 0xfc, 0xff, 0x6a, 0x00
> -};
> -
> -static const unsigned char XGI330_HiTVSt1Timing[] = {
> -	0x32, 0x65, 0x2C, 0x5F, 0x08, 0x31, 0x3A, 0x65,
> -	0x28, 0x02, 0x01, 0x3D, 0x06, 0x3E, 0x35, 0x6D,
> -	0x06, 0x14, 0x3E, 0x35, 0x6D, 0x00, 0xC5, 0x3F,
> -	0x65, 0x90, 0x7B, 0xA8, 0x03, 0xF0, 0x87, 0x03,
> -	0x11, 0x15, 0x11, 0xCF, 0x10, 0x11, 0xCF, 0x10,
> -	0x35, 0x35, 0x3B, 0x69, 0x1D,
> -	0x92, 0x0F, 0x40, 0x60, 0x80, 0x14, 0x90, 0x8C,
> -	0x60, 0x04, 0x86, 0xAF, 0x5D,
> -	0x0E, 0x00, 0xfc, 0xff, 0x2d, 0x00
> -};
> -
> -static const unsigned char XGI330_HiTVSt2Timing[] = {
> -	0x32, 0x65, 0x2C, 0x5F, 0x08, 0x31, 0x3A, 0x64,
> -	0x28, 0x02, 0x01, 0x3D, 0x06, 0x3E, 0x35, 0x6D,
> -	0x06, 0x14, 0x3E, 0x35, 0x6D, 0x00, 0xC5, 0x3F,
> -	0x64, 0x90, 0x33, 0x8C, 0x18, 0x36, 0x3E, 0x13,
> -	0x2A, 0xDE, 0x2A, 0x44, 0x40, 0x2A, 0x44, 0x40,
> -	0x8E, 0x8E, 0x82, 0x07, 0x0B,
> -	0x92, 0x0F, 0x40, 0x60, 0x80, 0x14, 0x90, 0x8C,
> -	0x60, 0x14, 0x3D, 0x63, 0x4F,
> -	0x27, 0x00, 0xFC, 0xff, 0x6a, 0x00
> -};
> -
> -static const unsigned char XGI330_HiTVTextTiming[] = {
> -	0x32, 0x65, 0x2C, 0x5F, 0x08, 0x31, 0x3A, 0x65,
> -	0x28, 0x02, 0x01, 0x3D, 0x06, 0x3E, 0x35, 0x6D,
> -	0x06, 0x14, 0x3E, 0x35, 0x6D, 0x00, 0xC5, 0x3F,
> -	0x65, 0x90, 0xE7, 0xBC, 0x03, 0x0C, 0x97, 0x03,
> -	0x14, 0x78, 0x14, 0x08, 0x20, 0x14, 0x08, 0x20,
> -	0xC8, 0xC8, 0x3B, 0xD2, 0x26,
> -	0x92, 0x0F, 0x40, 0x60, 0x80, 0x14, 0x90, 0x8C,
> -	0x60, 0x04, 0x96, 0x72, 0x5C,
> -	0x11, 0x00, 0xFC, 0xFF, 0x32, 0x00
> -};
> -
> -static const unsigned char XGI330_YPbPr750pTiming[] = {
> -	0x30, 0x1d, 0xe8, 0x09, 0x09, 0xed, 0x0c, 0x0c,
> -	0x98, 0x0a, 0x01, 0x0c, 0x06, 0x0d, 0x04, 0x0a,
> -	0x06, 0x14, 0x0d, 0x04, 0x0a, 0x00, 0x85, 0x3f,
> -	0xed, 0x50, 0x70, 0x9f, 0x16, 0x59, 0x60, 0x13,
> -	0x27, 0x0b, 0x27, 0xfc, 0x30, 0x27, 0x1c, 0xb0,
> -	0x4b, 0x4b, 0x6f, 0x2f, 0x63,
> -	0x92, 0x0F, 0x40, 0x60, 0x80, 0x14, 0x90, 0x8C,
> -	0x60, 0x14, 0x73, 0x00, 0x40,
> -	0x11, 0x00, 0xfc, 0xff, 0x32, 0x00
> -};
> -
> -static const unsigned char XGI330_YPbPr525pTiming[] = {
> -	0x3E, 0x11, 0x06, 0x09, 0x0b, 0x0c, 0x0c, 0x0c,
> -	0x98, 0x0a, 0x01, 0x0d, 0x06, 0x0d, 0x04, 0x0a,
> -	0x06, 0x14, 0x0d, 0x04, 0x0a, 0x00, 0x85, 0x3f,
> -	0x0c, 0x50, 0xb2, 0x9f, 0x16, 0x59, 0x4f, 0x13,
> -	0xad, 0x11, 0xad, 0x1d, 0x40, 0x8a, 0x3d, 0xb8,
> -	0x51, 0x5e, 0x60, 0x49, 0x7d,
> -	0x92, 0x0F, 0x40, 0x60, 0x80, 0x14, 0x90, 0x8C,
> -	0x60, 0x14, 0x4B, 0x43, 0x41,
> -	0x11, 0x00, 0xFC, 0xFF, 0x32, 0x00
> -};
> -
> -static const unsigned char XGI330_YPbPr525iTiming[] = {
> -	0x1B, 0x21, 0x03, 0x09, 0x05, 0x06, 0x0C, 0x0C,
> -	0x94, 0x49, 0x01, 0x0A, 0x06, 0x0D, 0x04, 0x0A,
> -	0x06, 0x14, 0x0D, 0x04, 0x0A, 0x00, 0x85, 0x1B,
> -	0x0C, 0x50, 0x00, 0x97, 0x00, 0xDA, 0x4A, 0x17,
> -	0x7D, 0x05, 0x4B, 0x00, 0x00, 0xE2, 0x00, 0x02,
> -	0x03, 0x0A, 0x65, 0x9D, 0x08,
> -	0x92, 0x8F, 0x40, 0x60, 0x80, 0x14, 0x90, 0x8C,
> -	0x60, 0x14, 0x4B, 0x00, 0x40,
> -	0x44, 0x00, 0xDB, 0x02, 0x3B, 0x00
> -};
> -
> -static const unsigned char XGI330_HiTVGroup3Data[] = {
> -	0x00, 0x1A, 0x22, 0x63, 0x62, 0x22, 0x08, 0x5F,
> -	0x05, 0x21, 0xB2, 0xB2, 0x55, 0x77, 0x2A, 0xA6,
> -	0x25, 0x2F, 0x47, 0xFA, 0xC8, 0xFF, 0x8E, 0x20,
> -	0x8C, 0x6E, 0x60, 0x2E, 0x58, 0x48, 0x72, 0x44,
> -	0x56, 0x36, 0x4F, 0x6E, 0x3F, 0x80, 0x00, 0x80,
> -	0x4F, 0x7F, 0x03, 0xA8, 0x7D, 0x20, 0x1A, 0xA9,
> -	0x14, 0x05, 0x03, 0x7E, 0x64, 0x31, 0x14, 0x75,
> -	0x18, 0x05, 0x18, 0x05, 0x4C, 0xA8, 0x01
> -};
> -
> -static const unsigned char XGI330_HiTVGroup3Simu[] = {
> -	0x00, 0x1A, 0x22, 0x63, 0x62, 0x22, 0x08, 0x95,
> -	0xDB, 0x20, 0xB8, 0xB8, 0x55, 0x47, 0x2A, 0xA6,
> -	0x25, 0x2F, 0x47, 0xFA, 0xC8, 0xFF, 0x8E, 0x20,
> -	0x8C, 0x6E, 0x60, 0x15, 0x26, 0xD3, 0xE4, 0x11,
> -	0x56, 0x36, 0x4F, 0x6E, 0x3F, 0x80, 0x00, 0x80,
> -	0x67, 0x36, 0x01, 0x47, 0x0E, 0x10, 0xBE, 0xB4,
> -	0x01, 0x05, 0x03, 0x7E, 0x65, 0x31, 0x14, 0x75,
> -	0x18, 0x05, 0x18, 0x05, 0x4C, 0xA8, 0x01
> -};
> -
> -static const unsigned char XGI330_HiTVGroup3Text[] = {
> -	0x00, 0x1A, 0x22, 0x63, 0x62, 0x22, 0x08, 0xA7,
> -	0xF5, 0x20, 0xCE, 0xCE, 0x55, 0x47, 0x2A, 0xA6,
> -	0x25, 0x2F, 0x47, 0xFA, 0xC8, 0xFF, 0x8E, 0x20,
> -	0x8C, 0x6E, 0x60, 0x18, 0x2C, 0x0C, 0x20, 0x22,
> -	0x56, 0x36, 0x4F, 0x6E, 0x3F, 0x80, 0x00, 0x80,
> -	0x93, 0x3C, 0x01, 0x50, 0x2F, 0x10, 0xF4, 0xCA,
> -	0x01, 0x05, 0x03, 0x7E, 0x65, 0x31, 0x14, 0x75,
> -	0x18, 0x05, 0x18, 0x05, 0x4C, 0xA8, 0x01
> -};
> -
> -static const unsigned char XGI330_Ren525pGroup3[] = {
> -	0x00, 0x14, 0x15, 0x25, 0x55, 0x15, 0x0b, 0x13,
> -	0xB1, 0x41, 0x62, 0x62, 0xFF, 0xF4, 0x45, 0xa6,
> -	0x25, 0x2F, 0x67, 0xF6, 0xbf, 0xFF, 0x8E, 0x20,
> -	0xAC, 0xDA, 0x60, 0xFe, 0x6A, 0x9A, 0x06, 0x10,
> -	0xd1, 0x04, 0x18, 0x0a, 0xFF, 0x80, 0x00, 0x80,
> -	0x3c, 0x77, 0x00, 0xEF, 0xE0, 0x10, 0xB0, 0xE0,
> -	0x10, 0x4F, 0x0F, 0x0F, 0x05, 0x0F, 0x08, 0x6E,
> -	0x1a, 0x1F, 0x25, 0x2a, 0x4C, 0xAA, 0x01
> -};
> -
> -static const unsigned char XGI330_Ren750pGroup3[] = {
> -	0x00, 0x14, 0x15, 0x25, 0x55, 0x15, 0x0b, 0x7a,
> -	0x54, 0x41, 0xE7, 0xE7, 0xFF, 0xF4, 0x45, 0xa6,
> -	0x25, 0x2F, 0x67, 0xF6, 0xbf, 0xFF, 0x8E, 0x20,
> -	0xAC, 0x6A, 0x60, 0x2b, 0x52, 0xCD, 0x61, 0x10,
> -	0x51, 0x04, 0x18, 0x0a, 0x1F, 0x80, 0x00, 0x80,
> -	0xFF, 0xA4, 0x04, 0x2B, 0x94, 0x21, 0x72, 0x94,
> -	0x26, 0x05, 0x01, 0x0F, 0xed, 0x0F, 0x0A, 0x64,
> -	0x18, 0x1D, 0x23, 0x28, 0x4C, 0xAA, 0x01
> -};
> -
> -static const struct SiS_LVDSData XGI_LVDS1024x768Data_1[] = {
> -	{ 960, 438, 1344, 806},	/* 00 (320x200,320x400,640x200,640x400) */
> -	{ 960, 388, 1344, 806},	/* 01 (320x350,640x350) */
> -	{1040, 438, 1344, 806},	/* 02 (360x400,720x400) */
> -	{1040, 388, 1344, 806},	/* 03 (720x350) */
> -	{ 960, 518, 1344, 806},	/* 04 (320x240,640x480) */
> -	{1120, 638, 1344, 806},	/* 05 (400x300,800x600) */
> -	{1344, 806, 1344, 806}	/* 06 (512x384,1024x768) */
> -};
> -
> -static const struct SiS_LVDSData XGI_LVDS1024x768Data_2[] = {
> -	{1344, 806, 1344, 806},
> -	{1344, 806, 1344, 806},
> -	{1344, 806, 1344, 806},
> -	{1344, 806, 1344, 806},
> -	{1344, 806, 1344, 806},
> -	{1344, 806, 1344, 806},
> -	{1344, 806, 1344, 806},
> -	{800,  449, 1280, 801},
> -	{800,  525, 1280, 813}
> -};
> -
> -static const struct SiS_LVDSData XGI_LVDS1280x1024Data_1[] = {
> -	{1048, 442,  1688, 1066},
> -	{1048, 392,  1688, 1066},
> -	{1048, 442,  1688, 1066},
> -	{1048, 392,  1688, 1066},
> -	{1048, 522,  1688, 1066},
> -	{1208, 642,  1688, 1066},
> -	{1432, 810,  1688, 1066},
> -	{1688, 1066, 1688, 1066}
> -};
> -
> -#define XGI_LVDS1280x1024Data_2 XGI_LVDS1024x768Data_2
> -
> -static const struct SiS_LVDSData XGI_LVDS1400x1050Data_1[] = {
> -	{928,   416, 1688, 1066},
> -	{928,   366, 1688, 1066},
> -	{928,   416, 1688, 1066},
> -	{928,   366, 1688, 1066},
> -	{928,   496, 1688, 1066},
> -	{1088,  616, 1688, 1066},
> -	{1312,  784, 1688, 1066},
> -	{1568, 1040, 1688, 1066},
> -	{1688, 1066, 1688, 1066}
> -};
> -
> -static const struct SiS_LVDSData XGI_LVDS1400x1050Data_2[] = {
> -	{1688, 1066, 1688, 1066},
> -	{1688, 1066, 1688, 1066},
> -	{1688, 1066, 1688, 1066},
> -	{1688, 1066, 1688, 1066},
> -	{1688, 1066, 1688, 1066},
> -	{1688, 1066, 1688, 1066},
> -	{1688, 1066, 1688, 1066},
> -	{1688, 1066, 1688, 1066},
> -	{1688, 1066, 1688, 1066}
> -};
> -
> -/* ;;[ycchen] 12/05/02 LCDHTxLCDVT=2048x1320 */
> -static const struct SiS_LVDSData XGI_LVDS1600x1200Data_1[] = {
> -	{1088, 520,  2048, 1320}, /* 00 (320x200,320x400,640x200,640x400) */
> -	{1088, 470,  2048, 1320}, /* 01 (320x350,640x350) */
> -	{1088, 520,  2048, 1320}, /* 02 (360x400,720x400) */
> -	{1088, 470,  2048, 1320}, /* 03 (720x350) */
> -	{1088, 600,  2048, 1320}, /* 04 (320x240,640x480) */
> -	{1248, 720,  2048, 1320}, /* 05 (400x300,800x600) */
> -	{1472, 888,  2048, 1320}, /* 06 (512x384,1024x768) */
> -	{1728, 1144, 2048, 1320}, /* 07 (640x512,1280x1024) */
> -	{1848, 1170, 2048, 1320}, /* 08 (1400x1050) */
> -	{2048, 1320, 2048, 1320}  /* 09 (1600x1200) */
> -};
> -
> -static const struct SiS_LVDSData XGI_LVDSNoScalingData[] = {
> -	{ 800,  449,  800,  449}, /* 00 (320x200,320x400,640x200,640x400) */
> -	{ 800,  449,  800,  449}, /* 01 (320x350,640x350) */
> -	{ 800,  449,  800,  449}, /* 02 (360x400,720x400) */
> -	{ 800,  449,  800,  449}, /* 03 (720x350) */
> -	{ 800,  525,  800,  525}, /* 04 (640x480x60Hz) */
> -	{1056,  628, 1056,  628}, /* 05 (800x600x60Hz) */
> -	{1344,  806, 1344,  806}, /* 06 (1024x768x60Hz) */
> -	{1688, 1066, 1688, 1066}, /* 07 (1280x1024x60Hz) */
> -	{1688, 1066, 1688, 1066}, /* 08 (1400x1050x60Hz) */
> -	{2160, 1250, 2160, 1250}, /* 09 (1600x1200x60Hz) */
> -	{1688,  806, 1688,  806}  /* 0A (1280x768x60Hz) */
> -};
> -
> -static const struct SiS_LVDSData XGI_LVDS1024x768Data_1x75[] = {
> -	{ 960, 438, 1312, 800}, /* 00 (320x200,320x400,640x200,640x400) */
> -	{ 960, 388, 1312, 800}, /* 01 (320x350,640x350) */
> -	{1040, 438, 1312, 800}, /* 02 (360x400,720x400) */
> -	{1040, 388, 1312, 800}, /* 03 (720x350) */
> -	{ 928, 512, 1312, 800}, /* 04 (320x240,640x480) */
> -	{1088, 632, 1312, 800}, /* 05 (400x300,800x600) */
> -	{1312, 800, 1312, 800}, /* 06 (512x384,1024x768) */
> -};
> -
> -static const struct SiS_LVDSData XGI_LVDS1024x768Data_2x75[] = {
> -	{1312, 800, 1312, 800}, /* ; 00 (320x200,320x400,640x200,640x400) */
> -	{1312, 800, 1312, 800}, /* ; 01 (320x350,640x350) */
> -	{1312, 800, 1312, 800}, /* ; 02 (360x400,720x400) */
> -	{1312, 800, 1312, 800}, /* ; 03 (720x350) */
> -	{1312, 800, 1312, 800}, /* ; 04 (320x240,640x480) */
> -	{1312, 800, 1312, 800}, /* ; 05 (400x300,800x600) */
> -	{1312, 800, 1312, 800}, /* ; 06 (512x384,1024x768) */
> -};
> -
> -static const struct SiS_LVDSData XGI_LVDS1280x1024Data_1x75[] = {
> -	{1048,  442, 1688, 1066  }, /* ; 00 (320x200,320x400,640x200,640x400) */
> -	{1048,  392, 1688, 1066  }, /* ; 01 (320x350,640x350) */
> -	{1128,  442, 1688, 1066  }, /* ; 02 (360x400,720x400) */
> -	{1128,  392, 1688, 1066  }, /* ; 03 (720x350) */
> -	{1048,  522, 1688, 1066  }, /* ; 04 (320x240,640x480) */
> -	{1208,  642, 1688, 1066  }, /* ; 05 (400x300,800x600) */
> -	{1432,  810, 1688, 1066  }, /* ; 06 (512x384,1024x768) */
> -	{1688, 1066, 1688, 1066 },  /* ; 06; 07 (640x512,1280x1024) */
> -};
> -
> -static const struct SiS_LVDSData XGI_LVDS1280x1024Data_2x75[] = {
> -	{1688, 1066, 1688, 1066 }, /* ; 00 (320x200,320x400,640x200,640x400) */
> -	{1688, 1066, 1688, 1066 }, /* ; 01 (320x350,640x350) */
> -	{1688, 1066, 1688, 1066 }, /* ; 02 (360x400,720x400) */
> -	{1688, 1066, 1688, 1066 }, /* ; 03 (720x350) */
> -	{1688, 1066, 1688, 1066 }, /* ; 04 (320x240,640x480) */
> -	{1688, 1066, 1688, 1066 }, /* ; 05 (400x300,800x600) */
> -	{1688, 1066, 1688, 1066 }, /* ; 06 (512x384,1024x768) */
> -	{1688, 1066, 1688, 1066 }, /* ; 06; 07 (640x512,1280x1024) */
> -};
> -
> -static const struct SiS_LVDSData XGI_LVDSNoScalingDatax75[] = {
> -	{ 800,  449,  800, 449},  /* ; 00 (320x200,320x400,640x200,640x400) */
> -	{ 800,  449,  800, 449},  /* ; 01 (320x350,640x350) */
> -	{ 900,  449,  900, 449},  /* ; 02 (360x400,720x400) */
> -	{ 900,  449,  900, 449},  /* ; 03 (720x350) */
> -	{ 800,  500,  800, 500},  /* ; 04 (640x480x75Hz) */
> -	{1056,  625, 1056, 625},  /* ; 05 (800x600x75Hz) */
> -	{1312,  800, 1312, 800},  /* ; 06 (1024x768x75Hz) */
> -	{1688, 1066, 1688, 1066}, /* ; 07 (1280x1024x75Hz) */
> -	{1688, 1066, 1688, 1066}, /* ; 08 (1400x1050x75Hz)
> -				   * ;;[ycchen] 12/19/02
> -				   */
> -	{2160, 1250, 2160, 1250}, /* ; 09 (1600x1200x75Hz) */
> -	{1688,  806, 1688, 806},  /* ; 0A (1280x768x75Hz) */
> -};
> -
> -static const struct SiS_LVDSData XGI_LVDS1024x768Des_1[] = {
> -	{0, 1048,   0, 771}, /* 00 (320x200,320x400,640x200,640x400) */
> -	{0, 1048,   0, 771}, /* 01 (320x350,640x350) */
> -	{0, 1048,   0, 771}, /* 02 (360x400,720x400) */
> -	{0, 1048,   0, 771}, /* 03 (720x350) */
> -	{0, 1048,   0, 771}, /* 04 (640x480x60Hz) */
> -	{0, 1048,   0, 771}, /* 05 (800x600x60Hz) */
> -	{0, 1048, 805, 770}  /* 06 (1024x768x60Hz) */
> -};
> -
> -static const struct SiS_LVDSData XGI_LVDS1024x768Des_2[] = {
> -	{1142,  856, 622, 587}, /* 00 (320x200,320x400,640x200,640x400) */
> -	{1142,  856, 597, 562}, /* 01 (320x350,640x350) */
> -	{1142,  856, 622, 587}, /* 02 (360x400,720x400) */
> -	{1142,  856, 597, 562}, /* 03 (720x350) */
> -	{1142, 1048, 722, 687}, /* 04 (640x480x60Hz) */
> -	{1232,  936, 722, 687}, /* 05 (800x600x60Hz) */
> -	{   0, 1048, 805, 771}  /* 06 (1024x768x60Hz) */
> -};
> -
> -static const struct SiS_LVDSData XGI_LVDS1024x768Des_3[] = {
> -	{320, 24, 622, 587}, /* 00 (320x200,320x400,640x200,640x400) */
> -	{320, 24, 597, 562}, /* 01 (320x350,640x350) */
> -	{320, 24, 622, 587}, /* 02 (360x400,720x400) */
> -	{320, 24, 597, 562}, /* 03 (720x350) */
> -	{320, 24, 722, 687}  /* 04 (640x480x60Hz) */
> -};
> -
> -static const struct SiS_LVDSData XGI_LVDS1280x1024Des_1[] = {
> -	{0, 1328,    0, 1025}, /* 00 (320x200,320x400,640x200,640x400) */
> -	{0, 1328,    0, 1025}, /* 01 (320x350,640x350) */
> -	{0, 1328,    0, 1025}, /* 02 (360x400,720x400) */
> -	{0, 1328,    0, 1025}, /* 03 (720x350) */
> -	{0, 1328,    0, 1025}, /* 04 (640x480x60Hz) */
> -	{0, 1328,    0, 1025}, /* 05 (800x600x60Hz) */
> -	{0, 1328,    0, 1025}, /* 06 (1024x768x60Hz) */
> -	{0, 1328, 1065, 1024}  /* 07 (1280x1024x60Hz) */
> -};
> -
> - /* The Display setting for DE Mode Panel */
> -static const struct SiS_LVDSData XGI_LVDS1280x1024Des_2[] = {
> -	{1368, 1008, 752, 711}, /* 00 (320x200,320x400,640x200,640x400) */
> -	{1368, 1008, 729, 688}, /* 01 (320x350,640x350) */
> -	{1408, 1048, 752, 711}, /* 02 (360x400,720x400) */
> -	{1408, 1048, 729, 688}, /* 03 (720x350) */
> -	{1368, 1008, 794, 753}, /* 04 (640x480x60Hz) */
> -	{1448, 1068, 854, 813}, /* 05 (800x600x60Hz) */
> -	{1560, 1200, 938, 897}, /* 06 (1024x768x60Hz) */
> -	{0000, 1328,   0, 1025} /* 07 (1280x1024x60Hz) */
> -};
> -
> -static const struct SiS_LVDSData XGI_LVDS1400x1050Des_1[] = {
> -	{0, 1448, 0, 1051}, /* 00 (320x200,320x400,640x200,640x400) */
> -	{0, 1448, 0, 1051}, /* 01 (320x350,640x350) */
> -	{0, 1448, 0, 1051}, /* 02 (360x400,720x400) */
> -	{0, 1448, 0, 1051}, /* 03 (720x350) */
> -	{0, 1448, 0, 1051}, /* 04 (640x480x60Hz) */
> -	{0, 1448, 0, 1051}, /* 05 (800x600x60Hz) */
> -	{0, 1448, 0, 1051}, /* 06 (1024x768x60Hz) */
> -	{0, 1448, 0, 1051}, /* 07 (1280x1024x60Hz) */
> -	{0, 1448, 0, 1051}  /* 08 (1400x1050x60Hz) */
> -};
> -
> -static const struct SiS_LVDSData XGI_LVDS1400x1050Des_2[] = {
> -	{1308, 1068,  781,  766}, /* 00 (320x200,320x400,640x200,640x400) */
> -	{1308, 1068,  781,  766}, /* 01 (320x350,640x350) */
> -	{1308, 1068,  781,  766}, /* 02 (360x400,720x400) */
> -	{1308, 1068,  781,  766}, /* 03 (720x350) */
> -	{1308, 1068,  781,  766}, /* 04 (640x480x60Hz) */
> -	{1388, 1148,  841,  826}, /* 05 (800x600x60Hz) */
> -	{1490, 1250,  925,  910}, /* 06 (1024x768x60Hz) */
> -	{1608, 1368, 1053, 1038}, /* 07 (1280x1024x60Hz) */
> -	{   0, 1448,    0, 1051}  /* 08 (1400x1050x60Hz) */
> -};
> -
> -static const struct SiS_LVDSData XGI_LVDS1600x1200Des_1[] = {
> -	{0, 1664, 0, 1201}, /* 00 (320x200,320x400,640x200,640x400) */
> -	{0, 1664, 0, 1201}, /* 01 (320x350,640x350) */
> -	{0, 1664, 0, 1201}, /* 02 (360x400,720x400) */
> -	{0, 1664, 0, 1201}, /* 03 (720x350) */
> -	{0, 1664, 0, 1201}, /* 04 (640x480x60Hz) */
> -	{0, 1664, 0, 1201}, /* 05 (800x600x60Hz) */
> -	{0, 1664, 0, 1201}, /* 06 (1024x768x60Hz) */
> -	{0, 1664, 0, 1201}, /* 07 (1280x1024x60Hz) */
> -	{0, 1664, 0, 1201}, /* 08 (1400x1050x60Hz) */
> -	{0, 1664, 0, 1201}  /* 09 (1600x1200x60Hz) */
> -};
> -
> -static const struct XGI330_LCDDataDesStruct2  XGI_LVDSNoScalingDesData[] = {
> -	{0,  648,  448,  405,  96, 2}, /* 00 (320x200,320x400,
> -					*     640x200,640x400)
> -					*/
> -	{0,  648,  448,  355,  96, 2}, /* 01 (320x350,640x350) */
> -	{0,  648,  448,  405,  96, 2}, /* 02 (360x400,720x400) */
> -	{0,  648,  448,  355,  96, 2}, /* 03 (720x350) */
> -	{0,  648,    1,  483,  96, 2}, /* 04 (640x480x60Hz) */
> -	{0,  840,  627,  600, 128, 4}, /* 05 (800x600x60Hz) */
> -	{0, 1048,  805,  770, 136, 6}, /* 06 (1024x768x60Hz) */
> -	{0, 1328,    0, 1025, 112, 3}, /* 07 (1280x1024x60Hz) */
> -	{0, 1438,    0, 1051, 112, 3}, /* 08 (1400x1050x60Hz)*/
> -	{0, 1664,    0, 1201, 192, 3}, /* 09 (1600x1200x60Hz) */
> -	{0, 1328,    0, 0771, 112, 6}  /* 0A (1280x768x60Hz) */
> -};
> -
> -/* ; 1024x768 Full-screen */
> -static const struct SiS_LVDSData XGI_LVDS1024x768Des_1x75[] = {
> -	{0, 1040, 0, 769}, /* ; 00 (320x200,320x400,640x200,640x400) */
> -	{0, 1040, 0, 769}, /* ; 01 (320x350,640x350) */
> -	{0, 1040, 0, 769}, /* ; 02 (360x400,720x400) */
> -	{0, 1040, 0, 769}, /* ; 03 (720x350) */
> -	{0, 1040, 0, 769}, /* ; 04 (640x480x75Hz) */
> -	{0, 1040, 0, 769}, /* ; 05 (800x600x75Hz) */
> -	{0, 1040, 0, 769}  /* ; 06 (1024x768x75Hz) */
> -};
> -
> -/* ; 1024x768 center-screen (Enh. Mode) */
> -static const struct SiS_LVDSData XGI_LVDS1024x768Des_2x75[] = {
> -	{1142,  856, 622, 587}, /* 00 (320x200,320x400,640x200,640x400) */
> -	{1142,  856, 597, 562}, /* 01 (320x350,640x350) */
> -	{1142,  856, 622, 587}, /* 02 (360x400,720x400) */
> -	{1142,  856, 597, 562}, /* 03 (720x350) */
> -	{1142, 1048, 722, 687}, /* 04 (640x480x60Hz) */
> -	{1232,  936, 722, 687}, /* 05 (800x600x60Hz) */
> -	{   0, 1048, 805, 771}  /* 06 (1024x768x60Hz) */
> -};
> -
> -/* ; 1024x768 center-screen (St.Mode) */
> -static const struct SiS_LVDSData XGI_LVDS1024x768Des_3x75[] =  {
> -	{320, 24, 622, 587}, /* ; 00 (320x200,320x400,640x200,640x400) */
> -	{320, 24, 597, 562}, /* ; 01 (320x350,640x350) */
> -	{320, 24, 622, 587}, /* ; 02 (360x400,720x400) */
> -	{320, 24, 597, 562}, /* ; 03 (720x350) */
> -	{320, 24, 722, 687}  /* ; 04 (640x480x60Hz) */
> -};
> -
> -static const struct SiS_LVDSData XGI_LVDS1280x1024Des_1x75[] = {
> -	{0, 1296, 0, 1025}, /* ; 00 (320x200,320x400,640x200,640x400) */
> -	{0, 1296, 0, 1025}, /* ; 01 (320x350,640x350) */
> -	{0, 1296, 0, 1025}, /* ; 02 (360x400,720x400) */
> -	{0, 1296, 0, 1025}, /* ; 03 (720x350) */
> -	{0, 1296, 0, 1025}, /* ; 04 (640x480x75Hz) */
> -	{0, 1296, 0, 1025}, /* ; 05 (800x600x75Hz) */
> -	{0, 1296, 0, 1025}, /* ; 06 (1024x768x75Hz) */
> -	{0, 1296, 0, 1025}  /* ; 07 (1280x1024x75Hz) */
> -};
> -
> -/* The Display setting for DE Mode Panel */
> -/* Set DE as default */
> -static const struct SiS_LVDSData XGI_LVDS1280x1024Des_2x75[] = {
> -	{1368,  976, 752,  711}, /* ; 00 (320x200,320x400,640x200,640x400) */
> -	{1368,  976, 729,  688}, /* ; 01 (320x350,640x350) */
> -	{1408,  976, 752,  711}, /* ; 02 (360x400,720x400) */
> -	{1408,  976, 729,  688}, /* ; 03 (720x350) */
> -	{1368,  976, 794,  753}, /* ; 04 (640x480x75Hz) */
> -	{1448, 1036, 854,  813}, /* ; 05 (800x600x75Hz) */
> -	{1560, 1168, 938,  897}, /* ; 06 (1024x768x75Hz) */
> -	{   0, 1296,   0, 1025}  /* ; 07 (1280x1024x75Hz) */
> -};
> -
> -/* Scaling LCD 75Hz */
> -static const struct XGI330_LCDDataDesStruct2 XGI_LVDSNoScalingDesDatax75[] = {
> -	{0,  648, 448,  405,  96, 2}, /* ; 00 (320x200,320x400,
> -				       *       640x200,640x400)
> -				       */
> -	{0,  648, 448,  355,  96, 2}, /* ; 01 (320x350,640x350) */
> -	{0,  729, 448,  405, 108, 2}, /* ; 02 (360x400,720x400) */
> -	{0,  729, 448,  355, 108, 2}, /* ; 03 (720x350) */
> -	{0,  656,   0,  481,  64, 3}, /* ; 04 (640x480x75Hz) */
> -	{0,  816,   0,  601,  80, 3}, /* ; 05 (800x600x75Hz) */
> -	{0, 1040,   0,  769,  96, 3}, /* ; 06 (1024x768x75Hz) */
> -	{0, 1296,   0, 1025, 144, 3}, /* ; 07 (1280x1024x75Hz) */
> -	{0, 1448,   0, 1051, 112, 3}, /* ; 08 (1400x1050x75Hz) */
> -	{0, 1664,   0, 1201, 192, 3}, /* ; 09 (1600x1200x75Hz) */
> -	{0, 1328,   0,  771, 112, 6}  /* ; 0A (1280x768x75Hz) */
> -};
> -
> -/* CR00,CR02,CR03,CR04,CR05,SR0B,SR0C,SR0E */
> -static const struct XGI_LVDSCRT1HDataStruct  XGI_LVDSCRT11024x768_1_H[] = {
> -	{ {0x4B, 0x27, 0x8F, 0x32, 0x1B, 0x00, 0x45, 0x00} }, /* 00 (320x) */
> -	{ {0x4B, 0x27, 0x8F, 0x2B, 0x03, 0x00, 0x44, 0x00} }, /* 01 (360x) */
> -	{ {0x55, 0x31, 0x99, 0x46, 0x1D, 0x00, 0x55, 0x00} }, /* 02 (400x) */
> -	{ {0x63, 0x3F, 0x87, 0x4A, 0x93, 0x00, 0x01, 0x00} }, /* 03 (512x) */
> -	{ {0x73, 0x4F, 0x97, 0x55, 0x86, 0x00, 0x05, 0x00} }, /* 04 (640x) */
> -	{ {0x73, 0x4F, 0x97, 0x55, 0x86, 0x00, 0x05, 0x00} }, /* 05 (720x) */
> -	{ {0x87, 0x63, 0x8B, 0x69, 0x1A, 0x00, 0x26, 0x00} }, /* 06 (800x) */
> -	{ {0xA3, 0x7F, 0x87, 0x86, 0x97, 0x00, 0x02, 0x00} }  /* 07 (1024x) */
> -};
> -
> -/* CR00,CR02,CR03,CR04,CR05,SR0B,SR0C,SR0E */
> -static const struct XGI_LVDSCRT1HDataStruct  XGI_LVDSCRT11280x1024_1_H[] = {
> -	{ {0x56, 0x27, 0x9A, 0x30, 0x1E, 0x00, 0x05, 0x00 } }, /* 00 (320x) */
> -	{ {0x56, 0x27, 0x9A, 0x30, 0x1E, 0x00, 0x05, 0x00 } }, /* 01 (360x) */
> -	{ {0x60, 0x31, 0x84, 0x3A, 0x88, 0x00, 0x01, 0x00 } }, /* 02 (400x) */
> -	{ {0x6E, 0x3F, 0x92, 0x48, 0x96, 0x00, 0x01, 0x00 } }, /* 03 (512x) */
> -	{ {0x7E, 0x4F, 0x82, 0x58, 0x06, 0x00, 0x06, 0x00 } }, /* 04 (640x) */
> -	{ {0x7E, 0x4F, 0x82, 0x58, 0x06, 0x00, 0x06, 0x00 } }, /* 05 (720x) */
> -	{ {0x92, 0x63, 0x96, 0x6C, 0x1A, 0x00, 0x06, 0x00 } }, /* 06 (800x) */
> -	{ {0xAE, 0x7F, 0x92, 0x88, 0x96, 0x00, 0x02, 0x00 } }, /* 07 (1024x) */
> -	{ {0xCE, 0x9F, 0x92, 0xA8, 0x16, 0x00, 0x07, 0x00 } }  /* 08 (1280x) */
> -};
> -
> -/* CR00,CR02,CR03,CR04,CR05,SR0B,SR0C,SR0E */
> -static const struct XGI_LVDSCRT1HDataStruct  XGI_LVDSCRT11024x768_2_H[] = {
> -	{ {0x63, 0x27, 0x87, 0x3B, 0x8C, 0x00, 0x01, 0x00} }, /* 00 (320x) */
> -	{ {0x63, 0x27, 0x87, 0x3B, 0x8C, 0x00, 0x01, 0x00} }, /* 01 (360x) */
> -	{ {0x63, 0x31, 0x87, 0x3D, 0x8E, 0x00, 0x01, 0x00} }, /* 02 (400x) */
> -	{ {0x63, 0x3F, 0x87, 0x45, 0x96, 0x00, 0x01, 0x00} }, /* 03 (512x) */
> -	{ {0xA3, 0x4F, 0x87, 0x6E, 0x9F, 0x00, 0x06, 0x00} }, /* 04 (640x) */
> -	{ {0xA3, 0x4F, 0x87, 0x6E, 0x9F, 0x00, 0x06, 0x00} }, /* 05 (720x) */
> -	{ {0xA3, 0x63, 0x87, 0x78, 0x89, 0x00, 0x02, 0x00} }, /* 06 (800x) */
> -	{ {0xA3, 0x7F, 0x87, 0x86, 0x97, 0x00, 0x02, 0x00} }  /* 07 (1024x) */
> -};
> -
> -/* CR00,CR02,CR03,CR04,CR05,SR0B,SR0C,SR0E */
> -static const struct XGI_LVDSCRT1HDataStruct  XGI_LVDSCRT11280x1024_2_H[] = {
> -	{ {0x7E, 0x3B, 0x9A, 0x44, 0x12, 0x00, 0x01, 0x00} }, /* 00 (320x) */
> -	{ {0x7E, 0x3B, 0x9A, 0x44, 0x12, 0x00, 0x01, 0x00} }, /* 01 (360x) */
> -	{ {0x7E, 0x40, 0x84, 0x49, 0x91, 0x00, 0x01, 0x00} }, /* 02 (400x) */
> -	{ {0x7E, 0x47, 0x93, 0x50, 0x9E, 0x00, 0x01, 0x00} }, /* 03 (512x) */
> -	{ {0xCE, 0x77, 0x8A, 0x80, 0x8E, 0x00, 0x02, 0x00} }, /* 04 (640x) */
> -	{ {0xCE, 0x77, 0x8A, 0x80, 0x8E, 0x00, 0x02, 0x00} }, /* 05 (720x) */
> -	{ {0xCE, 0x81, 0x94, 0x8A, 0x98, 0x00, 0x02, 0x00} }, /* 06 (800x) */
> -	{ {0xCE, 0x8F, 0x82, 0x98, 0x06, 0x00, 0x07, 0x00} }, /* 07 (1024x) */
> -	{ {0xCE, 0x9F, 0x92, 0xA8, 0x16, 0x00, 0x07, 0x00} }  /* 08 (1280x) */
> -};
> -
> -/* CR00,CR02,CR03,CR04,CR05,SR0B,SR0C,SR0E */
> -static const struct XGI_LVDSCRT1HDataStruct XGI_LVDSCRT11400x1050_1_H[] = {
> -	{ {0x47, 0x27, 0x8B, 0x2C, 0x1A, 0x00, 0x05, 0x00} }, /* 00 (320x) */
> -	{ {0x47, 0x27, 0x8B, 0x30, 0x1E, 0x00, 0x05, 0x00} }, /* 01 (360x) */
> -	{ {0x51, 0x31, 0x95, 0x36, 0x04, 0x00, 0x01, 0x00} }, /* 02 (400x) */
> -	{ {0x5F, 0x3F, 0x83, 0x44, 0x92, 0x00, 0x01, 0x00} }, /* 03 (512x) */
> -	{ {0x6F, 0x4F, 0x93, 0x54, 0x82, 0x00, 0x05, 0x00} }, /* 04 (640x) */
> -	{ {0x6F, 0x4F, 0x93, 0x54, 0x82, 0x00, 0x05, 0x00} }, /* 05 (720x) */
> -	{ {0x83, 0x63, 0x87, 0x68, 0x16, 0x00, 0x06, 0x00} }, /* 06 (800x) */
> -	{ {0x9F, 0x7F, 0x83, 0x84, 0x92, 0x00, 0x02, 0x00} }, /* 07 (1024x) */
> -	{ {0xBF, 0x9F, 0x83, 0xA4, 0x12, 0x00, 0x07, 0x00} }, /* 08 (1280x) */
> -	{ {0xCE, 0xAE, 0x92, 0xB3, 0x01, 0x00, 0x03, 0x00} }  /* 09 (1400x) */
> -};
> -
> -/* CR00,CR02,CR03,CR04,CR05,SR0B,SR0C,SR0E */
> -static const struct XGI_LVDSCRT1HDataStruct XGI_LVDSCRT11400x1050_2_H[] = {
> -	{ {0x76, 0x3F, 0x83, 0x45, 0x8C, 0x00, 0x41, 0x00} }, /* 00 (320x) */
> -	{ {0x76, 0x3F, 0x83, 0x45, 0x8C, 0x00, 0x41, 0x00} }, /* 01 (360x) */
> -	{ {0x76, 0x31, 0x9A, 0x48, 0x9F, 0x00, 0x41, 0x00} }, /* 02 (400x) */
> -	{ {0x76, 0x3F, 0x9A, 0x4F, 0x96, 0x00, 0x41, 0x00} }, /* 03 (512x) */
> -	{ {0xCE, 0x7E, 0x82, 0x87, 0x9E, 0x00, 0x02, 0x00} }, /* 04 (640x) */
> -	{ {0xCE, 0x7E, 0x82, 0x87, 0x9E, 0x00, 0x02, 0x00} }, /* 05 (720x) */
> -	{ {0xCE, 0x63, 0x92, 0x96, 0x04, 0x00, 0x07, 0x00} }, /* 06 (800x) */
> -	{ {0xCE, 0x7F, 0x92, 0xA4, 0x12, 0x00, 0x07, 0x00} }, /* 07 (1024x) */
> -	{ {0xCE, 0x9F, 0x92, 0xB4, 0x02, 0x00, 0x03, 0x00} }, /* 08 (1280x) */
> -	{ {0xCE, 0xAE, 0x92, 0xBC, 0x0A, 0x00, 0x03, 0x00} }  /* 09 (1400x) */
> -};
> -
> -/* ;302lv channelA [ycchen] 12/05/02 LCDHT=2048 */
> -/* ; CR00,CR02,CR03,CR04,CR05,SR0B,SR0C,SR0E */
> -static const struct XGI_LVDSCRT1HDataStruct XGI_LVDSCRT11600x1200_1_H[] = {
> -	{ {0x5B, 0x27, 0x9F, 0x32, 0x0A, 0x00, 0x01, 0x00} }, /* 00 (320x) */
> -	{ {0x5B, 0x27, 0x9F, 0x32, 0x0A, 0x00, 0x01, 0x00} }, /* 01 (360x) */
> -	{ {0x65, 0x31, 0x89, 0x3C, 0x94, 0x00, 0x01, 0x00} }, /* 02 (400x) */
> -	{ {0x73, 0x3F, 0x97, 0x4A, 0x82, 0x00, 0x05, 0x00} }, /* 03 (512x) */
> -	{ {0x83, 0x4F, 0x87, 0x51, 0x09, 0x00, 0x06, 0x00} }, /* 04 (640x) */
> -	{ {0x83, 0x4F, 0x87, 0x51, 0x09, 0x00, 0x06, 0x00} }, /* 05 (720x) */
> -	{ {0x97, 0x63, 0x9B, 0x65, 0x1D, 0x00, 0x06, 0xF0} }, /* 06 (800x) */
> -	{ {0xB3, 0x7F, 0x97, 0x81, 0x99, 0x00, 0x02, 0x00} }, /* 07 (1024x) */
> -	{ {0xD3, 0x9F, 0x97, 0xA1, 0x19, 0x00, 0x07, 0x00} }, /* 08 (1280x) */
> -	{ {0xE2, 0xAE, 0x86, 0xB9, 0x91, 0x00, 0x03, 0x00} }, /* 09 (1400x) */
> -	{ {0xFB, 0xC7, 0x9F, 0xC9, 0x81, 0x00, 0x07, 0x00} }  /* 0A (1600x) */
> -};
> -
> -/* CR06,CR07,CR10,CR11,CR15,CR16,SR0A+CR09(5->7) */
> -static const struct XGI_LVDSCRT1VDataStruct XGI_LVDSCRT11024x768_1_V[] = {
> -	{ {0x97, 0x1F, 0x60, 0x87, 0x5D, 0x83, 0x10} }, /* 00 (x350) */
> -	{ {0xB4, 0x1F, 0x92, 0x89, 0x8F, 0xB5, 0x30} }, /* 01 (x400) */
> -	{ {0x04, 0x3E, 0xE2, 0x89, 0xDF, 0x05, 0x00} }, /* 02 (x480) */
> -	{ {0x7C, 0xF0, 0x5A, 0x8F, 0x57, 0x7D, 0xA0} }, /* 03 (x600) */
> -	{ {0x24, 0xF5, 0x02, 0x88, 0xFF, 0x25, 0x90} }  /* 04 (x768) */
> -};
> -
> -/* CR06,CR07,CR10,CR11,CR15,CR16,SR0A */
> -static const struct XGI_LVDSCRT1VDataStruct XGI_LVDSCRT11024x768_2_V[] = {
> -	{ {0x24, 0xBB, 0x31, 0x87, 0x5D, 0x25, 0x30} }, /* 00 (x350) */
> -	{ {0x24, 0xBB, 0x4A, 0x80, 0x8F, 0x25, 0x30} }, /* 01 (x400) */
> -	{ {0x24, 0xBB, 0x72, 0x88, 0xDF, 0x25, 0x30} }, /* 02 (x480) */
> -	{ {0x24, 0xF1, 0xAE, 0x84, 0x57, 0x25, 0xB0} }, /* 03 (x600) */
> -	{ {0x24, 0xF5, 0x02, 0x88, 0xFF, 0x25, 0x90} }  /* 04 (x768) */
> -};
> -
> -/* CR06,CR07,CR10,CR11,CR15,CR16,SR0A */
> -static const struct XGI_LVDSCRT1VDataStruct XGI_LVDSCRT11280x1024_1_V[] = {
> -	{ {0x86, 0x1F, 0x5E, 0x82, 0x5D, 0x87, 0x00} }, /* 00 (x350) */
> -	{ {0xB8, 0x1F, 0x90, 0x84, 0x8F, 0xB9, 0x30} }, /* 01 (x400) */
> -	{ {0x08, 0x3E, 0xE0, 0x84, 0xDF, 0x09, 0x00} }, /* 02 (x480) */
> -	{ {0x80, 0xF0, 0x58, 0x8C, 0x57, 0x81, 0xA0} }, /* 03 (x600) */
> -	{ {0x28, 0xF5, 0x00, 0x84, 0xFF, 0x29, 0x90} }, /* 04 (x768) */
> -	{ {0x28, 0x5A, 0x13, 0x87, 0xFF, 0x29, 0xA9} }  /* 05 (x1024) */
> -};
> -
> -/* CR06,CR07,CR10,CR11,CR15,CR16,SR0A */
> -static const struct XGI_LVDSCRT1VDataStruct XGI_LVDSCRT11280x1024_2_V[] = {
> -	{ {0x28, 0xD2, 0xAF, 0x83, 0xAE, 0xD8, 0xA1} }, /* 00 (x350) */
> -	{ {0x28, 0xD2, 0xC8, 0x8C, 0xC7, 0xF2, 0x81} }, /* 01 (x400) */
> -	{ {0x28, 0xD2, 0xF0, 0x84, 0xEF, 0x1A, 0xB1} }, /* 02 (x480) */
> -	{ {0x28, 0xDE, 0x2C, 0x8F, 0x2B, 0x56, 0x91} }, /* 03 (x600) */
> -	{ {0x28, 0xDE, 0x80, 0x83, 0x7F, 0xAA, 0x91} }, /* 04 (x768) */
> -	{ {0x28, 0x5A, 0x13, 0x87, 0xFF, 0x29, 0xA9} }  /* 05 (x1024) */
> -};
> -
> -/* CR06,CR07,CR10,CR11,CR15,CR16,SR0A */
> -static const struct XGI_LVDSCRT1VDataStruct XGI_LVDSCRT11400x1050_1_V[] = {
> -	{ {0x6C, 0x1F, 0x60, 0x84, 0x5D, 0x6D, 0x10} }, /* 00 (x350) */
> -	{ {0x9E, 0x1F, 0x93, 0x86, 0x8F, 0x9F, 0x30} }, /* 01 (x400) */
> -	{ {0xEE, 0x1F, 0xE2, 0x86, 0xDF, 0xEF, 0x10} }, /* 02 (x480) */
> -	{ {0x66, 0xF0, 0x5A, 0x8e, 0x57, 0x67, 0xA0} }, /* 03 (x600) */
> -	{ {0x0E, 0xF5, 0x02, 0x86, 0xFF, 0x0F, 0x90} }, /* 04 (x768) */
> -	{ {0x0E, 0x5A, 0x02, 0x86, 0xFF, 0x0F, 0x89} }, /* 05 (x1024) */
> -	{ {0x28, 0x10, 0x1A, 0x80, 0x19, 0x29, 0x0F} }  /* 06 (x1050) */
> -};
> -
> -/* CR06,CR07,CR10,CR11,CR15,CR16,SR0A */
> -static const struct XGI_LVDSCRT1VDataStruct XGI_LVDSCRT11400x1050_2_V[] = {
> -	{ {0x28, 0x92, 0xB6, 0x83, 0xB5, 0xCF, 0x81} }, /* 00 (x350) */
> -	{ {0x28, 0x92, 0xD5, 0x82, 0xD4, 0xEE, 0x81} }, /* 01 (x400) */
> -	{ {0x28, 0x92, 0xFD, 0x8A, 0xFC, 0x16, 0xB1} }, /* 02 (x480) */
> -	{ {0x28, 0xD4, 0x39, 0x86, 0x57, 0x29, 0x81} }, /* 03 (x600) */
> -	{ {0x28, 0xD4, 0x8D, 0x9A, 0xFF, 0x29, 0xA1} }, /* 04 (x768) */
> -	{ {0x28, 0x5A, 0x0D, 0x9A, 0xFF, 0x29, 0xA9} }, /* 05 (x1024) */
> -	{ {0x28, 0x10, 0x1A, 0x87, 0x19, 0x29, 0x8F} }  /* 06 (x1050) */
> -};
> -
> -/* CR06,CR07,CR10,CR11,CR15,CR16,SR0A+CR09(5->7) */
> -static const struct XGI_LVDSCRT1VDataStruct XGI_LVDSCRT11600x1200_1_V[] = {
> -	{ {0xd4, 0x1F, 0x81, 0x84, 0x5D, 0xd5, 0x10} }, /* 00 (x350) */
> -	{ {0x06, 0x3e, 0xb3, 0x86, 0x8F, 0x07, 0x20} }, /* 01 (x400) */
> -	{ {0x56, 0xba, 0x03, 0x86, 0xDF, 0x57, 0x00} }, /* 02 (x480) */
> -	{ {0xce, 0xF0, 0x7b, 0x8e, 0x57, 0xcf, 0xa0} }, /* 03 (x600) */
> -	{ {0x76, 0xF5, 0x23, 0x86, 0xFF, 0x77, 0x90} }, /* 04 (x768) */
> -	{ {0x76, 0x5A, 0x23, 0x86, 0xFF, 0x77, 0x89} }, /* 05 (x1024) */
> -	{ {0x90, 0x10, 0x1A, 0x8E, 0x19, 0x91, 0x2F} }, /* 06 (x1050) */
> -	{ {0x26, 0x11, 0xd3, 0x86, 0xaF, 0x27, 0x3f} }  /* 07 (x1200) */
> -};
> -
> -/* CR00,CR02,CR03,CR04,CR05,SR0B,SR0C,SR0E */
> -static const struct XGI_LVDSCRT1HDataStruct XGI_LVDSCRT11024x768_1_Hx75[] = {
> -	{ {0x4B, 0x27, 0x8F, 0x32, 0x1B, 0x00, 0x45, 0x00} },/* ; 00 (320x) */
> -	{ {0x4B, 0x27, 0x8F, 0x2B, 0x03, 0x00, 0x44, 0x00} },/* ; 01 (360x) */
> -	{ {0x55, 0x31, 0x99, 0x46, 0x1D, 0x00, 0x55, 0x00} },/* ; 02 (400x) */
> -	{ {0x63, 0x3F, 0x87, 0x4A, 0x93, 0x00, 0x01, 0x00} },/* ; 03 (512x) */
> -	{ {0x6F, 0x4F, 0x93, 0x54, 0x80, 0x00, 0x05, 0x00} },/* ; 04 (640x) */
> -	{ {0x6F, 0x4F, 0x93, 0x54, 0x80, 0x00, 0x05, 0x00} },/* ; 05 (720x) */
> -	{ {0x83, 0x63, 0x87, 0x68, 0x14, 0x00, 0x26, 0x00} },/* ; 06 (800x) */
> -	{ {0x9F, 0x7F, 0x83, 0x85, 0x91, 0x00, 0x02, 0x00} } /* ; 07 (1024x) */
> -};
> -
> -/* CR06,CR07,CR10,CR11,CR15,CR16,SR0A+CR09(5->7) */
> -static const struct XGI_LVDSCRT1VDataStruct XGI_LVDSCRT11024x768_1_Vx75[] = {
> -	{ {0x97, 0x1F, 0x60, 0x87, 0x5D, 0x83, 0x10} },/* ; 00 (x350) */
> -	{ {0xB4, 0x1F, 0x92, 0x89, 0x8F, 0xB5, 0x30} },/* ; 01 (x400) */
> -	{ {0xFE, 0x1F, 0xE0, 0x84, 0xDF, 0xFF, 0x10} },/* ; 02 (x480) */
> -	{ {0x76, 0xF0, 0x58, 0x8C, 0x57, 0x77, 0xA0} },/* ; 03 (x600) */
> -	{ {0x1E, 0xF5, 0x00, 0x83, 0xFF, 0x1F, 0x90} } /* ; 04 (x768) */
> -};
> -
> -/* CR00,CR02,CR03,CR04,CR05,SR0B,SR0C,SR0E */
> -static const struct XGI_LVDSCRT1HDataStruct XGI_LVDSCRT11024x768_2_Hx75[] = {
> -	{ {0x63, 0x27, 0x87, 0x3B, 0x8C, 0x00, 0x01, 0x00} },/* ; 00 (320x) */
> -	{ {0x63, 0x27, 0x87, 0x3B, 0x8C, 0x00, 0x01, 0x00} },/* ; 01 (360x) */
> -	{ {0x63, 0x31, 0x87, 0x3D, 0x8E, 0x00, 0x01, 0x00} },/* ; 02 (400x) */
> -	{ {0x63, 0x3F, 0x87, 0x45, 0x96, 0x00, 0x01, 0x00} },/* ; 03 (512x) */
> -	{ {0xA3, 0x4F, 0x87, 0x6E, 0x9F, 0x00, 0x06, 0x00} },/* ; 04 (640x) */
> -	{ {0xA3, 0x4F, 0x87, 0x6E, 0x9F, 0x00, 0x06, 0x00} },/* ; 05 (720x) */
> -	{ {0xA3, 0x63, 0x87, 0x78, 0x89, 0x00, 0x02, 0x00} },/* ; 06 (800x) */
> -	{ {0xA3, 0x7F, 0x87, 0x86, 0x97, 0x00, 0x02, 0x00} } /* ; 07 (1024x) */
> -};
> -
> -/* CR06,CR07,CR10,CR11,CR15,CR16,SR0A */
> -static const struct XGI_LVDSCRT1VDataStruct XGI_LVDSCRT11024x768_2_Vx75[] = {
> -	{ {0x24, 0xBB, 0x31, 0x87, 0x5D, 0x25, 0x30} },/* ; 00 (x350) */
> -	{ {0x24, 0xBB, 0x4A, 0x80, 0x8F, 0x25, 0x30} },/* ; 01 (x400) */
> -	{ {0x24, 0xBB, 0x72, 0x88, 0xDF, 0x25, 0x30} },/* ; 02 (x480) */
> -	{ {0x24, 0xF1, 0xAE, 0x84, 0x57, 0x25, 0xB0} },/* ; 03 (x600) */
> -	{ {0x24, 0xF5, 0x02, 0x88, 0xFF, 0x25, 0x90} } /* ; 04 (x768) */
> -};
> -
> -/* CR00,CR02,CR03,CR04,CR05,SR0B,SR0C,SR0E */
> -static const struct XGI_LVDSCRT1HDataStruct XGI_LVDSCRT11280x1024_1_Hx75[] = {
> -	{ {0x56, 0x27, 0x9A, 0x30, 0x1E, 0x00, 0x05, 0x00} },/* ; 00 (320x) */
> -	{ {0x56, 0x27, 0x9A, 0x30, 0x1E, 0x00, 0x05, 0x00} },/* ; 01 (360x) */
> -	{ {0x60, 0x31, 0x84, 0x3A, 0x88, 0x00, 0x01, 0x00} },/* ; 02 (400x) */
> -	{ {0x6E, 0x3F, 0x92, 0x48, 0x96, 0x00, 0x01, 0x00} },/* ; 03 (512x) */
> -	{ {0x7E, 0x4F, 0x82, 0x54, 0x06, 0x00, 0x06, 0x00} },/* ; 04 (640x) */
> -	{ {0x7E, 0x4F, 0x82, 0x54, 0x06, 0x00, 0x06, 0x00} },/* ; 05 (720x) */
> -	{ {0x92, 0x63, 0x96, 0x68, 0x1A, 0x00, 0x06, 0x00} },/* ; 06 (800x) */
> -	{ {0xAE, 0x7F, 0x92, 0x84, 0x96, 0x00, 0x02, 0x00} },/* ; 07 (1024x) */
> -	{ {0xCE, 0x9F, 0x92, 0xA5, 0x17, 0x00, 0x07, 0x00} } /* ; 08 (1280x) */
> -};
> -
> -/* CR06,CR07,CR10,CR11,CR15,CR16,SR0A */
> -static const struct XGI_LVDSCRT1VDataStruct XGI_LVDSCRT11280x1024_1_Vx75[] = {
> -	{ {0x86, 0xD1, 0xBC, 0x80, 0xBB, 0xE5, 0x00} },/* ; 00 (x350) */
> -	{ {0xB8, 0x1F, 0x90, 0x84, 0x8F, 0xB9, 0x30} },/* ; 01 (x400) */
> -	{ {0x08, 0x3E, 0xE0, 0x84, 0xDF, 0x09, 0x00} },/* ; 02 (x480) */
> -	{ {0x80, 0xF0, 0x58, 0x8C, 0x57, 0x81, 0xA0} },/* ; 03 (x600) */
> -	{ {0x28, 0xF5, 0x00, 0x84, 0xFF, 0x29, 0x90} },/* ; 04 (x768) */
> -	{ {0x28, 0x5A, 0x13, 0x87, 0xFF, 0x29, 0xA9} } /* ; 05 (x1024) */
> -};
> -
> -/* CR00,CR02,CR03,CR04,CR05,SR0B,SR0C,SR0E */
> -static const struct XGI_LVDSCRT1HDataStruct XGI_LVDSCRT11280x1024_2_Hx75[] = {
> -	{ {0x7E, 0x3B, 0x9A, 0x44, 0x12, 0x00, 0x01, 0x00} },/* ; 00 (320x) */
> -	{ {0x7E, 0x3B, 0x9A, 0x44, 0x12, 0x00, 0x01, 0x00} },/* ; 01 (360x) */
> -	{ {0x7E, 0x40, 0x84, 0x49, 0x91, 0x00, 0x01, 0x00} },/* ; 02 (400x) */
> -	{ {0x7E, 0x47, 0x93, 0x50, 0x9E, 0x00, 0x01, 0x00} },/* ; 03 (512x) */
> -	{ {0xCE, 0x77, 0x8A, 0x80, 0x8E, 0x00, 0x02, 0x00} },/* ; 04 (640x) */
> -	{ {0xCE, 0x77, 0x8A, 0x80, 0x8E, 0x00, 0x02, 0x00} },/* ; 05 (720x) */
> -	{ {0xCE, 0x81, 0x94, 0x8A, 0x98, 0x00, 0x02, 0x00} },/* ; 06 (800x) */
> -	{ {0xCE, 0x8F, 0x82, 0x98, 0x06, 0x00, 0x07, 0x00} },/* ; 07 (1024x) */
> -	{ {0xCE, 0x9F, 0x92, 0xA8, 0x16, 0x00, 0x07, 0x00} } /* ; 08 (1280x) */
> -};
> -
> -/* CR06,CR07,CR10,CR11,CR15,CR16,SR0A */
> -static const struct XGI_LVDSCRT1VDataStruct XGI_LVDSCRT11280x1024_2_Vx75[] = {
> -	{ {0x28, 0xD2, 0xAF, 0x83, 0xAE, 0xD8, 0xA1} },/* ; 00 (x350) */
> -	{ {0x28, 0xD2, 0xC8, 0x8C, 0xC7, 0xF2, 0x81} },/* ; 01 (x400) */
> -	{ {0x28, 0xD2, 0xF0, 0x84, 0xEF, 0x1A, 0xB1} },/* ; 02 (x480) */
> -	{ {0x28, 0xDE, 0x2C, 0x8F, 0x2B, 0x56, 0x91} },/* ; 03 (x600) */
> -	{ {0x28, 0xDE, 0x80, 0x83, 0x7F, 0xAA, 0x91} },/* ; 04 (x768) */
> -	{ {0x28, 0x5A, 0x13, 0x87, 0xFF, 0x29, 0xA9} } /* ; 05 (x1024) */
> -};
> -
> -/*add for new UNIVGABIOS*/
> -static const struct XGI330_LCDDataTablStruct XGI_LCDDataTable[] = {
> -	{Panel_1024x768, 0x0019, 0x0001, XGI_ExtLCD1024x768Data },
> -	{Panel_1024x768, 0x0019, 0x0000, XGI_StLCD1024x768Data },
> -	{Panel_1024x768, 0x0018, 0x0010, XGI_CetLCD1024x768Data },
> -	{Panel_1280x1024, 0x0019, 0x0001, XGI_ExtLCD1280x1024Data },
> -	{Panel_1280x1024, 0x0019, 0x0000, XGI_StLCD1280x1024Data },
> -	{Panel_1280x1024, 0x0018, 0x0010, XGI_CetLCD1280x1024Data },
> -	{Panel_1400x1050, 0x0019, 0x0001, xgifb_lcd_1400x1050 },
> -	{Panel_1400x1050, 0x0019, 0x0000, xgifb_lcd_1400x1050 },
> -	{Panel_1400x1050, 0x0018, 0x0010, XGI_CetLCD1400x1050Data },
> -	{Panel_1600x1200, 0x0019, 0x0001, XGI_ExtLCD1600x1200Data },
> -	{Panel_1600x1200, 0x0019, 0x0000, XGI_StLCD1600x1200Data },
> -	{PanelRef60Hz, 0x0008, 0x0008, XGI_NoScalingData },
> -	{Panel_1024x768x75, 0x0019, 0x0001, XGI_ExtLCD1024x768x75Data },
> -	{Panel_1024x768x75, 0x0019, 0x0000, XGI_ExtLCD1024x768x75Data },
> -	{Panel_1024x768x75, 0x0018, 0x0010, XGI_CetLCD1024x768x75Data },
> -	{Panel_1280x1024x75, 0x0019, 0x0001, xgifb_lcd_1280x1024x75 },
> -	{Panel_1280x1024x75, 0x0019, 0x0000, xgifb_lcd_1280x1024x75 },
> -	{Panel_1280x1024x75, 0x0018, 0x0010, XGI_CetLCD1280x1024x75Data },
> -	{PanelRef75Hz, 0x0008, 0x0008, XGI_NoScalingDatax75 },
> -	{0xFF, 0x0000, 0x0000, NULL } /* End of table */
> -};
> -
> -static const struct XGI330_LCDDataTablStruct XGI_LCDDesDataTable[] = {
> -	{Panel_1024x768, 0x0019, 0x0001, XGI_ExtLCDDes1024x768Data },
> -	{Panel_1024x768, 0x0019, 0x0000, XGI_StLCDDes1024x768Data },
> -	{Panel_1024x768, 0x0018, 0x0010, XGI_CetLCDDes1024x768Data },
> -	{Panel_1280x1024, 0x0019, 0x0001, XGI_ExtLCDDes1280x1024Data },
> -	{Panel_1280x1024, 0x0019, 0x0000, XGI_StLCDDes1280x1024Data },
> -	{Panel_1280x1024, 0x0018, 0x0010, XGI_CetLCDDes1280x1024Data },
> -	{Panel_1400x1050, 0x0019, 0x0001, xgifb_lcddes_1400x1050 },
> -	{Panel_1400x1050, 0x0019, 0x0000, xgifb_lcddes_1400x1050 },
> -	{Panel_1400x1050, 0x0418, 0x0010, XGI_CetLCDDes1400x1050Data },
> -	{Panel_1400x1050, 0x0418, 0x0410, XGI_CetLCDDes1400x1050Data2 },
> -	{Panel_1600x1200, 0x0019, 0x0001, XGI_ExtLCDDes1600x1200Data },
> -	{Panel_1600x1200, 0x0019, 0x0000, XGI_StLCDDes1600x1200Data },
> -	{PanelRef60Hz, 0x0008, 0x0008, XGI_NoScalingDesData },
> -	{Panel_1024x768x75, 0x0019, 0x0001, xgifb_lcddes_1024x768x75 },
> -	{Panel_1024x768x75, 0x0019, 0x0000, xgifb_lcddes_1024x768x75 },
> -	{Panel_1024x768x75, 0x0018, 0x0010, XGI_CetLCDDes1024x768x75Data },
> -	{Panel_1280x1024x75, 0x0019, 0x0001, xgifb_lcddes_1280x1024x75 },
> -	{Panel_1280x1024x75, 0x0019, 0x0000, xgifb_lcddes_1280x1024x75 },
> -	{Panel_1280x1024x75, 0x0018, 0x0010, XGI_CetLCDDes1280x1024x75Data },
> -	{PanelRef75Hz, 0x0008, 0x0008, XGI_NoScalingDesDatax75 },
> -	{0xFF, 0x0000, 0x0000, NULL }
> -};
> -
> -static const struct XGI330_LCDDataTablStruct xgifb_lcddldes[] = {
> -	{Panel_1024x768, 0x0019, 0x0001, XGI_ExtLCDDes1024x768Data },
> -	{Panel_1024x768, 0x0019, 0x0000, XGI_StLCDDes1024x768Data },
> -	{Panel_1024x768, 0x0018, 0x0010, XGI_CetLCDDes1024x768Data },
> -	{Panel_1280x1024, 0x0019, 0x0001, XGI_ExtLCDDLDes1280x1024Data },
> -	{Panel_1280x1024, 0x0019, 0x0000, XGI_StLCDDLDes1280x1024Data },
> -	{Panel_1280x1024, 0x0018, 0x0010, XGI_CetLCDDLDes1280x1024Data },
> -	{Panel_1400x1050, 0x0019, 0x0001, xgifb_lcddldes_1400x1050 },
> -	{Panel_1400x1050, 0x0019, 0x0000, xgifb_lcddldes_1400x1050 },
> -	{Panel_1400x1050, 0x0418, 0x0010, XGI_CetLCDDes1400x1050Data },
> -	{Panel_1400x1050, 0x0418, 0x0410, XGI_CetLCDDes1400x1050Data2 },
> -	{Panel_1600x1200, 0x0019, 0x0001, XGI_ExtLCDDLDes1600x1200Data },
> -	{Panel_1600x1200, 0x0019, 0x0000, XGI_StLCDDLDes1600x1200Data },
> -	{PanelRef60Hz, 0x0008, 0x0008, XGI_NoScalingDesData },
> -	{Panel_1024x768x75, 0x0019, 0x0001, xgifb_lcddes_1024x768x75 },
> -	{Panel_1024x768x75, 0x0019, 0x0000, xgifb_lcddes_1024x768x75 },
> -	{Panel_1024x768x75, 0x0018, 0x0010, XGI_CetLCDDes1024x768x75Data },
> -	{Panel_1280x1024x75, 0x0019, 0x0001, xgifb_lcddldes_1280x1024x75 },
> -	{Panel_1280x1024x75, 0x0019, 0x0000, xgifb_lcddldes_1280x1024x75 },
> -	{Panel_1280x1024x75, 0x0018, 0x0010, XGI_CetLCDDLDes1280x1024x75Data },
> -	{PanelRef75Hz, 0x0008, 0x0008, XGI_NoScalingDesDatax75 },
> -	{0xFF, 0x0000, 0x0000, NULL }
> -};
> -
> -static const struct XGI330_LCDDataTablStruct xgifb_epllcd_crt1_h[] = {
> -	{Panel_1024x768, 0x0018, 0x0000, XGI_LVDSCRT11024x768_1_H },
> -	{Panel_1024x768, 0x0018, 0x0010, XGI_LVDSCRT11024x768_2_H },
> -	{Panel_1280x1024, 0x0018, 0x0000, XGI_LVDSCRT11280x1024_1_H },
> -	{Panel_1280x1024, 0x0018, 0x0010, XGI_LVDSCRT11280x1024_2_H },
> -	{Panel_1400x1050, 0x0018, 0x0000, XGI_LVDSCRT11400x1050_1_H },
> -	{Panel_1400x1050, 0x0018, 0x0010, XGI_LVDSCRT11400x1050_2_H },
> -	{Panel_1600x1200, 0x0018, 0x0000, XGI_LVDSCRT11600x1200_1_H },
> -	{Panel_1024x768x75, 0x0018, 0x0000, XGI_LVDSCRT11024x768_1_Hx75 },
> -	{Panel_1024x768x75, 0x0018, 0x0010, XGI_LVDSCRT11024x768_2_Hx75 },
> -	{Panel_1280x1024x75, 0x0018, 0x0000, XGI_LVDSCRT11280x1024_1_Hx75 },
> -	{Panel_1280x1024x75, 0x0018, 0x0010, XGI_LVDSCRT11280x1024_2_Hx75 },
> -	{0xFF, 0x0000, 0x0000, NULL }
> -};
> -
> -static const struct XGI330_LCDDataTablStruct xgifb_epllcd_crt1_v[] = {
> -	{Panel_1024x768, 0x0018, 0x0000, XGI_LVDSCRT11024x768_1_V },
> -	{Panel_1024x768, 0x0018, 0x0010, XGI_LVDSCRT11024x768_2_V },
> -	{Panel_1280x1024, 0x0018, 0x0000, XGI_LVDSCRT11280x1024_1_V },
> -	{Panel_1280x1024, 0x0018, 0x0010, XGI_LVDSCRT11280x1024_2_V },
> -	{Panel_1400x1050, 0x0018, 0x0000, XGI_LVDSCRT11400x1050_1_V },
> -	{Panel_1400x1050, 0x0018, 0x0010, XGI_LVDSCRT11400x1050_2_V },
> -	{Panel_1600x1200, 0x0018, 0x0000, XGI_LVDSCRT11600x1200_1_V },
> -	{Panel_1024x768x75, 0x0018, 0x0000, XGI_LVDSCRT11024x768_1_Vx75 },
> -	{Panel_1024x768x75, 0x0018, 0x0010, XGI_LVDSCRT11024x768_2_Vx75 },
> -	{Panel_1280x1024x75, 0x0018, 0x0000, XGI_LVDSCRT11280x1024_1_Vx75 },
> -	{Panel_1280x1024x75, 0x0018, 0x0010, XGI_LVDSCRT11280x1024_2_Vx75 },
> -	{0xFF, 0x0000, 0x0000, NULL }
> -};
> -
> -static const struct XGI330_LCDDataTablStruct XGI_EPLLCDDataPtr[] = {
> -	{Panel_1024x768, 0x0018, 0x0000, XGI_LVDS1024x768Data_1 },
> -	{Panel_1024x768, 0x0018, 0x0010, XGI_LVDS1024x768Data_2 },
> -	{Panel_1280x1024, 0x0018, 0x0000, XGI_LVDS1280x1024Data_1 },
> -	{Panel_1280x1024, 0x0018, 0x0010, XGI_LVDS1280x1024Data_2 },
> -	{Panel_1400x1050, 0x0018, 0x0000, XGI_LVDS1400x1050Data_1 },
> -	{Panel_1400x1050, 0x0018, 0x0010, XGI_LVDS1400x1050Data_2 },
> -	{Panel_1600x1200, 0x0018, 0x0000, XGI_LVDS1600x1200Data_1 },
> -	{PanelRef60Hz, 0x0008, 0x0008, XGI_LVDSNoScalingData },
> -	{Panel_1024x768x75, 0x0018, 0x0000, XGI_LVDS1024x768Data_1x75 },
> -	{Panel_1024x768x75, 0x0018, 0x0010, XGI_LVDS1024x768Data_2x75 },
> -	{Panel_1280x1024x75, 0x0018, 0x0000, XGI_LVDS1280x1024Data_1x75 },
> -	{Panel_1280x1024x75, 0x0018, 0x0010, XGI_LVDS1280x1024Data_2x75 },
> -	{PanelRef75Hz, 0x0008, 0x0008, XGI_LVDSNoScalingDatax75 },
> -	{0xFF, 0x0000, 0x0000, NULL }
> -};
> -
> -static const struct XGI330_LCDDataTablStruct XGI_EPLLCDDesDataPtr[] = {
> -	{Panel_1024x768, 0x0018, 0x0000, XGI_LVDS1024x768Des_1 },
> -	{Panel_1024x768, 0x0618, 0x0410, XGI_LVDS1024x768Des_3 },
> -	{Panel_1024x768, 0x0018, 0x0010, XGI_LVDS1024x768Des_2 },
> -	{Panel_1280x1024, 0x0018, 0x0000, XGI_LVDS1280x1024Des_1 },
> -	{Panel_1280x1024, 0x0018, 0x0010, XGI_LVDS1280x1024Des_2 },
> -	{Panel_1400x1050, 0x0018, 0x0000, XGI_LVDS1400x1050Des_1 },
> -	{Panel_1400x1050, 0x0018, 0x0010, XGI_LVDS1400x1050Des_2 },
> -	{Panel_1600x1200, 0x0018, 0x0000, XGI_LVDS1600x1200Des_1 },
> -	{PanelRef60Hz, 0x0008, 0x0008, XGI_LVDSNoScalingDesData },
> -	{Panel_1024x768x75, 0x0018, 0x0000, XGI_LVDS1024x768Des_1x75 },
> -	{Panel_1024x768x75, 0x0618, 0x0410, XGI_LVDS1024x768Des_3x75 },
> -	{Panel_1024x768x75, 0x0018, 0x0010, XGI_LVDS1024x768Des_2x75 },
> -	{Panel_1280x1024x75, 0x0018, 0x0000, XGI_LVDS1280x1024Des_1x75 },
> -	{Panel_1280x1024x75, 0x0018, 0x0010, XGI_LVDS1280x1024Des_2x75 },
> -	{PanelRef75Hz, 0x0008, 0x0008, XGI_LVDSNoScalingDesDatax75 },
> -	{0xFF, 0x0000, 0x0000, NULL }
> -};
> -
> -static const struct XGI330_TVDataTablStruct XGI_TVDataTable[] = {
> -	{0x09E1, 0x0001, XGI_ExtPALData},
> -	{0x09E1, 0x0000, XGI_ExtNTSCData},
> -	{0x09E1, 0x0801, XGI_StPALData},
> -	{0x09E1, 0x0800, XGI_StNTSCData},
> -	{0x49E0, 0x0100, XGI_ExtHiTVData},
> -	{0x49E0, 0x4100, XGI_St2HiTVData},
> -	{0x49E0, 0x4900, XGI_St1HiTVData},
> -	{0x09E0, 0x0020, XGI_ExtYPbPr525iData},
> -	{0x09E0, 0x0040, XGI_ExtYPbPr525pData},
> -	{0x09E0, 0x0080, XGI_ExtYPbPr750pData},
> -	{0x09E0, 0x0820, XGI_StYPbPr525iData},
> -	{0x09E0, 0x0840, XGI_StYPbPr525pData},
> -	{0x09E0, 0x0880, XGI_StYPbPr750pData},
> -	{0xffff, 0x0000, XGI_ExtNTSCData},
> -};
> -
> -/* Dual link only */
> -static const struct XGI330_LCDCapStruct XGI_LCDDLCapList[] = {
> -/* LCDCap1024x768 */
> -	{Panel_1024x768, DefaultLCDCap, 0x88, 0x06, VCLK65_315,
> -	0x6C, 0xC3, 0x35, 0x62,
> -	0x0A, 0xC0, 0x28, 0x10},
> -/* LCDCap1280x1024 */
> -	{Panel_1280x1024, XGI_LCDDualLink + DefaultLCDCap,
> -	0x70, 0x03, VCLK108_2_315,
> -	0x70, 0x44, 0xF8, 0x2F,
> -	0x0A, 0xC0, 0x30, 0x10},
> -/* LCDCap1400x1050 */
> -	{Panel_1400x1050, XGI_LCDDualLink + DefaultLCDCap,
> -	0x70, 0x03, VCLK108_2_315,
> -	 0x70, 0x44, 0xF8, 0x2F,
> -	 0x0A, 0xC0, 0x30, 0x10},
> -/* LCDCap1600x1200 */
> -	{Panel_1600x1200, XGI_LCDDualLink + DefaultLCDCap,
> -	0xC0, 0x03, VCLK162,
> -	 0x43, 0x22, 0x70, 0x24,
> -	 0x0A, 0xC0, 0x30, 0x10},
> -/* LCDCap1024x768x75 */
> -	{Panel_1024x768x75, DefaultLCDCap, 0x60, 0, VCLK78_75,
> -	 0x2B, 0x61, 0x2B, 0x61,
> -	 0x0A, 0xC0, 0x28, 0x10},
> -/* LCDCap1280x1024x75 */
> -	{Panel_1280x1024x75, XGI_LCDDualLink + DefaultLCDCap,
> -	 0x90, 0x03, VCLK135_5,
> -	 0x54, 0x42, 0x4A, 0x61,
> -	 0x0A, 0xC0, 0x30, 0x10},
> -/* LCDCapDefault */
> -	{0xFF, DefaultLCDCap, 0x88, 0x06, VCLK65_315,
> -	0x6C, 0xC3, 0x35, 0x62,
> -	0x0A, 0xC0, 0x28, 0x10}
> -};
> -
> -static const struct XGI330_LCDCapStruct XGI_LCDCapList[] = {
> -/* LCDCap1024x768 */
> -	{Panel_1024x768, DefaultLCDCap, 0x88, 0x06, VCLK65_315,
> -	0x6C, 0xC3, 0x35, 0x62,
> -	0x0A, 0xC0, 0x28, 0x10},
> -/* LCDCap1280x1024 */
> -	{Panel_1280x1024, DefaultLCDCap,
> -	0x70, 0x03, VCLK108_2_315,
> -	0x70, 0x44, 0xF8, 0x2F,
> -	0x0A, 0xC0, 0x30, 0x10},
> -/* LCDCap1400x1050 */
> -	{Panel_1400x1050, DefaultLCDCap,
> -	 0x70, 0x03, VCLK108_2_315,
> -	 0x70, 0x44, 0xF8, 0x2F,
> -	 0x0A, 0xC0, 0x30, 0x10},
> -/* LCDCap1600x1200 */
> -	{Panel_1600x1200, DefaultLCDCap,
> -	 0xC0, 0x03, VCLK162,
> -	 0x5A, 0x23, 0x5A, 0x23,
> -	 0x0A, 0xC0, 0x30, 0x10},
> -/* LCDCap1024x768x75 */
> -	{Panel_1024x768x75, DefaultLCDCap, 0x60, 0, VCLK78_75,
> -	 0x2B, 0x61, 0x2B, 0x61,
> -	 0x0A, 0xC0, 0x28, 0x10},
> -/* LCDCap1280x1024x75 */
> -	{Panel_1280x1024x75, DefaultLCDCap,
> -	 0x90, 0x03, VCLK135_5,
> -	 0x54, 0x42, 0x4A, 0x61,
> -	 0x0A, 0xC0, 0x30, 0x10},
> -/* LCDCapDefault */
> -	{0xFF, DefaultLCDCap, 0x88, 0x06, VCLK65_315,
> -	0x6C, 0xC3, 0x35, 0x62,
> -	0x0A, 0xC0, 0x28, 0x10}
> -};
> -
> -const struct XGI_Ext2Struct XGI330_RefIndex[] = {
> -	{Mode32Bpp + SupportAllCRT2 + SyncPN, RES320x200, VCLK25_175,
> -	0x00, 0x10, 0x59, 320, 200},/* 00 */
> -	{Mode32Bpp + SupportAllCRT2 + SyncPN, RES320x200, VCLK25_175,
> -	0x00, 0x10, 0x00, 320, 400},/* 01 */
> -	{Mode32Bpp + SupportAllCRT2 + SyncNN, RES320x240, VCLK25_175,
> -	0x04, 0x20, 0x50, 320, 240},/* 02 */
> -	{Mode32Bpp + SupportAllCRT2 + SyncPP, RES400x300, VCLK40,
> -	0x05, 0x32, 0x51, 400, 300},/* 03 */
> -	{Mode32Bpp + NoSupportTV + SyncNN + SupportTV1024, RES512x384,
> -	VCLK65_315, 0x06, 0x43, 0x52, 512, 384},/* 04 */
> -	{Mode32Bpp + SupportAllCRT2 + SyncPN, RES640x400, VCLK25_175,
> -	0x00, 0x14, 0x2f, 640, 400},/* 05 */
> -	{Mode32Bpp + SupportAllCRT2 + SyncNN, RES640x480x60, VCLK25_175,
> -	0x04, 0x24, 0x2e, 640, 480},/* 06 640x480x60Hz (LCD 640x480x60z) */
> -	{Mode32Bpp + NoSupportHiVisionTV + SyncNN, RES640x480x72, VCLK31_5,
> -	0x04, 0x24, 0x2e, 640, 480},/* 07 640x480x72Hz (LCD 640x480x70Hz) */
> -	{Mode32Bpp + NoSupportHiVisionTV + SyncNN, RES640x480x75, VCLK31_5,
> -	0x47, 0x24, 0x2e, 640, 480},/* 08 640x480x75Hz (LCD 640x480x75Hz) */
> -	{Mode32Bpp + SupportRAMDAC2 + SyncNN, RES640x480x85, VCLK36,
> -	0x8A, 0x24, 0x2e, 640, 480},/* 09 640x480x85Hz */
> -	{Mode32Bpp + SupportRAMDAC2 + SyncPN, RES640x480x100, VCLK43_163,
> -	0x00, 0x24, 0x2e, 640, 480},/* 0a 640x480x100Hz */
> -	{Mode32Bpp + SupportRAMDAC2 + SyncPN, RES640x480x120, VCLK52_406,
> -	0x00, 0x24, 0x2e, 640, 480},/* 0b 640x480x120Hz */
> -	{Mode32Bpp + SupportRAMDAC2 + SyncPN, RES640x480x160, VCLK72_852,
> -	0x00, 0x24, 0x2e, 640, 480},/* 0c 640x480x160Hz */
> -	{Mode32Bpp + SupportRAMDAC2 + SyncNN, RES640x480x200, VCLK86_6,
> -	0x00, 0x24, 0x2e, 640, 480},/* 0d 640x480x200Hz */
> -	{Mode32Bpp + NoSupportLCD + SyncPP, RES800x600x56, VCLK36,
> -	0x05, 0x36, 0x6a, 800, 600},/* 0e 800x600x56Hz */
> -	{Mode32Bpp + NoSupportTV + SyncPP, RES800x600x60, VCLK40,
> -	0x05, 0x36, 0x6a, 800, 600},/* 0f 800x600x60Hz (LCD 800x600x60Hz) */
> -	{Mode32Bpp + NoSupportHiVisionTV + SyncPP, RES800x600x72, VCLK50,
> -	0x48, 0x36, 0x6a, 800, 600},/* 10 800x600x72Hz (LCD 800x600x70Hz) */
> -	{Mode32Bpp + NoSupportHiVisionTV + SyncPP, RES800x600x75, VCLK49_5,
> -	0x8B, 0x36, 0x6a, 800, 600},/* 11 800x600x75Hz (LCD 800x600x75Hz) */
> -	{Mode32Bpp + SupportRAMDAC2 + SyncPP, RES800x600x85, VCLK56_25,
> -	0x00, 0x36, 0x6a, 800, 600},/* 12 800x600x85Hz */
> -	{Mode32Bpp + SupportRAMDAC2 + SyncPN, RES800x600x100, VCLK68_179,
> -	0x00, 0x36, 0x6a, 800, 600},/* 13 800x600x100Hz */
> -	{Mode32Bpp + SupportRAMDAC2 + SyncPN, RES800x600x120, VCLK83_95,
> -	0x00, 0x36, 0x6a, 800, 600},/* 14 800x600x120Hz */
> -	{Mode32Bpp + SupportRAMDAC2 + SyncPN, RES800x600x160, VCLK116_406,
> -	0x00, 0x36, 0x6a, 800, 600},/* 15 800x600x160Hz */
> -	{Mode32Bpp + InterlaceMode + SyncPP, RES1024x768x43, VCLK44_9,
> -	0x00, 0x47, 0x37, 1024, 768},/* 16 1024x768x43Hz */
> -	/* 17 1024x768x60Hz (LCD 1024x768x60Hz) */
> -	{Mode32Bpp + NoSupportTV + SyncNN + SupportTV1024, RES1024x768x60,
> -	VCLK65_315, 0x06, 0x47, 0x37, 1024, 768},
> -	{Mode32Bpp + NoSupportHiVisionTV + SyncNN, RES1024x768x70, VCLK75,
> -	0x49, 0x47, 0x37, 1024, 768},/* 18 1024x768x70Hz (LCD 1024x768x70Hz) */
> -	{Mode32Bpp + NoSupportHiVisionTV + SyncPP, RES1024x768x75, VCLK78_75,
> -	0x00, 0x47, 0x37, 1024, 768},/* 19 1024x768x75Hz (LCD 1024x768x75Hz) */
> -	{Mode32Bpp + SupportRAMDAC2 + SyncPP, RES1024x768x85, VCLK94_5,
> -	0x8C, 0x47, 0x37, 1024, 768},/* 1a 1024x768x85Hz */
> -	{Mode32Bpp + SupportRAMDAC2 + SyncPN, RES1024x768x100, VCLK113_309,
> -	0x00, 0x47, 0x37, 1024, 768},/* 1b 1024x768x100Hz */
> -	{Mode32Bpp + SupportRAMDAC2 + SyncPN, RES1024x768x120, VCLK139_054,
> -	0x00, 0x47, 0x37, 1024, 768},/* 1c 1024x768x120Hz */
> -	{Mode32Bpp + SupportLCD + SyncPP, RES1280x960x60, VCLK108_2_315,
> -	0x08, 0x58, 0x7b, 1280, 960},/* 1d 1280x960x60Hz */
> -	{Mode32Bpp + InterlaceMode + SyncPP, RES1280x1024x43, VCLK78_75,
> -	0x00, 0x58, 0x3a, 1280, 1024},/* 1e 1280x1024x43Hz */
> -	{Mode32Bpp + NoSupportTV + SyncPP, RES1280x1024x60, VCLK108_2_315,
> -	0x07, 0x58, 0x3a, 1280, 1024},/*1f 1280x1024x60Hz (LCD 1280x1024x60Hz)*/
> -	{Mode32Bpp + NoSupportTV + SyncPP, RES1280x1024x75, VCLK135_5,
> -	0x00, 0x58, 0x3a, 1280, 1024},/*20 1280x1024x75Hz (LCD 1280x1024x75Hz)*/
> -	{Mode32Bpp + SyncPP, RES1280x1024x85, VCLK157_5,
> -	0x00, 0x58, 0x3a, 1280, 1024},/* 21 1280x1024x85Hz */
> -	/* 22 1600x1200x60Hz */
> -	{Mode32Bpp + SupportLCD + SyncPP + SupportCRT2in301C,
> -	RES1600x1200x60, VCLK162, 0x09, 0x7A, 0x3c, 1600, 1200},
> -	{Mode32Bpp + SyncPP + SupportCRT2in301C, RES1600x1200x65, VCLK175,
> -	0x00, 0x69, 0x3c, 1600, 1200},/* 23 1600x1200x65Hz */
> -	{Mode32Bpp + SyncPP + SupportCRT2in301C, RES1600x1200x70, VCLK189,
> -	0x00, 0x69, 0x3c, 1600, 1200},/* 24 1600x1200x70Hz */
> -	{Mode32Bpp + SyncPP + SupportCRT2in301C, RES1600x1200x75, VCLK202_5,
> -	0x00, 0x69, 0x3c, 1600, 1200},/* 25 1600x1200x75Hz */
> -	{Mode32Bpp + SyncPP, RES1600x1200x85, VCLK229_5,
> -	0x00, 0x69, 0x3c, 1600, 1200},/* 26 1600x1200x85Hz */
> -	{Mode32Bpp + SyncPP, RES1600x1200x100, VCLK269_655,
> -	0x00, 0x69, 0x3c, 1600, 1200},/* 27 1600x1200x100Hz */
> -	{Mode32Bpp + SyncPP, RES1600x1200x120, VCLK323_586,
> -	0x00, 0x69, 0x3c, 1600, 1200},/* 28 1600x1200x120Hz */
> -	{Mode32Bpp + SupportLCD + SyncNP, RES1920x1440x60, VCLK234,
> -	0x00, 0x00, 0x68, 1920, 1440},/* 29 1920x1440x60Hz */
> -	{Mode32Bpp + SyncPN, RES1920x1440x65, VCLK254_817,
> -	0x00, 0x00, 0x68, 1920, 1440},/* 2a 1920x1440x65Hz */
> -	{Mode32Bpp + SyncPN, RES1920x1440x70, VCLK277_015,
> -	0x00, 0x00, 0x68, 1920, 1440},/* 2b 1920x1440x70Hz */
> -	{Mode32Bpp + SyncPN, RES1920x1440x75, VCLK291_132,
> -	0x00, 0x00, 0x68, 1920, 1440},/* 2c 1920x1440x75Hz */
> -	{Mode32Bpp + SyncPN, RES1920x1440x85, VCLK330_615,
> -	0x00, 0x00, 0x68, 1920, 1440},/* 2d 1920x1440x85Hz */
> -	{Mode16Bpp + SyncPN, RES1920x1440x100, VCLK388_631,
> -	0x00, 0x00, 0x68, 1920, 1440},/* 2e 1920x1440x100Hz */
> -	{Mode32Bpp + SupportLCD + SyncPN, RES2048x1536x60, VCLK266_952,
> -	0x00, 0x00, 0x6c, 2048, 1536},/* 2f 2048x1536x60Hz */
> -	{Mode32Bpp + SyncPN, RES2048x1536x65, VCLK291_766,
> -	0x00, 0x00, 0x6c, 2048, 1536},/* 30 2048x1536x65Hz */
> -	{Mode32Bpp + SyncPN, RES2048x1536x70, VCLK315_195,
> -	0x00, 0x00, 0x6c, 2048, 1536},/* 31 2048x1536x70Hz */
> -	{Mode32Bpp + SyncPN, RES2048x1536x75, VCLK340_477,
> -	0x00, 0x00, 0x6c, 2048, 1536},/* 32 2048x1536x75Hz */
> -	{Mode16Bpp + SyncPN, RES2048x1536x85, VCLK375_847,
> -	0x00, 0x00, 0x6c, 2048, 1536},/* 33 2048x1536x85Hz */
> -	{Mode32Bpp + SupportHiVision + SupportRAMDAC2 +
> -	 SyncPP + SupportYPbPr750p, RES800x480x60, VCLK39_77,
> -	 0x08, 0x00, 0x70, 800, 480},/* 34 800x480x60Hz */
> -	{Mode32Bpp + SupportRAMDAC2 + SyncPP, RES800x480x75, VCLK49_5,
> -	0x08, 0x00, 0x70, 800, 480},/* 35 800x480x75Hz */
> -	{Mode32Bpp + SupportRAMDAC2 + SyncPP, RES800x480x85, VCLK56_25,
> -	0x08, 0x00, 0x70, 800, 480},/* 36 800x480x85Hz */
> -	{Mode32Bpp + SupportHiVision + SupportRAMDAC2 +
> -	 SyncPP + SupportYPbPr750p, RES1024x576x60, VCLK65_315,
> -	 0x09, 0x00, 0x71, 1024, 576},/* 37 1024x576x60Hz */
> -	{Mode32Bpp + SupportRAMDAC2 + SyncPP, RES1024x576x75, VCLK78_75,
> -	0x09, 0x00, 0x71, 1024, 576},/* 38 1024x576x75Hz */
> -	{Mode32Bpp + SupportRAMDAC2 + SyncPP, RES1024x576x85, VCLK94_5,
> -	0x09, 0x00, 0x71, 1024, 576},/* 39 1024x576x85Hz */
> -	{Mode32Bpp + SupportHiVision + SupportRAMDAC2 +
> -	SyncPP + SupportYPbPr750p, RES1280x720x60, VCLK108_2_315,
> -	0x0A, 0x00, 0x75, 1280, 720},/* 3a 1280x720x60Hz*/
> -	{Mode32Bpp + SupportRAMDAC2 + SyncPP, RES1280x720x75, VCLK135_5,
> -	0x0A, 0x00, 0x75, 1280, 720},/* 3b 1280x720x75Hz */
> -	{Mode32Bpp + SupportRAMDAC2 + SyncPP, RES1280x720x85, VCLK157_5,
> -	0x0A, 0x00, 0x75, 1280, 720},/* 3c 1280x720x85Hz */
> -	{Mode32Bpp + SupportTV + SyncNN, RES720x480x60, VCLK28_322,
> -	0x06, 0x00, 0x31,  720, 480},/* 3d 720x480x60Hz */
> -	{Mode32Bpp + SupportTV + SyncPP, RES720x576x56, VCLK36,
> -	0x06, 0x00, 0x32, 720, 576},/* 3e 720x576x56Hz */
> -	{Mode32Bpp + InterlaceMode + NoSupportLCD + SyncPP, RES856x480x79I,
> -	VCLK35_2, 0x00, 0x00, 0x00,  856, 480},/* 3f 856x480x79I */
> -	{Mode32Bpp + NoSupportLCD + SyncNN, RES856x480x60, VCLK35_2,
> -	0x00, 0x00, 0x00,  856, 480},/* 40 856x480x60Hz */
> -	{Mode32Bpp + NoSupportHiVisionTV + SyncPP, RES1280x768x60,
> -	VCLK79_411, 0x08, 0x48, 0x23, 1280, 768},/* 41 1280x768x60Hz */
> -	{Mode32Bpp + NoSupportHiVisionTV + SyncPP, RES1400x1050x60,
> -	VCLK122_61, 0x08, 0x69, 0x26, 1400, 1050},/* 42 1400x1050x60Hz */
> -	{Mode32Bpp + SupportRAMDAC2 + SyncPP, RES1152x864x60, VCLK80_350,
> -	0x37, 0x00, 0x20, 1152, 864},/* 43 1152x864x60Hz */
> -	{Mode32Bpp + SupportRAMDAC2 + SyncPP, RES1152x864x75, VCLK107_385,
> -	0x37, 0x00, 0x20, 1152, 864},/* 44 1152x864x75Hz */
> -	{Mode32Bpp + SupportLCD + SupportRAMDAC2 + SyncPP, RES1280x960x75,
> -	VCLK125_999, 0x3A, 0x88, 0x7b, 1280, 960},/* 45 1280x960x75Hz */
> -	{Mode32Bpp + SupportLCD + SupportRAMDAC2 + SyncPP, RES1280x960x85,
> -	VCLK148_5, 0x0A, 0x88, 0x7b, 1280, 960},/* 46 1280x960x85Hz */
> -	{Mode32Bpp + SupportLCD + SupportRAMDAC2 + SyncPP, RES1280x960x120,
> -	VCLK217_325, 0x3A, 0x88, 0x7b, 1280, 960},/* 47 1280x960x120Hz */
> -	{Mode32Bpp + SupportRAMDAC2 + SyncPN, RES1024x768x160, VCLK139_054,
> -	0x30, 0x47, 0x37, 1024, 768},/* 48 1024x768x160Hz */
> -};
> -
> -static const unsigned char XGI330_ScreenOffset[] = {
> -	0x14, 0x19, 0x20, 0x28, 0x32, 0x40,
> -	0x50, 0x64, 0x78, 0x80, 0x2d, 0x35,
> -	0x57, 0x48
> -};
> -
> -static const struct SiS_ModeResInfo_S XGI330_ModeResInfo[] = {
> -	{ 320,  200, 8,  8},
> -	{ 320,  240, 8,  8},
> -	{ 320,  400, 8,  8},
> -	{ 400,  300, 8,  8},
> -	{ 512,  384, 8,  8},
> -	{ 640,  400, 8, 16},
> -	{ 640,  480, 8, 16},
> -	{ 800,  600, 8, 16},
> -	{1024,  768, 8, 16},
> -	{1280, 1024, 8, 16},
> -	{1600, 1200, 8, 16},
> -	{1920, 1440, 8, 16},
> -	{2048, 1536, 8, 16},
> -	{ 720,  480, 8, 16},
> -	{ 720,  576, 8, 16},
> -	{1280,  960, 8, 16},
> -	{ 800,  480, 8, 16},
> -	{1024,  576, 8, 16},
> -	{1280,  720, 8, 16},
> -	{ 856,  480, 8, 16},
> -	{1280,  768, 8, 16},
> -	{1400, 1050, 8, 16},
> -	{1152,  864, 8, 16}
> -};
> -
> -const struct SiS_VCLKData XGI_VCLKData[] = {
> -	/* SR2B,SR2C,SR2D */
> -	{0x1B, 0xE1,  25}, /* 00 (25.175MHz) */
> -	{0x4E, 0xE4,  28}, /* 01 (28.322MHz) */
> -	{0x57, 0xE4,  31}, /* 02 (31.500MHz) */
> -	{0xC3, 0xC8,  36}, /* 03 (36.000MHz) */
> -	{0x42, 0xE2,  40}, /* 04 (40.000MHz) */
> -	{0xFE, 0xCD,  43}, /* 05 (43.163MHz) */
> -	{0x5D, 0xC4,  44}, /* 06 (44.900MHz) */
> -	{0x52, 0xE2,  49}, /* 07 (49.500MHz) */
> -	{0x53, 0xE2,  50}, /* 08 (50.000MHz) */
> -	{0x74, 0x67,  52}, /* 09 (52.406MHz) */
> -	{0x6D, 0x66,  56}, /* 0A (56.250MHz) */
> -	{0x6C, 0xC3,  65}, /* 0B (65.000MHz) */
> -	{0x46, 0x44,  67}, /* 0C (67.765MHz) */
> -	{0xB1, 0x46,  68}, /* 0D (68.179MHz) */
> -	{0xD3, 0x4A,  72}, /* 0E (72.852MHz) */
> -	{0x29, 0x61,  75}, /* 0F (75.000MHz) */
> -	{0x6E, 0x46,  76}, /* 10 (75.800MHz) */
> -	{0x2B, 0x61,  78}, /* 11 (78.750MHz) */
> -	{0x31, 0x42,  79}, /* 12 (79.411MHz) */
> -	{0xAB, 0x44,  83}, /* 13 (83.950MHz) */
> -	{0x46, 0x25,  84}, /* 14 (84.800MHz) */
> -	{0x78, 0x29,  86}, /* 15 (86.600MHz) */
> -	{0x62, 0x44,  94}, /* 16 (94.500MHz) */
> -	{0x2B, 0x41, 104}, /* 17 (104.998MHz) */
> -	{0x3A, 0x23, 105}, /* 18 (105.882MHz) */
> -	{0x70, 0x44, 108}, /* 19 (107.862MHz) */
> -	{0x3C, 0x23, 109}, /* 1A (109.175MHz) */
> -	{0x5E, 0x43, 113}, /* 1B (113.309MHz) */
> -	{0xBC, 0x44, 116}, /* 1C (116.406MHz) */
> -	{0xE0, 0x46, 132}, /* 1D (132.258MHz) */
> -	{0x54, 0x42, 135}, /* 1E (135.500MHz) */
> -	{0x9C, 0x22, 139}, /* 1F (139.275MHz) */
> -	{0x41, 0x22, 157}, /* 20 (157.500MHz) */
> -	{0x70, 0x24, 162}, /* 21 (161.793MHz) */
> -	{0x30, 0x21, 175}, /* 22 (175.000MHz) */
> -	{0x4E, 0x22, 189}, /* 23 (188.520MHz) */
> -	{0xDE, 0x26, 194}, /* 24 (194.400MHz) */
> -	{0x62, 0x06, 202}, /* 25 (202.500MHz) */
> -	{0x3F, 0x03, 229}, /* 26 (229.500MHz) */
> -	{0xB8, 0x06, 234}, /* 27 (233.178MHz) */
> -	{0x34, 0x02, 253}, /* 28 (252.699MHz) */
> -	{0x58, 0x04, 255}, /* 29 (254.817MHz) */
> -	{0x24, 0x01, 265}, /* 2A (265.728MHz) */
> -	{0x9B, 0x02, 267}, /* 2B (266.952MHz) */
> -	{0x70, 0x05, 270}, /* 2C (269.65567MHz) */
> -	{0x25, 0x01, 272}, /* 2D (272.04199MHz) */
> -	{0x9C, 0x02, 277}, /* 2E (277.015MHz) */
> -	{0x27, 0x01, 286}, /* 2F (286.359985MHz) */
> -	{0xB3, 0x04, 291}, /* 30 (291.13266MHz) */
> -	{0xBC, 0x05, 292}, /* 31 (291.766MHz) */
> -	{0xF6, 0x0A, 310}, /* 32 (309.789459MHz) */
> -	{0x95, 0x01, 315}, /* 33 (315.195MHz) */
> -	{0xF0, 0x09, 324}, /* 34 (323.586792MHz) */
> -	{0xFE, 0x0A, 331}, /* 35 (330.615631MHz) */
> -	{0xF3, 0x09, 332}, /* 36 (332.177612MHz) */
> -	{0x5E, 0x03, 340}, /* 37 (340.477MHz) */
> -	{0xE8, 0x07, 376}, /* 38 (375.847504MHz) */
> -	{0xDE, 0x06, 389}, /* 39 (388.631439MHz) */
> -	{0x52, 0x2A,  54}, /* 3A (54.000MHz) */
> -	{0x52, 0x6A,  27}, /* 3B (27.000MHz) */
> -	{0x62, 0x24,  70}, /* 3C (70.874991MHz) */
> -	{0x62, 0x64,  70}, /* 3D (70.1048912MHz) */
> -	{0xA8, 0x4C,  30}, /* 3E (30.1048912MHz) */
> -	{0x20, 0x26,  33}, /* 3F (33.7499957MHz) */
> -	{0x31, 0xc2,  39}, /* 40 (39.77MHz) */
> -	{0x11, 0x21,  30}, /* 41 (30MHz) }// NTSC 1024X768 */
> -	{0x2E, 0x48,  25}, /* 42 (25.175MHz) }// ScaleLCD */
> -	{0x24, 0x46,  25}, /* 43 (25.175MHz) */
> -	{0x26, 0x64,  28}, /* 44 (28.322MHz) */
> -	{0x37, 0x64,  40}, /* 45 (40.000MHz) */
> -	{0xA1, 0x42, 108}, /* 46 (95.000MHz) }// QVGA */
> -	{0x37, 0x61, 100}, /* 47 (100.00MHz) */
> -	{0x78, 0x27, 108}, /* 48 (108.200MHz) */
> -	{0xBF, 0xC8,  35}, /* 49 (35.2MHz) */
> -	{0x66, 0x43, 123}, /* 4A (122.61Mhz) */
> -	{0x2C, 0x61,  80}, /* 4B (80.350Mhz) */
> -	{0x3B, 0x61, 108}, /* 4C (107.385Mhz) */
> -	{0x69, 0x61, 191}, /* 4D (190.96MHz ) */
> -	{0x4F, 0x22, 192}, /* 4E (192.069MHz) */
> -	{0x28, 0x26, 322}, /* 4F (322.273MHz) */
> -	{0x5C, 0x6B,  27}, /* 50 (27.74HMz) */
> -	{0x57, 0x24, 126}, /* 51 (125.999MHz) */
> -	{0x5C, 0x42, 148}, /* 52 (148.5MHz) */
> -	{0x42, 0x61, 120}, /* 53 (120.839MHz) */
> -	{0x62, 0x61, 178}, /* 54 (178.992MHz) */
> -	{0x59, 0x22, 217}, /* 55 (217.325MHz) */
> -	{0x29, 0x01, 300}, /* 56 (299.505Mhz) */
> -	{0x52, 0x63,  74}, /* 57 (74.25MHz) */
> -	{0xFF, 0x00,   0}  /* End mark */
> -};
> -
> -static const struct SiS_VBVCLKData XGI_VBVCLKData[] = {
> -	{0x1B, 0xE1,  25}, /* 00 (25.175MHz) */
> -	{0x4E, 0xE4,  28}, /* 01 (28.322MHz) */
> -	{0x57, 0xE4,  31}, /* 02 (31.500MHz) */
> -	{0xC3, 0xC8,  36}, /* 03 (36.000MHz) */
> -	{0x42, 0x47,  40}, /* 04 (40.000MHz) */
> -	{0xFE, 0xCD,  43}, /* 05 (43.163MHz) */
> -	{0x5D, 0xC4,  44}, /* 06 (44.900MHz) */
> -	{0x52, 0x47,  49}, /* 07 (49.500MHz) */
> -	{0x53, 0x47,  50}, /* 08 (50.000MHz) */
> -	{0x74, 0x67,  52}, /* 09 (52.406MHz) */
> -	{0x6D, 0x66,  56}, /* 0A (56.250MHz) */
> -	{0x35, 0x62,  65}, /* 0B (65.000MHz) */
> -	{0x46, 0x44,  67}, /* 0C (67.765MHz) */
> -	{0xB1, 0x46,  68}, /* 0D (68.179MHz) */
> -	{0xD3, 0x4A,  72}, /* 0E (72.852MHz) */
> -	{0x29, 0x61,  75}, /* 0F (75.000MHz) */
> -	{0x6D, 0x46,  75}, /* 10 (75.800MHz) */
> -	{0x41, 0x43,  78}, /* 11 (78.750MHz) */
> -	{0x31, 0x42,  79}, /* 12 (79.411MHz) */
> -	{0xAB, 0x44,  83}, /* 13 (83.950MHz) */
> -	{0x46, 0x25,  84}, /* 14 (84.800MHz) */
> -	{0x78, 0x29,  86}, /* 15 (86.600MHz) */
> -	{0x62, 0x44,  94}, /* 16 (94.500MHz) */
> -	{0x2B, 0x22, 104}, /* 17 (104.998MHz) */
> -	{0x49, 0x24, 105}, /* 18 (105.882MHz) */
> -	{0xF8, 0x2F, 108}, /* 19 (108.279MHz) */
> -	{0x3C, 0x23, 109}, /* 1A (109.175MHz) */
> -	{0x5E, 0x43, 113}, /* 1B (113.309MHz) */
> -	{0xBC, 0x44, 116}, /* 1C (116.406MHz) */
> -	{0xE0, 0x46, 132}, /* 1D (132.258MHz) */
> -	{0xD4, 0x28, 135}, /* 1E (135.220MHz) */
> -	{0xEA, 0x2A, 139}, /* 1F (139.275MHz) */
> -	{0x41, 0x22, 157}, /* 20 (157.500MHz) */
> -	{0x70, 0x24, 162}, /* 21 (161.793MHz) */
> -	{0x30, 0x21, 175}, /* 22 (175.000MHz) */
> -	{0x4E, 0x22, 189}, /* 23 (188.520MHz) */
> -	{0xDE, 0x26, 194}, /* 24 (194.400MHz) */
> -	{0x70, 0x07, 202}, /* 25 (202.500MHz) */
> -	{0x3F, 0x03, 229}, /* 26 (229.500MHz) */
> -	{0xB8, 0x06, 234}, /* 27 (233.178MHz) */
> -	{0x34, 0x02, 253}, /* 28 (252.699997 MHz) */
> -	{0x58, 0x04, 255}, /* 29 (254.817MHz) */
> -	{0x24, 0x01, 265}, /* 2A (265.728MHz) */
> -	{0x9B, 0x02, 267}, /* 2B (266.952MHz) */
> -	{0x70, 0x05, 270}, /* 2C (269.65567 MHz) */
> -	{0x25, 0x01, 272}, /* 2D (272.041992 MHz) */
> -	{0x9C, 0x02, 277}, /* 2E (277.015MHz) */
> -	{0x27, 0x01, 286}, /* 2F (286.359985 MHz) */
> -	{0x3C, 0x02, 291}, /* 30 (291.132660 MHz) */
> -	{0xEF, 0x0A, 292}, /* 31 (291.766MHz) */
> -	{0xF6, 0x0A, 310}, /* 32 (309.789459 MHz) */
> -	{0x95, 0x01, 315}, /* 33 (315.195MHz) */
> -	{0xF0, 0x09, 324}, /* 34 (323.586792 MHz) */
> -	{0xFE, 0x0A, 331}, /* 35 (330.615631 MHz) */
> -	{0xF3, 0x09, 332}, /* 36 (332.177612 MHz) */
> -	{0xEA, 0x08, 340}, /* 37 (340.477MHz) */
> -	{0xE8, 0x07, 376}, /* 38 (375.847504 MHz) */
> -	{0xDE, 0x06, 389}, /* 39 (388.631439 MHz) */
> -	{0x52, 0x2A,  54}, /* 3A (54.000MHz) */
> -	{0x52, 0x6A,  27}, /* 3B (27.000MHz) */
> -	{0x62, 0x24,  70}, /* 3C (70.874991MHz) */
> -	{0x62, 0x64,  70}, /* 3D (70.1048912MHz) */
> -	{0xA8, 0x4C,  30}, /* 3E (30.1048912MHz) */
> -	{0x20, 0x26,  33}, /* 3F (33.7499957MHz) */
> -	{0x31, 0xc2,  39}, /* 40 (39.77MHz) */
> -	{0x11, 0x21,  30}, /* 41 (30MHz) }// NTSC 1024X768 */
> -	{0x2E, 0x48,  25}, /* 42 (25.175MHz) }// ScaleLCD */
> -	{0x24, 0x46,  25}, /* 43 (25.175MHz) */
> -	{0x26, 0x64,  28}, /* 44 (28.322MHz) */
> -	{0x37, 0x64,  40}, /* 45 (40.000MHz) */
> -	{0xA1, 0x42, 108}, /* 46 (95.000MHz) }// QVGA */
> -	{0x37, 0x61, 100}, /* 47 (100.00MHz) */
> -	{0x78, 0x27, 108}, /* 48 (108.200MHz) */
> -	{0xBF, 0xC8, 35 }, /* 49 (35.2MHz) */
> -	{0x66, 0x43, 123}, /* 4A (122.61Mhz) */
> -	{0x2C, 0x61, 80 }, /* 4B (80.350Mhz) */
> -	{0x3B, 0x61, 108}, /* 4C (107.385Mhz) */
> -	{0x69, 0x61, 191}, /* 4D (190.96MHz ) */
> -	{0x4F, 0x22, 192}, /* 4E (192.069MHz) */
> -	{0x28, 0x26, 322}, /* 4F (322.273MHz) */
> -	{0x5C, 0x6B,  27}, /* 50 (27.74HMz) */
> -	{0x57, 0x24, 126}, /* 51 (125.999MHz) */
> -	{0x5C, 0x42, 148}, /* 52 (148.5MHz) */
> -	{0x42, 0x61, 120}, /* 53 (120.839MHz) */
> -	{0x62, 0x61, 178}, /* 54 (178.992MHz) */
> -	{0x59, 0x22, 217}, /* 55 (217.325MHz) */
> -	{0x29, 0x01, 300}, /* 56 (299.505Mhz) */
> -	{0x52, 0x63,  74}, /* 57 (74.25MHz) */
> -	{0xFF, 0x00,   0}  /* End mark */
> -};
> -
> -#define XGI301TVDelay 0x22
> -#define XGI301LCDDelay 0x12
> -
> -static const unsigned char TVAntiFlickList[] = {/* NTSCAntiFlicker */
> -	0x04, /* ; 0 Adaptive */
> -	0x00, /* ; 1 new anti-flicker ? */
> -
> -	0x04, /* ; 0 Adaptive */
> -	0x08, /* ; 1 new anti-flicker ? */
> -
> -	0x04, /* ; 0 ? */
> -	0x00  /* ; 1 new anti-flicker ? */
> -};
> -
> -static const unsigned char TVEdgeList[] = {
> -	0x00, /* ; 0 NTSC No Edge enhance */
> -	0x04, /* ; 1 NTSC Adaptive Edge enhance */
> -	0x00, /* ; 0 PAL No Edge enhance */
> -	0x04, /* ; 1 PAL Adaptive Edge enhance */
> -	0x00, /* ; 0 HiTV */
> -	0x00  /* ; 1 HiTV */
> -};
> -
> -static const unsigned long TVPhaseList[] = {
> -	0x08BAED21, /* ; 0 NTSC phase */
> -	0x00E3052A, /* ; 1 PAL phase */
> -	0x9B2EE421, /* ; 2 PAL-M phase */
> -	0xBA3EF421, /* ; 3 PAL-N phase */
> -	0xA7A28B1E, /* ; 4 NTSC 1024x768 */
> -	0xE00A831E, /* ; 5 PAL-M 1024x768 */
> -	0x00000000, /* ; 6 reserved */
> -	0x00000000, /* ; 7 reserved */
> -	0xD67BF021, /* ; 8 NTSC phase */
> -	0xE986092A, /* ; 9 PAL phase */
> -	0xA4EFE621, /* ; A PAL-M phase */
> -	0x4694F621, /* ; B PAL-N phase */
> -	0x8BDE711C, /* ; C NTSC 1024x768 */
> -	0xE00A831E  /* ; D PAL-M 1024x768 */
> -};
> -
> -static const unsigned char NTSCYFilter1[] = {
> -	0x00, 0xF4, 0x10, 0x38, /* 0 : 320x text mode */
> -	0x00, 0xF4, 0x10, 0x38, /* 1 : 360x text mode */
> -	0xEB, 0x04, 0x25, 0x18, /* 2 : 640x text mode */
> -	0xF1, 0x04, 0x1F, 0x18, /* 3 : 720x text mode */
> -	0x00, 0xF4, 0x10, 0x38, /* 4 : 320x gra. mode */
> -	0xEB, 0x04, 0x25, 0x18, /* 5 : 640x gra. mode */
> -	0xEB, 0x15, 0x25, 0xF6  /* 6 : 800x gra. mode */
> -};
> -
> -static const unsigned char PALYFilter1[] = {
> -	0x00, 0xF4, 0x10, 0x38, /* 0 : 320x text mode */
> -	0x00, 0xF4, 0x10, 0x38, /* 1 : 360x text mode */
> -	0xF1, 0xF7, 0x1F, 0x32, /* 2 : 640x text mode */
> -	0xF3, 0x00, 0x1D, 0x20, /* 3 : 720x text mode */
> -	0x00, 0xF4, 0x10, 0x38, /* 4 : 320x gra. mode */
> -	0xF1, 0xF7, 0x1F, 0x32, /* 5 : 640x gra. mode */
> -	0xFC, 0xFB, 0x14, 0x2A  /* 6 : 800x gra. mode */
> -};
> -
> -static const unsigned char xgifb_palmn_yfilter1[] = {
> -	0x00, 0xF4, 0x10, 0x38, /* 0 : 320x text mode */
> -	0x00, 0xF4, 0x10, 0x38, /* 1 : 360x text mode */
> -	0xEB, 0x04, 0x10, 0x18, /* 2 : 640x text mode */
> -	0xF7, 0x06, 0x19, 0x14, /* 3 : 720x text mode */
> -	0x00, 0xF4, 0x10, 0x38, /* 4 : 320x gra. mode */
> -	0xEB, 0x04, 0x25, 0x18, /* 5 : 640x gra. mode */
> -	0xEB, 0x15, 0x25, 0xF6, /* 6 : 800x gra. mode */
> -	0xFF, 0xFF, 0xFF, 0xFF  /* End of Table */
> -};
> -
> -static const unsigned char xgifb_yfilter2[] = {
> -	0xFF, 0x03, 0x02, 0xF6, 0xFC, 0x27, 0x46, /* 0 : 320x text mode */
> -	0x01, 0x02, 0xFE, 0xF7, 0x03, 0x27, 0x3C, /* 1 : 360x text mode */
> -	0xFF, 0x03, 0x02, 0xF6, 0xFC, 0x27, 0x46, /* 2 : 640x text mode */
> -	0x01, 0x02, 0xFE, 0xF7, 0x03, 0x27, 0x3C, /* 3 : 720x text mode */
> -	0xFF, 0x03, 0x02, 0xF6, 0xFC, 0x27, 0x46, /* 4 : 320x gra. mode */
> -	0xFF, 0x03, 0x02, 0xF6, 0xFC, 0x27, 0x46, /* 5 : 640x gra. mode */
> -	0x01, 0x01, 0xFC, 0xF8, 0x08, 0x26, 0x38, /* 6 : 800x gra. mode */
> -	0xFF, 0xFF, 0xFC, 0x00, 0x0F, 0x22, 0x28  /* 7 : 1024xgra. mode */
> -};
> -
> -static const unsigned char XGI_NTSC1024AdjTime[] = {
> -	0xa7, 0x07, 0xf2, 0x6e, 0x17, 0x8b, 0x73, 0x53,
> -	0x13, 0x40, 0x34, 0xF4, 0x63, 0xBB, 0xCC, 0x7A,
> -	0x58, 0xe4, 0x73, 0xd0, 0x13
> -};
> -
> -static const struct XGI301C_Tap4TimingStruct xgifb_tap4_timing[] = {
> -	{0, {
> -	0x00, 0x20, 0x00, 0x00, 0x7F, 0x20, 0x02, 0x7F, /* ; C0-C7 */
> -	0x7D, 0x20, 0x04, 0x7F, 0x7D, 0x1F, 0x06, 0x7E, /* ; C8-CF */
> -	0x7C, 0x1D, 0x09, 0x7E, 0x7C, 0x1B, 0x0B, 0x7E, /* ; D0-D7 */
> -	0x7C, 0x19, 0x0E, 0x7D, 0x7C, 0x17, 0x11, 0x7C, /* ; D8-DF */
> -	0x7C, 0x14, 0x14, 0x7C, 0x7C, 0x11, 0x17, 0x7C, /* ; E0-E7 */
> -	0x7D, 0x0E, 0x19, 0x7C, 0x7E, 0x0B, 0x1B, 0x7C, /* ; EA-EF */
> -	0x7E, 0x09, 0x1D, 0x7C, 0x7F, 0x06, 0x1F, 0x7C, /* ; F0-F7 */
> -	0x7F, 0x04, 0x20, 0x7D, 0x00, 0x02, 0x20, 0x7E  /* ; F8-FF */
> -	}
> -	}
> -};
> -
> -static const struct XGI301C_Tap4TimingStruct PALTap4Timing[] = {
> -	{600,	{
> -		0x05, 0x19, 0x05, 0x7D, 0x03, 0x19, 0x06, 0x7E, /* ; C0-C7 */
> -		0x02, 0x19, 0x08, 0x7D, 0x01, 0x18, 0x0A, 0x7D, /* ; C8-CF */
> -		0x00, 0x18, 0x0C, 0x7C, 0x7F, 0x17, 0x0E, 0x7C, /* ; D0-D7 */
> -		0x7E, 0x16, 0x0F, 0x7D, 0x7E, 0x14, 0x11, 0x7D, /* ; D8-DF */
> -		0x7D, 0x13, 0x13, 0x7D, 0x7D, 0x11, 0x14, 0x7E, /* ; E0-E7 */
> -		0x7D, 0x0F, 0x16, 0x7E, 0x7D, 0x0E, 0x17, 0x7E, /* ; EA-EF */
> -		0x7D, 0x0C, 0x18, 0x7F, 0x7D, 0x0A, 0x18, 0x01, /* ; F0-F7 */
> -		0x7D, 0x08, 0x19, 0x02, 0x7D, 0x06, 0x19, 0x04  /* ; F8-FF */
> -		}
> -	},
> -	{768,	{
> -		0x08, 0x12, 0x08, 0x7E, 0x07, 0x12, 0x09, 0x7E, /* ; C0-C7 */
> -		0x06, 0x12, 0x0A, 0x7E, 0x05, 0x11, 0x0B, 0x7F, /* ; C8-CF */
> -		0x04, 0x11, 0x0C, 0x7F, 0x03, 0x11, 0x0C, 0x00, /* ; D0-D7 */
> -		0x03, 0x10, 0x0D, 0x00, 0x02, 0x0F, 0x0E, 0x01, /* ; D8-DF */
> -		0x01, 0x0F, 0x0F, 0x01, 0x01, 0x0E, 0x0F, 0x02, /* ; E0-E7 */
> -		0x00, 0x0D, 0x10, 0x03, 0x7F, 0x0C, 0x11, 0x04, /* ; EA-EF */
> -		0x7F, 0x0C, 0x11, 0x04, 0x7F, 0x0B, 0x11, 0x05, /* ; F0-F7 */
> -		0x7E, 0x0A, 0x12, 0x06, 0x7E, 0x09, 0x12, 0x07  /* ; F8-FF */
> -		}
> -	},
> -	{0xFFFF, {
> -		0x04, 0x1A, 0x04, 0x7E, 0x02, 0x1B, 0x05, 0x7E, /* ; C0-C7 */
> -		0x01, 0x1A, 0x07, 0x7E, 0x00, 0x1A, 0x09, 0x7D, /* ; C8-CF */
> -		0x7F, 0x19, 0x0B, 0x7D, 0x7E, 0x18, 0x0D, 0x7D, /* ; D0-D7 */
> -		0x7D, 0x17, 0x10, 0x7C, 0x7D, 0x15, 0x12, 0x7C, /* ; D8-DF */
> -		0x7C, 0x14, 0x14, 0x7C, 0x7C, 0x12, 0x15, 0x7D, /* ; E0-E7 */
> -		0x7C, 0x10, 0x17, 0x7D, 0x7C, 0x0D, 0x18, 0x7F, /* ; EA-EF */
> -		0x7D, 0x0B, 0x19, 0x7F, 0x7D, 0x09, 0x1A, 0x00, /* ; F0-F7 */
> -		0x7D, 0x07, 0x1A, 0x02, 0x7E, 0x05, 0x1B, 0x02  /* ; F8-FF */
> -		}
> -	}
> -};
> -
> -static const struct XGI301C_Tap4TimingStruct xgifb_ntsc_525_tap4_timing[] = {
> -	{480,	{
> -		0x04, 0x1A, 0x04, 0x7E, 0x03, 0x1A, 0x06, 0x7D, /* ; C0-C7 */
> -		0x01, 0x1A, 0x08, 0x7D, 0x00, 0x19, 0x0A, 0x7D, /* ; C8-CF */
> -		0x7F, 0x19, 0x0C, 0x7C, 0x7E, 0x18, 0x0E, 0x7C, /* ; D0-D7 */
> -		0x7E, 0x17, 0x10, 0x7B, 0x7D, 0x15, 0x12, 0x7C, /* ; D8-DF */
> -		0x7D, 0x13, 0x13, 0x7D, 0x7C, 0x12, 0x15, 0x7D, /* ; E0-E7 */
> -		0x7C, 0x10, 0x17, 0x7D, 0x7C, 0x0E, 0x18, 0x7E, /* ; EA-EF */
> -		0x7D, 0x0C, 0x19, 0x7E, 0x7D, 0x0A, 0x19, 0x00, /* ; F0-F7 */
> -		0x7D, 0x08, 0x1A, 0x01, 0x7E, 0x06, 0x1A, 0x02  /* ; F8-FF */
> -		}
> -	},
> -	{600,	{
> -		0x07, 0x14, 0x07, 0x7E, 0x06, 0x14, 0x09, 0x7D, /* ; C0-C7 */
> -		0x05, 0x14, 0x0A, 0x7D, 0x04, 0x13, 0x0B, 0x7E, /* ; C8-CF */
> -		0x03, 0x13, 0x0C, 0x7E, 0x02, 0x12, 0x0D, 0x7F, /* ; D0-D7 */
> -		0x01, 0x12, 0x0E, 0x7F, 0x01, 0x11, 0x0F, 0x7F, /* ; D8-DF */
> -		0x01, 0x10, 0x10, 0x00, 0x7F, 0x0F, 0x11, 0x01, /* ; E0-E7 */
> -		0x7F, 0x0E, 0x12, 0x01, 0x7E, 0x0D, 0x12, 0x03, /* ; EA-EF */
> -		0x7E, 0x0C, 0x13, 0x03, 0x7E, 0x0B, 0x13, 0x04, /* ; F0-F7 */
> -		0x7E, 0x0A, 0x14, 0x04, 0x7D, 0x09, 0x14, 0x06  /* ; F8-FF */
> -		}
> -	},
> -	{0xFFFF, {
> -		 0x09, 0x0F, 0x09, 0x7F, 0x08, 0x0F, 0x09, 0x00, /* ; C0-C7 */
> -		 0x07, 0x0F, 0x0A, 0x00, 0x06, 0x0F, 0x0A, 0x01, /* ; C8-CF */
> -		 0x06, 0x0E, 0x0B, 0x01, 0x05, 0x0E, 0x0B, 0x02, /* ; D0-D7 */
> -		 0x04, 0x0E, 0x0C, 0x02, 0x04, 0x0D, 0x0C, 0x03, /* ; D8-DF */
> -		 0x03, 0x0D, 0x0D, 0x03, 0x02, 0x0C, 0x0D, 0x05, /* ; E0-E7 */
> -		 0x02, 0x0C, 0x0E, 0x04, 0x01, 0x0B, 0x0E, 0x06, /* ; EA-EF */
> -		 0x01, 0x0B, 0x0E, 0x06, 0x00, 0x0A, 0x0F, 0x07, /* ; F0-F7 */
> -		 0x00, 0x0A, 0x0F, 0x07, 0x00, 0x09, 0x0F, 0x08  /* ; F8-FF */
> -		}
> -	}
> -};
> -
> -static const struct XGI301C_Tap4TimingStruct YPbPr750pTap4Timing[] = {
> -	{0xFFFF, {
> -		 0x05, 0x19, 0x05, 0x7D, 0x03, 0x19, 0x06, 0x7E, /* ; C0-C7 */
> -		 0x02, 0x19, 0x08, 0x7D, 0x01, 0x18, 0x0A, 0x7D, /* ; C8-CF */
> -		 0x00, 0x18, 0x0C, 0x7C, 0x7F, 0x17, 0x0E, 0x7C, /* ; D0-D7 */
> -		 0x7E, 0x16, 0x0F, 0x7D, 0x7E, 0x14, 0x11, 0x7D, /* ; D8-DF */
> -		 0x7D, 0x13, 0x13, 0x7D, 0x7D, 0x11, 0x14, 0x7E, /* ; E0-E7 */
> -		 0x7D, 0x0F, 0x16, 0x7E, 0x7D, 0x0E, 0x17, 0x7E, /* ; EA-EF */
> -		 0x7D, 0x0C, 0x18, 0x7F, 0x7D, 0x0A, 0x18, 0x01, /* ; F0-F7 */
> -		 0x7D, 0x08, 0x19, 0x02, 0x7D, 0x06, 0x19, 0x04 /* F8-FF */
> -		}
> -	}
> -};
> -#endif
> diff --git a/drivers/staging/xgifb/vb_util.h b/drivers/staging/xgifb/vb_util.h
> deleted file mode 100644
> index 0f6d5aac04f6..000000000000
> --- a/drivers/staging/xgifb/vb_util.h
> +++ /dev/null
> @@ -1,46 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _VBUTIL_
> -#define _VBUTIL_
> -static inline void xgifb_reg_set(unsigned long port, u8 index, u8 data)
> -{
> -	outb(index, port);
> -	outb(data, port + 1);
> -}
> -
> -static inline u8 xgifb_reg_get(unsigned long port, u8 index)
> -{
> -	outb(index, port);
> -	return inb(port + 1);
> -}
> -
> -static inline void xgifb_reg_and_or(unsigned long port, u8 index,
> -				    unsigned int data_and, unsigned int data_or)
> -{
> -	u8 temp;
> -
> -	temp = xgifb_reg_get(port, index);
> -	temp = (u8)((temp & data_and) | data_or);
> -	xgifb_reg_set(port, index, temp);
> -}
> -
> -static inline void xgifb_reg_and(unsigned long port, u8 index,
> -				 unsigned int data_and)
> -{
> -	u8 temp;
> -
> -	temp = xgifb_reg_get(port, index);
> -	temp = (u8)(temp & data_and);
> -	xgifb_reg_set(port, index, temp);
> -}
> -
> -static inline void xgifb_reg_or(unsigned long port, u8 index,
> -				unsigned int data_or)
> -{
> -	u8 temp;
> -
> -	temp = xgifb_reg_get(port, index);
> -	temp |= data_or;
> -	xgifb_reg_set(port, index, temp);
> -}
> -#endif
> -
> diff --git a/drivers/staging/xgifb/vgatypes.h b/drivers/staging/xgifb/vgatypes.h
> deleted file mode 100644
> index 22919f2368d5..000000000000
> --- a/drivers/staging/xgifb/vgatypes.h
> +++ /dev/null
> @@ -1,51 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _VGATYPES_
> -#define _VGATYPES_
> -
> -#include <linux/fb.h>	/* for struct fb_var_screeninfo for sis.h */
> -#include "../../video/fbdev/sis/vgatypes.h"
> -#include "../../video/fbdev/sis/sis.h"		/* for LCD_TYPE */
> -
> -enum XGI_VB_CHIP_TYPE {
> -	VB_CHIP_Legacy = 0,
> -	VB_CHIP_301,
> -	VB_CHIP_301B,
> -	VB_CHIP_301LV,
> -	VB_CHIP_302,
> -	VB_CHIP_302B,
> -	VB_CHIP_302LV,
> -	VB_CHIP_301C,
> -	VB_CHIP_302ELV,
> -	VB_CHIP_UNKNOWN, /* other video bridge or no video bridge */
> -	MAX_VB_CHIP
> -};
> -
> -struct xgi_hw_device_info {
> -	unsigned long ulExternalChip; /* NO VB or other video bridge*/
> -				      /* if ujVBChipID = VB_CHIP_UNKNOWN, */
> -
> -	void __iomem *pjVideoMemoryAddress;/* base virtual memory address */
> -					    /* of Linear VGA memory */
> -
> -	unsigned long ulVideoMemorySize; /* size, in bytes, of the
> -					  * memory on the board
> -					  */
> -
> -	unsigned char jChipType; /* Used to Identify Graphics Chip */
> -				 /* defined in the data structure type  */
> -				 /* "XGI_CHIP_TYPE" */
> -
> -	unsigned char jChipRevision; /* Used to Identify Graphics
> -				      * Chip Revision
> -				      */
> -
> -	unsigned char ujVBChipID; /* the ID of video bridge */
> -				  /* defined in the data structure type */
> -				  /* "XGI_VB_CHIP_TYPE" */
> -
> -	unsigned long ulCRT2LCDType; /* defined in the data structure type */
> -};
> -
> -/* Additional IOCTL for communication xgifb <> X driver        */
> -/* If changing this, xgifb.h must also be changed (for xgifb) */
> -#endif
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
