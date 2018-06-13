Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 223C2C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D298E20891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D298E20891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934996AbeFMQVR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 12:21:17 -0400
Received: from mailoutvs39.siol.net ([185.57.226.230]:45095 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754498AbeFMQVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 12:21:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 74222520C01;
        Wed, 13 Jun 2018 18:21:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id eMnrL9tp_yVf; Wed, 13 Jun 2018 18:21:09 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id C1FD652106A;
        Wed, 13 Jun 2018 18:21:09 +0200 (CEST)
Received: from jernej-laptop.localnet (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPA id BF79A521069;
        Wed, 13 Jun 2018 18:21:08 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     linux-sunxi@googlegroups.com, wens@csie.org
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
        linux-clk <linux-clk@vger.kernel.org>
Subject: Re: [linux-sunxi] Re: [PATCH v2 14/27] drm/sun4i: Don't check for panel or bridge on TV TCONs
Date:   Wed, 13 Jun 2018 18:20:07 +0200
Message-ID: <2662622.yHSNrIAaJ9@jernej-laptop>
In-Reply-To: <CAGb2v66QWr2CQhcfQ9BQds-0xeG=pS4MDzaNn7_HGz+q3gfkWA@mail.gmail.com>
References: <20180612200036.21483-1-jernej.skrabec@siol.net> <20180613074621.5phumovcyymbkfbn@flea> <CAGb2v66QWr2CQhcfQ9BQds-0xeG=pS4MDzaNn7_HGz+q3gfkWA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 13. junij 2018 ob 10:04:20 CEST je Chen-Yu Tsai napisal(a):
> On Wed, Jun 13, 2018 at 3:46 PM, Maxime Ripard
> 
> <maxime.ripard@bootlin.com> wrote:
> > On Tue, Jun 12, 2018 at 10:00:23PM +0200, Jernej Skrabec wrote:
> >> TV TCONs are always connected to TV or HDMI encoder, so it doesn't make
> >> sense to check if panel or bridge is connected to them.
> >> 
> >> Check if TCON has channel 0 and only then check for connected panel or
> >> bridges.
> >> 
> >> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> >> ---
> >> 
> >>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 12 +++++++++---
> >>  1 file changed, 9 insertions(+), 3 deletions(-)
> >> 
> >> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> >> b/drivers/gpu/drm/sun4i/sun4i_tcon.c index b1205a7bc20f..c9ffa5381185
> >> 100644
> >> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> >> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> >> @@ -1189,13 +1189,19 @@ static const struct component_ops sun4i_tcon_ops
> >> = {>> 
> >>  static int sun4i_tcon_probe(struct platform_device *pdev)
> >>  {
> >>  
> >>       struct device_node *node = pdev->dev.of_node;
> >> 
> >> +     const struct sun4i_tcon_quirks *quirks;
> >> 
> >>       struct drm_bridge *bridge;
> >>       struct drm_panel *panel;
> >>       int ret;
> >> 
> >> -     ret = drm_of_find_panel_or_bridge(node, 1, 0, &panel, &bridge);
> >> -     if (ret == -EPROBE_DEFER)
> >> -             return ret;
> >> +     quirks = of_device_get_match_data(&pdev->dev);
> > 
> > We should probably check ofr the pointer value before dereferencing it.
> 
> I think we've discussed this before. If the driver has data structures
> for all the supported compatible strings, and it is device tree only,
> then we should just let it blow up in the user's face, since they are
> obviously doing something they shouldn't be doing to get the driver
> to probe without a compatible string match.

TCON can't work with no quirks specified, since that would mean that neither 
channels are present. Additionally, sun4i_tcon_bind() also doesn't check if 
quirks are NULL or not. So I concur with Chen-Yu here.

Best regards,
Jernej



