Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933981AbeCGQRu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:17:50 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59643 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933502AbeCGQRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:17:49 -0500
X-Google-Smtp-Source: AG47ELuRfcMVVquo/SZKPvoO2fl0A7ig4NohrnhzSWFcRrlW9Gk2kOvfKrAlvRj/yDZ9LEL/twx3jg==
From: Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Wed, 7 Mar 2018 17:17:45 +0100
To: linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        torvalds@linux-foundation.org
Subject: Invalid /proc/<pid>/fd/{0,1,2} symlinks with TIOCGPTPEER
Message-ID: <20180307161744.GA17562@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

We discovered a potential bug in the devpts implementation via
TIOCGPTPEER ioctl()s today. We've tackled a similar problem already in:

commit 311fc65c9fb9c966bca8e6f3ff8132ce57344ab9
Author: Eric W. Biederman <ebiederm@xmission.com>
Date:   Thu Aug 24 15:13:29 2017 -0500

    pty: Repair TIOCGPTPEER

Most libcs will *still* look at /dev/ptmx when opening the master fd of
pty device. Usually, /dev/ptmx will nowadays be either a symlink to
/dev/pts/ptmx or it will be a second device node with permissions 666
whereas /dev/pts/ptmx will usually have permissions 000. Afaik, we've
also always supported making /dev/ptmx a bind-mount to /dev/pts/ptmx or
at least I haven't observed any issues with this so far and it's
something fairly common in containers. So in short, it should be legal
to do:

mount --bind /dev/pts/ptmx /dev/ptmx
chmod 666 /dev/ptmx

However, for any libc implementation or program that uses TIOCGPTPEER
the /proc/<pid>/fd/{0,1,2} symlinks are broken (currently affects at
least glibc 2.27) with bind-mounts of /dev/pts/ptmx to /dev/ptmx. A
quick reproducer is:

unshare --mount
mount --bind /dev/pts/ptmx /dev/ptmx
chmod 666 /dev/ptmx
script
ls -al /proc/self/fd/0

Let's assume the slave device index I received was 5 then I would expect to
see:

ls -al /proc/self/fd/0
lrwx------ 1 chb chb 64 Mar  7 16:41 /proc/self/fd/0 -> /dev/pts/5

But what I actually see is:

ls -al /proc/self/fd/0
lrwx------ 1 chb chb 64 Mar  7 16:41 /proc/self/fd/0 -> /

I think the explanation for this is fairly straightforward. When
userspace does:

master = open("/dev/ptmx", O_RDWR | O_NOCTTY);
slave = ioctl(master, TIOCGPTPEER, O_RDWR | O_NOCTTY);

and /dev/ptmx is a bind-mount of /dev/pts/ptmx looking up the root mount
of the dentry for the slave it appears to the kernel as if the dentry is
escaping it's bind-mount:

├─/dev        udev          devtmpfs   rw,nosuid,relatime,size=4001260k,nr_inodes=1000315,mode=755
│ ├─/dev/pts  devpts        devpts     rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000
│ └─/dev/ptmx devpts[/ptmx] devpts     rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000

since the root mount of the dentry is /dev/pts but the root mount of
/dev/ptmx is /dev if I'm correct so similar to what Linus pointed out in
a previous discussion (see [1]) before. So we still record the "wrong"
vfsmount when /dev/ptmx is a bind-mount and then hit the problem when we
call devpts_mntget() in drivers/tty/pty.c.

So I thought about this and - in case my analysis is correct - the
solution didn't seem obvious to me as a bind-mount has no concept of
what it's "parent" is (Which in this case should be the devpts mount at
/dev/pts.).

Christian

[1]: https://lkml.org/lkml/2017/8/23/826
