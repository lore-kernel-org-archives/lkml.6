Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90226C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DED02146F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="J3+uACOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731194AbfAKJUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:20:48 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37153 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfAKJUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:20:48 -0500
Received: by mail-ed1-f67.google.com with SMTP id h15so12525521edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 01:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GaqnS2LOgt+LFJt9xFrmU2vVR4iRU1kwlidEkb98jHQ=;
        b=J3+uACOsGvjKIwwNZU9v/5e9exunHsPJpRPYDg4OlMHHf/XELl6dYwNsYlGox5YTa8
         yMbxIMStMsUQrN+OyrAaM3vIDZ3TDlpKGlarvZ6Rb6jV8SGsXkCrKe5+9f6rxGOE0zrC
         M4wSFRXHs04vdaIB4+CC7tXD97hu9kx632QVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=GaqnS2LOgt+LFJt9xFrmU2vVR4iRU1kwlidEkb98jHQ=;
        b=j2fR7RfBOoId3ljNIInRUt/AoC5gZ75pZbAQeyNzNnxlu70vXjXcdL6YM1FD03nYlY
         tgDECSYxmzQcRoVehODAdgnKkoy/QIS4bOcWw9tbDF1Ic5IZxCNOWImvvhb88eGxxsqJ
         nt2dwoneusLvj9RQFwChG56vAmNtJmS7uwh6d0NF4pOhtyijms2zr6kI9Lhpt/4PSFWD
         MNUeY/Kayvw8FdDBc3VDy5EkUO3u9JeZVwsLHc8EQLlbXK8UBUPx8ymFOjIZ4qvvsd/e
         jfVs4fCOUEjmaLxc7J4tQKGqJKqc1xZZaX5kkh/+mhZlXPXrguLEHCnvCG5EZFSYxLTE
         S1/A==
X-Gm-Message-State: AJcUukclp08JM6EaNDpTRPxzz7hu6rWKZlyNj17C5oTP0Sju2GFYU14C
        iZvjxNl7EUyjGBH6lmWQcxNi2Q==
X-Google-Smtp-Source: ALg8bN4kBtaXnQRgos4KUgmDEnpC7otk8vZ64bn1MqFMnTMg4iIyt3mMD7L0TM3+lcOPEX94Yx+UEg==
X-Received: by 2002:a17:906:d507:: with SMTP id ge7-v6mr11266479ejb.78.1547198445731;
        Fri, 11 Jan 2019 01:20:45 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id m14sm3064811edc.27.2019.01.11.01.20.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 01:20:44 -0800 (PST)
Date:   Fri, 11 Jan 2019 10:20:42 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     CK Hu <ck.hu@mediatek.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Frank Wunderlich <frank-w@public-files.de>,
        David Airlie <airlied@linux.ie>,
        Alexander Ryabchenko <d3adme4t@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Re: [PATCH] drm/mediatek: Add MTK Framebuffer-Device (mt7623)
Message-ID: <20190111092042.GP21184@phenom.ffwll.local>
Mail-Followup-To: CK Hu <ck.hu@mediatek.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        David Airlie <airlied@linux.ie>,
        Alexander Ryabchenko <d3adme4t@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20190102084917.4049-1-frank-w@public-files.de>
 <20190107103640.GH21184@phenom.ffwll.local>
 <CAKMK7uEqxz4TAt_iwEC+dMWboVxCeCduyABsSwD0Ns7k=Z_UWA@mail.gmail.com>
 <trinity-0da588a3-1277-4421-ad6b-1f6aeb129dd6-1547146897687@3c-app-gmx-bs35>
 <20190110200225.GN21184@phenom.ffwll.local>
 <1547176809.12054.11.camel@mtksdaap41>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547176809.12054.11.camel@mtksdaap41>
