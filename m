Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A203EC6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D13927C92
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D13927C92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936323AbeF2TAh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 15:00:37 -0400
Received: from mailoutvs8.siol.net ([185.57.226.199]:41816 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932377AbeF2TAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 15:00:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 1FEEE522D6F;
        Fri, 29 Jun 2018 21:00:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id U8TmeEk3pYeZ; Fri, 29 Jun 2018 21:00:32 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 45AA1523087;
        Fri, 29 Jun 2018 21:00:32 +0200 (CEST)
Received: from jernej-laptop.localnet (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPA id EF75B5230B4;
        Fri, 29 Jun 2018 21:00:29 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     wens@csie.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, paul.kocialkowski@bootlin.com
Subject: Re: [PATCH] drm/sun4i: Implement zpos for DE2
Date:   Fri, 29 Jun 2018 20:59:03 +0200
Message-ID: <10555591.O1hNBsOQsL@jernej-laptop>
In-Reply-To: <20180629071746.ohdhg6mgj6knyijp@flea>
References: <20180627164514.4777-1-jernej.skrabec@siol.net> <8012754.crdjCMeE0H@jernej-laptop> <20180629071746.ohdhg6mgj6knyijp@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 29. junij 2018 ob 09:17:46 CEST je Maxime Ripard napisal(a):
> On Wed, Jun 27, 2018 at 10:58:28PM +0200, Jernej Škrabec wrote:
> > Dne sreda, 27. junij 2018 ob 20:25:00 CEST je Maxime Ripard napisal(a):
> > > Hi!
> > > 
> > > On Wed, Jun 27, 2018 at 06:45:14PM +0200, Jernej Skrabec wrote:
> > > > Initial implementation of DE2 planes only supported fixed zpos.
> > > > 
> > > > Expand implementation with configurable zpos property.
> > > > 
> > > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > 
> > > Thanks for that work. I guess you should expand a bit on the exact
> > > setup you're doing here.
> > 
> > OK.
> > 
> > > Are the pipes working the same way on the DE2 than on DE1, ie does the
> > > pipe blending applies before the alpha blending, and therefore you
> > > need to make sure that there's not two planes with alpha going to the
> > > same pipe?
> > 
> > I'm not familiar with DE1 and I'm not sure what the problem is.
> 
> The alpha blending is happening after the pipe blending. So you
> basically have a two-stage blending, the first one between the planes
> assigned to a pipe, only taking the plane priority into account, and
> using the highest priority plane's pixel in overlapping area. And
> then, you have alpha blending between the two pipes.
> 
> But that means that if you have two planes with alpha assigned to the
> same pipe, it's not going to work since the value and alpha of the
> lowest priority plane is going to be dropped in favor of the highest
> priority, instead of having transparency.

This sounds familiar. Each channel contains 4 overlays. Those overlays have 
fixed order, cannot be scaled and only blending supported is premultiply. This 
is the first step HW does. I guess this is the thing similar to DE1 plane 
blending.

After that, HW scaling is done on channel level (if it is enabled). Then 
channels are mapped (reordered) to pipes according to route register and at 
the end, alpha blending is done between pipes.

As you can see, overlays don't fit in DRM concept. They have relative position 
to channel zpos setting and scalling can't be done on them, with only 
premultipy supported. Because of those limitations, only one overlay is used 
in one channel. With this restriction, everything else falls pretty nicely 
into DRM concept.

> 
> > However, there is an issue in DE2 when alpha blending multiple planes if
> > bottom-most plane doesn't cover all screen. In this case alpha blending
> > produce weird result on screen. Fortunately, there is elegant solution.
> > Black opaque fill color is enabled for pipe 0 (always at the bottom),
> > which covers any "undefined region" and that makes alpha blending happy
> > again.
> > 
> > Alternatively, blending modes between planes could be tweaked or
> > disabled, but I found aforementioned solution is much simpler and
> > you set it only once.
> 
> Yeah, we had a similar behaviour as well, if the lowest plane has a
> some alpha (!= 0xff), the pixel value is completely dropped. We worked
> around this by preventing any plane with alpha at the lowest position,
> but it might be a good idea to check if the background color set to
> black fixes it. I remember that we were indeed seeing the background
> color, but I don't think I tried setting it to black and seeing what
> happens.
> 

I tested both corner cases I could think of and all seems to be fine. These 
are:
1. Having bottom-most plane only partialy covered. This caused issues with 
alpha blending. Solution is to set opaque black fill color to bottom-most 
pipe. In this case, previously undefined region doesn't have undefined pixel 
data and blending is correct.
2. Bottom-most plane has alpha values <0xff. This doesn't cause any issue at 
all. I suspect that the reason for that is background color set to black.

> > > Also, you seem to use the pipe and channels indifferently now, why is
> > > that?
> > 
> > Why do you think so?
> 
> Your driver used to use the channel id, and is now replaced by the
> zpos assigned (for example in SUN8I_MIXER_BLEND_PIPE_CTL_EN)

zpos represents pipe number, so that is correct thing to do.

I think I know what bothers you. Patch shows only part of the changed 
functions. Please take a look at final functions. sun8i_vi_layer_enable() and 
sun8i_vi_layer_update_coord() still work (mostly) based on channel id.

For example, sun8i_vi_layer_update_coord() function sets almost all of the 
registers based on channel id. Only output size after scaling is set based on 
pipe (zpos) id.

More precisely, zpos has to be used for reading/writing pipe settings in 
global mixer registers (prefixed with SUN8I_MIXER_BLEND_). Channel id has to 
be used when reading/writing channel registers (prefixed with 
SUN8I_MIXER_CHAN_UI_ or SUN8I_MIXER_CHAN_VI_).

Before the patch, channel id was actually the same as zpos id and because of 
that channel id was used for pipes too.

> 
> > Channel always represents HW unit, for example, on H3, mixer0, channel 0
> > always represents VI plane, channel 1, represents first UI, plane, channel
> > 2, second UI plane, etc.
> > 
> > Pipe 0 always represent channel at the bottom, pipe 1 channel on top pipe
> > 0, etc. Initial, fixed zpos implementation really had 1:1 mapping, but
> > now it can be different.
> > 
> > Register SUN8I_MIXER_BLEND_ROUTE holds pipe <-> channel mappings.
> > Bits 3:0 represents pipe 0 and holds channel number. Bits 7:4 represents
> > pipe 1, etc.
> > 
> > Additionaly,  there can be holes, for example, pipe 3 and pipe 0 are
> > enabled and pipe 1 and 2 are disabled.
> 
> IIRC, you have 4 layers per channel, and then a combination of VI and
> UI channels to form the DE2. Where is the pipe located exactly,
> between the layers and the channel output, or between the channel
> output?

I hope I answered that in first answer.

Best regards,
Jernej



