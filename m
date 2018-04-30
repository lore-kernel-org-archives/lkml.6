Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754756AbeD3Pco (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:32:44 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39606 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754639AbeD3Pck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:32:40 -0400
X-Google-Smtp-Source: AB8JxZohy6nYrJtNyxHM7AtHlK2AvWfiRcl17T9UoF3lb2IxYDAEFQjwTQZq4x/tsHhWjvyf+mCYEA==
Date: Mon, 30 Apr 2018 17:32:36 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org,
        Martyn Welch <martyn.welch@collabora.co.uk>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-samsung-soc@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Peter Senna Tschudin <peter.senna@collabora.com>,
        Martin Donnelly <martin.donnelly@ge.com>,
        linux-arm-msm@vger.kernel.org, Jyri Sarha <jsarha@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        linux-arm-kernel@lists.infradead.org,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        linux-renesas-soc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH 24/24] drm/bridge: establish a link between the bridge
 supplier and consumer
Message-ID: <20180430153236.GP12521@phenom.ffwll.local>
Mail-Followup-To: Peter Rosin <peda@axentia.se>,
        linux-kernel@vger.kernel.org,
        Martyn Welch <martyn.welch@collabora.co.uk>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-samsung-soc@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Peter Senna Tschudin <peter.senna@collabora.com>,
        Martin Donnelly <martin.donnelly@ge.com>,
        linux-arm-msm@vger.kernel.org, Jyri Sarha <jsarha@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        linux-arm-kernel@lists.infradead.org,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        linux-renesas-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org, freedreno@lists.freedesktop.org
References: <20180426223139.16740-1-peda@axentia.se>
 <20180426223139.16740-25-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426223139.16740-25-peda@axentia.se>
X-Operating-System: Linux phenom 4.15.0-3-amd64 
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 12:31:39AM +0200, Peter Rosin wrote:
> If the bridge supplier is unbound, this will bring the bridge consumer
> down along with the bridge. Thus, there will no longer linger any
> dangling pointers from the bridge consumer (the drm_device) to some
> non-existent bridge supplier.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

Minus the ->owner bikeshed I brought up in the previous patch I agree with
this approach as the best way to move forward for now.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

One small suggestion below, for merging I'd say pls get Jyri's
review/tested-by too, since you're both working on the same problem it
seems.

Aside: Do you want commit rights to drm-misc to be able to push work like
this?

Cheers, Daniel

> ---
>  drivers/gpu/drm/drm_bridge.c | 18 ++++++++++++++++++
>  include/drm/drm_bridge.h     |  2 ++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index a038da696802..f0c79043ec43 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -26,6 +26,7 @@
>  #include <linux/mutex.h>
>  
>  #include <drm/drm_bridge.h>
> +#include <drm/drm_device.h>
>  #include <drm/drm_encoder.h>
>  
>  #include "drm_crtc_internal.h"
> @@ -124,12 +125,25 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
>  	if (bridge->dev)
>  		return -EBUSY;
>  
> +	if (encoder->dev->dev != bridge->owner) {

You might end up with a NULL encoder->dev->dev. Perhaps check that and
bail with a WARN_ON?

> +		bridge->link = device_link_add(encoder->dev->dev,
> +					       bridge->owner, 0);
> +		if (!bridge->link) {
> +			dev_err(bridge->owner, "failed to link bridge to %s\n",
> +				dev_name(encoder->dev->dev));
> +			return -EINVAL;
> +		}
> +	}
> +
>  	bridge->dev = encoder->dev;
>  	bridge->encoder = encoder;
>  
>  	if (bridge->funcs->attach) {
>  		ret = bridge->funcs->attach(bridge);
>  		if (ret < 0) {
> +			if (bridge->link)
> +				device_link_del(bridge->link);
> +			bridge->link = NULL;
>  			bridge->dev = NULL;
>  			bridge->encoder = NULL;
>  			return ret;
> @@ -156,6 +170,10 @@ void drm_bridge_detach(struct drm_bridge *bridge)
>  	if (bridge->funcs->detach)
>  		bridge->funcs->detach(bridge);
>  
> +	if (bridge->link)
> +		device_link_del(bridge->link);
> +	bridge->link = NULL;
> +
>  	bridge->dev = NULL;
>  }
>  
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 3bc659f3e7d2..9a386559a41a 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -261,6 +261,7 @@ struct drm_bridge_timings {
>   * @list: to keep track of all added bridges
>   * @timings: the timing specification for the bridge, if any (may
>   * be NULL)
> + * @link: drm consumer <-> bridge supplier
>   * @funcs: control functions
>   * @driver_private: pointer to the bridge driver's internal context
>   */
> @@ -271,6 +272,7 @@ struct drm_bridge {
>  	struct drm_bridge *next;
>  	struct list_head list;
>  	const struct drm_bridge_timings *timings;
> +	struct device_link *link;
>  
>  	const struct drm_bridge_funcs *funcs;
>  	void *driver_private;
> -- 
> 2.11.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
