Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4252C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE6D20652
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE6D20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbeJEQrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 12:47:02 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:32931 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbeJEQrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 12:47:02 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1g8MjB-0005fs-Rt; Fri, 05 Oct 2018 11:48:57 +0200
Message-ID: <1538732937.3545.8.camel@pengutronix.de>
Subject: Re: [PATCH v4 03/11] gpu: ipu-v3: Add planar support to interlaced
 scan
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
Date:   Fri, 05 Oct 2018 11:48:57 +0200
In-Reply-To: <20181004185401.15751-4-slongerbeam@gmail.com>
References: <20181004185401.15751-1-slongerbeam@gmail.com>
         <20181004185401.15751-4-slongerbeam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-04 at 11:53 -0700, Steve Longerbeam wrote:
> To support interlaced scan with planar formats, cpmem SLUV must
> be programmed with the correct chroma line stride. For full and
> partial planar 4:2:2 (YUV422P, NV16), chroma line stride must
> be doubled. For full and partial planar 4:2:0 (YUV420, YVU420, NV12),
> chroma line stride must _not_ be doubled, since a single chroma line
> is shared by two luma lines.
> 
> Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
> ---
>  drivers/gpu/ipu-v3/ipu-cpmem.c              | 26 +++++++++++++++++++--
>  drivers/staging/media/imx/imx-ic-prpencvf.c |  3 ++-
>  drivers/staging/media/imx/imx-media-csi.c   |  3 ++-
>  include/video/imx-ipu-v3.h                  |  3 ++-
>  4 files changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/ipu-v3/ipu-cpmem.c b/drivers/gpu/ipu-v3/ipu-cpmem.c
> index a9d2501500a1..d41df8034c5b 100644
> --- a/drivers/gpu/ipu-v3/ipu-cpmem.c
> +++ b/drivers/gpu/ipu-v3/ipu-cpmem.c
> @@ -273,9 +273,10 @@ void ipu_cpmem_set_uv_offset(struct ipuv3_channel *ch, u32 u_off, u32 v_off)
>  }
>  EXPORT_SYMBOL_GPL(ipu_cpmem_set_uv_offset);
>  
> -void ipu_cpmem_interlaced_scan(struct ipuv3_channel *ch, int stride)
> +void ipu_cpmem_interlaced_scan(struct ipuv3_channel *ch, int stride,
> +			       u32 pixelformat)
>  {
> -	u32 ilo, sly;
> +	u32 ilo, sly, sluv;
>  
>  	if (stride < 0) {
>  		stride = -stride;
> @@ -286,9 +287,30 @@ void ipu_cpmem_interlaced_scan(struct ipuv3_channel *ch, int stride)
>  
>  	sly = (stride * 2) - 1;
>  
> +	switch (pixelformat) {
> +	case V4L2_PIX_FMT_YUV420:
> +	case V4L2_PIX_FMT_YVU420:
> +		sluv = stride / 2 - 1;
> +		break;
> +	case V4L2_PIX_FMT_NV12:
> +		sluv = stride - 1;
> +		break;
> +	case V4L2_PIX_FMT_YUV422P:
> +		sluv = stride - 1;
> +		break;
> +	case V4L2_PIX_FMT_NV16:
> +		sluv = stride * 2 - 1;
> +		break;
> +	default:
> +		sluv = 0;
> +		break;
> +	}
> +
>  	ipu_ch_param_write_field(ch, IPU_FIELD_SO, 1);
>  	ipu_ch_param_write_field(ch, IPU_FIELD_ILO, ilo);
>  	ipu_ch_param_write_field(ch, IPU_FIELD_SLY, sly);
> +	if (sluv)
> +		ipu_ch_param_write_field(ch, IPU_FIELD_SLUV, sluv);
>  };
>  EXPORT_SYMBOL_GPL(ipu_cpmem_interlaced_scan);
[...]

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

and

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

to be merged with the rest of the series via the media tree. I'll take
care not to introduce nontrivial conflicts in imx-drm.

regards
Philipp
