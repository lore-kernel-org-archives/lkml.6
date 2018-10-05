Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E82C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D07E20652
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D07E20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbeJEQmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 12:42:46 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40055 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbeJEQmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 12:42:46 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1g8Mf4-0004ez-Mr; Fri, 05 Oct 2018 11:44:42 +0200
Message-ID: <1538732679.3545.5.camel@pengutronix.de>
Subject: Re: [PATCH v4 02/11] gpu: ipu-csi: Swap fields according to
 input/output field types
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Steve Longerbeam <slongerbeam@gmail.com>,
        linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "open list:DRM DRIVERS FOR FREESCALE IMX" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>
Date:   Fri, 05 Oct 2018 11:44:39 +0200
In-Reply-To: <20181004185401.15751-3-slongerbeam@gmail.com>
References: <20181004185401.15751-1-slongerbeam@gmail.com>
         <20181004185401.15751-3-slongerbeam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Thu, 2018-10-04 at 11:53 -0700, Steve Longerbeam wrote:
[...]
>  int ipu_csi_init_interface(struct ipu_csi *csi,
>  			   struct v4l2_mbus_config *mbus_cfg,
> -			   struct v4l2_mbus_framefmt *mbus_fmt)
> +			   struct v4l2_mbus_framefmt *infmt,
> +			   struct v4l2_mbus_framefmt *outfmt)
>  {
[...] 
> +		std = V4L2_STD_UNKNOWN;
> +		if (width == 720) {
> +			switch (height) {
> +			case 480:
> +				std = V4L2_STD_NTSC;
> +				break;
> +			case 576:
> +				std = V4L2_STD_PAL;
> +				break;
> +			default:
> +				break;
> +			}
> +		}
> +
> +		if (std == V4L2_STD_UNKNOWN) {
>  			dev_err(csi->ipu->dev,
[...]
> +				"Unsupported interlaced video mode\n");
> +			ret = -EINVAL;
> +			goto out_unlock;
>  		}
[...]
> +
> +		/* framelines for NTSC / PAL */
> +		height = (std & V4L2_STD_525_60) ? 525 : 625;

I think this is a bit convoluted. Instead of initializing std, then
possibly changing it, and then comparing to the inital value, and then
checking it again to determine the new height, why not just:

		if (width == 720 && height == 480) {
			std = V4L2_STD_NTSC;
			height = 525;
		} else if (width == 720 && height == 576) {
			std = V4L2_STD_PAL;
			height = 625;
		} else {
			dev_err(csi->ipu->dev,
				"Unsupported interlaced video mode\n");
			ret = -EINVAL;
			goto out_unlock;
		}

?

>  		break;
>  	case IPU_CSI_CLK_MODE_CCIR1120_PROGRESSIVE_DDR:
>  	case IPU_CSI_CLK_MODE_CCIR1120_PROGRESSIVE_SDR:
> @@ -476,9 +529,10 @@ int ipu_csi_init_interface(struct ipu_csi *csi,
>  	dev_dbg(csi->ipu->dev, "CSI_ACT_FRM_SIZE = 0x%08X\n",
>  		ipu_csi_read(csi, CSI_ACT_FRM_SIZE));
>  
> +out_unlock:
>  	spin_unlock_irqrestore(&csi->lock, flags);
>  
> -	return 0;
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(ipu_csi_init_interface);
>  
> diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
> index 4acdd7ae612b..ad66f007d395 100644
> --- a/drivers/staging/media/imx/imx-media-csi.c
> +++ b/drivers/staging/media/imx/imx-media-csi.c
> @@ -666,7 +666,6 @@ static int csi_setup(struct csi_priv *priv)
>  	struct v4l2_mbus_framefmt *infmt, *outfmt;
>  	const struct imx_media_pixfmt *incc;
>  	struct v4l2_mbus_config mbus_cfg;
> -	struct v4l2_mbus_framefmt if_fmt;
>  	struct v4l2_rect crop;
>  
>  	infmt = &priv->format_mbus[CSI_SINK_PAD];
> @@ -679,22 +678,14 @@ static int csi_setup(struct csi_priv *priv)
>  		priv->upstream_ep.bus.parallel.flags :
>  		priv->upstream_ep.bus.mipi_csi2.flags;
>  
> -	/*
> -	 * we need to pass input frame to CSI interface, but
> -	 * with translated field type from output format
> -	 */
> -	if_fmt = *infmt;
> -	if_fmt.field = outfmt->field;
>  	crop = priv->crop;
>  
>  	/*
>  	 * if cycles is set, we need to handle this over multiple cycles as
>  	 * generic/bayer data
>  	 */
> -	if (is_parallel_bus(&priv->upstream_ep) && incc->cycles) {
> -		if_fmt.width *= incc->cycles;

If the input format width passed to ipu_csi_init_interface is not
multiplied by the number of cycles per pixel anymore, width in the
CSI_SENS_FRM_SIZE register will be set to the unmultiplied value from
infmt.
This breaks 779680e2e793 ("media: imx: add support for RGB565_2X8 on
parallel bus").

> +	if (is_parallel_bus(&priv->upstream_ep) && incc->cycles)
>  		crop.width *= incc->cycles;
> -	}
>  
>  	ipu_csi_set_window(priv->csi, &crop);
>  
> @@ -702,7 +693,7 @@ static int csi_setup(struct csi_priv *priv)
>  			     priv->crop.width == 2 * priv->compose.width,
>  			     priv->crop.height == 2 * priv->compose.height);
>  
> -	ipu_csi_init_interface(priv->csi, &mbus_cfg, &if_fmt);
> +	ipu_csi_init_interface(priv->csi, &mbus_cfg, infmt, outfmt);

regards
Philipp
