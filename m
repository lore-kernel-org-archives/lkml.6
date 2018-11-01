Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0771C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A776204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A776204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeKBHaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 03:30:46 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:46542 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbeKBHaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 03:30:46 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gILPQ-0004lV-Se; Thu, 01 Nov 2018 22:25:48 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gILPQ-0000WW-MY; Thu, 01 Nov 2018 22:25:48 +0000
Message-ID: <5d134c818828ddecf1ab9768b126c15c267c099e.camel@decadent.org.uk>
Subject: Re: [PATCH 4.9 23/35] x86/mm: Expand static page table for fixmap
 space
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Feng Tang <feng.tang@intel.com>,
        kernel test robot <rong.a.chen@intel.com>,
        H Peter Anvin <hpa@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Yinghai Lu <yinghai@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirsky <luto@kernel.org>
Date:   Thu, 01 Nov 2018 22:25:43 +0000
In-Reply-To: <20181011152521.098965859@linuxfoundation.org>
References: <20181011152520.174949126@linuxfoundation.org>
         <20181011152521.098965859@linuxfoundation.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-VzV2VgtRZdKJpHD5S+LT"
User-Agent: Evolution 3.30.1-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VzV2VgtRZdKJpHD5S+LT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-10-11 at 17:35 +0200, Greg Kroah-Hartman wrote:
> 4.9-stable review patch.  If anyone has any objections, please let me kno=
w.
>=20
> ------------------
>=20
> From: Feng Tang <feng.tang@intel.com>
>=20
> commit 05ab1d8a4b36ee912b7087c6da127439ed0a903e upstream.

This backport is incorrect.  The part that updated __startup_64() in
arch/x86/kernel/head64.c was dropped, presumably because that function
doesn't exist in 4.9.  However that seems to be an essential of the
fix.  In 4.9 the startup_64 routine in arch/x86/kernel/head_64.S would
need to be changed instead.

I also found that this introduces new boot-time warnings on some
systems if CONFIG_DEBUG_WX is enabled.

So, unless someone provides fixes for those issues, I think this should
be reverted for the 4.9 branch.

Ben.

