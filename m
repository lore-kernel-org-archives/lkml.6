Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902DEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CC420779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="OdGWeK5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CC420779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeICVJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:09:47 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36455 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbeICVJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:09:47 -0400
Received: by mail-ed1-f65.google.com with SMTP id f4-v6so1237498edq.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 09:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=saBzFNpvuBZnTQhI0cSL60ejRtlsZZ3JEoZhCp7ci+g=;
        b=OdGWeK5UZlJlnYetN7R0Rwh/GS1sTAHNQpzScfjmBuW4JiQ8IoKDuOqBfCTvCiDU2b
         KLJRbdSAgaWTxYnot1H3QK7kjdhIYRbydBmZ9XySYZLPgUk3oOYSTdUWq4ZzyAdPKYh5
         8h5Uj+oBcD0Ewy3EF+uwNAG9f6+MEBcDT5NMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=saBzFNpvuBZnTQhI0cSL60ejRtlsZZ3JEoZhCp7ci+g=;
        b=hyjK5wk/b+bGLPiITRcl/eQQ3PWEVaHNMWlpmwJ0qoevJ4aAKGVjrnAYzeYG816wEh
         8Qy/TxemcDNxU31lxCzVFOPU2YtfPo7hFav1CouEXV8NPHOIGtBrpCN3bT9Gw7cewWk3
         RoJebkj/vJSalPpJVDbyPMPk+hgzOJ+HxEIYQNNT8u3iyo9ei4iax44WpXfVvHnC9j1B
         NlI8Zo14gBcIl0C7p8bFxAMvvFhhmp4rPwopHrfgScISWEndH+P3vEgJXzXmY8HMoyu0
         0taKHuRb9f9m1QEreyYWipelBh9cjSaVaN50c3ofVPh/R1eEjDAWT8rEeYnT1/gOvjL/
         LuEw==
X-Gm-Message-State: APzg51CkrnNPz/RmBCasXXMfi3jw103Ozg0MXmCJCvpAjWisZSE7pLEw
        qiPBfnVrYwekjwCEKRa5k1NIXg==
X-Google-Smtp-Source: ANB0VdZzekG25oOY2KvXSJML27qfRGrV7G6AU6/j5dlYJ7VFQMtHqnI3vxHCv9CsIY2uuefZIjVrEA==
X-Received: by 2002:a50:c40e:: with SMTP id v14-v6mr32902652edf.232.1535993330671;
        Mon, 03 Sep 2018 09:48:50 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-109.fiber7.init7.net. [212.51.149.109])
        by smtp.gmail.com with ESMTPSA id m35-v6sm8081645ede.14.2018.09.03.09.48.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 09:48:49 -0700 (PDT)
Date:   Mon, 3 Sep 2018 18:48:47 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kees Cook <keescook@chromium.org>, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 3/4] fbdev: Add FBINFO_HIDE_SMEM_START flag
Message-ID: <20180903164847.GM21634@phenom.ffwll.local>
Mail-Followup-To: DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kees Cook <keescook@chromium.org>, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20180822085405.10787-1-daniel.vetter@ffwll.ch>
 <20180822085405.10787-3-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822085405.10787-3-daniel.vetter@ffwll.ch>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 10:54:04AM +0200, Daniel Vetter wrote:
> DRM drivers really, really, really don't want random userspace to
> share buffer behind it's back, bypassing the dma-buf buffer sharing
> machanism. For that reason we've ruthlessly rejected any IOCTL
> exposing the physical address of any graphics buffer.
> 
> Unfortunately fbdev comes with that built-in. We could just set
> smem_start to 0, but that means we'd have to hand-roll our own fb_mmap
> implementation. For good reasons many drivers do that, but
> smem_start/length is still super convenient.
> 
> Hence instead just stop the leak in the ioctl, to keep fb mmap working
> as-is. A second patch will set this flag for all drm drivers.
> 
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Any comments from the fbdev side on this?
-Daniel

> ---
>  drivers/video/fbdev/core/fbmem.c | 4 ++++
>  include/linux/fb.h               | 7 +++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 609438d2465b..549d0f86fcf3 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1116,6 +1116,8 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
>  		if (!lock_fb_info(info))
>  			return -ENODEV;
>  		fix = info->fix;
> +		if (info->flags & FBINFO_HIDE_SMEM_START)
> +			fix.smem_start = 0;
>  		unlock_fb_info(info);
>  
>  		ret = copy_to_user(argp, &fix, sizeof(fix)) ? -EFAULT : 0;
> @@ -1326,6 +1328,8 @@ static int fb_get_fscreeninfo(struct fb_info *info, unsigned int cmd,
>  	if (!lock_fb_info(info))
>  		return -ENODEV;
>  	fix = info->fix;
> +	if (info->flags & FBINFO_HIDE_SMEM_START)
> +		fix.smem_start = 0;
>  	unlock_fb_info(info);
>  	return do_fscreeninfo_to_user(&fix, compat_ptr(arg));
>  }
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index fa8c6f9c9c3a..f42b09ca71f8 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -456,6 +456,13 @@ struct fb_tile_ops {
>   * and host endianness. Drivers should not use this flag.
>   */
>  #define FBINFO_BE_MATH  0x100000
> +/*
> + * Hide smem_start in the FBIOGET_FSCREENINFO IOCTL. This is used by modern DRM
> + * drivers to stop userspace from trying to share buffers behind the kernel's
> + * back. Instead dma-buf based buffer sharing should be used.
> + */
> +#define FBINFO_HIDE_SMEM_START  0x200000
> +
>  
>  struct fb_info {
>  	atomic_t count;
> -- 
> 2.18.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
