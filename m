Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754718AbeBNMPh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 07:15:37 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:51139 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754330AbeBNMPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 07:15:35 -0500
Date: Wed, 14 Feb 2018 13:15:23 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Philipp Rossak <embed3d@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>, linux-rtc@vger.kernel.org
Subject: Re: [linux-sunxi] [PATCH v2] rtc: ac100: Fix ac100 determine rate bug
Message-ID: <20180214121523.mn7y4xnf3wzttlvc@flea.home>
References: <20180213121414.7000-1-embed3d@gmail.com>
 <20180213133201.kwq4aatpts7nerc2@flea.lan>
 <CAGb2v64tOCeD38gGR_fboC6PJCCD8L-EPu196MGrGgHLenkQXw@mail.gmail.com>
 <8142b42d-bf8d-0903-e26e-1499f95e51d5@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pylvygszhgwk5yqg"
Content-Disposition: inline
In-Reply-To: <8142b42d-bf8d-0903-e26e-1499f95e51d5@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pylvygszhgwk5yqg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2018 at 04:23:00PM +0100, Philipp Rossak wrote:
>=20
>=20
> On 13.02.2018 14:44, Chen-Yu Tsai wrote:
> > On Tue, Feb 13, 2018 at 9:32 PM, Maxime Ripard
> > <maxime.ripard@bootlin.com> wrote:
> > > On Tue, Feb 13, 2018 at 01:14:14PM +0100, Philipp Rossak wrote:
> > > > This patch fixes a bug, that prevents the Allwinner A83T and the A80
> > > > from a successful boot. You can find the shortend trace below:
> > >=20
> > > Since when is it there?
> > >=20
> The bug is there since v4.16-rc1 and appeared after the clk branch was
> merged.
>=20
> ^^ Should I add this info also in the commit message?

Yes

