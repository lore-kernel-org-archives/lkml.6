Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABAEC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 00:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4543020666
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 00:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="CHbl2++B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4543020666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbeH3ENU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 00:13:20 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:58686 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725758AbeH3ENU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 00:13:20 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id DDD5410C07AD;
        Wed, 29 Aug 2018 17:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1535588036; bh=/HYEhSbHhBk/NLnEB8N+EEsWUSYhfwCCR2cFAVKmPSc=;
        h=From:To:CC:Subject:Date:References:From;
        b=CHbl2++BhISeQ/8qGIfGy1YwcnS5NihHoeqnDnHUQmFiD/tDpzy7WjHQiSZw+dl5V
         ozOYNCiigZna9Q5lSXWZ4XRW7WJDMkP5VYJsTdfvhI4nw9+YLwSDwjM3TsFEwoUlez
         lawwBG9NkIKYKoQaKXd0HOR5TW0KeMa7bTmJtC0pa2PRmsK8RxqwSc/RKhuI8ewsCv
         oQfZ+FPfRtyFRGf6etm6kNuMh0UrVsjPvHvR26IYgFIowjC4/6JQUyHy357pkCn2T5
         z0muqyozPgsy+w58avrdwWnJtroDpx3DDPDKaX2FDffKXViJUTCNfNrKU+xUwl9+X+
         mhvN3m3JpZdcA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id D9F5551BE;
        Wed, 29 Aug 2018 17:13:51 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Wed, 29
 Aug 2018 17:13:51 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>
CC:     Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>,
        Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        Jann Horn <jannh@google.com>,
        Adin Scannell <ascannell@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "jejb@parisc-linux.org" <jejb@parisc-linux.org>
Subject: Re: [PATCH 3/4] mm/tlb, x86/mm: Support invalidating TLB caches for
 RCU_TABLE_FREE
Thread-Topic: [PATCH 3/4] mm/tlb, x86/mm: Support invalidating TLB caches
 for RCU_TABLE_FREE
Thread-Index: AQHUPfVFMOyepXHyn0ucFio/hxYEkA==
Date:   Thu, 30 Aug 2018 00:13:50 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B090CA3@us01wembx1.internal.synopsys.com>
References: <20180823134525.5f12b0d3@roar.ozlabs.ibm.com>
 <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com>
 <776104d4c8e4fc680004d69e3a4c2594b638b6d1.camel@au1.ibm.com>
 <CA+55aFzM77G9-Q6LboPLJ=5gHma66ZQKiMGCMqXoKABirdF98w@mail.gmail.com>
 <20180823133958.GA1496@brain-police>
 <20180824084717.GK24124@hirez.programming.kicks-ass.net>
 <20180824113214.GK24142@hirez.programming.kicks-ass.net>
 <20180824113953.GL24142@hirez.programming.kicks-ass.net>
 <20180827150008.13bce08f@roar.ozlabs.ibm.com>
 <20180827074701.GW24124@hirez.programming.kicks-ass.net>
 <20180827110017.GO24142@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.104]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/27/2018 04:00 AM, Peter Zijlstra wrote:=0A=
