Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F67C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 22:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CE6206C2
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 22:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731062AbeLPWBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 17:01:31 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39366 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730920AbeLPWB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 17:01:28 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gYeTO-0002FR-Pc; Sun, 16 Dec 2018 22:01:18 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gYeTO-0007lf-IC; Sun, 16 Dec 2018 22:01:18 +0000
Message-ID: <c6c2fbc56023a7a4ce0956ebd79c3048b3a2991e.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 226/328] x86/mm: Use WRITE_ONCE() when setting PTEs
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Nadav Amit <namit@vmware.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Andy Lutomirski <luto@kernel.org>
Date:   Sun, 16 Dec 2018 22:01:08 +0000
In-Reply-To: <F12A5F9B-770F-4D1A-90B5-C1873F383B03@vmware.com>
References: <lsq.1544392233.685418412@decadent.org.uk>
         <F12A5F9B-770F-4D1A-90B5-C1873F383B03@vmware.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-+EeQUsXLsT4vxoxmNUgU"
User-Agent: Evolution 3.30.2-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+EeQUsXLsT4vxoxmNUgU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2018-12-09 at 21:57 +0000, Nadav Amit wrote:
> This patch causes some sparse warnings. If you want to wait, I=E2=80=99ll=
 send a
> patch to fix it. (No expected functional impact though).

Thanks for the note.  I don't think that's enough of a reason to delay
this fix.

Ben.

