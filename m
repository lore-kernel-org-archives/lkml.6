Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524503360; cv=none;
        d=google.com; s=arc-20160816;
        b=0FkhVAGuYAPyNRO19of7NZeweyge0x18Ob4mKhVH3ptJNCbm1SrZWDq/lfJEw6sqpm
         lV6/6TrHwMwN9dRWQuttZVPYleIHYS8f0X/V5eWgcNgaPqyMYzgi1FfA24uGOjR470yS
         Ivu/ALQi2khxcUWLGFqvQXPSkpTA9Sd9GCjPCx3kk1SWhZTZrl9FHPHMLOJevgbRNFm2
         6zsA35qZAW1alDA/jVdQOfKd1zb2+Feu0ByAzkDdmJXMQjkoOYat9BckB+e7hMrhOU4J
         1RwG3K685B/xu2ao6qpFrwjjK6xga+opcAWFjUbbQF+js/cSOeTQ9q56vJSwBkCxBfKv
         W3yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=V6gOr1uccRhG696t1txqe5EZlRG5fq3rR+jtTEAiUVg=;
        b=ALqZSibhIJwoGlikeMwBMIp3s6QASd/dXtHJhuJ2x84zwCWGqABXi7475dLDcEBYTz
         INYuKQzcUa31iOHJqPLRETAqK7YwIC7m75m0frdvyHbHDFg00O1cUQZslL2F2KGI9mcy
         5CsiS01tH3vaAIH1TxyGdeUoCWsNAnWZ7JaAXXBRWZsM67DMky4jfLQ5OpG2xtKcgVDf
         mHUaNOBcxWpKcDnYWPHgpsvuN1+RCD7qrzVhPeihplQPAo0ZICvrnCLK69tmKZN+4UTa
         9lO+96gkQVSH6Rf8DSQsU21vS8c618B0bNbRC31I7mZFRktrBoMnQrIutzhsf1YT+10i
         teLw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=CDcG4nI7;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=CDcG4nI7;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx4/fbkutpupIM2fnVfy7fI0xiDavwNrhz/MM5EXkBI3UVqA4BZQHM6vUs8OLiwTejUb7Pp5Y0s8kSg9m4am+Zgo=
MIME-Version: 1.0
In-Reply-To: <1524498460-25530-29-git-send-email-joro@8bytes.org>
References: <1524498460-25530-1-git-send-email-joro@8bytes.org> <1524498460-25530-29-git-send-email-joro@8bytes.org>
From: Kees Cook <keescook@google.com>
Date: Mon, 23 Apr 2018 10:09:19 -0700
Message-ID: <CAGXu5jKYhqvgooq8q-2NoMC_Cqh-SR8J0y0c1x9LteinDfQELQ@mail.gmail.com>
Subject: Re: [PATCH 28/37] x86/mm/pti: Map kernel-text to user-space on 32 bit kernels
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
X-GMAIL-THRID: =?utf-8?q?1598552514601150146?=
X-GMAIL-MSGID: =?utf-8?q?1598557636009113386?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 8:47 AM, Joerg Roedel <joro@8bytes.org> wrote:
> From: Joerg Roedel <jroedel@suse.de>
>
> Keeping the kernel text mapped with G bit set keeps its
> entries in the TLB across kernel entry/exit and improved the
> performance. The 64 bit x86 kernels already do this when
> there is no PCID, so do this in 32 bit as well since PCID is
> not even supported there.

I think this should keep at least part of the logic as 64-bit since
there are other reasons to turn off the Global flag:

https://lkml.kernel.org/r/20180420222026.D0B4AAC9@viggo.jf.intel.com

-Kees

>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/mm/init_32.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
> index c893c6a..8299b98 100644
> --- a/arch/x86/mm/init_32.c
> +++ b/arch/x86/mm/init_32.c
> @@ -956,4 +956,10 @@ void mark_rodata_ro(void)
>         mark_nxdata_nx();
>         if (__supported_pte_mask & _PAGE_NX)
>                 debug_checkwx();
> +
> +       /*
> +        * Do this after all of the manipulation of the
> +        * kernel text page tables are complete.
> +        */
> +       pti_clone_kernel_text();
>  }
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
