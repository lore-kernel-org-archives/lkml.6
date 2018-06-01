Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751131AbeFABw6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 21:52:58 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:55874 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbeFABw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 21:52:57 -0400
Date: Fri, 1 Jun 2018 02:52:55 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/32] vfs: Make close() unmount the attached mount if so
 flagged [ver #8]
Message-ID: <20180601015255.GP30522@ZenIV.linux.org.uk>
References: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
 <152720685405.9073.17445116582570028610.stgit@warthog.procyon.org.uk>
 <20180531191955.GG30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531191955.GG30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 08:19:55PM +0100, Al Viro wrote:
> On Fri, May 25, 2018 at 01:07:34AM +0100, David Howells wrote:
> > +	if (unlikely(file->f_mode & FMODE_NEED_UNMOUNT))
> > +		__detach_mounts(dentry);
> > +
> 
> This is completely wrong.  First of all, you want to dissolve the mount tree
> on file->f_path.mount, not every tree rooted at dentry equal to file->f_path.dentry.
> This is easily done - it would be a simple call of drop_collected_mounts(mnt)
> if not for one detail.  You want it to happen only if the sucker isn't attached
> anywhere by that point.  IOW,
>         namespace_lock();
>         lock_mount_hash();
> 	if (!real_mount(mnt)->mnt_ns)
> 		umount_tree(real_mount(mnt), UMOUNT_SYNC);
>         unlock_mount_hash();
>         namespace_unlock();
> and that's it.  You don't need that magical mystery turd in move_mount() later
> in the series and all the infrastructure you grow for it.
> 
> FWIW, I would've suggested this
>  void drop_collected_mounts(struct vfsmount *mnt)
>  {
>  	namespace_lock();
>  	lock_mount_hash();
> +	if (!real_mount(mnt)->mnt_ns)
> +		umount_tree(real_mount(mnt), UMOUNT_SYNC);
> -	umount_tree(real_mount(mnt), UMOUNT_SYNC);
>  	unlock_mount_hash();
>  	namespace_unlock();
>  }
> 
> and in __fput()
> 	if (unlikely(file->f_mode & FMODE_NEED_UNMOUNT))
> 		drop_collected_mounts(mnt);
> 
> All there is to it, AFAICS...

... except that it should be a separate primitive - drop_collected_mounts() is
used put_mnt_ns(), where the root definitely has non-NULL ->mnt_ns.

Another thing: the same issue (misuse of __detach_mounts()) exists in cleanup
path of do_o_path().  What's more, doing it there is pointless - if
do_dentry_open() has set FMODE_NEED_UNMOUNT, it either succeeds or calls fput()
itself.  Either way, the caller should *not* do the cleanups done by fput().

Another thing: copy_mount_for_o_path() is bogus.  Horrible calling conventions
aside, what the hell is that lock_mount() for?  In do_loopback() we lock the
*mountpoint*; here the source gets locked, for no visible reason.  What we
should do is something like this:

1) common helper -

static struct mount *__do_loopback(struct path *from, bool recurse)
{
        struct mount *mnt = ERR_PTR(-EINVAL), *f = real_mount(from->mnt); 

        if (IS_MNT_UNBINDABLE(f))
                return mnt;

        if (!check_mnt(f) && from->dentry->d_op != &ns_dentry_operations)
                return mnt;

        if (!recurse && has_locked_children(f, from->dentry))
                return mnt;

        if (recurse)
                mnt = copy_tree(f, from->dentry, CL_COPY_MNT_NS_FILE);
        else
                mnt = clone_mnt(f, from->dentry, 0);
        if (!IS_ERR(mnt))
		mnt->mnt.mnt_flags &= ~MNT_LOCKED;
	return mnt;
}

2) in do_loopback() we are left with

static int do_loopback(struct path *path, const char *old_name,
                                int recurse)
{
        struct path old_path;
        struct mount *mnt, *parent;
        struct mountpoint *mp;
        int err;
        if (!old_name || !*old_name)
                return -EINVAL;
        err = kern_path(old_name, LOOKUP_FOLLOW|LOOKUP_AUTOMOUNT, &old_path);
        if (err)
                return err;

        err = -EINVAL;
        if (mnt_ns_loop(old_path.dentry))
                goto out;

        mp = lock_mount(path);
        if (IS_ERR(mp)) {
		err = PTR_ERR(mp);
                goto out;
	}

        parent = real_mount(path->mnt);
        if (!check_mnt(parent))
                goto out2;

	mnt = __do_loopback(&old_path, recurse);
        if (IS_ERR(mnt)) {
                err = PTR_ERR(mnt);
                goto out2;
        }

        err = graft_tree(mnt, parent, mp);
        if (err) {
                lock_mount_hash();
                umount_tree(mnt, UMOUNT_SYNC);
                unlock_mount_hash();
        }
out2:
        unlock_mount(mp);
out:
        path_put(&old_path);
        return err;
}

3) copy_mount_for_o_path() with saner calling conventions:

int copy_mount_for_o_path(struct path *path, bool recurse)
{
        struct mount *mnt = __do_loopback(path, recurse);
        if (IS_ERR(mnt)) {
		path_put(path);
                return PTR_ERR(mnt);
	}
	mntput(path->mnt);
        path->mnt = &mnt->mnt;
        return 0;
}

4) in do_o_path():
static int do_o_path(struct nameidata *nd, unsigned flags, struct file *file)
{
        struct path path;
        int error = path_lookupat(nd, flags, &path);
        if (error)
                return error;

        if (file->f_flags & O_CLONE_MOUNT) {
                error = copy_mount_for_o_path(&path,
				!(file->f_flags & O_NON_RECURSIVE));
                if (error < 0)
                        return error;
        }

        audit_inode(nd->name, path.dentry, 0);
        error = vfs_open(&path, file, current_cred());
        path_put(&path);
        return error;
}
