Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B55C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7E120866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jW42cD8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbfAPCs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 21:48:29 -0500
Received: from ozlabs.org ([203.11.71.1]:37805 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728619AbfAPCs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 21:48:28 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43fWqF1lhZz9s3l;
        Wed, 16 Jan 2019 13:48:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547606905;
        bh=5tt3/ff4SHg1PgysdMdzH3SZwKVUaF3+vkfr4y/rLVU=;
        h=Date:From:To:Cc:Subject:From;
        b=jW42cD8HxgGrVf2CZzXL0uvqRQpcRQHt1CV4CjHDqu3/1uXTda500+VJgtWV0+eDy
         tRlhpDqh+vZmXOePZbJbhmRQHQcRvitZntG4dTY9qCVPejyqk8r4JrK/Db6Co3DkU4
         C1QTa+TXa4KKI9cLtb+NvkuXxq1VKgoYfPV+GZ207SkIq6PLXAnU1UgmWCocctaysh
         GXThpf9GexD1ObWZ+lOMekpp9TeDCUsK0UO/FXpOnRzY1s5RkvY6g08SPDeQ9xXPox
         huKzCQ7SROrooyGh6JShVoW7ilupyzPVdzwBuIjmOj9b24N2Z/fC7qmZV8oOMYAMR4
         Pji21YE65GM+w==
Date:   Wed, 16 Jan 2019 13:48:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Omar Sandoval <osandov@fb.com>
Subject: linux-next: build failure after merge of the block tree
Message-ID: <20190116134824.74c2d7da@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2Jb9UHR.9gaR=CVdBX_Jlm4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2Jb9UHR.9gaR=CVdBX_Jlm4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (x86_64
allmodconfig) failed like this:

fs/gfs2/lops.c: In function 'gfs2_end_log_read':
fs/gfs2/lops.c:394:39: error: macro "bio_for_each_segment_all" requires 4 a=
rguments, but only 3 given
  bio_for_each_segment_all(bvec, bio, i) {
                                       ^
fs/gfs2/lops.c:394:2: error: 'bio_for_each_segment_all' undeclared (first u=
se in this function); did you mean 'bio_first_page_all'?
  bio_for_each_segment_all(bvec, bio, i) {
  ^~~~~~~~~~~~~~~~~~~~~~~~
  bio_first_page_all
fs/gfs2/lops.c:394:2: note: each undeclared identifier is reported only onc=
e for each function it appears in
fs/gfs2/lops.c:394:26: error: expected ';' before '{' token
  bio_for_each_segment_all(bvec, bio, i) {
                          ^              ~
                          ;

Caused by commit

  eb754eb2a953 ("block: allow bio_for_each_segment_all() to iterate over mu=
lti-page bvec")

One instance of bio_for_each_segment_all() was missed.

I have applied the following fix patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 16 Jan 2019 13:44:02 +1100
Subject: [PATCH] block: fix up for bio_for_each_segment_all() API change

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/gfs2/lops.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index ef68bf6232e7..15deefeaafd0 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -390,8 +390,9 @@ static void gfs2_end_log_read(struct bio *bio)
 	struct page *page;
 	struct bio_vec *bvec;
 	int i;
+	struct bvec_iter_all iter_all;
=20
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_segment_all(bvec, bio, i, iter_all) {
 		page =3D bvec->bv_page;
 		if (bio->bi_status) {
 			int err =3D blk_status_to_errno(bio->bi_status);
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/2Jb9UHR.9gaR=CVdBX_Jlm4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw+m3gACgkQAVBC80lX
0GwoHQf+P6tzwemxAKhgg71igIacjJmsdrVXibDJl934znQDD/Pp5u+7pOYTgREk
4JEJXNX4/1E26k9dNBGE3CV0wUF2sLAsyvQ2PQ8BGO4deIUBUuieBAwtzOMISfsh
cn+MZPvmwBVCehVoWNyooNHsZ2OHMOzjyjx1UMs1FNtYTXKzbRuoH7JzeN9JCpjz
AsRoYsmBFjNxYTOFQFKgQs/rCcNOPNR8nNgNNIrDQbT82Mx2qHcJkX1+WZhgrzri
QAnCpnr2N9fwfSQmq7RORKkgLUTF35l4bdnF/ARhY8Z6CtONhaN6W7daGsejGzXu
JDgdvLChYR4btxvpVfm+6to4W+2Cbg==
=8hO2
-----END PGP SIGNATURE-----

--Sig_/2Jb9UHR.9gaR=CVdBX_Jlm4--
