Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELveUeR9eQl/PpGSnEVqVhaZFKvNSob5/HJl9pDkvvYihqD0QqJROUvREghFZkc0gKRokawQ
ARC-Seal: i=1; a=rsa-sha256; t=1520274325; cv=none;
        d=google.com; s=arc-20160816;
        b=G8gkHMNyK+zF06a/yPnN/oLSSfgBu24KA1D/jtWEk/9hwBPtuPrhW1UUD/loaKn1Ur
         593wIe7HHvh5xeHtUJgW2zyy8QoQRBQRX4dGLbmrH7SQQY5kfwSh8H+IvjERYwltv0IS
         7IGtfIBcjQMY8wQPO5/koYhCU40LIPphJ2QgSCO44EPNY57scL9KaB4GudrvJh44ua9i
         1SENBVhM+2Gww/04apWA12QLPYq1XHgi/KMUZ1+MJ9JWKoY5ZqSC4CoFAjuD4IyyJjDo
         uNJQ6NuDtTTbNOq6do0j/j3Jq44qvW6rO8aWAZ6N7JMbFWiR03ut/dQXwJVzaVY7dB7z
         vgqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=vTVn/V67uglWFPu1xXRqaL6PPUAuxt/2pn1u3o2Yhk4=;
        b=A4ynNQmszBsfLaKVc37kyPtJOjskRO08HmWFGiGFO6Z8w+KKebXesEan0IrIZjjpqP
         cCfZxzQlw29R3yGfcBcBBbtYmhjGK1Nc1eZWnwL5Ud/RKlPnet76bgJ1z5UQ6OsMSPcP
         QWQDRl+OoWzQUAD8wa1oCW9i10SuSY3sIjkqDZFEKD39JTzzfscQZMsnsBbyNBBqyStY
         aNcvKrjLUy6xFsAVJCMSnHE865+m1gRi+ZX6JZQARpjvwj2EXIKOY75PfDu/0cbq7YLn
         3guAIN80luU63bGVqvb+/UUH5PDTQa6230HzugpN8W6HqC5/7Sq059vExU7SVmS6use7
         NGOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=iDL/Q4su;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=iDL/Q4su;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Date: Mon, 5 Mar 2018 19:25:24 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Brian Gerst <brgerst@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	the arch/x86 maintainers <x86@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
	Hugh Dickins <hughd@google.com>, Kees Cook <keescook@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 11/34] x86/entry/32: Handle Entry from Kernel-Mode on
 Entry-Stack
Message-ID: <20180305182524.GT16484@8bytes.org>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
 <1520245563-8444-12-git-send-email-joro@8bytes.org>
 <CAMzpN2h3xkhw_A4VeeA47=oykKgxXeumHM-q0QpaA8+fwFVRjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMzpN2h3xkhw_A4VeeA47=oykKgxXeumHM-q0QpaA8+fwFVRjw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093022557312692?=
X-GMAIL-MSGID: =?utf-8?q?1594123171218540908?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Brian,

thanks for your review and helpful input.

On Mon, Mar 05, 2018 at 11:41:01AM -0500, Brian Gerst wrote:
> On Mon, Mar 5, 2018 at 5:25 AM, Joerg Roedel <joro@8bytes.org> wrote:
> > +.Lentry_from_kernel_\@:
> > +
> > +       /*
> > +        * This handles the case when we enter the kernel from
> > +        * kernel-mode and %esp points to the entry-stack. When this
> > +        * happens we need to switch to the task-stack to run C code,
> > +        * but switch back to the entry-stack again when we approach
> > +        * iret and return to the interrupted code-path. This usually
> > +        * happens when we hit an exception while restoring user-space
> > +        * segment registers on the way back to user-space.
> > +        *
> > +        * When we switch to the task-stack here, we can't trust the
> > +        * contents of the entry-stack anymore, as the exception handler
> > +        * might be scheduled out or moved to another CPU. Therefore we
> > +        * copy the complete entry-stack to the task-stack and set a
> > +        * marker in the iret-frame (bit 31 of the CS dword) to detect
> > +        * what we've done on the iret path.
> 
> We don't need to worry about preemption changing the entry stack.  The
> faults that IRET or segment loads can generate just run the exception
> fixup handler and return.  Interrupts were disabled when the fault
> occurred, so the kernel cannot be preempted.  The other case to watch
> is #DB on SYSENTER, but that simply returns and doesn't sleep either.
> 
> We can keep the same process as the existing debug/NMI handlers -
> leave the current exception pt_regs on the entry stack and just switch
> to the task stack for the call to the handler.  Then switch back to
> the entry stack and continue.  No copying needed.

Okay, I'll look into that. Will it even be true for fully preemptible
and RT kernels that there can't be any preemption of these handlers?

> > +       /* Mark stackframe as coming from entry stack */
> > +       orl     $CS_FROM_ENTRY_STACK, PT_CS(%esp)
> 
> Not all 32-bit processors will zero-extend segment pushes.  You will
> need to explicitly clear the bit in the case where we didn't switch
> CR3.

Okay, thanks, will add that.


Regards,

	Joerg
