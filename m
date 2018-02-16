Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751053AbeBPXtx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 18:49:53 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:57415 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeBPXtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 18:49:51 -0500
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
        <87r2pk358g.fsf@linutronix.de>
        <CA+55aFzfug3S_dRrHDh=Zdat0KZVar13NQVzyqXd3-xHLzeSjA@mail.gmail.com>
Date: Sat, 17 Feb 2018 00:49:35 +0100
In-Reply-To: <CA+55aFzfug3S_dRrHDh=Zdat0KZVar13NQVzyqXd3-xHLzeSjA@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 16 Feb 2018 15:31:22 -0800")
Message-ID: <87lgfs3374.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-17, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> dentry_kill() calls both dentry_lock_inode() and lock_parent() in the
>> common case. So by changing the semantics of lock_parent(), I am
>> removing two "recheck in case I dropped" in the common case rather
>> than just the one you pointed out.
>
> Ok, that would be lovely, but doesn't that end up being a nasty patch?

After reading your initial feedback my idea was to change both
lock_parent() and dentry_lock_inode() to not only communicate _if_ the
lock was successful, but also if d_lock was dropped in the process. (For
example, with a tristate rather than boolean return value.) Then callers
would know if they needed to recheck the dentry contents.

> So it may be that my dislike of the "re-check after possibly dropping
> the lock" is not really about the re-checking, but about just how it
> made that function look much more complicated.

I understand what you are saying and I appreciate the comments. I will
code up some variations for myself and try to pick the one that is the
least complicated for my v2.

John Ogness
