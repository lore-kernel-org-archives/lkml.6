Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967496AbeCAKdT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 05:33:19 -0500
Received: from mail.bootlin.com ([62.4.15.54]:38278 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966395AbeCAKdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 05:33:13 -0500
Date: Thu, 1 Mar 2018 11:32:59 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Samuel Holland <samuel@sholland.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH 3/3] mailbox: sunxi-msgbox: Add a new mailbox driver
Message-ID: <20180301103259.nomjbwkw4xbvhbfv@flea>
References: <20180228022714.30068-1-samuel@sholland.org>
 <20180228022714.30068-4-samuel@sholland.org>
 <20180228083214.h4oi2kmjjqmoyfhn@flea>
 <fdf86770-6f45-3b3c-50ea-7a8363894639@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zp7kdmrnxtjungey"
Content-Disposition: inline
In-Reply-To: <fdf86770-6f45-3b3c-50ea-7a8363894639@sholland.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zp7kdmrnxtjungey
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2018 at 11:19:11AM -0600, Samuel Holland wrote:
> Hi,
>=20
> On 02/28/18 02:32, Maxime Ripard wrote:
> > On Tue, Feb 27, 2018 at 08:27:14PM -0600, Samuel Holland wrote:
> >> +	/*
> >> +	 * The failure path should not disable the clock or assert the reset,
> >> +	 * because the PSCI implementation in firmware relies on this device
> >> +	 * being functional. Claiming the clock in this driver is required to
> >> +	 * prevent Linux from turning it off.
> >> +	 */
> >> +	ret =3D clk_prepare_enable(clk);
> >> +	if (ret) {
> >> +		dev_err(dev, "Failed to enable bus clock: %d\n", ret);
> >> +		return ret;
> >> +	}
> >=20
> > You don't need it to be always on though. You only need it to be
> > enabled when you access the registers (on both sides I guess?). So you
> > could very well enable the clock in your registers accessors in Linux,
> > and do the same in the ARISC firmware. That should work.
>=20
> It does need to always be on because the *PSCI* implementation (ATF) also=
 uses
> SCPI concurrently with Linux (on a separate channel). Turning off the clo=
ck
> anywhere in Linux could turn it off in the middle of a PSCI SCPI call on a
> different CPU, causing ATF to hang in EL3 (which would be very bad).

Then the above code doesn't fix anything. You should mark the clock
critical, otherwise that clock will be turned off if the driver is
compiled as a module and not loaded (or loaded later), or if the
driver is not even compiled in.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--zp7kdmrnxtjungey
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqX1toACgkQ0rTAlCFN
r3QrCQ//W43iHw2yA04qQwRg+S9XCDti0+SutM54YaVxFsebKuS3lL46Cn7DZdXt
EMC+p3pDfMBpKhDDyVYDiGKVFvU1U9ho0J14esSNmos2o9t7hGByjQ54dgQMH3B3
D1K42KdbTvu7JxWmGl2k+6eLt1QIKovaB4GS2pc0IL++bZInOuOkoa1m/M2s1li3
EvdYSB1oNhuriqD+kZq4COp11iGuv4MDGtLmaIiltSXqmgb6OqGw+wNExR23kHUk
porzRqvAXODE7K/rw104xl4ykMp9f4h+eY0NLNHe2uR8inDPEpTGGNYhxKOjQFr6
XI/8gyhamQSlnaC32rlu7k07EQEm7sdMHmMyJ4awU+schNskN1b46nHMD3Uti2oM
OEpVFLn9ExFmPiTx4fVUkx8QFCCgc3xkLrFHUJuR0ikRbdciuN+fa1lF67COXoRa
AyWbBnH2SnjFu1xKurGU77ZVAA2slQdwggJp86+aYxoXGVhNoE14MgfECtUSMJ3F
TeaurYiXi876b0dYxnDoFNaY1TUE6L5rkD5QG4CDhl8s7v362Ae0/tEEDs0QSl3X
a5f1K3t24Repvcfh6mPzkGVtjOZ/JP4QFPlprVOU9nQ6yUY7ofl1AsXiWnyrWVED
rZtsmGqQdLdlgNMKK2fOsaA5jsDtoirvS/+1tJZi+mVrVA4rfZU=
=eBab
-----END PGP SIGNATURE-----

--zp7kdmrnxtjungey--
