Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030469AbeBNNoi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:44:38 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36807 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030395AbeBNNof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:44:35 -0500
X-Google-Smtp-Source: AH8x225G3pc3RsMN31fGcD3XZ3skI109uLOcAPmS1WHALeKKVU6IJxRS7KNS5z5j9oY/A52B+RHYtWkIS/sswPqtueM=
MIME-Version: 1.0
In-Reply-To: <a26103156b3f6ba73b1e46c6f577f1bee74872d9.1512041070.git.dongsu@kinvolk.io>
References: <cover.1512741134.git.dongsu@kinvolk.io> <a26103156b3f6ba73b1e46c6f577f1bee74872d9.1512041070.git.dongsu@kinvolk.io>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Wed, 14 Feb 2018 14:44:34 +0100
Message-ID: <CAOssrKcHOp9OaCWRALsxe5MTk+tv7Gi5rPsHz2VLguzK-P+LMw@mail.gmail.com>
Subject: Re: [PATCH 10/11] fuse: Allow user namespace mounts
To: Dongsu Park <dongsu@kinvolk.io>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Alban Crequy <alban@kinvolk.io>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2017 at 3:32 PM, Dongsu Park <dongsu@kinvolk.io> wrote:
> From: Seth Forshee <seth.forshee@canonical.com>
>
> To be able to mount fuse from non-init user namespaces, it's necessary
> to set FS_USERNS_MOUNT flag to fs_flags.
>
> Patch v4 is available: https://patchwork.kernel.org/patch/8944681/
>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> [dongsu: add a simple commit messasge]
> Signed-off-by: Dongsu Park <dongsu@kinvolk.io>
> ---
>  fs/fuse/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 7f6b2e55..8c98edee 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1212,7 +1212,7 @@ static void fuse_kill_sb_anon(struct super_block *sb)
>  static struct file_system_type fuse_fs_type = {
>         .owner          = THIS_MODULE,
>         .name           = "fuse",
> -       .fs_flags       = FS_HAS_SUBTYPE,
> +       .fs_flags       = FS_HAS_SUBTYPE | FS_USERNS_MOUNT,
>         .mount          = fuse_mount,
>         .kill_sb        = fuse_kill_sb_anon,
>  };

I think enabling FS_USERNS_MOUNT should be pretty safe.

I was thinking opting out should be as simple as "chmod o-rw
/dev/fuse".  But that breaks libfuse, even though fusermount opens
/dev/fuse in privileged mode, so it shouldn't.  That can be fixed in
libfuse, but it's an unfortunate bug and it also means /dev/fuse is
configured with "crw-rw-rw-" in most cases.  Which means it will be
opting out, not opting in, which is the less safe version.

> @@ -1244,7 +1244,7 @@ static struct file_system_type fuseblk_fs_type = {
>         .name           = "fuseblk",
>         .mount          = fuse_mount_blk,
>         .kill_sb        = fuse_kill_sb_blk,
> -       .fs_flags       = FS_REQUIRES_DEV | FS_HAS_SUBTYPE,
> +       .fs_flags       = FS_REQUIRES_DEV | FS_HAS_SUBTYPE | FS_USERNS_MOUNT,
>  };
>  MODULE_ALIAS_FS("fuseblk");

As I said, this hunk should be dropped from the first version, because
it's possibly unsafe.

Thanks,
Miklos
