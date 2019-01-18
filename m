Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B7CC07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5529720823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547832674;
	bh=+kqyZIlnO3ixeb2SUutOIYXVyPLGTVBMNSP9HOFSdvs=;
	h=Subject:In-Reply-To:References:Cc:To:From:Date:List-ID:From;
	b=a/z/gr/48THGGknrgbu4lOGtBod38Fr8BhvX3kBejoNvBWgAv9+KtYeyAnVxyzm4i
	 1tsc7aksTTtqHIBJ3x2aqn7LOCzoMMSMLLwQiEn9uQF6j3/L5je5aj8Lx7Q7xg0pKv
	 ZmM2eYRrgMUoKd7psUgaos0unOJJMwHHFwYckGSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbfARRbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:31:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:55942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727527AbfARRbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:31:12 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CFB320823;
        Fri, 18 Jan 2019 17:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547832671;
        bh=+kqyZIlnO3ixeb2SUutOIYXVyPLGTVBMNSP9HOFSdvs=;
        h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
        b=xgq2HtOYS33MJZMhob4YFIv2ge93HM7Uji8PLiKi58FVWjOH1PsCciLXC7dLQiZmi
         l414MOJU22WmyVe979GbG5s82r3v4SDmJig7r1n3GnjIMP6mWM4ZHISJUgHEvNySOE
         G8wYNF+IQM+LeDq4vWfzRvfqKH8XBaKNjnTK5+C4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] clk: mmp2: avoid disabling the SP clock when unused
User-Agent: alot/0.8
In-Reply-To: <bec06415e980f18d5d3407d498cad372dc3abd1b.camel@v3.sk>
References: <20190116093505.1920945-1-lkundrak@v3.sk> <154765664632.169631.9344557684702266461@swboyd.mtv.corp.google.com> <73b20a5caef100d5768679cc395168976e86ed04.camel@v3.sk> <154768138798.169631.18317264971847478148@swboyd.mtv.corp.google.com> <bec06415e980f18d5d3407d498cad372dc3abd1b.camel@v3.sk>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
To:     Lubomir Rintel <lkundrak@v3.sk>,
        Michael Turquette <mturquette@baylibre.com>
Message-ID: <154783267051.169631.3197836544646625747@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 18 Jan 2019 09:31:10 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2019-01-17 01:47:55)
> On Wed, 2019-01-16 at 15:29 -0800, Stephen Boyd wrote:
> > Quoting Lubomir Rintel (2019-01-16 09:26:31)
> > > On Wed, 2019-01-16 at 08:37 -0800, Stephen Boyd wrote:
> > > >=20
> > > > Is it a critical clk that should never be turned off?
> > >=20
> > > I don't think it is. It is entirely plausible to have no use for the
> > > "security processor", and in that case it's just okay to keep the clo=
ck
> > > disabled.
> >=20
> > So does the firmware/bootloader leave the clk enabled out of boot and we
> > shouldn't really touch the on/off bits of the clk hardware from the
> > kernel?
>=20
> I think so.
>=20
> > Or do we want to actively manage this clk from a driver
> > somewhere in the kernel?
>=20
> The olpc_apsp driver actually manages this clock, but that might turn
> out to be the wrong thing to do. It currently only works if the driver
> is built-in and thus the clock is always kept enabled.
>=20
> I'm now somewhat more confused that I believed myself to be when
> sending the patch. Perhaps you could help me understand things a bit
> more:
>=20
> 1.) What's the principal difference between CLK_IGNORE_UNUSED and
> CLK_IS_CRITICAL? Is it that the CLK_IGNORE_UNUSED clocks are permitted=20
> to be disabled by a driver, but an attempt to disable CLK_IS_CRITICAL
> is a bug?

Yes. CLK_IGNORE_UNUSED is a workaround for two opposing forces. The
first being the lack of a way for the clk framework to "hand off" the
state of a clk to clk consumers after late init and the second being the
desire to save power by disabling unused clocks.

>=20
> 2.) Perhaps it makes sense to disable the SP on the machines that don't
> utilize it even if firmware keeps it enabled? Would it make sense to
> make the clk driver use the  "protected-clocks" DT property for this?

I don't think so. The protected-clocks property lists clks that
shouldn't be touched by the OS. Critical clks in theory are still
touched because the framework turns them on once, in case they're not
already enabled. That's sort of a weird implementation detail that some
drivers rely on. We haven't had a situation where drivers shouldn't
read/write clk registers but also mark them as critical. I would think
that we just wouldn't register those clks with the kernel because they
would never be used.

Does having this clk actually matter? Maybe it can just be removed
instead? Put another way, is it saving any power to manage the clk from
the kernel?

>=20
> ----8<----
>=20
> Here's some more context for the SP on the MMP2:
>=20
> The SP is a small PJ1 core. It starts when the platform is powered on
> and eventually brings up the large PJ4 core.
>=20
> On the OLPC machine, the first stage firmware (cforth) starts running
> on the SP, configures the DRAM, starts the boot firmware (openfirmware)
> on the main PJ4 core and then enters a loop that bit-bangs the PS/2
> protocol on the attached keyboard/touchpad.
>=20
> It is entirely possible that on some boards the SP is not used for
> anything but the bringup of the bootloader on the main core.
>=20
> SP is sometimes referred to as WTM, "wireless trusted module", but it's
> not clear to me why is it the case. There's no documentation.
>=20

Ok. Thanks for the background.

