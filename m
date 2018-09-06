Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCBAC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0DB20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="d+C4jD/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0DB20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbeIFMGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:06:46 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37883 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeIFMGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:06:46 -0400
Received: by mail-ed1-f68.google.com with SMTP id a20-v6so8083929edd.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 00:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FNrlx7YGS0abSGmRRPluerfry9KZrzugJ+6tFq8LAcA=;
        b=d+C4jD/3Op1SU7MKU2wuRkN37Exq31onwyc4w/TDL2dJxcoIr+bRSklDWBuxU2U5Ed
         gW25dggsTEuXBvasT+NSGs1A8aoZEyp+fC1D7+5y7SLzq7y0VGXWd+M0v0illP+DMA8O
         GWVOzWWQCbOlPLCsUJZ1HHjtlL0QiqrsnlZFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=FNrlx7YGS0abSGmRRPluerfry9KZrzugJ+6tFq8LAcA=;
        b=SlKFjvfTs7MhtZtJpVK245n90GKeiVTwF5M1XQ8vm+nWV5qjdW3i1s8Xucv1fd3b9x
         NAfGpPPfZV60lmHu9RpMnA/wtx1bW5Zf6XmRVP76+5acjC4kXylIwRFthtwesudVIrai
         9ceRqEvbftCx7e2qUsSvp8vJ8cgZgrGlTH49mlb5HdJOgmREoQDVACqMmf9UNeujsaVB
         lxK5B4APv6fRYur2viVEKKxnfrcgJjyAy/1P+Uvs0c60MzN8OYyPZ/8tRjbZ7f7FhB05
         dl7U9aQqYF8RJRDT28vMJJ7VUsQ72uu7ZBk8+0ti/oR+bGbHlW7WuytSJ+lDkmBSEu/2
         M4CA==
X-Gm-Message-State: APzg51A01/yYv7nukbsPr8TgfMjK9RMgUXP1Qqb/jvQ0yfpcttNR6DBM
        3Lt2Ypygh8Fqmecys1SDGIs1Xw==
X-Google-Smtp-Source: ANB0Vdbn/SuuFZcg+W5tkLNYppPA/9MAcQrv7e6XWX5y0RX4JuyUKRuvqvLJLP+Rcj6f11LYjwdxWw==
X-Received: by 2002:a50:aa83:: with SMTP id q3-v6mr2167908edc.64.1536219159513;
        Thu, 06 Sep 2018 00:32:39 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id f6-v6sm2961639ede.75.2018.09.06.00.32.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 00:32:38 -0700 (PDT)
Date:   Thu, 6 Sep 2018 09:32:36 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH] drm: refuse ADDFB2 ioctl for broken bigendian drivers
Message-ID: <20180906073236.GL4929@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Sean Paul <sean@poorly.run>
References: <20180906072850.11150-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906072850.11150-1-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.17.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 09:28:50AM +0200, Gerd Hoffmann wrote:
> Drivers must set the quirk_addfb_prefer_host_byte_order quirk to make
> the drm_mode_addfb() compat code work correctly on bigendian machines.
> 
> If they don't they interpret pixel_format values incorrectly for bug
> compatibility, which in turn implies the ADDFB2 ioctl does not work
> correctly then.  So block it to make userspace fallback to ADDFB.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/drm_ioctl.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index ea10e9a26a..08e48bda23 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -469,6 +469,29 @@ static int drm_copy_field(char __user *buf, size_t *buf_len, const char *value)
>  	return 0;
>  }
>  
> +static int drm_mode_addfb2_check(struct drm_device *dev,
> +				 void *data, struct drm_file *file_priv)
> +{
> +#ifdef __BIG_ENDIAN
> +	if (!dev->mode_config.quirk_addfb_prefer_host_byte_order) {
> +		/*
> +		 * Drivers must set the
> +		 * quirk_addfb_prefer_host_byte_order quirk to make
> +		 * the drm_mode_addfb() compat code work correctly on
> +		 * bigendian machines.
> +		 *
> +		 * If they don't they interpret pixel_format values
> +		 * incorrectly for bug compatibility, which in turn
> +		 * implies the ADDFB2 ioctl does not work correctly
> +		 * then.  So block it to make userspace fallback to
> +		 * ADDFB.
> +		 */

DRM_DEBUG_KMS would be good here I think, just to help userspace people
figure out why they got an -EINVAL.

> +		return -EINVAL;
> +	}
> +#endif
> +	return drm_mode_addfb2(dev, data, file_priv);

I think it'd be better if we have all the addfb code in drm_framebuffer.c.
So leave the function name, and extract the common code into
__drm_mode_addfb2 helper.

With these two nits addressed:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> +}
> +
>  /*
>   * Get version information
>   *
> @@ -645,7 +668,7 @@ static const struct drm_ioctl_desc drm_ioctls[] = {
>  	DRM_IOCTL_DEF(DRM_IOCTL_MODE_GETPROPBLOB, drm_mode_getblob_ioctl, DRM_UNLOCKED),
>  	DRM_IOCTL_DEF(DRM_IOCTL_MODE_GETFB, drm_mode_getfb, DRM_UNLOCKED),
>  	DRM_IOCTL_DEF(DRM_IOCTL_MODE_ADDFB, drm_mode_addfb_ioctl, DRM_UNLOCKED),
> -	DRM_IOCTL_DEF(DRM_IOCTL_MODE_ADDFB2, drm_mode_addfb2, DRM_UNLOCKED),
> +	DRM_IOCTL_DEF(DRM_IOCTL_MODE_ADDFB2, drm_mode_addfb2_check, DRM_UNLOCKED),
>  	DRM_IOCTL_DEF(DRM_IOCTL_MODE_RMFB, drm_mode_rmfb_ioctl, DRM_UNLOCKED),
>  	DRM_IOCTL_DEF(DRM_IOCTL_MODE_PAGE_FLIP, drm_mode_page_flip_ioctl, DRM_MASTER|DRM_UNLOCKED),
>  	DRM_IOCTL_DEF(DRM_IOCTL_MODE_DIRTYFB, drm_mode_dirtyfb_ioctl, DRM_MASTER|DRM_UNLOCKED),
> -- 
> 2.9.3
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
