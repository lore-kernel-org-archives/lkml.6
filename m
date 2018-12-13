Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6730C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729C220849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qS6l732h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 729C220849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbeLMGBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 01:01:11 -0500
Received: from ozlabs.org ([203.11.71.1]:44415 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbeLMGBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 01:01:11 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43FjjJ16fMz9s47;
        Thu, 13 Dec 2018 17:01:08 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544680868;
        bh=/LV3Vd447jsiiFI5k4rsHMG+ZOEAbR4YTKF8CrtGfsw=;
        h=Date:From:To:Cc:Subject:From;
        b=qS6l732h8vKt7ije+2KC/+K2qdPAyAmwS31UoRAEawgPAJtPxzJ5LrLW/ui0gTWPF
         LJ6EexmH8hc+M77tvtnCwe72paKSV6pCSYQDo+ho876opoXTNGcWsiTH5TI/Y3cB56
         l482NNjxkP5RjowfbSd5IFV9d2POmMMrAZUuEjrBqQOgfIwGVXOoGrCNZSGwIXVxzu
         U/OghkGR6+9kn8jXdA1jgYte/xuf5KzVSa0zXqrzusa92drJDPjvIzbwq2Y0WR8nG1
         I5CQucD6fKX9vvrhXutOHJ7G68JeeArU7oQhmW+TDdrorIxz+2BMsT5ynKVnac38Gs
         WOyX6gt+3pAhA==
Date:   Thu, 13 Dec 2018 17:01:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: linux-next: manual merge of the akpm-current tree with the arm64
 tree
Message-ID: <20181213170107.38bd04d6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/s/dZJ6VtEHUosbgwXC4YBD8"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/s/dZJ6VtEHUosbgwXC4YBD8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  arch/arm64/mm/mmu.c

between commit:

  4ab215061554 ("arm64: Add memory hotplug support")

from the arm64 tree and commit:

  232619fcc076 ("lib/ioremap: ensure break-before-make is used for huge p4d=
 mappings")

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

diff --cc arch/arm64/mm/mmu.c
index da513a1facf4,cf9a26d3d7f5..000000000000
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@@ -1047,19 -1029,7 +1043,24 @@@ int pud_free_pmd_page(pud_t *pudp, unsi
  	return 1;
  }
 =20
 +#ifdef CONFIG_MEMORY_HOTPLUG
 +int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *alt=
map,
 +		    bool want_memblock)
 +{
 +	int flags =3D 0;
 +
 +	if (rodata_full || debug_pagealloc_enabled())
 +		flags =3D NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 +
 +	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
 +			     size, PAGE_KERNEL, pgd_pgtable_alloc, flags);
 +
 +	return __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT,
 +			   altmap, want_memblock);
 +}
 +#endif
++
+ int p4d_free_pud_page(p4d_t *p4d, unsigned long addr)
+ {
+ 	return 0;	/* Don't attempt a block mapping */
+ }

--Sig_/s/dZJ6VtEHUosbgwXC4YBD8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwR9aMACgkQAVBC80lX
0GzuUAgApOa/2d+NaygMl3ECyhQEDiOyxvZeByd6ZfA3RZaAzzxPl+HJzAZn+yRB
oJmCFfJe5igNQzkXUf0KYueV+e0B3JLEfMF5/B9sPKzq7ddlsgIaRWcdvsw6f83D
xnk8Kh8cOqiNxlzRccEEZUZX80bXyTmgKB8NAIJApF7iXCtg3v9V8Bt75ZyFaDtX
6FloQD+eQJp3el89yfOuJABRo/yekomit/LOUBXLJmWuEHa5vFrns+5jFNyMp4vi
9PwtGOH6CXXBFtkwvxcugCKCO/JQy0H2esFX4WOioTp+qCcGXK2jxXKhPgxHMe6Y
aRSjFFIby5cE9uE6rbe5JKLFwceMbg==
=4wCQ
-----END PGP SIGNATURE-----

--Sig_/s/dZJ6VtEHUosbgwXC4YBD8--
