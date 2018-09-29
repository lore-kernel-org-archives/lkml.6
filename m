Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5814C64E93
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 13:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48AB20879
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 13:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A48AB20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbeI2UPw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 16:15:52 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54448 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728184AbeI2UPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 16:15:52 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B3CDE208F4; Sat, 29 Sep 2018 15:47:17 +0200 (CEST)
Received: from localhost (unknown [212.145.226.70])
        by mail.bootlin.com (Postfix) with ESMTPSA id 70EA220795;
        Sat, 29 Sep 2018 15:47:07 +0200 (CEST)
Date:   Sat, 29 Sep 2018 15:47:04 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH 05/12] drm/sun4i: sun6i_mipi_dsi: Add DSI Generic short
 write 2 param transfer
Message-ID: <20180929134704.ylcg32xtk5m2pyoj@flea>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
 <20180927114850.24565-6-jagan@amarulasolutions.com>
 <20180927171831.2nfybgn2xmc4vrgt@flea>
 <CAMty3ZCD4ArjhPJYxv3ztWXdnby8YXQ73QqoVNoHFBc-DAxx_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAMty3ZCD4ArjhPJYxv3ztWXdnby8YXQ73QqoVNoHFBc-DAxx_w@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 11:06:50PM +0530, Jagan Teki wrote:
> >
> > >               ret = sun6i_dsi_dcs_write_short(dsi, msg);
> > > @@ -885,6 +886,8 @@ static ssize_t sun6i_dsi_transfer(struct mipi_dsi_host *host,
> > >               }
> > >
> > >       default:
> > > +             dev_err(dsi->dev, "unsupported message type 0x%02x\n",
> > > +                     msg->type);
> >
> > And this isn't an error check.
> 
> But unsupported message type by sun6i_dsi should be an error
> eventually isn't it?

It's already an error condition. What you're adding, and unlike what
your commit log says, is not an error check...

> and we can easily figure out where the error trigger.

... but instead an error message.

That's definitely not the same thing, and I'm not sure we actually
need it. If a driver requests multiple transfers that are unsupported,
we'll end up spaming the kernel logs, especially when it can and
should be checked in the driver doing those transfers.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
