Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934586AbeCHBeF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 20:34:05 -0500
Received: from ozlabs.org ([103.22.144.67]:56995 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933575AbeCHBeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 20:34:04 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 8 Mar 2018 12:33:31 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Lee Jones <lee.jones@linaro.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>, Mark Brown <broonie@kernel.org>,
        David Lechner <david@lechnology.com>
Subject: linux-next: manual merge of the mfd tree with Linus' tree
Message-ID: <20180308123331.36eab22c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/WZ23EJ1_7rzJy+naceLvY.t"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WZ23EJ1_7rzJy+naceLvY.t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Lee,

Today's linux-next merge of the mfd tree got a conflict in:

  drivers/mfd/syscon.c

between commit:

  3bafc09e7797 ("mfd: syscon: Add hardware spinlock support")

from Linus' tree and commit:

  34c90dcce6b1 ("mfd: syscon: Set regmap name to DT node name")

from the mfd tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/mfd/syscon.c
index 7eaa40bc703f,2c34a356a6a9..000000000000
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@@ -88,24 -87,7 +88,25 @@@ static struct syscon *of_syscon_registe
  	if (ret)
  		reg_io_width =3D 4;
 =20
 +	ret =3D of_hwspin_lock_get_id(np, 0);
 +	if (ret > 0 || (IS_ENABLED(CONFIG_HWSPINLOCK) && ret =3D=3D 0)) {
 +		syscon_config.use_hwlock =3D true;
 +		syscon_config.hwlock_id =3D ret;
 +		syscon_config.hwlock_mode =3D HWLOCK_IRQSTATE;
 +	} else if (ret < 0) {
 +		switch (ret) {
 +		case -ENOENT:
 +			/* Ignore missing hwlock, it's optional. */
 +			break;
 +		default:
 +			pr_err("Failed to retrieve valid hwlock: %d\n", ret);
 +			/* fall-through */
 +		case -EPROBE_DEFER:
 +			goto err_regmap;
 +		}
 +	}
 +
+ 	syscon_config.name =3D of_node_full_name(np);
  	syscon_config.reg_stride =3D reg_io_width;
  	syscon_config.val_bits =3D reg_io_width * 8;
  	syscon_config.max_register =3D resource_size(&res) - reg_io_width;

--Sig_/WZ23EJ1_7rzJy+naceLvY.t
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqgkusACgkQAVBC80lX
0GzH3wf+PXPZdnTCQTRrilTd6mBsQ4Nu69S8F/Dnw12vsEQ4UoCWY8OrFY3FmLnR
Qb1dAKMoPiq/QGLHaFrBn72lUAgD7zPymvb2J7ahNgSZvTSpSosHSY9aeML+BMMV
0RykdyXqH84zeSZvtLQd3PFsjb0EKIUpJs4WOOATInKFVuxgVRgyF2B1UXG39Uk/
+hmERT7C1PcoxzSt1gfZ6sbQh5VQxn2J/DVGZWsm2F/HSt4JlQupUhGhKM9Qx8Hk
amSvCBSf2ZWDdgB6CGjkwfhDJsao/PGOE7rzFHpEVSg+ChIlvihhFVLB50Mg/M56
gjUxI5B9U6mdYOfA6jFKjvpKH2hgbQ==
=6R0X
-----END PGP SIGNATURE-----

--Sig_/WZ23EJ1_7rzJy+naceLvY.t--
