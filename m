Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589B6C71133
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199D62064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThIHLxN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 199D62064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbeJPA0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:26:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbeJPA0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:26:00 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E35E2064A;
        Mon, 15 Oct 2018 16:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539621600;
        bh=oIex2p71clyMSay0LRz6xowbOFyFf7M7CbX5q2AgmGk=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=ThIHLxN+A9UJFW3FqIc73rSeN6febmV2iJ3BvKDA5BRASdInF5tsTXT50kXAawBrG
         eWD3ss1o8WY5KoGPFiSJyVWbuhX7SnYM1ZOpIaHjyusZrT5TbYLqtIyrauErQS8eD8
         wxJfS36aes0mMmW5VdbsM9uTdPwKR6zau2Fk2oNs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181015104905.GF1653@imbe.wolfsonmicro.main>
Cc:     broonie@kernel.org, lee.jones@linaro.org, linus.walleij@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20181008132542.19775-1-ckeepax@opensource.cirrus.com>
 <20181008132542.19775-3-ckeepax@opensource.cirrus.com>
 <153924124658.207691.10370075148426001371@swboyd.mtv.corp.google.com>
 <20181011132602.GD1653@imbe.wolfsonmicro.main>
 <153935999691.5275.1587207165396958375@swboyd.mtv.corp.google.com>
 <20181015104905.GF1653@imbe.wolfsonmicro.main>
Message-ID: <153962159992.5275.9275448716859702011@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 3/5] clk: lochnagar: Add support for the Cirrus Logic Lochnagar
Date:   Mon, 15 Oct 2018 09:39:59 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Charles Keepax (2018-10-15 03:49:05)
> On Fri, Oct 12, 2018 at 08:59:56AM -0700, Stephen Boyd wrote:
> > Quoting Charles Keepax (2018-10-11 06:26:02)
> > > On Thu, Oct 11, 2018 at 12:00:46AM -0700, Stephen Boyd wrote:
> > > > Quoting Charles Keepax (2018-10-08 06:25:40)
> > > > > +struct lochnagar_clk_priv {
> > > > > +       struct device *dev;
> > > > > +       struct lochnagar *lochnagar;
> > > > =

> > > > Is this used for anything besides getting the regmap? Can you get t=
he
> > > > pointer to the parent in probe and use that to get the regmap point=
er
> > > > from dev_get_remap() and also use the of_node of the parent to regi=
ster
> > > > a clk provider? It would be nice to avoid including the mfd header =
file
> > > > unless it's providing something useful.
> > > > =

> > > =

> > > It is also used to find out which type of Lochnagar we have
> > > connected, which determines which clocks we should register. I
> > =

> > Can that be done through some device ID? So the driver can be untangled
> > from the MFD part.
> > =

> > > could perhaps pass that using another mechanism but we would
> > > still want to include the MFD stuff to get the register
> > > definitions. So this approach seems simplest.
> > =

> > Can the register definitions be moved to this clk driver?
> > =

> > Maybe you now get the hint, but I'd really like to be able to merge and
> > compile the clk driver all by itself without relying on the parent MFD
> > device to provide anything at compile time.
> > =

> =

> If you feel strongly but since the MFD needs to hold the regmap
> (which needs to define the read/volatile regs and defaults)
> these will need to be duplicate defines and personally i would
> rather only have one copy as it makes updating things much less
> error prone.

Ok if there's going to be read/volatile regs and defaults then it makes
sense to leave the defines in some shared header file, which is
unfortunate for the independent merge of driver bits. Either way, I
would prefer we don't use struct lochnagar in this driver and move to
more generic structures like struct regmap and express the type of MFD
to this device driver some other way.

> =

> > > > > +       if (lclk->regmap.dir_mask) {
> > > > > +               ret =3D regmap_update_bits(regmap, lclk->regmap.c=
fg_reg,
> > > > > +                                        lclk->regmap.dir_mask,
> > > > > +                                        lclk->regmap.dir_mask);
> > > > > +               if (ret < 0) {
> > > > > +                       dev_err(priv->dev, "Failed to set %s dire=
ction: %d\n",
> > > > =

> > > > What does direction mean?
> > > > =

> > > =

> > > Some of the clocks can both generate and receive a clock. For
> > > example the PSIA (external audio interface) MCLKs, the attached
> > > device could be expecting or providing a master audio clock. If
> > > the user assigns a parent to the clock we assume the attached
> > > device is providing a clock to us, otherwise we assume we are
> > > providing the clock.
> > =

> > And this directionality is determined by dir_mask? It would be great if
> > this sort of information was in the commit text or in a comment in the
> > driver so we know what's going on here.
> > =

> =

> No problem will make this more clear.
> =


Thanks!

