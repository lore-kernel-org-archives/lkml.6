Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E02C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA83D20821
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="Y66Oa5RF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfBLJpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:45:50 -0500
Received: from plaes.org ([188.166.43.21]:49010 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbfBLJpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:45:50 -0500
Received: from plaes.org (localhost [127.0.0.1])
        by plaes.org (Postfix) with ESMTPSA id 663D64022E;
        Tue, 12 Feb 2019 09:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1549964747; bh=W25nCZmEIHwGCTrzOhdBgd7ZEShM1fhel195A9NUUJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y66Oa5RFVOQQLEpwHktWNOQofRWVwvVlE4yIXl0jLqHj+CrSy6KH+C36goAXDu3+H
         3hDCzZbdv1x+SzKdULFgOOcO+7j8Kd3O+NB1369dHVx4E5Nhd5af1ON2g9hTKCmi0N
         5Cxc5sWq5pxAoEWdtFIINuXTzTYSH1fWVaFevRV9IgGCPyPoCXnWaDV1XzsrgUn8K3
         ngBcxdfJnvh0CKSh7P2rSlnae0PYccxX/C9h5KDfbuV3GqYi283omzQECukJLIyGpf
         oeQ+0pnI5n8pS39PuSNUsDvh0Xxhlqax4PFnR1Inl0ldeOaFfiAOtRUq4+CXfS4xK2
         qgSmS4YawBs3g==
Date:   Tue, 12 Feb 2019 09:45:46 +0000
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
Message-ID: <20190212094546.n2w7pffytzdgpx3e@plaes.org>
References: <20190202155209.31617-1-plaes@plaes.org>
 <20190205094529.t7je4ozzu2b4ornc@flea>
 <CAGb2v673ntXn7MTRhU1uecO9q8_i79e+Ovio=tucd6qFf5L84Q@mail.gmail.com>
 <20190206092000.f46nsn4fw2n4crub@flea>
 <20190206100309.dhkm2l73qzkwgjzg@plaes.org>
 <20190206155227.wbkzvsdgykir4wn5@flea>
 <20190211143552.2uqx6yy53dyv5lbl@plaes.org>
 <20190211153402.s5qij5idvhbtsw2y@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211153402.s5qij5idvhbtsw2y@flea>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 04:34:02PM +0100, Maxime Ripard wrote:
> On Mon, Feb 11, 2019 at 02:35:52PM +0000, Priit Laes wrote:
> > On Wed, Feb 06, 2019 at 04:52:27PM +0100, Maxime Ripard wrote:
> > > Hi,
> > > 
> > > On Wed, Feb 06, 2019 at 10:03:09AM +0000, Priit Laes wrote:
> > > > > > I'm concerned for other users of the PLL-PERIPH clock. AFAIK
> > > > > > all of them, except the HRTIMER, expect the clock rate to stay
> > > > > > the same and not change underneath them. And SATA expects it to
> > > > > > be at 600 MHz, as the datasheet says. And while it may not directly
> > > > > > apply to the LIME2, eMMC on newer SoCs / boards run at the slightly
> > > > > > reduced rate of 50 MHz just fine.
> > > > > > 
> > > > > > In the commit in question, clocks without CLK_SET_RATE_PARENT
> > > > > > should be using the old code (now in the if conditional block),
> > > > > > i.e. the behavior should not have changed.
> > > > > > 
> > > > > > I don't think this actually "fixes" whatever bug was introduced,
> > > > > > but only papers over the issue, and possible introduces further
> > > > > > issues for other users.
> > > > > 
> > > > > You're right, I've overlooked that it was pll-periph being
> > > > > affected. I've dropped it for now.
> > > > 
> > > > Any ideas what could be done. I currently have no time to debug it,
> > > > but it affects existing systems.
> > > 
> > > I can't find what would change with that commit either if the flag
> > > isn't set, so looking at the register state before and after that
> > > commit would help I guess?
> > 
> > Register dump without the patch:
> > 
> > $ busybox devmem 0x01c20090
> > 0x0250030E
> > 
> > pll-ddr-base     2 2 0   768000000          0     0  50000
> >    pll-ddr-other 1 1 0   768000000          0     0  50000
> >       mmc2       3 3 0    51200000          0     0  50000
> > 
> > Register dump with patch applied, booted from mmc0 and after mounting emmc:
> > 
> > $ busybox devmem 0x01c20090
> > 0x8140020B
> > 
> > pll-periph-base  3 3 0  1200000000          0     0  50000
> >    pll-periph    6 6 0   600000000          0     0  50000
> >       mmc2       3 3 0    50000000          0     0  50000
> 
> I meant the whole Clock controller, ideally a diff between the two
> states would be great.

I have uploaded the raw files here:
https://gist.github.com/plaes/3465386d8aa55fa70fd3997310719828

The test scenario is following:

1) Boot via FEL (u-boot + zImage + boot.scr) and load root fs from
sd-card / mmc0

2) ssh into machine and dump register space

- no-patch-before-mount.dump
- no-patch-post-mount.dump

3) Attempt to mount emmc / mmc2 and dump ccu register space
- with-patch-before-mount.dump
- with-patch-post-mount.dump


Firstly, I noticed that first 0x200 bits are mirrored:
0x1c20000 = 0x1c20200
0x1c20004 = 0x1c20204
...
01xc201fc = 0x1c203fc

And here come the diffs:

a) Diff before mount vs patch / reverted patch:

mmc2:
  -0x1c20090: 0x0250030E
  +0x1c20090: 0x0140020B
unk1: (mirrored ahb?, this one's flaky due to mmc runtime suspend)
  -0x1c20260: 0x1200C17F
  +0x1c20260: 0x1200C07F
unk2: (mirrored mmc2?)
  -0x1c20290: 0x0250030E
  +0x1c20290: 0x0140020B

b) Diff post-mount vs patch / reverted patch:

ahb (this one's flaky, possibly due to runtime suspend for mmc):
  -0x1c20060: 0x1200C07F or 0x1200C17F
  +0x1c20060: 0x1200C47F
mmc2:
  -0x1c20090: 0x0250030E
  +0x1c20090: 0x8140020B
unk1:
  -0x1c20260: 0x1200C07F
  +0x1c20260: 0x1200C47F
unk3:
  -0x1c20288: 0x8140030B
  +0x1c20288: 0x0140030B
unk2: (mirrored mmc2?)
  -0x1c20290: 0x0250030E
  +0x1c20290: 0x8140020B


