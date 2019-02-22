Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E62FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0842075A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="hBej+JmC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfBVM2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 07:28:21 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:34288 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfBVM2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 07:28:21 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CD14B2D2;
        Fri, 22 Feb 2019 13:28:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1550838499;
        bh=wguJco89rPqTnWNrwjE4CVsHP24lOz0h040ylbg16fk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hBej+JmCE3vKg+zR+jJyRp1K54w3NKsSgPA8e0Wtjd0Z2d8yeP/QNQzxe4PB2FCw2
         dBuC94eGhmThQuwh9Z/xrnjHAVyzQcKEfB15EdaloyUqghiVTToHCG/LBQEbWluuRs
         7YvF/kIeG8BqZK/4FmLduL5WETzs/F2FrxZw+4fw=
Date:   Fri, 22 Feb 2019 14:28:14 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jonas Karlman <jonas@kwiboo.se>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm: bridge: dw-hdmi: Fix overflow workaround for
 Rockchip SoCs
Message-ID: <20190222122814.GW3522@pendragon.ideasonboard.com>
References: <AM3PR03MB0966818FAAAE6192FF4ED11AAC7D0@AM3PR03MB0966.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM3PR03MB0966818FAAAE6192FF4ED11AAC7D0@AM3PR03MB0966.eurprd03.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonas,

Thank you for the patch.

On Wed, Feb 20, 2019 at 07:52:31AM +0000, Jonas Karlman wrote:
> The Rockchip RK3288 SoC (v2.00a) and RK3328/RK3399 SoCs (v2.11a) have
> also been identified as needing this workaround with a single iteration.
> 
> Fixes: be41fc55f1aa ("drm: bridge: dw-hdmi: Handle overflow workaround based on device version")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

This makes me wonder if we have any device at all that doesn't need the
workaround... The HDMI encoder in R-Car SoCs doesn't seem to require it,
but it reports the same version number as on other SoCs that require the
workaround, and enabling it doesn't seem to affect R-Car adversely.
Should we thus enable it unconditionally ? Input from Synopsys would be
useful.

> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 64c3cf027518..14223c0ee784 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -1655,6 +1655,8 @@ static void dw_hdmi_clear_overflow(struct dw_hdmi *hdmi)
>  	 * iteration for others.
>  	 * The Amlogic Meson GX SoCs (v2.01a) have been identified as needing
>  	 * the workaround with a single iteration.
> +	 * The Rockchip RK3288 SoC (v2.00a) and RK3328/RK3399 SoCs (v2.11a) have
> +	 * been identified as needing the workaround with a single iteration.
>  	 */
>  
>  	switch (hdmi->version) {
> @@ -1663,7 +1665,9 @@ static void dw_hdmi_clear_overflow(struct dw_hdmi *hdmi)
>  		break;
>  	case 0x131a:
>  	case 0x132a:
> +	case 0x200a:
>  	case 0x201a:
> +	case 0x211a:
>  	case 0x212a:
>  		count = 1;
>  		break;

-- 
Regards,

Laurent Pinchart
