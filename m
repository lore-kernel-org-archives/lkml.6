Return-Path: <mceier@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524002197; cv=none;
        d=google.com; s=arc-20160816;
        b=TlyZcx6IXimRC6ClgHFHO5YlIpm7nbbOIFmNIYXIgERaM8PGBm9+iI7is0nZHKRm0O
         s0aFSt54fx4ZLDrjC59QMeCqJUkYL611KuS8L9EV9O9gWILwQv80i/MNct7Yj62YLyNk
         33Fnw9NzIwChwKOeuTqXDxDu/zLY1hMc6yPX2U2A1CjreDoV4byBuXt6iNuV8QY/P6cH
         OTT2PCv/M2AhqazOA0vJgmVtMoJE2DaoR1FjSNrdioR4v6KMPsJwphHeYBoX/hFLYEzR
         ZfGtrfIq1NINyppNo50wAHqTPAbgjfvresyGPJoLcMz5HXQpXXLeZjd1FhazJ7JhWgPJ
         XlRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :reply-to:mime-version:dkim-signature:arc-authentication-results;
        bh=88hF6HjYXl1+pPOp9lGTbAkVO3fFYJNITc21RS7ow7w=;
        b=Dh6/o+HnAV2KmsGI6OqfRlKb4skTUV+fgJLD52lgHODaaJ0W8ZL98AY7QcNRRybUEF
         bojE8Ie2pp7QVrpYJ+uMR0weEyzEmJPF6HVuHsSiWZAEGa03VoCHXI2aB89vZzLPYe4S
         BtMM/0oi3ysLesc2DvsClNA0fwirmNZEdy0jb0aFjsgFG4NfTFvmwYA/+g4cLy3YC+yL
         vZ1FA0wM/4DA4q85wu+IFPU+R20BxdBx8TTwrdVzO19UikMnvuoCdWsU9mOBsoY0HqW7
         XxyVaOc2KsHPU9qum7Z4w9aeUWngHZmlWEUyUEn0mCuHYdveQgkIOpWJsepyVm4bAuFP
         y+Lw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=K3ST8Ego;
       spf=pass (google.com: domain of mceier@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mceier@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=K3ST8Ego;
       spf=pass (google.com: domain of mceier@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mceier@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49WcOV7ELZ4LOkZTwbWA10CXxV3hQdwU7aRVoU9VvKrx8ZQDD4ICmVaXm+q8n9j4goOeizJBPynvHl71OxPluA=
MIME-Version: 1.0
Reply-To: mceier+kernel@gmail.com
Sender: mceier@gmail.com
In-Reply-To: <20180417211304.7B3F1FDB@viggo.jf.intel.com>
References: <20180417211302.421F6442@viggo.jf.intel.com> <20180417211304.7B3F1FDB@viggo.jf.intel.com>
From: Mariusz Ceier <mceier+kernel@gmail.com>
Date: Tue, 17 Apr 2018 23:56:36 +0200
X-Google-Sender-Auth: 1MO_uNmo4J3IoX2sOTI-cX0fMGo
Message-ID: <CAJTyqKMLh4QoNYUF1BZ5D51L8ZEt_fxqNRWYBON+27icavY8tQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86, pti: fix boot warning from Global-bit setting
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
	Aaro Koskinen <aaro.koskinen@nokia.com>, aarcange@redhat.com, luto@kernel.org,
	arjan@linux.intel.com, Borislav Petkov <bp@alien8.de>, dan.j.williams@intel.com,
	dwmw2@infradead.org, gregkh@linuxfoundation.org, hughd@google.com,
	jpoimboe@redhat.com, jgross@suse.com, keescook@google.com,
	Linus Torvalds <torvalds@linux-foundation.org>, namit@vmware.com, peterz@infradead.org,
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598029619129049046?=
X-GMAIL-MSGID: =?utf-8?q?1598032127764006658?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 17 April 2018 at 23:13, Dave Hansen <dave.hansen@linux.intel.com> wrote:
>
> These are _very_ lightly tested.  I'm throwing them out there for
> folks are looking for a fix.
>
> ---
>
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> pageattr.c is not friendly when it encounters empty (zero) PTEs.  The
> kernel linear map is exempt from these checks, but kernel text is not.
> This patch adds the code to also exempt kernel text from these checks.
> The proximate cause of these warnings was most likely an __init area
> that spanned a 2MB page boundary that resulted in a "zero" PMD.
>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Fixes: 39114b7a7 (x86/pti: Never implicitly clear _PAGE_GLOBAL for kernel image)
> Reported-by: Mariusz Ceier <mceier@gmail.com>
> Reported-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Arjan van de Ven <arjan@linux.intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Kees Cook <keescook@google.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Nadav Amit <namit@vmware.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-mm@kvack.org
> ---
>
>  b/arch/x86/mm/pageattr.c |   17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff -puN arch/x86/mm/pageattr.c~pti-glb-warning-inpageattr arch/x86/mm/pageattr.c
> --- a/arch/x86/mm/pageattr.c~pti-glb-warning-inpageattr 2018-04-17 14:10:22.695395554 -0700
> +++ b/arch/x86/mm/pageattr.c    2018-04-17 14:10:22.721395554 -0700
> @@ -1151,6 +1151,16 @@ static int populate_pgd(struct cpa_data
>         return 0;
>  }
>
> +bool __cpa_pfn_in_highmap(unsigned long pfn)
> +{
> +       /*
> +        * Kernel text has an alias mapping at a high address, known
> +        * here as "highmap".
> +        */
> +       return within_inclusive(pfn, highmap_start_pfn(),
> +                       highmap_end_pfn());
> +}
> +
>  static int __cpa_process_fault(struct cpa_data *cpa, unsigned long vaddr,
>                                int primary)
>  {
> @@ -1183,6 +1193,10 @@ static int __cpa_process_fault(struct cp
>                 cpa->numpages = 1;
>                 cpa->pfn = __pa(vaddr) >> PAGE_SHIFT;
>                 return 0;
> +
> +       } else if (__cpa_pfn_in_highmap(cpa->pfn)) {
> +               /* Faults in the highmap are OK, so do not warn: */
> +               return -EFAULT;
>         } else {
>                 WARN(1, KERN_WARNING "CPA: called for zero pte. "
>                         "vaddr = %lx cpa->vaddr = %lx\n", vaddr,
> @@ -1335,8 +1349,7 @@ static int cpa_process_alias(struct cpa_
>          * to touch the high mapped kernel as well:
>          */
>         if (!within(vaddr, (unsigned long)_text, _brk_end) &&
> -           within_inclusive(cpa->pfn, highmap_start_pfn(),
> -                            highmap_end_pfn())) {
> +           __cpa_pfn_in_highmap(cpa->pfn)) {
>                 unsigned long temp_cpa_vaddr = (cpa->pfn << PAGE_SHIFT) +
>                                                __START_KERNEL_map - phys_base;
>                 alias_cpa = *cpa;
> _


I confirm that these 2 patches fix the BUG for me in kernel 4.17.0-rc1.

Thanks
