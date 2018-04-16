Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752941AbeDPRzQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 13:55:16 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:37852 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbeDPRzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 13:55:15 -0400
X-Google-Smtp-Source: AIpwx4+bDdYE052t9suT1BFMZ6RbBkJHmBlEhbWvaTbxavABxhnCDo5PdtwA28gW+82JqOp9mzK/APA8CiNEl1MJBug=
MIME-Version: 1.0
In-Reply-To: <20dd27aecaac4a158acecb9dbb5365327f0696ec.1521620371.git.rgb@redhat.com>
References: <cover.1521620371.git.rgb@redhat.com> <20dd27aecaac4a158acecb9dbb5365327f0696ec.1521620371.git.rgb@redhat.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 16 Apr 2018 10:55:13 -0700
X-Google-Sender-Auth: RwoaTwPosRn3jU1A3r-2z01SKak
Message-ID: <CAGXu5jJrCntv1fGLtVALyh5+UGdn5DvCkM230Vn7QGutY8k1og@mail.gmail.com>
Subject: Re: [PATCH ghak21 V4 1/2] audit: remove path param from link denied function
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Paul Moore <paul@paul-moore.com>, Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 1:42 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> In commit 45b578fe4c3cade6f4ca1fc934ce199afd857edc
> ("audit: link denied should not directly generate PATH record")
> the need for the struct path *link parameter was removed.
> Remove the now useless struct path argument.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  fs/namei.c            | 4 ++--
>  include/linux/audit.h | 6 ++----
>  kernel/audit.c        | 3 +--
>  3 files changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 9cc91fb..e3682bb 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -945,7 +945,7 @@ static inline int may_follow_link(struct nameidata *nd)
>         if (nd->flags & LOOKUP_RCU)
>                 return -ECHILD;
>
> -       audit_log_link_denied("follow_link", &nd->stack[0].link);
> +       audit_log_link_denied("follow_link");
>         return -EACCES;
>  }
>
> @@ -1011,7 +1011,7 @@ static int may_linkat(struct path *link)
>         if (safe_hardlink_source(inode) || inode_owner_or_capable(inode))
>                 return 0;
>
> -       audit_log_link_denied("linkat", link);
> +       audit_log_link_denied("linkat");
>         return -EPERM;
>  }

This removed the "link" details in both cases, and then commit
ea841bafda3f ("audit: add refused symlink to audit_names") added back
one of them:

> diff --git a/fs/namei.c b/fs/namei.c
> index e3682bb72cb5..5f8e8e2732e1 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -945,6 +945,7 @@ static inline int may_follow_link(struct nameidata *nd)
>         if (nd->flags & LOOKUP_RCU)
>                 return -ECHILD;
>
> +       audit_inode(nd->name, nd->stack[0].link.dentry, 0);
>         audit_log_link_denied("follow_link");
>         return -EACCES;
>  }

Why remove it in the first place, and why add it back open-coded in
only one place?

-Kees

-- 
Kees Cook
Pixel Security
