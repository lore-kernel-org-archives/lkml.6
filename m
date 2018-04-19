Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524096123; cv=none;
        d=google.com; s=arc-20160816;
        b=gRGiQw73YE+fliXId72AFifGGr487IutRSBTg9JEt1jLBwdSfiOptM58Sc+pgZAMzz
         kXSwQF8p1yfPjnhXZ/Mu1jzWYG0GyLTl1lLUfNuJN1LR7MgoWcSNVaLSLIPPUP6alvFH
         yFG9bcjkiosvaWHUL414DUjAG2ihO5dzoRlY2sBCBg1fDsiCmakhGLTI/g1rkcuXUFIS
         sBQdpVFHfEJCaTC40LWwWhvKAN+r2wZyawhrSET3uAGvI+yV4IUDr1lHB9cEwaZGfJ2q
         yECMayHb6Tb2cR/ZFwNTkFhkXl86wMhVQmAqilF0mpP4VcMZ6Cseba068hwXD8ayWhr+
         /lyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=b8rqKkanK4DLIShldn3HRZxMXdammSN0ZpxXW3E1iUc=;
        b=aXIDO/xb8wtUekAC5E9KAGf4scdJiovPiOfyGJb5NdlxXS62sl2dhv/eISYTxqCwQE
         iVpQUSt/mAob6RUfpdX1j/F3fP1k0T4/iwCgvxLwSRY11EwceUq1sDZtYM9w6T3apUDe
         BPmbtlpW6ayxKjtsNUzLxdf6uv9ZY9sA6Pe8P6q9NgWk0ixcJauUf3Yfy0b2FEArB8Kv
         aLD33GdKJ2G5ulK67iGj0dVdm1GS2ylRZlIdTbvs2UFGOLIXDWdYfvKUUTUYf2oSHBRD
         1DBV4j84brHoN2jihlSSNRiWGR9x7rzE24qZgtrcZNQkiDNU+CPVzTH7lMHnCn9YGz5A
         axzw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OLSSqi6o;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=Nw2UHDqG;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OLSSqi6o;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=Nw2UHDqG;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AIpwx49FrwLjE0X1Kdwa+YOWQgqB5ID2mcesmokHFC20H4usa/V7sHIKWZNKrZahzxVgpIl+2IirefFQEWLpxhQ5gMw=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <87k1t4t7tw.fsf@linux.intel.com>
References: <1523892323-14741-1-git-send-email-joro@8bytes.org>
 <1523892323-14741-4-git-send-email-joro@8bytes.org> <87k1t4t7tw.fsf@linux.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Apr 2018 17:02:02 -0700
X-Google-Sender-Auth: IF7iV_JKyJrKOSHuf_tqY69glbc
Message-ID: <CA+55aFxKzsPQW4S4esvJY=wb7D3LKBdDDcXoMKJSqcOgnD3FuA@mail.gmail.com>
Subject: Re: [PATCH 03/35] x86/entry/32: Load task stack from x86_tss.sp1 in
 SYSENTER handler
To: Andi Kleen <ak@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, "the arch/x86 maintainers" <x86@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
	Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>, Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>, Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>, "Liguori, Anthony" <aliguori@amazon.com>,
	Daniel Gruss <daniel.gruss@iaik.tugraz.at>, Hugh Dickins <hughd@google.com>,
	Kees Cook <keescook@google.com>, Andrea Arcangeli <aarcange@redhat.com>, Waim@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597916934570630846?=
X-GMAIL-MSGID: =?utf-8?q?1598130616171387367?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 4:26 PM, Andi Kleen <ak@linux.intel.com> wrote:
>
> Seems like a hack. Why can't that be stored in a per cpu variable?

It *is* a percpu variable - the whole x86_tss structure is percpu.

I guess it could be a different (separate) percpu variable, but might
as well use the space we already have allocated.

             Linus
