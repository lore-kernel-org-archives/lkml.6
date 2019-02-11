Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FC7C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F14D21B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="UcWzavtC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbfBKOgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:36:00 -0500
Received: from plaes.org ([188.166.43.21]:45486 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731113AbfBKOf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:35:56 -0500
Received: from plaes.org (localhost [127.0.0.1])
        by plaes.org (Postfix) with ESMTPSA id C02C9412CA;
        Mon, 11 Feb 2019 14:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1549895753; bh=8Gi4omit073u81WaoF9zvkqRCS3LXU7oUSEGO5wyFVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UcWzavtCei5KDgJWdYUmJqg3iM+kJGgqI6RL1LfSuXi7HxH8x92/YtcE/TFpRV/vd
         OXTkEpfGw0zTjOOhXn26nTz88366xRfx/duaJqI5JvIA6oDOpPckgIU4P3dDRu3uN4
         l9z2yNsJdbOCz1Hrle7EwdowWHV6rNEPpa+KU1XNhHWubpo5LKKYZhK7ZPpF4LFvEp
         dXlObLMkJjG1EudRgdcaFUugj+GukUBJQ8cYeGpYhXF5b8vf7dhXZtywiCn+KupPB5
         ku36ilStHzdIwhC5RzuoXiDBk0fiXEaiuIYZA3G36e8i53XSBp8x9scneTReEAt+ta
         IP0ydVUHZEYrA==
Date:   Mon, 11 Feb 2019 14:35:52 +0000
From:   Priit Laes <plaes@plaes.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [RFC PATCH] clk: sunxi-ng: sun4i: Use CLK_SET_RATE_PARENT for
 mmc2 clock
Message-ID: <20190211143552.2uqx6yy53dyv5lbl@plaes.org>
References: <20190202155209.31617-1-plaes@plaes.org>
 <20190205094529.t7je4ozzu2b4ornc@flea>
 <CAGb2v673ntXn7MTRhU1uecO9q8_i79e+Ovio=tucd6qFf5L84Q@mail.gmail.com>
 <20190206092000.f46nsn4fw2n4crub@flea>
 <20190206100309.dhkm2l73qzkwgjzg@plaes.org>
 <20190206155227.wbkzvsdgykir4wn5@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206155227.wbkzvsdgykir4wn5@flea>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 04:52:27PM +0100, Maxime Ripard wrote:
> Hi,
> 
> On Wed, Feb 06, 2019 at 10:03:09AM +0000, Priit Laes wrote:
> > > > I'm concerned for other users of the PLL-PERIPH clock. AFAIK
> > > > all of them, except the HRTIMER, expect the clock rate to stay
> > > > the same and not change underneath them. And SATA expects it to
> > > > be at 600 MHz, as the datasheet says. And while it may not directly
> > > > apply to the LIME2, eMMC on newer SoCs / boards run at the slightly
> > > > reduced rate of 50 MHz just fine.
> > > > 
> > > > In the commit in question, clocks without CLK_SET_RATE_PARENT
> > > > should be using the old code (now in the if conditional block),
> > > > i.e. the behavior should not have changed.
> > > > 
> > > > I don't think this actually "fixes" whatever bug was introduced,
> > > > but only papers over the issue, and possible introduces further
> > > > issues for other users.
> > > 
> > > You're right, I've overlooked that it was pll-periph being
> > > affected. I've dropped it for now.
> > 
> > Any ideas what could be done. I currently have no time to debug it,
> > but it affects existing systems.
> 
> I can't find what would change with that commit either if the flag
> isn't set, so looking at the register state before and after that
> commit would help I guess?

Register dump without the patch:

$ busybox devmem 0x01c20090
0x0250030E

pll-ddr-base     2 2 0   768000000          0     0  50000
   pll-ddr-other 1 1 0   768000000          0     0  50000
      mmc2       3 3 0    51200000          0     0  50000

Register dump with patch applied, booted from mmc0 and after mounting emmc:

$ busybox devmem 0x01c20090
0x8140020B

pll-periph-base  3 3 0  1200000000          0     0  50000
   pll-periph    6 6 0   600000000          0     0  50000
      mmc2       3 3 0    50000000          0     0  50000



> 
> Maxime
> 
> -- 
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


