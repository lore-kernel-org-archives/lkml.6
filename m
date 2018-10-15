Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12218C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969432064E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Sz4PGOw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969432064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeJOPov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 11:44:51 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45232 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbeJOPou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 11:44:50 -0400
Received: by mail-ed1-f65.google.com with SMTP id v18-v6so16901821edq.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 01:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XZYQIu5KjBiYApMiSsuPuMTLKZpS99gpw0CkoqA95eg=;
        b=Sz4PGOw/aoB+adXZXEf7MOPH+7RtvLNAkkMrDFDAGx+KexQDuWYgktprbPn8vm4NkW
         7/ngp0dW9dkeqhfXBik74IpMsaTUslwk/w4Tb4WjleZKs7OIkChb3poqfRCHLqI9P/rY
         5QFjj1xuJRCzC0H6WON3LrCTiJa6eWu94xk44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=XZYQIu5KjBiYApMiSsuPuMTLKZpS99gpw0CkoqA95eg=;
        b=taYf0VV0eRW/GbLsEefcFn5Ocl+t5OE0g2tFRgDme6vTNkDMEq04YKD5gv/Sez4Eks
         RuvqkFE/me31D4R0iNlt2P2cwoXxcHTn7FJMNBV15FBTGOKRXKVMpX6j3+p185DmdZ5Y
         ufLVFfTm7MayWMPvE1D+OSSFdhloYS7f+FZkfyOp3EKmSxIjZT2OZ1ypFK5FnQb91aIr
         38T2N7YoGg+CULr9IX5y42tuVEMJ1+UsY1zJP7pPAcDOK9eXBl9b+VkU0OlQ3CuZULmY
         FhNmJW+DFWtcUAkAPvW31pnlf5vkIkcoXcYWxwtmSWAbFt0+gHhJt63SOhLkadTOCJNR
         QBhg==
X-Gm-Message-State: ABuFfogXcC1mzo7kwoUEiP84L1NuXD+fiP4KyCvl4NTHEzI5MkYTHcAL
        5s55509gXe9U55III6JLjpCnFg==
X-Google-Smtp-Source: ACcGV63zIkgTn0bTVk3sgiNlU9CI/3O87oa+dPIsl33hYfb5WiIzUoOeSJP7CXT6MPuQ4lspGpokfg==
X-Received: by 2002:a05:6402:6d8:: with SMTP id n24mr21887071edy.99.1539590440479;
        Mon, 15 Oct 2018 01:00:40 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id m14-v6sm3276832edr.19.2018.10.15.01.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 01:00:35 -0700 (PDT)
Date:   Mon, 15 Oct 2018 10:00:33 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sti: clean up after drm_atomic_helper_shutdown rework
Message-ID: <20181015080033.GQ31561@phenom.ffwll.local>
Mail-Followup-To: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20181012094639.1585-1-benjamin.gaignard@linaro.org>
 <20181012094639.1585-2-benjamin.gaignard@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012094639.1585-2-benjamin.gaignard@linaro.org>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 11:46:39AM +0200, Benjamin Gaignard wrote:
