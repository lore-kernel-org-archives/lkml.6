Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8F7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B0E520831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0E520831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbeKSVEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 16:04:04 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41114 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbeKSVED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 16:04:03 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 4D9BB808C7; Mon, 19 Nov 2018 11:40:44 +0100 (CET)
Date:   Mon, 19 Nov 2018 11:40:46 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quozl@laptop.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        devel@driverdev.osuosl.org, Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 06/15] Platform: OLPC: Add XO-1.75 EC driver
Message-ID: <20181119104046.GC28607@amd>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-7-lkundrak@v3.sk>
 <CAHp75VcefOJHZ3WdZYrGEJFjqg2s1oJ75Jg9gKmQFre_ScAPZg@mail.gmail.com>
 <8881f5e48613c9d9d133e3964031fe2ab57f4801.camel@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+nBD6E3TurpgldQp"
Content-Disposition: inline
In-Reply-To: <8881f5e48613c9d9d133e3964031fe2ab57f4801.camel@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+nBD6E3TurpgldQp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > +#include <linux/delay.h>
> > > +#include <linux/gpio/consumer.h>
> > > +#include <linux/spinlock.h>
> > > +#include <linux/completion.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/ctype.h>
> > > +#include <linux/olpc-ec.h>
> > > +#include <linux/spi/spi.h>
> > > +#include <linux/reboot.h>
> > > +#include <linux/input.h>
> > > +#include <linux/kfifo.h>
> > > +#include <linux/module.h>
> > > +#include <linux/power_supply.h>
> >=20
> > Easy to maintain when it's sorted.

No / it depends.

> > > +       channel =3D priv->rx_buf[0];
> > > +       byte =3D priv->rx_buf[1];
> >=20
> > Maybe specific structures would fit better?
> >=20
> > Like
> >=20
> > struct olpc_ec_resp_hdr {
> >  u8 channel;
> >  u8 byte;
> > ...
> > }

Structures have padding and other nastyness...

> > > +                       pm_wakeup_event(priv->pwrbtn->dev.parent,
> > > 1000);
> >=20
> > Magic number.

Nothing wrong with magic numbers.

> > > +       args[0] =3D mask & 0xff;
> > > +       args[1] =3D (mask >> 8) & 0xff;
> >=20
> > ...mask >> 0;
> > ...mask >> 8;

No, please.

> > __maybe_unused  instead of ugly #ifdef?
> >=20
> > > +{
> > > +       struct platform_device *pdev =3D to_platform_device(dev);
> > > +       struct olpc_xo175_ec *priv =3D platform_get_drvdata(pdev);
> >=20
> > dev_get_drvdata() or how is it called?
> >=20
> > > +       unsigned char hintargs[5];
> >=20
> > struct olpc_ec_hint_cmd {
> > u8 ...
> > u32 ...
> > };
> >=20
> > ?

No, unless you want to break the code. Or add __attribute__ packed and
deal with endianness.

Just no.

> > > +       static unsigned int suspend_count;
> >=20
> > u32 I suppose.

You know, there's semantic difference between unsigned int and
u32. And this sounds like candidate for unsigned int.

> > > +       /* Enable all EC events while we're awake */
> > > +       olpc_xo175_ec_set_event_mask(0xffff);
> >=20
> > #define EC_ALL_EVENTS GENMASK(15, 0)

Actually that's less readable. Just don't.

> > > +static const struct of_device_id olpc_xo175_ec_of_match[] =3D {
> > > +       { .compatible =3D "olpc,xo1.75-ec" },
> > > +       { },
> >=20
> > No comma for terminators.

Comma is fine.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--+nBD6E3TurpgldQp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvyky4ACgkQMOfwapXb+vI2VACgq3L4bT9Babbvon3rC4cRz11g
UaAAoJve3CamopvVPFBQrLLdYPAzTcuv
=Tfuz
-----END PGP SIGNATURE-----

--+nBD6E3TurpgldQp--
