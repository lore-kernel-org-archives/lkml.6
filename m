Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4FCC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 15:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E966204FD
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 15:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=orpaltech.com header.i=@orpaltech.com header.b="O408bxRF";
	dkim=pass (1024-bit key) header.d=orpaltech.com header.i=@orpaltech.com header.b="O408bxRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E966204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=orpaltech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbeKDAfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 20:35:24 -0400
Received: from fallback16.mail.ru ([94.100.177.128]:58182 "EHLO
        fallback16.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeKDAfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 20:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=orpaltech.com; s=mailru;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=gvOIcYEv5ft9BjoIvFA1W6/U1ZU+3rDZa7sp8tSxlgo=;
        b=O408bxRFjY7m4AQrZS4xhu4mdc3MCBrDXdcggR01+tUSQDmK6jwU4M6qf0A/zKNanrbmozdikEGFDsNYYxhGqkSt+Ze5Rb9eOrln5+zeZ/XCZRby46jO21itkoi+/0hH+rAcYyKDkytMztp2L7QXYPVz3j3z0okbuBAC/c5Ya8w=;
Received: from [10.161.100.15] (port=44340 helo=smtpng3.m.smailru.net)
        by fallback16.i with esmtp (envelope-from <ssuloev@orpaltech.com>)
        id 1gIxm4-0001vs-FN; Sat, 03 Nov 2018 18:23:45 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=orpaltech.com; s=mailru;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=gvOIcYEv5ft9BjoIvFA1W6/U1ZU+3rDZa7sp8tSxlgo=;
        b=O408bxRFjY7m4AQrZS4xhu4mdc3MCBrDXdcggR01+tUSQDmK6jwU4M6qf0A/zKNanrbmozdikEGFDsNYYxhGqkSt+Ze5Rb9eOrln5+zeZ/XCZRby46jO21itkoi+/0hH+rAcYyKDkytMztp2L7QXYPVz3j3z0okbuBAC/c5Ya8w=;
Received: by smtpng3.m.smailru.net with esmtpa (envelope-from <ssuloev@orpaltech.com>)
        id 1gIxll-0007dA-DP; Sat, 03 Nov 2018 18:23:26 +0300
Subject: Re: [PATCH 01/10] drm/sun4i: sun6i_mipi_dsi: Compute burst mode loop
 N1 instruction delay
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        TL Lim <tllim@pine64.org>, linux-sunxi@googlegroups.com
References: <20181103100900.30313-1-jagan@amarulasolutions.com>
 <20181103100900.30313-2-jagan@amarulasolutions.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
From:   Sergey Suloev <ssuloev@orpaltech.com>
Message-ID: <8365df14-3397-b395-48eb-3070da3b65fc@orpaltech.com>
Date:   Sat, 3 Nov 2018 18:23:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181103100900.30313-2-jagan@amarulasolutions.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-77F55803: YRX02Hd68WdaeFBL0qwpQTnPfOaH4wr5x2fcbXo7q/J3CrPbwvPOsZ0gjQyt9/jD
X-7FA49CB5: 0D63561A33F958A58D8004984C3DD30AA164851E0B8B70FD828E6202185338748941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC836476C0CAF46E325F83A522CA9DD8327EE4931B544F03EFBC4D579DC7ECA47B3ECF71A060ACF921C3FBE4731C566533BA786A40A5AABA2AD371193C9F3DD0FB1AF5EB82E77451A5C57BD33C9F3DD0FB1AF5EB4E70A05D1297E1BBCB5012B2E24CD356
X-Mailru-Sender: 689FA8AB762F7393E78166CB31B43AE4860A974F191B2B339A56FF813C27D258778B5FB1219D8779F6BCD4B1DE95BF653AE5922765F965CDF1D7D1B96E5495AE10FCEA6DFE3E0A150D4ABDE8C577C2ED
X-Mras: OK
X-77F55803: avDaC6v6n9t/n1JIXLWE1ycf199igA/chNiwYokEj6enp5lTMfQBzp/XcZx+RTB7q2N+dXbmOd4=
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jagan,

On 11/3/18 1:08 PM, Jagan Teki wrote:
> Loop N1 instruction delay for burst mode lcd panel are
> computed as per BSP code.
>
> Reference code is available in BSP
> (in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> dsi_dev[sel]->dsi_inst_loop_num.bits.loop_n1=
> (panel->lcd_ht-panel->lcd_x)*(150)/(panel->lcd_dclk_freq*8) - 50;
> => (((mode->htotal - mode->hdisplay) * 150) / ((mode->clock / 1000) * 8)) - 50;
>
> So use the similar computation for loop N1 delay.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>   drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> index 86430efd9054..da152c21ec62 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -394,7 +394,14 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
>   static void sun6i_dsi_setup_inst_loop(struct sun6i_dsi *dsi,
>   				      struct drm_display_mode *mode)
>   {
> -	u16 delay = 50 - 1;
> +	struct mipi_dsi_device *device = dsi->device;
> +	u16 delay;
> +
> +	if (device->mode_flags == MIPI_DSI_MODE_VIDEO_BURST)
> +		delay = (((mode->htotal - mode->hdisplay) * 150) /
> +			((mode->clock / 1000) * 8)) - 50;
> +	else
> +		delay = 50 - 1;
>   
>   	regmap_write(dsi->regs, SUN6I_DSI_INST_LOOP_NUM_REG(0),
>   		     SUN6I_DSI_INST_LOOP_NUM_N0(50 - 1) |


is this patch series comes in addition to the previous MIPI DSI series 
or in its stead?

Thanks

