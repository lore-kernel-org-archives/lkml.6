Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518195905; cv=none;
        d=google.com; s=arc-20160816;
        b=dDlQuKFsZfOeyMRi1kaDwkF0gpu5K0QA93AVU8zNTaUPGVKWUZqdf/myYYAFHz8jiI
         Rc0dpzfyE2GM+0snSa9RAQS6yVTwFxxbqtb8pxveoZIox2N/6tUbb9d4+E+VdV1OWf0e
         31RrxVQ0nBJkA+UgEIjkRtalQa+oMYyNPKAU/JAwbnW9SamV7CVsMx+1QBZ3t76F9xyw
         ZtzZUu8OHYeyiFxtcdiuYeNG6RGzBejYxDOpi3TzRSiBx7QmZeDiAXMj6w1tPbRzc8Yf
         C6Cj/kfsH4yRZLhmom6iqp0muRrF+t/xMyvRaAOdB67frkXFfPeKOa+qo3jYOjzWYAq9
         MJ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=5xC0LWiP49tHtE62343SVaW62QIKt1lVjPDfW3PdScU=;
        b=MNH2zW3Y4QHq1lz6ssW8awvlerxoL9aPa7niOj0VpRkh3j380DpIfp23QzVDeLDU1O
         spcbxHjRZAMCCIwgT00jXk6MY/Px24wJ8wVhUkGO9SESNghWhewanOHMzEDj6AZJi7pq
         jmjvlIAOipcWCkOdOr1zh1cNqExyFwQdYpPD83q1NFug2J5bZH/iMaiQD3iQbh9JoidF
         Cqa/3T5HcHCGpm0tmAo2A1xKH1Ui/nczGBh6UvESbMMAIEfpdKaIKn34KJVW2d/EKoxO
         ILBsDEXZvbfSLzEusSCeer/+RF+h2DTroDkmqHczuE8lcbdtGPnJn9YUlxeVNfmblgmL
         MWYg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Fc+FRolY;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Fc+FRolY;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x224ru7k4b89pe9vl/ocszLTHEGQ3zXgnyZaFCchAg0uLOJI504XL0ukDZ6BxhJbBBOYX+Xjci7DXRBqDlU2pK40=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1518168340-9392-10-git-send-email-joro@8bytes.org>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org> <1518168340-9392-10-git-send-email-joro@8bytes.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 9 Feb 2018 09:05:02 -0800
X-Google-Sender-Auth: eXQDFw9VX0uBcOBnj5bf0zB2eg4
Message-ID: <CA+55aFzB9H=RT6YB3onZCephZMs9ccz4aJ_jcPcfEkKJD_YDCQ@mail.gmail.com>
Subject: Re: [PATCH 09/31] x86/entry/32: Leave the kernel via trampoline stack
To: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
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
	Kees Cook <keescook@google.com>, Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>, Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914904027044040?=
X-GMAIL-MSGID: =?utf-8?q?1591943790074191458?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 9, 2018 at 1:25 AM, Joerg Roedel <joro@8bytes.org> wrote:
> +
> +       /* Copy over the stack-frame */
> +       cld
> +       rep movsb

Ugh. This is going to be horrendous. Maybe not noticeable on modern
CPU's, but the whole 32-bit code is kind of pointless on a modern CPU.

At least use "rep movsl". If the kernel stack isn't 4-byte aligned,
you have issues.

             Linus
