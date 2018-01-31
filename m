Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752799AbeAaVDr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 16:03:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:52882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751886AbeAaVDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 16:03:46 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B405E21799
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AH8x227ic3CDwV/MPlJ4TnlF96if/KEYDeJhu9+rSS5a2KTJF/dC8PU19chGY06dnmPi8dWzlWIBrJH2OWekrA+4mAs=
MIME-Version: 1.0
In-Reply-To: <20180131210039.18273-1-namit@vmware.com>
References: <20180131210039.18273-1-namit@vmware.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 31 Jan 2018 13:03:24 -0800
X-Gmail-Original-Message-ID: <CALCETrV+4Yri3hr5fSDSj7di+z3ZnBpQWQO7w7vfWVT+N_XrOg@mail.gmail.com>
Message-ID: <CALCETrV+4Yri3hr5fSDSj7di+z3ZnBpQWQO7w7vfWVT+N_XrOg@mail.gmail.com>
Subject: Re: [PATCH v2] x86: Align TLB invalidation info
To: Nadav Amit <namit@vmware.com>
Cc: X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 1:00 PM, Nadav Amit <namit@vmware.com> wrote:
> The TLB invalidation info is allocated on the stack, which might cause
> it to be unaligned. Since this information may be transferred to
> different cores for TLB shootdown, this might result in an additional
> cache-line bouncing between the cores.
>
> We do not use __cacheline_aligned() since it also defines the section,
> which is inappropriate for stack variables.
>
> Signed-off-by: Nadav Amit <namit@vmware.com>
>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>

Acked-by: Andy Lutomirski <luto@kernel.org>

This is basically free and adds no mess, so I think it's probably okay
even in the absence that it's a huge win.

But Dave is right, the commit message needs updating.  It will reduce
the number of cachelines that become shared and then get exclusively
owned by the originator from 2 to 1.  This isn't really "bouncing".

>
> --
> v1 -> v2: use __aligned instead of all the mess (Andy)
> ---
>  arch/x86/mm/tlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 5bfe61a5e8e3..9690112e3a82 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -576,7 +576,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
>  {
>         int cpu;
>
> -       struct flush_tlb_info info = {
> +       struct flush_tlb_info info __aligned(SMP_CACHE_BYTES) = {
>                 .mm = mm,
>         };
>
> --
> 2.14.1
>
