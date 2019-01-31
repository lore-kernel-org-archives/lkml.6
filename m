Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1F9C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 23:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D0220881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 23:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DfpukCug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfAaXWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 18:22:39 -0500
Received: from ozlabs.org ([203.11.71.1]:38231 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbfAaXWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 18:22:38 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43rGVM0v8Lz9sDr;
        Fri,  1 Feb 2019 10:22:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548976956;
        bh=MtZD8H8KmEALLNTc0PuIGqabdmhcbaiG3cbft7ZYLQY=;
        h=Date:From:To:Cc:Subject:From;
        b=DfpukCug9p3RRLIxhyF0pAn5p8X452+EwdujHkJ3x4arM2O7vUbrJ8vDuS02IHKdj
         sga9TN9zMFp+jY8hVSkt5GoOOdF2KZpPVvImvBpFwHeFrIUnJ6gSanfqnTwRDxfiJ+
         44iB92l3IOYtdOBNasuPWwvviSG5Wtm9PAwUktUzNYjhSMhfqY24wwXbYQWYgV/qAG
         +Hf3kEfgBlkQccpq2tWVDqfGzmBEc/ndMDydfjdD/16uNm/mk+eN/Wv5ZkAhLLoEw6
         /DY+hHxlL0jJHOxIQuRUKSLR73Or7Ekprz7LMmjr3/oLzciUE/k2yyc9agBPAl3bW+
         W4lVA4esx1pJA==
Date:   Fri, 1 Feb 2019 10:22:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: linux-next: manual merge of the v4l-dvb tree with Linus' tree
Message-ID: <20190201102233.4643f528@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/26swWJgYn+uksKv0J51/Eiz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/26swWJgYn+uksKv0J51/Eiz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the v4l-dvb tree got a conflict in:

  drivers/media/platform/vim2m.c

between commit:

  240809ef6630 ("media: vim2m: only cancel work if it is for right context")

from Linus' tree and commit:

  b3e64e5b0778 ("media: vim2m: use per-file handler work queue")

from the v4l-dvb tree.

I fixed it up (I think - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/media/platform/vim2m.c
index 89d9c4c21037,e31c14c7d37f..000000000000
--- a/drivers/media/platform/vim2m.c
+++ b/drivers/media/platform/vim2m.c
@@@ -806,10 -904,7 +904,9 @@@ static void vim2m_stop_streaming(struc
  	struct vb2_v4l2_buffer *vbuf;
  	unsigned long flags;
 =20
 -	cancel_delayed_work_sync(&ctx->work_run);
 +	if (v4l2_m2m_get_curr_priv(dev->m2m_dev) =3D=3D ctx)
- 		cancel_delayed_work_sync(&dev->work_run);
++		cancel_delayed_work_sync(&ctx->work_run);
 +
  	for (;;) {
  		if (V4L2_TYPE_IS_OUTPUT(q->type))
  			vbuf =3D v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);

--Sig_/26swWJgYn+uksKv0J51/Eiz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxTgzkACgkQAVBC80lX
0GxrXgf/bYy+tP6gR1hfCseyvh/pQrv8gVEX+0hvoWzsq+YbnEpVXgVp/IIwNaBk
owtR78baI15GSGx5F0pccgiLXigjOVpiKcGckccHRkOrpP9yfM0v1bQ/28A33hPg
9auU0n5lX7mCDhjB7co1Bnzdsainxoko+auGxYPHM4iYiafvCczdBMPqDXkGa1mc
+w1azwmVXqcq5d7eS7+4GsO49kNvtKMHIFVPwT4H19AI8MSgb2QpaDeo0VppdTkr
Q2LHLxHBxkd1ihQjC/JwgvY+yDUncGs61rVLv2wR7NO0+FKpZQ7v29g/GbkdlnlO
ZizLndNJ6c1V5pwi2rpQW+jEP9Ky+g==
=8Ocf
-----END PGP SIGNATURE-----

--Sig_/26swWJgYn+uksKv0J51/Eiz--
