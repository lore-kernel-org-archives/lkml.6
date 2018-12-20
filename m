Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BC2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E6020989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KoiY4PMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbeLTB4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 20:56:54 -0500
Received: from ozlabs.org ([203.11.71.1]:47193 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729420AbeLTB4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 20:56:53 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43Kvy94vMjz9sBh;
        Thu, 20 Dec 2018 12:56:49 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545271009;
        bh=J2MZZqU54ZLzHUz9Y/ctczxzn5j/JWRXeR2o5E73BV8=;
        h=Date:From:To:Cc:Subject:From;
        b=KoiY4PMwskz3ryHzom/97m+qHHMPgwSr54CfeDWoZ3Y4170aQa2cgblVezg/cQS6/
         j55b1ITAJEY0QpqbI4soBSEyV1/AT8EFbCx1Rdcxcx1NWoUnft+P7fIzlcpCiClwIM
         MG4EyQ1nQGJFmLKj4jvFQc+HH9g1mY8v8X/tN2qHiwAqAs4TaVJ+JDjrrVw12CF719
         LFmmQ4zyCU5xbHai5lb67XghrE40Fp75H8vNQ31J2Yr2jCoN7BWWZr0M7eIFr8JnKU
         pFp7XBAFqYOyhDNrUbLkRnv78227p71/mQ14KGjnHewsJPgP5cCEWdj8ZJs8PsjGjD
         wOPI302GmbdSQ==
Date:   Thu, 20 Dec 2018 12:56:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Petr Machata <petrm@mellanox.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20181220125635.76ae89ad@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/rN_.1I6oz98LMOcMEqK5afx"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rN_.1I6oz98LMOcMEqK5afx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/vxlan.c

between commits:

  6db924687139 ("vxlan: Fix error path in __vxlan_dev_create()")
  ce5e098f7a10 ("vxlan: changelink: Fix handling of default remotes")

from the net tree and commit:

  0e6160f3f5a9 ("vxlan: vxlan_fdb_notify(): Make switchdev notification con=
figurable")

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

diff --cc drivers/net/vxlan.c
index 0565f8880199,71c3b7b6b1ab..000000000000
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@@ -3297,16 -3483,9 +3484,16 @@@ static int __vxlan_dev_create(struct ne
 =20
  	list_add(&vxlan->next, &vn->vxlan_list);
  	return 0;
 +
  errout:
 +	/* unregister_netdevice() destroys the default FDB entry with deletion
 +	 * notification. But the addition notification was not sent yet, so
 +	 * destroy the entry by hand here.
 +	 */
  	if (f)
- 		vxlan_fdb_destroy(vxlan, f, false);
+ 		vxlan_fdb_destroy(vxlan, f, false, false);
 +	if (unregister)
 +		unregister_netdevice(dev);
  	return err;
  }
 =20
@@@ -3540,8 -3719,10 +3727,9 @@@ static int vxlan_changelink(struct net_
  {
  	struct vxlan_dev *vxlan =3D netdev_priv(dev);
  	struct vxlan_rdst *dst =3D &vxlan->default_dst;
+ 	unsigned long old_age_interval;
  	struct vxlan_rdst old_dst;
  	struct vxlan_config conf;
 -	struct vxlan_fdb *f =3D NULL;
  	int err;
 =20
  	err =3D vxlan_nl2conf(tb, data,
@@@ -3564,13 -3749,13 +3756,14 @@@
  					   vxlan->cfg.dst_port,
  					   old_dst.remote_vni,
  					   old_dst.remote_vni,
- 					   old_dst.remote_ifindex, 0);
+ 					   old_dst.remote_ifindex,
+ 					   true);
 =20
  		if (!vxlan_addr_any(&dst->remote_ip)) {
 -			err =3D vxlan_fdb_create(vxlan, all_zeros_mac,
 +			err =3D vxlan_fdb_update(vxlan, all_zeros_mac,
  					       &dst->remote_ip,
  					       NUD_REACHABLE | NUD_PERMANENT,
 +					       NLM_F_APPEND | NLM_F_CREATE,
  					       vxlan->cfg.dst_port,
  					       dst->remote_vni,
  					       dst->remote_vni,

--Sig_/rN_.1I6oz98LMOcMEqK5afx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwa9tMACgkQAVBC80lX
0GxyhAf/RTpapDLHDtZ8Owg+OB7R34ZbrO5YNvGQeyTipJsnH8tqucKSY0H6LPqf
j2U1UR9PUSEwYllH5YUSBEETT4Y2DVHHC8I6c3GPGFwGyLt+AtXhK1j/99swKQ5g
tqnCQdu0pti/1d9FomXs+5tcN4HY9liWGB4eNlBBrqeojzNjMzp7y8Bnb7HDH16/
G1CQgl4H/yzFM957tzhz5Qs0tlkz38rxShDa/xT0/sA8k1iCJZLMUtx0Dj2EXvEq
PPNtNnoAhuXfppKT2aDPpMzjqZDmLA4DzoXtj0mFbf+XUblq/LR6pSApozKYklwD
AjeiRHBbVesVli47Sj6wjx5QtplBsQ==
=qH2F
-----END PGP SIGNATURE-----

--Sig_/rN_.1I6oz98LMOcMEqK5afx--
