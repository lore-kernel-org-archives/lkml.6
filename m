Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031214AbeBNVJq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 16:09:46 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37971 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030501AbeBNVJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 16:09:44 -0500
X-Google-Smtp-Source: AH8x2275rQkdXkwcFeKtK7TxEL/NlaSDpUhnvtMqbYM1GNGwFO6Xj8EjOEtGgS4kKtL78wChgoMbO5R6w/iZpGUhK5E=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <fc8dc7d245b6962d330eeedea544d7e4fd56e78c.1518230355.git.rgb@redhat.com>
References: <cover.1518230355.git.rgb@redhat.com> <fc8dc7d245b6962d330eeedea544d7e4fd56e78c.1518230355.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 14 Feb 2018 16:09:42 -0500
Message-ID: <CAHC9VhT1B8bEu5w+U+oYFQbR8m7upk8x3o8qbQ7ZPa9ijE21uA@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] audit: bail ASAP on syscall entry
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 9, 2018 at 9:40 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Since removing the audit entry filter, test for early return before
> setting up any context state.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/auditsc.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Sigh.

First off, thanks for making the changes, I think the end result of
1/3+2/3 is better than the v1 patch.

However, this really didn't need to be two patches, please combine 1/3
and 2/3 and resubmit.  I know I've done the patch squashing for you in
the past, but I think it's time to start pushing some of this work
back to you.

Moving forward, if I provide feedback and do not explicitly suggest
creating a new patch, please incorporate the changes into the existing
patches.

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 9348302..bc534bf 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1519,23 +1519,23 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
>         if (!audit_enabled)
>                 return;
>
> -       context->arch       = syscall_get_arch();
> -       context->major      = major;
> -       context->argv[0]    = a1;
> -       context->argv[1]    = a2;
> -       context->argv[2]    = a3;
> -       context->argv[3]    = a4;
> -
>         state = context->state;
> +       if (state == AUDIT_DISABLED)
> +               return;
> +
>         context->dummy = !audit_n_rules;
>         if (!context->dummy && state == AUDIT_BUILD_CONTEXT) {
>                 context->prio = 0;
>                 if (auditd_test_task(tsk))
>                         return;
>         }
> -       if (state == AUDIT_DISABLED)
> -               return;
>
> +       context->arch       = syscall_get_arch();
> +       context->major      = major;
> +       context->argv[0]    = a1;
> +       context->argv[1]    = a2;
> +       context->argv[2]    = a3;
> +       context->argv[3]    = a4;
>         context->serial     = 0;
>         context->ctime = current_kernel_time64();
>         context->in_syscall = 1;
> --
> 1.8.3.1
>



-- 
paul moore
www.paul-moore.com
