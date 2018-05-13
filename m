Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752013AbeEMUEB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 16:04:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:45525 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751664AbeEMUEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 16:04:00 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,397,1520924400";
   d="scan'208";a="41470117"
Date: Sun, 13 May 2018 23:03:56 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/boot/compressed/64: Set up GOT for
 paging_prepare() and cleanup_trampoline()
Message-ID: <20180513200356.2a4si345f76j2leb@black.fi.intel.com>
References: <20180510173806.4332-1-kirill.shutemov@linux.intel.com>
 <20180510173806.4332-2-kirill.shutemov@linux.intel.com>
 <alpine.DEB.2.21.1805132019490.1582@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1805132019490.1582@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2018 at 06:55:46PM +0000, Thomas Gleixner wrote:
> On Thu, 10 May 2018, Kirill A. Shutemov wrote:
> 
> > +	/*
> > +	 * paging_prepare() and cleanup_trampoline() below can have GOT
> > +	 * references. Adjust the table with address we are running at.
> > +	 */
> > +
> > +	/* The GOP was not adjusted before */
> 
> GOP == EFI speak for Graphics Output Protocol. What the heck? 

I was not aware about Graphics Output Protocol.
> 
> > +	xorq	%rax, %rax
> 
> And this clearing of RAX is related to this because? Sure you need it for
> adjust_got() but adding a comment to that is too much asked for, right?

Huh? The comment just above the line describes why it's needed.

> > +	/* Calculate the address the binary is loaded at. */
> > +	call	1f
> > +1:	popq	%rdi
> > +	subq	$1b, %rdi
> > +
> > +	call	adjust_gop
> > +
> >  	/*
> >  	 * At this point we are in long mode with 4-level paging enabled,
> >  	 * but we might want to enable 5-level paging or vice versa.
> > @@ -381,6 +396,24 @@ trampoline_return:
> >  	pushq	$0
> >  	popfq
> >  
> > +	/*
> > +	 * Previously we've adjusted the GOT with address the binary was
> > +	 * loaded at. Now we need to re-adjust for relocation address.
> > +	 */
> 
> Breaking up those comments makes it more readable, right?

Yes, I think so.

The first comment is for the whole block of code below. The second is the
comment for the first step.

> > +	/*
> > +	 * Calculate the address the binary is loaded at.
> > +	 * This address was used to adjust the table before and we need to
> > +	 * undo the change.
> > +	 */
> > +	call	1f
> > +1:	popq	%rax
> > +	subq	$1b, %rax
> > +
> > +	/* The new adjustment is relocation address */
> 
>   is the relocation address
> 
> > +	movq	%rbx, %rdi
> > +	call	adjust_gop
> > +
> >  /*
> >   * Copy the compressed kernel to the end of our buffer
> >   * where decompression in place becomes safe.
> > @@ -481,19 +514,6 @@ relocated:
> >  	shrq	$3, %rcx
> >  	rep	stosq
> >  
> > -/*
> > - * Adjust our own GOT
> > - */
> > -	leaq	_got(%rip), %rdx
> > -	leaq	_egot(%rip), %rcx
> > -1:
> > -	cmpq	%rcx, %rdx
> > -	jae	2f
> > -	addq	%rbx, (%rdx)
> > -	addq	$8, %rdx
> > -	jmp	1b
> > -2:
> > -	
> >  /*
> >   * Do the extraction, and jump to the new kernel..
> >   */
> > @@ -512,6 +532,26 @@ relocated:
> >   */
> >  	jmp	*%rax
> >  
> > +/*
> > + * Adjust global offest table
> 
> offest? 
> 
> > + *
> > + * RAX is previous adjustment of the table to undo (0 if it's the first time we touch GOP).
> 
>   is the previous
> 
> And there is no reason to make that line overly long.
> 
> > + * RDI is the new adjustment to apply.
> > + */
> > +adjust_gop:
> > +	/* Walk through the GOT adding the address to the entries */
> > +	leaq	_got(%rip), %rdx
> > +	leaq	_egot(%rip), %rcx
> > +1:
> > +	cmpq	%rcx, %rdx
> > +	jae	2f
> > +	subq	%rax, (%rdx)	/* Undo previous adjustment */
> > +	addq	%rdi, (%rdx)	/* Apply the new adjustment */
> > +	addq	$8, %rdx
> > +	jmp	1b
> > +2:
> > +	ret
> 
> I'm really tired of your carelessness. The amount of half baken stuff you
> submit is way above the tolerance level by now. I asked you several times
> to be more careful, but you simply do not care at all. Get your act
> together finally.

I don't think it's fair.

Yes, I have hard time write correctly, even in my native languages.
I'm blind to mistakes I do. I'm sorry about them.

But I do care about bugs in my code and I do my best addressing them.
It took a lot of effort to find root cause of the bug and your statement
about my carelessness doesn't match my assessment.

Have a nice day.

-- 
 Kirill A. Shutemov
