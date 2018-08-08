Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EFEC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A6321A29
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="b0K/tVl3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A6321A29
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbeHHVTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 17:19:12 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:51102 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbeHHVTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 17:19:12 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 3D36A5C0491;
        Wed,  8 Aug 2018 20:58:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1533754690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UNj3frUBMyoj8308SEGkRnsVEk1NdhoU/iPZ0Dolx/M=;
        b=b0K/tVl3MHNO3T7Z2Gbx3Bnax3edB5QeY12f2yFNfr3iUggqZw51ealpAwkr7fN8sb0Faq
        +gdB7CJYsGT1gP5In07z7oOQYY7F0hy9aeLSSEMaWVGj90wrypT7ZRX2Tkq1/gvkvKBVrW
        i6RDjQWerzR67WBSBDVIo5IwOOVJ67g=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Wed, 08 Aug 2018 20:58:10 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Marek Vasut <marex@denx.de>, Shawn Guo <shawnguo@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Robert Chiras <robert.chiras@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        dri-devel@lists.freedesktop.org,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] drm/mxsfb: Fix initial corrupt frame when
 activating display
In-Reply-To: <056bd70ef7bf4d66d636cf7869a489e8c743aaf3.1533743954.git.leonard.crestez@nxp.com>
References: <cover.1533743954.git.leonard.crestez@nxp.com>
 <056bd70ef7bf4d66d636cf7869a489e8c743aaf3.1533743954.git.leonard.crestez@nxp.com>
Message-ID: <f4cb848b487ce2eb3dfe41d20b253796@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.08.2018 18:08, Leonard Crestez wrote:
> LCDIF will repeatedly display data from CUR_BUF and set CUR_BUF to
> NEXT_BUF when done. Since we are only ever writing to NEXT_BUF the
> display will show an initial corrupt frame.
> 
> Fix by writing the FB paddr to both CUR_BUF and NEXT_BUF when
> activating the CRTC.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Tested-by: Philipp Zabel <p.zabel@pengutronix.de>

Reviewed-by: Stefan Agner <stefan@agner.ch>

> ---
>  drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 45 +++++++++++++++++++++---------
>  1 file changed, 32 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> index e4fcbb65b969..24b1f0c1432e 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> @@ -191,10 +191,25 @@ static int mxsfb_reset_block(void __iomem *reset_addr)
>  		return ret;
>  
>  	return clear_poll_bit(reset_addr, MODULE_CLKGATE);
>  }
>  
> +static dma_addr_t mxsfb_get_fb_paddr(struct mxsfb_drm_private *mxsfb)
> +{
> +	struct drm_framebuffer *fb = mxsfb->pipe.plane.state->fb;
> +	struct drm_gem_cma_object *gem;
> +
> +	if (!fb)
> +		return 0;
> +
> +	gem = drm_fb_cma_get_gem_obj(fb, 0);
> +	if (!gem)
> +		return 0;
> +
> +	return gem->paddr;
> +}
> +
>  static void mxsfb_crtc_mode_set_nofb(struct mxsfb_drm_private *mxsfb)
>  {
>  	struct drm_display_mode *m = &mxsfb->pipe.crtc.state->adjusted_mode;
>  	const u32 bus_flags = mxsfb->connector.display_info.bus_flags;
>  	u32 vdctrl0, vsync_pulse_len, hsync_pulse_len;
> @@ -267,12 +282,22 @@ static void mxsfb_crtc_mode_set_nofb(struct
> mxsfb_drm_private *mxsfb)
>  	       mxsfb->base + LCDC_VDCTRL4);
>  }
>  
>  void mxsfb_crtc_enable(struct mxsfb_drm_private *mxsfb)
>  {
> +	dma_addr_t paddr;
> +
>  	mxsfb_enable_axi_clk(mxsfb);
>  	mxsfb_crtc_mode_set_nofb(mxsfb);
> +
> +	/* Write cur_buf as well to avoid an initial corrupt frame */
> +	paddr = mxsfb_get_fb_paddr(mxsfb);
> +	if (paddr) {
> +		writel(paddr, mxsfb->base + mxsfb->devdata->cur_buf);
> +		writel(paddr, mxsfb->base + mxsfb->devdata->next_buf);
> +	}
> +
>  	mxsfb_enable_controller(mxsfb);
>  }
>  
>  void mxsfb_crtc_disable(struct mxsfb_drm_private *mxsfb)
>  {
> @@ -283,16 +308,12 @@ void mxsfb_crtc_disable(struct mxsfb_drm_private *mxsfb)
>  void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
>  			       struct drm_plane_state *state)
>  {
>  	struct drm_simple_display_pipe *pipe = &mxsfb->pipe;
>  	struct drm_crtc *crtc = &pipe->crtc;
> -	struct drm_framebuffer *fb = pipe->plane.state->fb;
>  	struct drm_pending_vblank_event *event;
> -	struct drm_gem_cma_object *gem;
> -
> -	if (!crtc)
> -		return;
> +	dma_addr_t paddr;
>  
>  	spin_lock_irq(&crtc->dev->event_lock);
>  	event = crtc->state->event;
>  	if (event) {
>  		crtc->state->event = NULL;
> @@ -303,14 +324,12 @@ void mxsfb_plane_atomic_update(struct
> mxsfb_drm_private *mxsfb,
>  			drm_crtc_send_vblank_event(crtc, event);
>  		}
>  	}
>  	spin_unlock_irq(&crtc->dev->event_lock);
>  
> -	if (!fb)
> -		return;
> -
> -	gem = drm_fb_cma_get_gem_obj(fb, 0);
> -
> -	mxsfb_enable_axi_clk(mxsfb);
> -	writel(gem->paddr, mxsfb->base + mxsfb->devdata->next_buf);
> -	mxsfb_disable_axi_clk(mxsfb);
> +	paddr = mxsfb_get_fb_paddr(mxsfb);
> +	if (paddr) {
> +		mxsfb_enable_axi_clk(mxsfb);
> +		writel(paddr, mxsfb->base + mxsfb->devdata->next_buf);
> +		mxsfb_disable_axi_clk(mxsfb);
> +	}
>  }
