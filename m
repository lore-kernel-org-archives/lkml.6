Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C92C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 03:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95AA7208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 03:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbfBRDRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 22:17:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45924 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728052AbfBRDRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 22:17:34 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 76F69C03DFE1;
        Mon, 18 Feb 2019 03:17:33 +0000 (UTC)
Received: from localhost (ovpn-12-45.pek2.redhat.com [10.72.12.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 792491024965;
        Mon, 18 Feb 2019 03:17:32 +0000 (UTC)
Date:   Mon, 18 Feb 2019 11:17:29 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Mike Travis <travis@sgi.com>,
        Thomas Garnier <thgarnie@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v3 1/6] x86/mm/KASLR: Improve code comments about struct
 kaslr_memory_region
Message-ID: <20190218031729.GG14858@MiWiFi-R3L-srv>
References: <20190216140008.28671-1-bhe@redhat.com>
 <20190216140008.28671-2-bhe@redhat.com>
 <CAGXu5j+MUrt70E6YiwM0QWOQxQeU9+rY7UPvuDrASne1pkCZLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+MUrt70E6YiwM0QWOQxQeU9+rY7UPvuDrASne1pkCZLA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 18 Feb 2019 03:17:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/17/19 at 09:07am, Kees Cook wrote:
> > diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> > index 3f452ffed7e9..d7c6e4e8e48e 100644
> > --- a/arch/x86/mm/kaslr.c
> > +++ b/arch/x86/mm/kaslr.c
> > @@ -42,10 +42,59 @@
> >  static const unsigned long vaddr_end = CPU_ENTRY_AREA_BASE;
> >
> >  /*
> > - * Memory regions randomized by KASLR (except modules that use a separate logic
> > - * earlier during boot). The list is ordered based on virtual addresses. This
> > - * order is kept after randomization.
> > + * 'struct kasl_memory_region' entries represent continuous chunks of
> 
> Typo: struct kaslr_memory_region

Will change.

Thanks for reviewing this patchset and great suggestions.

> 
> Also, while you're rewriting this, how about putting it in full
> kern-doc format? (You're already using the "@field" style...) I think
> you just need the "/**" header...

Sure, will update.

> 
> /**
>  * struct name.... - short description...
> 
> > + * kernel virtual memory regions, to be randomized by KASLR.
> > + *
> > + * ( The exception is the module space virtual memory window which
> > + *   uses separate logic earlier during bootup. )
> > + *
> > + * Currently there are three such regions: the physical memory mapping,
> > + * vmalloc and vmemmap regions.
> > + *
> > + * The array below has the entries ordered based on virtual addresses.
> > + * The order is kept after randomization, i.e. the randomized
> > + * virtual addresses of these regions are still ascending.
> > + *
> > + * Here are the fields:
> > + *
> > + * @base: points to a global variable used by the MM to get the
> > + * virtual base address of any of the above regions. This allows the
> > + * early KASLR code to modify these base addresses early during bootup,
> > + * on a per bootup basis, without the MM code even being aware of whether
> > + * it got changed and to what value.
> > + *
> > + * When KASLR is active then the MM code makes sure that for each region
> > + * there's such a single, dynamic, global base address 'unsigned long'
> > + * variable available for the KASLR code to point to and modify directly:
> > + *
> > + *     { &page_offset_base, 0 },
> > + *     { &vmalloc_base,     0 },
> > + *     { &vmemmap_base,     1 },
> > + *
> > + * @size_tb: size in TB of each memory region. Thereinto, the size of
> 
> nit: "Thereinto" is odd. I'd say "Therefore".

Will replace it with 'Therefore'.

> 
> > + * the physical memory mapping region is variable, calculated according
> > + * to the actual size of system RAM in order to save more space for
> > + * randomization. The rest are fixed values related to paging mode.
> > + *
> > + * @size_tb: is the size of each memory region after randomization, and
> > + * its unit is TB.
> 
> Redundant lines?

I added it on purpose to stress these regions and their sizes, can
remove this line. Or edit it like:


* @size_tb: is the size of each memory region after randomization, and
* its unit is TB:
*     Physical memory mapping: (actual RAM size + 10 TB padding)
*     Vmalloc: 32 TB
*     Vmemmap: 1 TB

> 
> > + *
> > + * Physical memory mapping: (actual RAM size + 10 TB padding)
> > + * Vmalloc: 32 TB
> > + * Vmemmap: 1 TB
> > + *
> > + * When randomize the layout, their order are kept, still the physical
> > + * memory mapping region is handled fistly, next vmalloc and vmemmap.
> 
> typo: "first"

Will change.

> 
> > + * E.g the physical memory region, we limit the starting address to be
> > + * taken from the 1st 1/3 part of the whole available virtual address
> > + * space which is from 0xffff880000000000 to 0xfffffe0000000000, namely
> > + * the original starting address of the physical memory mapping region
> > + * to the starting address of cpu_entry_area mapping region. Once a random
> > + * address is chosen for the physical memory mapping, we jump over the
> > + * region and add 1G to begin the next region handling with the remaining
> > + * available space.
> 
> Should the "operation" comments (rather than the struct field
> comments) be moved to the start of the kernel_randomize_memory()
> function instead?

This paragraph is used to describe the order in which regions are
handled, incidentally give an example to detail it. Since struct
kasl_memory_region is the core and only data KASLR handled, put it here.

> 
> -Kees
> 
> >   */
> > +
> >  static __initdata struct kaslr_memory_region {
> >         unsigned long *base;
> >         unsigned long size_tb;
> > --
> > 2.17.2
> >
> 
> 
> -- 
> Kees Cook
