Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753660AbeBGJVe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 04:21:34 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:39059 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753291AbeBGJVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 04:21:31 -0500
X-Google-Smtp-Source: AH8x225ucMBz/B2q/hHPie3etRiPaMTGOSxMfow/4NuCVOd6p3AdVF2GjxTdPxLR7aq2RL0hpqHvFwjye8dVIM5rdHQ=
MIME-Version: 1.0
X-Originating-IP: [176.63.54.97]
In-Reply-To: <86832c6adb256f29f44b6229222b80964fc8cfcc.1517314847.git.dongsu@kinvolk.io>
References: <cover.1517314847.git.dongsu@kinvolk.io> <86832c6adb256f29f44b6229222b80964fc8cfcc.1517314847.git.dongsu@kinvolk.io>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 7 Feb 2018 10:21:29 +0100
Message-ID: <CAJfpegtVz=Y2yxkq26S4zp76suWFy4DsLqqDOrUCuc+VQJ=VVw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/2] fuse: introduce new fs_type flag FS_IMA_NO_CACHE
To: Dongsu Park <dongsu@kinvolk.io>
Cc: linux-kernel@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Alban Crequy <alban@kinvolk.io>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Seth Forshee <seth.forshee@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 7:06 PM, Dongsu Park <dongsu@kinvolk.io> wrote:
> From: Alban Crequy <alban@kinvolk.io>
>
> This new fs_type flag FS_IMA_NO_CACHE means files should be re-measured,
> re-appraised and re-audited each time. Cached integrity results should
> not be used.
>
> It is useful in FUSE because the userspace FUSE process can change the
> underlying files at any time without notifying the kernel.
>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-integrity@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: Christoph Hellwig <hch@infradead.org>
> Acked-by: "Serge E. Hallyn" <serge@hallyn.com>
> Acked-by: Seth Forshee <seth.forshee@canonical.com>
> Tested-by: Dongsu Park <dongsu@kinvolk.io>
> Signed-off-by: Alban Crequy <alban@kinvolk.io>
> ---
>  fs/fuse/inode.c    | 2 +-
>  include/linux/fs.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 624f18bb..0a9e5164 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1205,7 +1205,7 @@ static void fuse_kill_sb_anon(struct super_block *sb)
>  static struct file_system_type fuse_fs_type = {
>         .owner          = THIS_MODULE,
>         .name           = "fuse",
> -       .fs_flags       = FS_HAS_SUBTYPE,
> +       .fs_flags       = FS_HAS_SUBTYPE | FS_IMA_NO_CACHE,
>         .mount          = fuse_mount,
>         .kill_sb        = fuse_kill_sb_anon,
>  };
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 511fbaab..ced841ba 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2075,6 +2075,7 @@ struct file_system_type {
>  #define FS_BINARY_MOUNTDATA    2
>  #define FS_HAS_SUBTYPE         4
>  #define FS_USERNS_MOUNT                8       /* Can be mounted by userns root */
> +#define FS_IMA_NO_CACHE                16      /* Force IMA to re-measure, re-appraise, re-audit files */

I think it would be more logical to change the order of the patches
(i.e. first patch adds this constant and the code handling it, and
second patch just adds it to fuse's .fs_flags).

Otherwise

Acked-by:   Miklos Szeredi <mszeredi@redhat.com>

Thanks,
Miklos


>  #define FS_RENAME_DOES_D_MOVE  32768   /* FS will handle d_move() during rename() internally. */
>         struct dentry *(*mount) (struct file_system_type *, int,
>                        const char *, void *);
> --
> 2.13.6
>
