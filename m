Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5FAC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03DA2208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="FPf0uRXl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03DA2208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390474AbeHGVRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:17:48 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:40740 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390044AbeHGVRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:17:47 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 82B4F5C0187;
        Tue,  7 Aug 2018 21:01:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1533668519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gian+ODqz/9V5I1yF8So0gFFLgyxycvvhkEjfrY8QDM=;
        b=FPf0uRXl9UEtQjxuzGzQqHzWj8Jjw/idBVavEyIeSlMH/6Kj1Ls82GSx70x4RBopuDHfuX
        ofsTw3pqQCVhx+61fjKElxalEbbocNF3c2sFjo6AfD6/wkEVsLQH/eM+OxoJ39FAoGwCZo
        iZAgbFfLfM2bEVxhn1l65RwcY0dkeGI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Tue, 07 Aug 2018 21:01:59 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Marek Vasut <marex@denx.de>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        dri-devel@lists.freedesktop.org,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] drm/mxsfb: Switch to
 drm_atomic_helper_commit_tail_rpm
In-Reply-To: <cd938df7516aee05289dc2d7dc17bc85b219be53.1533583611.git.leonard.crestez@nxp.com>
References: <cover.1533583611.git.leonard.crestez@nxp.com>
 <cd938df7516aee05289dc2d7dc17bc85b219be53.1533583611.git.leonard.crestez@nxp.com>
Message-ID: <da414ab37c3d7c02f059fd3c0470dac9@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.08.2018 21:31, Leonard Crestez wrote:
> The lcdif block is only powered on when display is active so plane
> updates when not enabled are not valid. Writing to an unpowered IP block
> is mostly ignored but can trigger bus errors on some chips.
> 
> Prevent this situation by switching to drm_atomic_helper_commit_tail_rpm
> and having the drm core ensure atomic_plane_update is only called while
> the crtc is active. This avoids having to keep track of "enabled" bits
> inside the mxsfb driver.
> 
> This also requires handling the vblank event for disable from
> mxsfb_pipe_update.

Hm, I don't think this is a new requirement. Simple KMS Helper Reference
clearly states that it should be called from update:
https://www.kernel.org/doc/html/v4.17/gpu/drm-kms-helpers.html#simple-kms-helper-reference

Probably using drm_atomic_helper_commit_tail_rpm just exacerbates an
issue which we haven't seen before...

Since I think it is a general fix, I'd rather prefer have it in a
separate commit.

> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Suggested-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> index d797dfd40d98..5777e730085b 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> @@ -96,10 +96,14 @@ static const struct drm_mode_config_funcs
> mxsfb_mode_config_funcs = {
>  	.fb_create		= drm_gem_fb_create,
>  	.atomic_check		= drm_atomic_helper_check,
>  	.atomic_commit		= drm_atomic_helper_commit,
>  };
>  
> +static const struct drm_mode_config_helper_funcs mxsfb_mode_config_helpers = {
> +	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
> +};
> +
>  static void mxsfb_pipe_enable(struct drm_simple_display_pipe *pipe,
>  			      struct drm_crtc_state *crtc_state,
>  			      struct drm_plane_state *plane_state)
>  {
>  	struct mxsfb_drm_private *mxsfb = drm_pipe_to_mxsfb_drm_private(pipe);
> @@ -113,15 +117,25 @@ static void mxsfb_pipe_enable(struct
> drm_simple_display_pipe *pipe,
>  
>  static void mxsfb_pipe_disable(struct drm_simple_display_pipe *pipe)
>  {

Shouldn't that be in mxsfb_pipe_update?

--
Stefan

>  	struct mxsfb_drm_private *mxsfb = drm_pipe_to_mxsfb_drm_private(pipe);
>  	struct drm_device *drm = pipe->plane.dev;
> +	struct drm_crtc *crtc = &pipe->crtc;
> +	struct drm_pending_vblank_event *event;
>  
>  	drm_panel_disable(mxsfb->panel);
>  	mxsfb_crtc_disable(mxsfb);
>  	drm_panel_unprepare(mxsfb->panel);
>  	pm_runtime_put_sync(drm->dev);
> +
> +	spin_lock_irq(&drm->event_lock);
> +	event = crtc->state->event;
> +	if (event) {
> +		crtc->state->event = NULL;
> +		drm_crtc_send_vblank_event(crtc, event);
> +	}
> +	spin_unlock_irq(&drm->event_lock);
>  }
>  
>  static void mxsfb_pipe_update(struct drm_simple_display_pipe *pipe,
>  			      struct drm_plane_state *plane_state)
>  {
> @@ -232,10 +246,11 @@ static int mxsfb_load(struct drm_device *drm,
> unsigned long flags)
>  	drm->mode_config.min_width	= MXSFB_MIN_XRES;
>  	drm->mode_config.min_height	= MXSFB_MIN_YRES;
>  	drm->mode_config.max_width	= MXSFB_MAX_XRES;
>  	drm->mode_config.max_height	= MXSFB_MAX_YRES;
>  	drm->mode_config.funcs		= &mxsfb_mode_config_funcs;
> +	drm->mode_config.helper_private	= &mxsfb_mode_config_helpers;
>  
>  	drm_mode_config_reset(drm);
>  
>  	pm_runtime_get_sync(drm->dev);
>  	ret = drm_irq_install(drm, platform_get_irq(pdev, 0));
