Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbeBZIrL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 03:47:11 -0500
Received: from mail-wr0-f176.google.com ([209.85.128.176]:39253 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752079AbeBZIrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 03:47:04 -0500
X-Google-Smtp-Source: AG47ELt5VgKA1EeThgzCEclLQUBuHIVM39yCi3sOpdiTyzj0p4FV8u4ldKpWG9QNu2g8TNk5CKVrwA==
Date: Mon, 26 Feb 2018 09:47:00 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Borislav Petkov <bp@suse.de>, tglx@linutronix.de,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, hpa@zytor.com, kirill.shutemov@linux.intel.com,
        peterz@infradead.org, gorcunov@openvz.org, luto@amacapital.net,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/boot] x86/boot/compressed/64: Prepare trampoline memory
Message-ID: <20180226084700.vpjavqk6e4xfyapa@gmail.com>
References: <20180209142228.21231-4-kirill.shutemov@linux.intel.com>
 <tip-b91993a87aff6dafd60a9c8ce80ebc425161a815@git.kernel.org>
 <20180224214818.GD29374@pd.tnic>
 <20180225105205.xicklkl3n5azdw2j@node.shutemov.name>
 <20180226073552.xabt55ukp24inut5@gmail.com>
 <20180226080256.j7jzuxyokx42uytd@node.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226080256.j7jzuxyokx42uytd@node.shutemov.name>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Kirill A. Shutemov <kirill@shutemov.name> wrote:

> > Also, could do a puts() hexdump of the affected memory area _before_ we overwrite 
> > it? Is it empty? Could we add some debug warning that checks that it's all zeroes?
> 
> The problem is that we don't really have a way get a message out of there.

Is there any memory area we can write to that survives into the real kernel?

> But without a way to print address it's still a black box.

> > 1)
> > 
> >         /* Check if LA57 is desired and supported */
> >         if (IS_ENABLED(CONFIG_X86_5LEVEL) && native_cpuid_eax(0) >= 7 &&
> >                         (native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31))))
> >                 paging_config.l5_required = 1;
> > 
> > ... it isn't explained why this feature CPU check is so complex.
> 
> We check that the CPUID leaf is supported and than check the feature
> itself.
> 
> Maybe the first check is redundant, but I tried to be safe here.

So the explanation that is missing is to explain which usual primitive this is 
equivalent to. This is essentially an early boot variant of 
boot_cpu_has(X86_FEATURE_LA57), right?

> > 2)
> > 
> > +       /* Place the trampoline just below the end of low memory, aligned to 4k */
> > +       paging_config.trampoline_start = bios_start - TRAMPOLINE_32BIT_SIZE;
> > +       paging_config.trampoline_start = round_down(paging_config.trampoline_start, PAGE_SIZE);
> > 
> > placing trampolines just below or just above BIOS images is fragile. Instead a 
> > better heuristic is to use the "middle" of suspected available RAM and work from 
> > there.
> 
> It's not obvious what is lower end of available memory here. Any hints?
> 
> Realtime trampoline is allocated with top-down approach and I tried to
> mimic the approach here.

Yeah, it's all a bit weird - I'm grasping at straws really - and the large size of 
the patch doesn't help.

> > +       /* Clear trampoline memory first */
> > +       memset(trampoline, 0, TRAMPOLINE_32BIT_SIZE);
> > 
> > Memory bootup state is typically all zeroes (except maybe for kexec), so this 
> > should check that what it's clearing doesn't contain any data.
> 
> Hm. I don't see why would we expect this. Do we really have guarantee that
> bootloader would not mess with the memory?

Hm, probably not - what's the typical memory usage of GRUB for example?

> > It should probably also clear this memory _after_ use.
> 
> After use I tired to restore the original content of the memory.
> See cleanup_trampoline(). That looks safer to me.

Yeah, agreed.

BTW., it's still a possibility that we are barking up the wrong tree here: if the 
bug Boris triggered is somehow not fully deterministic (but say kernel build 
alignment dependent - which alignment your commit changed) then this might be the 
wrong commit. A split-up into several patches would help there too: for example if 
the new data structures in the kernel image trigger the bug (with nothing else in 
that commit) then it strongly suggests that it's alignment related, etc.

But it certainly 'feels' to have a chance to be related: stomping on the wrong 
piece of memory can make graphics fail.

> > Why '+ _PAGE_TABLE_NOENC', while not ' |' ?
> 
> It shouldn't really matter, but yeah, '|' is more appropriate.

Readability and using standard patterns is king.

Thanks,

	Ingo
