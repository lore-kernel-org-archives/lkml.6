Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752908AbeCOWey (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 18:34:54 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52284 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752404AbeCOWew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 18:34:52 -0400
Date: Thu, 15 Mar 2018 22:34:45 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs: Teach path_connected to handle nfs filesystems with
 multiple roots.
Message-ID: <20180315223444.GA30522@ZenIV.linux.org.uk>
References: <20180225073950.GI30522@ZenIV.linux.org.uk>
 <87bmgbnhar.fsf_-_@linutronix.de>
 <20180312191351.GN30522@ZenIV.linux.org.uk>
 <877eqhcab3.fsf@xmission.com>
 <20180312203916.GQ30522@ZenIV.linux.org.uk>
 <87woygan6p.fsf@xmission.com>
 <87tvtk97i8.fsf@xmission.com>
 <20180313003751.GT30522@ZenIV.linux.org.uk>
 <20180313005010.GV30522@ZenIV.linux.org.uk>
 <87muzai6rm.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87muzai6rm.fsf_-_@xmission.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 06:20:29PM -0500, Eric W. Biederman wrote:
> 
> On nfsv2 and nfsv3 the nfs server can export subsets of the same
> filesystem and report the same filesystem identifier, so that the nfs
> client can know they are the same filesystem.  The subsets can be from
> disjoint directory trees.  The nfsv2 and nfsv3 filesystems provides no
> way to find the common root of all directory trees exported form the
> server with the same filesystem identifier.
> 
> The practical result is that in struct super s_root for nfs s_root is
> not necessarily the root of the filesystem.  The nfs mount code sets
> s_root to the root of the first subset of the nfs filesystem that the
> kernel mounts.
> 
> This effects the dcache invalidation code in generic_shutdown_super
> currently called shrunk_dcache_for_umount and that code for years
> has gone through an additional list of dentries that might be dentry
> trees that need to be freed to accomodate nfs.
> 
> When I wrote path_connected I did not realize nfs was so special, and
> it's hueristic for avoiding calling is_subdir can fail.
> 
> The practical case where this fails is when there is a move of a
> directory from the subtree exposed by one nfs mount to the subtree
> exposed by another nfs mount.  This move can happen either locally or
> remotely.  With the remote case requiring that the move directory be cached
> before the move and that after the move someone walks the path
> to where the move directory now exists and in so doing causes the
> already cached directory to be moved in the dcache through the magic
> of d_splice_alias.
> 
> If someone whose working directory is in the move directory or a
> subdirectory and now starts calling .. from the initial mount of nfs
> (where s_root == mnt_root), then path_connected as a heuristic will
> not bother with the is_subdir check.  As s_root really is not the root
> of the nfs filesystem this heuristic is wrong, and the path may
> actually not be connected and path_connected can fail.
> 
> The is_subdir function might be cheap enough that we can call it
> unconditionally.  Verifying that will take some benchmarking and
> the result may not be the same on all kernels this fix needs
> to be backported to.  So I am avoiding that for now.
> 
> Filesystems with snapshots such as nilfs and btrfs do something
> similar.  But as the directory tree of the snapshots are disjoint
> from one another and from the main directory tree rename won't move
> things between them and this problem will not occur.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
> Fixes: 397d425dc26d ("vfs: Test for and handle paths that are unreachable from their mnt_root")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
> 
> Al do you want to push this one to Linus or shall I?

Applied; I think there might be a helper lurking in there, but for now
that'll do.
