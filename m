Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750902AbeBPWc2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 17:32:28 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:57370 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbeBPWc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 17:32:27 -0500
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
Date: Fri, 16 Feb 2018 23:32:08 +0100
In-Reply-To: <CA+55aFyo6jrvU62DiwKJZaTnmwLYQe4krNJCbAUui8R+=bDVdQ@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 16 Feb 2018 10:03:15 -0800")
Message-ID: <87y3js36s7.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-16, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Fri, Feb 16, 2018 at 7:09 AM, John Ogness <john.ogness@linutronix.de> wrote:
>> dentry_kill() holds dentry->d_lock and needs to acquire both
>> dentry->d_inode->i_lock and dentry->d_parent->d_lock. This cannot be
>> done with spin_lock() operations because it's the reverse of the
>> regular lock order. To avoid ABBA deadlocks it is done with two
>> trylock loops.
>>
>> Trylock loops are problematic in two scenarios:
>
> I don't mind this patch series per se (although I would really like Al
> to ack it), but this particular patch I hate.
>
> Why?
>
>> Avoid the trylock loops by using dentry_lock_inode() and lock_parent()
>> which take the locks in the appropriate order. As both functions drop
>> dentry->lock briefly, this requires rechecking of the dentry content
>> as it might have changed after dropping the lock.
>
> I think the trylock should be done first, and then you don't need that
> recheck for the common case.
>
> I realize that the recheck itself isn't expensive, but it's mostly
> about the code flow and the comment:
>
>> +                * Recheck refcount as it might have been incremented while
>> +                * d_lock was dropped.
>
> the thing is, 99.9% of the time the d_lock wasn't dropped, so that
> "while d_lock was dropped" comment is misleading.
>
> Re-organizing it to do the trylock fastpath explicitly here and not
> bothering with the re-check etc crid for the common case is the rioght
> thing to do.
>
> And the old code was actually organized exactly that way, with a
>
>         if (inode && unlikely(!spin_trylock(&inode->i_lock)))
>                 goto failed;
>
> at the top.
>
> But instead of having that unlikely "failed" case do the complex
> thing, you made the *normal* case do the complex thing.
>
> So NAK on this.

lock_parent() already has the problem you are referring to. Callers are
required to recheck the dentry contents and check the returned parent
because they do not know if the trylock succeeded. See
d_prune_aliases(), for example.

Would you like my v2 to fixup lock_parent() semantics to address your
concerns there as well?

John Ogness
