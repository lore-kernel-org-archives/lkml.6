Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755390AbeE3FHW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 01:07:22 -0400
Received: from ozlabs.org ([203.11.71.1]:53847 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750964AbeE3FHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 01:07:18 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 30 May 2018 15:07:11 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>
Subject: linux-next: manual merge of the regulator tree with the arm-soc
 tree
Message-ID: <20180530150711.2c7c1fe9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/XFAHrEkeBv.SlIR+tx89QO5"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XFAHrEkeBv.SlIR+tx89QO5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the regulator tree got a conflict in:

  arch/arm/mach-omap1/board-ams-delta.c

between commit:

  0486738928bf ("ARM: OMAP1: ams-delta: add GPIO lookup tables")

from the arm-soc tree and commit:

  6059577cb28d ("regulator: fixed: Convert to use GPIO descriptor only")

from the regulator tree.

I fixed it up (see below - it may be better done) and can carry the fix
as necessary. This is now fixed as far as linux-next is concerned, but
any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm/mach-omap1/board-ams-delta.c
index 80f54cb54276,759fa18f6ab4..000000000000
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@@ -203,10 -203,8 +203,10 @@@ static struct resource latch2_resources
  	},
  };
 =20
- #define LATCH2_LABEL	"latch2"
++#define LATCH2_LABEL	"ams-delta-latch2"
 +
  static struct bgpio_pdata latch2_pdata =3D {
 -	.label	=3D "ams-delta-latch2",
 +	.label	=3D LATCH2_LABEL,
  	.base	=3D AMS_DELTA_LATCH2_GPIO_BASE,
  	.ngpio	=3D AMS_DELTA_LATCH2_NGPIO,
  };
@@@ -303,6 -288,16 +302,15 @@@ static struct platform_device modem_nre
  	},
  };
 =20
+ static struct gpiod_lookup_table modem_nreset_gpiod_table =3D {
+ 	.dev_id =3D "reg-fixed-voltage",
+ 	.table =3D {
 -		/* The AMS_DELTA_GPIO_PIN_MODEM_NRESET is at offset 12 */
 -		GPIO_LOOKUP("ams-delta-latch2", 12,
++		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_MODEM_NRESET,
+ 			    "enable", GPIO_ACTIVE_HIGH),
+ 		{ },
+ 	},
+ };
+=20
  struct modem_private_data {
  	struct regulator *regulator;
  };
@@@ -658,15 -581,7 +666,15 @@@ static int __init late_init(void
 =20
  	platform_add_devices(late_devices, ARRAY_SIZE(late_devices));
 =20
 +	/*
 +	 * As soon as devices have been registered, assign their dev_names
 +	 * to respective GPIO lookup tables before they are added.
 +	 */
 +	ams_delta_lcd_gpio_table.dev_id =3D dev_name(&ams_delta_lcd_device.dev);
 +	ams_delta_nand_gpio_table.dev_id =3D dev_name(&ams_delta_nand_device.dev=
);
 +
 +	gpiod_add_lookup_tables(late_gpio_tables, ARRAY_SIZE(late_gpio_tables));
-=20
+ 	gpiod_add_lookup_table(&modem_nreset_gpiod_table);
  	err =3D platform_device_register(&modem_nreset_device);
  	if (err) {
  		pr_err("Couldn't register the modem regulator device\n");

--Sig_/XFAHrEkeBv.SlIR+tx89QO5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsOMX8ACgkQAVBC80lX
0Gz3gQgAimuqRHgKw76XlRt2rpKcL2XLUoer3jEQFZYcEcckguEraKX0xb5nxPrs
G8UABlkhQHcbFAeHOJByYAiP9dXTLeBBs7HQdHs2gmYVVERyhpYnMza0FIim1lTe
dM4erdRuB9Y/4MvcrZ6jVquXM69nhCLPHWUR2gRD3P94fifHTXbfB2Lw5t0p+M8v
rQgwLBOUAWmwBa5w5XUsWpqr2gM/C6EHjBooWQHGNqGG+dTBkuHYnfcB2Bl5Wj1i
ue8Dtr9puymHgyp8C3dKrmN/KsIqf/+N1zlxXecUxgddn+XBCWeaRvN+4zwxenqS
wghnl+Qpg+QTCAe0xTzm9AHptvDBXg==
=3PtG
-----END PGP SIGNATURE-----

--Sig_/XFAHrEkeBv.SlIR+tx89QO5--
