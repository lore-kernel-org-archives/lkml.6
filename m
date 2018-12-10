Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE405C07E85
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 01:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840AE2081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 01:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qGM9ppCQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840AE2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbeLJBgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 20:36:38 -0500
Received: from ozlabs.org ([203.11.71.1]:49035 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbeLJBgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 20:36:37 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43ClzQ2s8kz9s6w;
        Mon, 10 Dec 2018 12:36:34 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544405794;
        bh=QQ26+YHjj2TApSDmMTV8D5Y7q07lBycCnFOaJiLrjbo=;
        h=Date:From:To:Cc:Subject:From;
        b=qGM9ppCQW1187Ruf8A3OKl41B2si81lVfpKnUoaziGbtJItrynADfEaXqIc6rGufe
         9jTaq8KGMY248zx1fBI2MJ5tgjT+H5qzdKd1VuxJk77KZ2ANjxdduodtjiRlxbhH/I
         6en4ZSd8ZPd3BJcHzFeoGUUS2xZ22/vQd1Qttkd62uCZloXpgtXzY+6nnECSwAwoYb
         oWFuKnDCoROWE4plT7q1VTQCeoCRDvE7Q8al/5MLMUcCAS5odl0UbbYQGVodCBfupw
         xBp0v7+FNcJbDqY/84K6/lKEvxE/ODr631ZqyLITcZ6TN6MTZRz9sFeFcP00o2WbVn
         vj5cWYsCqEBRQ==
Date:   Mon, 10 Dec 2018 12:36:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        aul Blakey <paulb@mellanox.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20181210123633.4a0e4409@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/p=0FB9cZnhPyV_t8ywI.Uig"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/p=0FB9cZnhPyV_t8ywI.Uig
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/sched/cls_flower.c

between commit:

  35cc3cefc4de ("net/sched: cls_flower: Reject duplicated rules also under =
skip_sw")

from the net tree and commit:

  5c72299fba9d ("net: sched: cls_flower: Classify packets using port ranges=
")

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

diff --cc net/sched/cls_flower.c
index 71312d7bd8f4,85e9f8e1da10..000000000000
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@@ -1238,16 -1355,18 +1355,16 @@@ static int fl_change(struct net *net, s
  	if (err)
  		goto errout_idr;
 =20
- 	if (!fold && fl_lookup(fnew->mask, &fnew->mkey)) {
 -	if (!tc_skip_sw(fnew->flags)) {
 -		if (!fold && __fl_lookup(fnew->mask, &fnew->mkey)) {
 -			err =3D -EEXIST;
 -			goto errout_mask;
 -		}
 -
 -		err =3D rhashtable_insert_fast(&fnew->mask->ht, &fnew->ht_node,
 -					     fnew->mask->filter_ht_params);
 -		if (err)
 -			goto errout_mask;
++	if (!fold && __fl_lookup(fnew->mask, &fnew->mkey)) {
 +		err =3D -EEXIST;
 +		goto errout_mask;
  	}
 =20
 +	err =3D rhashtable_insert_fast(&fnew->mask->ht, &fnew->ht_node,
 +				     fnew->mask->filter_ht_params);
 +	if (err)
 +		goto errout_mask;
 +
  	if (!tc_skip_hw(fnew->flags)) {
  		err =3D fl_hw_replace_filter(tp, fnew, extack);
  		if (err)

--Sig_/p=0FB9cZnhPyV_t8ywI.Uig
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwNwyEACgkQAVBC80lX
0GwgkQgAoYXAkaYZRPt2n0QzjxBlzlMVySFZYWlHf5xoa45EYMjfV3mx9KMFPqjv
jg8OwwLvTQTVQLRvvUtYrm7tDJePnqcsJXul0DRFzICyLFWZlTeKEPKN9LRz3o8e
qeIEDyDZafoORscVFsvhcRF9wIWVcTE7vMK+X4hqEGmwLCCQYTis3Lo85yagquTw
oKVMlZmuCD9TXhGQuYW1VTivM505GjuB8pFkzKGaQqvPEjK+kODUDH1YM/R70DxU
GsKEIcuBhizYQ18xGrKAZJJNXkmGlskNoA8zmy8MviacOqyoFdHVTG3PPmTfJmAd
mIUl1p0FTj9tskDfC8GK/F5tdct29w==
=f+4/
-----END PGP SIGNATURE-----

--Sig_/p=0FB9cZnhPyV_t8ywI.Uig--
