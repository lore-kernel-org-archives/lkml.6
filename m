Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbeECJG5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 05:06:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38927 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbeECJGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 05:06:53 -0400
X-Google-Smtp-Source: AB8JxZre6FAo9WxBIk7jwBCxb/qJsGA2tgds8pmqGp2J1qE4YY/eqwf5s9gBMqf6K5/3H/V/eoRvMw==
Date: Thu, 3 May 2018 11:06:48 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-rockchip@lists.infradead.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, dri-devel@lists.freedesktop.org,
        Vincent Abriou <vincent.abriou@st.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] drm/sti: do not remove the drm_bridge that was never
 added
Message-ID: <20180503090648.GG12521@phenom.ffwll.local>
Mail-Followup-To: Peter Rosin <peda@axentia.se>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-rockchip@lists.infradead.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, dri-devel@lists.freedesktop.org,
        Vincent Abriou <vincent.abriou@st.com>,
        linux-arm-kernel@lists.infradead.org
References: <20180502074025.12421-1-peda@axentia.se>
 <20180502074025.12421-2-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180502074025.12421-2-peda@axentia.se>
X-Operating-System: Linux phenom 4.15.0-3-amd64 
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 09:40:23AM +0200, Peter Rosin wrote:
> The more natural approach would perhaps be to add an drm_bridge_add,
> but there are several other bridges that never call drm_bridge_add.
> Just removing the drm_bridge_remove is the easier fix.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

This mess is much bigger. There's 2 pairs of bridge functions:

- drm_bridge_attach/detach. Those are meant to be called by the overall
  drm driver to connect/disconnect a drm_bridge.

- drm_bridge_add/remove. These are supposed to be called by the bridge
  driver itself to register/unregister itself. Maybe we should rename
  them, since the same issue happens with drm_panel, with the same
  confusion.

I thought someone was working on a cleanup series to fix this mess, but I
didn't find anything.
-Daniel

> ---
>  drivers/gpu/drm/sti/sti_hda.c  | 1 -
>  drivers/gpu/drm/sti/sti_hdmi.c | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
> index 67bbdb49fffc..199db13f565c 100644
> --- a/drivers/gpu/drm/sti/sti_hda.c
> +++ b/drivers/gpu/drm/sti/sti_hda.c
> @@ -721,7 +721,6 @@ static int sti_hda_bind(struct device *dev, struct device *master, void *data)
>  	return 0;
>  
>  err_sysfs:
> -	drm_bridge_remove(bridge);
>  	return -EINVAL;
>  }
>  
> diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
> index 58f431102512..932724784942 100644
> --- a/drivers/gpu/drm/sti/sti_hdmi.c
> +++ b/drivers/gpu/drm/sti/sti_hdmi.c
> @@ -1315,7 +1315,6 @@ static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
>  	return 0;
>  
>  err_sysfs:
> -	drm_bridge_remove(bridge);
>  	hdmi->drm_connector = NULL;
>  	return -EINVAL;
>  }
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
