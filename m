Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeBHX7A (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 18:59:00 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35508 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeBHX67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 18:58:59 -0500
X-Google-Smtp-Source: AH8x225uWD5Dd0RiH1zJ92B8U0YvDRp1zX8ADWaowlPsCMMpIamXVkxBCGYg5Hg5DTfO/2ZZYJMSe7vvo657840BxyQ=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <0b3961849e1fdcb10b95dd3ca0dc818e8997a8f5.1518002656.git.rgb@redhat.com>
References: <0b3961849e1fdcb10b95dd3ca0dc818e8997a8f5.1518002656.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 8 Feb 2018 18:58:56 -0500
Message-ID: <CAHC9VhRWq-iW4kKkhKLiORSVtDXyeWNLyGX1wcmT4LwuoDiDgw@mail.gmail.com>
Subject: Re: [PATCH] audit: deprecate the AUDIT_FILTER_ENTRY filter
To: Richard Guy Briggs <rgb@redhat.com>
Cc: linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 7, 2018 at 6:24 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> The audit entry filter has been long deprecated with userspace support
> finally removed in audit-v2.6.7 and plans to remove kernel support have
> existed since kernel-v2.6.31.
> Remove it.
>
> Passes audit-testsuite.
>
> See: https://github.com/linux-audit/audit-kernel/issues/6
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/auditfilter.c | 4 ++--
>  kernel/auditsc.c     | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index 4a1758a..1bbf5de 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -258,8 +258,8 @@ static inline struct audit_entry *audit_to_entry_common(struct audit_rule_data *
>                 goto exit_err;
>  #ifdef CONFIG_AUDITSYSCALL
>         case AUDIT_FILTER_ENTRY:
> -               if (rule->action == AUDIT_ALWAYS)
> -                       goto exit_err;
> +               pr_err("AUDIT_FILTER_ENTRY is deprecated\n");
> +               goto exit_err;
>         case AUDIT_FILTER_EXIT:
>         case AUDIT_FILTER_TASK:
>  #endif
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index e80459f..9348302 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1530,7 +1530,8 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
>         context->dummy = !audit_n_rules;
>         if (!context->dummy && state == AUDIT_BUILD_CONTEXT) {
>                 context->prio = 0;
> -               state = audit_filter_syscall(tsk, context, &audit_filter_list[AUDIT_FILTER_ENTRY]);
> +               if (auditd_test_task(tsk))
> +                       return;

Since we are removing the call to audit_filter_syscall() entirely -
which would appear to be the right thing - I wonder if it would be a
good idea to move the auditd_test_task() check earlier in the function
(fail early).  I'm thinking up where we check audit_enabled, before we
start populating context.

>         }
>         if (state == AUDIT_DISABLED)
>                 return;
> --
> 1.8.3.1
>
> --
> Linux-audit mailing list
> Linux-audit@redhat.com
> https://www.redhat.com/mailman/listinfo/linux-audit

-- 
paul moore
www.paul-moore.com
