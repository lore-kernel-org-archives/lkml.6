Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87CEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982302084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AD1DmDYB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbfAKCvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 21:51:04 -0500
Received: from ozlabs.org ([203.11.71.1]:39447 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728846AbfAKCvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 21:51:04 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43bS6Y2BFzz9sCs;
        Fri, 11 Jan 2019 13:51:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547175061;
        bh=ko1qcLOP9blKthv609PGrztw/vR3fIktJGVY9OWKNg4=;
        h=Date:From:To:Cc:Subject:From;
        b=AD1DmDYB7aGsksTQd5F9SYmOP8O0XGDq7pmpRVG7FdCiT/xQ9uUzOtlEIwhhK0cjt
         N6gWTZI8JFpW9uuBT6q+LfbhQQ1W54P1cdJNiEIXqpfH8AZXCCdnsJwySqW/c+cehq
         lImaI617GpS5raoNo8n4UY+4tbPw1QJDRPgbzkT42YqwKvSwdxvW1JosuJ7fTtAb9t
         VTvdmndMZgWxH9o3qqO5PsiVJhIal3CVuDkZmv/tbqEh8bibXvYjOyGEB9Anql+1+0
         w2fNM14Fn+kdYT0sH9I745IFpbgFkhdlYpNEXFVuRSzKo258v3vmM0bVnlj/cOLg/B
         xHwvPNZvfJRaw==
Date:   Fri, 11 Jan 2019 13:51:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>
Subject: linux-next: manual merge of the akpm-current tree with Linus' tree
Message-ID: <20190111135100.487a1896@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/37tx.=JDpnn5.I9hB2NQekn"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/37tx.=JDpnn5.I9hB2NQekn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  mm/rmap.c

between commit:

  ba422731316d ("mm/mmu_notifier: mm/rmap.c: Fix a mmu_notifier range bug i=
n try_to_unmap_one")

from Linus' tree and commit:

  f955d5dda846 ("mm/mmu_notifier: contextual information for event triggeri=
ng invalidation v2")

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

diff --cc mm/rmap.c
index 0454ecc29537,62e47f3462cf..000000000000
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@@ -1371,9 -1372,10 +1372,10 @@@ static bool try_to_unmap_one(struct pag
  	 * Note that the page can not be free in this function as call of
  	 * try_to_unmap() must hold a reference on the page.
  	 */
 -	mmu_notifier_range_init(&range, vma->vm_mm, vma->vm_start,
 -				min(vma->vm_end, vma->vm_start +
 +	mmu_notifier_range_init(&range, vma->vm_mm, address,
 +				min(vma->vm_end, address +
- 				    (PAGE_SIZE << compound_order(page))));
+ 				    (PAGE_SIZE << compound_order(page))),
+ 				MMU_NOTIFY_CLEAR);
  	if (PageHuge(page)) {
  		/*
  		 * If sharing is possible, start and end will be adjusted

--Sig_/37tx.=JDpnn5.I9hB2NQekn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw4BJQACgkQAVBC80lX
0GyPlgf/Yh8zBzAujNlUYDUeZ4bR7J1ZUTjd+Oyllguhq+Hb3ABbGXNvfc4EGY0W
aGVgPXLu7p4urRpYo6PITIQQY6YwUjNXWMWdNekXhmpr5i4UKWo+d4l/mSDfVuB+
yu2s47/XUml1oXvtMgasSTmL1svOVWYn+2m2L0jO05l78GYUGZ4UmW3O6d6l572f
ReGhuKHYthtaFEW4pX9gh55gDdTlt6qy76nVcDCWXHn0hn5a3HTC9JX9w5FogLM0
Sf3MVG4dLbGJ1TUDNpcntX6ojAHy4CI52/7PZFSIaOnIHwO66JISXk57pL7mEsV0
AaWfQuUca9sB2Z9qM0GwL+K2NjpiJg==
=yDvH
-----END PGP SIGNATURE-----

--Sig_/37tx.=JDpnn5.I9hB2NQekn--
