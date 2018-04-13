Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754090AbeDMIZ3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 04:25:29 -0400
Received: from mail-yb0-f174.google.com ([209.85.213.174]:45489 "EHLO
        mail-yb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753001AbeDMIZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 04:25:24 -0400
X-Google-Smtp-Source: AIpwx48Y9BaKUZ2mZlm5qJbc8G78fb/NZo16TJsbx8r4ZBVZX+Llgmm1yRT6C2U3bv+fW+d8D+h0+spNWQyRkHmWLuM=
MIME-Version: 1.0
In-Reply-To: <20180412150826.20988-5-mszeredi@redhat.com>
References: <20180412150826.20988-1-mszeredi@redhat.com> <20180412150826.20988-5-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 13 Apr 2018 11:25:23 +0300
Message-ID: <CAOQ4uxg0+CJaskEVQdGr6+KkWwDvgzdNsrNt1oocnL6VxsDEFA@mail.gmail.com>
Subject: Re: [RFC PATCH 04/35] ovl: copy up times
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 6:07 PM, Miklos Szeredi <mszeredi@redhat.com> wrote:
> Copy up mtime and ctime to overlay inode after times in real object are
> modified.  Be careful not to dirty cachelines when not necessary.
>
> This is in preparation for moving overlay functionality out of the VFS.
>
> This patch shouldn't have any observable effect.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/overlayfs/dir.c       |  5 +++++
>  fs/overlayfs/inode.c     |  1 +
>  fs/overlayfs/overlayfs.h |  7 +++++++
>  fs/overlayfs/util.c      | 19 +++++++++++++++++++
>  4 files changed, 32 insertions(+)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 839709c7803a..cd0fa2363723 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -507,6 +507,7 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
>                 else
>                         err = ovl_create_over_whiteout(dentry, inode, attr,
>                                                         hardlink);
> +               ovl_copytimes_with_parent(dentry);
>         }
>  out_revert_creds:
>         revert_creds(old_cred);
> @@ -768,6 +769,7 @@ static int ovl_do_remove(struct dentry *dentry, bool is_dir)
>                         drop_nlink(dentry->d_inode);
>         }
>         ovl_nlink_end(dentry, locked);
> +       ovl_copytimes_with_parent(dentry);
>  out_drop_write:
>         ovl_drop_write(dentry);
>  out:
> @@ -1079,6 +1081,9 @@ static int ovl_rename(struct inode *olddir, struct dentry *old,
>         ovl_dentry_version_inc(new->d_parent, ovl_type_origin(old) ||
>                                (d_inode(new) && ovl_type_origin(new)));
>
> +       ovl_copytimes_with_parent(old);
> +       ovl_copytimes_with_parent(new);
> +

All the ovl_copytimes_with_parent() calls you added can be replaced with a
single call in ovl_dentry_version_inc(). Just need to change its name and
pass it the child instead of the parent dentry.

Thanks,
Amir.
