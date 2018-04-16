Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754806AbeDPJpk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:45:40 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57218 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751840AbeDPJph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:45:37 -0400
Date: Mon, 16 Apr 2018 10:45:34 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Ayan Kumar Halder <ayan.halder@arm.com>
Cc: brian.starkey@arm.com, alexandru-cosmin.gheorghe@arm.com,
        malidp@foss.arm.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, nd@arm.com
Subject: Re: [PATCH v2] drm/arm/malidp: Ensure that the crtcs are shutdown
 before removing any encoder/connector
Message-ID: <20180416094534.GF14661@e110455-lin.cambridge.arm.com>
References: <20180412154727.GJ16141@n2100.armlinux.org.uk>
 <1523633388-15112-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1523633388-15112-1-git-send-email-ayan.halder@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2018 at 04:29:48PM +0100, Ayan Kumar Halder wrote:
> One needs to ensure that the crtcs are shutdown so that the
> drm_crtc_state->connector_mask reflects that no connectors
> are currently active. Further, it reduces the reference
> count for each connector. This ensures that the connectors
> and encoders can be cleanly removed either when _unbind
> is called for the corresponding drivers or by
> drm_mode_config_cleanup().

Describing what the code does is nice and good, however it is also
useful to have a description of what the patch fixes, or why the fix
provided by the patch is better.

In this case, we need drm_atomic_helper_shutdown() to be called before
component_unbind_all() otherwise the connectors attached to the
component device will have the wrong reference count value and will not
be cleanly cleared up.

> 
> Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>

With the updated commit message:

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

> ---
> 
> Changes in v2:
>  - Reset the connectors' mask and the reference counts in drm_device
> before unbinding any of its components (ie connectors and 
> encoders).
> 
> ---
>  drivers/gpu/drm/arm/malidp_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
> index 8d20faa..0a788d7 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.c
> +++ b/drivers/gpu/drm/arm/malidp_drv.c
> @@ -278,7 +278,6 @@ static int malidp_init(struct drm_device *drm)
>  
>  static void malidp_fini(struct drm_device *drm)
>  {
> -	drm_atomic_helper_shutdown(drm);
>  	drm_mode_config_cleanup(drm);
>  }
>  
> @@ -646,6 +645,7 @@ static int malidp_bind(struct device *dev)
>  	malidp_de_irq_fini(drm);
>  	drm->irq_enabled = false;
>  irq_init_fail:
> +	drm_atomic_helper_shutdown(drm);
>  	component_unbind_all(dev, drm);
>  bind_fail:
>  	of_node_put(malidp->crtc.port);
> @@ -681,6 +681,7 @@ static void malidp_unbind(struct device *dev)
>  	malidp_se_irq_fini(drm);
>  	malidp_de_irq_fini(drm);
>  	drm->irq_enabled = false;
> +	drm_atomic_helper_shutdown(drm);
>  	component_unbind_all(dev, drm);
>  	of_node_put(malidp->crtc.port);
>  	malidp->crtc.port = NULL;
> -- 
> 2.7.4
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
