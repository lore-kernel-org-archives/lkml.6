Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933187AbeD1AKK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 20:10:10 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46840 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933115AbeD1AKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 20:10:08 -0400
Date: Sat, 28 Apr 2018 01:10:03 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: NeilBrown <neilb@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: dcache: remove trylock loops (was Re: [BUG] lock_parent()
 breakage when used from shrink_dentry_list())
Message-ID: <20180428001003.GA14907@ZenIV.linux.org.uk>
References: <20180223150928.GC30522@ZenIV.linux.org.uk>
 <20180223174216.GD30522@ZenIV.linux.org.uk>
 <20180223201317.GG30522@ZenIV.linux.org.uk>
 <CA+55aFyP9JtyzUzA_S2sdKCK+8CZtNoA3UkXg5X4J0Hf2_ekjg@mail.gmail.com>
 <20180224002248.GH30522@ZenIV.linux.org.uk>
 <20180225073950.GI30522@ZenIV.linux.org.uk>
 <87bmgbnhar.fsf_-_@linutronix.de>
 <20180312191351.GN30522@ZenIV.linux.org.uk>
 <20180312200540.GO30522@ZenIV.linux.org.uk>
 <87o9jsdbho.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o9jsdbho.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 12:12:51PM +1100, NeilBrown wrote:

> >	     * selinux inode_doinit_with_dentry() (two call sites, very alike)
> 
> I'm less sure about this one, but I think it probably wants
> d_find_any_alias() as well.  Like cap_inode_getsecurity() it only wants
> a dentry so that it can pass something to __vfs_getxattr(),
> and that only wants a dentry so it can pass something to ->get.
> 
> Possibly we should rename d_find_alias() to d_find_hashed_alias() so that
> people need to make a conscious choice between d_find_hashed_alias() and
> d_find_any_alias() ??

FWIW, it *is* a bug; this
                        /*
                         * this is can be hit on boot when a file is accessed
                         * before the policy is loaded.  When we load policy we
                         * may find inodes that have no dentry on the
                         * sbsec->isec_head list.  No reason to complain as these
                         * will get fixed up the next time we go through
                         * inode_doinit with a dentry, before these inodes could
                         * be used again by userspace.
                         */
in selinux/hooks.c is flat-out wrong now.  Sure, if you first load selinux
policy after exporting something over NFS or letting attacker play with
open-by-fhandle, you are past any help, but still...

I disagree about going for d_find_any_alias() from the very beginning, BTW -
we need to try it in case of d_find_alias() failure, but sufficiently crappy
filesystem can bloody well fail to access xattrs via disconnected dentry.
