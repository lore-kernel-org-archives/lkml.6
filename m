Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752909AbeDCDPy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 23:15:54 -0400
Received: from ozlabs.org ([103.22.144.67]:36737 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750905AbeDCDPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 23:15:50 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 3 Apr 2018 13:14:54 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>, Tal Gilboa <talgi@mellanox.com>
Subject: linux-next: manual merge of the net-next tree with the pci tree
Message-ID: <20180403131454.4f9f032d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/kLc5NKrAQe+OKKbEqT4VXk+"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kLc5NKrAQe+OKKbEqT4VXk+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/ethernet/mellanox/mlx5/core/en_main.c

between commit:

  2907938d2375 ("net/mlx5e: Use pcie_bandwidth_available() to compute bandw=
idth")

from the pci tree and commit:

  0608d4dbaf4e ("net/mlx5e: Unify slow PCI heuristic")

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

diff --cc drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 884337f88589,0aab3afc6885..000000000000
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@@ -3880,16 -4026,50 +4033,20 @@@ void mlx5e_build_default_indir_rqt(u32=20
  		indirection_rqt[i] =3D i % num_channels;
  }
 =20
- static bool cqe_compress_heuristic(u32 link_speed, u32 pci_bw)
 -static int mlx5e_get_pci_bw(struct mlx5_core_dev *mdev, u32 *pci_bw)
 -{
 -	enum pcie_link_width width;
 -	enum pci_bus_speed speed;
 -	int err =3D 0;
 -
 -	err =3D pcie_get_minimum_link(mdev->pdev, &speed, &width);
 -	if (err)
 -		return err;
 -
 -	if (speed =3D=3D PCI_SPEED_UNKNOWN || width =3D=3D PCIE_LNK_WIDTH_UNKNOW=
N)
 -		return -EINVAL;
 -
 -	switch (speed) {
 -	case PCIE_SPEED_2_5GT:
 -		*pci_bw =3D 2500 * width;
 -		break;
 -	case PCIE_SPEED_5_0GT:
 -		*pci_bw =3D 5000 * width;
 -		break;
 -	case PCIE_SPEED_8_0GT:
 -		*pci_bw =3D 8000 * width;
 -		break;
 -	default:
 -		return -EINVAL;
 -	}
 -
 -	return 0;
 -}
 -
+ static bool slow_pci_heuristic(struct mlx5_core_dev *mdev)
  {
- 	return (link_speed && pci_bw &&
- 		(pci_bw < 40000) && (pci_bw < link_speed));
- }
+ 	u32 link_speed =3D 0;
+ 	u32 pci_bw =3D 0;
 =20
- static bool hw_lro_heuristic(u32 link_speed, u32 pci_bw)
- {
- 	return !(link_speed && pci_bw &&
- 		 (pci_bw <=3D 16000) && (pci_bw < link_speed));
+ 	mlx5e_get_max_linkspeed(mdev, &link_speed);
 -	mlx5e_get_pci_bw(mdev, &pci_bw);
++	pci_bw =3D pcie_bandwidth_available(mdev->pdev, NULL, NULL, NULL);
+ 	mlx5_core_dbg_once(mdev, "Max link speed =3D %d, PCI BW =3D %d\n",
+ 			   link_speed, pci_bw);
+=20
+ #define MLX5E_SLOW_PCI_RATIO (2)
+=20
+ 	return link_speed && pci_bw &&
+ 		link_speed > MLX5E_SLOW_PCI_RATIO * pci_bw;
  }
 =20
  void mlx5e_set_tx_cq_mode_params(struct mlx5e_params *params, u8 cq_perio=
d_mode)

--Sig_/kLc5NKrAQe+OKKbEqT4VXk+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrC8a4ACgkQAVBC80lX
0Gxv4AgAjHVEdipcMHuSq6GbgjgcHJ9+Maf0XBZOszt9XWJyOPqYUvhDMvT+EqJk
2Jcwe/N5uhwwQn+EGk5cy2mJzTqlz3QEXFejF4YFwnOwWW5XVYNbTCiopl4aKLWe
qb5IS3MLZ0txG+5hmGDWJvFVnoh5dSputUTaPKo8xzOUtZdUFuHYjsGcxNbNUpy7
QkkyDKILhnf7XO4IYFf0+DC/qKxLS+aBqXy9BWizGDewCXBdax5ekiLyuC8MmPw5
nRLyJaVdaoYhDZDbTzAlSDdiD4Gm0+zsIkfLbRDARt81/2d1YHoRWO71WMpVeBg5
7sZQvhkWE4yIOsAeb1Nu7cL8LuW8mg==
=vMbS
-----END PGP SIGNATURE-----

--Sig_/kLc5NKrAQe+OKKbEqT4VXk+--
