Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3D7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF6222504
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF6222504
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbeKMBad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:30:33 -0500
Received: from gloria.sntech.de ([185.11.138.130]:49118 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728416AbeKMBad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:30:33 -0500
Received: from we0660.dip.tu-dresden.de ([141.76.178.148] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gMEGX-0005IU-Ni; Mon, 12 Nov 2018 16:36:41 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        amd-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Mali DP Maintainers <malidp@foss.arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/atomic: Create and use __drm_atomic_helper_crtc_reset() everywhere
Date:   Mon, 12 Nov 2018 16:36:41 +0100
Message-ID: <2475529.N6HtQ5V54z@phil>
In-Reply-To: <20181112150114.18395-2-maarten.lankhorst@linux.intel.com>
References: <20181112150114.18395-1-maarten.lankhorst@linux.intel.com> <20181112150114.18395-2-maarten.lankhorst@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 12. November 2018, 16:01:14 CET schrieb Maarten Lankhorst:
> We already have __drm_atomic_helper_connector_reset() and
> __drm_atomic_helper_plane_reset(), extend this to crtc as well.
> 
> Most drivers already have a gpu reset hook, correct it.
> Nouveau already implemented its own __drm_atomic_helper_crtc_reset(),
> convert it to the common one.
> 
> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>


> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index fb70fb486fbf..d2d5aa676084 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -1071,13 +1071,14 @@ static void vop_crtc_destroy(struct drm_crtc *crtc)
>  
>  static void vop_crtc_reset(struct drm_crtc *crtc)
>  {
> +	struct rockchip_crtc_state *crtc_state =
> +		kzalloc(sizeof(*crtc_state), GFP_KERNEL);
> +
>  	if (crtc->state)
>  		__drm_atomic_helper_crtc_destroy_state(crtc->state);
>  	kfree(crtc->state);
>  
> -	crtc->state = kzalloc(sizeof(struct rockchip_crtc_state), GFP_KERNEL);
> -	if (crtc->state)
> -		crtc->state->crtc = crtc;
> +	__drm_atomic_helper_crtc_reset(crtc, &crtc_state->base);
>  }
>  
>  static struct drm_crtc_state *vop_crtc_duplicate_state(struct drm_crtc *crtc)

for the Rockchip-part
Acked-by: Heiko Stuebner <heiko@sntech.de>


