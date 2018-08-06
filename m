Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782D3C46470
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 02:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D90219A2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 02:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dTREDe3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D90219A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbeHFEIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 00:08:18 -0400
Received: from ozlabs.org ([203.11.71.1]:41523 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725266AbeHFEIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 00:08:18 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41kLVN12Qzz9s0n;
        Mon,  6 Aug 2018 12:01:31 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533520892;
        bh=kdZ5ILMWgOGh2c1BmVD62mLj67SAYgtxh2AuQyL5vNw=;
        h=Date:From:To:Cc:Subject:From;
        b=dTREDe3U94ly8otyXhct+Vt1E2sXbhk+w3F1+Jwukda9UKeeEGLZx+t057PmzQI3j
         Rhex2gr1E6jh7SqPW4nm9n0dVOEJdE6DjK0Sp4c7590hU6RO8o8Owa5KZCbuInpY2s
         +uCpt7EplYJCtXFXbO+w9nSmLJxO+y2uuD1Q4Z+O1KVYt6YQP4WkG9m3IAxCwNEhlU
         nquIBgCArefv2HiM8AaeI8FimYVgzDOD10ytI/hsL9K4qSPASzG8lepV0M3t8c2sol
         jHymkvULSJKjOU5om6cSjBTEY2bJwGGwrubLOyx10NfTPYdkZ1Ncn07q9cycJjxv2J
         8AC5vnyXtFx2g==
Date:   Mon, 6 Aug 2018 12:01:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the rdma tree with Linus' tree
Message-ID: <20180806120131.169f70f3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Zj.KEDY3uN5lYsg_mN5C6Ol"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Zj.KEDY3uN5lYsg_mN5C6Ol
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rdma tree got a conflict in:

  drivers/infiniband/core/uverbs_main.c

between commit:

  1eb9364ce81d ("IB/uverbs: Fix ordering of ucontext check in ib_uverbs_wri=
te")

from Linus' tree and commit:

  a9b66d6453d7 ("IB/uverbs: Do not block disassociate during write()")

from the rdma tree.

I fixed it up (I am not entirely sure this is correct, but see below) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/infiniband/core/uverbs_main.c
index 2094d136513d,6f62146e9738..000000000000
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@@ -748,24 -758,8 +758,18 @@@ static ssize_t ib_uverbs_write(struct f
  		return ret;
 =20
  	srcu_key =3D srcu_read_lock(&file->device->disassociate_srcu);
- 	ib_dev =3D srcu_dereference(file->device->ib_dev,
- 				  &file->device->disassociate_srcu);
- 	if (!ib_dev) {
- 		ret =3D -EIO;
- 		goto out;
- 	}
 =20
 +	/*
 +	 * Must be after the ib_dev check, as once the RCU clears ib_dev =3D=3D
 +	 * NULL means ucontext =3D=3D NULL
 +	 */
 +	if (!file->ucontext &&
 +	    (command !=3D IB_USER_VERBS_CMD_GET_CONTEXT || extended)) {
 +		ret =3D -EINVAL;
 +		goto out;
 +	}
 +
- 	if (!verify_command_mask(ib_dev, command, extended)) {
+ 	if (!verify_command_mask(file, command, extended)) {
  		ret =3D -EOPNOTSUPP;
  		goto out;
  	}

--Sig_/Zj.KEDY3uN5lYsg_mN5C6Ol
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltnq/sACgkQAVBC80lX
0Gy5gAf9GksJSgpLQ8wN/vpyH5Z7wrL/lg+4FQ0z64925H9MwXl9/ysskiR3m6oh
BuPGCn6xZbeJfEpwPY8d2Fc0kSvHnzIxfl6M67ePxpM1nx1MsUyNXheq1NtJ3oGt
tG7WW1L2VLWfoPApBsZN8719L/ADPyl3p2ik96f7qgduzNWX0H714RELgNUesY1A
a8PE2IjN7pfnzJWA0WjRN2HhU4kmqH9kFggkYZfLNXBtbjKcs8zyn4F5l8S3WgaI
f5bRw2EVdFop1KKff0ff+mgfVHH1Tj/X3B8226v2NTlQZpYsrlbd9KuG0Bm4zSkW
C0V2X2UULzYBb6yjkC8Fo10EXkR0dQ==
=lEbX
-----END PGP SIGNATURE-----

--Sig_/Zj.KEDY3uN5lYsg_mN5C6Ol--
