Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E21BC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 05:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0200218A1
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 05:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cucTOfTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbfBFFPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 00:15:05 -0500
Received: from ozlabs.org ([203.11.71.1]:56399 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726051AbfBFFPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 00:15:05 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43vV4j5drFz9s7T;
        Wed,  6 Feb 2019 16:15:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549430102;
        bh=sT6CGGFNUassOQ8W1pWaYiYVspapVLQpqbmCFLs2nMA=;
        h=Date:From:To:Cc:Subject:From;
        b=cucTOfTpHngCoUSYuHxyN+cqOlpVQ1EcZ1ErmpcfnUK0RMJXgPzVTQJqXP04Tz2LE
         e+sL4aXphcrpgYZ9iG56ookT5KgW+YpYkoy8LgAw73dsFm8HmEgUXuQ4MsbkN/eFAC
         mKJ7S1vuSJCwL/gtN68SQZUu7Qxp8NEdBDVFOAzGY9WN3b7KGpseTzKv5iii7GFWrk
         kCCF4umRWyLiI6v1IJcljEuxErPA/wKM9QnKv+mS0QhjV/cjpJcBqTa7FPEqm/jB7O
         sfqgUcvg8ETPa5t6749MKQtyzEvgnfeayfw/8K/hc+6KoPvCMg35/LuM7VqA/Igceb
         BmtgfSigtr40g==
Date:   Wed, 6 Feb 2019 16:15:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: linux-next: manual merge of the akpm-current tree with the
 powerpc-fixes tree
Message-ID: <20190206161501.070912bd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ocMURUR.zSRJHN=EfOUsA1T"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ocMURUR.zSRJHN=EfOUsA1T
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  arch/powerpc/mm/pgtable-book3s64.c

between commit:

  579b9239c1f3 ("powerpc/radix: Fix kernel crash with mremap()")

from the powerpc-fixes tree and commit:

  41bde21e85a7 ("arch/powerpc/mm: Nest MMU workaround for mprotect RW upgra=
de")

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

diff --cc arch/powerpc/mm/pgtable-book3s64.c
index ecd31569a120,9f154efed1ae..c11c60056669
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@@ -401,24 -398,27 +398,49 @@@ void arch_report_meminfo(struct seq_fil
  }
  #endif /* CONFIG_PROC_FS */
 =20
 +/*
 + * For hash translation mode, we use the deposited table to store hash sl=
ot
 + * information and they are stored at PTRS_PER_PMD offset from related pmd
 + * location. Hence a pmd move requires deposit and withdraw.
 + *
 + * For radix translation with split pmd ptl, we store the deposited table=
 in the
 + * pmd page. Hence if we have different pmd page we need to withdraw duri=
ng pmd
 + * move.
 + *
 + * With hash we use deposited table always irrespective of anon or not.
 + * With radix we use deposited table only for anonymous mapping.
 + */
 +int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
 +			   struct spinlock *old_pmd_ptl,
 +			   struct vm_area_struct *vma)
 +{
 +	if (radix_enabled())
 +		return (new_pmd_ptl !=3D old_pmd_ptl) && vma_is_anonymous(vma);
 +
 +	return true;
 +}
++
+ pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long ad=
dr,
+ 			     pte_t *ptep)
+ {
+ 	unsigned long pte_val;
+=20
+ 	/*
+ 	 * Clear the _PAGE_PRESENT so that no hardware parallel update is
+ 	 * possible. Also keep the pte_present true so that we don't take
+ 	 * wrong fault.
+ 	 */
+ 	pte_val =3D pte_update(vma->vm_mm, addr, ptep, _PAGE_PRESENT, _PAGE_INVA=
LID, 0);
+=20
+ 	return __pte(pte_val);
+=20
+ }
+=20
+ void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long ad=
dr,
+ 			     pte_t *ptep, pte_t old_pte, pte_t pte)
+ {
+ 	if (radix_enabled())
+ 		return radix__ptep_modify_prot_commit(vma, addr,
+ 						      ptep, old_pte, pte);
+ 	set_pte_at(vma->vm_mm, addr, ptep, pte);
+ }

--Sig_/ocMURUR.zSRJHN=EfOUsA1T
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxabVUACgkQAVBC80lX
0Gz8QggAgtrN83vfPaENyHMWdrr/t6+xWtG20urPqQGGTj3WBAPd5a5OoUUa9a21
KPwB0+1kdwcFOmupAyCGRzz3+8Zw9jXGxZTSJqYajL1kM5tWoYTQMnSWOIonQDke
hsVNwclWCd+8D8vzGw8qWN5V1+M3M+OAsck5RiyPMlgicUaDQELQ6bwttKRb0b+x
2b/D1ZExPngCRkBnBzIcWsh4Br12QkTejlI0IJKGhSj5I7tBm6yWrqoS2/QU3y5Q
5qlWv9znvKTWZB0boG04nzvQc5SpwUou678XG3qtf8eydW8Wrzu2yfH9uJ+tEhuh
8Eux6sq1KODdt8k9JDjzh/QxHcCiSQ==
=ko55
-----END PGP SIGNATURE-----

--Sig_/ocMURUR.zSRJHN=EfOUsA1T--
