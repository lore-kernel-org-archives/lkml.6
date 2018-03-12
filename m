Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932313AbeCLUdu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 16:33:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53934 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932222AbeCLUdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 16:33:49 -0400
Date: Mon, 12 Mar 2018 20:33:46 +0000
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
Message-ID: <20180312203346.GP30522@ZenIV.linux.org.uk>
References: <87h8q7erlo.fsf@linutronix.de>
 <20180223150928.GC30522@ZenIV.linux.org.uk>
 <20180223174216.GD30522@ZenIV.linux.org.uk>
 <20180223201317.GG30522@ZenIV.linux.org.uk>
 <CA+55aFyP9JtyzUzA_S2sdKCK+8CZtNoA3UkXg5X4J0Hf2_ekjg@mail.gmail.com>
 <20180224002248.GH30522@ZenIV.linux.org.uk>
 <20180225073950.GI30522@ZenIV.linux.org.uk>
 <87bmgbnhar.fsf_-_@linutronix.de>
 <20180312191351.GN30522@ZenIV.linux.org.uk>
 <20180312200540.GO30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312200540.GO30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 08:05:41PM +0000, Al Viro wrote:

> Does any of the d_find_alias() callers want those dentries?  That is,
> non-directories from d_obtain_alias() still not attached to a parent;
> note that exportfs_decode_fh() is *not* one of such places - we don't
> use d_find_alias() there at all.  If there's no such caller, we can
> bloody well just drop the discon_alias logics and be done with that;
> if there is, that commit has introduced a bug.  I might have missed
> a part of threads related to that patch, so my apologies if it had
> been discussed.
> 
> Neil, what's the situation there?  A lot of those callers clearly treat
> the "only disconnected IS_ROOT alias exist" same as "no aliases at all";
> it looks like the change might have been the right thing, but it sure
> as hell shouldn't be an undocumented side effect...

FWIW, callers are
drivers/staging/lustre/lustre/llite/llite_lib.c:2448:           dentry = d_find_alias(page->mapping->host);
	definitely doesn't want them
fs/ceph/caps.c:2945:    while ((dn = d_find_alias(inode))) {
fs/ceph/mds_client.c:1930:      dentry = d_find_alias(inode);
	ditto - it's building a pathname.
fs/ceph/mds_client.c:2910:      dentry = d_find_alias(inode);
	ditto.
fs/ceph/mds_client.c:3374:      parent = d_find_alias(inode);
	clearly at least expects a directory (feeds to d_lookup(), etc.)
fs/coda/cache.c:112:    alias_de = d_find_alias(inode);
	directory-only
fs/fat/namei_vfat.c:736:        alias = d_find_alias(inode);
	we will reject any IS_ROOT there anyway
fs/fs-writeback.c:2071:         dentry = d_find_alias(inode);
	wants a name, these don't have one.
fs/fuse/dir.c:966:      dir = d_find_alias(parent);
	directory-only
fs/hostfs/hostfs_kern.c:129:    dentry = d_find_alias(ino);
	wants a pathname
fs/nilfs2/super.c:931:          dentry = d_find_alias(inode);
	directory-only
fs/nilfs2/super.c:1025:                 dentry = d_find_alias(inode);
	bloody better be a directory (root one, at that)
fs/xfs/xfs_filestream.c:293:    dentry = d_find_alias(inode);
	no parent, no love.
mm/shmem.c:3435:                dentry = d_find_alias(inode);
	no d_obtain_alias() on that one
security/commoncap.c:391:       dentry = d_find_alias(inode);
security/lsm_audit.c:295:               dentry = d_find_alias(inode);
	wants a name
security/selinux/hooks.c:1536:                  dentry = d_find_alias(inode);
security/selinux/hooks.c:1646:                          dentry = d_find_alias(inode);

So all but four of them clearly do *not* want those suckers.  And remaining
ones are in
	* ceph invalidate_aliases()
	* cap_inode_getsecurity()
	* selinux inode_doinit_with_dentry() (two call sites, very alike)
Do any of those want that stuff?
