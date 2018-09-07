Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F8FC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800AC20855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="R2F10+Lk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800AC20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbeIHA3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:29:30 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45557 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeIHA3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:29:30 -0400
Received: by mail-ed1-f67.google.com with SMTP id p52-v6so12284251eda.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 12:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=JesxdWZrp1dQvyHPGstha9mnSPRY2smCWTjdT81MrXw=;
        b=R2F10+LkHdlxZwHJPOxusZlUZi+RYxvBV4lOIhr8p8+Q6+SIZ44DNyeKY9mDC3KzZP
         vQhuEFvibvVelPFMosSmbO78CIxY1wDJHqFwOoHvbncUjjurn1+tLvdDZ5jvMbrMPEQl
         lUEpuRQjm7PpPW7Dzkkw/ycEzScQ7ZBFlHzNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=JesxdWZrp1dQvyHPGstha9mnSPRY2smCWTjdT81MrXw=;
        b=Y4pZHaIPcb9iKymGrt6c7wuAFtHBEVQqQQktU5aFvNUKk8mhS2A6YW+tK9aFH3cZN6
         guBiiS/g5Sk7QTgFglXDz9sUapoje9hDjchI++RrSmgWx8Bmb38CiUmV6iVQWQNK1naw
         pEHF7bb1hcwEIGwOqHhv/iB00EPxbIji3mL90hfh2S/zhRYjudbPv6+hLEoobSR0XRR1
         nvp0AC4m3opSxUx5PXDfMb8MpB6LQVuNjZikxFQXfWN7E0ais9VX+fDduRbxKu1PcVTT
         FOQ5JR/KKinxD3HhDZaINCg0SspV1R3WpCvXs3wks3t6ImQEqKiProk1A/3Wf8htDRqo
         /U8A==
X-Gm-Message-State: APzg51A/sNCEFWWQx0Wpx5WrGqaAbXp1a1oKyTpvh/ELRMXE4uTC4kAT
        dpvd6bq3suWfiWKiC9ZonW9UvA==
X-Google-Smtp-Source: ANB0VdYu29TIXV3fNzROmBb/rDswJIddPBYG82TbEaUk5dXANFh0EICMgOIwT1c78ZRl+SAPpqE9Aw==
X-Received: by 2002:a50:8c45:: with SMTP id p63-v6mr10792581edp.84.1536349622049;
        Fri, 07 Sep 2018 12:47:02 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id s36-v6sm5348406edb.56.2018.09.07.12.47.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 12:47:01 -0700 (PDT)
Date:   Fri, 7 Sep 2018 21:46:59 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Peter Wu <peter@lekensteyn.nl>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 4/4] drm/fb-helper: improve documentation and print
 warnings
Message-ID: <20180907194659.GC7176@phenom.ffwll.local>
Mail-Followup-To: Peter Wu <peter@lekensteyn.nl>,
        Gerd Hoffmann <kraxel@redhat.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20180906221810.20170-1-peter@lekensteyn.nl>
 <20180906221810.20170-5-peter@lekensteyn.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180906221810.20170-5-peter@lekensteyn.nl>
