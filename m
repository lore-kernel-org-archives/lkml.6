Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB62EC67877
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2E821470
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB2E821470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbeJMAsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:48:37 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:44161 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbeJMAsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:48:37 -0400
X-Originating-IP: 2.224.242.101
Received: from w540 (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 337A824000E;
        Fri, 12 Oct 2018 17:15:04 +0000 (UTC)
Date:   Fri, 12 Oct 2018 19:14:58 +0200
From:   jacopo mondi <jacopo@jmondi.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Cheng-yi Chiang <cychiang@chromium.org>
Subject: Re: [PATCH v2] regulator/gpio: Allow nonexclusive GPIO access
Message-ID: <20181012171458.GA21294@w540>
References: <20181012125412.21324-1-linus.walleij@linaro.org>
 <20181012142612.GJ7677@w540>
 <20181012164424.GE2340@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <20181012164424.GE2340@sirena.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Mark,

On Fri, Oct 12, 2018 at 06:44:24PM +0200, Mark Brown wrote:
> On Fri, Oct 12, 2018 at 04:26:12PM +0200, jacopo mondi wrote:
>
> > Sorry, I'm going slightly OT with this, but please read below.
>
> > On Fri, Oct 12, 2018 at 02:54:12PM +0200, Linus Walleij wrote:
> > > This allows nonexclusive (simultaneous) access to a single
> > > GPIO line for the fixed regulator enable line. This happens
>
> > I might have a use case for shared GPIO lines used as 'simple' reset
> > signal for camera devices and not for regulators.
>
> This recently came up in ASoC too with audio CODECs sharing reset lines,
> there was a discussion started with the reset API maintainer though no
> response yet.  CCing in Cheng-yi who had that problem.  Not deleting
> context for that.
>

Thanks

> > See drivers/media/i2c/ov772x.c FIXME note in power_on() function at:
> > https://elixir.bootlin.com/linux/latest/source/drivers/media/i2c/ov772x.c#L832
> >
> > The reset line is in this case is passed to the driver by board file:
> > https://elixir.bootlin.com/linux/latest/source/arch/sh/boards/mach-migor/setup.c#L350
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

That's exactly why the current implementation in those drivers is not
even sub-optimal :)

> was relatively easy in the sysetm Cheng-yi has as it's just one driver
> but what if there's mutiple drivers?  That's relatively likely with
> audio where you might have something like a CODEC with a separate power
> amplifier.  The regulator enable stuff is handling this in the core but
> it's less clear where to put that for reset lines.
>

Isn't DT the natural place where to define a reset line (or any kind of
shared GPIO line) as shared? And for non-OF archs, the board file?

Maybe I should start by adding the NONEXCLUSIVE flags to the ones accepted
by gpio lookup tables and see how it looks?

Thanks
   j


> > Please note this is an ancient architecture that boots from board
> > files, but the same might happen in modern designs with OF support. Is
> > there any clean way to handle shared GPIOs I might not be aware of for
> > those systems?



--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJbwNaSAAoJEHI0Bo8WoVY8jpEP/iMtE8WGuPKbp6qSryA7UQRt
3ggtnuAvLdTfH6XDfESHrPjcUTbwdeqMQC+/LzcOw5ofQMbMWCUEf4SwI2V2ewGh
HzMprnLGIrFF8oeq45pkhET4dcsj08x//DbxKc0nqtm3/sDXZyYIbIl+X2c20VAl
QPuuhdV00YF86yTJMr1s6qkk6nbMVZzzk4s4SyCUciA0XVIlrCJMCcg/ZqvnSHMM
Gxb4/L7oK2/AMKmF+Ibjvj+skMyWEbs+zO/LWevp5YLCsYb9JtoDopSuslresemc
UHH2u23+0gozeb8MrTD/yyWPlRghCNb7PeWA1GxDlFqj7NX7QcW1ot+fkMjp3GeA
4kSzm53TMBnS2jsxfJTJ/wm3uKDQtQPW15XBELw01LJFua1Eo6d65u6daOZ8D6im
qYuLKi6BS7jMtmmttmtwBEG8u6qb3I/rA6rQlhQVl/E/QDynpzL5xWfk2Sy7LvQj
mZoGppGTYhQRnKTtRJxvUgYqln2UHy7FmdNBFqahW+AvWY3kB4i46E8WMXtQttM5
fXDLIlc4f8ESqFXoiWsIRrtZHsUdeEoWpYqQ+lqqiMXs0rP1195n0JfTVazJCLSg
2JL6lRgcf6WiFh3mGLwOVIp5oHgx2PigAdhFfRpcpTYd0i8Ml+rbS6SvjTVh0JtC
1SKFLP07qQuc/WR7aCTV
=+HDt
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
