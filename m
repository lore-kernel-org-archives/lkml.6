Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752215AbeEODGb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 23:06:31 -0400
Received: from ozlabs.org ([203.11.71.1]:54379 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752009AbeEODGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 23:06:30 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 15 May 2018 13:06:19 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Moore <paul@paul-moore.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: linux-next: manual merge of the audit tree with the selinux tree
Message-ID: <20180515130619.2e9e033c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/FMib1Efj0uJno1PcSGGQen5"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FMib1Efj0uJno1PcSGGQen5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paul,

Today's linux-next merge of the audit tree got a conflict in:

  security/selinux/selinuxfs.c

between commit:

  4195ed425d3c ("audit: normalize MAC_STATUS record")

from the selinux tree and commits:

  cdfb6b341f0f ("audit: use inline function to get audit context")
  d141136f523a ("audit: normalize MAC_POLICY_LOAD record")

from the audit tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc security/selinux/selinuxfs.c
index c0cadbc5f85c,35fd77737c59..000000000000
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@@ -167,13 -167,11 +167,13 @@@ static ssize_t sel_write_enforce(struc
  				      NULL);
  		if (length)
  			goto out;
- 		audit_log(current->audit_context, GFP_KERNEL, AUDIT_MAC_STATUS,
+ 		audit_log(audit_context(), GFP_KERNEL, AUDIT_MAC_STATUS,
 -			"enforcing=3D%d old_enforcing=3D%d auid=3D%u ses=3D%u",
 +			"enforcing=3D%d old_enforcing=3D%d auid=3D%u ses=3D%u"
 +			" enabled=3D%d old-enabled=3D%d lsm=3Dselinux res=3D1",
  			new_value, old_value,
  			from_kuid(&init_user_ns, audit_get_loginuid(current)),
 -			audit_get_sessionid(current));
 +			audit_get_sessionid(current),
 +			selinux_enabled, selinux_enabled);
  		enforcing_set(state, new_value);
  		if (new_value)
  			avc_ss_reset(state->avc, 0);
@@@ -303,12 -299,10 +303,12 @@@ static ssize_t sel_write_disable(struc
  		length =3D selinux_disable(fsi->state);
  		if (length)
  			goto out;
- 		audit_log(current->audit_context, GFP_KERNEL, AUDIT_MAC_STATUS,
+ 		audit_log(audit_context(), GFP_KERNEL, AUDIT_MAC_STATUS,
 -			"selinux=3D0 auid=3D%u ses=3D%u",
 +			"enforcing=3D%d old_enforcing=3D%d auid=3D%u ses=3D%u"
 +			" enabled=3D%d old-enabled=3D%d lsm=3Dselinux res=3D1",
 +			enforcing, enforcing,
  			from_kuid(&init_user_ns, audit_get_loginuid(current)),
 -			audit_get_sessionid(current));
 +			audit_get_sessionid(current), 0, 1);
  	}
 =20
  	length =3D count;
@@@ -581,8 -575,8 +581,8 @@@ static ssize_t sel_write_load(struct fi
  	length =3D count;
 =20
  out1:
- 	audit_log(current->audit_context, GFP_KERNEL, AUDIT_MAC_POLICY_LOAD,
+ 	audit_log(audit_context(), GFP_KERNEL, AUDIT_MAC_POLICY_LOAD,
 -		"policy loaded auid=3D%u ses=3D%u",
 +		"auid=3D%u ses=3D%u lsm=3Dselinux res=3D1",
  		from_kuid(&init_user_ns, audit_get_loginuid(current)),
  		audit_get_sessionid(current));
  out:

--Sig_/FMib1Efj0uJno1PcSGGQen5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr6TqsACgkQAVBC80lX
0Gzrlwf4hlr1ML8jolSWepH57egtrx69gPStX3cTB/HMjSLi9R2zqVVBCrqaFQyB
tETNiqnHRXLW6yeS6/PlQM7YI1xgLqF/WGR3ANkycttPuetUUe9KciCU4Ok0hKji
Yj+xMr9Z1cjpi8zQ6Js/6UWpgxnU31rmgDF/83b0DLgy4Ey5N4cUNO1+y55YiWie
uID8LOWaLevyxuGlx12CUpOMxzlZyJtVnrdLG5LHao/K1zANhwHiKyQkgpnRNBsU
cli9xHcr/ttUHwczJ7DX56VF130/Pe1kuGxBa/OBJ49qhytGkbwNKUbMi5uSz8K4
gADBWFWU+YZbszc0+OD3TkrgFTVd
=Kpp2
-----END PGP SIGNATURE-----

--Sig_/FMib1Efj0uJno1PcSGGQen5--
