Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4807C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89224206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfANQox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:44:53 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:45948 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbfANQox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:44:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id B25C4FB04;
        Mon, 14 Jan 2019 17:37:11 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5QTgmjqCxMHl; Mon, 14 Jan 2019 17:37:09 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 8D44947303; Mon, 14 Jan 2019 17:37:08 +0100 (CET)
Date:   Mon, 14 Jan 2019 17:37:08 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marek Vasut <marex@denx.de>, Anson Huang <anson.huang@nxp.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 07/10] drm/mxsfb: Signal mode changed when bpp changed
Message-ID: <20190114163708.GA24994@bogon.m.sigxcpu.org>
References: <1547043209-8283-1-git-send-email-robert.chiras@nxp.com>
 <1547043209-8283-8-git-send-email-robert.chiras@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547043209-8283-8-git-send-email-robert.chiras@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Wed, Jan 09, 2019 at 02:13:47PM +0000, Robert Chiras wrote:
> From: Mirela Rabulea <mirela.rabulea@nxp.com>
> 
> Add mxsfb_atomic_helper_check to signal mode changed when bpp changed.
> This will trigger the execution of disable/enable on
> a modeset with different bpp than the current one.
> 
> Signed-off-by: Mirela Rabulea <mirela.rabulea@nxp.com>
> ---
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c | 48 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> index d3fb3a8..f528a37 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> @@ -115,9 +115,55 @@ void mxsfb_disable_axi_clk(struct mxsfb_drm_private *mxsfb)
>  		clk_disable_unprepare(mxsfb->clk_axi);
>  }
>  
> +/**
> + * mxsfb_atomic_helper_check - validate state object
> + * @dev: DRM device
> + * @state: the driver state object
> + *
> + * On top of the drm imlementation drm_atomic_helper_check,
> + * check if the bpp is changed, if so, signal mode_changed,
> + * this will trigger disable/enable
> + *
> + * RETURNS:
> + * Zero for success or -errno
> + */
> +static int mxsfb_atomic_helper_check(struct drm_device *dev,
> +			    struct drm_atomic_state *state)
> +{
> +	struct drm_crtc *crtc;
> +	struct drm_crtc_state *crtc_state;
> +	int i, ret;
> +
> +	ret = drm_atomic_helper_check(dev, state);
> +	if (ret)
> +		return ret;
> +
> +	for_each_crtc_in_state(state, crtc, crtc_state, i) {

This does not exist anymore in recent drm, see
9ba29fcb76a559078491adffc74f66bf92b9dbea.
Cheers,
 -- Guido

> +		struct drm_plane_state *primary_state;
> +		int old_bpp = 0;
> +		int new_bpp = 0;
> +
> +		if (!crtc->primary || !crtc->primary->old_fb)
> +			continue;
> +		primary_state =
> +			drm_atomic_get_plane_state(state, crtc->primary);
> +		if (!primary_state || !primary_state->fb)
> +			continue;
> +		old_bpp = crtc->primary->old_fb->format->depth;
> +		new_bpp = primary_state->fb->format->depth;
> +		if (old_bpp != new_bpp) {
> +			crtc_state->mode_changed = true;
> +			DRM_DEBUG_ATOMIC(
> +				"[CRTC:%d:%s] mode changed, bpp %d->%d\n",
> +				crtc->base.id, crtc->name, old_bpp, new_bpp);
> +		}
> +	}
> +	return ret;
> +}
> +
>  static const struct drm_mode_config_funcs mxsfb_mode_config_funcs = {
>  	.fb_create		= drm_gem_fb_create,
> -	.atomic_check		= drm_atomic_helper_check,
> +	.atomic_check		= mxsfb_atomic_helper_check,
>  	.atomic_commit		= drm_atomic_helper_commit,
>  };
>  
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
