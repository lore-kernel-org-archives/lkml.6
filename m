Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE46C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22FB206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfANQo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:44:56 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:45949 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbfANQoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:44:54 -0500
X-Greylist: delayed 459 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Jan 2019 11:44:52 EST
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 68171FB05;
        Mon, 14 Jan 2019 17:38:39 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qtI92PIbpOo9; Mon, 14 Jan 2019 17:38:33 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id D638A47303; Mon, 14 Jan 2019 17:38:32 +0100 (CET)
Date:   Mon, 14 Jan 2019 17:38:32 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marek Vasut <marex@denx.de>, Anson Huang <anson.huang@nxp.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 04/10] drm/mxsfb: Update mxsfb with additional pixel
 formats
Message-ID: <20190114163832.GB24994@bogon.m.sigxcpu.org>
References: <1547043209-8283-1-git-send-email-robert.chiras@nxp.com>
 <1547043209-8283-5-git-send-email-robert.chiras@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547043209-8283-5-git-send-email-robert.chiras@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Wed, Jan 09, 2019 at 02:13:43PM +0000, Robert Chiras wrote:
> Since version 4 of eLCDIF, there are some registers that can do
> transformations on the input data, like re-arranging the pixel
> components. By doing that, we can support more pixel formats.
> This patch adds support for X/ABGR and RGBX/A. Although, the local alpha
> is not supported by eLCDIF, the alpha pixel formats were added to the
> supported pixel formats but it will be ignored. This was necessary since
> there are systems (like Android) that requires such pixel formats.
> 
> Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
> ---
>  drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 108 ++++++++++++++++++++++++++++---------
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c  |  27 +++++++---
>  drivers/gpu/drm/mxsfb/mxsfb_drv.h  |   4 +-
>  drivers/gpu/drm/mxsfb/mxsfb_regs.h | 100 ++++++++++++++++++++--------------
>  4 files changed, 169 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> index f0648ce..6aa8804 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> @@ -48,15 +48,35 @@ static u32 set_hsync_pulse_width(struct mxsfb_drm_private *mxsfb, u32 val)
>  		mxsfb->devdata->hs_wdth_shift;
>  }
>  
> +/*  Print Four-character-code (FOURCC) */
> +static char *fourcc_to_str(u32 fmt)
> +{
> +	/* Use 10 chars so we can simultaneously print two codes */
> +	static char code[10], *c = &code[0];
> +
> +	if (c == &code[10])
> +		c = &code[0];
> +
> +	*(c++) = (unsigned char)(fmt & 0xff);
> +	*(c++) = (unsigned char)((fmt >> 8) & 0xff);
> +	*(c++) = (unsigned char)((fmt >> 16) & 0xff);
> +	*(c++) = (unsigned char)((fmt >> 24) & 0xff);
> +	*(c++) = '\0';
> +
> +	return (c - 5);
> +}
> +
>  /* Setup the MXSFB registers for decoding the pixels out of the framebuffer */
> -static int mxsfb_set_pixel_fmt(struct mxsfb_drm_private *mxsfb)
> +static int mxsfb_set_pixel_fmt(struct mxsfb_drm_private *mxsfb, bool update)
>  {
>  	struct drm_crtc *crtc = &mxsfb->pipe.crtc;
>  	struct drm_device *drm = crtc->dev;
>  	const u32 format = crtc->primary->state->fb->format->format;
> -	u32 ctrl, ctrl1;
> +	u32 ctrl = 0, ctrl1 = 0;
> +	bool bgr_format = true;
>  
> -	ctrl = CTRL_BYPASS_COUNT | CTRL_MASTER;
> +	if (!update)
> +		ctrl = CTRL_BYPASS_COUNT | CTRL_MASTER;
>  
>  	/*
>  	 * WARNING: The bus width, CTRL_SET_BUS_WIDTH(), is configured to
> @@ -65,31 +85,69 @@ static int mxsfb_set_pixel_fmt(struct mxsfb_drm_private *mxsfb)
>  	 * to arbitrary value. This limitation should not pose an issue.
>  	 */
>  
> -	/* CTRL1 contains IRQ config and status bits, preserve those. */
> -	ctrl1 = readl(mxsfb->base + LCDC_CTRL1);
> -	ctrl1 &= CTRL1_CUR_FRAME_DONE_IRQ_EN | CTRL1_CUR_FRAME_DONE_IRQ;
> +	if (!update) {
> +		/* CTRL1 contains IRQ config and status bits, preserve those. */
> +		ctrl1 = readl(mxsfb->base + LCDC_CTRL1);
> +		ctrl1 &= CTRL1_CUR_FRAME_DONE_IRQ_EN | CTRL1_CUR_FRAME_DONE_IRQ;
> +	}
> +
> +	DRM_DEV_DEBUG_DRIVER(drm->dev, "Setting up %s mode\n",
> +		fourcc_to_str(format));
> +
> +	/* Do some clean-up that we might have from a previous mode */
> +	ctrl &= ~CTRL_SHIFT_DIR(1);
> +	ctrl &= ~CTRL_SHIFT_NUM(0x3f);
> +	if (mxsfb->devdata->ipversion >= 4)
> +		writel(CTRL2_ODD_LINE_PATTERN(0x7) |
> +		       CTRL2_EVEN_LINE_PATTERN(0x7),
> +		       mxsfb->base + LCDC_V4_CTRL2 + REG_CLR);
>  
>  	switch (format) {
>  	case DRM_FORMAT_RGB565:
> -		dev_dbg(drm->dev, "Setting up RGB565 mode\n");
>  		ctrl |= CTRL_SET_WORD_LENGTH(0);
>  		ctrl1 |= CTRL1_SET_BYTE_PACKAGING(0xf);
>  		break;
> +	case DRM_FORMAT_RGBX8888:
> +	case DRM_FORMAT_RGBA8888:
> +		/* RGBX - > 0RGB */
> +		ctrl |= CTRL_SHIFT_DIR(1);
> +		ctrl |= CTRL_SHIFT_NUM(8);
> +		bgr_format = false;
> +		/* Fall through */
> +	case DRM_FORMAT_XBGR8888:
> +	case DRM_FORMAT_ABGR8888:
> +		if (bgr_format) {
> +			if (mxsfb->devdata->ipversion < 4)
> +				goto err;
> +			writel(CTRL2_ODD_LINE_PATTERN(0x5) |
> +			       CTRL2_EVEN_LINE_PATTERN(0x5),
> +			       mxsfb->base + LCDC_V4_CTRL2 + REG_SET);
> +		}
> +		/* Fall through */
>  	case DRM_FORMAT_XRGB8888:
> -		dev_dbg(drm->dev, "Setting up XRGB8888 mode\n");
> +	case DRM_FORMAT_ARGB8888:
>  		ctrl |= CTRL_SET_WORD_LENGTH(3);
>  		/* Do not use packed pixels = one pixel per word instead. */
>  		ctrl1 |= CTRL1_SET_BYTE_PACKAGING(0x7);
>  		break;
>  	default:
> -		dev_err(drm->dev, "Unhandled pixel format %08x\n", format);
> -		return -EINVAL;
> +		goto err;
>  	}
>  
> -	writel(ctrl1, mxsfb->base + LCDC_CTRL1);
> -	writel(ctrl, mxsfb->base + LCDC_CTRL);
> +	if (update) {
> +		writel(ctrl, mxsfb->base + LCDC_CTRL + REG_SET);
> +		writel(ctrl1, mxsfb->base + LCDC_CTRL1 + REG_SET);
> +	} else {
> +		writel(ctrl, mxsfb->base + LCDC_CTRL);
> +		writel(ctrl1, mxsfb->base + LCDC_CTRL1);
> +	}
>  
>  	return 0;
> +
> +err:
> +	DRM_DEV_ERROR(drm->dev, "Unhandled pixel format: %s\n",
> +		      fourcc_to_str(format));
> +	return -EINVAL;
>  }
>  
>  static void mxsfb_set_bus_fmt(struct mxsfb_drm_private *mxsfb)
> @@ -97,9 +155,7 @@ static void mxsfb_set_bus_fmt(struct mxsfb_drm_private *mxsfb)
>  	struct drm_crtc *crtc = &mxsfb->pipe.crtc;
>  	struct drm_device *drm = crtc->dev;
>  	u32 bus_format = MEDIA_BUS_FMT_RGB888_1X24;
> -	u32 reg;
> -
> -	reg = readl(mxsfb->base + LCDC_CTRL);
> +	u32 reg = 0;
>  
>  	if (mxsfb->connector->display_info.num_bus_formats)
>  		bus_format = mxsfb->connector->display_info.bus_formats[0];
> @@ -107,22 +163,21 @@ static void mxsfb_set_bus_fmt(struct mxsfb_drm_private *mxsfb)
>  	DRM_DEV_DEBUG_DRIVER(drm->dev,
>  		"Using bus_format: 0x%08X\n", bus_format);
>  
> -	reg &= ~CTRL_BUS_WIDTH_MASK;
>  	switch (bus_format) {
>  	case MEDIA_BUS_FMT_RGB565_1X16:
> -		reg |= CTRL_SET_BUS_WIDTH(STMLCDIF_16BIT);
> +		reg = CTRL_SET_BUS_WIDTH(STMLCDIF_16BIT);
>  		break;
>  	case MEDIA_BUS_FMT_RGB666_1X18:
> -		reg |= CTRL_SET_BUS_WIDTH(STMLCDIF_18BIT);
> +		reg = CTRL_SET_BUS_WIDTH(STMLCDIF_18BIT);
>  		break;
>  	case MEDIA_BUS_FMT_RGB888_1X24:
> -		reg |= CTRL_SET_BUS_WIDTH(STMLCDIF_24BIT);
> +		reg = CTRL_SET_BUS_WIDTH(STMLCDIF_24BIT);
>  		break;
>  	default:
>  		dev_err(drm->dev, "Unknown media bus format %d\n", bus_format);
>  		break;
>  	}
> -	writel(reg, mxsfb->base + LCDC_CTRL);
> +	writel(reg, mxsfb->base + LCDC_CTRL + REG_SET);
>  }
>  
>  static void mxsfb_enable_controller(struct mxsfb_drm_private *mxsfb)
> @@ -133,8 +188,9 @@ static void mxsfb_enable_controller(struct mxsfb_drm_private *mxsfb)
>  		clk_prepare_enable(mxsfb->clk_disp_axi);
>  	clk_prepare_enable(mxsfb->clk);
>  
> -	writel(CTRL2_OUTSTANDING_REQS__REQ_16,
> -		mxsfb->base + LCDC_V4_CTRL2 + REG_SET);
> +	if (mxsfb->devdata->ipversion >= 4)
> +		writel(CTRL2_OUTSTANDING_REQS(REQ_16),
> +			mxsfb->base + LCDC_V4_CTRL2 + REG_SET);
>  
>  	/* If it was disabled, re-enable the mode again */
>  	writel(CTRL_DOTCLK_MODE, mxsfb->base + LCDC_CTRL + REG_SET);
> @@ -152,6 +208,10 @@ static void mxsfb_disable_controller(struct mxsfb_drm_private *mxsfb)
>  {
>  	u32 reg;
>  
> +	if (mxsfb->devdata->ipversion >= 4)
> +		writel(CTRL2_OUTSTANDING_REQS(0x7),
> +			mxsfb->base + LCDC_V4_CTRL2 + REG_CLR);
> +
>  	writel(CTRL_RUN, mxsfb->base + LCDC_CTRL + REG_CLR);
>  
>  	/*
> @@ -239,7 +299,7 @@ static void mxsfb_crtc_mode_set_nofb(struct mxsfb_drm_private *mxsfb)
>  	/* Clear the FIFOs */
>  	writel(CTRL1_FIFO_CLEAR, mxsfb->base + LCDC_CTRL1 + REG_SET);
>  
> -	err = mxsfb_set_pixel_fmt(mxsfb);
> +	err = mxsfb_set_pixel_fmt(mxsfb, false);
>  	if (err)
>  		return;
>  
> @@ -322,7 +382,7 @@ void mxsfb_crtc_disable(struct mxsfb_drm_private *mxsfb)
>  }
>  
>  void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
> -			       struct drm_plane_state *state)
> +			       struct drm_plane_state *old_state)
>  {
>  	struct drm_simple_display_pipe *pipe = &mxsfb->pipe;
>  	struct drm_crtc *crtc = &pipe->crtc;
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> index c0b6198..76230d7 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> @@ -48,6 +48,22 @@ enum mxsfb_devtype {
>  	MXSFB_V4,
>  };
>  
> +/*
> + * When adding new formats, make sure to update the num_formats from
> + * mxsfb_devdata below.
> + */
> +static const uint32_t mxsfb_formats[] = {
> +	/* MXSFB_V3 */
> +	DRM_FORMAT_XRGB8888,
> +	DRM_FORMAT_ARGB8888,
> +	DRM_FORMAT_RGB565,
> +	/* MXSFB_V4 */
> +	DRM_FORMAT_XBGR8888,
> +	DRM_FORMAT_ABGR8888,
> +	DRM_FORMAT_RGBX8888,
> +	DRM_FORMAT_RGBA8888,
> +};
> +
>  static const struct mxsfb_devdata mxsfb_devdata[] = {
>  	[MXSFB_V3] = {
>  		.transfer_count	= LCDC_V3_TRANSFER_COUNT,
> @@ -57,6 +73,8 @@ static const struct mxsfb_devdata mxsfb_devdata[] = {
>  		.hs_wdth_mask	= 0xff,
>  		.hs_wdth_shift	= 24,
>  		.ipversion	= 3,
> +		.flags		= MXSFB_FLAG_NULL,
> +		.num_formats	= 3,
>  	},
>  	[MXSFB_V4] = {
>  		.transfer_count	= LCDC_V4_TRANSFER_COUNT,
> @@ -66,14 +84,11 @@ static const struct mxsfb_devdata mxsfb_devdata[] = {
>  		.hs_wdth_mask	= 0x3fff,
>  		.hs_wdth_shift	= 18,
>  		.ipversion	= 4,
> +		.flags		= MXSFB_FLAG_BUSFREQ,

This and MXSFB_FLAG_NULL never got defined (unless I overlooked it).
Cheers,
 -- Guido

> +		.num_formats	= ARRAY_SIZE(mxsfb_formats),
>  	},
>  };
>  
> -static const uint32_t mxsfb_formats[] = {
> -	DRM_FORMAT_XRGB8888,
> -	DRM_FORMAT_RGB565
> -};
> -
>  static struct mxsfb_drm_private *
>  drm_pipe_to_mxsfb_drm_private(struct drm_simple_display_pipe *pipe)
>  {
> @@ -250,7 +265,7 @@ static int mxsfb_load(struct drm_device *drm, unsigned long flags)
>  	}
>  
>  	ret = drm_simple_display_pipe_init(drm, &mxsfb->pipe, &mxsfb_funcs,
> -			mxsfb_formats, ARRAY_SIZE(mxsfb_formats), NULL,
> +			mxsfb_formats, mxsfb->devdata->num_formats, NULL,
>  			mxsfb->connector);
>  	if (ret < 0) {
>  		dev_err(drm->dev, "Cannot setup simple display pipe\n");
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.h b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
> index 71238ad..c15b4f9 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.h
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
> @@ -24,6 +24,8 @@ struct mxsfb_devdata {
>  	unsigned int	 hs_wdth_mask;
>  	unsigned int	 hs_wdth_shift;
>  	unsigned int	 ipversion;
> +	unsigned int	 flags;
> +	unsigned int	 num_formats;
>  };
>  
>  struct mxsfb_drm_private {
> @@ -51,6 +53,6 @@ void mxsfb_disable_axi_clk(struct mxsfb_drm_private *mxsfb);
>  void mxsfb_crtc_enable(struct mxsfb_drm_private *mxsfb);
>  void mxsfb_crtc_disable(struct mxsfb_drm_private *mxsfb);
>  void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
> -			       struct drm_plane_state *state);
> +			       struct drm_plane_state *old_state);
>  
>  #endif /* __MXSFB_DRV_H__ */
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_regs.h b/drivers/gpu/drm/mxsfb/mxsfb_regs.h
> index c5b5e40..4904fdd 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_regs.h
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_regs.h
> @@ -48,54 +48,76 @@
>  #define LCDC_AS_BUF			0x220
>  #define LCDC_AS_NEXT_BUF		0x230
>  
> -#define CTRL_SFTRST			(1 << 31)
> -#define CTRL_CLKGATE			(1 << 30)
> -#define CTRL_BYPASS_COUNT		(1 << 19)
> -#define CTRL_VSYNC_MODE			(1 << 18)
> -#define CTRL_DOTCLK_MODE		(1 << 17)
> -#define CTRL_DATA_SELECT		(1 << 16)
> -#define CTRL_SET_BUS_WIDTH(x)		(((x) & 0x3) << 10)
> -#define CTRL_GET_BUS_WIDTH(x)		(((x) >> 10) & 0x3)
> -#define CTRL_BUS_WIDTH_MASK		(0x3 << 10)
> -#define CTRL_SET_WORD_LENGTH(x)		(((x) & 0x3) << 8)
> -#define CTRL_GET_WORD_LENGTH(x)		(((x) >> 8) & 0x3)
> -#define CTRL_MASTER			(1 << 5)
> -#define CTRL_DF16			(1 << 3)
> -#define CTRL_DF18			(1 << 2)
> -#define CTRL_DF24			(1 << 1)
> -#define CTRL_RUN			(1 << 0)
> -
> -#define CTRL1_RECOVERY_ON_UNDERFLOW		(1 << 24)
> -#define CTRL1_FIFO_CLEAR		(1 << 21)
> -#define CTRL1_SET_BYTE_PACKAGING(x)	(((x) & 0xf) << 16)
> -#define CTRL1_GET_BYTE_PACKAGING(x)	(((x) >> 16) & 0xf)
> -#define CTRL1_CUR_FRAME_DONE_IRQ_EN	(1 << 13)
> -#define CTRL1_CUR_FRAME_DONE_IRQ	(1 << 9)
> -
> -#define CTRL2_OUTSTANDING_REQS__REQ_16		(4 << 21)
> +/* reg bit manipulation */
> +#define REG_MASK(e, s) (((1 << ((e) - (s) + 1)) - 1) << (s))
> +#define REG_PUT(x, e, s) (((x) << (s)) & REG_MASK(e, s))
> +#define REG_GET(x, e, s) (((x) & REG_MASK(e, s)) >> (s))
> +
> +#define SWIZZLE_LE		0 /* Little-Endian or No swap */
> +#define SWIZZLE_BE		1 /* Big-Endian or swap all */
> +#define SWIZZLE_HWD		2 /* Swap half-words */
> +#define SWIZZLE_HWD_BYTE	3 /* Swap bytes within each half-word */
> +
> +#define CTRL_SFTRST			BIT(31)
> +#define CTRL_CLKGATE			BIT(30)
> +#define CTRL_SHIFT_DIR(x)		REG_PUT((x), 26, 26)
> +#define CTRL_SHIFT_NUM(x)		REG_PUT((x), 25, 21)
> +#define CTRL_BYPASS_COUNT		BIT(19)
> +#define CTRL_VSYNC_MODE			BIT(18)
> +#define CTRL_DOTCLK_MODE		BIT(17)
> +#define CTRL_DATA_SELECT		BIT(16)
> +#define CTRL_INPUT_SWIZZLE(x)		REG_PUT((x), 15, 14)
> +#define CTRL_CSC_SWIZZLE(x)		REG_PUT((x), 13, 12)
> +#define CTRL_SET_BUS_WIDTH(x)		REG_PUT((x), 11, 10)
> +#define CTRL_GET_BUS_WIDTH(x)		REG_GET((x), 11, 10)
> +#define CTRL_BUS_WIDTH_MASK		REG_PUT((0x3), 11, 10)
> +#define CTRL_SET_WORD_LENGTH(x)		REG_PUT((x), 9, 8)
> +#define CTRL_GET_WORD_LENGTH(x)		REG_GET((x), 9, 8)
> +#define CTRL_MASTER			BIT(5)
> +#define CTRL_DF16			BIT(3)
> +#define CTRL_DF18			BIT(2)
> +#define CTRL_DF24			BIT(1)
> +#define CTRL_RUN			BIT(0)
> +
> +#define CTRL1_RECOVERY_ON_UNDERFLOW	BIT(24)
> +#define CTRL1_FIFO_CLEAR		BIT(21)
> +#define CTRL1_SET_BYTE_PACKAGING(x)	REG_PUT((x), 19, 16)
> +#define CTRL1_GET_BYTE_PACKAGING(x)	REG_GET((x), 19, 16)
> +#define CTRL1_CUR_FRAME_DONE_IRQ_EN	BIT(13)
> +#define CTRL1_CUR_FRAME_DONE_IRQ	BIT(9)
> +
> +#define REQ_1	0
> +#define REQ_2	1
> +#define REQ_4	2
> +#define REQ_8	3
> +#define REQ_16	4
> +
> +#define CTRL2_OUTSTANDING_REQS(x)	REG_PUT((x), 23, 21)
> +#define CTRL2_ODD_LINE_PATTERN(x)	REG_PUT((x), 18, 16)
> +#define CTRL2_EVEN_LINE_PATTERN(x)	REG_PUT((x), 14, 12)
>  
>  #define TRANSFER_COUNT_SET_VCOUNT(x)	(((x) & 0xffff) << 16)
>  #define TRANSFER_COUNT_GET_VCOUNT(x)	(((x) >> 16) & 0xffff)
>  #define TRANSFER_COUNT_SET_HCOUNT(x)	((x) & 0xffff)
>  #define TRANSFER_COUNT_GET_HCOUNT(x)	((x) & 0xffff)
>  
> -#define VDCTRL0_ENABLE_PRESENT		(1 << 28)
> -#define VDCTRL0_VSYNC_ACT_HIGH		(1 << 27)
> -#define VDCTRL0_HSYNC_ACT_HIGH		(1 << 26)
> -#define VDCTRL0_DOTCLK_ACT_FALLING	(1 << 25)
> -#define VDCTRL0_ENABLE_ACT_HIGH		(1 << 24)
> -#define VDCTRL0_VSYNC_PERIOD_UNIT	(1 << 21)
> -#define VDCTRL0_VSYNC_PULSE_WIDTH_UNIT	(1 << 20)
> -#define VDCTRL0_HALF_LINE		(1 << 19)
> -#define VDCTRL0_HALF_LINE_MODE		(1 << 18)
> +#define VDCTRL0_ENABLE_PRESENT		BIT(28)
> +#define VDCTRL0_VSYNC_ACT_HIGH		BIT(27)
> +#define VDCTRL0_HSYNC_ACT_HIGH		BIT(26)
> +#define VDCTRL0_DOTCLK_ACT_FALLING	BIT(25)
> +#define VDCTRL0_ENABLE_ACT_HIGH		BIT(24)
> +#define VDCTRL0_VSYNC_PERIOD_UNIT	BIT(21)
> +#define VDCTRL0_VSYNC_PULSE_WIDTH_UNIT	BIT(20)
> +#define VDCTRL0_HALF_LINE		BIT(19)
> +#define VDCTRL0_HALF_LINE_MODE		BIT(18)
>  #define VDCTRL0_SET_VSYNC_PULSE_WIDTH(x) ((x) & 0x3ffff)
>  #define VDCTRL0_GET_VSYNC_PULSE_WIDTH(x) ((x) & 0x3ffff)
>  
>  #define VDCTRL2_SET_HSYNC_PERIOD(x)	((x) & 0x3ffff)
>  #define VDCTRL2_GET_HSYNC_PERIOD(x)	((x) & 0x3ffff)
>  
> -#define VDCTRL3_MUX_SYNC_SIGNALS	(1 << 29)
> -#define VDCTRL3_VSYNC_ONLY		(1 << 28)
> +#define VDCTRL3_MUX_SYNC_SIGNALS	BIT(29)
> +#define VDCTRL3_VSYNC_ONLY		BIT(28)
>  #define SET_HOR_WAIT_CNT(x)		(((x) & 0xfff) << 16)
>  #define GET_HOR_WAIT_CNT(x)		(((x) >> 16) & 0xfff)
>  #define SET_VERT_WAIT_CNT(x)		((x) & 0xffff)
> @@ -103,7 +125,7 @@
>  
>  #define VDCTRL4_SET_DOTCLK_DLY(x)	(((x) & 0x7) << 29) /* v4 only */
>  #define VDCTRL4_GET_DOTCLK_DLY(x)	(((x) >> 29) & 0x7) /* v4 only */
> -#define VDCTRL4_SYNC_SIGNALS_ON		(1 << 18)
> +#define VDCTRL4_SYNC_SIGNALS_ON		BIT(18)
>  #define SET_DOTCLK_H_VALID_DATA_CNT(x)	((x) & 0x3ffff)
>  
>  #define DEBUG0_HSYNC			(1 < 26)
> @@ -124,7 +146,7 @@
>  #define STMLCDIF_18BIT 2 /* pixel data bus to the display is of 18 bit width */
>  #define STMLCDIF_24BIT 3 /* pixel data bus to the display is of 24 bit width */
>  
> -#define MXSFB_SYNC_DATA_ENABLE_HIGH_ACT	(1 << 6)
> -#define MXSFB_SYNC_DOTCLK_FALLING_ACT	(1 << 7) /* negative edge sampling */
> +#define MXSFB_SYNC_DATA_ENABLE_HIGH_ACT	BIT(6)
> +#define MXSFB_SYNC_DOTCLK_FALLING_ACT	BIT(7) /* negative edge sampling */
>  
>  #endif /* __MXSFB_REGS_H__ */
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
