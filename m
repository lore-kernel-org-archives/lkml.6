Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E1CC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C1121797
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="cnfsBODg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C1121797
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbeHHVS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 17:18:57 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:51082 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbeHHVS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 17:18:57 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 585065C0491;
        Wed,  8 Aug 2018 20:57:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1533754675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wQeqn76kfSAgBG53kgj3jfIcKGVE9ouH6iqfIOzA8mo=;
        b=cnfsBODgeOsFlmVqLwMMHC65RmdMn30TLJ6OUEFmV7MSCgvnz5TkweM/8Im9mWEP5Qo8ua
        BdmN8mCSRFDCvEbgxfeVLA8tsAi7IHcEFyvee2U8r+7HVl8Vdl3vj7KgZ5uCBCDftwnN6A
        C+bRt5tqYEi39KmQohT2mvt1nTGSZvo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Wed, 08 Aug 2018 20:57:55 +0200
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
Subject: Re: [PATCH v4 1/5] drm/mxsfb: Move axi clk enable/disable to crtc
 enable/disable
In-Reply-To: <f0d719af219a7f922bcc0746e9f840c471c56c5d.1533743954.git.leonard.crestez@nxp.com>
References: <cover.1533743954.git.leonard.crestez@nxp.com>
 <f0d719af219a7f922bcc0746e9f840c471c56c5d.1533743954.git.leonard.crestez@nxp.com>
Message-ID: <19cefc44fb2888fa0de4c54f1e8c9bd9@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.08.2018 18:08, Leonard Crestez wrote:
> The main axi clk is disabled at the end of mxsfb_crtc_mode_set_nofb and
> immediately reenabled in mxsfb_enable_controller.
> 
> Avoid this by moving the handling of axi clk one level up to
> mxsfb_crtc_enable. Do the same for mxsfb_crtc_disable for simmetry
> 
> This shouldn't have any functional effect.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Thanks, looks good!

Reviewed-by: Stefan Agner <stefan@agner.ch>

> ---
>  drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> index 0abe77675b76..e4fcbb65b969 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> @@ -127,11 +127,10 @@ static void mxsfb_enable_controller(struct
> mxsfb_drm_private *mxsfb)
>  	u32 reg;
>  
>  	if (mxsfb->clk_disp_axi)
>  		clk_prepare_enable(mxsfb->clk_disp_axi);
>  	clk_prepare_enable(mxsfb->clk);
> -	mxsfb_enable_axi_clk(mxsfb);
>  
>  	/* If it was disabled, re-enable the mode again */
>  	writel(CTRL_DOTCLK_MODE, mxsfb->base + LCDC_CTRL + REG_SET);
>  
>  	/* Enable the SYNC signals first, then the DMA engine */
> @@ -157,12 +156,10 @@ static void mxsfb_disable_controller(struct
> mxsfb_drm_private *mxsfb)
>  
>  	reg = readl(mxsfb->base + LCDC_VDCTRL4);
>  	reg &= ~VDCTRL4_SYNC_SIGNALS_ON;
>  	writel(reg, mxsfb->base + LCDC_VDCTRL4);
>  
> -	mxsfb_disable_axi_clk(mxsfb);
> -
>  	clk_disable_unprepare(mxsfb->clk);
>  	if (mxsfb->clk_disp_axi)
>  		clk_disable_unprepare(mxsfb->clk_disp_axi);
>  }
>  
> @@ -206,11 +203,10 @@ static void mxsfb_crtc_mode_set_nofb(struct
> mxsfb_drm_private *mxsfb)
>  	/*
>  	 * It seems, you can't re-program the controller if it is still
>  	 * running. This may lead to shifted pictures (FIFO issue?), so
>  	 * first stop the controller and drain its FIFOs.
>  	 */
> -	mxsfb_enable_axi_clk(mxsfb);
>  
>  	/* Mandatory eLCDIF reset as per the Reference Manual */
>  	err = mxsfb_reset_block(mxsfb->base);
>  	if (err)
>  		return;
> @@ -267,23 +263,23 @@ static void mxsfb_crtc_mode_set_nofb(struct
> mxsfb_drm_private *mxsfb)
>  	       SET_VERT_WAIT_CNT(m->crtc_vtotal - m->crtc_vsync_start),
>  	       mxsfb->base + LCDC_VDCTRL3);
>  
>  	writel(SET_DOTCLK_H_VALID_DATA_CNT(m->hdisplay),
>  	       mxsfb->base + LCDC_VDCTRL4);
> -
> -	mxsfb_disable_axi_clk(mxsfb);
>  }
>  
>  void mxsfb_crtc_enable(struct mxsfb_drm_private *mxsfb)
>  {
> +	mxsfb_enable_axi_clk(mxsfb);
>  	mxsfb_crtc_mode_set_nofb(mxsfb);
>  	mxsfb_enable_controller(mxsfb);
>  }
>  
>  void mxsfb_crtc_disable(struct mxsfb_drm_private *mxsfb)
>  {
>  	mxsfb_disable_controller(mxsfb);
> +	mxsfb_disable_axi_clk(mxsfb);
>  }
>  
>  void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
>  			       struct drm_plane_state *state)
>  {
