Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 42FECC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07FF208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07FF208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965569AbeFOJEZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 05:04:25 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43687 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755675AbeFOJEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 05:04:24 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 716D3207A8; Fri, 15 Jun 2018 11:04:22 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-37-30.w90-88.abo.wanadoo.fr [90.88.156.30])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3C85120728;
        Fri, 15 Jun 2018 11:04:12 +0200 (CEST)
Date:   Fri, 15 Jun 2018 11:04:12 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] crypto: sun4i-ss: prevent deadlock on emulated hardware
Message-ID: <20180615090412.xgw35ga5cvc6w3h3@flea>
References: <20180614193659.29261-1-clabbe.montjoie@gmail.com>
 <20180615075754.b3ivyagjsomiafwk@flea>
 <20180615081554.GA3047@Red>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2mo5zrs2piu4jjwq"
Content-Disposition: inline
In-Reply-To: <20180615081554.GA3047@Red>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2mo5zrs2piu4jjwq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 15, 2018 at 10:15:54AM +0200, Corentin Labbe wrote:
> On Fri, Jun 15, 2018 at 09:57:54AM +0200, Maxime Ripard wrote:
> > On Thu, Jun 14, 2018 at 09:36:59PM +0200, Corentin Labbe wrote:
> > > Running a qemu emulated cubieboard with sun4i-ss driver enabled led t=
o a never
> > > ending boot.
> > > This is due to sun4i-ss deadlocked and taking all cpu in an infinite =
loop.
> > > Since the crypto hardware is not implemented, all registers are read =
as 0.
> > > So sun4i-ss will never progress in any operations. (TX_CNT being alwa=
ys 0)
> > >=20
> > > The first idea is to add a "TX_CNT always zero timeout" but this made=
 cipher/hash loops
> > > more complex and prevent a case that never happen on real hardware.
> > >=20
> > > The best way to fix is to check at probe time if we run on a virtual
> > > machine with hardware emulated but non-implemented and prevent
> > > sun4i-ss to be loaded in that case.
> > > Letting sun4i-ss to load is useless anyway since all crypto algorithm=
 will be
> > > disabled since they will fail crypto selftests.
> > >=20
> > > Tested-on: qemu-cubieboard
> > > Tested-on: cubieboard2
> > >=20
> > > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > > ---
> > >  drivers/crypto/sunxi-ss/sun4i-ss-core.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >=20
> > > diff --git a/drivers/crypto/sunxi-ss/sun4i-ss-core.c b/drivers/crypto=
/sunxi-ss/sun4i-ss-core.c
> > > index a81d89b3b7d8..a178e80adcf3 100644
> > > --- a/drivers/crypto/sunxi-ss/sun4i-ss-core.c
> > > +++ b/drivers/crypto/sunxi-ss/sun4i-ss-core.c
> > > @@ -341,9 +341,18 @@ static int sun4i_ss_probe(struct platform_device=
 *pdev)
> > >  	 * I expect to be a sort of Security System Revision number.
> > >  	 * Since the A80 seems to have an other version of SS
> > >  	 * this info could be useful
> > > +	 * Detect virtual machine with non-implemented hardware
> > > +	 * (qemu-cubieboard) by checking the register value after a write t=
o it.
> > > +	 * On non-implemented hardware, all registers are read as 0.
> > > +	 * On real hardware we should have a value > 0.
> > >  	 */
> > >  	writel(SS_ENABLED, ss->base + SS_CTL);
> > >  	v =3D readl(ss->base + SS_CTL);
> > > +	if (!v) {
> > > +		dev_err(&pdev->dev, "Qemu with non-implemented SS detected.\n");
> > > +		err =3D -ENODEV;
> > > +		goto error_rst;
> > > +	}
> >=20
> > This is wrong way to tackle the issue. There's multiple reason why
> > this could happen (for example the device not being clocked, or
> > maintained in reset). There's nothing specific about qemu here, and
> > the fundamental issue isn't that the device isn't functional in qemu,
> > it's that qemu lies about which hardware it can emulate in the DT it
> > passes to the kernel.
> >=20
> > There's no way this can scale, alone from the fact that qemu should
> > patch the DT according to what it can do. Not trying to chase after
> > each and every device that is broken in qemu.
> >=20
> > NAK.
> >=20
>=20
> My fix detect also when the device is badly clocked.

In which case, the proper fix is to enable the clock, not throw the
kernel's arm up in the air.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--2mo5zrs2piu4jjwq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsjgQsACgkQ0rTAlCFN
r3Q/Qw/8DzFoF1LNepl/4PZwJttI9CcYPWdGv6NQKkgPwbepZEgeYoBdS5BT5N40
SWMsH8B1G/lEP9frsi5Oo9YaDvh3aodAvTkeTHKFzbhlS2GMNutuh33zay+pIXvm
i024Gj3Ly3zME1zkjep/3k203DnlgSIQ6FCOnd7fGGN7j5C3WqkKKL54A62Xatje
Om+CHjIPSG95TaTYG3aD7wNpIeaBpIkG0xuu3bXtmK4Q6/7DVXw3vAhAZtCrs84Z
/A3f03vsJ8vDgGMIu60cH1BONVxE37SH+axkoeOhN8qfDxTUo4xoo65NwRAb+i/x
z73D8BxTX8ZXEfsTQuU9vnetzl5gmO/bBu+90dtQF90InFdHZegHWLpTk1xnhcAZ
bfKJDPB1E4fqpnaEI/TahMJMjXqInjhNb/BbfU4HgVAMnxRI+t+5vwLzrya4LDwv
bDzqCu2UqrqF5+HhQbRcLDpl0crMhZELILUS7Mwfn9nM24fo8U3yIfg+01thASBF
P3SGA6A4bGLFCm1BZRi3DHGyJyBWKRfSHgU6+0WUdIjLMuYFBVpXJY94W913kdU+
vQ9jdvc9xC8HjR9gtSMq4bsYGErVtXZYSn1oQMrHj09AtjEXvZ04d+uSW/J6M9V6
lO6iABy6A474iYHvto7VWwi9gRGZDjIoqLvMgkhchHbmhQYGKl0=
=ikzN
-----END PGP SIGNATURE-----

--2mo5zrs2piu4jjwq--
