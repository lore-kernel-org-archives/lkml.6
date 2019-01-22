Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6483EC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34ECB20866
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="tZuESgu2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfAVUd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:33:29 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:54360 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfAVUd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:33:29 -0500
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 58990575;
        Tue, 22 Jan 2019 21:33:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1548189206;
        bh=q407BlW7MIIPo4EcMlehb/+GEfg+zEFavV+DskVv9RY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tZuESgu2ElSrtJ/U/mvBC7fAkCKOwjhG9SOOe09ELnwFtSti9ciGObU2Hiq3CRH14
         Qqhcs77NdkM7DPN1X3TQllRvejZ1ZxVikQzB+2hUSWAoLtOn3NBrWqB7phOL4PmfOr
         CjrjhpQ6rnzHRiLFH9PdTK+EuHEHyPc/1eVs6JSQ=
Date:   Tue, 22 Jan 2019 22:33:25 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: rcar-du: Fix build error
Message-ID: <20190122203325.GC3264@pendragon.ideasonboard.com>
References: <20190118172125.32504-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190118172125.32504-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

Thank you for the patch.

On Fri, Jan 18, 2019 at 10:21:25AM -0700, Nathan Chancellor wrote:
> On arm{32,64} allyesconfig builds:
> 
> drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c:40:1: error: incomplete result type 'enum drm_mode_status' in function definition
> drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c:47:10: error: incomplete definition of type 'struct drm_display_mode'
> drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c:48:10: error: use of undeclared identifier 'MODE_CLOCK_HIGH'
> drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c:50:9: error: use of undeclared identifier 'MODE_OK'
> 
> After the removal of drmP.h from this file and its removal from
> bridge/dw_hdmi.h, these types are not defined anymore, as they
> were implicitly coming into that file through drm_crtc.h.
> 
> Fixes: 428747ae5cca ("drm: remove include of drmP.h from bridge/dw_hdmi.h")
> Fixes: 9a47db8e7a9d ("drm: rcar-du: Remove inclusion of drmP.h")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

This was included by Dave in merge commit f164a94c2c87 ("Merge tag
'drm-misc-next-2019-01-16' of git://anongit.freedesktop.org/drm/drm-misc
into drm-next").

> ---
>  drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c b/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c
> index 0fb25113f19c..452461dc96f2 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c
> @@ -12,6 +12,7 @@
>  #include <linux/platform_device.h>
>  
>  #include <drm/bridge/dw_hdmi.h>
> +#include <drm/drm_modes.h>
>  
>  #define RCAR_HDMI_PHY_OPMODE_PLLCFG	0x06	/* Mode of operation and PLL dividers */
>  #define RCAR_HDMI_PHY_PLLCURRGMPCTRL	0x10	/* PLL current and Gmp (conductance) */

-- 
Regards,

Laurent Pinchart