>=0A=
> The one obvious thing SH and ARM want is a sensible default for=0A=
> tlb_start_vma(). (also: https://lkml.org/lkml/2004/1/15/6 )=0A=
>=0A=
> The below make tlb_start_vma() default to flush_cache_range(), which=0A=
> should be right and sufficient. The only exceptions that I found where=0A=
> (oddly):=0A=
>=0A=
>   - m68k-mmu=0A=
>   - sparc64=0A=
>   - unicore=0A=
>=0A=
> Those architectures appear to have a non-NOP flush_cache_range(), but=0A=
> their current tlb_start_vma() does not call it.=0A=
=0A=
So indeed we follow the DaveM's insight from 2004 about tlb_{start,end}_vma=
() and=0A=
those are No-ops for ARC for the general case. For the historic VIPT aliasi=
ng=0A=
dcache they are what they should be per 2004 link above - I presume that is=
 all=0A=
hunky dory with you ?=0A=
=0A=
> Furthermore, I think tlb_flush() is broken on arc and parisc; in=0A=
> particular they don't appear to have any TLB invalidate for the=0A=
> shift_arg_pages() case, where we do not call tlb_*_vma() and fullmm=3D0.=
=0A=
=0A=
Care to explain this issue a bit more ?=0A=
And that is independent of the current discussion.=0A=
=0A=
> Possibly shift_arg_pages() should be fixed instead.=0A=
>=0A=
> Some archs (nds32,sparc32) avoid this by having an unconditional=0A=
> flush_tlb_mm() in tlb_flush(), which seems somewhat suboptimal if you=0A=
> have flush_tlb_range().  TLB_FLUSH_VMA() might be an option, however=0A=
> hideous it is.=0A=
>=0A=
> ---=0A=
>=0A=
> diff --git a/arch/arc/include/asm/tlb.h b/arch/arc/include/asm/tlb.h=0A=
> index a9db5f62aaf3..7af2b373ebe7 100644=0A=
> --- a/arch/arc/include/asm/tlb.h=0A=
> +++ b/arch/arc/include/asm/tlb.h=0A=
> @@ -23,15 +23,6 @@ do {						\=0A=
>   *=0A=
>   * Note, read http://lkml.org/lkml/2004/1/15/6=0A=
>   */=0A=
> -#ifndef CONFIG_ARC_CACHE_VIPT_ALIASING=0A=
> -#define tlb_start_vma(tlb, vma)=0A=
> -#else=0A=
> -#define tlb_start_vma(tlb, vma)						\=0A=
> -do {									\=0A=
> -	if (!tlb->fullmm)						\=0A=
> -		flush_cache_range(vma, vma->vm_start, vma->vm_end);	\=0A=
> -} while(0)=0A=
> -#endif=0A=
>  =0A=
>  #define tlb_end_vma(tlb, vma)						\=0A=
>  do {									\=0A=
=0A=
[snip..]=0A=
=0A=
> 				      \=0A=
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h=0A=
> index e811ef7b8350..1d037fd5bb7a 100644=0A=
> --- a/include/asm-generic/tlb.h=0A=
> +++ b/include/asm-generic/tlb.h=0A=
> @@ -181,19 +181,21 @@ static inline void tlb_remove_check_page_size_chang=
e(struct mmu_gather *tlb,=0A=
>   * the vmas are adjusted to only cover the region to be torn down.=0A=
>   */=0A=
>  #ifndef tlb_start_vma=0A=
> -#define tlb_start_vma(tlb, vma) do { } while (0)=0A=
> +#define tlb_start_vma(tlb, vma)						\=0A=
> +do {									\=0A=
> +	if (!tlb->fullmm)						\=0A=
> +		flush_cache_range(vma, vma->vm_start, vma->vm_end);	\=0A=
> +} while (0)=0A=
>  #endif=0A=
=0A=
So for non aliasing arches to be not affected, this relies on flush_cache_r=
ange()=0A=
to be no-op ?=0A=
=0A=
> -#define __tlb_end_vma(tlb, vma)					\=0A=
> -	do {							\=0A=
> -		if (!tlb->fullmm && tlb->end) {			\=0A=
> -			tlb_flush(tlb);				\=0A=
> -			__tlb_reset_range(tlb);			\=0A=
> -		}						\=0A=
> -	} while (0)=0A=
> -=0A=
>  #ifndef tlb_end_vma=0A=
> -#define tlb_end_vma	__tlb_end_vma=0A=
> +#define tlb_end_vma(tlb, vma)						\=0A=
> +	do {								\=0A=
> +		if (!tlb->fullmm && tlb->end) {				\=0A=
> +			tlb_flush(tlb);					\=0A=
> +			__tlb_reset_range(tlb);				\=0A=
> +		}							\=0A=
> +	} while (0)=0A=
>  #endif=0A=
>  =0A=
>  #ifndef __tlb_remove_tlb_entry=0A=
=0A=
And this one is for shift_arg_pages() but will also cause extraneous flushe=
s for=0A=
other cases - not happening currently !=0A=
=0A=
-Vineet=0A=
=0A=
