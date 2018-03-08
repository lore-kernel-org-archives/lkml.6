Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934362AbeCHALX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 19:11:23 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36335 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932448AbeCHALV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 19:11:21 -0500
X-Google-Smtp-Source: AG47ELvTAUavJzErZBzjoJ7IuxFTVPUnMvKoosEhmhHY8a+0E7fIfZ6M7+f1heRYSl3vifRlrqGTl0YfsCKnyiwrJJQ=
MIME-Version: 1.0
In-Reply-To: <20180307033600.102115-1-gwendal@chromium.org>
References: <20180307033600.102115-1-gwendal@chromium.org>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Wed, 7 Mar 2018 16:11:00 -0800
X-Google-Sender-Auth: RbHraC69XIdsG4Ke9Jpkgsfl8m4
Message-ID: <CAMHSBOX0sP5vnFJ8uzsRxoHi=cP874FZazp8uJs3UN8wu73ipw@mail.gmail.com>
Subject: Re: [PATCH] configfs: initialize inode with owner
To: Joel Becker <jlbec@evilplan.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        sarthakkukreti@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is not correct: When listed with ls, configfs attributes
have the uid/gid of the user who list them, but looks wrong.

 I will test it more and repost.

Gwendal.

On Tue, Mar 6, 2018 at 7:36 PM, Gwendal Grignou <gwendal@chromium.org> wrote:
> From: Sarthak Kukreti <sarthakkukreti@chromium.org>
>
> Use standard helper to set inode owner when created from user space.
> This is a noop when the owner is root.
>
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  fs/configfs/configfs_internal.h |  5 ++++-
>  fs/configfs/inode.c             | 14 ++++++++------
>  fs/configfs/mount.c             |  2 +-
>  3 files changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
> index b65d1ef532d5..772fce1fd222 100644
> --- a/fs/configfs/configfs_internal.h
> +++ b/fs/configfs/configfs_internal.h
> @@ -68,7 +68,10 @@ extern struct kmem_cache *configfs_dir_cachep;
>
>  extern int configfs_is_root(struct config_item *item);
>
> -extern struct inode * configfs_new_inode(umode_t mode, struct configfs_dirent *, struct super_block *);
> +extern struct inode *configfs_new_inode(umode_t mode,
> +                                       struct configfs_dirent *sd,
> +                                       struct inode *p_inode,
> +                                       struct super_block *s);
>  extern int configfs_create(struct dentry *, umode_t mode, void (*init)(struct inode *));
>
>  extern int configfs_create_file(struct config_item *, const struct configfs_attribute *);
> diff --git a/fs/configfs/inode.c b/fs/configfs/inode.c
> index eae87575e681..93db05a2db1f 100644
> --- a/fs/configfs/inode.c
> +++ b/fs/configfs/inode.c
> @@ -108,9 +108,11 @@ int configfs_setattr(struct dentry * dentry, struct iattr * iattr)
>         return error;
>  }
>
> -static inline void set_default_inode_attr(struct inode * inode, umode_t mode)
> +static inline void set_default_inode_attr(struct inode *inode,
> +                                         struct inode *p_inode,
> +                                         umode_t mode)
>  {
> -       inode->i_mode = mode;
> +       inode_init_owner(inode, p_inode, mode);
>         inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
>  }
>
> @@ -125,7 +127,7 @@ static inline void set_inode_attr(struct inode * inode, struct iattr * iattr)
>  }
>
>  struct inode *configfs_new_inode(umode_t mode, struct configfs_dirent *sd,
> -                                struct super_block *s)
> +                                struct inode *p_inode, struct super_block *s)
>  {
>         struct inode * inode = new_inode(s);
>         if (inode) {
> @@ -140,7 +142,7 @@ struct inode *configfs_new_inode(umode_t mode, struct configfs_dirent *sd,
>                          */
>                         set_inode_attr(inode, sd->s_iattr);
>                 } else
> -                       set_default_inode_attr(inode, mode);
> +                       set_default_inode_attr(inode, p_inode, mode);
>         }
>         return inode;
>  }
> @@ -190,11 +192,11 @@ int configfs_create(struct dentry * dentry, umode_t mode, void (*init)(struct in
>                 return -EEXIST;
>
>         sd = dentry->d_fsdata;
> -       inode = configfs_new_inode(mode, sd, dentry->d_sb);
> +       p_inode = d_inode(dentry->d_parent);
> +       inode = configfs_new_inode(mode, sd, p_inode, dentry->d_sb);
>         if (!inode)
>                 return -ENOMEM;
>
> -       p_inode = d_inode(dentry->d_parent);
>         p_inode->i_mtime = p_inode->i_ctime = CURRENT_TIME;
>         configfs_set_inode_lock_class(sd, inode);
>
> diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
> index a8f3b589a2df..23aede27c502 100644
> --- a/fs/configfs/mount.c
> +++ b/fs/configfs/mount.c
> @@ -78,7 +78,7 @@ static int configfs_fill_super(struct super_block *sb, void *data, int silent)
>         sb->s_time_gran = 1;
>
>         inode = configfs_new_inode(S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO,
> -                                  &configfs_root, sb);
> +                                  &configfs_root, NULL, sb);
>         if (inode) {
>                 inode->i_op = &configfs_root_inode_operations;
>                 inode->i_fop = &configfs_dir_operations;
> --
> 2.16.2.660.g709887971b-goog
>
