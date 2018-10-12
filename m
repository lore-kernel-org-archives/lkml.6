Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56245C67877
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228BF20835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V931GQ+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 228BF20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbeJMB5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:57:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbeJMB5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:57:02 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86C922064E;
        Fri, 12 Oct 2018 18:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539368595;
        bh=k+Te9xiJxDNCmSYG+8LJKJjRJCsCnEc0SecTYzWc3uA=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=V931GQ+X/5TcSD51Yn42wGofhqMJ8dMZjW41/Hsnvfj2yoF4yjEbwea3qTpM1P28/
         pVuPoZcbre3eCRBLBQqIn5Hcggd0tbpfYkvsmUsN8c4t0/WZqUHrNEUk8DaaQWpurO
         cDdPLdzZNnxZRRpdQlk3rsiUBcVZd4OSX/x5bgNU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Wang <sean.wang@mediatek.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <153259051470.48062.4735087631606629738@swboyd.mtv.corp.google.com>
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
 <153259051470.48062.4735087631606629738@swboyd.mtv.corp.google.com>
Message-ID: <153936859491.5275.13670768818136325103@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [resend PATCH v4 4/5] drm/mediatek: Add support for mmsys through a pdev
Date:   Fri, 12 Oct 2018 11:23:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2018-07-26 00:35:14)
> Quoting Sean Wang (2018-07-18 03:06:27)
> > On Wed, 2018-07-18 at 11:05 +0300, Laurent Pinchart wrote:
> > > Hi Sean,
> > > =

> > > This looks very strange to me. I'm not familiar with the hardware =

> > > architecture, but a clock controller that includes an audio controlle=
r seems =

> > > like a very weird design. It's usually the other way around, you have=
 an audio
> > =

> > yes, naming audsys as clock controller is really not good. it should be
> > worth a better naming.
> > =

> > mtk subsystem AFAIK works as a container, at least provides clocks,
> > reset, syscon access, these common resource to these devices running on
> > the subsystem. It also has a power gate independent from other
> > subsystem, that can be controlled when these devices all powered down
> > or once up.
> > =

> > And it should be better that we don't assume what exact devices are
> > running on since it is possible that there're different devices running
> > on the same subsystem per SoC. mtk has many subsystem working in this
> > way. mmsys is just a case. we can see in [1]
> > =

> > =

> > [1]
> > https://elixir.bootlin.com/linux/v4.18-rc5/source/Documentation/devicet=
ree/bindings/arm/mediatek
> >  =

> =

> Sean, is this an ack for this patch series? I think the consensus is to
> not modify DT to add a subnode for the "clk" part of the hardware, but
> instead either register the clks from the device driver that has the clk
> hardware inside of it, or do what this patch series does and register a
> device in software from the "parent" device driver so that logically clk
> things are contained in drivers/clk/
> =


Please resend this series. This is too old now and I'm dropping this
from (the very tail) of my queue.