>=20
> > On Dec 9, 2018, at 1:50 PM, Ben Hutchings <ben@decadent.org.uk> wrote:
> >=20
> > 3.16.62-rc1 review patch.  If anyone has any objections, please let me =
know.
> >=20
> > ------------------
> >=20
> > From: Nadav Amit <namit@vmware.com>
> >=20
> > commit 9bc4f28af75a91aea0ae383f50b0a430c4509303 upstream.
> >=20
> > When page-table entries are set, the compiler might optimize their
> > assignment by using multiple instructions to set the PTE. This might
> > turn into a security hazard if the user somehow manages to use the
> > interim PTE. L1TF does not make our lives easier, making even an interi=
m
> > non-present PTE a security hazard.
> >=20
> > Using WRITE_ONCE() to set PTEs and friends should prevent this potentia=
l
> > security hazard.
> >=20
> > I skimmed the differences in the binary with and without this patch. Th=
e
> > differences are (obviously) greater when CONFIG_PARAVIRT=3Dn as more
> > code optimizations are possible. For better and worse, the impact on th=
e
> > binary with this patch is pretty small. Skimming the code did not cause
> > anything to jump out as a security hazard, but it seems that at least
> > move_soft_dirty_pte() caused set_pte_at() to use multiple writes.
> >=20
> > Signed-off-by: Nadav Amit <namit@vmware.com>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Link: https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%=
2Flkml.kernel.org%2Fr%2F20180902181451.80520-1-namit%40vmware.com&amp;data=
=3D02%7C01%7Cnamit%40vmware.com%7C714a85e56274491706a408d65e210edd%7Cb39138=
ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C636799893436192539&amp;sdata=3DQNA9jX%=
2FSAai7zpZeNn%2FosXL%2BrjkG2lYfDVVUN9Etm0A%3D&amp;reserved=3D0
> > [bwh: Backported to 3.16:
> > - Use ACCESS_ONCE() instead of WRITE_ONCE()
> > - Drop changes in pmdp_establish(), native_set_p4d(), pudp_set_access_f=
lags()]
> > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > ---
> > --- a/arch/x86/include/asm/pgtable_64.h
> > +++ b/arch/x86/include/asm/pgtable_64.h
> > @@ -44,15 +44,15 @@ struct mm_struct;
> > void set_pte_vaddr_pud(pud_t *pud_page, unsigned long vaddr, pte_t new_=
pte);
> >=20
> >=20
> > -static inline void native_pte_clear(struct mm_struct *mm, unsigned lon=
g addr,
> > -				    pte_t *ptep)
> > +static inline void native_set_pte(pte_t *ptep, pte_t pte)
> > {
> > -	*ptep =3D native_make_pte(0);
> > +	ACCESS_ONCE(*ptep) =3D pte;
> > }
> >=20
> > -static inline void native_set_pte(pte_t *ptep, pte_t pte)
> > +static inline void native_pte_clear(struct mm_struct *mm, unsigned lon=
g addr,
> > +				    pte_t *ptep)
> > {
> > -	*ptep =3D pte;
> > +	native_set_pte(ptep, native_make_pte(0));
> > }
> >=20
> > static inline void native_set_pte_atomic(pte_t *ptep, pte_t pte)
> > @@ -62,7 +62,7 @@ static inline void native_set_pte_atomic
> >=20
> > static inline void native_set_pmd(pmd_t *pmdp, pmd_t pmd)
> > {
> > -	*pmdp =3D pmd;
> > +	ACCESS_ONCE(*pmdp) =3D pmd;
> > }
> >=20
> > static inline void native_pmd_clear(pmd_t *pmd)
> > @@ -98,7 +98,7 @@ static inline pmd_t native_pmdp_get_and_
> >=20
> > static inline void native_set_pud(pud_t *pudp, pud_t pud)
> > {
> > -	*pudp =3D pud;
> > +	ACCESS_ONCE(*pudp) =3D pud;
> > }
> >=20
> > static inline void native_pud_clear(pud_t *pud)
> > @@ -131,7 +131,7 @@ static inline pgd_t *native_get_shadow_p
> >=20
> > static inline void native_set_pgd(pgd_t *pgdp, pgd_t pgd)
> > {
> > -	*pgdp =3D kaiser_set_shadow_pgd(pgdp, pgd);
> > +	ACCESS_ONCE(*pgdp) =3D kaiser_set_shadow_pgd(pgdp, pgd);
> > }
> >=20
> > static inline void native_pgd_clear(pgd_t *pgd)
> > --- a/arch/x86/mm/pgtable.c
> > +++ b/arch/x86/mm/pgtable.c
> > @@ -242,7 +242,7 @@ static void pgd_mop_up_pmds(struct mm_st
> > 		if (pgd_val(pgd) !=3D 0) {
> > 			pmd_t *pmd =3D (pmd_t *)pgd_page_vaddr(pgd);
> >=20
> > -			pgdp[i] =3D native_make_pgd(0);
> > +			pgd_clear(&pgdp[i]);
> >=20
> > 			paravirt_release_pmd(pgd_val(pgd) >> PAGE_SHIFT);
> > 			pmd_free(mm, pmd);
> > @@ -352,7 +352,7 @@ int ptep_set_access_flags(struct vm_area
> > 	int changed =3D !pte_same(*ptep, entry);
> >=20
> > 	if (changed && dirty) {
> > -		*ptep =3D entry;
> > +		set_pte(ptep, entry);
> > 		pte_update_defer(vma->vm_mm, address, ptep);
> > 	}
> >=20
> > @@ -369,7 +369,7 @@ int pmdp_set_access_flags(struct vm_area
> > 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
> >=20
> > 	if (changed && dirty) {
> > -		*pmdp =3D entry;
> > +		set_pmd(pmdp, entry);
> > 		pmd_update_defer(vma->vm_mm, address, pmdp);
> > 		/*
> > 		 * We had a write-protection fault here and changed the pmd
>=20
>=20
--=20
Ben Hutchings
If you seem to know what you are doing, you'll be given more to do.



--=-+EeQUsXLsT4vxoxmNUgU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlwWyyUACgkQ57/I7JWG
EQmHuQ/+OX143V0PmIMXD22DccxMT7UJAe1L2jJ0Dz7sffAKbpla0Rfg0Qma0ds3
35t41JPDRld4SYw8VUNUi8GC7pQUAY0QZrAwFHgYpyNiUBYFCiltrLkXitONbXC5
vwAx2hL9X6DhL9ZZXMgK6EhcIPlKettrKb/oasadX9a6UEQtWoiwIpct2cwC53WW
s21M6VBVePzMDyn/BlbgiOelwK9MSr03ARKikQVBCl+JHNGzD8gjO4Cem1ps/BI4
hGHazK/cw19ZGPgv8noZwjQCw2w/SrxCsVOaralNTTjl6R9RK5uM7Cj9HEZoBOVA
vmlpRLNa5zNV5dmZX9hkjz95YzTw0J4GgBzsc57h4zONPfO0EC8Ze5UMBhfVZLkh
RIR0VNhfvpJax9SLhnY4k1wvkdCgvDDI/bjuGgcdNJt7vTWY0TF3K7zMzGSHqch/
+5AV22RJOgFlLNlWnDXLePX41lQwihSqAVX+c88F3sN4m0Mx0rRwzlafg8E8LMTC
Q/pUKQsBSQ7O3ympKi3a9Mj3EugBSdwoajrrhFqlU4Mi3WxKxKSdCffShbdUnIHO
M1C3gL4efXVJQz542eoQbPLGJiuKVjJ58ANXU9edh7qpXXSPJbmeLnTs9uF2Kf9w
HBjyJ19FEnilBrKqTk+3ptrCEXwizajix2ROtD6/048e7rZNfBI=
=GPIW
-----END PGP SIGNATURE-----

--=-+EeQUsXLsT4vxoxmNUgU--
