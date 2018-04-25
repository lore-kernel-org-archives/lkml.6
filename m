Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755588AbeDYQtw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 12:49:52 -0400
Received: from smtpgwcipde.automotive.elektrobit.com ([213.95.163.141]:58477
        "EHLO smtpgwcipde.elektrobit.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754585AbeDYQtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 12:49:46 -0400
Date: Wed, 25 Apr 2018 18:49:06 +0200
From: Stefan Potyra <Stefan.Potyra@elektrobit.com>
To: Mark Brown <broonie@kernel.org>
CC: Florian Fainelli <florian.fainelli@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Jonas Gorski <jonas.gorski@gmail.com>, <ldv-project@linuxtesting.org>,
        <sil2review@lists.osadl.org>
Subject: [PATCH v4] spi/bcm63xx-hspi: Enable the clock before calling
 clk_get_rate().
Message-ID: <20180425164904.GA30349@er01809n.ebgroup.elektrobit.com>
References: <20180419130358.r7dva6owy2izyfus@agrajag.zerfleddert.de>
 <dfb9c72c-6289-a2ea-c3d4-c59f5e3c799c@broadcom.com>
 <20180424161605.GA17825@er01809n.ebgroup.elektrobit.com>
 <20180424173253.GF22073@sirena.org.uk>
 <20180425134728.GA20897@er01809n.ebgroup.elektrobit.com>
 <20180425155028.GF24769@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <20180425155028.GF24769@sirena.org.uk>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Originating-IP: [10.0.24.181]
X-ClientProxiedBy: denue6es008.ebgroup.elektrobit.com (10.5.139.25) To
 denue6es008.ebgroup.elektrobit.com (10.5.139.25)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Enable the clock prior to calling clk_get_rate(), because clk_get_rate()
should only be called if the clock is enabled.

Additionally, prepare/enable the pll_clk before calling clk_get_rate()
for the same reason.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 142168eba9dc ("spi: bcm63xx-hsspi: add bcm63xx HSSPI driver")
Signed-off-by: Stefan Potyra <Stefan.Potyra@elektrobit.com>
---
 drivers/spi/spi-bcm63xx-hsspi.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hssp=
i.c
index cbcba614b253..8475703543e5 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -352,22 +352,27 @@ static int bcm63xx_hsspi_probe(struct platform_device=
 *pdev)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
=20
+	ret =3D clk_prepare_enable(clk);
+	if (ret)
+		return ret;
+
 	rate =3D clk_get_rate(clk);
 	if (!rate) {
 		struct clk *pll_clk =3D devm_clk_get(dev, "pll");
=20
-		if (IS_ERR(pll_clk))
-			return PTR_ERR(pll_clk);
+		if (IS_ERR(pll_clk)) {
+			ret =3D PTR_ERR(pll_clk);
+			goto out_disable_clk;
+		}
+
=20
 		rate =3D clk_get_rate(pll_clk);
-		if (!rate)
-			return -EINVAL;
+		if (!rate) {
+			ret =3D -EINVAL;
+			goto out_disable_clk;
+		}
 	}
=20
-	ret =3D clk_prepare_enable(clk);
-	if (ret)
-		return ret;
-
 	master =3D spi_alloc_master(&pdev->dev, sizeof(*bs));
 	if (!master) {
 		ret =3D -ENOMEM;
--=20
2.17.0


--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEATY+KFcrMtHMM+b3X8uyjJIzOwAFAlrgsXwACgkQX8uyjJIz
OwBerg/9EqnUtTafdrKsu9IEkV8E+jzZCtp4JWQI4lmteNcdmufocEPwXQX9cZqZ
f0GVexGMFQVhA7lK3Zzm8DgvaAT2hSFKLkZgQ1eutz1HyrMUWrMZQ7YeH6IwHu/8
/WevR7BieZKI+WWKJfZQz6I4/ofb5lSEK1fZ10AFVAdjAgNbV/6jOLWrTRrH++Dn
0I4e5HBTOzzKek7Rg9+oHG06GEVEdVu0mJweVmzXhVRH3ij5EHV0qftJ/Y5nI5It
m26qXLL9ZAj6TOP5jMriJQ94Zw2Li+E23xiPoC1KTGYKcyk0THKBeWhsUldTCJzv
ENkI+dG12TpXlRWtSPTea8LDo2cPxbbYs50DgGX1GwB2Dtz2NIngVL+OqfXmU4G4
rl6AgthYPKli6zOxVzLN69GHfOfp8V3Dw00oL6n4yfCVBCFtrmsEuJytHsghKoMl
6zpYZaxjtS2y9IM76NA5fiNtnY9Jtsr6jf+gcEQgZX45Rt8O9Rz6Jz4/JFSDh5dY
eQEhvRGc8/dtXauPR5KNzqRdp6WZNoVl6ircLGXYlSVUQvMN06qyVlrybHbxxL76
R2l1H/GwNxyXAE1POw4JAED8g+vgRRmb5gZIiCcS8YR726i4KQwzdsAo8OLhRA7d
HQMpU5NQ0ruZmICtVq8uAMgs9fD2Knsk49XWLx4ZqbYCNqnrqnY=
=Z9YA
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
