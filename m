Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbeCIShg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 13:37:36 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:41288 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbeCIShf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 13:37:35 -0500
X-Google-Smtp-Source: AG47ELtA9xq3EmXOY4yV6P1zJok2jcUfNnSE5+Jyh0Tqo4MxwZSNc00rHf3f2TbZZFLy4zDYarDUjLJh0BLNJHxTAUw=
MIME-Version: 1.0
In-Reply-To: <20180309105752.24017-1-christian.brauner@ubuntu.com>
References: <20180309105752.24017-1-christian.brauner@ubuntu.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 9 Mar 2018 10:37:34 -0800
X-Google-Sender-Auth: Rst8Xl6FrvyVe07JwnY19Uax9M0
Message-ID: <CA+55aFyMHKSA4V7Y7qN5_F4R=hpD+W41FFYCE8b+FrFSeXQMtQ@mail.gmail.com>
Subject: Re: [PATCH v1] devpts: resolve devpts bind-mounts
To: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm. This hunk annoys me and makes me go "Whaa?":

On Fri, Mar 9, 2018 at 2:57 AM, Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> @@ -163,6 +159,26 @@ struct vfsmount *devpts_mntget(struct file *filp, struct pts_fs_info *fsi)
>
>         path = filp->f_path;
>         path_get(&path);
> +       if ((DEVPTS_SB(path.mnt->mnt_sb) == fsi) &&
> +           (path.mnt->mnt_root == fsi->ptmx_dentry)) {
> +               /* Walk upward while the start point is a bind mount of a single
> +                * file.
> +                */
> +               while (path.mnt->mnt_root == path.dentry)
> +                       if (follow_up(&path) == 0)
> +                               break;
> +
> +               /* Is this path a valid devpts filesystem? */
> +               err = devpts_ptmx_path(&path);
> +               dput(path.dentry);
> +               if (err == 0)
> +                       goto check_devpts_sb;
> +
> +               path_put(&path);
> +               path = filp->f_path;
> +               path_get(&path);
> +               goto check_devpts_sb;
> +       }
>
>         err = devpts_ptmx_path(&path);
>         dput(path.dentry);

why did you duplicate the devpts_ptmx_path() and then do that odd
error handling?

We only go into that "if()" statement if
DEVPTS_SB(filp->f_path.mnt->mnt_sb) == fsi, so then when you do that
"put path and re-get it, and go to check_devpts_sb", the
check_devpts_sb won't actually _do_ anything, because it has

> +check_devpts_sb:
>         if (DEVPTS_SB(path.mnt->mnt_sb) != fsi) {

and we know that "if()" there cannot trigger, since we just checked it earlier.

So abou two thirds of the above seems unnecessary.

Why isn't the code just doing


       if ((DEVPTS_SB(path.mnt->mnt_sb) == fsi) &&
           (path.mnt->mnt_root == fsi->ptmx_dentry)) {
               /* Walk upward while the start point is a bind mount of a single
                * file.
                */
               while (path.mnt->mnt_root == path.dentry)
                       if (follow_up(&path) == 0)
                               break;
        }

and then just falling through to the existing "devpts_ptmx_path()" etc
code? Duplicating it seems wrong, and the error handling in the
duplicated path seems wrong too.

Am I missing something?


> @@ -187,10 +206,16 @@ struct pts_fs_info *devpts_acquire(struct file *filp)
>         path = filp->f_path;
>         path_get(&path);
>
> -       err = devpts_ptmx_path(&path);
> -       if (err) {
> -               result = ERR_PTR(err);
> -               goto out;
> +       /* Has the devpts filesystem already been found? */
> +       if (path.mnt->mnt_sb->s_magic != DEVPTS_SUPER_MAGIC) {
> +               /* Is there an appropriate devpts filesystem in the parent
> +                * directory?
> +                */
> +               err = devpts_ptmx_path(&path);
> +               if (err) {
> +                       result = ERR_PTR(err);
> +                       goto out;
> +               }
>         }

This part (and the accompanying removal from devpts_ptmx_path() should
just have been a separate preparatory patch that doesn't change
semantics, no? Also, the scope of 'err' is now entirely inside that
if(), so I think it should just be declared there too.

I didn't actually test the patch, this is just from reading it, so I
might have missed something.

                Linus
