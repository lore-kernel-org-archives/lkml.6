Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932104AbeBVLkh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 06:40:37 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41298 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753640AbeBVLkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 06:40:20 -0500
X-Google-Smtp-Source: AH8x225w5Ef5tuQXeSedKxPESXdMPn8bLmdgJ3fXrR8vXAmGm5852BjBoDdny1fzFHgnfMkJMA+O2Zq/TFWN5dHeOqU=
MIME-Version: 1.0
In-Reply-To: <20180221202908.17258-4-ebiederm@xmission.com>
References: <878tbmf5vl.fsf@xmission.com> <20180221202908.17258-4-ebiederm@xmission.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Thu, 22 Feb 2018 12:40:18 +0100
Message-ID: <CAOssrKeNLBeMkMrrCeRBO9Z80zFxCCEygKL3DErnQ9xBoLkH0g@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] fuse: Ensure posix acls are translated outside of init_user_ns
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>, Dongsu Park <dongsu@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 9:29 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Ensure the translation happens by failing to read or write
> posix acls when the filesystem has not indicated it supports
> posix acls.

For the first iteration this is fine, but  we could convert the raw
xattrs as well, if we later want to, right?

Thanks,
Miklos

>
> This ensures that modern cached posix acl support is available
> and used when dealing with posix acls.  This is important
> because only that path has the code to convernt the uids and
> gids in posix acls into the user namespace of a fuse filesystem.
>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  fs/fuse/fuse_i.h |  1 +
>  fs/fuse/inode.c  |  7 +++++++
>  fs/fuse/xattr.c  | 43 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 51 insertions(+)
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 7772e2b4057e..986fa2b043ab 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -979,6 +979,7 @@ ssize_t fuse_listxattr(struct dentry *entry, char *list, size_t size);
>  int fuse_removexattr(struct inode *inode, const char *name);
>  extern const struct xattr_handler *fuse_xattr_handlers[];
>  extern const struct xattr_handler *fuse_acl_xattr_handlers[];
> +extern const struct xattr_handler *fuse_no_acl_xattr_handlers[];
>
>  struct posix_acl;
>  struct posix_acl *fuse_get_acl(struct inode *inode, int type);
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index e018dc3999f4..a52cf2019a58 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1097,6 +1097,13 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
>             file->f_cred->user_ns != sb->s_user_ns)
>                 goto err_fput;
>
> +       /*
> +        * If we are not in the initial user namespace posix
> +        * acls must be translated.
> +        */
> +       if (sb->s_user_ns != &init_user_ns)
> +               sb->s_xattr = fuse_no_acl_xattr_handlers;
> +
>         fc = kmalloc(sizeof(*fc), GFP_KERNEL);
>         err = -ENOMEM;
>         if (!fc)
> diff --git a/fs/fuse/xattr.c b/fs/fuse/xattr.c
> index 3caac46b08b0..433717640f78 100644
> --- a/fs/fuse/xattr.c
> +++ b/fs/fuse/xattr.c
> @@ -192,6 +192,26 @@ static int fuse_xattr_set(const struct xattr_handler *handler,
>         return fuse_setxattr(inode, name, value, size, flags);
>  }
>
> +static bool no_xattr_list(struct dentry *dentry)
> +{
> +       return false;
> +}
> +
> +static int no_xattr_get(const struct xattr_handler *handler,
> +                       struct dentry *dentry, struct inode *inode,
> +                       const char *name, void *value, size_t size)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static int no_xattr_set(const struct xattr_handler *handler,
> +                       struct dentry *dentry, struct inode *nodee,
> +                       const char *name, const void *value,
> +                       size_t size, int flags)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
>  static const struct xattr_handler fuse_xattr_handler = {
>         .prefix = "",
>         .get    = fuse_xattr_get,
> @@ -209,3 +229,26 @@ const struct xattr_handler *fuse_acl_xattr_handlers[] = {
>         &fuse_xattr_handler,
>         NULL
>  };
> +
> +static const struct xattr_handler fuse_no_acl_access_xattr_handler = {
> +       .name  = XATTR_NAME_POSIX_ACL_ACCESS,
> +       .flags = ACL_TYPE_ACCESS,
> +       .list  = no_xattr_list,
> +       .get   = no_xattr_get,
> +       .set   = no_xattr_set,
> +};
> +
> +static const struct xattr_handler fuse_no_acl_default_xattr_handler = {
> +       .name  = XATTR_NAME_POSIX_ACL_DEFAULT,
> +       .flags = ACL_TYPE_ACCESS,
> +       .list  = no_xattr_list,
> +       .get   = no_xattr_get,
> +       .set   = no_xattr_set,
> +};
> +
> +const struct xattr_handler *fuse_no_acl_xattr_handlers[] = {
> +       &fuse_no_acl_access_xattr_handler,
> +       &fuse_no_acl_default_xattr_handler,
> +       &fuse_xattr_handler,
> +       NULL
> +};
> --
> 2.14.1
>
