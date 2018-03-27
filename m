Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeC0L4f (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 07:56:35 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38234 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeC0L4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 07:56:32 -0400
Date: Tue, 27 Mar 2018 19:56:06 +0800
From: Mark Brown <broonie@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: David Collins <collinsd@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, sboyd@kernel.org,
        ilina@codeaurora.org
Subject: Re: [PATCH 1/2] regulator: add QCOM RPMh regulator driver
Message-ID: <20180327115606.GC29239@sirena.org.uk>
References: <cover.1521246069.git.collinsd@codeaurora.org>
 <71fab82672524b95632cdb588c16edfc9711866a.1521246069.git.collinsd@codeaurora.org>
 <CAD=FV=Xz01ra=WS--vtA+dkb1H8wcw3UnFzXPS=zYWAQCPP5eg@mail.gmail.com>
 <184378e4-caf8-6ce3-e089-3690588fcb28@codeaurora.org>
 <CAD=FV=WsVDDaV-mMUvQWUomyBFCJZunKiyDt_K81_syoNhGRZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Content-Disposition: inline
In-Reply-To: <CAD=FV=WsVDDaV-mMUvQWUomyBFCJZunKiyDt_K81_syoNhGRZQ@mail.gmail.com>
X-Cookie: Serenity through viciousness.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 23, 2018 at 01:00:47PM -0700, Doug Anderson wrote:
> On Thu, Mar 22, 2018 at 3:31 PM, David Collins <collinsd@codeaurora.org> =
wrote:

> > There are two cases that I can think of: 1. Having a set_voltage()
> > callback allows for delaying for an RPMh request ACK during certain
> > voltage set point decreasing scenarios (to be elaborated below).

> Can't you still have a delay in set_voltage_sel()?

We have specific support for adding ramp delays, no need to open code it
in operations.

> > 2.
> > Having a get_voltage() as opposed to get_voltage_sel() callback allows =
an
> > uninitialized voltage of 0 to be returned in the case that no initial
> > voltage is specified in device tree.  This eliminates the possibility of
> > the regulator framework short-circuiting a regulator_set_voltage() call
> > that happens to match the voltage corresponding to selector 0.

> Interesting.  I suppose you could mix them (have set_voltage_sel() and
> get_voltage()) as long as you documented why you were doing it.  Then
> we'd have to see if Mark was happy with that...

This is a *terrible* idea which will almost certainly break.  If the
driver can't read values it should return an appropriate error code.

> > I'm aware of one important instance in which decreasing voltage needs a
> > delay: SD card voltage change from 3.3 V to 1.8 V.  This is the use case
> > that I had in mind with the 'max_uv < vreg->voltage' check.  However, y=
ou
> > are correct that hardware will report completion of the voltage slewing
> > early in this case since the comparator is checking for output >=3D set
> > point.  I can remove this special case check.

You can't usefully wait for voltages to fall, you can never guarantee
what the loading on the device is.  It's something the user has to
manage if they care.

> > Here is an explanation for why the "device tree mode" abstraction is
> > present in the first place.  Between different Qualcomm Technologies, I=
nc.
> > PMICs, regulators support a subset of the same modes (HPM/PWM, AUTO,
> > LPM/PFM, Retention, and pass-through).  However, the register values for
> > the same modes vary between different regulator types and different PMIC
> > families.  This patch is adding support for several PMIC4 family PMICs.
> > The values needed for to-be-released PMIC5 PMIC regulators are differen=
t.
> > As an example, here are the different values for LPM/PFM across PMIC
> > families and regulator types: PMIC4 LDO/SMPS =3D 5, PMIC4 BOB =3D 1, PM=
IC5
> > LDO/HFSMPS/BOB =3D 4, PMIC5 FTSMPS =3D N/A.  Having the "device tree mo=
de"
> > ensures that it is not possible to inadvertently specify a PMIC specific
> > mode in device tree which corresponds to the wrong type or family but
> > which aliases a value that would be accepted as correct.

> I'm OK with having the "device tree mode" abstraction, and in fact the
> current regulator framework seems to want you to have this anyway.  If
> I read the code correctly, you're required to have the conversion
> function and there's no default.

I didn't spot this in the code but something called "device tree mode"
sounds like it's going to be awfully confusing...

> > Pass-through mode (PASS) a.k.a. bypass is supported by Qualcomm
> > Technologies, Inc. buck-or-boost regulators (BOB).  When PASS is select=
ed,
> > the BOB output is directly connected to the BOB input (typically Vbat).

=2E..

> > qcom_rpmh-regulator substantially simpler.  I suppose that BOB PASS mode
> > could be handled via get_bypass() and set_bypass() regulator ops.  Doing
> > this would require more complicated ops selections in the driver since =
it

This is exactly the functionality supported by the bypass operations.
Any complexity due to the hardware design is unfortunate but honestly
the way the QC regulator stuff is designed they seem like a bit of a
lost cause on that front - they look very different to any other
hardware we've seen.

> I've never poked at the get_bypass() / set_bypass(), but it sounds
> better to me to use them.  I'm not a fan of the current hack.  Even
> aside from the bit of hackiness, I'm slightly concerned that some of
> your logic that generally assumes lower integers =3D lower power modes
> would break.

Yes, abusing the framework is just going to make things even worse. =20

> >>> +arch_initcall(rpmh_regulator_init);

> >> I always get yelled at when I try to use arch_initcall() for stuff
> >> like this.  You should do what everyone else does and use

> > I agree that consumers should handle probe deferral.  Unfortunately,
> > reality isn't always so nice.  Also, probe deferrals increase boot-up t=
ime
> > which is particularly problematic in the mobile space.

> Sigh, yeah.  I'm not a fan either.  If you can convince Mark that you
> should use arch_initcall() or subsys_initcall() I won't yell.  ...but
> in the past I've seen others get yelled at.

Do you have concrete consumers that have a good reason for doing this?

> Note: in actuality it doesn't always increase boot time a whole lot.

Note also that we now have the device dependency mechanism that Raphael
implemented with the explicit idea that that it'd be used to avoid
unneeded deferrals.

> ...but deferrals _do_ for sure increase the time for certain
> peripherals to come up, and if those peripherals are things like the
> LCD displays then it sucks.

There's been some discussion of allowing the user to specific certain
devices to target as priorities for probing which should deal with that.

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlq6MVYACgkQJNaLcl1U
h9Bsdwf+KMYIgw/6oBWCQZX5vlrCC26SOPyo9MOVD2aeEmVMFjCfmIiU6LVcz1lK
BnCuPp9gdkvu3OLkpVuyC0RV69yZW84L719ORCy8+XHCTohfmOvEaCJT+Q5rz7Mk
bZJzf4JctZNPRlPISJ34Equ2wxzTVNYn/FNPD+jEOXB7TAVeCcMdf/yPROhsC49+
sd115Pze3DUD4lX1XfaXQQ5HGgPOagnCPK9VsawyJMASmg8EAedsPPohLTcCQr+N
N5Kueh5P25jn5oUtzHxebvJtbYpLe/120HsmGxjSTb9rpQ3Gk72pQpt9XaxoAnms
6Ia1zmSAYHlEJ5svSuERClhY+OUlVA==
=0ErK
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--
