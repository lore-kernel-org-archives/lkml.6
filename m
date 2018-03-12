Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751572AbeCLUFr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 16:05:47 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52822 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751333AbeCLUFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 16:05:46 -0400
Date: Mon, 12 Mar 2018 20:05:41 +0000
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
Message-ID: <20180312200540.GO30522@ZenIV.linux.org.uk>
References: <20180223040814.GA30522@ZenIV.linux.org.uk>
 <87h8q7erlo.fsf@linutronix.de>
 <20180223150928.GC30522@ZenIV.linux.org.uk>
 <20180223174216.GD30522@ZenIV.linux.org.uk>
 <20180223201317.GG30522@ZenIV.linux.org.uk>
 <CA+55aFyP9JtyzUzA_S2sdKCK+8CZtNoA3UkXg5X4J0Hf2_ekjg@mail.gmail.com>
 <20180224002248.GH30522@ZenIV.linux.org.uk>
 <20180225073950.GI30522@ZenIV.linux.org.uk>
 <87bmgbnhar.fsf_-_@linutronix.de>
 <20180312191351.GN30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312191351.GN30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 07:13:51PM +0000, Al Viro wrote:

> There's an unpleasant area around the ->s_root vs. NFS.  There's
> code that makes assumptions about ->s_root that are simply not true
> for NFS.  Is path_connected() correct wrt NFS multiple imports from
> the same server?  Ditto for mnt_already_visible() (that one might
> be mitigated at the moment, but probably won't last).  Eric, am
> I missing something subtle in there?

BTW, another thing spotted while trying to document the stuff:
Neil's "VFS: don't keep disconnected dentries on d_anon" has a subtle
side effect I hadn't spotted when applying.  Namely, for
DCACHE_DISCONNECTED non-directory IS_ROOT dentries we now have
d_unhashed() true.  That makes d_find_alias() logics around
discon_alias dead code:
                if (S_ISDIR(inode->i_mode) || !d_unhashed(alias)) {
                        if (IS_ROOT(alias) &&
                            (alias->d_flags & DCACHE_DISCONNECTED)) {
                                discon_alias = alias;
                        } else {
                                __dget_dlock(alias);
                                spin_unlock(&alias->d_lock);
                                return alias;
                        }
                }

Directory case is a red herring - we'll end up picking one and only
alias, whether it's IS_ROOT/disconnected or not.  For non-directories,
though, IS_ROOT and disconnected implies d_unhashed() now, so we might
as well turn that into
	if directory
		return d_find_any_alias
	else
		return the first hashed alias

Does any of the d_find_alias() callers want those dentries?  That is,
non-directories from d_obtain_alias() still not attached to a parent;
note that exportfs_decode_fh() is *not* one of such places - we don't
use d_find_alias() there at all.  If there's no such caller, we can
bloody well just drop the discon_alias logics and be done with that;
if there is, that commit has introduced a bug.  I might have missed
a part of threads related to that patch, so my apologies if it had
been discussed.

Neil, what's the situation there?  A lot of those callers clearly treat
the "only disconnected IS_ROOT alias exist" same as "no aliases at all";
it looks like the change might have been the right thing, but it sure
as hell shouldn't be an undocumented side effect...