> Since drm_atomic_helper_shutdown() rework it is possible to do additional
> clean up in sti driver: custom plane destroy functions become useless and
> clean up encoder is no more needed.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> ---
>  drivers/gpu/drm/sti/sti_cursor.c |  9 +--------
>  drivers/gpu/drm/sti/sti_gdp.c    |  9 +--------
>  drivers/gpu/drm/sti/sti_hqvdp.c  |  9 +--------
>  drivers/gpu/drm/sti/sti_tvout.c  | 24 ------------------------
>  4 files changed, 3 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sti/sti_cursor.c b/drivers/gpu/drm/sti/sti_cursor.c
> index bc908453ffb3..e1ba253055c7 100644
> --- a/drivers/gpu/drm/sti/sti_cursor.c
> +++ b/drivers/gpu/drm/sti/sti_cursor.c
> @@ -328,13 +328,6 @@ static const struct drm_plane_helper_funcs sti_cursor_helpers_funcs = {
>  	.atomic_disable = sti_cursor_atomic_disable,
>  };
>  
> -static void sti_cursor_destroy(struct drm_plane *drm_plane)
> -{
> -	DRM_DEBUG_DRIVER("\n");
> -
> -	drm_plane_cleanup(drm_plane);
> -}
> -
>  static int sti_cursor_late_register(struct drm_plane *drm_plane)
>  {
>  	struct sti_plane *plane = to_sti_plane(drm_plane);
> @@ -346,7 +339,7 @@ static int sti_cursor_late_register(struct drm_plane *drm_plane)
>  static const struct drm_plane_funcs sti_cursor_plane_helpers_funcs = {
>  	.update_plane = drm_atomic_helper_update_plane,
>  	.disable_plane = drm_atomic_helper_disable_plane,
> -	.destroy = sti_cursor_destroy,
> +	.destroy = drm_plane_cleanup,
>  	.reset = sti_plane_reset,
>  	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
> diff --git a/drivers/gpu/drm/sti/sti_gdp.c b/drivers/gpu/drm/sti/sti_gdp.c
> index 3c19614d3f75..87b50451afd7 100644
> --- a/drivers/gpu/drm/sti/sti_gdp.c
> +++ b/drivers/gpu/drm/sti/sti_gdp.c
> @@ -879,13 +879,6 @@ static const struct drm_plane_helper_funcs sti_gdp_helpers_funcs = {
>  	.atomic_disable = sti_gdp_atomic_disable,
>  };
>  
> -static void sti_gdp_destroy(struct drm_plane *drm_plane)
> -{
> -	DRM_DEBUG_DRIVER("\n");
> -
> -	drm_plane_cleanup(drm_plane);
> -}
> -
>  static int sti_gdp_late_register(struct drm_plane *drm_plane)
>  {
>  	struct sti_plane *plane = to_sti_plane(drm_plane);
> @@ -897,7 +890,7 @@ static int sti_gdp_late_register(struct drm_plane *drm_plane)
>  static const struct drm_plane_funcs sti_gdp_plane_helpers_funcs = {
>  	.update_plane = drm_atomic_helper_update_plane,
>  	.disable_plane = drm_atomic_helper_disable_plane,
> -	.destroy = sti_gdp_destroy,
> +	.destroy = drm_plane_cleanup,
>  	.reset = sti_plane_reset,
>  	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
> diff --git a/drivers/gpu/drm/sti/sti_hqvdp.c b/drivers/gpu/drm/sti/sti_hqvdp.c
> index 23565f52dd71..065a5b08a702 100644
> --- a/drivers/gpu/drm/sti/sti_hqvdp.c
> +++ b/drivers/gpu/drm/sti/sti_hqvdp.c
> @@ -1256,13 +1256,6 @@ static const struct drm_plane_helper_funcs sti_hqvdp_helpers_funcs = {
>  	.atomic_disable = sti_hqvdp_atomic_disable,
>  };
>  
> -static void sti_hqvdp_destroy(struct drm_plane *drm_plane)
> -{
> -	DRM_DEBUG_DRIVER("\n");
> -
> -	drm_plane_cleanup(drm_plane);
> -}
> -
>  static int sti_hqvdp_late_register(struct drm_plane *drm_plane)
>  {
>  	struct sti_plane *plane = to_sti_plane(drm_plane);
> @@ -1274,7 +1267,7 @@ static int sti_hqvdp_late_register(struct drm_plane *drm_plane)
>  static const struct drm_plane_funcs sti_hqvdp_plane_helpers_funcs = {
>  	.update_plane = drm_atomic_helper_update_plane,
>  	.disable_plane = drm_atomic_helper_disable_plane,
> -	.destroy = sti_hqvdp_destroy,
> +	.destroy = drm_plane_cleanup,
>  	.reset = sti_plane_reset,
>  	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
> diff --git a/drivers/gpu/drm/sti/sti_tvout.c b/drivers/gpu/drm/sti/sti_tvout.c
> index ea4a3b87fa55..4dc3b2ec40eb 100644
> --- a/drivers/gpu/drm/sti/sti_tvout.c
> +++ b/drivers/gpu/drm/sti/sti_tvout.c
> @@ -788,21 +788,6 @@ static void sti_tvout_create_encoders(struct drm_device *dev,
>  	tvout->dvo = sti_tvout_create_dvo_encoder(dev, tvout);
>  }
>  
> -static void sti_tvout_destroy_encoders(struct sti_tvout *tvout)
> -{
> -	if (tvout->hdmi)
> -		drm_encoder_cleanup(tvout->hdmi);
> -	tvout->hdmi = NULL;
> -
> -	if (tvout->hda)
> -		drm_encoder_cleanup(tvout->hda);
> -	tvout->hda = NULL;
> -
> -	if (tvout->dvo)
> -		drm_encoder_cleanup(tvout->dvo);
> -	tvout->dvo = NULL;
> -}
> -
>  static int sti_tvout_bind(struct device *dev, struct device *master, void *data)
>  {
>  	struct sti_tvout *tvout = dev_get_drvdata(dev);
> @@ -815,17 +800,8 @@ static int sti_tvout_bind(struct device *dev, struct device *master, void *data)
>  	return 0;
>  }
>  
> -static void sti_tvout_unbind(struct device *dev, struct device *master,
> -	void *data)
> -{
> -	struct sti_tvout *tvout = dev_get_drvdata(dev);
> -
> -	sti_tvout_destroy_encoders(tvout);
> -}
> -
>  static const struct component_ops sti_tvout_ops = {
>  	.bind	= sti_tvout_bind,
> -	.unbind	= sti_tvout_unbind,

Hm, this here looks strange now. I'd put a comment somewhere that
master_ops->unbind cleans up everything. Either way:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

>  };
>  
>  static int sti_tvout_probe(struct platform_device *pdev)
> -- 
> 2.15.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
