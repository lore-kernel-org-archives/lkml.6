Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965024AbeB1XaR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 18:30:17 -0500
Received: from ozlabs.org ([103.22.144.67]:47833 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964903AbeB1XaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 18:30:15 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 1 Mar 2018 10:30:02 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arkadi Sharshevsky <arkadis@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>
Subject: linux-next: build failure after merge of the net-next tree
Message-ID: <20180301103002.29b7de11@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bdLWrkyxTb6eeFHqag1FrZ="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bdLWrkyxTb6eeFHqag1FrZ=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (x86_64
allmodconfig) failed like this:

net/core/devlink.c: In function 'devlink_resource_validate_size':
net/core/devlink.c:2349:34: error: invalid type argument of '->' (have 'str=
uct devlink_resource_size_params')
  if (size > resource->size_params->size_max) {
                                  ^~
net/core/devlink.c:2354:34: error: invalid type argument of '->' (have 'str=
uct devlink_resource_size_params')
  if (size < resource->size_params->size_min) {
                                  ^~
net/core/devlink.c:2359:43: error: invalid type argument of '->' (have 'str=
uct devlink_resource_size_params')
  div64_u64_rem(size, resource->size_params->size_granularity, &reminder);
                                           ^~

Caused by commit

  cc944ead839a ("devlink: Move size validation to core")

interacting with commit

  77d270967c5f ("mlxsw: spectrum: Fix handling of resource_size_param")

from the net tree.

I have applied the following merge fix patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 1 Mar 2018 10:24:31 +1100
Subject: [PATCH] devlink: merge fix up for resource_size_param changes

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 net/core/devlink.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/devlink.c b/net/core/devlink.c
index e7cb957d9efb..1b5bf0d1cee9 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -2346,17 +2346,17 @@ devlink_resource_validate_size(struct devlink_resou=
rce *resource, u64 size,
 	u64 reminder;
 	int err =3D 0;
=20
-	if (size > resource->size_params->size_max) {
+	if (size > resource->size_params.size_max) {
 		NL_SET_ERR_MSG_MOD(extack, "Size larger than maximum");
 		err =3D -EINVAL;
 	}
=20
-	if (size < resource->size_params->size_min) {
+	if (size < resource->size_params.size_min) {
 		NL_SET_ERR_MSG_MOD(extack, "Size smaller than minimum");
 		err =3D -EINVAL;
 	}
=20
-	div64_u64_rem(size, resource->size_params->size_granularity, &reminder);
+	div64_u64_rem(size, resource->size_params.size_granularity, &reminder);
 	if (reminder) {
 		NL_SET_ERR_MSG_MOD(extack, "Wrong granularity");
 		err =3D -EINVAL;
--=20
2.16.1

--=20
Cheers,
Stephen Rothwell

--Sig_/bdLWrkyxTb6eeFHqag1FrZ=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqXO3oACgkQAVBC80lX
0GwI+gf/Yj1doAb4kbJROZUfxvIjESAik7UG/Egn6Q8U2iABNlFpoTQRfXdJ1XmC
tum0u6hUyS2KhZGsCQIzDN9kA7hAhDjnN7QAB3uZcPNvqUADgOm1n2Rc2jTYtFIt
2qPb8M8BVvGKN4E4RhxdGsP1Pq5BbW0fkcGiDf2LfADzODGCnFEpR4KLrVpinwp/
1m4n/Ei3sl/c14POFuoy3C77RESKmMXDZ20cO+lCTC5CpLyzGUBirvnFnuXYGaVZ
bSrmxXcmORU0g7wRYQQ0yr7E1Qy6+F2mwIjVahxrW6Svb7LWPTHMR85RCpxSJFJ7
f5pFOc+7KbgpU5E/VXJnSVhs57ftoA==
=9/rp
-----END PGP SIGNATURE-----

--Sig_/bdLWrkyxTb6eeFHqag1FrZ=--
