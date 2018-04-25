Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754544AbeDYODQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 10:03:16 -0400
Received: from smtpgwcipde.automotive.elektrobit.com ([213.95.163.141]:53749
        "EHLO smtpgwcipde.elektrobit.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753571AbeDYODO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 10:03:14 -0400
Date: Wed, 25 Apr 2018 15:47:30 +0200
From: Stefan Potyra <Stefan.Potyra@elektrobit.com>
To: Mark Brown <broonie@kernel.org>
CC: Florian Fainelli <florian.fainelli@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Jonas Gorski <jonas.gorski@gmail.com>, <ldv-project@linuxtesting.org>,
        <sil2review@lists.osadl.org>
Subject: [PATCH v3] spi/bcm63xx-hspi: Enable the clock before calling
Message-ID: <20180425134728.GA20897@er01809n.ebgroup.elektrobit.com>
References: <20180419130358.r7dva6owy2izyfus@agrajag.zerfleddert.de>
 <dfb9c72c-6289-a2ea-c3d4-c59f5e3c799c@broadcom.com>
 <20180424161605.GA17825@er01809n.ebgroup.elektrobit.com>
 <20180424173253.GF22073@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <20180424173253.GF22073@sirena.org.uk>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Originating-IP: [10.0.24.181]
X-ClientProxiedBy: denue6es008.ebgroup.elektrobit.com (10.5.139.25) To
 denue6es008.ebgroup.elektrobit.com (10.5.139.25)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Enable the clock prior to calling clk_get_rate(), because clk_get_rate()
should only be called if the clock is enabled.

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


--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEATY+KFcrMtHMM+b3X8uyjJIzOwAFAlrghugACgkQX8uyjJIz
OwAP0w/6Aw6QHIS37j2GJwPo22PVw14H7EdiBnG5i+Z1erP3PhP/bw3+NfwchKX1
GDF4cwQ0YPHkhBoDGaa/gM/39HxOU4O/cefP2j+yzXvhCHtQlxMOlz+0juwiA5tj
SfVmFAvju5FlhRCZijkaxD5V3rDQ0Zh0PDQUADpSUoboVtkQHrUuTbl6RgMj4Joq
gcIfeaKAvTp+eWxXKAUNAaZEvBMLGCtSsvKKakw98NTT0CX4fAzRzIQKiO1CUMJR
NB3Sq/wJ7ETYxm8kIM2l7f5pqapaRMBV37bBkkw38o5+BLtoC+uo37f+uWr3WAi4
RvNq5I65hTCc+leKiW7Y62klkYkFDd9VZjSvDyKcEXtXUNbtg1LLGdNPvERiCotQ
bzBjeQadiG/qxvqF9U7cD1jfspyj0Q4bHf/iO2SKShOJfOijmA/xeqjsyZuZlzBi
gCPxjFPae/b+i8SN/jcug0DwD305U2OsWR+IUisp0kQqhffe/+fFy70OGUCmQPoG
13CcpuuIebgdO7FDkRhG7K/aYr37v22mAveNMrEuvxemadVgA9R2/feRFUEZmoGN
NdYLNkqlnKum2Og+WbYYkCiw7XnOLayF2P1EyYai6oDgq53WuY7pR4aBXky0kbtk
dQTxr378eFxS1RDOQRhphb56tGYmsPx/GefUKRoeFpjQSuV5N5E=
=FsCe
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
