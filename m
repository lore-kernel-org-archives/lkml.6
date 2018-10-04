Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9CBC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 23:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FBB52054F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 23:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="s4EysTCY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FBB52054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbeJEGug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 02:50:36 -0400
Received: from ozlabs.org ([203.11.71.1]:60395 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726113AbeJEGuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 02:50:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42R8rG0q0lz9s8J;
        Fri,  5 Oct 2018 09:54:38 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538697278;
        bh=od6haiOxBupMDI21XnRHOOzVRLaL2hzSbvNgjCqPrX8=;
        h=Date:From:To:Cc:Subject:From;
        b=s4EysTCYOcW9PZS9o9CYOT81XBsWakOwEKrSpZmTn2wrCO4k1XADvh4SxHgbJ01qN
         jkF9J8OrP88s4+Mwf7u6L53c9pPXyc3jv/dQA/6ZcHJYSm3eIljxRfhKMy2aCrkwun
         lcZqZOtFAanz9bn9enZrJLyHa5SN07ku+uSMRxgrnuUXKEsQYHHAHTb/fzwFnuZejq
         yN/Wi2zTih6Tskp9hWkC/Jxr2VT9zTZ3CSpWH5iAE8zS74ApKPEXUceQrt3kAXFbJl
         aLNj6mGTXtiSPN8WE8mIdM6KsBVGUEYvotdgF/nKy9DXoCZIexUfFFeyWLI7cjxcxM
         puD3mTngjqDaA==
Date:   Fri, 5 Oct 2018 09:54:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust <trondmy@gmail.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: linux-next: build failure after merge of the nfsd tree
Message-ID: <20181005095420.184c2619@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/S8UFiK7fsrvx3VuTVLrq.2/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/S8UFiK7fsrvx3VuTVLrq.2/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the nfsd tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

net/sunrpc/xprtrdma/svc_rdma_backchannel.c: In function 'svc_rdma_handle_bc=
_reply':
net/sunrpc/xprtrdma/svc_rdma_backchannel.c:67:21: error: 'struct rpc_xprt' =
has no member named 'recv_lock'; did you mean 'reserve_lock'?
  spin_unlock(&xprt->recv_lock);
                     ^~~~~~~~~
                     reserve_lock
net/sunrpc/xprtrdma/svc_rdma_backchannel.c:79:19: error: 'struct rpc_xprt' =
has no member named 'recv_lock'; did you mean 'reserve_lock'?
  spin_lock(&xprt->recv_lock);
                   ^~~~~~~~~
                   reserve_lock

Caused by commit

  cf4f6fd48dac ("svcrdma: Remove ->release_rqst call in bc reply handler")

interacting with commit

  75c84151a9dc ("SUNRPC: Rename xprt->recv_lock to xprt->queue_lock")

from the nfs tree.

I have added the following merge fix patch for today:

=46rom b249a74ca8c4f992e2530f95218ea4f2ed72e0b9 Mon Sep 17 00:00:00 2001
From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 5 Oct 2018 09:51:30 +1000
Subject: [PATCH] svcrdma: fix up for recv_lock rename

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c b/net/sunrpc/xprtrd=
ma/svc_rdma_backchannel.c
index 19e34a6aa583..2d176a48543a 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
@@ -64,7 +64,7 @@ int svc_rdma_handle_bc_reply(struct rpc_xprt *xprt, __be3=
2 *rdma_resp,
 		goto out_unlock;
 	memcpy(dst->iov_base, p, len);
 	xprt_pin_rqst(req);
-	spin_unlock(&xprt->recv_lock);
+	spin_unlock(&xprt->queue_lock);
=20
 	credits =3D be32_to_cpup(rdma_resp + 2);
 	if (credits =3D=3D 0)
@@ -76,7 +76,7 @@ int svc_rdma_handle_bc_reply(struct rpc_xprt *xprt, __be3=
2 *rdma_resp,
 	xprt->cwnd =3D credits << RPC_CWNDSHIFT;
 	spin_unlock_bh(&xprt->transport_lock);
=20
-	spin_lock(&xprt->recv_lock);
+	spin_lock(&xprt->queue_lock);
 	ret =3D 0;
 	xprt_complete_rqst(req->rq_task, rcvbuf->len);
 	xprt_unpin_rqst(req);
--=20
2.18.0

--=20
Cheers,
Stephen Rothwell

--Sig_/S8UFiK7fsrvx3VuTVLrq.2/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu2qD0ACgkQAVBC80lX
0Gxj2wgAik9JkgSUekw14i6iTUdXDMUXdvWxnIcDn2r7rJjCkljvjMI+waXTZfwU
0lvtyij6eFnbd0Zke1Uf82Th4d9+OpLEza8/Ntgizk3Kwl94FXkIv4T/K28trf3a
hpIzA/hu5hUS9XiZjlKnJo3wAsKs3qAaDxpEOl3FlzdumJAAoBn66dU2iZXe5soJ
vlctNGQVAvR3eJMjh2W072BMBhfPbJzLod4rz0vENopq3E8DvycTN+bapA2IAcLN
Svfm6hNP8Ns7Y8Ll4t+3UOt7Q9yJlhMAYs9WvKQNSXp4HOw18ulZ1el+UPoaeDNf
F0GFDwRnKf8XUudYyRWVhfmuj4Xrxw==
=KsQQ
-----END PGP SIGNATURE-----

--Sig_/S8UFiK7fsrvx3VuTVLrq.2/--
