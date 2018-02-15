Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165173AbeBOXeh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 18:34:37 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41089 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163785AbeBOXef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 18:34:35 -0500
X-Google-Smtp-Source: AH8x224FbBCM0b7qLTILY+D8C/Mf+nb6A2X2GRafIojkzyUHGE+Gl+tdvJTlqqUWdmDSg+UUJYM0+V57iawaIZRRJjI=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <1c5184985e422774329484153b0147c2861e91a7.1518603831.git.rgb@redhat.com>
References: <cover.1518603831.git.rgb@redhat.com> <1c5184985e422774329484153b0147c2861e91a7.1518603831.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 15 Feb 2018 18:34:33 -0500
Message-ID: <CAHC9VhR3u0n9ZSLHYcf0aJR=X=PLkSFPnYffz+=5v669QyasHg@mail.gmail.com>
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
> +       audit_inode(getname_kernel(d_absolute_path(&nd->stack[0].link, pathname,
> +                                                  PATH_MAX + 1)),
> +                   nd->stack[0].link.dentry, 0);

Hmm, it's been a while since I've looked at the audit vfs/inode code,
but isn't the audit_inode() call directly above effectively a
duplicate of the audit_inode(nd->name, nd->stack[0].link.dentry, 0)
call you added in patch 3/4?

> +       audit_inode(nd->name, nd->stack[0].link.dentry->d_parent, LOOKUP_PARENT);
> +
>         audit_inode(nd->name, nd->stack[0].link.dentry, 0);
>         audit_log_link_denied("follow_link", &nd->stack[0].link);
>         return -EACCES;
> --
> 1.8.3.1

-- 
paul moore
www.paul-moore.com
