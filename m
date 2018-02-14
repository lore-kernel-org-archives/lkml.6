Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161553AbeBNRzx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:55:53 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33553 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161300AbeBNRzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:55:52 -0500
X-Google-Smtp-Source: AH8x226uWsPjYOmcpGpt4gpjIbjouGfWIrMx+ALwEsouGZB8/g+HmCpOO2iRukkk0lZ9+4JlzdCpkA==
Date: Wed, 14 Feb 2018 20:55:48 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Andy Lutomirski <luto@amacapital.net>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>, Andi Kleen <ak@linux.intel.com>,
        Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/9] x86/mm: Make __VIRTUAL_MASK_SHIFT dynamic
Message-ID: <20180214175548.6uxpm3bspmgqi7hs@node.shutemov.name>
References: <20180214111656.88514-1-kirill.shutemov@linux.intel.com>
 <20180214111656.88514-9-kirill.shutemov@linux.intel.com>
 <CALCETrVafx9kZwsJrihUxKszio9rJCPZJHnWSh3QC992o=zxnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVafx9kZwsJrihUxKszio9rJCPZJHnWSh3QC992o=zxnA@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 05:22:58PM +0000, Andy Lutomirski wrote:
> On Wed, Feb 14, 2018 at 11:16 AM, Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> > For boot-time switching between paging modes, we need to be able to
> > adjust virtual mask shifts.
> >
> > The change doesn't affect the kernel image size much:
> >
> >    text    data     bss     dec     hex filename
> > 8628892 4734340 1368064 14731296         e0c820 vmlinux.before
> > 8628966 4734340 1368064 14731370         e0c86a vmlinux.after
> >
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/entry/entry_64.S            | 12 ++++++++++++
> >  arch/x86/include/asm/page_64_types.h |  2 +-
> >  arch/x86/mm/dump_pagetables.c        | 12 ++++++++++--
> >  arch/x86/mm/kaslr.c                  |  4 +++-
> >  4 files changed, 26 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> > index cd216c9431e1..1608b13a0b36 100644
> > --- a/arch/x86/entry/entry_64.S
> > +++ b/arch/x86/entry/entry_64.S
> > @@ -260,8 +260,20 @@ GLOBAL(entry_SYSCALL_64_after_hwframe)
> >          * Change top bits to match most significant bit (47th or 56th bit
> >          * depending on paging mode) in the address.
> >          */
> > +#ifdef CONFIG_X86_5LEVEL
> > +       testl   $1, pgtable_l5_enabled(%rip)
> > +       jz      1f
> > +       shl     $(64 - 57), %rcx
> > +       sar     $(64 - 57), %rcx
> > +       jmp     2f
> > +1:
> > +       shl     $(64 - 48), %rcx
> > +       sar     $(64 - 48), %rcx
> > +2:
> > +#else
> >         shl     $(64 - (__VIRTUAL_MASK_SHIFT+1)), %rcx
> >         sar     $(64 - (__VIRTUAL_MASK_SHIFT+1)), %rcx
> > +#endif
> 
> Eww.
> 
> Can't this be ALTERNATIVE "shl ... sar ...", "shl ... sar ...",
> X86_FEATURE_5LEVEL or similar?

Optimization comes in a separate patch:

https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git/commit/?h=la57/boot-switching/wip&id=015fa3576a7f2b8bd271096bb3a12b06cdc845af

-- 
 Kirill A. Shutemov
