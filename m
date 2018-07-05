Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC38C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F66240D0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F66240D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754174AbeGEUF1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:05:27 -0400
Received: from mailoutvs21.siol.net ([185.57.226.212]:34651 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754045AbeGEUFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:05:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id BBD875231AB;
        Thu,  5 Jul 2018 22:05:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id WBGJEcQ6iHvj; Thu,  5 Jul 2018 22:05:22 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id D18395204E1;
        Thu,  5 Jul 2018 22:05:21 +0200 (CEST)
Received: from jernej-laptop.localnet (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPA id 52FCB5204DA;
        Thu,  5 Jul 2018 22:05:18 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] Re: [PATCH v3 09/24] drm/sun4i: Don't skip TCONs if they don't have channel 0
Date:   Thu, 05 Jul 2018 22:03:35 +0200
Message-ID: <1699738.FoQmAThxyL@jernej-laptop>
In-Reply-To: <20180705070358.7ng4shuo3pxp62q6@flea>
References: <20180625120304.7543-1-jernej.skrabec@siol.net> <CAGb2v66_6RoYk6MRtTJeqg0Z09A7y+pvSxs7qeeND+iKPE_+BA@mail.gmail.com> <20180705070358.7ng4shuo3pxp62q6@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne četrtek, 05. julij 2018 ob 09:03:58 CEST je Maxime Ripard napisal(a):
> On Sun, Jul 01, 2018 at 11:11:06PM +0800, Chen-Yu Tsai wrote:
> > On Sun, Jul 1, 2018 at 4:27 PM, Jernej Škrabec <jernej.skrabec@siol.net> 
wrote:
> > > Dne četrtek, 28. junij 2018 ob 08:24:34 CEST je Chen-Yu Tsai napisal(a):
> > >> On Thu, Jun 28, 2018 at 12:45 PM, Jernej Škrabec
> > >> 
> > >> <jernej.skrabec@siol.net> wrote:
> > >> > Dne četrtek, 28. junij 2018 ob 03:51:31 CEST je Chen-Yu Tsai 
napisal(a):
> > >> >> On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec
> > >> >> <jernej.skrabec@siol.net>
> > >> > 
> > >> > wrote:
> > >> >> > TV TCONs (channel 1 only) are always connected to TV or HDMI
> > >> >> > encoder.
> > >> >> > Because of that, all output endpoints on such TCON node will point
> > >> >> > to a
> > >> >> > encoder which is part of component framework.
> > >> >> > 
> > >> >> > Correct current graph traversing algorithm in such way that it
> > >> >> > doesn't
> > >> >> > skip output enpoints with id 0 on TV TCONs.
> > >> >> 
> > >> >> No. Our bindings say that endpoint 0 _is_ channel 0. For TCONs that
> > >> >> don't
> > >> >> have channel 0, it must be skipped.
> > >> > 
> > >> > I'm not sure where this is stated. I read TCON binding again. Can you
> > >> > please point me to it?
> > >> 
> > >> https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree
> > >> /bind ings/display/sunxi/sun4i-drm.txt#L169
> > >> 
> > >> Our TCON driver still expects RGB or LVDS panel / bridges on endpoint
> > >> 0.
> > > 
> > > Yes, but that can only happen on TCON which has channel 0. TV TCONs
> > > (those
> > > with channel 1 only) can't have panels or bridges connected to them,
> > > because they are internally always connected to either HDMI or TV
> > > encoder or both. Actually, R40 is the only SoC, where same TV TCON can
> > > be connected to TV encoder or HDMI. Others have specialized TV TCONs,
> > > which are connect to only one encoder.
> > > 
> > > IMO TV TCONs are really just stripped down LCD TCONs to support one (or
> > > max
> > > two) specific encoder.
> > 
> > I agree. We've seen these first in the H3, and the reverse, TCONs only
> > with
> > LCD, on the A23/A33.
> > 
> > >> So I guess this was sort of implied historically. It's no longer true.
> > >> This is something we should probably fix.
> > > 
> > > Fixed in what way? You mean update bindings to mention that TCON output
> > > endpoint 0 is reserved for panels or bridges?
> > 
> > Either that, or have the drm driver look at other endpoints. I guess we
> > should ask Maxime if this is already done or not, since the DSI driver
> > isn't endpoint 0 in the A33 dtsi.
> 
> The DSI driver isn't really a good example for this, since the panel
> isn't described as part of the OF graph, but DSI binding require that
> it's a child of the DSI controller node.

So should be new behaviour reverted? I mean ignoring endpoint 0 on TV TCONs.

For me, it doesn't make sense to check for panel or bridges on TV TCONs, 
because they are never exposed on physical pins. They are always connected to 
TVE or HDMI encoder internally.

> 
> > >> In practice our drivers don't look at it (yet), but rely on the
> > >> downstream
> > >> encoder type to determine which channel to use.
> > >> 
> > >> But please add the "allwinner,tcon-channel" property as specified in
> > >> the binding.
> > > 
> > > It's my understanding of TCON binding documentation that property
> > > "allwinner,tcon-channel" is needed only if TCON supports both channels.
> > > TV
> > > TCON clearly supports only channel 1. In that case, there is no doubt to
> > > which channel output endpoint belongs.
> > > 
> > > If that's not true, dt bindings documentation should be reworded to
> > > contain
> > > word "needed" or something similar. Currently, no DT for newer SoC
> > > contains
> > > that property (for example, A83T, H3, H5 or even A33).
> 
> Yeah, but that's mainly because we have a single output enabled for
> each channel on those newer SoCs. When / if we enable the RGB and LVDS
> output for example, we will have to set this.

So just to be clear, before I send follow up series, I have to add 
"allwinner,tcon-channel" property to DT, because both TV TCONs can be 
connected to either TVE or HDMI (trough TCON TOP)?

BTW, since this property is not used at all in the code, why not just simply 
deprecate it and remove it from existing DTs? I noticed this is standard 
practice for obsolete properties.

Best regards,
Jernej

> 
> > > On A33 this is even more interesting, since tcon0 has only channel
> > > 0 and has DSI output endpoint with number 1. According to TCON
> > > binding docs, if "allwinner,tcon-channel" is not preset, endpoint
> > > number represent channel. So, that would mean DSI needs channel 1
> > > on tcon which supports clearly only channel 0. So either there
> > > TCON bindings documentation needs updates or DT for A33 has to be
> > > updated.
> > 
> > Maxime? You did the A33 DSI stuff.
> 
> I guess it's missing on the A33 DSI endpoint.
> 
> Maxime



