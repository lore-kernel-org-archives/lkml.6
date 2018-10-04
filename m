Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5ECC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB1621470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="hKffz4zb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB1621470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbeJDOsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:48:19 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33567 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbeJDOsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:48:19 -0400
Received: by mail-ed1-f67.google.com with SMTP id g26-v6so7707654edp.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 00:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=59kp/jMiBlYDJHEkq+sGtZINQoDKtgRJlxx9mK8eWbc=;
        b=hKffz4zbfk98O5NGPFU1Sdh59fDLV8LiQt/iUQLCyg9Tl66Gm21suoNoYMFySQOuwn
         qzpIUe6NAA78OWzsZD+JGXzTU7LCrSMI+idwohakRRGvRYMgIO4NAcJ5GujTjefK1daz
         b6ruedjpD7S+bGZKlNpGPFlvUt7xmDG+iq2ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=59kp/jMiBlYDJHEkq+sGtZINQoDKtgRJlxx9mK8eWbc=;
        b=sovjvgroz2xgtsdWadAtfZwQXlq26gmJDUBBEYQkAL5oJL53ibzbj2BponmFosyolo
         evAvZBb0eAwkuSJZBmyMBPgw8ciLaMBgytF0BV2dKqIEIotJpnLQvt6tzz6yXdCUjww5
         IU0Bn61i+m5Bgffl7hw4bRNTyvQDaHkUPALNaKOMiaO/0P/PzmrmTvoJIcJON80BQas1
         mZql3lnK1f2oGm1iyxDwMRLd6GxpbXmT6jFz3Z9vsw2a3ixPl0eehkKoLmWzhC5sniWt
         5jzRzO0ADdiczQ/7N9/nMCDchblpGQ5qiFZ8+G/r6TpRii0+CEJEaGh60itXgUWCXN9s
         1YNA==
X-Gm-Message-State: ABuFfojS8J2bZT8Hnku6L8x8h6Hy+yIkK48jgAetaaqmj3KFLI615gnu
        w6H0touRUiO/CY/RPq/bmVni+Q==
X-Google-Smtp-Source: ACcGV63c4wilojgtork+H2VXpf3CvZOySd25VMRzfeDeSvVzei1+wcUlkCBhkYxLixTZKj16lesbmA==
X-Received: by 2002:a17:906:14c7:: with SMTP id y7-v6mr5333942ejc.184.1538639778141;
        Thu, 04 Oct 2018 00:56:18 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id m11sm1247183edv.90.2018.10.04.00.56.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 00:56:16 -0700 (PDT)
Date:   Thu, 4 Oct 2018 09:56:14 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v2] drm: fb-helper: Reject all pixel format changing
 requests
Message-ID: <20181004075614.GH31561@phenom.ffwll.local>
Mail-Followup-To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, Sean Paul <sean@poorly.run>
References: <20181003164538.5534-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003164538.5534-1-Eugeniy.Paltsev@synopsys.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 07:45:38PM +0300, Eugeniy Paltsev wrote:
> drm fbdev emulation doesn't support changing the pixel format at all,
> so reject all pixel format changing requests.

For next time around: Please keep the note here why we need this and what
the impact is. Otherwise it's not immediately clear why we should backport
this patch to all stable kernels.

