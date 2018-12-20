Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2F5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8051221741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeSreWHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731788AbeLTMOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:14:32 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44809 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbeLTMOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:14:30 -0500
Received: by mail-lj1-f195.google.com with SMTP id k19-v6so1324770lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 04:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ykPQgd+D8oV9K7tP/NcA/KVCltx/mFL7ha6/pueegv8=;
        b=ZeSreWHNuOd/8BzwWqmsC26IQzsJ8nu2I8fyzIWWl/5n9SHkbyiWney1TaI8UF1ej/
         mokJ8pbNuVb5DF8Ka6op8VnyXPeLw6w+eHW/pllJQic2lYxlrzgr53TOFnFdeqgvUggo
         yCoXawR3HFsDPwyTa1y3rVzbEpPXhLt3sluBPR1BQqCAHhQ3spMrzxnR+P5OaXQ+QOPm
         nvS76fo9jKcl/zFycOf2kVY35O/Yc8BrHqgQg4M/6o5ywnOtug1UnnpmOR/iN4qypZ59
         tuKPr2YSBgT+vg/QYWYLhHEMEk3LnVqfX714lp6iMUjE7VHmbB+ikQIlMoKfeqihpG29
         mBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ykPQgd+D8oV9K7tP/NcA/KVCltx/mFL7ha6/pueegv8=;
        b=TjpivzHs7CdvKcFMkHz3Oy89/A1h+w7DaRgtJQQn7YxoAQbgAvI+obYDdr8D7jbLCn
         9T5H/QQh4ClByzvezAis2q5Y7iQHNpl/x9sHkD+rNMhC7dyT8wjQZOPedZ3pwnVtRuqH
         Ik3/qYw266e+BlouwA+Siq2/Iq/rGMotqHoL1DeygkcffQf0kqlUT2eqadGz2HFqqsrj
         6ij4fkNmVlbQYMbc4QRgh3Z1YZWoUw+7LL6uTwVNG70HMn0AP9ZUgUDgkkLJG+BjTNrb
         syl19Z7Elru6jDg016Mbhr5hl+SPIyvVVw8bTC8xy9US+cpkvIJ8T44uOIa01NmcJSmN
         SXwA==
X-Gm-Message-State: AA+aEWZ2iGyND+GQjgWlDi2GnmyGgZG7ahCZVxEUfA0dMq8HYnSgfe9X
        AD58L699VVjXxdg7I7aGKhE=
X-Google-Smtp-Source: AFSGD/XFRHf5mGyo1UXx/x78K+PI4EWcEzZFop3nfuSpiBUMQoITdp8uyjBSavhR6P2eE9brswzYWg==
X-Received: by 2002:a2e:a202:: with SMTP id h2-v6mr14878874ljm.72.1545308068073;
        Thu, 20 Dec 2018 04:14:28 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id s24sm4178942lfc.30.2018.12.20.04.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 04:14:27 -0800 (PST)
Subject: Re: [PATCH 05/14] drm/bochs: atomic: switch planes to atomic, wire up
 helpers.
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@redhat.com>
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
References: <20181219115127.31359-1-kraxel@redhat.com>
 <20181219115127.31359-6-kraxel@redhat.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <277f1e16-aa7b-b741-4ceb-3dea0f776a60@gmail.com>
