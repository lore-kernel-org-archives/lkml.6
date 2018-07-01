Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8511AC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 08:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD58252B1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 08:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD58252B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752115AbeGAI30 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 04:29:26 -0400
Received: from mailoutvs22.siol.net ([185.57.226.213]:58483 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751850AbeGAI3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 04:29:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 5DB15520EE1;
        Sun,  1 Jul 2018 10:29:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Rv0exl5DGOTK; Sun,  1 Jul 2018 10:29:15 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id A3A59520EDF;
        Sun,  1 Jul 2018 10:29:15 +0200 (CEST)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPA id 355FF520EE1;
        Sun,  1 Jul 2018 10:29:11 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
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
Date:   Sun, 01 Jul 2018 10:27:43 +0200
Message-ID: <8952939.l1hLr1Mv9y@jernej-laptop>
In-Reply-To: <CAGb2v67kBRWkJpJogFR4GXgA66dsxVaMVWN8MDiP_wFTqxW-=g@mail.gmail.com>
References: <20180625120304.7543-1-jernej.skrabec@siol.net> <2676604.ZYCNkuCdbT@jernej-laptop> <CAGb2v67kBRWkJpJogFR4GXgA66dsxVaMVWN8MDiP_wFTqxW-=g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne četrtek, 28. junij 2018 ob 08:24:34 CEST je Chen-Yu Tsai napisal(a):
> On Thu, Jun 28, 2018 at 12:45 PM, Jernej Škrabec
> 
> <jernej.skrabec@siol.net> wrote:
> > Dne četrtek, 28. junij 2018 ob 03:51:31 CEST je Chen-Yu Tsai napisal(a):
> >> On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net>
> > 
> > wrote:
> >> > TV TCONs (channel 1 only) are always connected to TV or HDMI encoder.
> >> > Because of that, all output endpoints on such TCON node will point to a
> >> > encoder which is part of component framework.
> >> > 
> >> > Correct current graph traversing algorithm in such way that it doesn't
> >> > skip output enpoints with id 0 on TV TCONs.
> >> 
> >> No. Our bindings say that endpoint 0 _is_ channel 0. For TCONs that don't
> >> have channel 0, it must be skipped.
> > 
> > I'm not sure where this is stated. I read TCON binding again. Can you
> > please point me to it?
> 
> https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bind
> ings/display/sunxi/sun4i-drm.txt#L169
> 
> Our TCON driver still expects RGB or LVDS panel / bridges on endpoint 0.

Yes, but that can only happen on TCON which has channel 0. TV TCONs (those 
with channel 1 only) can't have panels or bridges connected to them, because 
they are internally always connected to either HDMI or TV encoder or both. 
Actually, R40 is the only SoC, where same TV TCON can be connected to TV 
encoder or HDMI. Others have specialized TV TCONs, which are connect to only 
one encoder.

IMO TV TCONs are really just stripped down LCD TCONs to support one (or max 
two) specific encoder.

> So I guess this was sort of implied historically. It's no longer true.
> This is something we should probably fix.

Fixed in what way? You mean update bindings to mention that TCON output 
endpoint 0 is reserved for panels or bridges?

> 
> In practice our drivers don't look at it (yet), but rely on the downstream
> encoder type to determine which channel to use.
> 
> But please add the "allwinner,tcon-channel" property as specified in
> the binding.

It's my understanding of TCON binding documentation that property 
"allwinner,tcon-channel" is needed only if TCON supports both channels. TV 
TCON clearly supports only channel 1. In that case, there is no doubt to which 
channel output endpoint belongs.

If that's not true, dt bindings documentation should be reworded to contain 
word "needed" or something similar. Currently, no DT for newer SoC contains 
that property (for example, A83T, H3, H5 or even A33). On A33 this is even 
more interesting, since tcon0 has only channel 0 and has DSI output endpoint 
with number 1. According to TCON binding docs, if "allwinner,tcon-channel" is 
not preset, endpoint number represent channel. So, that would mean DSI needs 
channel 1 on tcon which supports clearly only channel 0. So either there TCON 
bindings documentation needs updates or DT for A33 has to be updated.

BTW, "allwinner,tcon-channel" property is not used at all in the code.

> 
> > So on TV TCONs on R40 (without channel 0) TVE would be endpoint 1 and HDMI
> > endpoint 2 (or the other way around)?
> 
> Which one goes first doesn't quite matter. IIRC there's also a mux for TVE?

AFAIK, TV TCON is by default connected to TV encoder unless HDMI mux in TCON 
TOP points to it. I think it's best put TVE with lower number since it's 
default and HDMI with higher number.

Best regards,
Jernej



