Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932469AbeCLTN6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 15:13:58 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51044 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751473AbeCLTN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 15:13:56 -0400
Date: Mon, 12 Mar 2018 19:13:51 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: John Ogness <john.ogness@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: dcache: remove trylock loops (was Re: [BUG] lock_parent()
 breakage when used from shrink_dentry_list())
Message-ID: <20180312191351.GN30522@ZenIV.linux.org.uk>
References: <20180223035814.GZ30522@ZenIV.linux.org.uk>
 <20180223040814.GA30522@ZenIV.linux.org.uk>
 <87h8q7erlo.fsf@linutronix.de>
 <20180223150928.GC30522@ZenIV.linux.org.uk>
 <20180223174216.GD30522@ZenIV.linux.org.uk>
 <20180223201317.GG30522@ZenIV.linux.org.uk>
 <CA+55aFyP9JtyzUzA_S2sdKCK+8CZtNoA3UkXg5X4J0Hf2_ekjg@mail.gmail.com>
 <20180224002248.GH30522@ZenIV.linux.org.uk>
 <20180225073950.GI30522@ZenIV.linux.org.uk>
 <87bmgbnhar.fsf_-_@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bmgbnhar.fsf_-_@linutronix.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 06:16:28AM +0100, John Ogness wrote:

> If someone else has grabbed a reference, it shouldn't be added to the
> lru list. Only decremented.
> 
> if (entry->d_lockref.count == 1)

Nah, better handle that in retain_dentry() itself.  See updated
#work.dcache.

Note: another potentially fun thing in that branch is that I've
finally decided to bite the bullet and make __d_move() preserve
->d_parent of target.

Mainline:
al@sonny:/tmp$ touch d
al@sonny:/tmp$ sleep 100 >/tmp/a/b/c &
[1] 16487
al@sonny:/tmp$ ls -l /proc/16487/fd
total 0
lrwx------ 1 al al 64 Mar 12 11:33 0 -> /dev/pts/13
l-wx------ 1 al al 64 Mar 12 11:33 1 -> /tmp/a/b/c
lrwx------ 1 al al 64 Mar 12 11:33 2 -> /dev/pts/13
al@sonny:/tmp$ mv /tmp/d /tmp/a/b/c 
al@sonny:/tmp$ ls -l /proc/16487/fd
total 0
lrwx------ 1 al al 64 Mar 12 11:33 0 -> /dev/pts/13
l-wx------ 1 al al 64 Mar 12 11:33 1 -> /tmp/c (deleted)
lrwx------ 1 al al 64 Mar 12 11:33 2 -> /dev/pts/13

With that branch:
root@kvm1:/tmp# touch d
root@kvm1:/tmp# sleep 100 >/tmp/a/b/c &
[1] 2263
root@kvm1:/tmp# ls -l /proc/2263/fd
total 0
lrwx------ 1 root root 64 Mar 12 11:33 0 -> /dev/pts/0
l-wx------ 1 root root 64 Mar 12 11:33 1 -> /tmp/a/b/c
lrwx------ 1 root root 64 Mar 12 11:33 2 -> /dev/pts/0
root@kvm1:/tmp# mv /tmp/d /tmp/a/b/c
root@kvm1:/tmp# ls -l /proc/2263/fd
total 0
lrwx------ 1 root root 64 Mar 12 11:33 0 -> /dev/pts/0
l-wx------ 1 root root 64 Mar 12 11:33 1 -> '/tmp/a/b/c (deleted)'
lrwx------ 1 root root 64 Mar 12 11:33 2 -> /dev/pts/0

It doesn't come quite for free; cross-directory d_move()
and d_exchange() callers are responsible for having both
parents pinned (all of them do that, mostly since the usual
sequence is "look parents up, lock_rename(), *then* look
children up, then do renaming"; those that are not part of
rename(2) are also OK) and d_splice_alias() has become potentially
blocking in one case.  AFAICS, none of the callers is in
locking environment that would not allow that.  Survives
the local beating and doesn't seem to cause any performance
regressions.

What we get out of that is
	a) much saner semantics for d_move() et.al.
	b) saner behaviour of d_path() (see above)
	c) dentry can be IS_ROOT only if it has been
such all along; that simplifies the hell out of analysis.

FWIW, there's another trylock loop on dentries - one in
autofs get_next_positive_dentry().  Any plans re dealing
with that one?

I'd spent the last couple of weeks (when not being too sick
for any work) going through dcache.c and related code; hopefully
this time I will get the documentation into postable shape ;-/

There's an unpleasant area around the ->s_root vs. NFS.  There's
code that makes assumptions about ->s_root that are simply not true
for NFS.  Is path_connected() correct wrt NFS multiple imports from
the same server?  Ditto for mnt_already_visible() (that one might
be mitigated at the moment, but probably won't last).  Eric, am
I missing something subtle in there?
