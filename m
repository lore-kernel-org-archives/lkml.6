Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B787DC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D9A20883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFjtKAZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D9A20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbeGZIut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:50:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:58278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728749AbeGZIus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:50:48 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B98120673;
        Thu, 26 Jul 2018 07:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532590515;
        bh=X3YiETSP96EhHBeVSyqplLSFd+pOdmkw7T6shH6wR6Y=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=YFjtKAZ12ZxubWJwOYK/ca9XZxC/znVKAUPGSCmPeqeYNLY3ezB3h4/2NeQjErEA0
         tJroZQW26R3KqbGxHdVWrHoZuihk9ZEWMagsFpjDUhz+6zAzqnbEHK1aGapCWYMhq9
         P/yHj/kHKu5lyqYnlsaI+tLBJ7qqA8VGAdJJOa2M=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Wang <sean.wang@mediatek.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1531908387.8953.147.camel@mtkswgap22>
Cc:     mark.rutland@arm.com, airlied@linux.ie, mturquette@baylibre.com,
        dri-devel@lists.freedesktop.org, ulrich.hecht+renesas@gmail.com,
        lee.jones@linaro.org, linux-clk@vger.kernel.org,
        linux@armlinux.org.uk, ck.hu@mediatek.com, robh+dt@kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        mchehab@kernel.org, linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>,
        gregkh@linuxfoundation.org, rdunlap@infradead.org,
        sboyd@codeaurora.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, matthias.bgg@kernel.org,
        pi-cheng.chen@linaro.org, davem@davemloft.net
References: <20180717220328.792-1-matthias.bgg@kernel.org>
 <20180717220328.792-5-matthias.bgg@kernel.org>
 <1531882655.8953.83.camel@mtkswgap22> <51066716.k5MkZnrqCl@avalon>
 <1531908387.8953.147.camel@mtkswgap22>
Message-ID: <153259051470.48062.4735087631606629738@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [resend PATCH v4 4/5] drm/mediatek: Add support for mmsys through a pdev
Date:   Thu, 26 Jul 2018 00:35:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sean Wang (2018-07-18 03:06:27)
> On Wed, 2018-07-18 at 11:05 +0300, Laurent Pinchart wrote:
> > Hi Sean,
> > =

> > On Wednesday, 18 July 2018 05:57:35 EEST Sean Wang wrote:
> > > On Wed, 2018-07-18 at 00:03 +0200, matthias.bgg@kernel.org wrote:
> > > > From: Matthias Brugger <mbrugger@suse.com>
> > > > =

> > > > The MMSYS subsystem includes clocks and drm components.
> > > > This patch adds an initailization path through a platform device
> > > > for the clock part, so that both drivers get probed from the same
> > > > device tree compatible.
> > > =

> > > Sorry for that I should have a response earlier for the series.
> > > =

> > > Some points I felt they're not exactly right and should be fixed up
> > > before we're moving on
> > > =

> > > Currently, drm driver have a wrong reference to the dt-binding,
> > > "mediatek,mt2701-mmsys" or "mediatek,mt8173-mmsys", they should be all
> > > for the subsystem exporting clock and reset line such common resource=
 to
> > > its sub-devices. Every subsystem has a similar shape. I hope mmsys
> > > shouldn't be an exception.
> > > =

> > > DRM device needs to have its own dt-binding show how connections betw=
een
> > > DRM components being made and its node should be put under mmsys node.
> > > =

> > > In this way, it becomes easy to see how the topology of the subsystem=
 is
> > > and grows, like a tree "device tree", instead of hiding the details in
> > > the implementation.
> > > =

> > > The similar example we already did for audsys on mt2701 and mt7623 as
> > > below
> > > =

> > >     audsys: clock-controller@11220000 {
> > >             =

> > compatible =3D "mediatek,mt7623-audsys",
> > >             =

> >            "mediatek,mt2701-audsys",
> > >             =

> >            "syscon";
> > >             =

> >       ...
> > > =

> > >             =

> > afe: audio-controller {
> > >             =

> >       compatible =3D "mediatek,mt7623-audio",
> > >             =

> >               =

> >      "mediatek,mt2701-audio";
> > > =

> > >             =

> >       ...
> > >             =

> > };
> > >     };
> > =

> > This looks very strange to me. I'm not familiar with the hardware =

> > architecture, but a clock controller that includes an audio controller =
seems =

> > like a very weird design. It's usually the other way around, you have a=
n audio
> =

> yes, naming audsys as clock controller is really not good. it should be
> worth a better naming.
> =

> mtk subsystem AFAIK works as a container, at least provides clocks,
> reset, syscon access, these common resource to these devices running on
> the subsystem. It also has a power gate independent from other
> subsystem, that can be controlled when these devices all powered down
> or once up.
> =

> And it should be better that we don't assume what exact devices are
> running on since it is possible that there're different devices running
> on the same subsystem per SoC. mtk has many subsystem working in this
> way. mmsys is just a case. we can see in [1]
> =

> =

> [1]
> https://elixir.bootlin.com/linux/v4.18-rc5/source/Documentation/devicetre=
e/bindings/arm/mediatek
>  =


Sean, is this an ack for this patch series? I think the consensus is to
not modify DT to add a subnode for the "clk" part of the hardware, but
instead either register the clks from the device driver that has the clk
hardware inside of it, or do what this patch series does and register a
device in software from the "parent" device driver so that logically clk
things are contained in drivers/clk/

