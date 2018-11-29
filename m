Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C003EC64EB4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867FB20863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3odRjOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867FB20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeK3Jgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:36:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:56648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbeK3Jgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:36:37 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F2B520863;
        Thu, 29 Nov 2018 22:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543530575;
        bh=2QaAe4Zs9DSQ7ZMWdrOuXKDmoS5z0evRYwMmfRjPW1M=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=t3odRjOWD8sO0m0lOm1DQM49DgOWK+6jn9pN5eN2zy3abLO+0TB7Tbhxy7d51jzml
         pz6q1m8inNGb3MEPgVmCUlKW+Gzo0DcdRyXZeLHBxbvtUQdjgSbMsGP1IxslMm/krk
         XY4QTginYdUvDUrDJwWlpmVEjHyTaWHbu4fnw52I=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Janek Kotas <jank@cadence.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CAE55F09-516A-4737-8F74-07BBA3AF5737@global.cadence.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <D3711617-229C-4FA5-9E73-A7A3C025893B@global.cadence.com>
 <154223394933.88331.14659021245427374668@swboyd.mtv.corp.google.com>
 <CAE55F09-516A-4737-8F74-07BBA3AF5737@global.cadence.com>
Message-ID: <154353057449.88331.10017415440005548379@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] clk: Add Fixed MMIO clock driver
Date:   Thu, 29 Nov 2018 14:29:34 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Janek Kotas (2018-11-15 00:27:15)
> Thanks for the reply.
> Jan
> =

> > On 14 Nov 2018, at 23:19, Stephen Boyd <sboyd@kernel.org> wrote:
> > =

> > Quoting Janek Kotas (2018-11-14 07:24:39)
> >> This patch adds a driver for Fixed MMIO clock.
> >> The driver reads a clock frequency value from a single 32-bit memory
> >> mapped register and registers it as a fixed rate clock.
> >> =

> >> It can be enabled with COMMON_CLK_FIXED_MMIO Kconfig option.
> >> =

> >> Signed-off-by: Jan Kotas <jank@cadence.com>
> > =

> > Sounds like a fine idea. Except I can see how it will be abused if there
> > are a handful of these fixed rate "clks" somewhere in memory that all
> > get populated. =

> > =

> > Do you really have a fixed rate clk in hardware that exposes a single
> > register, or do you have a set of them that some firmware is populating
> > into an I/O memory space that we can read the fixed rates from? If it's
> > the latter, I wonder why we can't just have the firmware populate the
> > fixed rate clks into DT itself?
> =

> The first case.
> We have a single register in a fixed location which contains =

> the frequency of the main system clock.
> This allows us to use the same image in emulation, FPGA
> and simulation without any changes.
> We usually don=E2=80=99t use a full bootloader, just a simple wrapper,
> which initializes the necessary stuff and jumps to the kernel.

So the hardware team has decided to throw a frequency register in there?
Alright! Does that fixed rate clk generate its fixed rate from some
other clk? I'm curious if this fixed rate clk has a parent source.

It would also be good to make sure that any clks registered from this
driver can't be populated from regions of memory like DDR. Can you
confirm? I think it will fail, but it would be worth checking

> =

> > =

> >> diff --git a/drivers/clk/clk-fixed-mmio.c b/drivers/clk/clk-fixed-mmio=
.c
> >> new file mode 100644
> >> index 0000000000..bbcadab345
> >> --- /dev/null
> >> +++ b/drivers/clk/clk-fixed-mmio.c
> =

> > =

> >> +}
> >> +
> >> +CLK_OF_DECLARE(fixed_mmio_clk, "fixed-mmio-clock", of_fixed_mmio_clk_=
setup);
> > =

> > Any reason why this can't be a platform driver? It would make this much
> > less DT specific and usable on other firmwares/platforms if we used a
> > platform driver here.
> > =

> =

> I looked at the fixed rate clock as a reference, but I can change it to =

> a platform driver, if that=E2=80=99s preferred.
> =


Yes I'd prefer a platform driver unless there's some reason it can't be
done. We may need to have both in case this needs to be populated very
early, but if that isn't the case then just a platform driver for now.

