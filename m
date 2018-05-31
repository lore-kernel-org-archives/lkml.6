Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754811AbeEaLsX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:48:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36406 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754522AbeEaLsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:48:20 -0400
Date: Thu, 31 May 2018 12:48:16 +0100
From: Mark Brown <broonie@kernel.org>
To: David Collins <collinsd@codeaurora.org>
Cc: Doug Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
Message-ID: <20180531114816.GC13319@sirena.org.uk>
References: <cover.1527040878.git.collinsd@codeaurora.org>
 <6d03576cf90f06afb1194301cb41fc31704def1d.1527040878.git.collinsd@codeaurora.org>
 <CAD=FV=VH0bTxPOmRr+jUyV0cGNQHLcwQTV9L-t0bxZOqD8FnHA@mail.gmail.com>
 <20180530103720.GH6920@sirena.org.uk>
 <CAD=FV=WTTKXwPchuWRh-RNTc8=X8Xo28oTqk=3wW4+SiTHhxuA@mail.gmail.com>
 <20180530155044.GR6920@sirena.org.uk>
 <CAD=FV=WVUmvPPd5BxXv9Sa_2CRPrrjQvYFyqroY-3fRr4f0Bzg@mail.gmail.com>
 <20180530162007.GU6920@sirena.org.uk>
 <CAD=FV=WL9enzYCoSx0fT_ny40ciLJU-hhS9joJ6nySXvWPqAxQ@mail.gmail.com>
 <75088820-f20d-32ac-780a-5e7dacdf20ff@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Content-Disposition: inline
In-Reply-To: <75088820-f20d-32ac-780a-5e7dacdf20ff@codeaurora.org>
X-Cookie: I've read SEVEN MILLION books!!
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 30, 2018 at 04:39:10PM -0700, David Collins wrote:

> The DRMS modes to use and max allowed current per mode need to be
> specified at the board level in device tree instead of hard-coded per
> regulator type in the driver.  There are at least two use cases driving
> this need: LDOs shared between RPMh client processors and SMPSes requiring
> PWM mode in certain circumstances.

Is there really no way to improve the RPM firmware?

> Consider the case of a regulator with physical 10 mA LPM max current. Say
> that modem and application processors each have a load on the regulator
> that draws 9 mA. If they each respect the 10 mA limit, then they'd each
> vote for LPM. The VRM block in RPMh hardware will aggregate these requests

This is, of course, why the regulator API aggregates this stuff based on
the current not based on having every individual user select a mode.

> together using a max function which will result in the regulator being set
> to LPM, even though the total load is 18 mA (which would require high
> power mode (HPM)). To get around this corner case, a LPM max current of 1
> uA can be used for all LDO supplies that have non-application processor
> consumers. Thus, any non-zero regulator_set_load() current request will
> result in setting the regulator to HPM (which is always safe).

That's obviously just never going to work well, the best you can do here
is just pretend that the other components are always operating at full
power (which I assume all the other components are doing too...) or not
try to use load based mode switching in the first place.

> The second situation that needs board-level DRMS mode and current limit
> specification is SMPS regulator AUTO mode to PWM (HPM) mode switching.
> SMPS regulators should theoretically always be able to operate in AUTO
> mode as it switches automatically between PWM mode (which can provide the
> maximum current) and PFM mode (which supports lower current but has higher
> efficiency). However, there may be board/system issues that require
> switching to PWM mode for certain use cases as it has better load
> regulation (i.e. no PFM ripple for lower loads) and supports more
> aggressive load current steps (i.e. greater A/ns).

> If a Linux consumer requires the ability to force a given SMPS regulator
> from AUTO mode into PWM mode and that SMPS is shared by other Linux
> consumers (which may be the case, but at least must be guaranteed to work
> architecturally), then regulator_set_load() is the only option since it
> provides aggregation, where as regulator_set_mode() does not.

That's obviously broken though, what you're describing is just clearly
nothing to do with load so trying to configure it using load is just
going to lead to problems later on.  Honestly it sounds like you just
want to force the regulator into forced PWM mode all the time, otherwise
you need to look into implementing support for describing the thing
you're actually trying to do and add a mechanism for per consumer mode
configuration.

This has been a frequent pattern with these RPM drivers, trying to find
some way to shoehorn something that happens to work right now into the
code.  That's going to make things fragile and hard to maintain, we need
code that does the thing it's saying it does so that it's easier to
understand and work with - getting things running isn't enough, they
need to be clear.

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsP4P8ACgkQJNaLcl1U
h9BZQgf+I/wVcjtOanB4eFLuRoPbjP9O9H6RSWlJp+LFFwEULGP49jMLGuqIeLzK
mqSzLLeiX5EylzIBQQO9bpRriFg3RVYPu5FOJzUenu6oFqlJjEFO2ALlU0ONDcrG
OJjFt2J1aLQcoQANqFPDWVfXuJxQPQvBP0spKNqshU6MjoOhHL2o0Agks2QPA7LE
nMh0N+zMQbggfDkYRqWFGWq3i9wYqilj6MgHEJD5h1yoAF97Hgr7iPM/XDVDFk4R
h3v5rkWRgCdou4VvKvg4RAKrCjKnZ86FQsQC2LaBHsnIpwSw82f9byBGc6W9MX9F
JVLIY/r+xiLxURg68B6Hk5L7SUPmaA==
=+MsJ
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
