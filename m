Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30901C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3831222A0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549912075;
	bh=hpHnp7o2FMuoS6rET5Md+trpsiNaL7H6bUMVvMqQUbo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=R1WPkaDx1Smhht15Kv6s+8+Qp5jAx0cFz7FgE/7yYhkeoYadCwzb9F/zacHX787KS
	 owWWvywXMZJHX7oMSAwqwH9qXv3o5oP4K0eTV1yBEOZWCzn2P3ELJt50701qRolBr+
	 zlRM4Vt+GCOLw7l+ff7c0YYqvIvHXtA3iWNmGaiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387579AbfBKTHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:07:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:37850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387553AbfBKTHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:07:52 -0500
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67DB0222AC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 19:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549912070;
        bh=hpHnp7o2FMuoS6rET5Md+trpsiNaL7H6bUMVvMqQUbo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VcfEfz58bFdmjlXz6M1KBALZPXQdtji8AYTEGbPM1aLDBdSQQgrq8f45Zsv7OV+va
         AUwWVG/w6leTLaGpdqUDnK2M/fATXStfUmnI0kmppzFNutH0BII1hlj8T8uucH9stE
         tyvX35tFtWHSARIUwwsxTNKlaRzhJbnn55GW4Uj0=
Received: by mail-wr1-f41.google.com with SMTP id t18so17965wrx.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 11:07:50 -0800 (PST)
X-Gm-Message-State: AHQUAubcKBgnVIsPu5p675QvzUXKbYEk2Rhk4hvzFxBAYMZ8IEoKY1Lv
        pQmO2ac3N7jpe2RCYHGdwr7jM3WYBQckKX//3Nl6Xg==
X-Google-Smtp-Source: AHgI3IYjrQE0EHl5TyoxDXY0/4ElafWu2SDDHhmeqZBTTRjtjt/RtCXzrxcQZ4yquiuuTjeaKmjMrBj6DfQWlMZaE/o=
X-Received: by 2002:adf:9dc4:: with SMTP id q4mr1168146wre.330.1549912068579;
 Mon, 11 Feb 2019 11:07:48 -0800 (PST)
MIME-Version: 1.0
References: <20190129003422.9328-1-rick.p.edgecombe@intel.com>
 <20190129003422.9328-6-rick.p.edgecombe@intel.com> <162C6C29-CD81-46FE-9A54-6ED05A93A9CB@gmail.com>
 <00649AE8-69C0-4CD2-A916-B8C8F0F5DAC3@amacapital.net> <6FE10C97-25FF-4E99-A96A-465CBACA935B@gmail.com>
