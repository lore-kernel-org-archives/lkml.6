Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7143C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71CC0222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="D2pYjEVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404676AbfBNASs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:18:48 -0500
Received: from ozlabs.org ([203.11.71.1]:50291 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728062AbfBNASs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 19:18:48 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 440H782ftLz9sMx;
        Thu, 14 Feb 2019 11:18:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550103524;
        bh=Oq+XGoOSMEPR2Wha6c1N2zuzgF1mUR+P6BvnGVYrQ5M=;
        h=Date:From:To:Cc:Subject:From;
        b=D2pYjEVakZc1SD5xk+4OP47E9arbyI+WtBmyG9i2WthHi+v4sz01MVWKL4gPMiK6R
         MJ3LBRd76maIZQe0tuBeRvG4jegDtq45UadWCqUA7DPWEO8Ewu5fKpRDq/nv7kC4e2
         201t/DRJ+E2ycrV3uFyyfuPC2j7liRNxRwWgiU3H4XiNCDviHcIn4qBmEN60PqGvhJ
         aTB5uxoTttBt+LP1WbfREPanXofB8ISXF3H83LoEi1pNXBignrdBCsRswATHEa+5p2
         7qhQC+/H8Ne/mDLW5ELoCEfBEUt45pH0cKk2JP7B7fOAkuRQj4wTOgasenOPWVxiI2
         YpBWXzhnmL2rw==
Date:   Thu, 14 Feb 2019 11:18:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kaike Wan <kaike.wan@intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: linux-next: build warning after merge of the rdma tree
Message-ID: <20190214111839.6300f9b7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Z6z9P2TDF6nR6NmJ0Ch481J"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Z6z9P2TDF6nR6NmJ0Ch481J
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rdma tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/infiniband/hw/hfi1/qp.c: In function 'hfi1_setup_wqe':
drivers/infiniband/hw/hfi1/qp.c:328:3: warning: this statement may fall thr=
ough [-Wimplicit-fallthrough=3D]
   hfi1_setup_tid_rdma_wqe(qp, wqe);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/infiniband/hw/hfi1/qp.c:329:2: note: here
  case IB_QPT_UC:
  ^~~~

Introduced by commit

  f1ab4efa6d32 ("IB/hfi1: Enable TID RDMA READ protocol")

I get this warning because I am building with -Wimplicit-fallthrough
in attempt to catch new additions early.  The gcc warning can be turned
off by adding a /* fall through */ comment at the point the fall through
happens (assuming that the fall through is intentional).

--=20
Cheers,
Stephen Rothwell

--Sig_/Z6z9P2TDF6nR6NmJ0Ch481J
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxks98ACgkQAVBC80lX
0GzLsAgApDA+uARjRgKYMgJAdCyAOCw48OWijHGbacKOgpFQ2s3ro9B7Z7+XJuL6
Dr6AJ1FHQa73NXsSj/wPOCaf0tG+MyRzcrSeamWPp6VR9WURkYkNZH6vz69eK5I7
3Qh3EUf7UmEJufUR43g8aSQMa7451WdsBEdeyWZk6Uan+X7d2cyi22NDqRDqjZva
KAmO507k4E0FtuVhLNpbzaf/F7bWbqQHSon7OcSpKrwCbtSWfHmXdKWHkXWljrd6
keHHZZlsvlENiHeWIzgGGev2e5tgUTjk94kAm/ZJZ7+7sudb/ImB2d0z9r28HZ+s
lK3uDOHvfc/lOPf5rRls2R24Ya2FHQ==
=k1OV
-----END PGP SIGNATURE-----

--Sig_/Z6z9P2TDF6nR6NmJ0Ch481J--
