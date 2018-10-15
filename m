Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E56C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 23:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C884F2089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 23:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="T2uQhAVD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C884F2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbeJPG4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 02:56:16 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:56186 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbeJPG4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 02:56:15 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4C1871A81;
        Tue, 16 Oct 2018 01:08:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1539644930;
        bh=qYmffRecfbOImEZNJufFxnK08rw9AXp+6KGMK5hE9go=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T2uQhAVDzQ3fplEaLZGglWrcfXjn/T6eSuKn/RhkPr+ap8qpEGZpXE67ucK+RmeQ2
         oyx8xMrA9X8TX7iP5mN4xPSgnBWvw0+8QdKKP1ZtfNKqwof89RyKR6b3TwLx+cvTmV
         nPZ155J1v88G1vKc6YXLO+AyS2FIGBayquqta0Hw=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     jacopo mondi <jacopo@jmondi.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Cheng-yi Chiang <cychiang@chromium.org>
Subject: Re: [PATCH v2] regulator/gpio: Allow nonexclusive GPIO access
Date:   Tue, 16 Oct 2018 02:08:57 +0300
Message-ID: <2849502.hPNvL6TNkA@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20181012164424.GE2340@sirena.org.uk>
References: <20181012125412.21324-1-linus.walleij@linaro.org> <20181012142612.GJ7677@w540> <20181012164424.GE2340@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Friday, 12 October 2018 19:44:24 EEST Mark Brown wrote:
> On Fri, Oct 12, 2018 at 04:26:12PM +0200, jacopo mondi wrote:
> > Sorry, I'm going slightly OT with this, but please read below.
> > 
> > On Fri, Oct 12, 2018 at 02:54:12PM +0200, Linus Walleij wrote:
> > > This allows nonexclusive (simultaneous) access to a single
> > > GPIO line for the fixed regulator enable line. This happens
> > 
> > I might have a use case for shared GPIO lines used as 'simple' reset
> > signal for camera devices and not for regulators.
> 
> This recently came up in ASoC too with audio CODECs sharing reset lines,
> there was a discussion started with the reset API maintainer though no
> response yet.  CCing in Cheng-yi who had that problem.  Not deleting
> context for that.
> 
> > See drivers/media/i2c/ov772x.c FIXME note in power_on() function at:
> > https://elixir.bootlin.com/linux/latest/source/drivers/media/i2c/ov772x.c#
> > L832
> > 
> > The reset line is in this case is passed to the driver by board file:
> > https://elixir.bootlin.com/linux/latest/source/arch/sh/boards/mach-migor/s
> > etup.c#L350
> > 
> > As you can see PTT3 is used for both sensors (I know, questionable
> > HW design...)
> > 
> > Do you think extending gpiod_lookup_flags with this newly introduced
> > NONEXCLUSIVE one is an acceptable solution to avoid handling this in
> > the sensor driver like we're doing today?
> 
> One problem you've got there is that you need the two devices to know
> about each other so they coordinate their use of the reset line.  This
> was relatively easy in the sysetm Cheng-yi has as it's just one driver
> but what if there's mutiple drivers?  That's relatively likely with
> audio where you might have something like a CODEC with a separate power
> amplifier.  The regulator enable stuff is handling this in the core but
> it's less clear where to put that for reset lines.

I've seen other boards where two components sharing a reset signal have an 
active low reset for one, and an active high reset for the other one. Only one 
of the two can be out of reset at a time. That's probably considered as 
"clever" by the hardware engineers, but is awful to support for us.

The core issue in my opinion is that we need code to handle this, and since 
the removal of board files there is no place anymore for such code. Board 
drivers exist in drivers/staging/board/, but that's hardly a solution moving 
forward (the TODO file explicitly states that removal of that code is the end 
goal).

> > Please note this is an ancient architecture that boots from board
> > files, but the same might happen in modern designs with OF support. Is
> > there any clean way to handle shared GPIOs I might not be aware of for
> > those systems?

-- 
Regards,

Laurent Pinchart



