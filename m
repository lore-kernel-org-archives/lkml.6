Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70507ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2622420875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Xg349x8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2622420875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388007AbeGWJBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 05:01:12 -0400
Received: from ozlabs.org ([203.11.71.1]:39559 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728176AbeGWJBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 05:01:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Yv7r2wCYz9s2M;
        Mon, 23 Jul 2018 18:01:12 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532332873;
        bh=4nhv2413zMUzF1vIMhnvLmwkoOqQps8o9GMieynZxHI=;
        h=Date:From:To:Cc:Subject:From;
        b=Xg349x8q/qyKUoryyEiXyfixVfhHl2DNAv4yreNuSqgrI+7L65Mrn9jUAxxCk0iKC
         K5zGu3buBH920k3Rpg8G24PM6z9zAP/HVD1SDEOWVwgy6XS1ZqZ5b16w9YAUpe+ROj
         LQHGrAdQNdwcP+MqGQbircEvLcjvwXeb4G0MgTTUDpbKa1kctcT2Mcxc0j4Ux6uAFb
         mmaF8/8MhwGhdldS8O0aBJ9EWH2SCjwIZMFBMVXUVlEjs4N62Zr2zjf/AbKzpz//mA
         hxMuYK7UuFpDkkmXPCrxFTElve2r3ktvewngXuMk6z51g+yZDCwhTPM10t1FDzTf6k
         ZNyM5KylEwUGw==
Date:   Mon, 23 Jul 2018 18:00:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: linux-next: manual merge of the akpm-current tree with Linus' tree
Message-ID: <20180723180051.7f896f99@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ilYYoLw1=/Ai8=WqW9UGg2Q"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ilYYoLw1=/Ai8=WqW9UGg2Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  mm/mmap.c

between commit:

  490fc053865c ("mm: make vm_area_alloc() initialize core fields")

from Linus' tree and commit:

  97478b56e246 ("mm: Fix vma_is_anonymous() false-positives")

from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc mm/mmap.c
index ff1944d8d458,b9636fa18f3c..000000000000
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@@ -2983,6 -3001,9 +2994,7 @@@ static int do_brk_flags(unsigned long a
  		return -ENOMEM;
  	}
 =20
 -	INIT_LIST_HEAD(&vma->anon_vma_chain);
 -	vma->vm_mm =3D mm;
+ 	vma->vm_ops =3D &anon_vm_ops;
  	vma->vm_start =3D addr;
  	vma->vm_end =3D addr + len;
  	vma->vm_pgoff =3D pgoff;

--Sig_/ilYYoLw1=/Ai8=WqW9UGg2Q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltVizMACgkQAVBC80lX
0Gyndgf/StLaNhw9ZGki7TuDsFl/rvhTnZ5K7MUYun7GckFFu17obsG60jPZC3kS
86GM51WuPo+FunD7L4HrBwamLxPG+i3OC9BaYV2lJZwmCuVd5oBx+k6D56stX5+k
4GiHHX+Kh6mpotJc937mqwIDSktxA2ZvZ6CGGZ28SoygBNqcOWZIGHNZY6cyO6A5
BAM2enUrf40aA0SIsUldWttJezjuYhbllUMeapEJ90gzhm0GOx0P5QiMvY0SDvCm
roxUtRDwUt8BEOWxVk+7T/Uxqj2tibLPIj935e/GF9sP4u4PgBGyEaj2BLRD0ZW8
kmyDSTlM/Wghz/Z2qcSf/elFI3PPaw==
=0ZbU
-----END PGP SIGNATURE-----

--Sig_/ilYYoLw1=/Ai8=WqW9UGg2Q--