In-Reply-To: <6FE10C97-25FF-4E99-A96A-465CBACA935B@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 11 Feb 2019 11:07:34 -0800
X-Gmail-Original-Message-ID: <CALCETrVaBaorbOA8QE=Pk=C+PfXZAz0-aX_3O8Y=nJV4QKELbw@mail.gmail.com>
Message-ID: <CALCETrVaBaorbOA8QE=Pk=C+PfXZAz0-aX_3O8Y=nJV4QKELbw@mail.gmail.com>
Subject: Re: [PATCH v2 05/20] x86/alternative: initializing temporary mm for patching
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Damian Tometzki <linux_dti@icloud.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>, Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 10:05 AM Nadav Amit <nadav.amit@gmail.com> wrote:
>
> > On Feb 10, 2019, at 9:18 PM, Andy Lutomirski <luto@amacapital.net> wrot=
e:
> >
> >
> >
> > On Feb 10, 2019, at 4:39 PM, Nadav Amit <nadav.amit@gmail.com> wrote:
> >
> >>> On Jan 28, 2019, at 4:34 PM, Rick Edgecombe <rick.p.edgecombe@intel.c=
om> wrote:
> >>>
> >>> From: Nadav Amit <namit@vmware.com>
> >>>
> >>> To prevent improper use of the PTEs that are used for text patching, =
we
> >>> want to use a temporary mm struct. We initailize it by copying the in=
it
> >>> mm.
> >>>
> >>> The address that will be used for patching is taken from the lower ar=
ea
> >>> that is usually used for the task memory. Doing so prevents the need =
to
> >>> frequently synchronize the temporary-mm (e.g., when BPF programs are
> >>> installed), since different PGDs are used for the task memory.
> >>>
> >>> Finally, we randomize the address of the PTEs to harden against explo=
its
> >>> that use these PTEs.
> >>>
> >>> Cc: Kees Cook <keescook@chromium.org>
> >>> Cc: Dave Hansen <dave.hansen@intel.com>
> >>> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >>> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> >>> Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
> >>> Suggested-by: Andy Lutomirski <luto@kernel.org>
> >>> Signed-off-by: Nadav Amit <namit@vmware.com>
> >>> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> >>> ---
> >>> arch/x86/include/asm/pgtable.h       |  3 +++
> >>> arch/x86/include/asm/text-patching.h |  2 ++
> >>> arch/x86/kernel/alternative.c        |  3 +++
> >>> arch/x86/mm/init_64.c                | 36 +++++++++++++++++++++++++++=
+
> >>> init/main.c                          |  3 +++
> >>> 5 files changed, 47 insertions(+)
> >>>
> >>> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pg=
table.h
> >>> index 40616e805292..e8f630d9a2ed 100644
> >>> --- a/arch/x86/include/asm/pgtable.h
> >>> +++ b/arch/x86/include/asm/pgtable.h
> >>> @@ -1021,6 +1021,9 @@ static inline void __meminit init_trampoline_de=
fault(void)
> >>>   /* Default trampoline pgd value */
> >>>   trampoline_pgd_entry =3D init_top_pgt[pgd_index(__PAGE_OFFSET)];
> >>> }
> >>> +
> >>> +void __init poking_init(void);
> >>> +
> >>> # ifdef CONFIG_RANDOMIZE_MEMORY
> >>> void __meminit init_trampoline(void);
> >>> # else
> >>> diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/=
asm/text-patching.h
> >>> index f8fc8e86cf01..a75eed841eed 100644
> >>> --- a/arch/x86/include/asm/text-patching.h
> >>> +++ b/arch/x86/include/asm/text-patching.h
> >>> @@ -39,5 +39,7 @@ extern void *text_poke_kgdb(void *addr, const void =
*opcode, size_t len);
> >>> extern int poke_int3_handler(struct pt_regs *regs);
> >>> extern void *text_poke_bp(void *addr, const void *opcode, size_t len,=
 void *handler);
