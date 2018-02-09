Return-Path: <luto@kernel.org>
X-Google-Smtp-Source: AH8x224kHLvqiDu1IZXNo04Tq+sFZut+i/riuEJE/WbjdsnxPuexzEC7XZ8RlLpjb1WmhDPnDdg8
ARC-Seal: i=1; a=rsa-sha256; t=1518198538; cv=none;
        d=google.com; s=arc-20160816;
        b=h9qPHVmI1lAvm3/M/q8Uug8Rhqh+pm/Sui5ZyiD3Y/s+qnHlxCucQcNJDvVYBywLXB
         tBjDupORu1oBpGHByC9K600AOrhYMdA4huuv1nQgCcsVh/b+XKAnF3hYdZSRA3RuU/Ra
         dGuHJ0l1Vclrr6+A47L97C+OPLeLvjCa0AW0ZIbRqw9+PcZlK3GsSTTjv6ZxpaPshFGM
         o5fvluD/VGQ0A3dkRO4Y97JmL00W2t7QXAfW4QJ2dvl78lo1fGWPfVZHGNV89/kpsco3
         SwkwG38j/NhdBtTo2bXA/xv0586S0sd1cWygRKX28OQITOz7xJ8Lr6j0fLcQeoXcvNT0
         Zj2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=7CrjGlQm4rePqdkfzRtRSGReBaJXbwKvLm/0Pw366Ek=;
        b=r+XPA00Ev60IhUq0jUiYeLTdMrEa+s3bEpBwbDDbE8z/wq1RIJvBITmpqc3iNIXp3+
         Wtmd3JTi+loYlxLnVMUtBhDkEM79TCkwKzv6cERgBxLnFouGDw+Oi7zz7WZK8JJMfDPG
         7rsdaT+LVVDjZtakx3tzNsDnEgiNH7oscCJBeW2lSAdx210OYgNczym3+QSdL4cm3KSM
         CZ5VfusO6m9S5dS1u80QBfHbPvglE2FSpWa5CiGOG/Q8HoE/oVid+LFbwFtxt6wevgVa
         HW1/LHLWTywxDiYCjGGRMKZ3grYjkj7zUzGko8TeUWWOzAjQUcd8tuGANrnGoxiPBKMn
         /qrg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of luto@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=luto@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of luto@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=luto@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5427121789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
MIME-Version: 1.0
In-Reply-To: <1518168340-9392-21-git-send-email-joro@8bytes.org>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org> <1518168340-9392-21-git-send-email-joro@8bytes.org>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 9 Feb 2018 17:48:36 +0000
X-Gmail-Original-Message-ID: <CALCETrUgk3s0uDZrHqy-HjudFXLeWN=oKz6EH9i-NCdWQEnAqw@mail.gmail.com>
Message-ID: <CALCETrUgk3s0uDZrHqy-HjudFXLeWN=oKz6EH9i-NCdWQEnAqw@mail.gmail.com>
Subject: Re: [PATCH 20/31] x86/mm/pae: Populate the user page-table with user pgd's
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
	Will Deacon <will.deacon@arm.com>, "Liguori, Anthony" <aliguori@amazon.com>,
	Daniel Gruss <daniel.gruss@iaik.tugraz.at>, Hugh Dickins <hughd@google.com>,
	Kees Cook <keescook@google.com>, Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>, Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914910930783866?=
X-GMAIL-MSGID: =?utf-8?q?1591946550723940601?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 9, 2018 at 9:25 AM, Joerg Roedel <joro@8bytes.org> wrote:
> From: Joerg Roedel <jroedel@suse.de>
>
> When we populate a PGD entry, make sure we populate it in
> the user page-table too.
>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/include/asm/pgtable-3level.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
> index bc4af54..1a0661b 100644
> --- a/arch/x86/include/asm/pgtable-3level.h
> +++ b/arch/x86/include/asm/pgtable-3level.h
> @@ -98,6 +98,9 @@ static inline void native_set_pmd(pmd_t *pmdp, pmd_t pmd)
>
>  static inline void native_set_pud(pud_t *pudp, pud_t pud)
>  {
> +#ifdef CONFIG_PAGE_TABLE_ISOLATION
> +       pud.p4d.pgd = pti_set_user_pgd(&pudp->p4d.pgd, pud.p4d.pgd);
> +#endif
>         set_64bit((unsigned long long *)(pudp), native_pud_val(pud));
>  }
>
> @@ -194,6 +197,10 @@ static inline pud_t native_pudp_get_and_clear(pud_t *pudp)
>  {
>         union split_pud res, *orig = (union split_pud *)pudp;
>
> +#ifdef CONFIG_PAGE_TABLE_ISOLATION
> +       pti_set_user_pgd(&pudp->p4d.pgd, __pgd(0));
> +#endif
> +
>         /* xchg acts as a barrier before setting of the high bits */
>         res.pud_low = xchg(&orig->pud_low, 0);
>         res.pud_high = orig->pud_high;

Can you rename the helper from pti_set_user_pgd() to
pti_set_user_top_level_entry() or similar?  The name was already a bit
absurd, but now it's just nuts.
