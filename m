Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeEMVaX (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 17:30:23 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51155 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751233AbeEMVaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 17:30:21 -0400
Date: Sun, 13 May 2018 23:30:11 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/boot/compressed/64: Set up GOT for paging_prepare()
 and cleanup_trampoline()
In-Reply-To: <20180513200356.2a4si345f76j2leb@black.fi.intel.com>
Message-ID: <alpine.DEB.2.21.1805132317380.1582@nanos.tec.linutronix.de>
References: <20180510173806.4332-1-kirill.shutemov@linux.intel.com> <20180510173806.4332-2-kirill.shutemov@linux.intel.com> <alpine.DEB.2.21.1805132019490.1582@nanos.tec.linutronix.de> <20180513200356.2a4si345f76j2leb@black.fi.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 May 2018, Kirill A. Shutemov wrote:
> On Sun, May 13, 2018 at 06:55:46PM +0000, Thomas Gleixner wrote:
> > On Thu, 10 May 2018, Kirill A. Shutemov wrote:
> > 
> > > +	/*
> > > +	 * paging_prepare() and cleanup_trampoline() below can have GOT
> > > +	 * references. Adjust the table with address we are running at.
> > > +	 */
> > > +
> > > +	/* The GOP was not adjusted before */
> > 
> > GOP == EFI speak for Graphics Output Protocol. What the heck? 
> 
> I was not aware about Graphics Output Protocol.

That does not matter. GOP what ever you think it is has nothing to do
here. This is about GOT or am I missing something? 

> > > +	xorq	%rax, %rax
> > 
> > And this clearing of RAX is related to this because? Sure you need it for
> > adjust_got() but adding a comment to that is too much asked for, right?
> 
> Huh? The comment just above the line describes why it's needed.

No it does not. It is a comment which has only value when you first read
the comment above the function which is called 5 lines later. Comments
should make sense on their own. To be honest I did not even make the
connection when I read the function later.

> > > +	/* Calculate the address the binary is loaded at. */
> > > +	call	1f
> > > +1:	popq	%rdi
> > > +	subq	$1b, %rdi
> > > +
> > > +	call	adjust_gop
> > > +
> > >  	/*
> > >  	 * At this point we are in long mode with 4-level paging enabled,
> > >  	 * but we might want to enable 5-level paging or vice versa.
> > > @@ -381,6 +396,24 @@ trampoline_return:
> > >  	pushq	$0
> > >  	popfq
> > >  
> > > +	/*
> > > +	 * Previously we've adjusted the GOT with address the binary was
> > > +	 * loaded at. Now we need to re-adjust for relocation address.
> > > +	 */
> > 
> > Breaking up those comments makes it more readable, right?
> 
> Yes, I think so.
> 
> The first comment is for the whole block of code below. The second is the
> comment for the first step.

Sorry no. It's just confusing as hell and a few weeks down the road it
looks like somebody removed the code between the comments and forgot to
update them. You can put an empty line into one comment block to separate
paragraphs.

> Yes, I have hard time write correctly, even in my native languages.
> I'm blind to mistakes I do. I'm sorry about them.

Sorry, that you have a problem with that, but you could have told me
offlist long ago and we would have found a solution for this.

Not knowing that, it just looks like being careless to the other side.

Thanks,

	tglx
