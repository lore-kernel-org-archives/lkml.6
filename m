Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbeBFRsy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 12:48:54 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40975 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752612AbeBFRss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 12:48:48 -0500
X-Google-Smtp-Source: AH8x224/LCmKtLeEDHylR+dgTWo2Xwx4PmpXR4KW1Kbb3SOpXE72p2JIRUxsUjgoukNk8uihRcElw8CVpz+rl4NSx/4=
MIME-Version: 1.0
In-Reply-To: <1517935505-9321-1-git-send-email-dwmw@amazon.co.uk>
References: <1517935505-9321-1-git-send-email-dwmw@amazon.co.uk>
From: Konstantin Khlebnikov <koct9i@gmail.com>
Date: Tue, 6 Feb 2018 20:48:46 +0300
Message-ID: <CALYGNiOUZXiOeWSYMgeF3792NNWAgpcxnAOMQ_Wb-d1-Xo_k0Q@mail.gmail.com>
Subject: Re: [PATCH] mm: Always print RLIMIT_DATA warning
To: David Woodhouse <dwmw@amazon.co.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Vladimir Davydov <vdavydov@virtuozzo.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Kees Cook <keescook@google.com>, Willy Tarreau <w@1wt.eu>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Laura Abbott <labbott@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 6, 2018 at 7:45 PM, David Woodhouse <dwmw@amazon.co.uk> wrote:
> The documentation for ignore_rlimit_data says that it will print a warning
> at first misuse. Yet it doesn't seem to do that. Fix the code to print
> the warning even when we allow the process to continue.

Ack. But I think this was a misprint in docs.
Anyway, this knob is a kludge so we might warn once even if it is set.

So, somebody still have problems with this change?
I remember concerns about that "warn_once" isn't enough to detect
what's going wrong.
And probably we should invent  "warn_sometimes".

>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
> We should probably also do what Linus suggested in
> https://lkml.org/lkml/2016/9/16/585
>
>  mm/mmap.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 9efdc021..dd76ea3 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3184,13 +3184,15 @@ bool may_expand_vm(struct mm_struct *mm, vm_flags_t flags, unsigned long npages)
>                 if (rlimit(RLIMIT_DATA) == 0 &&
>                     mm->data_vm + npages <= rlimit_max(RLIMIT_DATA) >> PAGE_SHIFT)
>                         return true;
> -               if (!ignore_rlimit_data) {
> -                       pr_warn_once("%s (%d): VmData %lu exceed data ulimit %lu. Update limits or use boot option ignore_rlimit_data.\n",
> -                                    current->comm, current->pid,
> -                                    (mm->data_vm + npages) << PAGE_SHIFT,
> -                                    rlimit(RLIMIT_DATA));
> +
> +               pr_warn_once("%s (%d): VmData %lu exceed data ulimit %lu. Update limits%s.\n",
> +                            current->comm, current->pid,
> +                            (mm->data_vm + npages) << PAGE_SHIFT,
> +                            rlimit(RLIMIT_DATA),
> +                            ignore_rlimit_data ? "" : " or use boot option ignore_rlimit_data");
> +
> +               if (!ignore_rlimit_data)
>                         return false;
> -               }
>         }
>
>         return true;
> --
> 2.7.4
>
