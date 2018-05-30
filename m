Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937324AbeE3IbO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 04:31:14 -0400
Received: from ozlabs.org ([203.11.71.1]:59679 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935879AbeE3IbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 04:31:10 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 30 May 2018 18:30:58 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        Russell King <rmk@armlinux.org.uk>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the userns tree with the arm tree
Message-ID: <20180530183058.06a26dbe@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3d+Ldxg8aJ2vDy/UUZVst7h"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3d+Ldxg8aJ2vDy/UUZVst7h
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the userns tree got a conflict in:

  arch/arm/mm/fault.c

between commit:

  93a24d7e23e7 ("ARM: spectre-v2: harden user aborts in kernel space")

from the arm tree and commit:

  3eb0f5193b49 ("signal: Ensure every siginfo we send has all bits initiali=
zed")

from the userns tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm/mm/fault.c
index 3b1ba003c4f9,32034543f49c..000000000000
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@@ -163,9 -163,8 +163,11 @@@ __do_user_fault(struct task_struct *tsk
  {
  	struct siginfo si;
 =20
 +	if (addr > TASK_SIZE)
 +		harden_branch_predictor();
 +
+ 	clear_siginfo(&si);
+=20
  #ifdef CONFIG_DEBUG_USER
  	if (((user_debug & UDBG_SEGV) && (sig =3D=3D SIGSEGV)) ||
  	    ((user_debug & UDBG_BUS)  && (sig =3D=3D SIGBUS))) {

--Sig_/3d+Ldxg8aJ2vDy/UUZVst7h
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsOYUIACgkQAVBC80lX
0Gw8wAf/YCf1DM5ZYfYeasTLEq5UyuAWf9QgrNLL1WywYt+BQMvhqVODpJ+mCmgG
f8selFj21jG9RyLjzooGsFfl/2OiVRua3DIXlZQPFICxqqPKnzrTsWCo0t5Q08vg
w+y4cdXqYtMyED65RMAtlc6kybWV+ZCsrJatwt57Q7TExemUS88K2t6gazisu/S+
DnCsRxWLx9hTPW/FvVBaf7AwT1QCPBjI9uheUG49tR/phK5gcK3sd/2oHJIZ5lZ9
iKVGHwa7ocsH/kXX5dZXW2I7JjMKE7CHqiMF9XiLJsvoYNXpwqcAvV16dwmMjQSo
EKYmv3VDEn/aH7zaXYXyfDpnYimn3g==
=eB72
-----END PGP SIGNATURE-----

--Sig_/3d+Ldxg8aJ2vDy/UUZVst7h--