I'll gather a few acks and then apply.
-Daniel
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---
> Changes v1->v2:
>  * Reject all pixel format changing request, not just the invalid ones.
> 
>  drivers/gpu/drm/drm_fb_helper.c | 91 ++++++++++++-----------------------------
>  1 file changed, 26 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index 16ec93b75dbf..48598d7f673f 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -1580,6 +1580,25 @@ int drm_fb_helper_ioctl(struct fb_info *info, unsigned int cmd,
>  }
>  EXPORT_SYMBOL(drm_fb_helper_ioctl);
>  
> +static bool drm_fb_pixel_format_equal(const struct fb_var_screeninfo *var_1,
> +				      const struct fb_var_screeninfo *var_2)
> +{
> +	return var_1->bits_per_pixel == var_2->bits_per_pixel &&
> +	       var_1->grayscale == var_2->grayscale &&
> +	       var_1->red.offset == var_2->red.offset &&
> +	       var_1->red.length == var_2->red.length &&
> +	       var_1->red.msb_right == var_2->red.msb_right &&
> +	       var_1->green.offset == var_2->green.offset &&
> +	       var_1->green.length == var_2->green.length &&
> +	       var_1->green.msb_right == var_2->green.msb_right &&
> +	       var_1->blue.offset == var_2->blue.offset &&
> +	       var_1->blue.length == var_2->blue.length &&
> +	       var_1->blue.msb_right == var_2->blue.msb_right &&
> +	       var_1->transp.offset == var_2->transp.offset &&
> +	       var_1->transp.length == var_2->transp.length &&
> +	       var_1->transp.msb_right == var_2->transp.msb_right;
> +}
> +
>  /**
>   * drm_fb_helper_check_var - implementation for &fb_ops.fb_check_var
>   * @var: screeninfo to check
> @@ -1590,7 +1609,6 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
>  {
>  	struct drm_fb_helper *fb_helper = info->par;
>  	struct drm_framebuffer *fb = fb_helper->fb;
> -	int depth;
>  
>  	if (var->pixclock != 0 || in_dbg_master())
>  		return -EINVAL;
> @@ -1610,72 +1628,15 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
>  		return -EINVAL;
>  	}
>  
> -	switch (var->bits_per_pixel) {
> -	case 16:
> -		depth = (var->green.length == 6) ? 16 : 15;
> -		break;
> -	case 32:
> -		depth = (var->transp.length > 0) ? 32 : 24;
> -		break;
> -	default:
> -		depth = var->bits_per_pixel;
> -		break;
> -	}
> -
> -	switch (depth) {
> -	case 8:
> -		var->red.offset = 0;
> -		var->green.offset = 0;
> -		var->blue.offset = 0;
> -		var->red.length = 8;
> -		var->green.length = 8;
> -		var->blue.length = 8;
> -		var->transp.length = 0;
> -		var->transp.offset = 0;
> -		break;
> -	case 15:
> -		var->red.offset = 10;
> -		var->green.offset = 5;
> -		var->blue.offset = 0;
> -		var->red.length = 5;
> -		var->green.length = 5;
> -		var->blue.length = 5;
> -		var->transp.length = 1;
> -		var->transp.offset = 15;
> -		break;
> -	case 16:
> -		var->red.offset = 11;
> -		var->green.offset = 5;
> -		var->blue.offset = 0;
> -		var->red.length = 5;
> -		var->green.length = 6;
> -		var->blue.length = 5;
> -		var->transp.length = 0;
> -		var->transp.offset = 0;
> -		break;
> -	case 24:
> -		var->red.offset = 16;
> -		var->green.offset = 8;
> -		var->blue.offset = 0;
> -		var->red.length = 8;
> -		var->green.length = 8;
> -		var->blue.length = 8;
> -		var->transp.length = 0;
> -		var->transp.offset = 0;
> -		break;
> -	case 32:
> -		var->red.offset = 16;
> -		var->green.offset = 8;
> -		var->blue.offset = 0;
> -		var->red.length = 8;
> -		var->green.length = 8;
> -		var->blue.length = 8;
> -		var->transp.length = 8;
> -		var->transp.offset = 24;
> -		break;
> -	default:
> +	/*
> +	 * drm fbdev emulation doesn't support changing the pixel format at all,
> +	 * so reject all pixel format changing requests.
> +	 */
> +	if (!drm_fb_pixel_format_equal(var, &info->var)) {
> +		DRM_DEBUG("fbdev emulation doesn't support changing the pixel format\n");
>  		return -EINVAL;
>  	}
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL(drm_fb_helper_check_var);
> -- 
> 2.14.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