X-Operating-System: Linux phenom 4.17.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 12:18:10AM +0200, Peter Wu wrote:
> Clarify the relation between drm_fb_helper_fbdev_setup/teardown. Clarify
> requirements for the new generic fbdev emulation API and log some more
> details in case the driver does something wrong. Fix related typos.
> 
> Cc: Noralf Trønnes <noralf@tronnes.org>
> Signed-off-by: Peter Wu <peter@lekensteyn.nl>
> ---
>  drivers/gpu/drm/drm_fb_helper.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index 4b0dd20bccb8..7f92ff173986 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -2821,7 +2821,9 @@ EXPORT_SYMBOL(drm_fb_helper_hotplug_event);
>   * The caller must to provide a &drm_fb_helper_funcs->fb_probe callback
>   * function.
>   *
> - * See also: drm_fb_helper_initial_config()
> + * Use drm_fb_helper_fbdev_teardown() to destroy the fbdev.
> + *
> + * See also: drm_fb_helper_initial_config(), drm_fbdev_generic_setup().
>   *
>   * Returns:
>   * Zero on success or negative error code on failure.
> @@ -3037,7 +3039,7 @@ static struct fb_deferred_io drm_fbdev_defio = {
>   * @fb_helper: fbdev helper structure
>   * @sizes: describes fbdev size and scanout surface size
>   *
> - * This function uses the client API to crate a framebuffer backed by a dumb buffer.
> + * This function uses the client API to create a framebuffer backed by a dumb buffer.
>   *
>   * The _sys_ versions are used for &fb_ops.fb_read, fb_write, fb_fillrect,
>   * fb_copyarea, fb_imageblit.
> @@ -3165,8 +3167,10 @@ static int drm_fbdev_client_hotplug(struct drm_client_dev *client)
>  	if (dev->fb_helper)
>  		return drm_fb_helper_hotplug_event(dev->fb_helper);
>  
> -	if (!dev->mode_config.num_connector)
> +	if (!dev->mode_config.num_connector) {
> +		DRM_DEV_DEBUG(dev->dev, "No connectors found, will not create framebuffer!\n");
>  		return 0;
> +	}
>  
>  	ret = drm_fb_helper_fbdev_setup(dev, fb_helper, &drm_fb_helper_generic_funcs,
>  					fb_helper->preferred_bpp, 0);
> @@ -3187,13 +3191,15 @@ static const struct drm_client_funcs drm_fbdev_client_funcs = {
>  };
>  
>  /**
> - * drm_fb_helper_generic_fbdev_setup() - Setup generic fbdev emulation
> + * drm_fbdev_generic_setup() - Setup generic fbdev emulation

Hm, drm_fb_helper_ would be the OCD prefix we use everywhere, but better
to make the docs match the code. Feel free to throw a rename patch on top.

>   * @dev: DRM device
>   * @preferred_bpp: Preferred bits per pixel for the device.
>   *                 @dev->mode_config.preferred_depth is used if this is zero.
>   *
>   * This function sets up generic fbdev emulation for drivers that supports
> - * dumb buffers with a virtual address and that can be mmap'ed.
> + * dumb buffers with a virtual address and that can be mmap'ed. If the driver
> + * does not support these functions, it could use drm_fb_helper_fbdev_setup().
> + * This function can only be used with devices created using drm_dev_register().

This last line is misleading, since every drm device is called with
drm_dev_register(). It's just not all called by driver code directly.
With this line removed:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

I'll leave it to Gerd to apply this all.
-Daniel


>   *
>   * Restore, hotplug events and teardown are all taken care of. Drivers that do
>   * suspend/resume need to call drm_fb_helper_set_suspend_unlocked() themselves.
> @@ -3206,6 +3212,8 @@ static const struct drm_client_funcs drm_fbdev_client_funcs = {
>   * This function is safe to call even when there are no connectors present.
>   * Setup will be retried on the next hotplug event.
>   *
> + * The fbdev is destroyed by drm_dev_unregister().
> + *
>   * Returns:
>   * Zero on success or negative error code on failure.
>   */
> @@ -3214,6 +3222,8 @@ int drm_fbdev_generic_setup(struct drm_device *dev, unsigned int preferred_bpp)
>  	struct drm_fb_helper *fb_helper;
>  	int ret;
>  
> +	WARN(dev->fb_helper, "fb_helper is already set!\n");
> +
>  	if (!drm_fbdev_emulation)
>  		return 0;
>  
> @@ -3224,12 +3234,15 @@ int drm_fbdev_generic_setup(struct drm_device *dev, unsigned int preferred_bpp)
>  	ret = drm_client_new(dev, &fb_helper->client, "fbdev", &drm_fbdev_client_funcs);
>  	if (ret) {
>  		kfree(fb_helper);
> +		DRM_DEV_ERROR(dev->dev, "Failed to register client: %d\n", ret);
>  		return ret;
>  	}
>  
>  	fb_helper->preferred_bpp = preferred_bpp;
>  
> -	drm_fbdev_client_hotplug(&fb_helper->client);
> +	ret = drm_fbdev_client_hotplug(&fb_helper->client);
> +	if (ret)
> +		DRM_DEV_DEBUG(dev->dev, "client hotplug ret=%d\n", ret);
>  
>  	return 0;
>  }
> -- 
> 2.18.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
