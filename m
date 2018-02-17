Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750948AbeBQAGk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 19:06:40 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:44803 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750787AbeBQAGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 19:06:38 -0500
X-Google-Smtp-Source: AH8x224jzEvY0l48lQER0AkQ3xmSBQ5j5ac/dAvsaNIz1jYQ3NMlKeXaK3/bHdYJxmWdzSvDUB0ZsFL9x5v4dwEofx4=
MIME-Version: 1.0
In-Reply-To: <87lgfs3374.fsf@linutronix.de>
References: <20180216150933.971-1-john.ogness@linutronix.de>
 <20180216150933.971-5-john.ogness@linutronix.de> <CA+55aFyo6jrvU62DiwKJZaTnmwLYQe4krNJCbAUui8R+=bDVdQ@mail.gmail.com>
 <87y3js36s7.fsf@linutronix.de> <CA+55aFxku7bB9BEBrqgREc5ac4MK9CGLir1c7ZA-7bjp-Q2tAg@mail.gmail.com>
 <87r2pk358g.fsf@linutronix.de> <CA+55aFzfug3S_dRrHDh=Zdat0KZVar13NQVzyqXd3-xHLzeSjA@mail.gmail.com>
 <87lgfs3374.fsf@linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 16 Feb 2018 16:06:36 -0800
X-Google-Sender-Auth: SBfb67NgCIxL3Iosi8ui4ipB834
Message-ID: <CA+55aFySL+exqUJX0JKmJY4Pa0CKwn9y4Voqs1QjWY29hkzhnQ@mail.gmail.com>
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

On Fri, Feb 16, 2018 at 3:49 PM, John Ogness <john.ogness@linutronix.de> wrote:
>
> After reading your initial feedback my idea was to change both
> lock_parent() and dentry_lock_inode() to not only communicate _if_ the
> lock was successful, but also if d_lock was dropped in the process. (For
> example, with a tristate rather than boolean return value.) Then callers
> would know if they needed to recheck the dentry contents.

So I think that would work well for your dentry_lock_inode() helper,
and might indeed solve my reaction to your dentry_kill() patch.

I suspect it doesn't work for lock_parent(), because that has to also
return the parent itself. So you'd have to add another way to say
"didn't need to drop dentry lock". I suspect it gets ugly real fast.

But yes, making dentry_lock_inode() return 0/1/2 for "fail/fast/slow"
(or whatever) sounds doable. And then your dentry_kill() patch can use
a "switch ()" to handle the cases, and the whole "need to revalidate"
might become pretty clear and clean.

I'd suggest you ignore lock_parent() for now. Unless you come up with
something clever.

        Linus
