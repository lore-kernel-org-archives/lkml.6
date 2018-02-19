Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752753AbeBSMUu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 07:20:50 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:60970 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752678AbeBSMUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 07:20:48 -0500
Date: Mon, 19 Feb 2018 13:20:46 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Philipp Rossak <embed3d@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Alessandro Zummo <a.zummo@towertech.it>,
        alexandre.belloni@bootlin.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>, linux-rtc@vger.kernel.org,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v3] rtc: ac100: Fix ac100 determine rate bug
Message-ID: <20180219122046.kap53tbui6av5irl@flea.lan>
References: <20180214135612.21356-1-embed3d@gmail.com>
 <20180215141154.monvwx25awwetqrc@flea.lan>
 <00ece3d8-52ac-c51d-1867-97f7fd84dadf@gmail.com>
 <CAGb2v67fP4-xxAAPWAa0+YtWY3xvQX=5XX7koq-h8USvT+YA-A@mail.gmail.com>
 <20180216130741.jjtjwbnjcmsnz3ds@flea.lan>
 <CAGb2v64xzVO0n8vTx9TfaoPPXv-85OoDk9y4k5KgLfkz70w2FA@mail.gmail.com>
 <aae613df-f7d8-d9dd-306b-fcda2bbb770f@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oizlize64jg2tdqs"
Content-Disposition: inline
In-Reply-To: <aae613df-f7d8-d9dd-306b-fcda2bbb770f@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oizlize64jg2tdqs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2018 at 06:55:58PM +0100, Philipp Rossak wrote:
> On 16.02.2018 14:15, Chen-Yu Tsai wrote:
> > On Fri, Feb 16, 2018 at 9:07 PM, Maxime Ripard
> > <maxime.ripard@bootlin.com> wrote:
> > > On Fri, Feb 16, 2018 at 12:10:18PM +0800, Chen-Yu Tsai wrote:
> > > > > diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
> > > > > b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
> > > > > index 6550bf0e594b..6f56d429f17e 100644
> > > > > --- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
> > > > > +++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
> > > > > @@ -175,11 +175,18 @@
> > > > >                          compatible =3D "x-powers,ac100-rtc";
> > > > >                          interrupt-parent =3D <&r_intc>;
> > > > >                          interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;
> > > > > -                       clocks =3D <&ac100_codec>;
> > > > > +                       clocks =3D <&ac100_rtc_32k>;
> > > > >                          #clock-cells =3D <1>;
> > > > >                          clock-output-names =3D "cko1_rtc",
> > > > >                                               "cko2_rtc",
> > > > >                                               "cko3_rtc";
> > > > > +
> > > > > +                       ac100_rtc_32k: rtc-32k-oscillator {
> > > > > +                               compatible =3D "fixed-clock";
> > > > > +                               #clock-cells =3D <0>;
> > > > > +                               clock-frequency  =3D <32768>;
> > > > > +                               clock-output-names =3D "ac100-rtc=
-32k";
> > > > > +                       };
> > > > >                  };
> > > > >          };
> > > > >   };
> > > > >=20
> > > > > What do you think about that solution?
> > > >=20
> > > > That's not quite right either. As I mentioned before, the
> > > > RTC block has two clock inputs, one 4MHz signal from the
> > > > codec block, and one 32.768 kHz signal from an external
> > > > crystal. The original device tree binding describes the
> > > > first one, and the 32.768 kHz clock was registered by
> > > > the RTC driver internally.
> > > >=20
> > > > If you're going to add the crystal clock, you still need
> > > > to keep the codec one. Note that this does not fix what
> > > > Maxime is asking you. I've already provided an explanation:
> > > >=20
> > > > The clock core allows registering clocks with not-yet-existing
> > > > clock parents. Parents are matches by string names. If no
> > > > clock by that name is registered yet, the clock core simply
> > > > orphans the new clock if the unregistered parent is its
> > > > current parent or simply ignores that parent if its not the
> > > > current parent. This is entirely valid and is what we are
> > > > counting on here, as we haven't implemented the codec-side
> > > > driver.
> > >=20
> > > So, we end up in a situation where clk_hw_get_num_parents returns the
> > > amount of clocks we can be parented to (orphans or not), but
> > > clk_hw_get_parent_by_index will not return the orphan clocks?
> >=20
> > There is no placeholder for missing parents, unlike the regulator
> > subsystem that has a dummy regulator for this purpose.
> >=20
> > > That's pretty bad :/
> >=20
> > Yeah. I didn't expect this to happen. But to be fair, I should
> > have done the check on clk_hw_get_parent_by_index.
> >=20
> > > Is there a way to test before registering that all our parents are
> > > actually there? clk_get?
> >=20
> > That's probably the way to do it. However in the AC100 RTC case,
> > I left it open to be missing on purpose, so we could use the RTC
> > without waiting for the codec to be supported.
> >=20
> > ChenYu
> >=20
>=20
> So how should we proceed with this issue?
>=20
> Should I send a new version with a fixed comment or should I implement the
> check in clk_get function?
>=20
> For the second option I will need about 3 weeks to submit a proper patch
> since I have the next two weeks some other stuff to do.
> If a proper fix is required earlier, it might be better if someone else is
> taking care about a fix.

A better comment will do.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--oizlize64jg2tdqs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqKwR0ACgkQ0rTAlCFN
r3QYxQ/+JVdimX2RS0HAaySW/q4zrw1CDQsaxBcoyHyakR6FoFaR10mNn6JXb/V6
1nOhpoqDit3eQggfrBOZ1uhkSKrT5Kub+mAad696p3lxc+GhLg7d04YWjuWJEst5
1ip1fUc9Cx2QjayWtkNF7Ci+kP9FH4SzR8c6tdwNievwvVyubQKNoBU/iUV0nbf3
Kf++5GiixXDwIa1FIHb65hqjiuqPOBm4OPHZ8dDMi6j9WCs8V7RTPvdVUJPA+wQO
h8mzL6o3TT4npTLOkdOeHxpsjOeX00vZJFFgQI70Euuj/UrZ4/4ZcxxCR/+wrp0q
hmQ6BBqJbjosJQmgmhgljvq/qseR+OKtxHFBmC/QK3ss58b3sZ0AoGFezFj/uUnX
TPQASjIQbRksBMzb0zCsyWTAcoSXDUJESSMXlByNM9TKFYVdaV3czECZjohXXhSY
F/oul/BzIuu+5315ieH+M7tRnz1RXN42nE3JtyH5SxdKVHmY+te4zFSaudi0on+0
YG2pQdDmldiuu+B5POjiqqmw4ij66qha/6EaxSdbBYZj/jDBBo/ptHs7Zis3MQfJ
l8n5dDbHo9ndmCf0vV7/sSZ+1At12CxrmPHfChnHJ8j0cQR6/JdgppjsmKVhHEL1
ZuEvytlZHD66aNrXsuyJAZH4LhvPVCNsf/oN5sPlCHmZiROnvec=
=NFwc
-----END PGP SIGNATURE-----

--oizlize64jg2tdqs--
