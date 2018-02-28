Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964775AbeB1Ww0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 17:52:26 -0500
Received: from ozlabs.org ([103.22.144.67]:51053 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935256AbeB1WwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 17:52:24 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 1 Mar 2018 09:51:45 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Pirko <jiri@mellanox.com>,
        Arkadi Sharshevsky <arkadis@mellanox.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20180301095145.40b1fef5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/8IIh3SSSJXsbJBOiW261dry"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8IIh3SSSJXsbJBOiW261dry
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/ethernet/mellanox/mlxsw/spectrum.c

between commit:

  77d270967c5f ("mlxsw: spectrum: Fix handling of resource_size_param")

from the net tree and commit:

  4f4bbf7c4e3d ("devlink: Perform cleanup of resource_set cb")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index c7e941aecc2a,7c6204f701ae..000000000000
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@@ -4204,21 -3816,13 +3822,12 @@@ static struct devlink_resource_ops mlxs
  	.occ_get =3D mlxsw_sp_resource_kvd_linear_occ_get,
  };
 =20
- static struct devlink_resource_ops mlxsw_sp_resource_kvd_hash_single_ops =
=3D {
- 	.size_validate =3D mlxsw_sp_resource_kvd_hash_single_size_validate,
- };
-=20
- static struct devlink_resource_ops mlxsw_sp_resource_kvd_hash_double_ops =
=3D {
- 	.size_validate =3D mlxsw_sp_resource_kvd_hash_double_size_validate,
- };
 -static struct devlink_resource_size_params mlxsw_sp_kvd_size_params;
 -static struct devlink_resource_size_params mlxsw_sp_linear_size_params;
 -static struct devlink_resource_size_params mlxsw_sp_hash_single_size_para=
ms;
 -static struct devlink_resource_size_params mlxsw_sp_hash_double_size_para=
ms;
--
  static void
 -mlxsw_sp_resource_size_params_prepare(struct mlxsw_core *mlxsw_core)
 +mlxsw_sp_resource_size_params_prepare(struct mlxsw_core *mlxsw_core,
 +				      struct devlink_resource_size_params *kvd_size_params,
 +				      struct devlink_resource_size_params *linear_size_params,
 +				      struct devlink_resource_size_params *hash_double_size_params,
 +				      struct devlink_resource_size_params *hash_single_size_params)
  {
  	u32 single_size_min =3D MLXSW_CORE_RES_GET(mlxsw_core,
  						 KVD_SINGLE_MIN_SIZE);
@@@ -4274,8 -3876,8 +3883,8 @@@ static int mlxsw_sp_resources_register(
  					true, kvd_size,
  					MLXSW_SP_RESOURCE_KVD,
  					DEVLINK_RESOURCE_ID_PARENT_TOP,
 -					&mlxsw_sp_kvd_size_params,
 +					&kvd_size_params,
- 					&mlxsw_sp_resource_kvd_ops);
+ 					NULL);
  	if (err)
  		return err;
 =20
@@@ -4298,8 -3904,8 +3911,8 @@@
  					false, double_size,
  					MLXSW_SP_RESOURCE_KVD_HASH_DOUBLE,
  					MLXSW_SP_RESOURCE_KVD,
 -					&mlxsw_sp_hash_double_size_params,
 +					&hash_double_size_params,
- 					&mlxsw_sp_resource_kvd_hash_double_ops);
+ 					NULL);
  	if (err)
  		return err;
 =20
@@@ -4308,8 -3914,8 +3921,8 @@@
  					false, single_size,
  					MLXSW_SP_RESOURCE_KVD_HASH_SINGLE,
  					MLXSW_SP_RESOURCE_KVD,
 -					&mlxsw_sp_hash_single_size_params,
 +					&hash_single_size_params,
- 					&mlxsw_sp_resource_kvd_hash_single_ops);
+ 					NULL);
  	if (err)
  		return err;
 =20

--Sig_/8IIh3SSSJXsbJBOiW261dry
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqXMoEACgkQAVBC80lX
0GzF8ggAoJlDgMLoQzBQz7LGtC5KscZhhhRvNDytL8gVTf9CHAhzuXK3JSOpMU7r
HL2OYTwve6fIZppECdULIonwQjrID1WK5vSKxK1b2eyJV/srWVeap0gvcxT6I+Q4
nNJgas4RILvDdXCyFAZXP4AuNTy2vmgVAsp6leCt0rl4E/H/D9ukJC4dXSO64S8q
UVvmvwUxPfzA3X0OfOESjjLpyv0J3ZgwdUDAYKOFW3jZzAa8v/x0nqFLmGaeK3i1
RWSTwtPMbKm7n8uyS5CUWiFH40LbITV1/60AAV1AbKeuYkCrI5DeTf38J7PwQlEB
qcusCqYml2ZK2zJKx+PCm/OqrlCbkA==
=exiD
-----END PGP SIGNATURE-----

--Sig_/8IIh3SSSJXsbJBOiW261dry--
