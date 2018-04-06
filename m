Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755479AbeDFOxQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 10:53:16 -0400
Received: from galahad.ideasonboard.com ([185.26.127.97]:35290 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755415AbeDFOxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 10:53:12 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Philippe Cornu <philippe.cornu@st.com>
Cc: Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Vincent Abriou <vincent.abriou@st.com>
Subject: Re: [PATCH] drm: clarify adjusted_mode for a bridge connected to a crtc
Date: Fri, 06 Apr 2018 17:53:09 +0300
Message-ID: <1765089.gI5krnOhAB@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180226121605.12050-1-philippe.cornu@st.com>
References: <20180226121605.12050-1-philippe.cornu@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philippe,

Thank you for the patch.

On Monday, 26 February 2018 14:16:04 EEST Philippe Cornu wrote:
> This patch clarifies the adjusted_mode documentation
> for a bridge directly connected to a crtc.
> 
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
> This patch is linked to the discussion https://lkml.org/lkml/2018/1/25/367
> 
>  include/drm/drm_bridge.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 3270fec46979..b5f3c070467c 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -177,7 +177,8 @@ struct drm_bridge_funcs {
>  	 * pipeline has been called already. If the bridge is the first element
>  	 * then this would be &drm_encoder_helper_funcs.mode_set. The display
>  	 * pipe (i.e.  clocks and timing signals) is off when this function is
> -	 * called.
> +	 * called. If the bridge is connected to the crtc, the adjusted_mode
> +	 * parameter is the one defined in &drm_crtc_state.adjusted_mode.

Unless I'm mistaken this will always be the mode stored in 
&drm_crtc_state.adjusted_mode (at least for atomic drivers), regardless of 
whether the bridge is the first in the chain (connected to the CRTC) or not. 
What is important to document is that we have a single adjusted_mode for the 
whole chain of bridges, and that it corresponds to the mode output by the CRTC 
for the first bridge. Bridges further in the chain can look at that mode, 
although there will probably be nothing of interest to them there.

How about the following text ?

    /**
     * @mode_set:
     *
     * This callback should set the given mode on the bridge. It is called
     * after the @mode_set callback for the preceding element in the display
     * pipeline has been called already. If the bridge is the first element
     * then this would be &drm_encoder_helper_funcs.mode_set. The display
     * pipe (i.e.  clocks and timing signals) is off when this function is
     * called.
     *
     * The adjusted_mode parameter corresponds to the mode output by the CRTC
     * for the first bridge in the chain. It can be different from the mode
     * parameter that contains the desired mode for the connector at the end
     * of the bridges chain, for instance when the first bridge in the chain
     * performs scaling. The adjusted mode is mostly useful for the first
     * bridge in the chain and is likely irrelevant for the other bridges.
     *
     * For atomic drivers the adjusted_mode is the mode stored in
     * &drm_crtc_state.adjusted_mode.
     *
     * NOTE:
     *
     * If a need arises to store and access modes adjusted for other locations
     * than the connection between the CRTC and the first bridge, the DRM
     * framework will have to be extended with DRM bridge states.
   	 */

Then I think we should also update the documentation of 
drm_crtc_state.adjusted_mode accordingly:

    /*
     * @adjusted_mode:
     *
     * Internal display timings which can be used by the driver to handle
     * differences between the mode requested by userspace in @mode and what
     * is actually programmed into the hardware.
     *
     * For drivers using drm_bridge, this store the hardware display timings
     * used between the CRTC and the first bridge. For other drivers, the
     * meaning of the adjusted_mode field is purely driver implementation
     * defined information, and will usually be used to store the hardware
     * display timings used between the CRTC and encoder blocks.
     */

-- 
Regards,

Laurent Pinchart