> We met a kernel panic when enabling earlycon, which is due to the fixmap
> address of earlycon is not statically setup.
>=20
> Currently the static fixmap setup in head_64.S only covers 2M virtual
> address space, while it actually could be in 4M space with different
> kernel configurations, e.g. when VSYSCALL emulation is disabled.
>=20
> So increase the static space to 4M for now by defining FIXMAP_PMD_NUM to =
2,
> and add a build time check to ensure that the fixmap is covered by the
> initial static page tables.
>=20
> Fixes: 1ad83c858c7d ("x86_64,vsyscall: Make vsyscall emulation configurab=
le")
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: kernel test robot <rong.a.chen@intel.com>
> Reviewed-by: Juergen Gross <jgross@suse.com> (Xen parts)
> Cc: H Peter Anvin <hpa@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Yinghai Lu <yinghai@kernel.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Andy Lutomirsky <luto@kernel.org>
> Cc: stable@vger.kernel.org
> Link: https://lkml.kernel.org/r/20180920025828.23699-1-feng.tang@intel.co=
m
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/x86/include/asm/fixmap.h     |   10 ++++++++++
>  arch/x86/include/asm/pgtable_64.h |    3 ++-
>  arch/x86/kernel/head_64.S         |   16 ++++++++++++----
>  arch/x86/mm/pgtable.c             |    9 +++++++++
>  arch/x86/xen/mmu.c                |    8 ++++++--
>  5 files changed, 39 insertions(+), 7 deletions(-)
>=20
> --- a/arch/x86/include/asm/fixmap.h
> +++ b/arch/x86/include/asm/fixmap.h
> @@ -14,6 +14,16 @@
>  #ifndef _ASM_X86_FIXMAP_H
>  #define _ASM_X86_FIXMAP_H
> =20
> +/*
> + * Exposed to assembly code for setting up initial page tables. Cannot b=
e
> + * calculated in assembly code (fixmap entries are an enum), but is sani=
ty
> + * checked in the actual fixmap C code to make sure that the fixmap is
> + * covered fully.
> + */
> +#define FIXMAP_PMD_NUM	2
> +/* fixmap starts downwards from the 507th entry in level2_fixmap_pgt */
> +#define FIXMAP_PMD_TOP	507
> +
>  #ifndef __ASSEMBLY__
>  #include <linux/kernel.h>
>  #include <asm/acpi.h>
> --- a/arch/x86/include/asm/pgtable_64.h
> +++ b/arch/x86/include/asm/pgtable_64.h
> @@ -13,13 +13,14 @@
>  #include <asm/processor.h>
>  #include <linux/bitops.h>
>  #include <linux/threads.h>
> +#include <asm/fixmap.h>
> =20
>  extern pud_t level3_kernel_pgt[512];
>  extern pud_t level3_ident_pgt[512];
>  extern pmd_t level2_kernel_pgt[512];
>  extern pmd_t level2_fixmap_pgt[512];
>  extern pmd_t level2_ident_pgt[512];
> -extern pte_t level1_fixmap_pgt[512];
> +extern pte_t level1_fixmap_pgt[512 * FIXMAP_PMD_NUM];
>  extern pgd_t init_level4_pgt[];
> =20
>  #define swapper_pg_dir init_level4_pgt
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -23,6 +23,7 @@
>  #include "../entry/calling.h"
>  #include <asm/export.h>
>  #include <asm/nospec-branch.h>
> +#include <asm/fixmap.h>
> =20
>  #ifdef CONFIG_PARAVIRT
>  #include <asm/asm-offsets.h>
> @@ -493,13 +494,20 @@ NEXT_PAGE(level2_kernel_pgt)
>  		KERNEL_IMAGE_SIZE/PMD_SIZE)
> =20
>  NEXT_PAGE(level2_fixmap_pgt)
> -	.fill	506,8,0
> -	.quad	level1_fixmap_pgt - __START_KERNEL_map + _PAGE_TABLE
> -	/* 8MB reserved for vsyscalls + a 2MB hole =3D 4 + 1 entries */
> -	.fill	5,8,0
> +	.fill	(512 - 4 - FIXMAP_PMD_NUM),8,0
> +	pgtno =3D 0
> +	.rept (FIXMAP_PMD_NUM)
> +	.quad level1_fixmap_pgt + (pgtno << PAGE_SHIFT) - __START_KERNEL_map \
> +		+ _PAGE_TABLE;
> +	pgtno =3D pgtno + 1
> +	.endr
> +	/* 6 MB reserved space + a 2MB hole */
> +	.fill	4,8,0
> =20
>  NEXT_PAGE(level1_fixmap_pgt)
> +	.rept (FIXMAP_PMD_NUM)
>  	.fill	512,8,0
> +	.endr
> =20
>  #undef PMDS
> =20
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -536,6 +536,15 @@ void __native_set_fixmap(enum fixed_addr
>  {
>  	unsigned long address =3D __fix_to_virt(idx);
> =20
> +#ifdef CONFIG_X86_64
> +       /*
> +	* Ensure that the static initial page tables are covering the
> +	* fixmap completely.
> +	*/
> +	BUILD_BUG_ON(__end_of_permanent_fixed_addresses >
> +		     (FIXMAP_PMD_NUM * PTRS_PER_PTE));
> +#endif
> +
>  	if (idx >=3D __end_of_fixed_addresses) {
>  		BUG();
>  		return;
> --- a/arch/x86/xen/mmu.c
> +++ b/arch/x86/xen/mmu.c
> @@ -1936,7 +1936,7 @@ void __init xen_setup_kernel_pagetable(p
>  		 * L3_k[511] -> level2_fixmap_pgt */
>  		convert_pfn_mfn(level3_kernel_pgt);
> =20
> -		/* L3_k[511][506] -> level1_fixmap_pgt */
> +		/* L3_k[511][508-FIXMAP_PMD_NUM ... 507] -> level1_fixmap_pgt */
>  		convert_pfn_mfn(level2_fixmap_pgt);
>  	}
>  	/* We get [511][511] and have Xen's version of level2_kernel_pgt */
> @@ -1970,7 +1970,11 @@ void __init xen_setup_kernel_pagetable(p
>  		set_page_prot(level2_ident_pgt, PAGE_KERNEL_RO);
>  		set_page_prot(level2_kernel_pgt, PAGE_KERNEL_RO);
>  		set_page_prot(level2_fixmap_pgt, PAGE_KERNEL_RO);
> -		set_page_prot(level1_fixmap_pgt, PAGE_KERNEL_RO);
> +
> +		for (i =3D 0; i < FIXMAP_PMD_NUM; i++) {
> +			set_page_prot(level1_fixmap_pgt + i * PTRS_PER_PTE,
> +				      PAGE_KERNEL_RO);
> +		}
> =20
>  		/* Pin down new L4 */
>  		pin_pagetable_pfn(MMUEXT_PIN_L4_TABLE,
>=20
>=20
--=20
Ben Hutchings
Absolutum obsoletum. (If it works, it's out of date.) - Stafford Beer



--=-VzV2VgtRZdKJpHD5S+LT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlvbfWcACgkQ57/I7JWG
EQlG+hAAkrsRI4+rFHP/NGQHSnyJc3xBUdhb3YiAPTF7hJbMvcp4pJgfK5e3tUhB
Zpb6agg8uLX9VBE+plZhfDvv60fisSEmjoflCTBAUeIo1sZYdIycw3xbv9P1RXlX
pbjzeF8X76Jlg7zageHdpcTN1ULzqma5clN1A/AEoPy/V8yO5XNsZsYLYFAOwfUg
4+cM6qKQpZzpFPVgpFGilVhPudQQMIx9WR0hGscpLA5b8BdSWGetZwfLxMBe2+yU
a9jERnAhe3lOu6fwaaRWV57TeJGGvp7T+SU2QPq6zpRHrE+TFrsdScIOovm7CJgy
z3rzOv2qkP0Mz0DKgkiuD2BYrOFvEJSbNenFK1noirwt+X5sgOqWocM7CexLDBT+
UT1X+GdCskMGSRE3M4Vma4QWMznPwFXY7ZB6ak0s+VQr18QSmjdESRX13yuniKvf
nlezy60Fx/Q/iVAUKLNsYyxfBXvFI+tKrPuMQ1IxlrSxTmK0vNHptv5W3G5/7sR4
xf+km2ITKrXmxaRhNJctKdMe5PvXO4y07nT3+cYU2rIgBIhj8wPdfcQwrTjsv0B6
SKVbH15hnnqGio1CDQ75yuLJlfEv7BN+G+EzcPs09yMs/NAMz0ODNnDhDAQt7z8n
+dtqI8mUQnVACulSqaQeAjAudWY/pK/bEDMKr3z8prv8u+FNbHs=
=JTUY
-----END PGP SIGNATURE-----

--=-VzV2VgtRZdKJpHD5S+LT--
