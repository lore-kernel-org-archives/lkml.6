Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1251C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F66208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F66208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966113AbeFOQm2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:42:28 -0400
Received: from mailoutvs40.siol.net ([185.57.226.231]:45580 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965985AbeFOQm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:42:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id E4C02520679;
        Fri, 15 Jun 2018 18:42:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8FtG1iOslO-Z; Fri, 15 Jun 2018 18:42:22 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 46CC75202D0;
        Fri, 15 Jun 2018 18:42:22 +0200 (CEST)
Received: from jernej-laptop.localnet (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPA id 4A562520679;
        Fri, 15 Jun 2018 18:42:20 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     wens@csie.org, robh+dt@kernel.org, airlied@linux.ie,
        gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 11/27] drm/sun4i: tcon: Add support for tcon-top gate
Date:   Fri, 15 Jun 2018 18:41:16 +0200
Message-ID: <2948115.KggauuSURZ@jernej-laptop>
In-Reply-To: <20180615083110.laruycabvyjmesmo@flea>
References: <20180612200036.21483-1-jernej.skrabec@siol.net> <20180612200036.21483-12-jernej.skrabec@siol.net> <20180615083110.laruycabvyjmesmo@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Dne petek, 15. junij 2018 ob 10:31:10 CEST je Maxime Ripard napisal(a):
> Hi,
> 
> On Tue, Jun 12, 2018 at 10:00:20PM +0200, Jernej Skrabec wrote:
> > TV TCONs connected to TCON TOP have to enable additional gate in order
> > to work.
> > 
> > Add support for such TCONs.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  drivers/gpu/drm/sun4i/sun4i_tcon.c | 11 +++++++++++
> >  drivers/gpu/drm/sun4i/sun4i_tcon.h |  4 ++++
> >  2 files changed, 15 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > b/drivers/gpu/drm/sun4i/sun4i_tcon.c index 08747fc3ee71..0afb5a94a414
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > @@ -688,6 +688,16 @@ static int sun4i_tcon_init_clocks(struct device *dev,
> > 
> >  		dev_err(dev, "Couldn't get the TCON bus clock\n");
> >  		return PTR_ERR(tcon->clk);
> >  	
> >  	}
> > 
> > +
> > +	if (tcon->quirks->has_tcon_top_gate) {
> > +		tcon->top_clk = devm_clk_get(dev, "tcon-top");
> > +		if (IS_ERR(tcon->top_clk)) {
> > +			dev_err(dev, "Couldn't get the TCON TOP bus clock\n");
> > +			return PTR_ERR(tcon->top_clk);
> > +		}
> > +		clk_prepare_enable(tcon->top_clk);
> > +	}
> > +
> 
> Is it required for the TCON itself to operate, or does the TCON
> requires the TCON TOP, which in turn requires that clock to be
> functional?
> 
> I find it quite odd to have a clock that isn't meant for a particular
> device to actually be wired to another device. I'm not saying this
> isn't the case, but it would be a first.

Documentation doesn't say much about that gate. I did few tests and TCON 
registers can be read and written even if TCON TOP TV TCON gate is disabled. 
However, there is no image, as expected.

More interestingly, I enabled test pattern directly in TCON to eliminate 
influence of the mixer. As soon as I disabled that gate, test pattern on HDMI 
screen was gone, which suggest that this gate influences something inside 
TCON.

Another test I did was that I moved enable/disable gate code to 
sun4i_tcon_channel_set_status() and it worked just as well.

I'll ask AW engineer what that gate actually does, but from what I saw, I 
would say that most appropriate location to enable/disable TCON TOP TV TCON 
gate is TCON driver. Alternatively, TCON TOP driver could check if any TV TCON 
is in use and enable appropriate gate. However, that doesn't sound right to me 
for some reason.

Best regards,
Jernej


