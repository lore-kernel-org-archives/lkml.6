Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751597AbeCTDnS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 23:43:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750968AbeCTDnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 23:43:16 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 943C02178C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELuXKQbU5NdWlPlVPvFOnwc4wYvVPvzJQgPqAHb7FdRT5H4vfVzJHNup/zMkrV2aA1Dq7LOzvzrdF7UIJP2dqvM=
MIME-Version: 1.0
In-Reply-To: <20180319143154.3742-1-boris.ostrovsky@oracle.com>
References: <20180319143154.3742-1-boris.ostrovsky@oracle.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 20 Mar 2018 03:42:54 +0000
X-Gmail-Original-Message-ID: <CALCETrXNm4H2kq76yM1Cc2+LEqimrrG2eY8BagNpii-JEaSP9Q@mail.gmail.com>
Message-ID: <CALCETrXNm4H2kq76yM1Cc2+LEqimrrG2eY8BagNpii-JEaSP9Q@mail.gmail.com>
Subject: Re: [PATCH] x86/vsyscall/64: Use proper accessor to update p4d entry
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andrew Lutomirski <luto@kernel.org>,
        X86 ML <x86@kernel.org>, Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 2:31 PM, Boris Ostrovsky
<boris.ostrovsky@oracle.com> wrote:
> Writing to it directly does not work for Xen PV guests.

Whoops, my bad.

Acked-by: Andy Lutomirski <luto@kernel.org>

>
> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> ---
>  arch/x86/entry/vsyscall/vsyscall_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
> index 8560ef68a9d6..317be365bce3 100644
> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> @@ -347,7 +347,7 @@ void __init set_vsyscall_pgtable_user_bits(pgd_t *root)
>         set_pgd(pgd, __pgd(pgd_val(*pgd) | _PAGE_USER));
>         p4d = p4d_offset(pgd, VSYSCALL_ADDR);
>  #if CONFIG_PGTABLE_LEVELS >= 5
> -       p4d->p4d |= _PAGE_USER;
> +       set_p4d(p4d, __p4d(p4d_val(*p4d) | _PAGE_USER));
>  #endif
>         pud = pud_offset(p4d, VSYSCALL_ADDR);
>         set_pud(pud, __pud(pud_val(*pud) | _PAGE_USER));
> --
> 2.14.3
>
