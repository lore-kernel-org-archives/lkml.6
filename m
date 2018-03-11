Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932210AbeCKLaU (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 07:30:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41763 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932120AbeCKLaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 07:30:18 -0400
X-Google-Smtp-Source: AG47ELuLbuSrN4Ypbi57asv8JrHzl79fGn5UlyQGpQMdBlWZ9Ffl7pzuPh1kx9VJYScq1gHiNafMwQ==
From: Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Sun, 11 Mar 2018 12:30:15 +0100
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v1] devpts: resolve devpts bind-mounts
Message-ID: <20180311113013.GA21805@gmail.com>
References: <20180309105752.24017-1-christian.brauner@ubuntu.com>
 <CA+55aFyMHKSA4V7Y7qN5_F4R=hpD+W41FFYCE8b+FrFSeXQMtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFyMHKSA4V7Y7qN5_F4R=hpD+W41FFYCE8b+FrFSeXQMtQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 10:37:34AM -0800, Linus Torvalds wrote:
> Hmm. This hunk annoys me and makes me go "Whaa?":
> 
> On Fri, Mar 9, 2018 at 2:57 AM, Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> > @@ -163,6 +159,26 @@ struct vfsmount *devpts_mntget(struct file *filp, struct pts_fs_info *fsi)
> >
> >         path = filp->f_path;
> >         path_get(&path);
> > +       if ((DEVPTS_SB(path.mnt->mnt_sb) == fsi) &&
> > +           (path.mnt->mnt_root == fsi->ptmx_dentry)) {
> > +               /* Walk upward while the start point is a bind mount of a single
> > +                * file.
> > +                */
> > +               while (path.mnt->mnt_root == path.dentry)
> > +                       if (follow_up(&path) == 0)
> > +                               break;
> > +
> > +               /* Is this path a valid devpts filesystem? */
> > +               err = devpts_ptmx_path(&path);
> > +               dput(path.dentry);
> > +               if (err == 0)
> > +                       goto check_devpts_sb;
> > +
> > +               path_put(&path);
> > +               path = filp->f_path;
> > +               path_get(&path);
> > +               goto check_devpts_sb;
> > +       }
> >
> >         err = devpts_ptmx_path(&path);
> >         dput(path.dentry);
> 
> why did you duplicate the devpts_ptmx_path() and then do that odd
> error handling?
> 
> We only go into that "if()" statement if
> DEVPTS_SB(filp->f_path.mnt->mnt_sb) == fsi, so then when you do that
> "put path and re-get it, and go to check_devpts_sb", the
> check_devpts_sb won't actually _do_ anything, because it has
> 
> > +check_devpts_sb:
> >         if (DEVPTS_SB(path.mnt->mnt_sb) != fsi) {
> 
> and we know that "if()" there cannot trigger, since we just checked it earlier.
> 
> So abou two thirds of the above seems unnecessary.
> 
> Why isn't the code just doing
> 
> 
>        if ((DEVPTS_SB(path.mnt->mnt_sb) == fsi) &&
>            (path.mnt->mnt_root == fsi->ptmx_dentry)) {
>                /* Walk upward while the start point is a bind mount of a single
>                 * file.
>                 */
>                while (path.mnt->mnt_root == path.dentry)
>                        if (follow_up(&path) == 0)
>                                break;
>         }
> 
> and then just falling through to the existing "devpts_ptmx_path()" etc
> code? Duplicating it seems wrong, and the error handling in the
> duplicated path seems wrong too.
> 
> Am I missing something?

Right, the sb information can't be changed by follow_up() so we can
actually do it simpler. In the first iteration of the patch I wasn't
sure of that when I thought through the whole source pathname vs.
location on a different device mess for /dev, /dev/pts, and /dev/ptmx
being a bind-mount.

> 
> 
> > @@ -187,10 +206,16 @@ struct pts_fs_info *devpts_acquire(struct file *filp)
> >         path = filp->f_path;
> >         path_get(&path);
> >
> > -       err = devpts_ptmx_path(&path);
> > -       if (err) {
> > -               result = ERR_PTR(err);
> > -               goto out;
> > +       /* Has the devpts filesystem already been found? */
> > +       if (path.mnt->mnt_sb->s_magic != DEVPTS_SUPER_MAGIC) {
> > +               /* Is there an appropriate devpts filesystem in the parent
> > +                * directory?
> > +                */
> > +               err = devpts_ptmx_path(&path);
> > +               if (err) {
> > +                       result = ERR_PTR(err);
> > +                       goto out;
> > +               }
> >         }
> 
> This part (and the accompanying removal from devpts_ptmx_path() should
> just have been a separate preparatory patch that doesn't change
> semantics, no? Also, the scope of 'err' is now entirely inside that
> if(), so I think it should just be declared there too.

Yeah, I split this out into a non-functional change in the new version
of the patch.

Christian

> 
> I didn't actually test the patch, this is just from reading it, so I

> might have missed something.
