Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B57C6778C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 00:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBA2256AF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 00:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KSnDbJ3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BBA2256AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752816AbeGBAVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 20:21:13 -0400
Received: from ozlabs.org ([203.11.71.1]:57163 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752625AbeGBAVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 20:21:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Jnwg0k48z9s1b;
        Mon,  2 Jul 2018 10:21:07 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1530490867;
        bh=W7QlYv7ItvQ8Un11e2thj6yrFIPKIcGKvy29Cu8hAxw=;
        h=Date:From:To:Cc:Subject:From;
        b=KSnDbJ3iv6C8vDfsnZ3anYqohbL1WbhioA9G+G0etbMOFxwLIWL9qsGDw2+oT1Fse
         bP9I+qaFP2CwX5BB/tzMouTFbh5H7BG/jK/EfDVyQSCr0P732wO2dOUxLvz7mgFH9s
         1GMggRFuLsn04uf5kqOXk7rOLFRVkapNdF+wWyG8K9TYl5vaTkrVbTGjtb0e/2pgvF
         NP17OegWUQ6cZ3FQ3pTExnozTCa05JIJywGedFy7B6NOGp3uuyr6IIdd0EQw5gh3Q7
         010F+0pX3aSOPqbCf1i4r+KD7lALPU+XhL+nCzoNVFwtbRtSOEyBdZzeH5v+DHnuoz
         z25liKQVSzsJQ==
Date:   Mon, 2 Jul 2018 10:21:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>
Subject: linux-next: manual merge of the net-next tree with the rdma tree
Message-ID: <20180702102106.4ac2bd17@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3A3sm3gFhnnudXWR9NN/qs/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3A3sm3gFhnnudXWR9NN/qs/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/smc/smc_ib.c

between commit:

  ddb457c6993b ("net/smc: Replace ib_query_gid with rdma_get_gid_attr")

from the rdma tree and commit:

  be6a3f38ff2a ("net/smc: determine port attributes independent from pnet t=
able")

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

diff --cc net/smc/smc_ib.c
index 74f29f814ec1,36de2fd76170..000000000000
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@@ -144,6 -143,62 +144,66 @@@ out
  	return rc;
  }
 =20
+ static int smc_ib_fill_gid_and_mac(struct smc_ib_device *smcibdev, u8 ibp=
ort)
+ {
 -	struct ib_gid_attr gattr;
 -	int rc;
 -
 -	rc =3D ib_query_gid(smcibdev->ibdev, ibport, 0,
 -			  &smcibdev->gid[ibport - 1], &gattr);
 -	if (rc || !gattr.ndev)
 -		return -ENODEV;
++	const struct ib_gid_attr *gattr;
++	int rc =3D 0;
+=20
 -	memcpy(smcibdev->mac[ibport - 1], gattr.ndev->dev_addr, ETH_ALEN);
 -	dev_put(gattr.ndev);
 -	return 0;
++	gattr =3D rdma_get_gid_attr(smcibdev->ibdev, ibport, 0);
++	if (IS_ERR(gattr))
++		return PTR_ERR(gattr);
++	if (!gattr->ndev) {
++		rc =3D -ENODEV;
++		goto done;
++	}
++	smcibdev->gid[ibport - 1] =3D gattr->gid;
++	memcpy(smcibdev->mac[ibport - 1], gattr->ndev->dev_addr, ETH_ALEN);
++done:
++	rdma_put_gid_attr(gattr);
++	return rc;
+ }
+=20
+ /* Create an identifier unique for this instance of SMC-R.
+  * The MAC-address of the first active registered IB device
+  * plus a random 2-byte number is used to create this identifier.
+  * This name is delivered to the peer during connection initialization.
+  */
+ static inline void smc_ib_define_local_systemid(struct smc_ib_device *smc=
ibdev,
+ 						u8 ibport)
+ {
+ 	memcpy(&local_systemid[2], &smcibdev->mac[ibport - 1],
+ 	       sizeof(smcibdev->mac[ibport - 1]));
+ 	get_random_bytes(&local_systemid[0], 2);
+ }
+=20
+ bool smc_ib_port_active(struct smc_ib_device *smcibdev, u8 ibport)
+ {
+ 	return smcibdev->pattr[ibport - 1].state =3D=3D IB_PORT_ACTIVE;
+ }
+=20
+ static int smc_ib_remember_port_attr(struct smc_ib_device *smcibdev, u8 i=
bport)
+ {
+ 	int rc;
+=20
+ 	memset(&smcibdev->pattr[ibport - 1], 0,
+ 	       sizeof(smcibdev->pattr[ibport - 1]));
+ 	rc =3D ib_query_port(smcibdev->ibdev, ibport,
+ 			   &smcibdev->pattr[ibport - 1]);
+ 	if (rc)
+ 		goto out;
+ 	/* the SMC protocol requires specification of the RoCE MAC address */
+ 	rc =3D smc_ib_fill_gid_and_mac(smcibdev, ibport);
+ 	if (rc)
+ 		goto out;
+ 	if (!strncmp(local_systemid, SMC_LOCAL_SYSTEMID_RESET,
+ 		     sizeof(local_systemid)) &&
+ 	    smc_ib_port_active(smcibdev, ibport))
+ 		/* create unique system identifier */
+ 		smc_ib_define_local_systemid(smcibdev, ibport);
+ out:
+ 	return rc;
+ }
+=20
  /* process context wrapper for might_sleep smc_ib_remember_port_attr */
  static void smc_ib_port_event_work(struct work_struct *work)
  {

--Sig_/3A3sm3gFhnnudXWR9NN/qs/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAls5b/IACgkQAVBC80lX
0Gzr0Af/VMEfivbvdiVq57zUT/IEn/2UFkN8IQMDIO0Tmzs5U4NzNuk+6ZZqsXoh
5SnhasStszQWZghjZgE8d1N6JSV4bedYzAD6uMiFqAL8RK8bl0zGaWDj4Tqsj/QN
S/q2LUapDimbkCm6VXsRSWQdCyYLbkbd6wbY+lVFeCIV91K0L+iQkNjCOnHm5syB
rmp6tXjHQ+/GCZbhUMv3xLKBtQ6+1IN/m2x+V75IL5lSt/u5J4pY0DGNuFjRIWK2
bvy+FVa9i75+HhMvFwiapBOrh/6plpoXYfBZ1on3KhqSO9LYIhGl2kinpgudCM4m
WOvR7uFbzOVOI5I+oFrg+kYPyZDDtQ==
=8ug9
-----END PGP SIGNATURE-----

--Sig_/3A3sm3gFhnnudXWR9NN/qs/--
