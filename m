Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbeDQBdb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 21:33:31 -0400
Received: from ozlabs.org ([203.11.71.1]:48885 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751060AbeDQBd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 21:33:29 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 17 Apr 2018 11:32:18 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Howells <dhowells@redhat.com>, Jessica Yu <jeyu@kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Subject: linux-next: manual merge of the efi-lock-down tree with the modules
 tree
Message-ID: <20180417113218.4e6ba307@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/FR17Ty4Fu+ptL0fRZVkBCxB"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FR17Ty4Fu+ptL0fRZVkBCxB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

Today's linux-next merge of the efi-lock-down tree got a conflict in:

  kernel/module.c

between commit:

  2c8fd268f418 ("module: Do not access sig_enforce directly")

from the modules tree and commit:

  7c0d4949d834 ("Enforce module signatures if the kernel is locked down")

from the efi-lock-down tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc kernel/module.c
index 1e3337bcf1e7,62419cf48ef6..000000000000
--- a/kernel/module.c
+++ b/kernel/module.c
@@@ -2777,19 -2786,46 +2780,46 @@@ static int module_sig_check(struct load
  		err =3D mod_verify_sig(mod, &info->len);
  	}
 =20
- 	if (!err) {
+ 	switch (err) {
+ 	case 0:
  		info->sig_ok =3D true;
  		return 0;
- 	}
 =20
- 	/* Not having a signature is only an error if we're strict. */
- 	if (err =3D=3D -ENOKEY && !is_module_sig_enforced())
- 		err =3D 0;
+ 		/* We don't permit modules to be loaded into trusted kernels
+ 		 * without a valid signature on them, but if we're not
+ 		 * enforcing, certain errors are non-fatal.
+ 		 */
+ 	case -ENODATA:
+ 		reason =3D "Loading of unsigned module";
+ 		goto decide;
+ 	case -ENOPKG:
+ 		reason =3D "Loading of module with unsupported crypto";
+ 		goto decide;
+ 	case -ENOKEY:
+ 		reason =3D "Loading of module with unavailable key";
+ 	decide:
 -		if (sig_enforce) {
++		if (is_module_sig_enforced()) {
+ 			pr_notice("%s is rejected\n", reason);
+ 			return -EKEYREJECTED;
+ 		}
 =20
- 	return err;
+ 		if (can_do_ima_check && is_ima_appraise_enabled())
+ 			return 0;
+ 		if (kernel_is_locked_down(reason))
+ 			return -EPERM;
+ 		return 0;
+=20
+ 		/* All other errors are fatal, including nomem, unparseable
+ 		 * signatures and signature check failures - even if signatures
+ 		 * aren't required.
+ 		 */
+ 	default:
+ 		return err;
+ 	}
  }
  #else /* !CONFIG_MODULE_SIG */
- static int module_sig_check(struct load_info *info, int flags)
+ static int module_sig_check(struct load_info *info, int flags,
+ 			    bool can_do_ima_check)
  {
  	return 0;
  }

--Sig_/FR17Ty4Fu+ptL0fRZVkBCxB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrVTqIACgkQAVBC80lX
0GxIXgf9G5UDqwoQ8azpGfzQXVu1jqEFmXahu513SpP5js9ALlDCy8hnO+gDZuoW
Z1NaIqEABP6h7dM4TmuNdf4DE7IqJL3X/JcfvmSwYQboWDqdIMxb/AqFvnnTO2OL
KZ31UbDGMMrXEi+0iujBjLGND2l0icKCUJdaYZU8yXRKWyVruNR8wD+xkBhZ9C5y
q5q7iLKiIt2OQFpLJzzuxdtGAx8J2BGXlBZwYhEkneRWKET5Zsh8OsFnM/oJdOCu
ttQyG6yQBBcJfIlpmuuo/FrazNnnYJpuwJ5l4q5zS1rk5nNpHoaH+XfI42Ugq/Q6
33SZzuXd5su1Z5O4SeVDgK9JUAaUNQ==
=8lVf
-----END PGP SIGNATURE-----

--Sig_/FR17Ty4Fu+ptL0fRZVkBCxB--
