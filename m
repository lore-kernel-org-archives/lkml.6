Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750960AbeBPXFw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 18:05:52 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:57381 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbeBPXFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 18:05:51 -0500
From: John Ogness <john.ogness@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] fs/dcache: Avoid the try_lock loops in dentry_kill()
References: <20180216150933.971-1-john.ogness@linutronix.de>
        <20180216150933.971-5-john.ogness@linutronix.de>
        <CA+55aFyo6jrvU62DiwKJZaTnmwLYQe4krNJCbAUui8R+=bDVdQ@mail.gmail.com>
        <87y3js36s7.fsf@linutronix.de>
        <CA+55aFxku7bB9BEBrqgREc5ac4MK9CGLir1c7ZA-7bjp-Q2tAg@mail.gmail.com>
Date: Sat, 17 Feb 2018 00:05:35 +0100
In-Reply-To: <CA+55aFxku7bB9BEBrqgREc5ac4MK9CGLir1c7ZA-7bjp-Q2tAg@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 16 Feb 2018 14:42:36 -0800")
Message-ID: <87r2pk358g.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-16, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> lock_parent() already has the problem you are referring to. Callers
>> are required to recheck the dentry contents and check the returned
>> parent because they do not know if the trylock succeeded. See
>> d_prune_aliases(), for example.
>
> What are you talking about?
>
> lock_parent() does the nice "spin_trylock succeeded" special case.
>
> Yes, it will then do the "unlock dentry, do the parent first, then
> re-check" too, and callers may need to worry about it.
>
> But that's not what I'm complaining about in your patch. You remove
> the simple case, and make dentry_kill() do the "recheck in case I
> dropped" every single time.

dentry_lock_inode() uses the same semantics as lock_parent(). The caller
does not know if the trylock succeeded. Any caller using lock_parent()
must "recheck in case I dropped", just as with dentry_lock_inode(). This
is what you have pointed out.

> The fact that there are _other_ complex cases doesn't make it any
> better. The whole "but Bobby does it too" thing is not a defense.
> Would you jump off a bridge just because your friend did it?

dentry_kill() calls both dentry_lock_inode() and lock_parent() in the
common case. So by changing the semantics of lock_parent(), I am
removing two "recheck in case I dropped" in the common case rather than
just the one you pointed out.

John Ogness
