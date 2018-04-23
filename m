Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524503182; cv=none;
        d=google.com; s=arc-20160816;
        b=ewlIUgNRnC01cyhxHjSNCj/YC8KgDNRQjOEd8i4kAbdofq2Gw70x1WiWUiperP3u2X
         /63QsjnExGtcOe57hIDOs2NeaIkBtALHw7kabO6sQ+vbEnrwREiPTN1eWt4I1yF41NPI
         7a085cbtP8ABysSXQOIj1qBASLI71Xhkwe+vDUxGK4yLnKncqbT4CynlCz02cwEWOV5N
         oXk10MpO3/YMqWUhgyTuilQNVXWDzKLD1UWiYWLo+ip98rpxBDqGvstpRoh+MRo7dium
         p4QXYIKtvLvj0NqvcBJqQ3AZO/wsgDYTB34D4MPFeWWy+wT9wgaqkztqrpyTP7LKdjLu
         MCNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=4TvV75HUGSffWDz8yhG/jkWHrd3mH4frhfK0tayes2g=;
        b=ZrJ8vX/0Uon04ibTSoAPrbge5K7nTH1OMHTZ8AGKf8lcasRxsmVCtgNsRILD2wTJqM
         IYHM1wl1DouB8tusMrTsOrojSft0JUI5/52fFNQ9BeQZ0OgbONWbb7fPD+luCEJIsYAi
         MVrlI+W+QIRLvMk2//nMJDGU85LGBFKh5h374GIkELOoxopXduv9uK4p5tip0gTngVE3
         YY9W6MtTIWjbUROoqBtqljcG+Ews0vTe/Ms4VuK4a0l4dvL6CrPjeSnwBojsxZ0BsDNx
         Te4e5Ye1aXTQbw3kdYNMNRKJFrhFWcGmbv41qO4bEV0lyqmkyrEIpT0Lj14/eeoRhauO
         SMFA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=sYhSMlVc;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=sYhSMlVc;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx49fkScAz9Ru7Z6Zz58CjkHjksXSjIPKJJre4HJssUry813pyWTmAR4TI+1Aa9XE/RHB6CHTJSvZnHzDqTWszBw=
MIME-Version: 1.0
In-Reply-To: <1524498460-25530-28-git-send-email-joro@8bytes.org>
References: <1524498460-25530-1-git-send-email-joro@8bytes.org> <1524498460-25530-28-git-send-email-joro@8bytes.org>
From: Kees Cook <keescook@google.com>
Date: Mon, 23 Apr 2018 10:06:20 -0700
Message-ID: <CAGXu5jLN_rzmfgM-Xne836ip+qMc8T1QX=mhozo3NFLNssgUfw@mail.gmail.com>
Subject: Re: [PATCH 27/37] x86/mm/pti: Keep permissions when cloning kernel
 text in pti_clone_kernel_text()
To: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>, Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>, Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>, Anthony Liguori <aliguori@amazon.com>,
	Daniel Gruss <daniel.gruss@iaik.tugraz.at>, Hugh Dickins <hughd@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>, Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
	"David H . Gutteridge" <dhgutteridge@sympatico.ca>, Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598552515043565489?=
X-GMAIL-MSGID: =?utf-8?q?1598557448862281254?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 8:47 AM, Joerg Roedel <joro@8bytes.org> wrote:
> From: Joerg Roedel <jroedel@suse.de>
>
> Mapping the kernel text area to user-space makes only sense
> if it has the same permissions as in the kernel page-table.
> If permissions are different this will cause a TLB reload
> when using the kernel page-table, which is as good as not
> mapping it at all.
>
> On 64-bit kernels this patch makes no difference, as the
> whole range cloned by pti_clone_kernel_text() is mapped RO
> anyway. On 32 bit there are writeable mappings in the range,
> so just keep the permissions as they are.

Why are there R/W text mappings in this range? I find that to be
unexpected. Shouldn't CONFIG_DEBUG_WX already complain if that were
true?

-Kees

-- 
Kees Cook
Pixel Security
