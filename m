Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D2FC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010802082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="O/dy46Za"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010802082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeJDRmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 13:42:25 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36654 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbeJDRmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 13:42:25 -0400
Received: by mail-ed1-f68.google.com with SMTP id c26-v6so416050edt.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 03:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=z4jtWpePR/uAYrvgxMZ95VFZ7ATEFUvg+Ev6SoNoQHw=;
        b=O/dy46ZaURTMsQHASPLASgSzDtZCnrEnojMdEIElvGEKqXZfSFvKuwp250Ptz2GkT1
         +h5gCf/CDf643RQDRMIIS7y0swbukfe3AdFMuE6B5sdF1DnBCVFto/UlyzrKLqaLqynH
         exSAWU+lqvQr0xyapRImQQ4A653OA+9wN6V1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=z4jtWpePR/uAYrvgxMZ95VFZ7ATEFUvg+Ev6SoNoQHw=;
        b=LMMYaUDXA7FFyWKSaD7Ly1qdDJzvoNfYGyGziqdnoArgHnZaJKGNeKl3rdLf5LT5bY
         DRTU70ndW5gAIwAV2MIHM5Nq2ef1famzE2fn+QOtcv2xcKhP6+PzRbODOAioui0++pfB
         Jb540Yt+5fUyidNMA4DlUi5WFVmMsMyLvXzwLUaS436I+9/bIanagTcWDs7FukJBe8Ug
         JD+BzMkydF7AVaesm/3YDgEEb8LJUrv5xt3PRxgSbUqJ978oLh+bHGaAYKTVCgg59qmL
         QszQVp77GPrVcwOe9hjxUJFaGQ4/UTn9qXPHooff02wjBf9Gg5KPtjmc+O/qh85KJm7/
         BRGQ==
X-Gm-Message-State: ABuFfoiVRCu9O8LBxWeIM72y3cUTUybdbCSnHt5jZu3HJNSInZ4/YB8y
        jMzBw+zDsOnpK1O9FBa09vW/2w==
X-Google-Smtp-Source: ACcGV63TwUudHuKvg5LvvkPBm0dAZ21EHeghXNZnbd9mNdCBzZlJTpyYeqF2ZSRPXeFUXjHT0yffXw==
X-Received: by 2002:a50:d512:: with SMTP id u18-v6mr7906807edi.291.1538650181373;
        Thu, 04 Oct 2018 03:49:41 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id g18-v6sm1385553edg.69.2018.10.04.03.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 03:49:40 -0700 (PDT)
Date:   Thu, 4 Oct 2018 12:49:38 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        David Airlie <airlied@linux.ie>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-snps-arc@lists.infradead.org, Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v2] drm: fb-helper: Reject all pixel format changing
 requests
Message-ID: <20181004104938.GJ31561@phenom.ffwll.local>
Mail-Followup-To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        David Airlie <airlied@linux.ie>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-snps-arc@lists.infradead.org,
        Sean Paul <sean@poorly.run>
References: <20181003164538.5534-1-Eugeniy.Paltsev@synopsys.com>
 <20181004103422.GL9144@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181004103422.GL9144@intel.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 01:34:22PM +0300, Ville Syrjälä wrote:
> On Wed, Oct 03, 2018 at 07:45:38PM +0300, Eugeniy Paltsev wrote:
> > drm fbdev emulation doesn't support changing the pixel format at all,
> > so reject all pixel format changing requests.
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> > ---
> > Changes v1->v2:
> >  * Reject all pixel format changing request, not just the invalid ones.
> > 
> >  drivers/gpu/drm/drm_fb_helper.c | 91 ++++++++++++-----------------------------
> >  1 file changed, 26 insertions(+), 65 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> > index 16ec93b75dbf..48598d7f673f 100644
> > --- a/drivers/gpu/drm/drm_fb_helper.c
> > +++ b/drivers/gpu/drm/drm_fb_helper.c
> > @@ -1580,6 +1580,25 @@ int drm_fb_helper_ioctl(struct fb_info *info, unsigned int cmd,
> >  }
> >  EXPORT_SYMBOL(drm_fb_helper_ioctl);
> >  
> > +static bool drm_fb_pixel_format_equal(const struct fb_var_screeninfo *var_1,
> > +				      const struct fb_var_screeninfo *var_2)
> > +{
> > +	return var_1->bits_per_pixel == var_2->bits_per_pixel &&
> > +	       var_1->grayscale == var_2->grayscale &&
> > +	       var_1->red.offset == var_2->red.offset &&
> > +	       var_1->red.length == var_2->red.length &&
> > +	       var_1->red.msb_right == var_2->red.msb_right &&
> > +	       var_1->green.offset == var_2->green.offset &&
> > +	       var_1->green.length == var_2->green.length &&
> > +	       var_1->green.msb_right == var_2->green.msb_right &&
> > +	       var_1->blue.offset == var_2->blue.offset &&
> > +	       var_1->blue.length == var_2->blue.length &&
> > +	       var_1->blue.msb_right == var_2->blue.msb_right &&
> > +	       var_1->transp.offset == var_2->transp.offset &&
> > +	       var_1->transp.length == var_2->transp.length &&
> > +	       var_1->transp.msb_right == var_2->transp.msb_right;
> > +}
> 
> Could have shortened a bit with memcmp() but this works too.

