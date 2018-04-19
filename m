Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752261AbeDSMIW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 08:08:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43336 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbeDSMIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 08:08:20 -0400
Date: Thu, 19 Apr 2018 13:08:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: David Collins <collinsd@codeaurora.org>, lgirdwood@gmail.com,
        mark.rutland@arm.com, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rnayak@codeaurora.org, ilina@codeaurora.org
Subject: Re: [PATCH 1/2] regulator: add QCOM RPMh regulator driver
Message-ID: <20180419120813.GD27188@sirena.org.uk>
References: <cover.1521246069.git.collinsd@codeaurora.org>
 <71fab82672524b95632cdb588c16edfc9711866a.1521246069.git.collinsd@codeaurora.org>
 <152165924074.91116.13025068669916027026@swboyd.mtv.corp.google.com>
 <493c1f5d-df99-ca68-0f90-a7937a696f5d@codeaurora.org>
 <152411734938.46528.9676451637772936597@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="at6+YcpfzWZg/htY"
Content-Disposition: inline
In-Reply-To: <152411734938.46528.9676451637772936597@swboyd.mtv.corp.google.com>
X-Cookie: We've upped our standards, so up yours!
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18, 2018 at 10:55:49PM -0700, Stephen Boyd wrote:

> I lost the code context, but my general comment was that the modes that
> the hardware supports should come from the driver. If there's some sort
> of constraint on what those modes end up being because some board has an
> issue with some mode then we would want a binding that indicates such a

No, that's *never* how regulator constraints work.  We only change the
hardware configuration if we have explicit permission from constraints
to do so, otherwise everything is left as we found it.  That way if your
board catches fire or whatever it wasn't something that Linux initiated
just from default behaviour.

> > > Is this regulator-microvolt-offset? Ah I guess it's a thing in the RP=
Mh
> > > registers. This probably needs to be pushed into the framework and co=
me
> > > down through a 'set_headroom' op in the regulator ops via a
> > > regulator-headroom-microvolt property that's parsed in of_regulator.c.

> > The qcom,headroom-voltage property is equivalent to struct
> > regulator_desc.min_dropout_uV, but handled in hardware.  I don't see the
> > need to make a new regulator op to configure this value dynamically.

> Ok? We have other regulator ops just to configure boot time things. The
> goal is to come up with generic regulator properties that can be applied
> from the framework perspective and be used by other regulator drivers in
> the future.

This doesn't sound like what the min_dropout_uV constraint is intended
to handle - that's there for the regulator driver (not constraints) to
indicate how much headroom the regulator needs in the supply voltage in
order to provide regulation.  It's not something the regulator uses,
it's something that gets fed into voltage requests made on the supply of
the regulator which I can't see that the hardware is going to be able to
handle unaided.

> Cool. This should be a generic regulator DT property that all regulators
> can use. We have the same problem on other RPM based regulator drivers
> where boot sends a bunch of voltages because we don't know what it is by
> default out of boot and we can't read it.

Ideally future versions of the RPM will have improved interfaces,
there's a bunch of problems like this :(

> >=20
> > >> +       if (type =3D=3D RPMH_REGULATOR_TYPE_XOB && init_data->constr=
aints.min_uV) {
> > >> +               vreg->rdesc.fixed_uV =3D init_data->constraints.min_=
uV;
> > >> +               init_data->constraints.apply_uV =3D 0;
> > >> +               vreg->rdesc.n_voltages =3D 1;
> > >> +       }

> > > What is this doing? Usually constraints aren't touched by the driver.

> > For XOB managed regulators, we need to set fixed_uV to match the DT
> > constraint voltage and n_voltages =3D 1.  This allows consumers
> > regulator_set_voltage() calls to succeed for such regulators.  It works
> > the same as a fixed regulator.  I think that apply_uV =3D 0 could be le=
ft out.

> Wouldn't XOB regulators only have one voltage specified for min/max in
> DT already though? I seem to recall that's how we make set_voltage() in
> those cases work. Or it could be that drivers aren't supposed to call
> set_voltage() on single or fixed voltage regulators anyway, because
> constraints take care of it for them.

Yes, constraints that specify a single voltage are done by setting min
and max to the same value.  fixed_uV is *only* for regulators that have
a physically fixed voltage.

> > >> +       if (vreg->hw_data->mode_map) {
> > >> +               init_data->constraints.valid_ops_mask |=3D REGULATOR=
_CHANGE_MODE;

A driver must *NEVER* modify any constraints.

> > > Huh, I thought this was assigned by the framework.

> > No, this is not set anywhere in the regulator framework.  There isn't a=
 DT
> > method to configure it.  It seems that it could only be handled before
> > with board files.  Other regulator drivers also configure it.

> Hmm ok. Would something be bad if we did support it through DT? I can't
> seem to recall the history here.

Yes, if someone wants to configure this through DT they should add
support for configuring it using DT.  The mode support in most
regulators is not practically useful so nobody did that yet.  Mostly the
hardware does a much better job of adjusting modes on the fly for
anything that's going on at runtime than software is ever likely to do
so it's not worth it.

--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrYhqwACgkQJNaLcl1U
h9BFMQgAgDeSgMRsDtkY6PyXw9wPTVA53XMSF3JXyrF1qWtLx4DmQlqE7ZAB2lY5
j29vpVB9sqwyBzjPYqVI6vSGVV/SFnkByWpZJ3ZXEuIROOP4XfaR+jAbOx0N2kHA
5xHWBbUGQUV3+Sr2rK/pYoc4swFrPplBwvrT5tP6kVg4UfMqRshl1AA1BL+TUeOZ
rKycnOt3O9v2r2hu2U2+rp96g3qsnrIcXD6+rRR9aXIb/rv1D1sFYRIMbtcpTJeP
oQqa7kVTcV1PcOW4/Dy6DEOPm86fyhIKZw3K92gLLZl/HlQDiSTADReDfiELUBP8
wxWfQg8QO1AfYRRCHXiRFgXvr2TvJQ==
=yrnc
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--
