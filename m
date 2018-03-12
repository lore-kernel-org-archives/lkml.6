Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932316AbeCLUjV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 16:39:21 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54092 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932171AbeCLUjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 16:39:19 -0400
Date: Mon, 12 Mar 2018 20:39:17 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dcache: remove trylock loops (was Re: [BUG] lock_parent()
 breakage when used from shrink_dentry_list())
Message-ID: <20180312203916.GQ30522@ZenIV.linux.org.uk>
References: <87h8q7erlo.fsf@linutronix.de>
 <20180223150928.GC30522@ZenIV.linux.org.uk>
 <20180223174216.GD30522@ZenIV.linux.org.uk>
 <20180223201317.GG30522@ZenIV.linux.org.uk>
 <CA+55aFyP9JtyzUzA_S2sdKCK+8CZtNoA3UkXg5X4J0Hf2_ekjg@mail.gmail.com>
 <20180224002248.GH30522@ZenIV.linux.org.uk>
 <20180225073950.GI30522@ZenIV.linux.org.uk>
 <87bmgbnhar.fsf_-_@linutronix.de>
 <20180312191351.GN30522@ZenIV.linux.org.uk>
 <877eqhcab3.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877eqhcab3.fsf@xmission.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 03:23:44PM -0500, Eric W. Biederman wrote:

> Of the two code paths you are concert about:
> 
> For path path_connected looking at s_root is a heuristic to avoid
> calling is_subdir every time we need to do that check.  If the heuristic
> fails we still have is_subdir which should remain accurate.  If
> is_subdir fails the path is genuinely not connected at that moment
> and failing is the correct thing to do.
 
Umm...  That might be not good enough - the logics is "everything's
reachable from ->s_root anyway, so we might as well not bother checking".
For NFS it's simply not true.

We can mount server:/foo/bar/baz on /tmp/a, then server:/foo on /tmp/b
and we'll have ->s_root pointing to a subtree of what's reachable at
/tmp/b.  Play with renames under /tmp/b and you just might end up with
a problem.  And mount on /tmp/a will be (mistakenly) considered to
be safe, since it satisfies the heuristics in path_connected().
