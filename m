Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237D9ECDFAE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB48F2064E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="IeZXHXqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB48F2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbeJJA6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:58:52 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:36428 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJJA6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:58:51 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1E3266F8;
        Tue,  9 Oct 2018 19:40:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1539106844;
        bh=VaG2hzl7hXzfD1aslo6f+Cf2Bte1UE5uoDplM2gglOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IeZXHXqa9KrassG2emkimTAGb6nnZLv446Vip+TusQSUgjJON+gbxHEvu+Ma81EEJ
         MhRt6K1WACIcnrUTJnkhUk5h3CU2KwtdA5kAiPaeC81lWhjf9gHC3oZFXdUV1OqNs2
         YG+eRNlD4jt5M+jQiEeRUxLzphpOfaZYx5W+Lrzo=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
        sboyd@kernel.org, airlied@linux.ie, architt@codeaurora.org,
        a.hajda@samsung.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 15/29] drm/bridge/synopsys: dw-hdmi: Enable workaround for v2.12a
Date:   Tue, 09 Oct 2018 20:40:44 +0300
Message-ID: <3616158.EzHeIcd69b@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20181007093905.11253-16-jernej.skrabec@siol.net>
References: <20181007093905.11253-1-jernej.skrabec@siol.net> <20181007093905.11253-16-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

Thank you for the patch.

On Sunday, 7 October 2018 12:38:51 EEST Jernej Skrabec wrote:
> It turns out that even new DW HDMI controllers exhibits same magenta
> line issues as older versions.
> 
> Enable workaround for v2.12a.

This doesn't affect the platforms I maintain, so I can't really test this, but 
I'm wondering whether there could be other platforms using a v2.12a DW HDMI 
that wouldn't need the workaround.

My platforms use a previous version, namely v2.01a. The workaround for that 
version has been enabled by

commit 9c305eb442f3b371fc722ade827bbf673514123e
Author: Neil Armstrong <narmstrong@baylibre.com>
Date:   Fri Feb 23 12:44:37 2018 +0100

    drm: bridge: dw-hdmi: Fix overflow workaround for Amlogic Meson GX SoCs

I haven't paid too much attention to the patch back then, and have now double-
checked the HDMI output on R-Car Gen3. Enabling the workaround doesn't cause 
any regression, and reverting the commit doesn't cause any issue either. I 
thus wonder whether we shouldn't enable the workaround with count = 1 in the 
default case instead of adding new IP core versions to the list. It would be 
nice if someone from Synopsys could comment on this.

> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
> 5971976284bf..df1c7a2d6961 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -1664,6 +1664,7 @@ static void dw_hdmi_clear_overflow(struct dw_hdmi
> *hdmi) case 0x131a:
>  	case 0x132a:
>  	case 0x201a:
> +	case 0x212a:
>  		count = 1;
>  		break;
>  	default:

-- 
Regards,

Laurent Pinchart



