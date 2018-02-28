Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeB1Gxs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 01:53:48 -0500
Received: from mail-pl0-f48.google.com ([209.85.160.48]:44030 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751717AbeB1Gxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 01:53:46 -0500
X-Google-Smtp-Source: AG47ELt473jgjkEdGpFNMxA5UbVdfMbRSAxliVgX2M5wBnoviwMpjUcrGmn5YF7M+dNXpD+U4Vpy+Q==
Date: Wed, 28 Feb 2018 16:53:31 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC REBASED 5/5] powerpc/mm/slice: use the dynamic high slice
 size to limit bitmap operations
Message-ID: <20180228165331.6e09959d@roar.ozlabs.ibm.com>
In-Reply-To: <878tbe7ggs.fsf@linux.vnet.ibm.com>
References: <02a62db83282b5ef3e0e8281fdc46fa91beffc86.1518382747.git.christophe.leroy@c-s.fr>
        <5badd882663833576c10b8aafe235fe1e443f119.1518382747.git.christophe.leroy@c-s.fr>
        <87bmga7qng.fsf@linux.vnet.ibm.com>
        <20180227191125.659d5cbe@roar.ozlabs.ibm.com>
        <878tbe7ggs.fsf@linux.vnet.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2018 18:11:07 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > On Tue, 27 Feb 2018 14:31:07 +0530
> > "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:
> >  
> >> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> >>   
> >> > The number of high slices a process might use now depends on its
> >> > address space size, and what allocation address it has requested.
> >> >
> >> > This patch uses that limit throughout call chains where possible,
> >> > rather than use the fixed SLICE_NUM_HIGH for bitmap operations.
> >> > This saves some cost for processes that don't use very large address
> >> > spaces.    
> >> 
> >> I haven't really looked at the final code. One of the issue we had was
> >> with the below scenario.
> >> 
> >> mmap(addr, len) where addr < 128TB and addr+len > 128TB  We want to make
> >> sure we build the mask such that we don't find the addr available.  
> >
> > We should run it through the mmap regression tests. I *think* we moved
> > all of that logic from the slice code to get_ummapped_area before going
> > in to slices. I may have missed something though, it would be good to
> > have more eyes on it.
> >  
> 
> mmap(-1,...) failed with the test. Something like below fix it
> 
> @@ -756,7 +770,7 @@ void slice_set_user_psize(struct mm_struct *mm, unsigned int psize)
>         mm->context.low_slices_psize = lpsizes;
>  
>         hpsizes = mm->context.high_slices_psize;
> -       high_slices = GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit);
> +       high_slices = SLICE_NUM_HIGH;
>         for (i = 0; i < high_slices; i++) {
>                 mask_index = i & 0x1;
>                 index = i >> 1;
> 
> I guess for everything in the mm_context_t, we should compute it till
> SLICE_NUM_HIGH. The reason for failure was, even though we recompute the
> slice mask cached in mm_context on slb_addr_limit, it was still derived
> from the high_slices_psizes which was computed with lower value.

Okay thanks for catching that Aneesh. I guess that's a slow path so it
should be okay. Christophe if you're taking care of the series can you
fold it in? Otherwise I'll do that after yours gets merged.

Thanks,
Nick
