Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752138AbeBZIDJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 03:03:09 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38432 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbeBZIDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 03:03:06 -0500
X-Google-Smtp-Source: AH8x226PJ8E4eOf7Njw2MtxM1LUNQ+pSxCupUGfJxaS/piocGl4+CfmEWSSATgcat2twCVJJGwovlA==
Date: Mon, 26 Feb 2018 11:02:56 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>
Cc: tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, willy@infradead.org, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, peterz@infradead.org,
        gorcunov@openvz.org, luto@amacapital.net,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/boot] x86/boot/compressed/64: Prepare trampoline memory
Message-ID: <20180226080256.j7jzuxyokx42uytd@node.shutemov.name>
References: <20180209142228.21231-4-kirill.shutemov@linux.intel.com>
 <tip-b91993a87aff6dafd60a9c8ce80ebc425161a815@git.kernel.org>
 <20180224214818.GD29374@pd.tnic>
 <20180225105205.xicklkl3n5azdw2j@node.shutemov.name>
 <20180226073552.xabt55ukp24inut5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226073552.xabt55ukp24inut5@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 08:35:52AM +0100, Ingo Molnar wrote:
> 
> * Kirill A. Shutemov <kirill@shutemov.name> wrote:
> 
> > +#if 0
> >  	/*
> >  	 * Find a suitable spot for the trampoline.
> >  	 * This code is based on reserve_bios_regions().
> > @@ -49,6 +50,9 @@ struct paging_config paging_prepare(void)
> >  	/* Place the trampoline just below the end of low memory, aligned to 4k */
> >  	paging_config.trampoline_start = bios_start - TRAMPOLINE_32BIT_SIZE;
> >  	paging_config.trampoline_start = round_down(paging_config.trampoline_start, PAGE_SIZE);
> > +#else
> > +	paging_config.trampoline_start = 0x99000;
> > +#endif
> 
> So if it's suspected to be 'Video BIOS undeclared RAM use' related then wouldn't a 
> lower address be safer?

I tried to check if putting it into place where realtime trampoline
usually lands helps the situation. Apparently, not.

> Such as:
> 
> 	paging_config.trampoline_start = 0x40000;
> 
> or so?

Yeah, good idea.

Borislav, could you check this?

> Also, could do a puts() hexdump of the affected memory area _before_ we overwrite 
> it? Is it empty? Could we add some debug warning that checks that it's all zeroes?

The problem is that we don't really have a way get a message out of there.

http://lkml.kernel.org/r/793b9c55-e85b-97b5-c857-dd8edcda4081@zytor.com

> I also kind of regret that this remained a single commit:
> 
>  3 files changed, 120 insertions(+), 1 deletion(-)
> 
> this should be split up further:
> 
>  - one patch that adds trampoline space to the kernel image
>  - one patch that calculates the trampoline address and prints the address
>  - one or two patch that does the functional changes
>  - (any more split-up you can think of - early boot code is very fragile!)

Okay, I'll look into it.

But without a way to print address it's still a black box.

> It will be painful to rebase x86/mm but I think it's unavoidable at this stage.
> 
> There's also a few other things I don't like in paging_prepare():
> 
> 1)
> 
>         /* Check if LA57 is desired and supported */
>         if (IS_ENABLED(CONFIG_X86_5LEVEL) && native_cpuid_eax(0) >= 7 &&
>                         (native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31))))
>                 paging_config.l5_required = 1;
> 
> ... it isn't explained why this feature CPU check is so complex.

We check that the CPUID leaf is supported and than check the feature
itself.

Maybe the first check is redundant, but I tried to be safe here.

> 2)
> 
> +       /* Place the trampoline just below the end of low memory, aligned to 4k */
> +       paging_config.trampoline_start = bios_start - TRAMPOLINE_32BIT_SIZE;
> +       paging_config.trampoline_start = round_down(paging_config.trampoline_start, PAGE_SIZE);
> 
> placing trampolines just below or just above BIOS images is fragile. Instead a 
> better heuristic is to use the "middle" of suspected available RAM and work from 
> there.

It's not obvious what is lower end of available memory here. Any hints?

Realtime trampoline is allocated with top-down approach and I tried to
mimic the approach here.

> 3)
> 
> +       /* Clear trampoline memory first */
> +       memset(trampoline, 0, TRAMPOLINE_32BIT_SIZE);
> 
> Memory bootup state is typically all zeroes (except maybe for kexec), so this 
> should check that what it's clearing doesn't contain any data.

Hm. I don't see why would we expect this. Do we really have guarantee that
bootloader would not mess with the memory?

> It should probably also clear this memory _after_ use.

After use I tired to restore the original content of the memory.
See cleanup_trampoline(). That looks safer to me.

> 4)
> 
> +       /*
> +        * Set up a new page table that will be used for switching from 4-
> +        * to 5-level paging or vice versa. In other cases trampoline
> +        * wouldn't touch CR3.
> +        *
> +        * For 4- to 5-level paging transition, set up current CR3 as the
> +        * first and the only entry in a new top-level page table.
> +        *
> +        * For 5- to 4-level paging transition, copy page table pointed by
> +        * first entry in the current top-level page table as our new
> +        * top-level page table. We just cannot point to the page table
> +        * from trampoline as it may be above 4G.
> +        */
> +       if (paging_config.l5_required) {
> +               trampoline[TRAMPOLINE_32BIT_PGTABLE_OFFSET] = __native_read_cr3() + _PAGE_TABLE_NOENC;
> +       } else if (native_read_cr4() & X86_CR4_LA57) {
> +               unsigned long src;
> +
> +               src = *(unsigned long *)__native_read_cr3() & PAGE_MASK;
> +               memcpy(trampoline + TRAMPOLINE_32BIT_PGTABLE_OFFSET / sizeof(unsigned long),
> +                      (void *)src, PAGE_SIZE);
> +       }
> 
> Why '+ _PAGE_TABLE_NOENC', while not ' |' ?

It shouldn't really matter, but yeah, '|' is more appropriate.

> Also, it isn't clear what is where at this stage and it would be helpful to add 
> comments explaining the general purpose.
> 
> There's also two main objects here:
> 
>  - the mode switching code trampoline
>  - the trampoline pagetable
> 
> it's not clear from this code where is which - and the naming isn't overly clear 
> either: is '*trampoline' the code, or the pagetable, or both?

Okay, I'll do my best explaining this.

> We need to re-do this as we have now run into _exactly_ the kind of difficult to 
> debug bug that I was worried about when I insisted on the many iterations of this 
> patch-set...
> 
> Thanks,
> 
> 	Ingo

-- 
 Kirill A. Shutemov
