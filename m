Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED24C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 16:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85C120843
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 16:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85C120843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tronnes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbeJ1BDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 21:03:20 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:55188 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbeJ1BDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 21:03:20 -0400
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:58881 helo=[192.168.10.175])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gGRLQ-0001AR-9f; Sat, 27 Oct 2018 18:21:48 +0200
Subject: Re: [PATCH] drm/tinydrm: Advertise that we can do only
 DRM_FORMAT_MOD_LINEAR.
To:     Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org
References: <20181025162635.6689-1-eric@anholt.net>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <ca2c2bb1-5440-860b-c713-6f3a319c12c2@tronnes.org>
Date:   Sat, 27 Oct 2018 18:21:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181025162635.6689-1-eric@anholt.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Den 25.10.2018 18.26, skrev Eric Anholt:
> Without this, the xserver relies on what the 3D driver exposes and
> assumes that the display can handle it, and then the DRM driver
> happily tries to scan out a tiled format.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>   drivers/gpu/drm/drm_simple_kms_helper.c     | 8 ++++++++
>   drivers/gpu/drm/tinydrm/core/tinydrm-core.c | 1 +
>   drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c | 6 +++++-
>   3 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
> index 51fa978f0d23..917812448d1b 100644
> --- a/drivers/gpu/drm/drm_simple_kms_helper.c
> +++ b/drivers/gpu/drm/drm_simple_kms_helper.c
> @@ -190,6 +190,13 @@ static void drm_simple_kms_plane_cleanup_fb(struct drm_plane *plane,
>   	pipe->funcs->cleanup_fb(pipe, state);
>   }
>   
> +static bool drm_simple_kms_format_mod_supported(struct drm_plane *plane,
> +						uint32_t format,
> +						uint64_t modifier)
> +{
> +	return modifier == DRM_FORMAT_MOD_LINEAR;
> +}
> +

I assume this also works for the other drivers that use this helper.
A quick look at the code seems to support this assumption.
Format modifiers is something I've never looked at before.

Acked-by: Noralf Trønnes <noralf@tronnes.org>

>   static const struct drm_plane_helper_funcs drm_simple_kms_plane_helper_funcs = {
>   	.prepare_fb = drm_simple_kms_plane_prepare_fb,
>   	.cleanup_fb = drm_simple_kms_plane_cleanup_fb,
> @@ -204,6 +211,7 @@ static const struct drm_plane_funcs drm_simple_kms_plane_funcs = {
>   	.reset			= drm_atomic_helper_plane_reset,
>   	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
>   	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
> +	.format_mod_supported   = drm_simple_kms_format_mod_supported,
>   };
>   
>   /**
> diff --git a/drivers/gpu/drm/tinydrm/core/tinydrm-core.c b/drivers/gpu/drm/tinydrm/core/tinydrm-core.c
> index 255341ee4eb9..9af51d982a33 100644
> --- a/drivers/gpu/drm/tinydrm/core/tinydrm-core.c
> +++ b/drivers/gpu/drm/tinydrm/core/tinydrm-core.c
> @@ -146,6 +146,7 @@ static int tinydrm_init(struct device *parent, struct tinydrm_device *tdev,
>   	drm->dev_private = tdev;
>   	drm_mode_config_init(drm);
>   	drm->mode_config.funcs = &tinydrm_mode_config_funcs;
> +	drm->mode_config.allow_fb_modifiers = true;
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c b/drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c
> index 7e8e24d0b7a7..eacfc0ec8ff1 100644
> --- a/drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c
> +++ b/drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c
> @@ -184,6 +184,10 @@ tinydrm_display_pipe_init(struct tinydrm_device *tdev,
>   	struct drm_display_mode mode_copy;
>   	struct drm_connector *connector;
>   	int ret;
> +	static const uint64_t modifiers[] = {
> +		DRM_FORMAT_MOD_LINEAR,
> +		DRM_FORMAT_MOD_INVALID
> +	};
>   
>   	drm_mode_copy(&mode_copy, mode);
>   	ret = tinydrm_rotate_mode(&mode_copy, rotation);
> @@ -202,6 +206,6 @@ tinydrm_display_pipe_init(struct tinydrm_device *tdev,
>   		return PTR_ERR(connector);
>   
>   	return drm_simple_display_pipe_init(drm, &tdev->pipe, funcs, formats,
> -					    format_count, NULL, connector);
> +					    format_count, modifiers, connector);
>   }
>   EXPORT_SYMBOL(tinydrm_display_pipe_init);

