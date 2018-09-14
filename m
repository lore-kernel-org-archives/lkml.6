Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79DDECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80B72146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="b0ao/kpm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80B72146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbeINPgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:36:42 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:34274 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbeINPgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:36:42 -0400
Received: from avalon.localnet (unknown [IPv6:2a02:a03f:44f6:3500:d929:375b:d608:66c7])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E8D73CE;
        Fri, 14 Sep 2018 12:22:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536920571;
        bh=UdmXSn/cn3Bq5WHqTQOIJ1ZnyGpkd1dqMoobhUmnu08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b0ao/kpmOHtKg4Czj1naDMmQcuvUO7G+OTFOz+iA0UTb6S2z6SVeZ5bp9AeWtmN4M
         Lp+WcYwVofGd5A4DWOwEW/INtKlkOxCECnMapIn7EhqN3ezOsV7MFvNPOq05F9CPx6
         FGiwAjV46mzeyiPDGDy/ZQUiQZZP/9FccbTrRZV4=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] media: vsp1: Remove artificial pixel limitation
Date:   Fri, 14 Sep 2018 13:23:04 +0300
Message-ID: <3874771.GdJIGdZf8f@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180831144044.31713-2-kieran.bingham+renesas@ideasonboard.com>
References: <20180831144044.31713-1-kieran.bingham+renesas@ideasonboard.com> <20180831144044.31713-2-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Friday, 31 August 2018 17:40:39 EEST Kieran Bingham wrote:
> The VSP1 has a minimum width and height of a single pixel, with the
> exception of pixel formats with sub-sampling.
> 
> Remove the artificial minimum width and minimum height limitation, and
> instead clamp the minimum dimensions based upon the sub-sampling
> parameter of that dimension.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

and applied to my tree.

> ---
>  drivers/media/platform/vsp1/vsp1_video.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/platform/vsp1/vsp1_video.c
> b/drivers/media/platform/vsp1/vsp1_video.c index 81d47a09d7bc..e78eadd0295b
> 100644
> --- a/drivers/media/platform/vsp1/vsp1_video.c
> +++ b/drivers/media/platform/vsp1/vsp1_video.c
> @@ -38,9 +38,7 @@
>  #define VSP1_VIDEO_DEF_WIDTH		1024
>  #define VSP1_VIDEO_DEF_HEIGHT		768
> 
> -#define VSP1_VIDEO_MIN_WIDTH		2U
>  #define VSP1_VIDEO_MAX_WIDTH		8190U
> -#define VSP1_VIDEO_MIN_HEIGHT		2U
>  #define VSP1_VIDEO_MAX_HEIGHT		8190U
> 
>  /*
> ---------------------------------------------------------------------------
> -- @@ -136,9 +134,8 @@ static int __vsp1_video_try_format(struct vsp1_video
> *video, height = round_down(height, info->vsub);
> 
>  	/* Clamp the width and height. */
> -	pix->width = clamp(width, VSP1_VIDEO_MIN_WIDTH, VSP1_VIDEO_MAX_WIDTH);
> -	pix->height = clamp(height, VSP1_VIDEO_MIN_HEIGHT,
> -			    VSP1_VIDEO_MAX_HEIGHT);
> +	pix->width = clamp(width, info->hsub, VSP1_VIDEO_MAX_WIDTH);
> +	pix->height = clamp(height, info->vsub, VSP1_VIDEO_MAX_HEIGHT);
> 
>  	/*
>  	 * Compute and clamp the stride and image size. While not documented in

-- 
Regards,

Laurent Pinchart



