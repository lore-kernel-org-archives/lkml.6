Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935349AbeCHLW6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 06:22:58 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48586 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbeCHLW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 06:22:56 -0500
X-Google-Smtp-Source: AG47ELumjQVVyWglq799ZggnlvJX7os849sSuu/Ga5LQPnsVkEGSCfecc0074P78+xhCkOoBAOOvgQ==
From: Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Thu, 8 Mar 2018 12:22:49 +0100
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: Invalid /proc/<pid>/fd/{0,1,2} symlinks with TIOCGPTPEER
Message-ID: <20180308112248.GA5918@gmail.com>
References: <20180307161744.GA17562@gmail.com>
 <878tb3u1hv.fsf@xmission.com>
 <20180308082228.GD22728@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180308082228.GD22728@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 09:22:29AM +0100, Christian Brauner wrote:
> On Wed, Mar 07, 2018 at 01:30:52PM -0600, Eric W. Biederman wrote:
> > Christian Brauner <christian.brauner@canonical.com> writes:
> > 
> > > Hey,
> > >
> > > We discovered a potential bug in the devpts implementation via
> > > TIOCGPTPEER ioctl()s today. We've tackled a similar problem already in:
> > >
> > > commit 311fc65c9fb9c966bca8e6f3ff8132ce57344ab9
> > > Author: Eric W. Biederman <ebiederm@xmission.com>
> > > Date:   Thu Aug 24 15:13:29 2017 -0500
> > >
> > >     pty: Repair TIOCGPTPEER
> > >
> > > Most libcs will *still* look at /dev/ptmx when opening the master fd of
> > > pty device. Usually, /dev/ptmx will nowadays be either a symlink to
> > > /dev/pts/ptmx or it will be a second device node with permissions 666
> > > whereas /dev/pts/ptmx will usually have permissions 000. Afaik, we've
> > > also always supported making /dev/ptmx a bind-mount to /dev/pts/ptmx or
> > > at least I haven't observed any issues with this so far and it's
> > > something fairly common in containers. So in short, it should be legal
> > > to do:
> > >
> > > mount --bind /dev/pts/ptmx /dev/ptmx
> > > chmod 666 /dev/ptmx
> > >
> > > However, for any libc implementation or program that uses TIOCGPTPEER
> > > the /proc/<pid>/fd/{0,1,2} symlinks are broken (currently affects at
> > > least glibc 2.27) with bind-mounts of /dev/pts/ptmx to /dev/ptmx. A
> > > quick reproducer is:
> > >
> > > unshare --mount
> > > mount --bind /dev/pts/ptmx /dev/ptmx
> > > chmod 666 /dev/ptmx
> > > script
> > > ls -al /proc/self/fd/0
> > >
> > > Let's assume the slave device index I received was 5 then I would expect to
> > > see:
> > >
> > > ls -al /proc/self/fd/0
> > > lrwx------ 1 chb chb 64 Mar  7 16:41 /proc/self/fd/0 -> /dev/pts/5
> > >
> > > But what I actually see is:
> > >
> > > ls -al /proc/self/fd/0
> > > lrwx------ 1 chb chb 64 Mar  7 16:41 /proc/self/fd/0 -> /
> > >
> > > I think the explanation for this is fairly straightforward. When
> > > userspace does:
> > >
> > > master = open("/dev/ptmx", O_RDWR | O_NOCTTY);
> > > slave = ioctl(master, TIOCGPTPEER, O_RDWR | O_NOCTTY);
> > >
> > > and /dev/ptmx is a bind-mount of /dev/pts/ptmx looking up the root mount
> > > of the dentry for the slave it appears to the kernel as if the dentry is
> > > escaping it's bind-mount:
> > >
> > > ├─/dev        udev          devtmpfs   rw,nosuid,relatime,size=4001260k,nr_inodes=1000315,mode=755
> > > │ ├─/dev/pts  devpts        devpts     rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000
> > > │ └─/dev/ptmx devpts[/ptmx] devpts     rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000
> > >
> > > since the root mount of the dentry is /dev/pts but the root mount of
> > > /dev/ptmx is /dev if I'm correct so similar to what Linus pointed out in
> > > a previous discussion (see [1]) before. So we still record the "wrong"
> > > vfsmount when /dev/ptmx is a bind-mount and then hit the problem when we
> > > call devpts_mntget() in drivers/tty/pty.c.
> > 
> > I think your analysis of why we return / is correct. If the root of the
> > mount is a file (aka /dev/pts/ptmx).  Then any other file will on that
> > mount will not be under the root of the mount, and will be displayed
> > as '/'.  Because we have in fact escaped the root of the mount.
> > 
> > I think this is more of a quality of implementation issue more than a
> > bug per se.
> 
> It's at least a regression since this used to work before. :)
> 
> > 
> > > So I thought about this and - in case my analysis is correct - the
> > > solution didn't seem obvious to me as a bind-mount has no concept of
> > > what it's "parent" is (Which in this case should be the devpts mount at
> > > /dev/pts.).
> > 
> > We might be able to improve the quality of the implementation, by
> > noticing this case early (sb->s_root != mnt->mnt_root) and using the
> > same tricks on /dev/pts/ptmx as we do on /dev/ptmx.  That is looking
> > in ../pts and see if the filesystem we want is there.
> > 
> > It would be a wee bit tricky but doable.  The practical question becomes
> > what breaks and what makes it worth maintaining such a mechanism.
> > 
> > I don't remember how important it is to have a valid path in proc.  So
> > I won't comment on how important it is to improve the quality of
> > the implementation.
> 
> It's quite important for containers. The problem is that we can't (yet)
> mknod() in a user namespace and making /dev/ptmx a symlink to
> /dev/pts/ptmx will cause issues when used together with path-based LSMs
> like AppArmor so a bind-mount is the only reliable option.
> 
> > 
> > The code can be improved by doing something like:
> 
> Right, what do you think about Linus suggestion? I'm happy to look into
> it.

Ah you're pointing at a similar solution. Sorry, I missed it on the
first pass. I'll send a patch soon.

Christian

> 
> Christian
> 
> > 
> > static int devpts_ptmx_pts_path(struct path *path)
> > {
> > 	struct super_block *sb;
> > 	int err;
> > 
> > 	/* Is a devpts filesystem at "pts" in the same directory? */
> > 	err = path_pts(path);
> > 	if (err)
> > 		return err;
> > 
> > 	/* Is the path the root of a devpts filesystem? */
> > 	sb = path->mnt->mnt_sb;
> > 	if ((sb->s_magic != DEVPTS_SUPER_MAGIC) ||
> > 	    (path->mnt->mnt_root != sb->s_root))
> > 		return -ENODEV;
> > 
> > 	return 0;
> > }
> > 
> > ....
> > 	if ((DEVPTS_SB(path.mnt->mnt_sb) == fsi) &&
> > 	    (path.mnt->mnt_root == fsi->ptmx_dentry)) {
> > 		/* While the start point is a bind mount of single file
> >                  * walk upwards.
> >                  */
> >             	while ((path.mnt->mnt_root == path.dentry) && follow_up(&path))
> > 			;
> > 		if (devpts_ptmx_pts_path(&path) == 0) {
> >                 	dput(path.dentry);
> >                    	return path.mnt;     
> >                 }
> >                 /* No luck fall through to the old code */
> >                 path_put(path);
> >                 path = filp->f_path;
> >                 path_get(&path);
> >         }
> > 
> > The fall through vs fail would be a judgement on how important it is to
> > have a useable path in proc for TIOCPTPEER.
> > 
> > Eric
