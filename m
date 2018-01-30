Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbeA3MDp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 07:03:45 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51086 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751360AbeA3MDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 07:03:43 -0500
Date: Tue, 30 Jan 2018 12:03:40 +0000
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] regulator: core: Fix s2idle
Message-ID: <20180130120340.GB10525@sirena.org.uk>
References: <1517308346-25299-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline
In-Reply-To: <1517308346-25299-1-git-send-email-geert+renesas@glider.be>
X-Cookie: Try
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2018 at 11:32:26AM +0100, Geert Uytterhoeven wrote:

> But I have no idea what impact it has.  So far it doesn't seem to hurt,
> though.

I suspect that instead what we should be doing is changing the
set_suspend_state() check to the below - if we don't have any
constraints or there's otherwise nothing to do just let the suspend
proceed.

Can you give this a spin and confirm if it fixes things?

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 42681c10cbe4..dd4708c58480 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -758,7 +758,7 @@ static int suspend_set_state(struct regulator_dev *rdev,
=20
 	rstate =3D regulator_get_suspend_state(rdev, state);
 	if (rstate =3D=3D NULL)
-		return -EINVAL;
+		return 0;
=20
 	/* If we have no suspend mode configration don't set anything;
 	 * only warn if the driver implements set_suspend_voltage or

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpwXxsACgkQJNaLcl1U
h9Br/wf/VJSb0WDJbvRZhKgS99sXW57lkEju5+lHVsIW3h9eiHnkVMT50hw/ZDUp
/olvormQdYrqdP800lfpUJGIPpMt3p+tdsWFP+AYgORVxoBGLDC3dpCwTGSglP0o
bem9Z3y9eKbP3v/8Q3fF0MN06KUsafDbOqzO3IpqdRp1RKYQdhYCmugN+9LP6DwG
HIp225jxbLy7bfQ03CkZCf/uFj5gYE63tnJydeOMO0Ld6DE5ZVJRPDs9oeDgsA0c
PdAd2DeZrtf5Bav3bzDVM5F0iW4R7O4umglzi8a8NkhwDuoYNsYcyIY0cVoeAWBv
NJRA4W9OnThy6ql2JNQIIhsF5Nhjcg==
=iS9K
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
