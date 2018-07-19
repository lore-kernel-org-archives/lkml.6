Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3196CC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03A120693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E03A120693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731492AbeGSIuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 04:50:11 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:47693 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731456AbeGSIuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 04:50:11 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 3DF1010195452;
        Thu, 19 Jul 2018 10:08:13 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id D7FEB2165F4; Thu, 19 Jul 2018 10:08:12 +0200 (CEST)
Date:   Thu, 19 Jul 2018 10:08:12 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Ben Skeggs <bskeggs@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/probe_helper: Add
 drm_helper_probe_single_connector_modes_with_rpm()
Message-ID: <20180719080812.GA14235@wunner.de>
References: <20180718205645.25924-1-lyude@redhat.com>
 <20180718205645.25924-3-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718205645.25924-3-lyude@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 04:56:40PM -0400, Lyude Paul wrote:
> For nouveau, while the GPU is guaranteed to be on when a hotplug has
> been received, the same assertion does not hold true if a connector
> probe has been started by userspace without having had received a sysfs
> event.
> 
> So ensure that any connector probing keeps the GPU alive for the
> duration of the probe by introducing
> drm_helper_probe_single_connector_modes_with_rpm(). It's the same as
> drm_helper_probe_single_connector_modes, but it handles holding a power
> reference to the device for the duration of the connector probe.

Hm, a runtime PM ref is already acquired in nouveau_connector_detect().
I'm wondering why that's not sufficient?

Thanks,

Lukas

> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Reviewed-by: Karol Herbst <karolherbst@gmail.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org
> ---
> Changes since v1:
>  - Add a generic helper to DRM to handle this
> 
>  drivers/gpu/drm/drm_probe_helper.c          | 31 +++++++++++++++++++++
>  drivers/gpu/drm/nouveau/dispnv50/disp.c     |  2 +-
>  drivers/gpu/drm/nouveau/nouveau_connector.c |  4 +--
>  include/drm/drm_crtc_helper.h               |  7 +++--
>  4 files changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
> index 527743394150..0a9d6748b854 100644
> --- a/drivers/gpu/drm/drm_probe_helper.c
> +++ b/drivers/gpu/drm/drm_probe_helper.c
> @@ -31,6 +31,7 @@
>  
>  #include <linux/export.h>
>  #include <linux/moduleparam.h>
> +#include <linux/pm_runtime.h>
>  
>  #include <drm/drmP.h>
>  #include <drm/drm_crtc.h>
> @@ -541,6 +542,36 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
>  }
>  EXPORT_SYMBOL(drm_helper_probe_single_connector_modes);
>  
> +/**
> + * drm_helper_probe_single_connector_modes_with_rpm - get complete set of
> + *                                                    display modes
> + * @connector: connector to probe
> + * @maxX: max width for modes
> + * @maxY: max height for modes
> + *
> + * Same as drm_helper_probe_single_connector_modes, except that it makes sure
> + * that the device is active by synchronously grabbing a runtime power
> + * reference while probing.
> + *
> + * Returns:
> + * The number of modes found on @connector.
> + */
> +int drm_helper_probe_single_connector_modes_with_rpm(struct drm_connector *connector,
> +						     uint32_t maxX, uint32_t maxY)
> +{
> +	int ret;
> +
> +	ret = pm_runtime_get_sync(connector->dev->dev);
> +	if (ret < 0 && ret != -EACCES)
> +		return ret;
> +
> +	ret = drm_helper_probe_single_connector_modes(connector, maxX, maxY);
> +
> +	pm_runtime_put(connector->dev->dev);
> +	return ret;
> +}
> +EXPORT_SYMBOL(drm_helper_probe_single_connector_modes_with_rpm);
> +
>  /**
>   * drm_kms_helper_hotplug_event - fire off KMS hotplug events
>   * @dev: drm_device whose connector state changed
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> index fa3ab618a0f9..c54767b50fd8 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -858,7 +858,7 @@ static const struct drm_connector_funcs
>  nv50_mstc = {
>  	.reset = nouveau_conn_reset,
>  	.detect = nv50_mstc_detect,
> -	.fill_modes = drm_helper_probe_single_connector_modes,
> +	.fill_modes = drm_helper_probe_single_connector_modes_with_rpm,
>  	.destroy = nv50_mstc_destroy,
>  	.atomic_duplicate_state = nouveau_conn_atomic_duplicate_state,
>  	.atomic_destroy_state = nouveau_conn_atomic_destroy_state,
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
> index 2a45b4c2ceb0..8d9070779261 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -1088,7 +1088,7 @@ nouveau_connector_funcs = {
>  	.reset = nouveau_conn_reset,
>  	.detect = nouveau_connector_detect,
>  	.force = nouveau_connector_force,
> -	.fill_modes = drm_helper_probe_single_connector_modes,
> +	.fill_modes = drm_helper_probe_single_connector_modes_with_rpm,
>  	.set_property = nouveau_connector_set_property,
>  	.destroy = nouveau_connector_destroy,
>  	.atomic_duplicate_state = nouveau_conn_atomic_duplicate_state,
> @@ -1103,7 +1103,7 @@ nouveau_connector_funcs_lvds = {
>  	.reset = nouveau_conn_reset,
>  	.detect = nouveau_connector_detect_lvds,
>  	.force = nouveau_connector_force,
> -	.fill_modes = drm_helper_probe_single_connector_modes,
> +	.fill_modes = drm_helper_probe_single_connector_modes_with_rpm,
>  	.set_property = nouveau_connector_set_property,
>  	.destroy = nouveau_connector_destroy,
>  	.atomic_duplicate_state = nouveau_conn_atomic_duplicate_state,
> diff --git a/include/drm/drm_crtc_helper.h b/include/drm/drm_crtc_helper.h
> index 6914633037a5..8f3f6d6fcc8c 100644
> --- a/include/drm/drm_crtc_helper.h
> +++ b/include/drm/drm_crtc_helper.h
> @@ -64,9 +64,10 @@ int drm_helper_crtc_mode_set_base(struct drm_crtc *crtc, int x, int y,
>  				  struct drm_framebuffer *old_fb);
>  
>  /* drm_probe_helper.c */
> -int drm_helper_probe_single_connector_modes(struct drm_connector
> -					    *connector, uint32_t maxX,
> -					    uint32_t maxY);
> +int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
> +					    uint32_t maxX, uint32_t maxY);
> +int drm_helper_probe_single_connector_modes_with_rpm(struct drm_connector *connector,
> +						     uint32_t maxX, uint32_t maxY);
>  int drm_helper_probe_detect(struct drm_connector *connector,
>  			    struct drm_modeset_acquire_ctx *ctx,
>  			    bool force);
> -- 
> 2.17.1
> 