I'm always vary of memcmp with structs that might have padding and stuff.

> Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> I suppose we really should be doing the same for most of the rest of
> var_screeninfo as we don't allow changing the timings/etc. either.

Timing at least doens't have an immediate correctness impact of userspace
rendering the wrong format :-)

Thanks for review&patch, applied to drm-misc-fixes.
-Daniel

> 
> > +
> >  /**
> >   * drm_fb_helper_check_var - implementation for &fb_ops.fb_check_var
> >   * @var: screeninfo to check
> > @@ -1590,7 +1609,6 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
> >  {
> >  	struct drm_fb_helper *fb_helper = info->par;
> >  	struct drm_framebuffer *fb = fb_helper->fb;
> > -	int depth;
> >  
> >  	if (var->pixclock != 0 || in_dbg_master())
> >  		return -EINVAL;
> > @@ -1610,72 +1628,15 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
> >  		return -EINVAL;
> >  	}
> >  
> > -	switch (var->bits_per_pixel) {
> > -	case 16:
> > -		depth = (var->green.length == 6) ? 16 : 15;
> > -		break;
> > -	case 32:
> > -		depth = (var->transp.length > 0) ? 32 : 24;
> > -		break;
> > -	default:
> > -		depth = var->bits_per_pixel;
> > -		break;
> > -	}
> > -
> > -	switch (depth) {
> > -	case 8:
> > -		var->red.offset = 0;
> > -		var->green.offset = 0;
> > -		var->blue.offset = 0;
> > -		var->red.length = 8;
> > -		var->green.length = 8;
> > -		var->blue.length = 8;
> > -		var->transp.length = 0;
> > -		var->transp.offset = 0;
> > -		break;
> > -	case 15:
> > -		var->red.offset = 10;
> > -		var->green.offset = 5;
> > -		var->blue.offset = 0;
> > -		var->red.length = 5;
> > -		var->green.length = 5;
> > -		var->blue.length = 5;
> > -		var->transp.length = 1;
> > -		var->transp.offset = 15;
> > -		break;
> > -	case 16:
> > -		var->red.offset = 11;
> > -		var->green.offset = 5;
> > -		var->blue.offset = 0;
> > -		var->red.length = 5;
> > -		var->green.length = 6;
> > -		var->blue.length = 5;
> > -		var->transp.length = 0;
> > -		var->transp.offset = 0;
> > -		break;
> > -	case 24:
> > -		var->red.offset = 16;
> > -		var->green.offset = 8;
> > -		var->blue.offset = 0;
> > -		var->red.length = 8;
> > -		var->green.length = 8;
> > -		var->blue.length = 8;
> > -		var->transp.length = 0;
> > -		var->transp.offset = 0;
> > -		break;
> > -	case 32:
> > -		var->red.offset = 16;
> > -		var->green.offset = 8;
> > -		var->blue.offset = 0;
> > -		var->red.length = 8;
> > -		var->green.length = 8;
> > -		var->blue.length = 8;
> > -		var->transp.length = 8;
> > -		var->transp.offset = 24;
> > -		break;
> > -	default:
> > +	/*
> > +	 * drm fbdev emulation doesn't support changing the pixel format at all,
> > +	 * so reject all pixel format changing requests.
> > +	 */
> > +	if (!drm_fb_pixel_format_equal(var, &info->var)) {
> > +		DRM_DEBUG("fbdev emulation doesn't support changing the pixel format\n");
> >  		return -EINVAL;
> >  	}
> > +
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL(drm_fb_helper_check_var);
> > -- 
> > 2.14.4
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> -- 
> Ville Syrjälä
> Intel
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
