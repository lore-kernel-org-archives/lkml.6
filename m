Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4C0C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72D52147A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="cz2diqbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C72D52147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbeIMSnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:43:21 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42245 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbeIMSnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:43:21 -0400
Received: by mail-ed1-f68.google.com with SMTP id l5so4637497edw.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 06:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UjIkaMRLsW/jV5zIwvdECJ/rjb2sLKMH+wlJ6BF8+ow=;
        b=cz2diqblCZ9xmMFyCigXE4k7w5PG6VfOOp1v2DaM0+0DDgELR4YujKW7V93QNSTpbJ
         wstnSG1u+yKSwUYMFidG7M4logvRpzr4D9MUdBUYN2l1Rrk9E83w6BLjKnqRf/NddOCw
         JfKTi17u3tuN98CzX719YZG2fOb6cULTXwBuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=UjIkaMRLsW/jV5zIwvdECJ/rjb2sLKMH+wlJ6BF8+ow=;
        b=fQhTFMZH9YXuWh6k0JufnJ5ozgFcSQ5+DcvHAAOYaOTZ343QoI+4gQZpyh+oiV2rSb
         AMJlTYJZfbG8sZz/lWLPGyAn0KHwQ5HhOFyaf3CzFVEADZSxcJU9TsRAzoGbpUFy0oRV
         xtHQwaX/F0J+7uoRiUuKYDt+vie75nsCyjiv1LqFUh6CcmVCkirMrbj/t6qLx+0E4jW0
         MN9Ohtd4K5f5Gq//e6WB9ZCJ0K5TEU04UVQp5azmc8HLp2rqtnNdOUHf47+fYGWbdrbh
         p6/3QwvUPQM7I1fp0G/Zwvp58et7QnJ78aeBfNp7XOVA6MvODXpYR5PgaEwKiZB4qrHK
         bKgA==
X-Gm-Message-State: APzg51D02lPhh4FhOIiWpQopQqf8RbYjPEXWx6PiBAtEq78vxP5L6o6G
        H9cnun6Vaq95YXv6KIfC42+kgg==
X-Google-Smtp-Source: ANB0VdZHbapP0BE6y3lCCMRy1G634Mhw1+pPjdmxKYuEv9Z0E1vmCS5QthAdZcT63Pr7VFbstI36cg==
X-Received: by 2002:a50:a305:: with SMTP id 5-v6mr10844170edn.57.1536845629527;
        Thu, 13 Sep 2018 06:33:49 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id a11-v6sm1797125edn.95.2018.09.13.06.33.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 06:33:48 -0700 (PDT)
Date:   Thu, 13 Sep 2018 15:33:46 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Geoff Levand <geoff@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Kumar Gala <galak@kernel.crashing.org>,
        Li Yang <leoyang.li@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-block@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 02/24] drivers/video/fbdev: use ioremap_wc/wt()
 instead of __ioremap()
Message-ID: <20180913133346.GD11082@phenom.ffwll.local>
Mail-Followup-To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Geoff Levand <geoff@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Kumar Gala <galak@kernel.crashing.org>,
        Li Yang <leoyang.li@nxp.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>,
        aneesh.kumar@linux.vnet.ibm.com, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1536692743.git.christophe.leroy@c-s.fr>
 <2f980cf32a05415662272cf052c2b9e2a94c756f.1536692743.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f980cf32a05415662272cf052c2b9e2a94c756f.1536692743.git.christophe.leroy@c-s.fr>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 03:58:17PM +0000, Christophe Leroy wrote:
> _PAGE_NO_CACHE is a platform specific flag. In addition, this flag
> is misleading because one would think it requests a noncached page
> whereas a noncached page is _PAGE_NO_CACHE | _PAGE_GUARDED
> 
> _PAGE_NO_CACHE alone means write combined noncached page, so lets
> use ioremap_wc() instead.
> 
> _PAGE_WRITETHRU is also platform specific flag. Use ioremap_wt()
> instead.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

I wondered why this all showed up in my gfx inbox, then spotted this patch
here.

