Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751227AbeCIA0x (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 19:26:53 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37962 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeCIA0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 19:26:52 -0500
X-Google-Smtp-Source: AG47ELvJYCqKrEa/GULl+ICS8lUjPWjaXKv/fw7pCnriLL+qbzUJU3U2Mv27zohsmwj7KojlDXKcFHVRzHqQiix7A+k=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <f48d5d1f1e429e2dee817ae723f9a02a67ed1f3b.1518603831.git.rgb@redhat.com>
References: <cover.1518603831.git.rgb@redhat.com> <f48d5d1f1e429e2dee817ae723f9a02a67ed1f3b.1518603831.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 8 Mar 2018 19:26:49 -0500
Message-ID: <CAHC9VhTYqJ5v1MTqch624PS8d8YkgeEK4tEY5cUcgXgD8ofU1A@mail.gmail.com>
Subject: Re: [RFC PATCH ghak21 2/4] audit: link denied should not directly
 generate PATH record
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 11:18 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Audit link denied events generate duplicate PATH records which disagree
> in different ways from symlink and hardlink denials.
> audit_log_link_denied() should not directly generate PATH records.
>
> See: https://github.com/linux-audit/audit-kernel/issues/21
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/audit.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)

Merged, thanks.

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 4c3fd24..683b249 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2259,31 +2259,19 @@ void audit_log_task_info(struct audit_buffer *ab, struct task_struct *tsk)
>  void audit_log_link_denied(const char *operation, const struct path *link)
>  {
>         struct audit_buffer *ab;
> -       struct audit_names *name;
>
>         if (!audit_enabled || audit_dummy_context())
>                 return;
>
> -       name = kzalloc(sizeof(*name), GFP_NOFS);
> -       if (!name)
> -               return;
> -
>         /* Generate AUDIT_ANOM_LINK with subject, operation, outcome. */
>         ab = audit_log_start(current->audit_context, GFP_KERNEL,
>                              AUDIT_ANOM_LINK);
>         if (!ab)
> -               goto out;
> +               return;
>         audit_log_format(ab, "op=%s", operation);
>         audit_log_task_info(ab, current);
>         audit_log_format(ab, " res=0");
>         audit_log_end(ab);
> -
> -       /* Generate AUDIT_PATH record with object. */
> -       name->type = AUDIT_TYPE_NORMAL;
> -       audit_copy_inode(name, link->dentry, d_backing_inode(link->dentry));
> -       audit_log_name(current->audit_context, name, link, 0, NULL);
> -out:
> -       kfree(name);
>  }
>
>  /**
> --
> 1.8.3.1
>



-- 
paul moore
www.paul-moore.com
