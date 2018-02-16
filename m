Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162699AbeBPSDT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 13:03:19 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:42922 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162511AbeBPSDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 13:03:17 -0500
X-Google-Smtp-Source: AH8x225tlPR9VkWEzcQ1WAP7N0ih1rr2wfB5hYpBU4pDBONfb2ydfAUqGwMBC71dz+K3dDRqQYEI8sr2bHz3pmPZfVo=
MIME-Version: 1.0
In-Reply-To: <20180216150933.971-5-john.ogness@linutronix.de>
References: <20180216150933.971-1-john.ogness@linutronix.de> <20180216150933.971-5-john.ogness@linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 16 Feb 2018 10:03:15 -0800
X-Google-Sender-Auth: VJa4RHpropIfakRpGNcZ-tANWDQ
Message-ID: <CA+55aFyo6jrvU62DiwKJZaTnmwLYQe4krNJCbAUui8R+=bDVdQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] fs/dcache: Avoid the try_lock loops in dentry_kill()
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 7:09 AM, John Ogness <john.ogness@linutronix.de> wrote:
> dentry_kill() holds dentry->d_lock and needs to acquire both
> dentry->d_inode->i_lock and dentry->d_parent->d_lock. This cannot be
> done with spin_lock() operations because it's the reverse of the
> regular lock order. To avoid ABBA deadlocks it is done with two
> trylock loops.
>
> Trylock loops are problematic in two scenarios:

I don't mind this patch series per se (although I would really like Al
to ack it), but this particular patch I hate.

Why?

> Avoid the trylock loops by using dentry_lock_inode() and lock_parent()
> which take the locks in the appropriate order. As both functions drop
> dentry->lock briefly, this requires rechecking of the dentry content
> as it might have changed after dropping the lock.

I think the trylock should be done first, and then you don't need that
recheck for the common case.

I realize that the recheck itself isn't expensive, but it's mostly
about the code flow and the comment:

> +                * Recheck refcount as it might have been incremented while
> +                * d_lock was dropped.

the thing is, 99.9% of the time the d_lock wasn't dropped, so that
"while d_lock was dropped" comment is misleading.

Re-organizing it to do the trylock fastpath explicitly here and not
bothering with the re-check etc crid for the common case is the rioght
thing to do.

And the old code was actually organized exactly that way, with a

        if (inode && unlikely(!spin_trylock(&inode->i_lock)))
                goto failed;

at the top.

But instead of having that unlikely "failed" case do the complex
thing, you made the *normal* case do the complex thing.

So NAK on this.

It should be fairly trivial to fix, and make the "failed" thing do it right.

             Linus
