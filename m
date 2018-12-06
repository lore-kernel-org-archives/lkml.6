Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60064C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1B72146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="eobayvG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1B72146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbeLFHaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 02:30:10 -0500
Received: from ozlabs.org ([203.11.71.1]:56415 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728758AbeLFHaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 02:30:10 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 439S1B5GBgz9s47;
        Thu,  6 Dec 2018 18:30:06 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544081407;
        bh=euibUqfaRMDcZ6GXyQtDDxDOVsSnHai9F9dlX17U38E=;
        h=Date:From:To:Cc:Subject:From;
        b=eobayvG5aSGHWxpBjkP0uV4JxIQLokJjGkQJkRqXvopDZMqkTThWmsrfcX7Ak1rTb
         ATHmG6UMjzZ/8Hug+RY9tnzHGZQn4z3lATIAlbDO0DkbUz0iprgslIzSPfiWG4/T2N
         i4jfsWVqIYYZSYemh3b/5cJgCGaWO4asT6SKTe0njfjCByFV1wEHerhrL9njUVPDh0
         r79XAcEbEi0C01BVdhct3tYnifOMPMZuVefBouu8ypuSZFgW+Q1rP2MBE8bVtmvInJ
         tKBFx/jfJaJPtrre6z3jPRqn5FJ1BUnRhwg7wb+h2uqR4oUbnzyQhflC0MxDxLCO/M
         lsubYpBQ1IxSQ==
Date:   Thu, 6 Dec 2018 18:29:38 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Subject: linux-next: manual merge of the akpm-current tree with the
 btrfs-kdave tree
Message-ID: <20181206182938.3b153d04@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Iv7HK=v6yOLt0qJmRnJoNSC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Iv7HK=v6yOLt0qJmRnJoNSC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  fs/btrfs/extent_io.c

between commit:

  e42c38c80535 ("btrfs: Refactor main loop in extent_readpages")

from the btrfs-kdave tree and commit:

  "fs: don't open code lru_to_page()"

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

diff --cc fs/btrfs/extent_io.c
index 5104714212b4,3707c95a6598..000000000000
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@@ -4103,24 -4103,28 +4103,24 @@@ int extent_readpages(struct address_spa
  	int nr =3D 0;
  	u64 prev_em_start =3D (u64)-1;
 =20
 -	for (page_idx =3D 0; page_idx < nr_pages; page_idx++) {
 -		page =3D lru_to_page(pages);
 +	while (!list_empty(pages)) {
 +		for (nr =3D 0; nr < BTRFS_PAGES_BATCH && !list_empty(pages);) {
- 			struct page *page =3D list_entry(pages->prev, struct page, lru);
++			struct page *page =3D lru_to_page(pages);
 =20
 -		prefetchw(&page->flags);
 -		list_del(&page->lru);
 -		if (add_to_page_cache_lru(page, mapping,
 -					page->index,
 -					readahead_gfp_mask(mapping))) {
 -			put_page(page);
 -			continue;
 +			prefetchw(&page->flags);
 +			list_del(&page->lru);
 +			if (add_to_page_cache_lru(page, mapping, page->index,
 +						readahead_gfp_mask(mapping))) {
 +				put_page(page);
 +				continue;
 +			}
 +
 +			pagepool[nr++] =3D page;
  		}
 =20
 -		pagepool[nr++] =3D page;
 -		if (nr < ARRAY_SIZE(pagepool))
 -			continue;
  		__extent_readpages(tree, pagepool, nr, &em_cached, &bio,
 -				&bio_flags, &prev_em_start);
 -		nr =3D 0;
 +				   &bio_flags, &prev_em_start);
  	}
 -	if (nr)
 -		__extent_readpages(tree, pagepool, nr, &em_cached, &bio,
 -				&bio_flags, &prev_em_start);
 =20
  	if (em_cached)
  		free_extent_map(em_cached);

--Sig_/Iv7HK=v6yOLt0qJmRnJoNSC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwIz+IACgkQAVBC80lX
0GwhEQf8CcgSw40AqORCOSFn30nqJIiClLVz6z3OFB9XgB0+gCKFf6OJOT+jxRPB
tHBKV5/SuaKqYb4MRVtbrtPlnLqmMFwSGMWWqhKWVRHLOW/D/jAdJcpojF6AWkq+
Lfm7N2+rdYfFhcCU5LHaudjUIW2OE3O4magQcud5zDjQQOVqKMjH5q+uZMPVQxGu
wexMEL8WCUMzfo3aMfoD4go/pwL3NQx9MO2kE2SHzTIIgQLnL+TBAL3Ekpknc2ho
ME/gN760CHv/kZjVsmls2ZzgC5yZ4T2jpmCSKHH2m2NX+ULiw+IdDiYx1VgRPzkj
GZzdEw0GIQpXHeUFNm0GYFAurixtpg==
=yC2B
-----END PGP SIGNATURE-----

--Sig_/Iv7HK=v6yOLt0qJmRnJoNSC--
