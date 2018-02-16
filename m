Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968074AbeBPNHy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 08:07:54 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:50812 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967920AbeBPNHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 08:07:53 -0500
Date: Fri, 16 Feb 2018 14:07:41 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Philipp Rossak <embed3d@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>, alexandre.belloni@bootlin.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>, linux-rtc@vger.kernel.org,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v3] rtc: ac100: Fix ac100 determine rate bug
Message-ID: <20180216130741.jjtjwbnjcmsnz3ds@flea.lan>
References: <20180214135612.21356-1-embed3d@gmail.com>
 <20180215141154.monvwx25awwetqrc@flea.lan>
 <00ece3d8-52ac-c51d-1867-97f7fd84dadf@gmail.com>
 <CAGb2v67fP4-xxAAPWAa0+YtWY3xvQX=5XX7koq-h8USvT+YA-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b3q5udco5vc26b62"
Content-Disposition: inline
In-Reply-To: <CAGb2v67fP4-xxAAPWAa0+YtWY3xvQX=5XX7koq-h8USvT+YA-A@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b3q5udco5vc26b62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2018 at 12:10:18PM +0800, Chen-Yu Tsai wrote:
> > diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
> > b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
> > index 6550bf0e594b..6f56d429f17e 100644
> > --- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
> > +++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
> > @@ -175,11 +175,18 @@
> >                         compatible =3D "x-powers,ac100-rtc";
> >                         interrupt-parent =3D <&r_intc>;
> >                         interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;
> > -                       clocks =3D <&ac100_codec>;
> > +                       clocks =3D <&ac100_rtc_32k>;
> >                         #clock-cells =3D <1>;
> >                         clock-output-names =3D "cko1_rtc",
> >                                              "cko2_rtc",
> >                                              "cko3_rtc";
> > +
> > +                       ac100_rtc_32k: rtc-32k-oscillator {
> > +                               compatible =3D "fixed-clock";
> > +                               #clock-cells =3D <0>;
> > +                               clock-frequency  =3D <32768>;
> > +                               clock-output-names =3D "ac100-rtc-32k";
> > +                       };
> >                 };
> >         };
> >  };
> >
> > What do you think about that solution?
>=20
> That's not quite right either. As I mentioned before, the
> RTC block has two clock inputs, one 4MHz signal from the
> codec block, and one 32.768 kHz signal from an external
> crystal. The original device tree binding describes the
> first one, and the 32.768 kHz clock was registered by
> the RTC driver internally.
>=20
> If you're going to add the crystal clock, you still need
> to keep the codec one. Note that this does not fix what
> Maxime is asking you. I've already provided an explanation:
>=20
> The clock core allows registering clocks with not-yet-existing
> clock parents. Parents are matches by string names. If no
> clock by that name is registered yet, the clock core simply
> orphans the new clock if the unregistered parent is its
> current parent or simply ignores that parent if its not the
> current parent. This is entirely valid and is what we are
> counting on here, as we haven't implemented the codec-side
> driver.

So, we end up in a situation where clk_hw_get_num_parents returns the
amount of clocks we can be parented to (orphans or not), but
clk_hw_get_parent_by_index will not return the orphan clocks?

That's pretty bad :/

Is there a way to test before registering that all our parents are
actually there? clk_get?

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--b3q5udco5vc26b62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqG15wACgkQ0rTAlCFN
r3QkWBAAhsEhE7SLibndHvjpa0EAe2pmJTeBgGuTgEdUSngVXvCpJ8gk4kCR6r9K
ylCdJmW0+YZUK4tmHY0PoifwcFQaFxf11vMLG5tjD7I6kBixIuKHTjflsWIBbB+b
Glzl8GNDoP4TARkGqA1HYkgNn7WG/AuDKyxA6T5QtXinPTNQLSTA6CkW4oDEeD/4
SEGHcqgYOJrWaFHl/hsFdKAdL99FQTUo8DH40mhbJlUfa+oXHkJ0+tapffuFY4Y4
ijirJgXLCYrq90RC8cC8tPJeqbCmsCCus7yYFQ6zhGYY31diavmhZ+61SkenB/Da
D3QEXCG4Ylgp7Am4MH1qcrPjbl3/PgC5LTRti9xg/ykvZTW2T5XVCvLs7iZuWElW
enDd51ofskT/W+kU5f/DHS9v7Btw6+2kQPLS1suBseGUMMZb1dieqgzad5nvfdJO
RlDofCU9eo1020ogX7sM3jblVSsPgjKWlSOFLOoZ97l6fgrq9v7Y90s5ZgGGZ5bo
ob0bhmGF89VGII1OxpUyRveqAFztN9jw1AgCSRuX78iHBt5uJg7h0utIpMsJGSUO
kKPvahsGbv3RmSdQWpvZVz8LRQ5zHype+kSEyKu2LHECupURYW/ulQ89vG8d0I/l
4wbam4I+illy8oyfMtHCRDgl01GstEprhmwdW/ALl2LxpFhd0j0=
=s8xP
-----END PGP SIGNATURE-----

--b3q5udco5vc26b62--
