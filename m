Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072BFC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 05:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27B420875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 05:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GikMCPkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27B420875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbeJEMoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 08:44:32 -0400
Received: from ozlabs.org ([203.11.71.1]:58179 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbeJEMoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 08:44:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42RJgG0hCJz9s1c;
        Fri,  5 Oct 2018 15:47:21 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538718442;
        bh=K1kuzhafY7PeTK9LuiegoeDAhrkZqU3sZwWgPw/dUZo=;
        h=Date:From:To:Cc:Subject:From;
        b=GikMCPkmbdl/e3YZf3VPRI/duja0gWiS4A9tWwWcs3nJQbDD0phI70mq2Wp/2zt4N
         dBxgP5pSzIAl+hy2qgzjRqk4ITMqdGqFMQb+aJg0hPHCqG//82OHudd5rOEEQ4tCT/
         jASpxADdsKv9Wf/PGqmI1ufaUkeMyxG4q2kUYdkimL3zE3AcCWSA+FkjUaZlTPH8Qj
         su54Ih0SJLES0vAKrluqk2i49ZfN+56w/RRngREouEpo/FzvkKl742FkqsiZPhV038
         LQaEGAdmoEcQlIm20Td09DlI9/DF8DOj2V7juV7hk6YGFlpyGEl4tDyQ5Ca79OTAwc
         jJViCrp2ksRIw==
Date:   Fri, 5 Oct 2018 15:47:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Huang Ying <ying.huang@intel.com>
Subject: linux-next: manual merge of the akpm-current tree with the
 btrfs-kdave tree
Message-ID: <20181005154721.4bfde639@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9MuZ1CGvPDQ=JH1fxbzSw/i"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9MuZ1CGvPDQ=JH1fxbzSw/i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  include/linux/swap.h

between commit:

  0f83d16b8f1f ("mm: split SWP_FILE into SWP_ACTIVATED and SWP_FS")

from the btrfs-kdave tree and commit:

  26833300651e ("mm, swap: fix race between swapoff and some swap operation=
s")

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

diff --cc include/linux/swap.h
index 4fff094dbd53,f32f94639b13..000000000000
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@@ -167,14 -167,14 +167,15 @@@ enum=20
  	SWP_SOLIDSTATE	=3D (1 << 4),	/* blkdev seeks are cheap */
  	SWP_CONTINUED	=3D (1 << 5),	/* swap_map has count continuation */
  	SWP_BLKDEV	=3D (1 << 6),	/* its a block device */
 -	SWP_FILE	=3D (1 << 7),	/* set after swap_activate success */
 -	SWP_AREA_DISCARD =3D (1 << 8),	/* single-time swap area discards */
 -	SWP_PAGE_DISCARD =3D (1 << 9),	/* freed swap page-cluster discards */
 -	SWP_STABLE_WRITES =3D (1 << 10),	/* no overwrite PG_writeback pages */
 -	SWP_SYNCHRONOUS_IO =3D (1 << 11),	/* synchronous IO is efficient */
 -	SWP_VALID	=3D (1 << 12),	/* swap is valid to be operated on? */
 +	SWP_ACTIVATED	=3D (1 << 7),	/* set after swap_activate success */
 +	SWP_FS		=3D (1 << 8),	/* swap file goes through fs */
 +	SWP_AREA_DISCARD =3D (1 << 9),	/* single-time swap area discards */
 +	SWP_PAGE_DISCARD =3D (1 << 10),	/* freed swap page-cluster discards */
 +	SWP_STABLE_WRITES =3D (1 << 11),	/* no overwrite PG_writeback pages */
 +	SWP_SYNCHRONOUS_IO =3D (1 << 12),	/* synchronous IO is efficient */
++	SWP_VALID	=3D (1 << 13),	/* swap is valid to be operated on? */
  					/* add others here before... */
--	SWP_SCANNING	=3D (1 << 13),	/* refcount in scan_swap_map */
++	SWP_SCANNING	=3D (1 << 14),	/* refcount in scan_swap_map */
  };
 =20
  #define SWAP_CLUSTER_MAX 32UL
@@@ -297,15 -297,20 +298,15 @@@ struct vma_swap_readahead=20
 =20
  /* linux/mm/workingset.c */
  void *workingset_eviction(struct address_space *mapping, struct page *pag=
e);
- bool workingset_refault(void *shadow);
+ void workingset_refault(struct page *page, void *shadow);
  void workingset_activation(struct page *page);
 =20
 -/* Do not use directly, use workingset_lookup_update */
 -void workingset_update_node(struct radix_tree_node *node);
 -
 -/* Returns workingset_update_node() if the mapping has shadow entries. */
 -#define workingset_lookup_update(mapping)				\
 -({									\
 -	radix_tree_update_node_t __helper =3D workingset_update_node;	\
 -	if (dax_mapping(mapping) || shmem_mapping(mapping))		\
 -		__helper =3D NULL;					\
 -	__helper;							\
 -})
 +/* Only track the nodes of mappings with shadow entries */
 +void workingset_update_node(struct xa_node *node);
 +#define mapping_set_update(xas, mapping) do {				\
 +	if (!dax_mapping(mapping) && !shmem_mapping(mapping))		\
 +		xas_set_update(xas, workingset_update_node);		\
 +} while (0)
 =20
  /* linux/mm/page_alloc.c */
  extern unsigned long totalram_pages;

--Sig_/9MuZ1CGvPDQ=JH1fxbzSw/i
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu2+ukACgkQAVBC80lX
0Gy9SAf/TRcZunFAOZ6z1fjHrLXEvd2qhdJuSLN1RNhCIi3TpRRqbRLxpDZoT4X2
Ts1zm85ww2X0Eggz1S4PfsBLIau64FTL74HnHGUxvKU/PHo6PxlqWQmV+klgjdAV
oRzbe5zshUEWLNvOwmPCsjv2cU53GTmF68JA0PG8/4lJvVlU29pIfEoIdb8BHJBo
IY9QPxJHHvAg7rnfMSTMOkigHP8e20QkcQOEoBd2nj5Otp0w7kCtnRf6E4tjkN2k
xLgWhVv9fHx0DrK/FgRTcC6Nlhsa2RPuTPLhVxW3oRufPnZ9FpnSpFt9T96jvjQV
6pSvHktLBZpvojJQLH4AuxCmFVG8uA==
=SEmn
-----END PGP SIGNATURE-----

--Sig_/9MuZ1CGvPDQ=JH1fxbzSw/i--
