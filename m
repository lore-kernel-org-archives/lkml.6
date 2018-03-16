Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932871AbeCPBSF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 21:18:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35626 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932341AbeCPBSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 21:18:04 -0400
Message-ID: <1521163082.18703.191.camel@redhat.com>
Subject: Re: linux-next: manual merge of the net-next tree with the
 rdma-fixes tree
From: Doug Ledford <dledford@redhat.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Bloch <markb@mellanox.com>, Leon Romanovsky <leonro@mellanox.com>
Date: Thu, 15 Mar 2018 21:18:02 -0400
In-Reply-To: <20180316115610.3d7f232a@canb.auug.org.au>
References: <20180316115610.3d7f232a@canb.auug.org.au>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-yqb1IDlM9mzkCVAXBMGC"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yqb1IDlM9mzkCVAXBMGC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-03-16 at 11:56 +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next merge of the net-next tree got a conflict in:
>=20
>   drivers/infiniband/hw/mlx5/main.c
>=20
> between commit:
>=20
>   42cea83f9524 ("IB/mlx5: Fix cleanup order on unload")
>=20
> from the rdma-fixes tree and commit:
>=20
>   b5ca15ad7e61 ("IB/mlx5: Add proper representors support")
>=20
> from the net-next tree.

We are aware of the merge conflict.  This is a result of the fact that
code had been submitted to the for-next area (the representors support)
and after that an issue was found by the syzkaller bot that deserved rc
fix status and which conflicted.  The fixup you list below is
insufficient to fix the merge conflict.  The full fixup can be found in
the rdma tree from where I merged the for-rc branch into the for-next
branch and created a complete fixup of the merge conflict.  The problem
is that one patch change the device init stage flow, while the other
patch duplicates the normal device init stage flow to the representor
device stage flow.  To resolve the fix, you not only have to resolve the
contextual diffs, but you have to duplicate the changes to the normal
device stage flow into the representor device stage flow.  It is very
far from a trivial merge.  We were planning on talking to Dave about
this issue tomorrow, but you beat us to raising the issue ;-).

Here's the commit (from the rdma git repo) with the proper merge fix
(although it also has other minor merge stuff that needs to be ignored):

2d873449a202 (Merge branch 'k.o/wip/dl-for-rc' into k.o/wip/dl-for-next)

> I fixed it up (see below and the merge fix patch as well) and can
> carry the fix as necessary. This is now fixed as far as linux-next is
> concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 16 Mar 2018 11:54:01 +1100
> Subject: [PATCH] IB/mlx5: merge fix for "Fix cleanup order on unload"
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/infiniband/hw/mlx5/ib_rep.c  | 6 +++---
>  drivers/infiniband/hw/mlx5/mlx5_ib.h | 3 +--
>  2 files changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mlx5/ib_rep.c b/drivers/infiniband/hw/=
mlx5/ib_rep.c
> index 61cc3d7db257..7fb997dadd80 100644
> --- a/drivers/infiniband/hw/mlx5/ib_rep.c
> +++ b/drivers/infiniband/hw/mlx5/ib_rep.c
> @@ -33,9 +33,9 @@ static const struct mlx5_ib_profile rep_profile =3D {
>  	STAGE_CREATE(MLX5_IB_STAGE_IB_REG,
>  		     mlx5_ib_stage_ib_reg_init,
>  		     mlx5_ib_stage_ib_reg_cleanup),
> -	STAGE_CREATE(MLX5_IB_STAGE_UMR_RESOURCES,
> -		     mlx5_ib_stage_umr_res_init,
> -		     mlx5_ib_stage_umr_res_cleanup),
> +	STAGE_CREATE(MLX5_IB_STAGE_POST_IB_REG_UMR,
> +		     mlx5_ib_stage_post_ib_reg_umr_init,
> +		     NULL),
>  	STAGE_CREATE(MLX5_IB_STAGE_CLASS_ATTR,
>  		     mlx5_ib_stage_class_attr_init,
>  		     NULL),
> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw=
/mlx5/mlx5_ib.h
> index 7ec753ec7962..c45a7abdbe3e 100644
> --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> @@ -1071,8 +1071,7 @@ int mlx5_ib_stage_bfrag_init(struct mlx5_ib_dev *de=
v);
>  void mlx5_ib_stage_bfrag_cleanup(struct mlx5_ib_dev *dev);
>  int mlx5_ib_stage_ib_reg_init(struct mlx5_ib_dev *dev);
>  void mlx5_ib_stage_ib_reg_cleanup(struct mlx5_ib_dev *dev);
> -int mlx5_ib_stage_umr_res_init(struct mlx5_ib_dev *dev);
> -void mlx5_ib_stage_umr_res_cleanup(struct mlx5_ib_dev *dev);
> +int mlx5_ib_stage_post_ib_reg_umr_init(struct mlx5_ib_dev *dev);
>  int mlx5_ib_stage_class_attr_init(struct mlx5_ib_dev *dev);
>  void __mlx5_ib_remove(struct mlx5_ib_dev *dev,
>  		      const struct mlx5_ib_profile *profile,
> --=20
> 2.16.1
>=20

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD
--=-yqb1IDlM9mzkCVAXBMGC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlqrG0oACgkQuCajMw5X
L91gmA/+NdQdzglKRQ0OvrLFkfH2iEaHWQOfKtxPnVj9fQ/We1v2lyKSeY6IuabD
pL652ZppLllywgiHUN+2zUAbbUYVa7UzVOsjWlDHg0/6185nJrcg7F3lRtcF5PMV
oJL0kaSl4tJOR74JqCtJ7TKCwRz0iaiB/z4CfMVBaCxu55NtvrR9y6197v/FE8Dv
XiN+zAvBCPuDG6IDQurr7abXR8qDqzIlmuhx60GgQEzQHT/ibQZve50ZWoMPmguV
+bRH86S8PZNy/HV/pmfmVgCQ0HBoO1cyVKY7VSUmQcc7PJ6GcuerTmhxo18r9mWb
704suukQ0/CPArJwVaZWEkhUcM8Rq0diyO42PTipaPIU7yuZmDrG1tUWzRkFDTb3
3NFOvGaR2PGcg0FCZWfrawUhim4PxvSVodfh/UtgjU7spMJxxNbEMt0ssM9j5UlY
aJ3Ya5iWoZ7j4QdkJiRS6kFy73m9GtgrZvDnnTK8FCMUD3q6drFI7RD5rf4Zs8ZL
ORZZAzdUEszhNp4V8NU8gXVowRA3KV3vHqJja9QGj4Es5f4P8k2vOeiOzpMJHwXU
U1X9vBN9in4t+4O0vpsjjvR0iJ+B9l1pLUb9+ue0FViTwlGA8P6JtE7UiW05soay
ydBKv4C5lwnz+Q8rgFHiUNA+kXmyDrBKkZRL87Q/et4PIT60qns=
=p3nB
-----END PGP SIGNATURE-----

--=-yqb1IDlM9mzkCVAXBMGC--
