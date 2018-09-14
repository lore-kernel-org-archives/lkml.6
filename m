Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF45ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D46E20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="YONpYCu/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D46E20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeINQay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 12:30:54 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:34836 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbeINQay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 12:30:54 -0400
Received: from avalon.localnet (unknown [IPv6:2a02:a03f:44f6:3500:d929:375b:d608:66c7])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2BC88CE;
        Fri, 14 Sep 2018 13:16:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536923812;
        bh=3KBlaKj9KAfCOQsumtuRy35b7+yYeKL/TPjIHIiOvxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YONpYCu/pb/6g71GWoz6Rkfo6VAa0ZGj378kVhlCcDi+qKmdq1LCakiaMQrK1Z1Mc
         Hw2HgEXFZvqsfPhmw/yQk+ShRvUMNAnyrMd4zfanN1Ul9lnHeyriDT5YKTcJO53VsJ
         J7pW8e7W3Fv9hGhmfAUyYcWHZyLq7slzI4zNLm9E=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Subject: Re: [PATCH 2/3] drm: rcar-du: Add pixel format support
Date:   Fri, 14 Sep 2018 14:17:06 +0300
Message-ID: <3865052.iN5JJav0kF@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180831181259.29529-3-kieran.bingham+renesas@ideasonboard.com>
References: <20180831181259.29529-1-kieran.bingham+renesas@ideasonboard.com> <20180831181259.29529-3-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

On Friday, 31 August 2018 21:12:58 EEST Kieran Bingham wrote:
> From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> 
> This patch supports pixel format of RGB332, ARGB4444, XRGB4444,
> BGR888, RGB888, BGRA8888, BGRX8888 and YVYU.
> VYUY pixel format is not supported by H/W specification.

Should VYUY be removed from rcar_du_vsp.c ? This can be done in a separate 
patch.

> Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> 
> ---
> 
> This patch does not remove existing support for multiplanar YVUY, even
> though the hardware does not explicitly provide it, because we support
> it through software by swapping the plane buffers.
> 
>  drivers/gpu/drm/rcar-du/rcar_du_kms.c | 32 +++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> b/drivers/gpu/drm/rcar-du/rcar_du_kms.c index 7c7aff8cdf77..d1bd174ec893
> 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> @@ -124,6 +124,38 @@ static const struct rcar_du_format_info
> rcar_du_format_infos[] = { .fourcc = DRM_FORMAT_YVU444,
>  		.bpp = 24,
>  		.planes = 3,
> +	}, {
> +		.fourcc = DRM_FORMAT_RGB332,
> +		.bpp = 8,
> +		.planes = 1,
> +	}, {
> +		.fourcc = DRM_FORMAT_ARGB4444,
> +		.bpp = 16,
> +		.planes = 1,
> +	}, {
> +		.fourcc = DRM_FORMAT_XRGB4444,
> +		.bpp = 16,
> +		.planes = 1,
> +	}, {
> +		.fourcc = DRM_FORMAT_BGR888,
> +		.bpp = 24,
> +		.planes = 1,
> +	}, {
> +		.fourcc = DRM_FORMAT_RGB888,
> +		.bpp = 24,
> +		.planes = 1,
> +	}, {
> +		.fourcc = DRM_FORMAT_BGRA8888,
> +		.bpp = 32,
> +		.planes = 1,
> +	}, {
> +		.fourcc = DRM_FORMAT_BGRX8888,
> +		.bpp = 32,
> +		.planes = 1,
> +	}, {
> +		.fourcc = DRM_FORMAT_YVYU,
> +		.bpp = 16,
> +		.planes = 1,
>  	},
>  };


-- 
Regards,

Laurent Pinchart