X-Operating-System: Linux phenom 4.18.0-2-amd64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 11:20:09AM +0800, CK Hu wrote:
> Hi, Daniel:
> 
> On Thu, 2019-01-10 at 21:02 +0100, Daniel Vetter wrote:
> > On Thu, Jan 10, 2019 at 08:01:37PM +0100, Frank Wunderlich wrote:
> > > Hi Daniel,
> > > 
> > > > > Would be good to use the new generic fbdev emulation code here, for even
> > > > > less code. Or at least know why this isn't possible to use for mtk (and
> > > > > maybe address that in the core code). Hand-rolling fbdev code shouldn't be
> > > > > needed anymore.
> > > > 
> > > > Back on the mailing list, no private replies please:
> > > 
> > > i don't wanted to spam all people with dumb questions ;)
> > 
> > There's no dumb questions, only insufficient documentation :-)
> > 
> > > > For examples please grep for drm_fbdev_generic_setup(). There's also a
> > > > still in-flight series from Gerd Hoffmann to convert over bochs. That,
> > > > plus all the kerneldoc linked from there should get you started.
> > > > -Daniel
> > > 
> > > this is one of google best founds if i search for drm_fbdev_generic_setup:
> > > 
> > > https://lkml.org/lkml/2018/12/19/305
> > > 
> > > not very helpful...
> > > 
> > > so i tried kernel-doc
> > > 
> > > https://www.kernel.org/doc/html/latest/gpu/drm-kms-helpers.html?highlight=drm_fbdev_generic_setup#c.drm_fbdev_generic_setup
> > > 
> > > which is nice function-reference but i've found no generic workflow
> > > 
> > > as the posted driver is "only" a driver ported from kernel 4.4 by Alexander, i don't know if this new framework can be used and which parts need to be changed. I only try to bring his code Mainline....
> > > Maybe CK Hu can help here because driver is originally from him and he knows internals. Or maybe you can help here?
> > > 
> > > i personally make my first steps as spare-time kernel-developer :)
> > 
> > There's a ton of in-kernel users of that function already, I meant you can
> > use those to serve as examples ... If those + the kerneldoc aren't
> > good enough, then we need to improve them.
> > -Daniel
> 
> I've tried with drm_fbdev_generic_setup() and it works fine with simple
> modification. The patch is
> 
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -16,6 +16,7 @@
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_crtc_helper.h>
> +#include <drm/drm_fb_helper.h>
>  #include <drm/drm_gem.h>
>  #include <drm/drm_gem_cma_helper.h>
>  #include <drm/drm_of.h>
> @@ -379,6 +380,7 @@ static void mtk_drm_kms_deinit(struct drm_device
> *drm)
>         .gem_prime_get_sg_table = mtk_gem_prime_get_sg_table,
>         .gem_prime_import_sg_table = mtk_gem_prime_import_sg_table,
>         .gem_prime_mmap = mtk_drm_gem_mmap_buf,
> +       .gem_prime_vmap = mtk_drm_gem_prime_vmap,
>         .ioctls = mtk_ioctls,
>         .num_ioctls = ARRAY_SIZE(mtk_ioctls),
>         .fops = &mtk_drm_fops,
> @@ -416,6 +418,8 @@ static int mtk_drm_bind(struct device *dev)
>         if (ret < 0)
>                 goto err_deinit;
> 
> +       drm_fbdev_generic_setup(drm, 32);
> +
>         return 0;
> 
> 
> But I implement .gem_prime_vmap with a workaround,
> 
> 
> --- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> @@ -280,3 +280,8 @@ int mtk_gem_create_ioctl(struct drm_device *dev,
> void *data,
>         mtk_drm_gem_free_object(&mtk_gem->base);
>         return ret;
>  }
> +
> +void *mtk_drm_gem_prime_vmap(struct drm_gem_object *obj)
> +{
> +       return (void *)1;
> +}
> 
> Current drm_fb_helper depends on drm_client to create fbdev. When
> drm_client create drm_client_buffer, it need to vmap to get kernel
> vaddr. But I think for fbdev, the vaddr is useless. Do you agree that I
> temporarily implement .gem_prime_vmap in such way?

The vmap is used by fbcon, without that fbdev won't really work I think.
So I'm rather confused on what you tested ...

Adding Noralf, he's the expert here.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
