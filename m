Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbeE3LAN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:00:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51602 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751479AbeE3LAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:00:07 -0400
Date: Wed, 30 May 2018 12:00:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v4 0/6] mfd/regulator/clk: bd71837: ROHM BD71837 PMIC
 driver
Message-ID: <20180530110000.GI6920@sirena.org.uk>
References: <cover.1527669443.git.matti.vaittinen@fi.rohmeurope.com>
 <20180530090512.GC13528@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QDIl5R72YNOeCxaP"
Content-Disposition: inline
In-Reply-To: <20180530090512.GC13528@localhost.localdomain>
X-Cookie: Don't get mad, get interest.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QDIl5R72YNOeCxaP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 30, 2018 at 12:05:12PM +0300, Matti Vaittinen wrote:

> Other 4 can be used on PWM or PFM switching mode. When PWM is used
> voltages can be changed without disabling regulator. On PFM this should
> not be done. These latter 4 regulators can be forced to PWM mode via
> control bit in register. This driver does not support controlling this
> mode though. So this driver version just checks if regulator is enabled
> before changing the voltage and if it is the voltage change fails with
> -EBUSY

It probably should support setting modes (especially if the device isn't
smart enough to automatically shift which sounds like the case) but
that's a separate thing.

> My question is whether it would be good idea to also read the 'force
> PWM' bit when voltage is changed and allow the change if PWM mode is
> forced to be used? Problem is that the check and voltage change can't be
> atomic so there is a chance someone changes the mode (bypassing the
> driver and regulator core) after this check but before we get to modify
> the voltage. Furthermore, I doubt the 'force PWM' is widely used (but I
> can't say for sure as I can't imagine all use cases) as it is not so
> power efficient.

Why would anything else be changing the mode configuration of the
regulator while the system is running?  That sounds like a bad idea.
In any case if the hardware really needs to be manually put into force
PWM to change voltage then the simplest thing would be to just move it
into force PWM mode, do the change, then change back if it wasn't
already in force PWM mode.

The tradeoff with forced PWM mode is that the quality of regulation will
be a lot better, especially if the load changes suddenly (as things like
CPUs often do).  Most hardware that's at all current is able respond to
changes in load and switch modes automatically when it's appropriate,
except possibly in some very low power modes.

--QDIl5R72YNOeCxaP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsOhC8ACgkQJNaLcl1U
h9Ag/wf+K4uLA5x5eT0bG96OcP1drAx9nx/aAbTTtQsFPeSTocdCq4nplECWlONt
Jfi9RRuX2TRezrrQa8QIcfssUhT4M1MJD30Mws0SJ3e1m+vhcSS3FUS4vOepmNPg
HcFnwg8qXNXSn1ahvYxZ2ISbu20C2uQj2XeJYsB4sQhsBzW/FPp7Z40nH1TMpqR3
m9hl4NSci25M9BchBzR3vLdltsdYVmGrX4kX2nZSTOXgymX58R+rBLZeyZ4+kMO1
/E0AUYBNiQ6+UN1NmN0abv0cD/GsvNc8nTEt2lB/IXkVGnz/nyj01pg5/5vrL7fx
g1F5lBtaLADOmLd6FbvX4wK4BJO3/g==
=yqHD
-----END PGP SIGNATURE-----

--QDIl5R72YNOeCxaP--
