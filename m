Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeCLOHM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:07:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59796 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752018AbeCLOHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:07:09 -0400
X-Google-Smtp-Source: AG47ELuqFPX3Kl5QkFYhvc5WGUWVVFjQSo/XrSRuON5GlbfeaxGWHBNI7NB40bH+BNcobN4NRHg3iA==
Date: Mon, 12 Mar 2018 15:07:06 +0100
From: Christian Brauner <christian.brauner@canonical.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 0/3 v2] devpts: handle /dev/ptmx bind-mounts
Message-ID: <20180312140704.GA2836@gmail.com>
References: <20180311210537.3674-1-christian.brauner@ubuntu.com>
 <CA+55aFxH0O4tXtOux0kajrhCHGo0NcUT1jTvT-O0prfsegyp_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFxH0O4tXtOux0kajrhCHGo0NcUT1jTvT-O0prfsegyp_A@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 11, 2018 at 02:46:26PM -0700, Linus Torvalds wrote:
> On Sun, Mar 11, 2018 at 2:05 PM, Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > This is the second iteration of this patch.
> 
> This looks good to me. Just wondering how this should be merged, and
> whether we should have a Cc: stable for it?
> 
> .. and, just in case, maybe Al can verify that there's nothing subtle
> about follow_up() that we need to worry about. That said, NFS already

Right, sorry I forgot to CC him again after the first version of the
patch.

> has that exact same loop for follow_to_parent(), just syntactically
> slightly different version.

Once we got devpts worked out I can send a follow-up patch that adds a
helper to namei.c that walks up bind-mounts. Seems it would make sense
as I can see this being useful in general. To be honest, before this I
had no real concept what resolving a bind-mount inside the kernel means
which was why I was worried to just bang out a patch without discussing
it first. Anyway, that should be a small follow-up.

> 
> In fact, I wonder if we even need to do that
> 
>         if ((DEVPTS_SB(path.mnt->mnt_sb) == fsi) &&
>             (path.mnt->mnt_root == fsi->ptmx_dentry)) {
> 
> and maybe we could do the follow_up() loop unconditionally?
> 
> Because if the ptmx dentry is *not* a bind mount, then the loop will
> be a no-op, and if it *is* a bind-mount, then I'm not convinced we
> should even try to just limit it to the devpts case - maybe somebody
> did a bind-mount on just a legacy ptmx device node?

Hm, I think we want to keep the condition and the reasoning points to a
snag in the current patch I think:
So in case that e.g. /dev/ptmx or /some/other/place is indeed a
bind-mount of a devpts mounted somewhere else we want to give userspace
a chance and check whether we find a suitable "pts" directory in the
same directory where the bind-mount is. This ensures that the paths in
/proc/<pid>/fd/<nr> are correct and that operations like
readlink("/proc/<pid>/fd/<nr>", buf, sizeof(buf))
chown(buf, 0, 0)
are actually sane and don't suddenly chown() / instead of
/<devpts>/<idx>. This also let's us easily support libcs still going
through /dev/ptmx instead of /dev/pts/ptmx [1].
But in case the passed in path is not a bind-mount we actually don't
want to call devpts_ptmx_path() without the

/* Has the devpts filesystem already been found? */
if (path->mnt->mnt_sb->s_magic != DEVPTS_SUPER_MAGIC)

check being performed because if (path->mnt->mnt_sb->s_magic == DEVPTS_SUPER_MAGIC)
holds and we still call path_pts() it will try to look for a "pts" mount
in the parent directory but there's no requirement that I know of for a
devpts to only be mounted at /dev/pts or /<somewhere>/pts. This means
that the current logic would cause us to e.g. break stuff like
mount -t devpts devpts /wherever which we shouldn't do. (That's a
discussion we had in the previous round of devpts fixes.) So I think we
actually want devpts_mntget() to do:

struct vfsmount *devpts_mntget(struct file *filp, struct pts_fs_info *fsi)
{
	bool unwind;
	struct path path;
	int err = 0;

	path = filp->f_path;
	path_get(&path);

	unwind = (DEVPTS_SB(path.mnt->mnt_sb) == fsi) &&
		 (path.mnt->mnt_root == fsi->ptmx_dentry);
	/* Walk upward while the start point is a bind mount of
	 * a single file.
	 */
	while (path.mnt->mnt_root == path.dentry && unwind)
		if (follow_up(&path) == 0)
			break;

	if ((path.mnt->mnt_sb->s_magic != DEVPTS_SUPER_MAGIC) || unwind)
		err = devpts_ptmx_path(&path);
	dput(path.dentry);
	if (err) {
		mntput(path.mnt);
		return ERR_PTR(err);
	}

	if (DEVPTS_SB(path.mnt->mnt_sb) != fsi) {
		mntput(path.mnt);
		return ERR_PTR(-ENODEV);
	}

	return path.mnt;
}

Does that look sane?

I'll send a new version of the patch today and will add an additional
test for devpts being mounted at a different location.

Christian

> 
> So that "if()" actually seems to be to be superfluous, and only limit
> the "follow bind mounts' case unnecessarily. Hmm?
