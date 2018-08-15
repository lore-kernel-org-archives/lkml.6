Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512FBC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15978215FA
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15978215FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbeHOQgN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 12:36:13 -0400
Received: from hermes.aosc.io ([199.195.250.187]:57312 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729312AbeHOQgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 12:36:13 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id EF2B3BE823;
        Wed, 15 Aug 2018 13:43:40 +0000 (UTC)
Date:   Wed, 15 Aug 2018 21:43:19 +0800
In-Reply-To: <5309847.hPHKHXY3qr@jernej-laptop>
References: <20180815120745.36593-1-icenowy@aosc.io> <5309847.hPHKHXY3qr@jernej-laptop>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [linux-sunxi] [PATCH] drm: sun4i: exclusively set HDMI-related clocks for dw-hdmi
To:     jernej.skrabec@gmail.com,
        =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        linux-sunxi@googlegroups.com
CC:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <2890910B-FFBD-4B05-8275-270B2DB73DEA@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年8月15日 GMT+08:00 下午9:39:44, "Jernej Škrabec" <jernej.skrabec@gmail.com> 写到:
>Hi!
>
>Dne sreda, 15. avgust 2018 ob 14:07:45 CEST je Icenowy Zheng
>napisal(a):
>> The glue in sun4i-drm of dw-hdmi currently doesn't set the clocks of
>> dw-hdmi exclusively, which will lead the display fails to initialize
>in
>> some situations.
>> 
>> Add the exclusivity to sun8i-dw-hdmi and sun8i-hdmi-phy.
>> 
>> Cc: stable@vger.kernel.org # v4.17+
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>
>Given that you want this patch to be merged in stable, I have to ask
>what kind 
>of tests did you run to prove it works as expected?
>
>In the past, there were some issues with TCON exclusive rate setting.
>It turns 
>out that as many scenarios as possible have to be tested before you can
>say 
>it's working.
>
>I imagine that it has to be tested on at least A83T, H3 (or H5) and R40
>(or 
>A64). They all have their own specifics which needs to be covered.
>
>Tests which I remember from top of my head:
>- run with monitor connected at boot

BTW I think the bootloader will affect the state of displsy even
without the patch.

When could your U-Boot tweaks patchset to be done? I think they will
be needed for a really reliable test.

>- run with monitor disconnected at boot and connect it later
>- playing with resolution switching (at least a few non-standard, e.g 
>something other than 1080p or 720p)

How to do it without starting a X server?

>
>Best regards,
>Jernej
>
>
>> ---
>>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c  | 11 ++++++++++-
>>  drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c |  7 +++++--
>>  2 files changed, 15 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
>> b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c index
>31875b636434..a10220518548
>> 100644
>> --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
>> +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
>> @@ -137,10 +137,16 @@ static int sun8i_dw_hdmi_bind(struct device
>*dev,
>> struct device *master, goto err_assert_ctrl_reset;
>>  	}
>> 
>> +	ret = clk_rate_exclusive_get(hdmi->clk_tmds);
>> +	if (ret) {
>> +		dev_err(dev, "Could not get exclusivity over the tmds clock\n");
>> +		goto err_disable_clk_tmds;
>> +	}
>> +
>>  	phy_node = of_parse_phandle(dev->of_node, "phys", 0);
>>  	if (!phy_node) {
>>  		dev_err(dev, "Can't found PHY phandle\n");
>> -		goto err_disable_clk_tmds;
>> +		goto err_put_clk_tmds_exclusivity;
>>  	}
>> 
>>  	ret = sun8i_hdmi_phy_probe(hdmi, phy_node);
>> @@ -179,6 +185,8 @@ static int sun8i_dw_hdmi_bind(struct device *dev,
>struct
>> device *master, cleanup_encoder:
>>  	drm_encoder_cleanup(encoder);
>>  	sun8i_hdmi_phy_remove(hdmi);
>> +err_put_clk_tmds_exclusivity:
>> +	clk_rate_exclusive_put(hdmi->clk_tmds);
>>  err_disable_clk_tmds:
>>  	clk_disable_unprepare(hdmi->clk_tmds);
>>  err_assert_ctrl_reset:
>> @@ -194,6 +202,7 @@ static void sun8i_dw_hdmi_unbind(struct device
>*dev,
>> struct device *master,
>> 
>>  	dw_hdmi_unbind(hdmi->hdmi);
>>  	sun8i_hdmi_phy_remove(hdmi);
>> +	clk_rate_exclusive_put(hdmi->clk_tmds);
>>  	clk_disable_unprepare(hdmi->clk_tmds);
>>  	reset_control_assert(hdmi->rst_ctrl);
>>  }
>> diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
>> b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c index
>82502b351aec..1e0b1d9bc0fb
>> 100644
>> --- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
>> +++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
>> @@ -511,13 +511,14 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi
>*hdmi,
>> struct device_node *node) }
>> 
>>  		clk_prepare_enable(phy->clk_phy);
>> +		clk_rate_exclusive_get(phy->clk_phy);
>>  	}
>> 
>>  	phy->rst_phy = of_reset_control_get_shared(node, "phy");
>>  	if (IS_ERR(phy->rst_phy)) {
>>  		dev_err(dev, "Could not get phy reset control\n");
>>  		ret = PTR_ERR(phy->rst_phy);
>> -		goto err_disable_clk_phy;
>> +		goto err_put_clk_phy_exclusivity;
>>  	}
>> 
>>  	ret = reset_control_deassert(phy->rst_phy);
>> @@ -548,7 +549,8 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi
>*hdmi,
>> struct device_node *node) reset_control_assert(phy->rst_phy);
>>  err_put_rst_phy:
>>  	reset_control_put(phy->rst_phy);
>> -err_disable_clk_phy:
>> +err_put_clk_phy_exclusivity:
>> +	clk_rate_exclusive_put(phy->clk_phy);
>>  	clk_disable_unprepare(phy->clk_phy);
>>  err_put_clk_pll1:
>>  	clk_put(phy->clk_pll1);
>> @@ -568,6 +570,7 @@ void sun8i_hdmi_phy_remove(struct sun8i_dw_hdmi
>*hdmi)
>> 
>>  	clk_disable_unprepare(phy->clk_mod);
>>  	clk_disable_unprepare(phy->clk_bus);
>> +	clk_rate_exclusive_put(phy->clk_phy);
>>  	clk_disable_unprepare(phy->clk_phy);
>> 
>>  	reset_control_assert(phy->rst_phy);
