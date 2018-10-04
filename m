Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A502C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148C32098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 148C32098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeJDR1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 13:27:17 -0400
Received: from mga12.intel.com ([192.55.52.136]:27883 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727030AbeJDR1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 13:27:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2018 03:34:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,338,1534834800"; 
   d="scan'208";a="79810624"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga006.jf.intel.com with SMTP; 04 Oct 2018 03:34:23 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 04 Oct 2018 13:34:22 +0300
Date:   Thu, 4 Oct 2018 13:34:22 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v2] drm: fb-helper: Reject all pixel format changing
 requests
Message-ID: <20181004103422.GL9144@intel.com>
References: <20181003164538.5534-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181003164538.5534-1-Eugeniy.Paltsev@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 07:45:38PM +0300, Eugeniy Paltsev wrote:
> drm fbdev emulation doesn't support changing the pixel format at all,
> so reject all pixel format changing requests.
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

Could have shortened a bit with memcmp() but this works too.

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

I suppose we really should be doing the same for most of the rest of
var_screeninfo as we don't allow changing the timings/etc. either.

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
Ville Syrjälä
Intel
