Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752007AbeCUDcB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 23:32:01 -0400
Received: from ozlabs.org ([103.22.144.67]:36217 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751581AbeCUDcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 23:32:00 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 21 Mar 2018 14:31:20 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: linux-next: manual merge of the selinux tree with the security tree
Message-ID: <20180321143120.6d9bbe0f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/KqbkvA9l0_pCmesndrQd5vm"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KqbkvA9l0_pCmesndrQd5vm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paul,

Today's linux-next merge of the selinux tree got a conflict in:

  security/selinux/hooks.c

between commit:

  6b4f3d01052a ("usb, signal, security: only pass the cred, not the secid, =
to kill_pid_info_as_cred and security_task_kill")

from the security tree and commit:

  6b6bc6205d98 ("selinux: wrap AVC state")

from the selinux tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc security/selinux/hooks.c
index fdd523e575e3,21b377aef69a..000000000000
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@@ -4050,11 -4164,10 +4170,12 @@@ static int selinux_task_kill(struct tas
  		perm =3D PROCESS__SIGNULL; /* null signal; existence test */
  	else
  		perm =3D signal_to_av(sig);
 -	if (!secid)
 +	if (!cred)
  		secid =3D current_sid();
 +	else
 +		secid =3D cred_sid(cred);
- 	return avc_has_perm(secid, task_sid(p), SECCLASS_PROCESS, perm, NULL);
+ 	return avc_has_perm(&selinux_state,
+ 			    secid, task_sid(p), SECCLASS_PROCESS, perm, NULL);
  }
 =20
  static void selinux_task_to_inode(struct task_struct *p,

--Sig_/KqbkvA9l0_pCmesndrQd5vm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqx0ggACgkQAVBC80lX
0GzwGQgAiduTSGQiurTzsVxygfFfrI0tRXKj73z66sS6bXeYu0e5Rbd8WAFoG1o2
PPAr9NHk8w3MFTF/yheeLJTcB7b6hO0vgLZW5THxYWVeiuugCzKqBW8yu+moFKP/
6M4Bgd6Xa2d9RwBhZewCZApBONgJEN6dld7sXSJIbf2+u2k++Q/FgOgM1xBCTXe0
LWd9DHnOTWEfM1KeNdPGjBgUpHfz4UOtV1yXdrAOHF8SFOqyUSZhrHZ5haSPRP7q
megKAboRgOb/tyzQ6bzvcqoDjFA7GZWQOsAAYt1za8ArusCuZ0vJZnIolSwu8JwA
kw4vUMXjCV75z6+8J8wF9Xabys9HvQ==
=1/zO
-----END PGP SIGNATURE-----

--Sig_/KqbkvA9l0_pCmesndrQd5vm--
