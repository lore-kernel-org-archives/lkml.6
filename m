Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55756ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 09:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4512083E
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 09:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="wK1hPfff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4512083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeJURUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 13:20:37 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33784 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbeJURUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 13:20:36 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4E096C8;
        Sun, 21 Oct 2018 11:06:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1540112816;
        bh=L7MRU3FqJucR4Jou/kjiNLMcj0a27Xkiz4VA72ofHzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wK1hPfff/iDnKRV1BHfXcOXPLiEckzIrX8uM0oh9lcyvp7nAn4DF0ah1NzOd60trA
         PwERMdswXlv8GEvEr5xMFmdym5oUNQIt/ELvRqD5HodiVr7BgO+R2nsHcleuME0GXr
         ApN3Z2xV/QKz7s5JL1DfSAmnnNCo4f4WMwr6AFm4=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Sandeep Panda <spanda@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        linux-arm-msm@vger.kernel.org, jsanka@codeaurora.org,
        ryandcase@chromium.org, Andrzej Hajda <a.hajda@samsung.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2] dt-bindings: drm/bridge: sn65dsi86: Add panel-hpd-delay
Date:   Sun, 21 Oct 2018 12:06:56 +0300
Message-ID: <7337055.Mnli2TfP4b@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20181019201940.138179-1-dianders@chromium.org>
References: <20181019201940.138179-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Douglas,

Thank you for the patch.

On Friday, 19 October 2018 23:19:39 EEST Douglas Anderson wrote:
> The timing diagram of some eDP panels says that you're supposed to
> wait for HPD to be asserted before the aux channel is operational.
> 
> In some cases, however, it's better to just hardcode the max delay
> instead of trying to use HPD.  Why?
> 
> The sn65dsi86 datasheet says that it only reports the debounced
> HPD signal to software.  It will tell software about HPD assertion
> as quickly as 100 ms after it's asserted, but sometimes it might
> take 400 ms because it's timed with a very inaccurate ring
> oscillator.  In practice it was measured at 200 ms on at least
> one system.
> 
> On a particular panel, HPD was asserted 84 ms after power was given.
> This same panel specified that HPD would always be asserted within
> 200 ms of applying power.  Thus on this panel with the measured
> 84 ms to assert HPD + the 200 ms measured debounce we'd wait 284 ms
> which is 84 ms longer than just hardcoding the sleep.
> 
> Let's allow boards to explicitly choose the hardcoded delay by adding
> a device tree attribute for it.  A few notes:
> a) This delay can't easily be in the panel bindings because the delay
>    wouldn't actually be needed if the same panel were hooked somewhere
>    else (someplace with more sane HPD behavior).

The delay shouldn't be handled in the panel driver, but I think it's still a 
property of the panel, and should thus be specified in the panel DT node. The 
panel driver should parse it from DT (or, if the panel driver knows about the 
specific panel model, just hardcode it), and then report it to the bridge 
driver which can then decide, based on its knowledge if the bridge internal 
HPD processing delays, to just wait for a fixed delay or use regular HPD 
handling.

> b) The nice thing about being able to set this delay is that it's also
>    useful on boards where HPD wasn't hooked up at all (for whatever
>    reason).
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  .../bindings/display/bridge/ti,sn65dsi86.txt          | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.txt
> b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.txt index
> 0a3fbb53a16e..1a1ca0f7a1d8 100644
> --- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.txt
> +++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.txt
> @@ -33,6 +33,15 @@ Optional properties:
> 
>  - suspend-gpios: specification for GPIO1 pin on bridge (active low)
> 
> +- ti,panel-hpd-delay-ms: Assume that HPD from the panel will be asserted
> within
> +			 this many milliseconds after giving power to the panel.
> +			 With this number we can ignore the HPD signal from
> +			 the panel and just hardcode a delay.  This is useful
> +			 to do because the bridge chip only provides the
> +			 debounced HPD signal to software and the timing of the
> +			 debounce is very inaccurate so it's often faster to
> +			 hardcode the max from the panel spec.
> +
>  Required nodes:
>  This device has two video ports. Their connections are modelled using the
>  OF graph bindings specified in Documentation/devicetree/bindings/graph.txt.
> @@ -62,6 +71,8 @@ edp-bridge@2d {
>  	clock-names = "refclk";
>  	clocks = <&input_refclk>;
> 
> +	ti,panel-hpd-delay-ms = <200>;
> +
>  	ports {
>  		#address-cells = <1>;
>  		#size-cells = <0>;

-- 
Regards,

Laurent Pinchart