> > > > Unable to handle kernel NULL pointer dereference at virtual address
> > > > 00000000
> > > > pgd =3D (ptrval)
> > > > [00000000] *pgd=3D00000000
> > > > Internal error: Oops: 5 [#1] SMP ARM
> > > > Modules linked in:
> > > > CPU: 0 PID: 49 Comm: kworker/0:1 Not tainted 4.15.0-10190-gb89e32cc=
d1be #2
> > > > Hardware name: Allwinner sun8i Family
> > > > Workqueue: events deferred_probe_work_func
> > > > PC is at clk_hw_get_rate+0x0/0x34
> > > > LR is at ac100_clkout_determine_rate+0x48/0x19c
> > > >=20
> > > > [ ... ]
> > > >=20
> > > > (clk_hw_get_rate) from (ac100_clkout_determine_rate+0x48/0x19c)
> > > > (ac100_clkout_determine_rate) from  (clk_core_set_rate_nolock+0x3c/=
0x1a0)
> > > > (clk_core_set_rate_nolock) from (clk_set_rate+0x30/0x88)
> > > > (clk_set_rate) from (of_clk_set_defaults+0x200/0x364)
> > > > (of_clk_set_defaults) from (platform_drv_probe+0x18/0xb0)
> > > >=20
> > > > To fix that bug, we first check if the return of the
> > > > clk_hw_get_parent_by_index is non zero. If it is zero we skip that
> > > > clock parent.
> > > >=20
> > > > The BUG report could be found here: https://lkml.org/lkml/2018/2/10=
/198
> > > >=20
> > > > Fixes: 04940631b8d2 ("rtc: ac100: Add clk output support")
> > >=20
> > > Should it be sent to stable?
> > >=20
> > > > Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> > > > ---
> > > >=20
> > > > Changes in v2:
> > > >        * add tag Fixes: ... to commit message
> > > >        * add comment to if statement why we are doing this check
> > > >=20
> > > >   drivers/rtc/rtc-ac100.c | 12 +++++++++++-
> > > >   1 file changed, 11 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/rtc/rtc-ac100.c b/drivers/rtc/rtc-ac100.c
> > > > index 8ff9dc3fe5bf..ba73201d8cc1 100644
> > > > --- a/drivers/rtc/rtc-ac100.c
> > > > +++ b/drivers/rtc/rtc-ac100.c
> > > > @@ -183,7 +183,17 @@ static int ac100_clkout_determine_rate(struct =
clk_hw *hw,
> > > >=20
> > > >        for (i =3D 0; i < num_parents; i++) {
> > > >                struct clk_hw *parent =3D clk_hw_get_parent_by_index=
(hw, i);
> > > > -             unsigned long tmp, prate =3D clk_hw_get_rate(parent);
> > > > +             unsigned long tmp, prate;
> > > > +
> > > > +             /*
> > > > +              * We purposefully left open the possibility to use t=
he clock
> > > > +              * from the codec side but it is not implemented righ=
t now.
> > > > +              * Thus we need to check if the parent exists.
> > > > +              */
> > > > +             if (!parent)
> > > > +                     continue;
> > > > +
> > > > +             prate =3D clk_hw_get_rate(parent);
> > >=20
> > > clk_hw_get_num_parents should return the exact number of parents,
> > > which is going to be 1 if you only have one parent, like all DTS seems
> > > to have.
> > >=20
> > > If not, then it should be explained in the comment and / or fixed
> > > properly.
> >=20
> > The clock has two parents. One is a fixed clock internally registered
> > by the driver. This is actually an external crystal, and we should
> > probably add a device node and the works for it. The other parent
> > is a clock from the codec side, which we properly declare and
> > reference in the device tree. This clock, though defined, is not
> > implemented in any driver (because we don't have any ATM).
> >=20
> > This second missing clock is what's causing issues here. The clk core
> > looks for the parent by name, can't find one that is registered, and
> > returns NULL.
> >=20
> > I guess the comment above is still not clear enough?
>=20
> I can get more detailed in the comment. I thought about this:
>=20
> The clock has two parents, one is a fixed clock which is internally
> registered by the ac100 driver. The other parent is a clock from the codec
> side of the chip, which we properly declare and reference in the devicetr=
ee
> and is not implemented in any driver right now.
> If the clock core looks for the parent of that second missing clock, it
> can't one that is registered and returns NULL.
> Thus we need to check if the parent exists before we get the parent rate.
>=20
> Is that ok for you?

Yep, much better thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--pylvygszhgwk5yqg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqEKFoACgkQ0rTAlCFN
r3R6+g/9EkVMyNql+oUq7TEdt+/9b3SEFcklEa7Ojmt+y1RdrS3xZMVBhOqkgisE
vJ73rBLV+ZzfD7SVVyfOTuhXRLXKkS36wXMkX30RJW0BiskFdHwBgYq1F/ZmGzBV
fmKvGQ0YMa8VPdUg4sXlBT3gFufXRh9HCqMgir25oefVg8QAkJCsKY7PVrKNXtcL
v4o1ybA/z1rEQrS7S9v+CeHaq4YJYAupsRRcFbdGaPz9VKgO5aun58E3HEmDm4tt
odiVezkeMS9koy/z8dQtTqOmilbKns9cUqWqryivBRRp4hYD2Mh416j/vef2dVX0
PLfQBl3Ah+e9CpHSVFmAI732RdVdq2CVcgYlqoFythjSrwwwlbdJOnud3ZPXX153
wwziXbHHRnCEEiCN+8Mu4KiDPfjOKDu/7xdVWIxhTXnwMirJd6uGRkMdbBxNlCWr
AybJM/7vO52t1gAJnTWoAVX8nTySCDKhi/SWlGs8ehA+K9OciWSx351F51HBDo93
we43Q9B7/AbScI8dsjadjTiRWV57MWsJpBPNybami901g6eLxhNxanadXP1GmXle
l8h7g760gIgCameEEgsByCVsdly0pvMJfXfSao4YAlogdIRvqstPMnQJ1/CCTAvZ
zfqiWxGyX2qr6+VQxwXqRjPLOLxP/as3WRnWOmdTpBAtTXOIVE8=
=pDCL
-----END PGP SIGNATURE-----

--pylvygszhgwk5yqg--
