Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754634AbeD3PYq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:24:46 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53963 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753482AbeD3PYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:24:43 -0400
X-Google-Smtp-Source: AB8JxZr3119zmnzfGdyY7KWrLdQkDydbeqSYMcjySqNvzUIeNGRQ1pJYIkKKeETYyUbs0VQ/8EuRIQ==
Date: Mon, 30 Apr 2018 17:24:38 +0200
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
Subject: Re: [PATCH 23/24] drm/bridge: require the .owner to be filled in on
 drm_bridge_attach
Message-ID: <20180430152438.GO12521@phenom.ffwll.local>
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
 <20180426223139.16740-24-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426223139.16740-24-peda@axentia.se>
X-Operating-System: Linux phenom 4.15.0-3-amd64 
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 12:31:38AM +0200, Peter Rosin wrote:
> The .owner will be handy to have around.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/gpu/drm/drm_bridge.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 9f023bd84d56..a038da696802 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -115,6 +115,9 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
>  	if (!encoder || !bridge)
>  		return -EINVAL;
>  
> +	if (WARN_ON(!bridge->owner))
> +		return -EINVAL;

I think conceptually this is checked at the wrong place, and I think also misnamed
a bit. The ->owner is essentially the struct device (and its associated
driver) that provides the drm_bridge. As such it should be filled out
already at drm_bridge_add() time, and I think the check should be in
there. For driver-internal bridges it might make sense to also check this
here, not sure. Or just require all bridges get added.

Wrt the name, I think we should call this pdev or something. ->owner
usually means the module owner. I think in other subsystems ->dev is used,
but in drm we use ->dev for the drm_device pointer, so totally different
thing. pdev = physical device is the best I came up with. Better
suggestions very much welcome.
-Daniel

> +
>  	if (previous && (!previous->dev || previous->encoder != encoder))
>  		return -EINVAL;
>  
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