Date:   Thu, 20 Dec 2018 14:14:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181219115127.31359-6-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/18 1:51 PM, Gerd Hoffmann wrote:
> Conversion to atomic modesetting, step three.
> Wire up atomic helpers.  Switch planes to atomic.
>
> We are late to the party, the transitional helpers are gone,
> so this can't be splitted into smaller steps any more.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   drivers/gpu/drm/bochs/bochs_fbdev.c |  3 ++
>   drivers/gpu/drm/bochs/bochs_kms.c   | 70 +++++++++++++++++++++++++++++++++++--
>   2 files changed, 70 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/bochs/bochs_fbdev.c b/drivers/gpu/drm/bochs/bochs_fbdev.c
> index dd3c7df267..d9f3d42999 100644
> --- a/drivers/gpu/drm/bochs/bochs_fbdev.c
> +++ b/drivers/gpu/drm/bochs/bochs_fbdev.c
> @@ -6,6 +6,7 @@
>    */
>   
>   #include "bochs.h"
> +#include <drm/drm_atomic_helper.h>
>   #include <drm/drm_gem_framebuffer_helper.h>
>   
>   /* ---------------------------------------------------------------------- */
> @@ -149,6 +150,8 @@ bochs_gem_fb_create(struct drm_device *dev, struct drm_file *file,
>   
>   const struct drm_mode_config_funcs bochs_mode_funcs = {
>   	.fb_create = bochs_gem_fb_create,
> +	.atomic_check = drm_atomic_helper_check,
> +	.atomic_commit = drm_atomic_helper_commit,
>   };
>   
>   int bochs_fbdev_init(struct bochs_device *bochs)
> diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
> index 18b705fb0b..aa3ba0377a 100644
> --- a/drivers/gpu/drm/bochs/bochs_kms.c
> +++ b/drivers/gpu/drm/bochs/bochs_kms.c
> @@ -6,7 +6,9 @@
>    */
>   
>   #include "bochs.h"
> +#include <drm/drm_atomic_helper.h>
>   #include <drm/drm_plane_helper.h>
> +#include <drm/drm_atomic_uapi.h>
>   
>   static int defx = 1024;
>   static int defy = 768;
> @@ -113,7 +115,7 @@ static int bochs_crtc_page_flip(struct drm_crtc *crtc,
>   	struct drm_framebuffer *old_fb = crtc->primary->fb;
>   	unsigned long irqflags;
>   
> -	crtc->primary->fb = fb;
> +	drm_atomic_set_fb_for_plane(crtc->primary->state, fb);
Taking into account that crtc->primary access goes away in the series:
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>   	bochs_crtc_mode_set_base(crtc, 0, 0, old_fb);
>   	if (event) {
>   		spin_lock_irqsave(&bochs->dev->event_lock, irqflags);
> @@ -151,6 +153,9 @@ static const struct drm_crtc_funcs bochs_crtc_funcs = {
>   	.set_config = drm_crtc_helper_set_config,
>   	.destroy = drm_crtc_cleanup,
>   	.page_flip = bochs_crtc_page_flip,
> +	.reset = drm_atomic_helper_crtc_reset,
> +	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
>   };
>   
>   static const struct drm_crtc_helper_funcs bochs_helper_funcs = {
> @@ -169,6 +174,59 @@ static const uint32_t bochs_formats[] = {
>   	DRM_FORMAT_BGRX8888,
>   };
>   
> +static void bochs_plane_atomic_update(struct drm_plane *plane,
> +				      struct drm_plane_state *old_state)
> +{
> +	struct bochs_device *bochs = plane->dev->dev_private;
> +	struct bochs_bo *bo;
> +
> +	if (!plane->state->fb)
> +		return;
> +	bo = gem_to_bochs_bo(plane->state->fb->obj[0]);
> +	bochs_hw_setbase(bochs,
> +			 plane->state->crtc_x,
> +			 plane->state->crtc_y,
> +			 bo->bo.offset);
> +	bochs_hw_setformat(bochs, plane->state->fb->format);
> +}
> +
> +static int bochs_plane_prepare_fb(struct drm_plane *plane,
> +				struct drm_plane_state *new_state)
> +{
> +	struct bochs_bo *bo;
> +
> +	if (!new_state->fb)
> +		return 0;
> +	bo = gem_to_bochs_bo(new_state->fb->obj[0]);
> +	return bochs_bo_pin(bo, TTM_PL_FLAG_VRAM, NULL);
> +}
> +
> +static void bochs_plane_cleanup_fb(struct drm_plane *plane,
> +				   struct drm_plane_state *old_state)
> +{
> +	struct bochs_bo *bo;
> +
> +	if (!old_state->fb)
> +		return;
> +	bo = gem_to_bochs_bo(old_state->fb->obj[0]);
> +	bochs_bo_unpin(bo);
> +}
> +
> +static const struct drm_plane_helper_funcs bochs_plane_helper_funcs = {
> +	.atomic_update = bochs_plane_atomic_update,
> +	.prepare_fb = bochs_plane_prepare_fb,
> +	.cleanup_fb = bochs_plane_cleanup_fb,
> +};
> +
> +static const struct drm_plane_funcs bochs_plane_funcs = {
> +       .update_plane   = drm_atomic_helper_update_plane,
> +       .disable_plane  = drm_atomic_helper_disable_plane,
> +       .destroy        = drm_primary_helper_destroy,
> +       .reset          = drm_atomic_helper_plane_reset,
> +       .atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
> +       .atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
> +};
> +
>   static struct drm_plane *bochs_primary_plane(struct drm_device *dev)
>   {
>   	struct drm_plane *primary;
> @@ -181,16 +239,17 @@ static struct drm_plane *bochs_primary_plane(struct drm_device *dev)
>   	}
>   
>   	ret = drm_universal_plane_init(dev, primary, 0,
> -				       &drm_primary_helper_funcs,
> +				       &bochs_plane_funcs,
>   				       bochs_formats,
>   				       ARRAY_SIZE(bochs_formats),
>   				       NULL,
>   				       DRM_PLANE_TYPE_PRIMARY, NULL);
>   	if (ret) {
>   		kfree(primary);
> -		primary = NULL;
> +		return NULL;
>   	}
>   
> +	drm_plane_helper_add(primary, &bochs_plane_helper_funcs);
>   	return primary;
>   }
>   
> @@ -275,6 +334,9 @@ static const struct drm_connector_funcs bochs_connector_connector_funcs = {
>   	.dpms = drm_helper_connector_dpms,
>   	.fill_modes = drm_helper_probe_single_connector_modes,
>   	.destroy = drm_connector_cleanup,
> +	.reset = drm_atomic_helper_connector_reset,
> +	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>   };
>   
>   static void bochs_connector_init(struct drm_device *dev)
> @@ -318,6 +380,8 @@ int bochs_kms_init(struct bochs_device *bochs)
>   	drm_connector_attach_encoder(&bochs->connector,
>   					  &bochs->encoder);
>   
> +	drm_mode_config_reset(bochs->dev);
> +
>   	return 0;
>   }
>   

