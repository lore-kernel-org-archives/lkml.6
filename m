Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932893AbeCPA5M (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 20:57:12 -0400
Received: from ozlabs.org ([103.22.144.67]:49983 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932617AbeCPA5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 20:57:07 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 16 Mar 2018 11:56:10 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Bloch <markb@mellanox.com>, Leon Romanovsky <leonro@mellanox.com>
Subject: linux-next: manual merge of the net-next tree with the rdma-fixes
 tree
Message-ID: <20180316115610.3d7f232a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/EM/EaYw6DMwyr/_jC+NRfnQ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EM/EaYw6DMwyr/_jC+NRfnQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/infiniband/hw/mlx5/main.c

between commit:

  42cea83f9524 ("IB/mlx5: Fix cleanup order on unload")

from the rdma-fixes tree and commit:

  b5ca15ad7e61 ("IB/mlx5: Add proper representors support")

from the net-next tree.

I fixed it up (see below and the merge fix patch as well) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 16 Mar 2018 11:54:01 +1100
Subject: [PATCH] IB/mlx5: merge fix for "Fix cleanup order on unload"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/infiniband/hw/mlx5/ib_rep.c  | 6 +++---
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 3 +--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/ib_rep.c b/drivers/infiniband/hw/ml=
x5/ib_rep.c
index 61cc3d7db257..7fb997dadd80 100644
--- a/drivers/infiniband/hw/mlx5/ib_rep.c
+++ b/drivers/infiniband/hw/mlx5/ib_rep.c
@@ -33,9 +33,9 @@ static const struct mlx5_ib_profile rep_profile =3D {
 	STAGE_CREATE(MLX5_IB_STAGE_IB_REG,
 		     mlx5_ib_stage_ib_reg_init,
 		     mlx5_ib_stage_ib_reg_cleanup),
-	STAGE_CREATE(MLX5_IB_STAGE_UMR_RESOURCES,
-		     mlx5_ib_stage_umr_res_init,
-		     mlx5_ib_stage_umr_res_cleanup),
+	STAGE_CREATE(MLX5_IB_STAGE_POST_IB_REG_UMR,
+		     mlx5_ib_stage_post_ib_reg_umr_init,
+		     NULL),
 	STAGE_CREATE(MLX5_IB_STAGE_CLASS_ATTR,
 		     mlx5_ib_stage_class_attr_init,
 		     NULL),
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/m=
lx5/mlx5_ib.h
index 7ec753ec7962..c45a7abdbe3e 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1071,8 +1071,7 @@ int mlx5_ib_stage_bfrag_init(struct mlx5_ib_dev *dev);
 void mlx5_ib_stage_bfrag_cleanup(struct mlx5_ib_dev *dev);
 int mlx5_ib_stage_ib_reg_init(struct mlx5_ib_dev *dev);
 void mlx5_ib_stage_ib_reg_cleanup(struct mlx5_ib_dev *dev);
-int mlx5_ib_stage_umr_res_init(struct mlx5_ib_dev *dev);
-void mlx5_ib_stage_umr_res_cleanup(struct mlx5_ib_dev *dev);
+int mlx5_ib_stage_post_ib_reg_umr_init(struct mlx5_ib_dev *dev);
 int mlx5_ib_stage_class_attr_init(struct mlx5_ib_dev *dev);
 void __mlx5_ib_remove(struct mlx5_ib_dev *dev,
 		      const struct mlx5_ib_profile *profile,
--=20
2.16.1

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/infiniband/hw/mlx5/main.c
index da091de4e69d,d9474b95d8e5..000000000000
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@@ -4860,19 -4999,19 +4996,19 @@@ int mlx5_ib_stage_ib_reg_init(struct ml
  	return ib_register_device(&dev->ib_dev, NULL);
  }
 =20
 -void mlx5_ib_stage_ib_reg_cleanup(struct mlx5_ib_dev *dev)
 +static void mlx5_ib_stage_pre_ib_reg_umr_cleanup(struct mlx5_ib_dev *dev)
  {
 -	ib_unregister_device(&dev->ib_dev);
 +	destroy_umrc_res(dev);
  }
 =20
- static void mlx5_ib_stage_ib_reg_cleanup(struct mlx5_ib_dev *dev)
 -int mlx5_ib_stage_umr_res_init(struct mlx5_ib_dev *dev)
++void mlx5_ib_stage_ib_reg_cleanup(struct mlx5_ib_dev *dev)
  {
 -	return create_umr_res(dev);
 +	ib_unregister_device(&dev->ib_dev);
  }
 =20
- static int mlx5_ib_stage_post_ib_reg_umr_init(struct mlx5_ib_dev *dev)
 -void mlx5_ib_stage_umr_res_cleanup(struct mlx5_ib_dev *dev)
++int mlx5_ib_stage_post_ib_reg_umr_init(struct mlx5_ib_dev *dev)
  {
 -	destroy_umrc_res(dev);
 +	return create_umr_res(dev);
  }
 =20
  static int mlx5_ib_stage_delay_drop_init(struct mlx5_ib_dev *dev)
@@@ -4999,6 -5144,48 +5144,48 @@@ static const struct mlx5_ib_profile pf_
  		     NULL),
  };
 =20
+ static const struct mlx5_ib_profile nic_rep_profile =3D {
+ 	STAGE_CREATE(MLX5_IB_STAGE_INIT,
+ 		     mlx5_ib_stage_init_init,
+ 		     mlx5_ib_stage_init_cleanup),
+ 	STAGE_CREATE(MLX5_IB_STAGE_FLOW_DB,
+ 		     mlx5_ib_stage_flow_db_init,
+ 		     mlx5_ib_stage_flow_db_cleanup),
+ 	STAGE_CREATE(MLX5_IB_STAGE_CAPS,
+ 		     mlx5_ib_stage_caps_init,
+ 		     NULL),
+ 	STAGE_CREATE(MLX5_IB_STAGE_NON_DEFAULT_CB,
+ 		     mlx5_ib_stage_rep_non_default_cb,
+ 		     NULL),
+ 	STAGE_CREATE(MLX5_IB_STAGE_ROCE,
+ 		     mlx5_ib_stage_rep_roce_init,
+ 		     mlx5_ib_stage_rep_roce_cleanup),
+ 	STAGE_CREATE(MLX5_IB_STAGE_DEVICE_RESOURCES,
+ 		     mlx5_ib_stage_dev_res_init,
+ 		     mlx5_ib_stage_dev_res_cleanup),
+ 	STAGE_CREATE(MLX5_IB_STAGE_COUNTERS,
+ 		     mlx5_ib_stage_counters_init,
+ 		     mlx5_ib_stage_counters_cleanup),
+ 	STAGE_CREATE(MLX5_IB_STAGE_UAR,
+ 		     mlx5_ib_stage_uar_init,
+ 		     mlx5_ib_stage_uar_cleanup),
+ 	STAGE_CREATE(MLX5_IB_STAGE_BFREG,
+ 		     mlx5_ib_stage_bfrag_init,
+ 		     mlx5_ib_stage_bfrag_cleanup),
+ 	STAGE_CREATE(MLX5_IB_STAGE_IB_REG,
+ 		     mlx5_ib_stage_ib_reg_init,
+ 		     mlx5_ib_stage_ib_reg_cleanup),
 -	STAGE_CREATE(MLX5_IB_STAGE_UMR_RESOURCES,
 -		     mlx5_ib_stage_umr_res_init,
 -		     mlx5_ib_stage_umr_res_cleanup),
++	STAGE_CREATE(MLX5_IB_STAGE_POST_IB_REG_UMR,
++		     mlx5_ib_stage_post_ib_reg_umr_init,
++		     NULL),
+ 	STAGE_CREATE(MLX5_IB_STAGE_CLASS_ATTR,
+ 		     mlx5_ib_stage_class_attr_init,
+ 		     NULL),
+ 	STAGE_CREATE(MLX5_IB_STAGE_REP_REG,
+ 		     mlx5_ib_stage_rep_reg_init,
+ 		     mlx5_ib_stage_rep_reg_cleanup),
+ };
+=20
  static void *mlx5_ib_add_slave_port(struct mlx5_core_dev *mdev, u8 port_n=
um)
  {
  	struct mlx5_ib_multiport_info *mpi;

--Sig_/EM/EaYw6DMwyr/_jC+NRfnQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqrFioACgkQAVBC80lX
0Gzmxwf9GpGubOButnTfLtxahHxO0JLAJpcrSFtVpeLEbay8+m0hkFghyaMllhRI
r0lEqJXdJDVF+631oadRew1S2dO6P0cPBlM2mK9gSbPNJZdkOgu3xkQSJOHUYuTT
VBYbzisdzF+27C+CCqnwEbA6D49+/ntIpbohzt0T/FlLFSSDTBOLCvPZ2yalHw0q
VIlIwyKsgM8UuT7uDpfh/a/6wqi0qh6fl85o1Gr/qNKG4P8StO9dU76m55dboBkg
A8/UXxqO6TOGPvavfZEgBdWp/PsrQLJJ31faURLfIRSWEJ59WfnfQ30n0h8JdKan
q2Dr8C7RKn5YvNvgAPUNkr75AeP5BA==
=auFt
-----END PGP SIGNATURE-----

--Sig_/EM/EaYw6DMwyr/_jC+NRfnQ--
