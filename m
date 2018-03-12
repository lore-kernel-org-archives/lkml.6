Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751596AbeCLPFQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:05:16 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38062 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbeCLPFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:05:15 -0400
X-Google-Smtp-Source: AG47ELvnEZWrJsvRl+M5SMjXkyDg5DkKwMSn1xSf5qSHPBuMxixkAmguLVhIhrG3YxqCf+tePZvtrQ3VadqFjw2YiB4=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <9ed76ccb239078ad5a2808d23c7b7f1738b0b2b8.1520835596.git.rgb@redhat.com>
References: <cover.1520835596.git.rgb@redhat.com> <9ed76ccb239078ad5a2808d23c7b7f1738b0b2b8.1520835596.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 12 Mar 2018 11:05:12 -0400
Message-ID: <CAHC9VhRDnd55em1YUkswOX4XmDP6xH5x005hcZnCZSRXz66exQ@mail.gmail.com>
Subject: Re: [PATCH ghak21 V2 2/4] audit: link denied should not directly
 generate PATH record
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 2:31 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Audit link denied events generate duplicate PATH records which disagree
> in different ways from symlink and hardlink denials.
> audit_log_link_denied() should not directly generate PATH records.
> While we're at it, remove the now useless struct path argument.
>
> See: https://github.com/linux-audit/audit-kernel/issues/21
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  fs/namei.c            |  2 +-
>  include/linux/audit.h |  6 ++----
>  kernel/audit.c        | 17 ++---------------
>  3 files changed, 5 insertions(+), 20 deletions(-)

I have no objection to the v2 change of removing the link parameter,
but this patch can not be merged as-is because the v1 patch has
already been merged into audit/next (as stated on the mailing list).
You need to respin this patch against audit/next and redo the
subject/description to indicate that you are just removing the unused
link parameter in this updated patch.

> diff --git a/fs/namei.c b/fs/namei.c
> index 9cc91fb..50d2533 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1011,7 +1011,7 @@ static int may_linkat(struct path *link)
>         if (safe_hardlink_source(inode) || inode_owner_or_capable(inode))
>                 return 0;
>
> -       audit_log_link_denied("linkat", link);
> +       audit_log_link_denied("linkat");
>         return -EPERM;
>  }
>
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index af410d9..75d5b03 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -146,8 +146,7 @@ extern void             audit_log_d_path(struct audit_buffer *ab,
>                                              const struct path *path);
>  extern void                audit_log_key(struct audit_buffer *ab,
>                                           char *key);
> -extern void                audit_log_link_denied(const char *operation,
> -                                                 const struct path *link);
> +extern void                audit_log_link_denied(const char *operation);
>  extern void                audit_log_lost(const char *message);
>
>  extern int audit_log_task_context(struct audit_buffer *ab);
> @@ -194,8 +193,7 @@ static inline void audit_log_d_path(struct audit_buffer *ab,
>  { }
>  static inline void audit_log_key(struct audit_buffer *ab, char *key)
>  { }
> -static inline void audit_log_link_denied(const char *string,
> -                                        const struct path *link)
> +static inline void audit_log_link_denied(const char *string)
>  { }
>  static inline int audit_log_task_context(struct audit_buffer *ab)
>  {
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 7026d69..e54deaf 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2301,36 +2301,23 @@ void audit_log_task_info(struct audit_buffer *ab, struct task_struct *tsk)
>  /**
>   * audit_log_link_denied - report a link restriction denial
>   * @operation: specific link operation
> - * @link: the path that triggered the restriction
>   */
> -void audit_log_link_denied(const char *operation, const struct path *link)
> +void audit_log_link_denied(const char *operation)
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