> >>> extern int after_bootmem;
> >>> +extern __ro_after_init struct mm_struct *poking_mm;
> >>> +extern __ro_after_init unsigned long poking_addr;
> >>>
> >>> #endif /* _ASM_X86_TEXT_PATCHING_H */
> >>> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternat=
ive.c
> >>> index 12fddbc8c55b..ae05fbb50171 100644
> >>> --- a/arch/x86/kernel/alternative.c
> >>> +++ b/arch/x86/kernel/alternative.c
> >>> @@ -678,6 +678,9 @@ void *__init_or_module text_poke_early(void *addr=
, const void *opcode,
> >>>   return addr;
> >>> }
> >>>
> >>> +__ro_after_init struct mm_struct *poking_mm;
> >>> +__ro_after_init unsigned long poking_addr;
> >>> +
> >>> static void *__text_poke(void *addr, const void *opcode, size_t len)
> >>> {
> >>>   unsigned long flags;
> >>> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> >>> index bccff68e3267..125c8c48aa24 100644
> >>> --- a/arch/x86/mm/init_64.c
> >>> +++ b/arch/x86/mm/init_64.c
> >>> @@ -53,6 +53,7 @@
> >>> #include <asm/init.h>
> >>> #include <asm/uv/uv.h>
> >>> #include <asm/setup.h>
> >>> +#include <asm/text-patching.h>
> >>>
> >>> #include "mm_internal.h"
> >>>
> >>> @@ -1383,6 +1384,41 @@ unsigned long memory_block_size_bytes(void)
> >>>   return memory_block_size_probed;
> >>> }
> >>>
> >>> +/*
> >>> + * Initialize an mm_struct to be used during poking and a pointer to=
 be used
> >>> + * during patching.
> >>> + */
> >>> +void __init poking_init(void)
> >>> +{
> >>> +    spinlock_t *ptl;
> >>> +    pte_t *ptep;
> >>> +
> >>> +    poking_mm =3D copy_init_mm();
> >>> +    BUG_ON(!poking_mm);
> >>> +
> >>> +    /*
> >>> +     * Randomize the poking address, but make sure that the followin=
g page
> >>> +     * will be mapped at the same PMD. We need 2 pages, so find spac=
e for 3,
> >>> +     * and adjust the address if the PMD ends after the first one.
> >>> +     */
> >>> +    poking_addr =3D TASK_UNMAPPED_BASE;
> >>> +    if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> >>> +        poking_addr +=3D (kaslr_get_random_long("Poking") & PAGE_MAS=
K) %
> >>> +            (TASK_SIZE - TASK_UNMAPPED_BASE - 3 * PAGE_SIZE);
> >>> +
> >>> +    if (((poking_addr + PAGE_SIZE) & ~PMD_MASK) =3D=3D 0)
> >>> +        poking_addr +=3D PAGE_SIZE;
> >>
> >> Further thinking about it, I think that allocating the virtual address=
 for
> >> poking from user address-range is problematic. The user can set watchp=
oints
> >> on different addresses, cause some static-keys to be enabled/disabled,=
 and
> >> monitor the signals to derandomize the poking address.
> >
> > Hmm, I hadn=E2=80=99t thought about watchpoints. I=E2=80=99m not sure h=
ow much we care
> > about possible derandomization like this, but we certainly don=E2=80=99=
t want to
> > send signals or otherwise malfunction.
> >
> >> Andy, I think you were pushing this change. Can I go back to use a vma=
lloc=E2=80=99d
> >> address instead, or do you have a better solution?
> >
> > Hmm. If we use a vmalloc address, we have to make sure it=E2=80=99s not=
 actually
> > allocated. I suppose we could allocate one once at boot and use that. W=
e
> > also have the problem that the usual APIs for handling =E2=80=9Cuser=E2=
=80=9D addresses
> > might assume they=E2=80=99re actually in the user range, although this =
seems
> > unlikely to be a problem in practice. More seriously, though, the code
> > that manipulates per-mm paging structures assumes that *all* of the
> > structures up to the top level are per-mm, and, if we use anything less
> > than a private pgd, this isn=E2=80=99t the case.
>
> I forgot that I only had this conversation in my mind ;-)
>
> Well, I did write some code that kept some vmalloc=E2=80=99d area private=
, and it
> did require more synchronization between the pgd=E2=80=99s. It is still p=
ossible
> to use another top-level PGD, but =E2=80=A6 (continued below)
>
> >
> >> I prefer not to
> >> save/restore DR7, of course.
> >
> > I suspect we may want to use the temporary mm concept for EFI, too, so =
we
> > may want to just suck it up and save/restore DR7. But only if a watchpo=
int
> > is in use, of course. I have an old patch I could dust off that tracks =
DR7
> > to make things like this efficient.
>
> =E2=80=A6 but, if this is the case, then I will just make (un)use_tempora=
ry_mm() to
> save/restore DR7. I guess you are ok with such a solution. I will
> incorporate it into Rick=E2=80=99s v3.
>

I'm certainly amenable to other solutions, but this one does seem the
least messy.  I looked at my old patch, and it doesn't do what you
want.  I'd suggest you just add a percpu variable like cpu_dr7 and rig
up some accessors so that it stays up to date.  Then you can skip the
dr7 writes if there are no watchpoints set.

Also, EFI is probably a less interesting example than rare_write.
With rare_write, especially the dynamically allocated variants that
people keep coming up with, we'll need a swath of address space fully
as large as the vmalloc area. and getting *that* right while still
using the kernel address range might be more of a mess than we really
want to deal with.

--Andy
