Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161795AbeBOTyN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 14:54:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:54894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161559AbeBOTx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 14:53:58 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96EE8217C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AH8x225inG1JNm6PDzqcGm0fQd2693AHTDlovAkRyjA5lSrT7OGUz1LI9Ma82+mCXVdV7TTJlZ9LdeTkBXiQBOvYxz8=
MIME-Version: 1.0
In-Reply-To: <20180215163602.61162-6-namit@vmware.com>
References: <20180215163602.61162-1-namit@vmware.com> <20180215163602.61162-6-namit@vmware.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 15 Feb 2018 19:53:36 +0000
X-Gmail-Original-Message-ID: <CALCETrX+F5apPenXGBf9oAc+aJieQYDA81zigPk6q6q6pa_i5A@mail.gmail.com>
Message-ID: <CALCETrX+F5apPenXGBf9oAc+aJieQYDA81zigPk6q6q6pa_i5A@mail.gmail.com>
Subject: Re: [PATCH RFC v2 5/6] x86: Use global pages when PTI is disabled
To: Nadav Amit <namit@vmware.com>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, Willy Tarreau <w@1wt.eu>,
        Nadav Amit <nadav.amit@gmail.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 4:36 PM, Nadav Amit <namit@vmware.com> wrote:
> As long as PTI is disabled, it is possible to use global pages, as long
> as we remove them once PTI is enabled again. To do so, return the global
> bit to __supported_pte_mask and disable global pages using CR4.
>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  arch/x86/include/asm/tlbflush.h |  6 ++++++
>  arch/x86/mm/init.c              | 14 ++++++--------
>  arch/x86/mm/tlb.c               |  3 ++-
>  3 files changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
> index ea65cf951c49..3a44cb0a9f56 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -319,6 +319,12 @@ static inline void set_cpu_pti_disable(unsigned short disable)
>         WARN_ON_ONCE(preemptible());
>
>         pti_update_user_cs64(cpu_pti_disable(), disable);
> +       if (__supported_pte_mask & _PAGE_GLOBAL) {
> +               if (disable)
> +                       cr4_set_bits(X86_CR4_PGE);
> +               else
> +                       cr4_clear_bits(X86_CR4_PGE);
> +       }

This will be *extremely* slow, and I don't see the point at all.  What
are you accomplishing here?

At best, you might gain something by adjusting the page table entries
to get globalness back, but I see no reason to fiddle with CR4.  Also,
if you do any of this at all and you run on K8, you're at risk of
getting machine checks unless you're very careful to get the
invalidation right.

I would just drop this patch, personally.
