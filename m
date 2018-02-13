Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934906AbeBMLc0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 06:32:26 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39656 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933926AbeBMLcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 06:32:23 -0500
X-Google-Smtp-Source: AH8x224/Dn7O/N7GRzRM3UmRbWCTCMAKB0gGPXORhqthiCe7tNbTOKrF1QFwSaF9/zsRgXtWwzL6QA==
Date: Tue, 13 Feb 2018 12:32:19 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Andrei Vagin <avagin@virtuozzo.com>,
        tip-bot for Jacob Shin <tipbot@zytor.com>,
        kirill.shutemov@linux.intel.com, linux-tip-commits@vger.kernel.org,
        tglx@linutronix.de, willy@infradead.org, gorcunov@openvz.org,
        bp@suse.de, peterz@infradead.org, torvalds@linux-foundation.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, luto@amacapital.net
Subject: Re: [tip:x86/boot] x86/boot/compressed/64: Handle 5-level paging
 boot if kernel is above 4G
Message-ID: <20180213113219.rn5xdilh7j3qvfme@gmail.com>
References: <tip-b4b56015ed1c98cbc9469e35ebbc4373a2844030@git.kernel.org>
 <20180213065155.GA14087@outlook.office365.com>
 <20180213080816.vwh64jiz23frjiot@node.shutemov.name>
 <20180213084121.GA19906@outlook.office365.com>
 <20180213090249.vnjwitt657jabnlt@node.shutemov.name>
 <20180213094355.jodz6cuh3n3brfmc@gmail.com>
 <20180213100005.53exytg5sqlk7kh4@node.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213100005.53exytg5sqlk7kh4@node.shutemov.name>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Kirill A. Shutemov <kirill@shutemov.name> wrote:

> On Tue, Feb 13, 2018 at 10:43:56AM +0100, Ingo Molnar wrote:
> > 
> > * Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > 
> > > On Tue, Feb 13, 2018 at 12:41:22AM -0800, Andrei Vagin wrote:
> > > > On Tue, Feb 13, 2018 at 11:08:16AM +0300, Kirill A. Shutemov wrote:
> > > > > On Mon, Feb 12, 2018 at 10:51:56PM -0800, Andrei Vagin wrote:
> > > > > > Hi Kirill,
> > > > > > 
> > > > > > Something is wrong in this patch.
> > > 
> > > Could you please check if this makes a difference?
> > > 
> > > diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> > > index 70b30f2bc9e0..99a0e7993252 100644
> > > --- a/arch/x86/boot/compressed/head_64.S
> > > +++ b/arch/x86/boot/compressed/head_64.S
> > > @@ -332,7 +332,7 @@ ENTRY(startup_64)
> > >  
> > >  	/* Make sure we have GDT with 32-bit code segment */
> > >  	leaq	gdt(%rip), %rax
> > > -	movl	%eax, gdt64+2(%rip)
> > > +	movq	%rax, gdt64+2(%rip)
> > >  	lgdt	gdt64(%rip)
> > 
> > There's another suspicious looking pattern as well:
> > 
> >         leaq    startup_32(%rip), %rax
> >         movl    %eax, BP_code32_start(%rsi)
> > ...
> >         movl    BP_code32_start(%esi), %eax
> >         leaq    startup_64(%rax), %rax
> > ...
> 
> code32_start is 4-byte field as described in the boot protocol, so the
> truncation is intentional I think.

Ok - and I guess the fact that the field includes '32' is documentation enough 
that this is expected.

Thanks,

	Ingo
