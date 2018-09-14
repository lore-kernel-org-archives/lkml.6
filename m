Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4911DECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CA920833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rGB/pED8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2CA920833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeINPji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:39:38 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:34314 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeINPji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:39:38 -0400
Received: from avalon.localnet (unknown [IPv6:2a02:a03f:44f6:3500:d929:375b:d608:66c7])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5703ACE;
        Fri, 14 Sep 2018 12:25:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536920746;
        bh=vFT4IRnmKU2yD4bACmQeGvBUaLjOYi48CmHCgqcQT/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rGB/pED8aDKrc/hx9IuqqHdCq+q5uTomMgX9OCyILE43GNAf3NIgIm3lYRxcCf448
         zHmQW/ycaOn1IPJene/4xuNqM+9AmmXE+VqCEHuJIiM33H76HmhDL1ARCeRZAf3kKz
         W5J3AXm0PdM8qjj7hVeFfEDWiozm+wFH7pScIkKc=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] media: vsp1: Correct the pitch on multiplanar formats
Date:   Fri, 14 Sep 2018 13:25:59 +0300
Message-ID: <4407219.HP1UPh24hA@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180831144044.31713-3-kieran.bingham+renesas@ideasonboard.com>
References: <20180831144044.31713-1-kieran.bingham+renesas@ideasonboard.com> <20180831144044.31713-3-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Friday, 31 August 2018 17:40:40 EEST Kieran Bingham wrote:
> DRM pipelines now support tri-planar as well as packed formats with
> YCbCr, however the pitch calculation was not updated to support this.
> 
> Correct this by adjusting the bytesperline accordingly when 3 planes are
> used.
> 
> Fixes: 7863ac504bc5 ("drm: rcar-du: Add tri-planar memory formats support")
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

I already have a similar patch from Matsuoka-san in my tree, please see 
https://patchwork.kernel.org/patch/10425565/. I'll update it with the fixes 
tag.

> ---
>  drivers/media/platform/vsp1/vsp1_drm.c | 10 ++++++++++
>  include/media/vsp1.h                   |  2 +-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/vsp1/vsp1_drm.c
> b/drivers/media/platform/vsp1/vsp1_drm.c index b9c0f695d002..b9afd98f6867
> 100644
> --- a/drivers/media/platform/vsp1/vsp1_drm.c
> +++ b/drivers/media/platform/vsp1/vsp1_drm.c
> @@ -814,6 +814,16 @@ int vsp1_du_atomic_update(struct device *dev, unsigned
> int pipe_index, rpf->format.num_planes = fmtinfo->planes;
>  	rpf->format.plane_fmt[0].bytesperline = cfg->pitch;
>  	rpf->format.plane_fmt[1].bytesperline = cfg->pitch;
> +
> +	/*
> +	 * Packed YUV formats are subsampled, but the packing of two components
> +	 * into a single plane compensates for this leaving the bytesperline
> +	 * to be the correct value. For multiplanar formats we must adjust the
> +	 * pitch accordingly.
> +	 */
> +	if (fmtinfo->planes == 3)
> +		rpf->format.plane_fmt[1].bytesperline /= fmtinfo->hsub;
> +
>  	rpf->alpha = cfg->alpha;
> 
>  	rpf->mem.addr[0] = cfg->mem[0];
> diff --git a/include/media/vsp1.h b/include/media/vsp1.h
> index 3093b9cb9067..0ce19b595cc7 100644
> --- a/include/media/vsp1.h
> +++ b/include/media/vsp1.h
> @@ -46,7 +46,7 @@ int vsp1_du_setup_lif(struct device *dev, unsigned int
> pipe_index, /**
>   * struct vsp1_du_atomic_config - VSP atomic configuration parameters
>   * @pixelformat: plane pixel format (V4L2 4CC)
> - * @pitch: line pitch in bytes, for all planes
> + * @pitch: line pitch in bytes

Should I update the above-mentioned patch with this as well ? How about 
phrasing it as "line pitch in bytes for the first plane" ?

>   * @mem: DMA memory address for each plane of the frame buffer
>   * @src: source rectangle in the frame buffer (integer coordinates)
>   * @dst: destination rectangle on the display (integer coordinates)

-- 
Regards,

Laurent Pinchart



