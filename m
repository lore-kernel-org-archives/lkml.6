Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1186FC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F612172F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="gaV4311d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F612172F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389160AbeHGUp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 16:45:29 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:40478 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbeHGUp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 16:45:28 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id F403F5C06FF;
        Tue,  7 Aug 2018 20:29:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1533666584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S62vADfBXX354dpQ+IHYX5OujZri7yKBVtSt3wuz1uI=;
        b=gaV4311d9FYuDfyTKHJFUz2zbyb3+IyWecD3mRvoJE8oXrBz6WbJftPQISWy+ljEVSjeqo
        5L/jbDaNPOrUkI8plnS5nkNdgspQyKJYXmH7qjJDfu9s6fXvA8iA/Fo8PRiKYgVHlcfE93
        48D/LpGjbD4T9InG2Q3JtDMebLDPVoo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Tue, 07 Aug 2018 20:29:43 +0200
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
Subject: Re: [PATCH v3 1/4] drm/mxsfb: Fix initial corrupt frame when
 activating display
In-Reply-To: <a1551bbbb018ebe9526f7367aef536ae26bdc256.1533583611.git.leonard.crestez@nxp.com>
References: <cover.1533583611.git.leonard.crestez@nxp.com>
 <a1551bbbb018ebe9526f7367aef536ae26bdc256.1533583611.git.leonard.crestez@nxp.com>
Message-ID: <e3f8a2e1a7947a3745a699ce5a3450dc@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.08.2018 21:31, Leonard Crestez wrote:
> LCDIF will repeatedly display data from CUR_BUF and set CUR_BUF to
> NEXT_BUF when done. Since we are only ever writing to NEXT_BUF the
> display will show an initial corrupt frame.
> 
> Fix by writing the FB paddr to both CUR_BUF and NEXT_BUF when
> activating the CRTC.

Really like how this patch set evolves! Only some minor thing below...

> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 42 +++++++++++++++++++++---------
>  1 file changed, 29 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> index 0abe77675b76..db3ff5bde122 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> @@ -194,15 +194,31 @@ static int mxsfb_reset_block(void __iomem *reset_addr)
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
> +	dma_addr_t paddr;
>  	int err;
>  
>  	/*
>  	 * It seems, you can't re-program the controller if it is still
>  	 * running. This may lead to shifted pictures (FIFO issue?), so
> @@ -268,10 +284,16 @@ static void mxsfb_crtc_mode_set_nofb(struct
> mxsfb_drm_private *mxsfb)
>  	       mxsfb->base + LCDC_VDCTRL3);
>  
>  	writel(SET_DOTCLK_H_VALID_DATA_CNT(m->hdisplay),
>  	       mxsfb->base + LCDC_VDCTRL4);
>  
> +	/* Update cur_buf as well to avoid an initial corrupt frame */
> +	paddr = mxsfb_get_fb_paddr(mxsfb);
> +	if (paddr) {
> +		writel(paddr, mxsfb->base + mxsfb->devdata->cur_buf);
> +		writel(paddr, mxsfb->base + mxsfb->devdata->next_buf);
> +	}

Traditionally mxsfb_crtc_mode_set_nofb() was used as a callback to
mode_set_nofb. And that callback should not fiddle with the fb (as the
name says).

So I rather prefer to move the new bits to mxsfb_crtc_enable(), between
mxsfb_crtc_mode_set_nofb() and mxsfb_enable_controller(). It is only
cosmetics, but I'd rather prefer to have it in the right place.

Currently the AXI clock is disabled between those functions... I suggest
to enable the AXI clock once in mxsfb_crtc_enable(). This puts an end to
the unnecessary enable/disable/enable sequence in mxsfb_crtc_enable().

So I suggest to create a patch "drm/mxsfb: simplify AXI clock handling"

--- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
@@ -129,7 +129,6 @@ static void mxsfb_enable_controller(struct
mxsfb_drm_private *mxsfb)
        if (mxsfb->clk_disp_axi)
                clk_prepare_enable(mxsfb->clk_disp_axi);
        clk_prepare_enable(mxsfb->clk);
-       mxsfb_enable_axi_clk(mxsfb);
 
        /* If it was disabled, re-enable the mode again */
        writel(CTRL_DOTCLK_MODE, mxsfb->base + LCDC_CTRL + REG_SET);
@@ -159,8 +158,6 @@ static void mxsfb_disable_controller(struct
mxsfb_drm_private *mxsfb)
        reg &= ~VDCTRL4_SYNC_SIGNALS_ON;
        writel(reg, mxsfb->base + LCDC_VDCTRL4);
 
-       mxsfb_disable_axi_clk(mxsfb);
-
        clk_disable_unprepare(mxsfb->clk);
        if (mxsfb->clk_disp_axi)
                clk_disable_unprepare(mxsfb->clk_disp_axi);
@@ -208,7 +205,6 @@ static void mxsfb_crtc_mode_set_nofb(struct
mxsfb_drm_private *mxsfb)
         * running. This may lead to shifted pictures (FIFO issue?), so
         * first stop the controller and drain its FIFOs.
         */
-       mxsfb_enable_axi_clk(mxsfb);
 
        /* Mandatory eLCDIF reset as per the Reference Manual */
        err = mxsfb_reset_block(mxsfb->base);
@@ -269,12 +265,11 @@ static void mxsfb_crtc_mode_set_nofb(struct
mxsfb_drm_private *mxsfb)
 
        writel(SET_DOTCLK_H_VALID_DATA_CNT(m->hdisplay),
               mxsfb->base + LCDC_VDCTRL4);
-
-       mxsfb_disable_axi_clk(mxsfb);
 }
 
 void mxsfb_crtc_enable(struct mxsfb_drm_private *mxsfb)
 {
+       mxsfb_enable_axi_clk(mxsfb);
        mxsfb_crtc_mode_set_nofb(mxsfb);
        mxsfb_enable_controller(mxsfb);
 }
@@ -282,6 +277,7 @@ void mxsfb_crtc_enable(struct mxsfb_drm_private
*mxsfb)
 void mxsfb_crtc_disable(struct mxsfb_drm_private *mxsfb)
 {
        mxsfb_disable_controller(mxsfb);
+       mxsfb_disable_axi_clk(mxsfb);
 }
 

Then move the above section between mxsfb_crtc_mode_set_nofb() and
mxsfb_enable_controller().

--
Stefan

>  	mxsfb_disable_axi_clk(mxsfb);
>  }
>  
>  void mxsfb_crtc_enable(struct mxsfb_drm_private *mxsfb)
>  {
> @@ -287,16 +309,12 @@ void mxsfb_crtc_disable(struct mxsfb_drm_private *mxsfb)
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
> @@ -307,14 +325,12 @@ void mxsfb_plane_atomic_update(struct
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