I trust you way more on the _PAGE_ flags than me, but this looks
reasonable.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/video/fbdev/chipsfb.c    |  3 +--
>  drivers/video/fbdev/controlfb.c  |  5 +----
>  drivers/video/fbdev/platinumfb.c |  5 +----
>  drivers/video/fbdev/valkyriefb.c | 12 ++++++------
>  4 files changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/video/fbdev/chipsfb.c b/drivers/video/fbdev/chipsfb.c
> index f103665cad43..40182ed85648 100644
> --- a/drivers/video/fbdev/chipsfb.c
> +++ b/drivers/video/fbdev/chipsfb.c
> @@ -27,7 +27,6 @@
>  #include <linux/init.h>
>  #include <linux/pci.h>
>  #include <linux/console.h>
> -#include <asm/io.h>
>  
>  #ifdef CONFIG_PMAC_BACKLIGHT
>  #include <asm/backlight.h>
> @@ -401,7 +400,7 @@ static int chipsfb_pci_init(struct pci_dev *dp, const struct pci_device_id *ent)
>  #endif /* CONFIG_PMAC_BACKLIGHT */
>  
>  #ifdef CONFIG_PPC
> -	p->screen_base = __ioremap(addr, 0x200000, _PAGE_NO_CACHE);
> +	p->screen_base = ioremap_wc(addr, 0x200000);
>  #else
>  	p->screen_base = ioremap(addr, 0x200000);
>  #endif
> diff --git a/drivers/video/fbdev/controlfb.c b/drivers/video/fbdev/controlfb.c
> index 8d14b29aafea..9cb0ef7ac29e 100644
> --- a/drivers/video/fbdev/controlfb.c
> +++ b/drivers/video/fbdev/controlfb.c
> @@ -48,9 +48,7 @@
>  #include <linux/nvram.h>
>  #include <linux/adb.h>
>  #include <linux/cuda.h>
> -#include <asm/io.h>
>  #include <asm/prom.h>
> -#include <asm/pgtable.h>
>  #include <asm/btext.h>
>  
>  #include "macmodes.h"
> @@ -715,8 +713,7 @@ static int __init control_of_init(struct device_node *dp)
>  		goto error_out;
>  	}
>  	/* map at most 8MB for the frame buffer */
> -	p->frame_buffer = __ioremap(p->frame_buffer_phys, 0x800000,
> -				    _PAGE_WRITETHRU);
> +	p->frame_buffer = ioremap_wt(p->frame_buffer_phys, 0x800000);
>  
>  	if (!p->control_regs_phys ||
>  	    !request_mem_region(p->control_regs_phys, p->control_regs_size,
> diff --git a/drivers/video/fbdev/platinumfb.c b/drivers/video/fbdev/platinumfb.c
> index 377d3399a3ad..bf6b7fb83cf4 100644
> --- a/drivers/video/fbdev/platinumfb.c
> +++ b/drivers/video/fbdev/platinumfb.c
> @@ -32,9 +32,7 @@
>  #include <linux/nvram.h>
>  #include <linux/of_device.h>
>  #include <linux/of_platform.h>
> -#include <asm/io.h>
>  #include <asm/prom.h>
> -#include <asm/pgtable.h>
>  
>  #include "macmodes.h"
>  #include "platinumfb.h"
> @@ -577,8 +575,7 @@ static int platinumfb_probe(struct platform_device* odev)
>  
>  	/* frame buffer - map only 4MB */
>  	pinfo->frame_buffer_phys = pinfo->rsrc_fb.start;
> -	pinfo->frame_buffer = __ioremap(pinfo->rsrc_fb.start, 0x400000,
> -					_PAGE_WRITETHRU);
> +	pinfo->frame_buffer = ioremap_wt(pinfo->rsrc_fb.start, 0x400000);
>  	pinfo->base_frame_buffer = pinfo->frame_buffer;
>  
>  	/* registers */
> diff --git a/drivers/video/fbdev/valkyriefb.c b/drivers/video/fbdev/valkyriefb.c
> index 275fb98236d3..d51c3a8009cb 100644
> --- a/drivers/video/fbdev/valkyriefb.c
> +++ b/drivers/video/fbdev/valkyriefb.c
> @@ -54,13 +54,11 @@
>  #include <linux/nvram.h>
>  #include <linux/adb.h>
>  #include <linux/cuda.h>
> -#include <asm/io.h>
>  #ifdef CONFIG_MAC
>  #include <asm/macintosh.h>
>  #else
>  #include <asm/prom.h>
>  #endif
> -#include <asm/pgtable.h>
>  
>  #include "macmodes.h"
>  #include "valkyriefb.h"
> @@ -318,7 +316,7 @@ static void __init valkyrie_choose_mode(struct fb_info_valkyrie *p)
>  int __init valkyriefb_init(void)
>  {
>  	struct fb_info_valkyrie	*p;
> -	unsigned long frame_buffer_phys, cmap_regs_phys, flags;
> +	unsigned long frame_buffer_phys, cmap_regs_phys;
>  	int err;
>  	char *option = NULL;
>  
> @@ -337,7 +335,6 @@ int __init valkyriefb_init(void)
>  	/* Hardcoded addresses... welcome to 68k Macintosh country :-) */
>  	frame_buffer_phys = 0xf9000000;
>  	cmap_regs_phys = 0x50f24000;
> -	flags = IOMAP_NOCACHE_SER; /* IOMAP_WRITETHROUGH?? */
>  #else /* ppc (!CONFIG_MAC) */
>  	{
>  		struct device_node *dp;
> @@ -354,7 +351,6 @@ int __init valkyriefb_init(void)
>  
>  		frame_buffer_phys = r.start;
>  		cmap_regs_phys = r.start + 0x304000;
> -		flags = _PAGE_WRITETHRU;
>  	}
>  #endif /* ppc (!CONFIG_MAC) */
>  
> @@ -369,7 +365,11 @@ int __init valkyriefb_init(void)
>  	}
>  	p->total_vram = 0x100000;
>  	p->frame_buffer_phys = frame_buffer_phys;
> -	p->frame_buffer = __ioremap(frame_buffer_phys, p->total_vram, flags);
> +#ifdef CONFIG_MAC
> +	p->frame_buffer = ioremap_nocache(frame_buffer_phys, p->total_vram);
> +#else
> +	p->frame_buffer = ioremap_wt(frame_buffer_phys, p->total_vram);
> +#endif
>  	p->cmap_regs_phys = cmap_regs_phys;
>  	p->cmap_regs = ioremap(p->cmap_regs_phys, 0x1000);
>  	p->valkyrie_regs_phys = cmap_regs_phys+0x6000;
> -- 
> 2.13.3
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
