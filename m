Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A46C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E99222D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BB+YVH9E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393677AbfBNAXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:23:08 -0500
Received: from ozlabs.org ([203.11.71.1]:41855 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730819AbfBNAXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 19:23:08 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 440HD848JMz9sMx;
        Thu, 14 Feb 2019 11:23:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550103784;
        bh=ag5y8Vx0qxY6NS8/1fF2pcYGvT05vR6wfM70wr/s6Mw=;
        h=Date:From:To:Cc:Subject:From;
        b=BB+YVH9Evonu1+idaYSeuUn4fy4scb+YA03jSzk+WYw+OpXU9xNRu8it7Ztd+BbcN
         sb5bBn9Jb4CuperuA0F0OT7vq18pXowsgIbd3wVxKsaZBkgb8g6/odwOauIi5SsSiR
         HClNch8NJWQdKb16vKhFFV/FYtlYJTMgOBmJgvqC54KQ7ZJI9wT2zsSxE3+G7gX6Uv
         4GA95XEvUq+fWg5QYkNJd8AF+JF9VO5gI3AjA787idEMURkx/o3+BQfHsQZEnC91Ta
         a3gocv0AGI9xcrLvAW27fpLSKajZbPkGfu/YGmlhfqarEuQ24Ypsg4tA3uPuBG+ZQx
         9IS+wnqCLkulw==
Date:   Thu, 14 Feb 2019 11:23:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kaike Wan <kaike.wan@intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: linux-next: build warning after merge of the rdma tree
Message-ID: <20190214112300.41c0c7bd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/MSSFTuMe8sp0nPz+it+nlDX"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MSSFTuMe8sp0nPz+it+nlDX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rdma tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/infiniband/hw/hfi1/tid_rdma.c: In function 'hfi1_tid_rdma_wqe_inter=
lock':
drivers/infiniband/hw/hfi1/tid_rdma.c:3251:3: warning: this statement may f=
all through [-Wimplicit-fallthrough=3D]
   switch (prev->wr.opcode) {
   ^~~~~~
drivers/infiniband/hw/hfi1/tid_rdma.c:3259:2: note: here
  case IB_WR_RDMA_READ:
  ^~~~

Introduced by commit

  c6c231175ccd ("IB/hfi1: Add interlock between TID RDMA WRITE and other re=
quests")

I get this warning because I am building with -Wimplicit-fallthrough
in attempt to catch new additions early.  The gcc warning can be turned
off by adding a /* fall through */ comment at the point the fall through
happens (assuming that the fall through is intentional).

--=20
Cheers,
Stephen Rothwell

--Sig_/MSSFTuMe8sp0nPz+it+nlDX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxktOQACgkQAVBC80lX
0GxC0Qf7BVZ2hN4cB9kXnA7InYLEWZvykziVmOsx8qXNrJC/2r+QbEMLTtJhZx9t
YYyJ8Mq14qoxoXVlsem2fY2ZBlZA/lXJy7og5Lm8ErJC8Ofr27G6jL1AEIQrqflH
AKXTUJDD9hxUYMYCmdykUGEHOiBoUqjwH+J2l0SLjger2LKwwIjR6x/23/dCZ5dE
Jd0tRoY1zD/OW1deipStqXVeZT//Cs8iin+5koEF27+16vcjyg375tdedl2sRZLM
1VGkYYfMQcGkTL0rlYed04SW7snjGao88W8VbZPzX1SEXdptALJOWDWgCrymkl18
yqPF/LOVsrye6JtVz83Z6U4G/PluqA==
=umc/
-----END PGP SIGNATURE-----

--Sig_/MSSFTuMe8sp0nPz+it+nlDX--
