Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750964AbeFABwU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 21:52:20 -0400
Received: from ozlabs.org ([203.11.71.1]:40135 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750757AbeFABwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 21:52:18 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 1 Jun 2018 11:52:14 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: manual merge of the vfs tree with Linus' tree
Message-ID: <20180601115214.25f6e1b9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=MtyrY4w.OwqIM_m+9rpcib"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=MtyrY4w.OwqIM_m+9rpcib
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

Today's linux-next merge of the vfs tree got a conflict in:

  fs/afs/fsclient.c

between commit:

  684b0f68cf1c ("afs: Fix AFSFetchStatus decoder to provide OpenAFS compati=
bility")

from Linus' tree and commit:

  c875c76a061d ("afs: Fix a Sparse warning in xdr_decode_AFSFetchStatus()")

from the vfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/afs/fsclient.c
index b273e1d60478,b695d9e16c65..000000000000
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@@ -138,37 -137,14 +138,31 @@@ static int xdr_decode_AFSFetchStatus(st
  	u64 data_version, size;
  	u32 type, abort_code;
  	u8 flags =3D 0;
- 	int ret;
-=20
- 	if (vnode)
- 		write_seqlock(&vnode->cb_lock);
 =20
 +	abort_code =3D ntohl(xdr->abort_code);
 +
  	if (xdr->if_version !=3D htonl(AFS_FSTATUS_VERSION)) {
 +		if (xdr->if_version =3D=3D htonl(0) &&
 +		    abort_code !=3D 0 &&
 +		    inline_error) {
 +			/* The OpenAFS fileserver has a bug in FS.InlineBulkStatus
 +			 * whereby it doesn't set the interface version in the error
 +			 * case.
 +			 */
 +			status->abort_code =3D abort_code;
- 			ret =3D 0;
- 			goto out;
++			return 0;
 +		}
 +
  		pr_warn("Unknown AFSFetchStatus version %u\n", ntohl(xdr->if_version));
  		goto bad;
  	}
 =20
 +	if (abort_code !=3D 0 && inline_error) {
 +		status->abort_code =3D abort_code;
- 		ret =3D 0;
- 		goto out;
++		return 0;
 +	}
 +
  	type =3D ntohl(xdr->type);
 -	abort_code =3D ntohl(xdr->abort_code);
  	switch (type) {
  	case AFS_FTYPE_FILE:
  	case AFS_FTYPE_DIR:

--Sig_/=MtyrY4w.OwqIM_m+9rpcib
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsQps4ACgkQAVBC80lX
0Gxsgwf/YfgQXbBQ6SIGH2KiUWRnbLgP6eYxVtt2clNSuZj+4oCgEhgD0W92GNvT
Ll6QCbGVd60/+sOj0RYpQkcNwe5fftSQLZOQ8BPco+jjsIFRUisIvRdFIGXGvZGZ
X3OiUNXuiDA4NwKaVzqEJ8n7uE6bmscYVRcEXys+WkVbBznoeSxvcNIYO2KQt+tg
QkCvCmCGaNflly6BNkEYI1IOiYcI6VJVgmsT/XLiM5RA5tyM81BikdKTlBZDOAdS
Nj6UZ1L95BHbahvPEuxMVcifb1EYIx/miEMb3MoCKIqGPIgkRi3a4Itv9QD/8/5W
gKVxaLUhNX9GT6kCeTrJQWI+XHTA5A==
=gTN7
-----END PGP SIGNATURE-----

--Sig_/=MtyrY4w.OwqIM_m+9rpcib--
