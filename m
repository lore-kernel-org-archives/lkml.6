Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751268AbeCIAuI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 19:50:08 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:43764 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750885AbeCIAuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 19:50:07 -0500
X-Google-Smtp-Source: AG47ELtw59X/l743jcExiUPrT/lKHMzu+jYfWpqXXWI9G+qeXpAb9IsEhtkC12q7LMUWvr6VjRgEYlEYLciFCD1ykB0=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <1c5184985e422774329484153b0147c2861e91a7.1518603831.git.rgb@redhat.com>
References: <cover.1518603831.git.rgb@redhat.com> <1c5184985e422774329484153b0147c2861e91a7.1518603831.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 8 Mar 2018 19:50:05 -0500
Message-ID: <CAHC9VhQAiQdCeayzYY5Nr0rqJu0q0AbbM2ovqAe7hYNZGOwyxA@mail.gmail.com>
Subject: Re: [RFC PATCH ghak21 4/4] audit: add parent of refused symlink to audit_names
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 11:18 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Audit link denied events for symlinks were missing the parent PATH
> record.  Add it.  Since the full pathname may not be available,
> reconstruct it from the path in the nameidata supplied.
>
> See: https://github.com/linux-audit/audit-kernel/issues/21
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  fs/namei.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 0edf133..bf1c046b 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -923,6 +923,7 @@ static inline int may_follow_link(struct nameidata *nd)
>         const struct inode *inode;
>         const struct inode *parent;
>         kuid_t puid;
> +       char *pathname;
>
>         if (!sysctl_protected_symlinks)
>                 return 0;
> @@ -945,6 +946,14 @@ static inline int may_follow_link(struct nameidata *nd)
>         if (nd->flags & LOOKUP_RCU)
>                 return -ECHILD;
>
> +       pathname = kmalloc(PATH_MAX + 1, GFP_KERNEL);
> +       if (!pathname)
> +               return -ENOMEM;

Two things here:

1. We need to allocate a buffer to feed to d_absolute_path(), and
getname_kernel() is just going to make another copy so we need to make
sure we clean up after ourselves.  Perhaps I missing it, but I'm not
seeing where we free the kmalloc'd buffer or call putname().  Feel
free to correct me if I'm missing something obvious.

2. While the audit_* calls are going to bail early in the cases where
audit is disabled, or not configured, we are going to pay the penalty
for the kmalloc() call above, as well as the getname_kernel() and
d_absolute_path() calls below.  I think it might be beneficial to
create a new function (audit_log_symlink_denied() perhaps?) which
encapsulates all the audit bits in may_follow_link() and exits early
when needed.  What do you think?

(Point #2 is why I didn't merge patch 3/4, just include it in this
revised patch)

> +       audit_inode(getname_kernel(d_absolute_path(&nd->stack[0].link, pathname,
> +                                                  PATH_MAX + 1)),
> +                   nd->stack[0].link.dentry, 0);
> +       audit_inode(nd->name, nd->stack[0].link.dentry->d_parent, LOOKUP_PARENT);
> +
>         audit_inode(nd->name, nd->stack[0].link.dentry, 0);
>         audit_log_link_denied("follow_link", &nd->stack[0].link);
>
>         return -EACCES;
> --
> 1.8.3.1

-- 
paul moore
www.paul-moore.com
