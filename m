Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB630C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE772147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pvg0OAkq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfBTGoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 01:44:15 -0500
Received: from ozlabs.org ([203.11.71.1]:56451 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfBTGoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 01:44:14 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4447P46Bjtz9s71;
        Wed, 20 Feb 2019 17:44:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550645051;
        bh=uHPdZHcpyvkz6p4H6WndNmTY0y02BuAfJIeLjWUeTBY=;
        h=Date:From:To:Cc:Subject:From;
        b=pvg0OAkqNJ+KHXf/mCj+6FcvOBZ/dfO8T82yhz0grDKOZEwCXz1mmOILaljOmWSOf
         sEfO87lVT9Ee/bQ60zHtdLpbu77+ZO+dMQZBKbbHAkkuWw/ilt0DK8FpzYgdSxH2EY
         lZSsfwJrz0YMNEZJzb68YvPcHFc233CwGymZnwGRbC2L2gmiaF4L7JdcJMEzH/9mdJ
         6i5Vl7N8uUxCIt5EbVS79xo57VC0BWDUeced8PTcfUANq93Kkv/TqP0fqDrUpsVMne
         LAUp3Uk++d7VmVDikXjjIedbBYeYaJE91gMY2zuqrOAfTlUdDkAZgzNBy6Y1YvOCxT
         +ZGqt/sus9V7g==
Date:   Wed, 20 Feb 2019 17:44:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20190220174407.753d94e5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/+dJg47_x3aIGx0KWjrEpAKc"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+dJg47_x3aIGx0KWjrEpAKc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/nouveau/nouveau_dmem.c:299:11: error: initialization of 'vm=
_fault_t (*)(struct hmm_devmem *, struct vm_area_struct *, long unsigned in=
t,  const struct page *, unsigned int,  pmd_t *)' {aka 'unsigned int (*)(st=
ruct hmm_devmem *, struct vm_area_struct *, long unsigned int,  const struc=
t page *, unsigned int,  struct <anonymous> *)'} from incompatible pointer =
type 'int (*)(struct hmm_devmem *, struct vm_area_struct *, long unsigned i=
nt,  const struct page *, unsigned int,  pmd_t *)' {aka 'int (*)(struct hmm=
_devmem *, struct vm_area_struct *, long unsigned int,  const struct page *=
, unsigned int,  struct <anonymous> *)'} [-Werror=3Dincompatible-pointer-ty=
pes]
  .fault =3D nouveau_dmem_fault,
           ^~~~~~~~~~~~~~~~~~
drivers/gpu/drm/nouveau/nouveau_dmem.c:299:11: note: (near initialization f=
or 'nouveau_dmem_devmem_ops.fault')

Caused by commit

  5be73b690875 ("drm/nouveau/dmem: device memory helpers for SVM")

from the drm tree interacting with commit

  ed814eb7f91d ("mm/hmm: convert to use vm_fault_t")

from the akpm-current tree.

I added this merge fix patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 20 Feb 2019 17:36:18 +1100
Subject: [PATCH] drm/nouveau/dmem: update for struct hmm_devmem_ops member
 change

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouve=
au/nouveau_dmem.c
index 8be7a83ced9b..e2539f64de60 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -261,7 +261,7 @@ static const struct migrate_vma_ops nouveau_dmem_fault_=
migrate_ops =3D {
 	.finalize_and_map	=3D nouveau_dmem_fault_finalize_and_map,
 };
=20
-static int
+static vm_fault_t
 nouveau_dmem_fault(struct hmm_devmem *devmem,
 		   struct vm_area_struct *vma,
 		   unsigned long addr,
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/+dJg47_x3aIGx0KWjrEpAKc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxs9zcACgkQAVBC80lX
0Gwadgf/VIgna3rMoT847apJKSCz10Qh+o1R+XypRCrd1PK8532r38hClmC/KVv+
dqNVQp8m0D+IGs2nHQPeKO/E50a2l6Dn0BjwRAA3XrorCc1kYOgH9mSDt4pQoMJP
HaEpfMMipuUpSuK5aEkFugiQedH9hI0mguLYbQE8z5ayPEIkugryqV1XJZS1+3wY
MO+8JtNK3NsC3Jm8R79eyrdSDDWscVugyzJakkHRq46dVc1lysEJhdAfdDMSqVvP
A6ITfrGUY2mQZbOr3MwlXKBpVgvc9p0jgmGaGcOZUoP5oe7s0IBlv4badkarFTHm
lSs70odR+xMLZoWoBQLu3+sUSJRwlQ==
=chSB
-----END PGP SIGNATURE-----

--Sig_/+dJg47_x3aIGx0KWjrEpAKc--
