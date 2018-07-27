Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778F6C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 01:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F134206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 01:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="telg9A80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F134206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732162AbeG0DJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 23:09:30 -0400
Received: from ozlabs.org ([203.11.71.1]:54609 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731974AbeG0DJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 23:09:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41cBjg6smJz9ryl;
        Fri, 27 Jul 2018 11:49:59 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532656200;
        bh=ZxPpT97Y4tyB9hll6Jb8v7MeloUTAC07KecTeLPArr8=;
        h=Date:From:To:Cc:Subject:From;
        b=telg9A80j+IJfn3Ul7+UPe1avGDOKIgLkhHG+5pTQY74DgYnzz7Die3QIVI6TDuso
         3YdSNiyDFoUX5RMrLlL4PyYHp0WS771ucKp8d6HgRqgp8ZNC/ocshhMGr+I1d2mMQj
         nWjlZ5VOVg3oMzfWLhsNH03mv8SAf0cNmrGnFzi1F5vvRoc0vcRqIqURnHxXqYWgLD
         Tr/pq7jmQE8TzysGukfzNuof6olDCYPpAW4Zp3pQKRREOQJ7guHCnW6DKFSr3d56Vl
         +FsgH4NM4SaqrCkNl3GjBtjI1TylwtaWcq62nt5Hs0bjSpsJLmA0pKu1aBJcIcEVML
         jZvbVymN3376Q==
Date:   Fri, 27 Jul 2018 11:49:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the v4l-dvb tree
Message-ID: <20180727114940.1d94a95c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/VzdAs7brUoe4RCdj6ne4fm="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VzdAs7brUoe4RCdj6ne4fm=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mauro,

After merging the v4l-dvb tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

fs/compat_ioctl.c: In function 'do_video_set_spu_palette':
fs/compat_ioctl.c:218:45: error: invalid application of 'sizeof' to incompl=
ete type 'struct video_spu_palette'
  up_native =3D compat_alloc_user_space(sizeof(struct video_spu_palette));
                                             ^~~~~~
In file included from include/linux/uaccess.h:14:0,
                 from include/linux/compat.h:19,
                 from fs/compat_ioctl.c:17:
fs/compat_ioctl.c:219:46: error: dereferencing pointer to incomplete type '=
struct video_spu_palette'
  err  =3D put_user(compat_ptr(palp), &up_native->palette);
                                              ^
At top level:
fs/compat_ioctl.c:206:12: warning: 'do_video_set_spu_palette' defined but n=
ot used [-Wunused-function]
 static int do_video_set_spu_palette(struct file *file,
            ^~~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  f863ce990030 ("media: dvb: get rid of VIDEO_SET_SPU_PALETTE")

grep is your friend ...

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/VzdAs7brUoe4RCdj6ne4fm=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltaejQACgkQAVBC80lX
0GzE4Af+LN+cxPfP4v6G6gk+Ck4WTB6Mso3ETOLxxZb6xX1Bvaw0OHEXTmj18dgm
9Mm+syh1Xu0xfeu/Ov9bZ9H43znJRfJA6pGlSpW7Eb+/cUR4D9aGz7pjCGTIX7Br
oL91OUjwjh7B+IXyXUTs2jNQyy5UfOx1KWwjD2KUffQmohI0SKUwaqXgLwA+PaUY
f+K/QTEzuzZDCUT9yHM/ZHt5pVG1f1Iz01S4Hhu86lM3Xrk//LStkQMQOZAhElwb
37Q0scrxOuFI7xc7n8WOMudjbZkD5EaQKYKuFZHTEJZcUU5DZAxg9gbVWFVpHPLa
nZEbqBR0qORigMPissxp1tzCY06Gdg==
=7JOE
-----END PGP SIGNATURE-----

--Sig_/VzdAs7brUoe4RCdj6ne4fm=--
