Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AB8JxZrXTd+u1pake/M9BJnn9gf5zQoBUXS2kw5ZSffEDvHmpS5KJvMKAwgFWbp0s7PooTHaTP0C
ARC-Seal: i=1; a=rsa-sha256; t=1526639925; cv=none;
        d=google.com; s=arc-20160816;
        b=Th/4RA7rlHLMynucmdC589d4SR/pUjdhPTsD+dSI+TVYTCtYcZE66+G34p1yng17ET
         Zc9q7n4J9+M1DdWfzgZYdsqKusx/GbtnaT4+TzAMvQeVtXdmdEh4BocVL9hJMP6hYwZU
         BExiw+rAi+bCQqtLIaZylF1BM0OTq7NqmSiIhdr0pQ6itjLngIda+Dp0aBkmBEA8udfM
         3ptjnzYoWD6SHfdDZ52xI03IB6BDsxFJ2ho49dRnMQv+I+jhmTWfHHkWGJrWMBXV4e1t
         h0PLawGA0lbfeU4oBK5UxgATML1QSxS92UsIaWgKH/u7Y09a8xvCK0XIlM6etzgDilLw
         209g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=vUEHOQRZFbFSFHoQy3ZValvCTKhGQYEsH265E+9tu9w=;
        b=qchI0qJZMserOx2A91a9kIQOG6t4QI6Qnp1T/1E5bmvVtlRxY4JbLd6eYHywEBobzo
         1TmJ/m/8OE8+HVH8TknNE1ULSLMBKL4eP9okM8UhAVR6LR/bLDYp2WuoPDZjvd2vY/WX
         fHRhueOs9U5+yb0Q5XPtty6gLp45bKYzC3zVPoHgqEhKUbCfMAC3ucWwPJo/HP14tL9x
         qbi8/KwePTm60rkHc2EYKQRQG3OrczYxyDYkY5EtXw4d462JS4qDSqCk5BNbq2hRICRX
         VIDPAWm2405G364YDilbzIhthTsHYpXEvqro/RtepL6IUQYoO0IdAzA7p/WbS2wXF8dl
         BIYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 146.0.238.70 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 146.0.238.70 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Date: Fri, 18 May 2018 12:38:39 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Josh Poimboeuf <jpoimboe@redhat.com>
cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
    Linus Torvalds <torvalds@linux-foundation.org>,
    Andy Lutomirsky <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
    Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bpetkov@suse.de>,
    Greg KH <gregkh@linuxfoundation.org>, keescook@google.com,
    hughd@google.com, Brian Gerst <brgerst@gmail.com>,
    Denys Vlasenko <dvlasenk@redhat.com>, Rik van Riel <riel@redhat.com>,
    Boris Ostrovsky <boris.ostrovsky@oracle.com>,
    Juergen Gross <jgross@suse.com>, David Laight <David.Laight@aculab.com>,
    Eduardo Valentin <eduval@amazon.com>, aliguori@amazon.com,
    Will Deacon <will.deacon@arm.com>, Vlastimil Babka <vbabka@suse.cz>,
    daniel.gruss@iaik.tugraz.at, Ingo Molnar <mingo@kernel.org>,
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
    "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch V181 35/54] x86/entry: Align entry text section to PMD
 boundary
In-Reply-To: <20180517155806.77k4zw5n3q6ia4yq@treble>
Message-ID: <alpine.DEB.2.21.1805181232280.2172@nanos.tec.linutronix.de>
References: <20171220213503.672610178@linutronix.de> <20171220215443.503537377@linutronix.de> <20180517155806.77k4zw5n3q6ia4yq@treble>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1587122604399937200?=
X-GMAIL-MSGID: =?utf-8?q?1600797986341797413?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 17 May 2018, Josh Poimboeuf wrote:

> On Wed, Dec 20, 2017 at 10:35:38PM +0100, Thomas Gleixner wrote:
> > From: Thomas Gleixner <tglx@linutronix.de>
> > 
> > The (irq)entry text must be visible in the user space page tables. To allow
> > simple PMD based sharing, make the entry text PMD aligned.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> 
> With my config, this patch adds 2.5M (+~25%) to the kernel text size.
> Is there a more granular way to achieve this?

We could make it PTE granular with some effort, but that would make the
whole PTI handling more complex. So not sure, if that's worth it.

Thanks,

	tglx
