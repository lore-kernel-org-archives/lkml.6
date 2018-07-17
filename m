Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A89ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB2120863
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAB2120863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729063AbeGQHxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:53:05 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:34871 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbeGQHxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:53:05 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 449BA2801FAD2;
        Tue, 17 Jul 2018 09:21:53 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id DB85822684B; Tue, 17 Jul 2018 09:21:52 +0200 (CEST)
Date:   Tue, 17 Jul 2018 09:21:52 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>
Subject: Re: [Nouveau] [PATCH 2/5] drm/nouveau: Grab RPM ref while probing
 outputs
Message-ID: <20180717072152.GA16115@wunner.de>
References: <20180716235936.11268-1-lyude@redhat.com>
 <20180716235936.11268-3-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716235936.11268-3-lyude@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 07:59:26PM -0400, Lyude Paul wrote:
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -2012,10 +2012,18 @@ nv50_disp_atomic_state_alloc(struct drm_device *dev)
>  	return &atom->state;
>  }
>  
> +static void
> +nouveau_output_poll_changed(struct drm_device *dev)
> +{
> +	pm_runtime_get_sync(dev->dev);
> +	drm_fb_helper_hotplug_event(dev->fb_helper);
> +	pm_runtime_put_autosuspend(dev->dev);
> +}
> +
>  static const struct drm_mode_config_funcs
>  nv50_disp_func = {
>  	.fb_create = nouveau_user_framebuffer_create,
> -	.output_poll_changed = drm_fb_helper_output_poll_changed,
> +	.output_poll_changed = nouveau_output_poll_changed,

It might make sense to provide a generic DRM helper for this.
Same for patch 3 in this series.

Thanks,

Lukas
