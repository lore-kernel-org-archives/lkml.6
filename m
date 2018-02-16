Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750937AbeBPWmj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 17:42:39 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:38440 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750808AbeBPWmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 17:42:37 -0500
X-Google-Smtp-Source: AH8x225C3SNhqqpWovvhOMjZL5pkmAMQJkipXKfldsMDJLsOa8yEc0xaC24WEVmMy+8mRrVwH5r74nEVjWDl21ZSPZk=
MIME-Version: 1.0
In-Reply-To: <87y3js36s7.fsf@linutronix.de>
References: <20180216150933.971-1-john.ogness@linutronix.de>
 <20180216150933.971-5-john.ogness@linutronix.de> <CA+55aFyo6jrvU62DiwKJZaTnmwLYQe4krNJCbAUui8R+=bDVdQ@mail.gmail.com>
 <87y3js36s7.fsf@linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 16 Feb 2018 14:42:36 -0800
X-Google-Sender-Auth: qZhuKhMgiPB0wm2GFjFxNv3El-Y
Message-ID: <CA+55aFxku7bB9BEBrqgREc5ac4MK9CGLir1c7ZA-7bjp-Q2tAg@mail.gmail.com>
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

On Fri, Feb 16, 2018 at 2:32 PM, John Ogness <john.ogness@linutronix.de> wrote:
>
> lock_parent() already has the problem you are referring to. Callers are
> required to recheck the dentry contents and check the returned parent
> because they do not know if the trylock succeeded. See
> d_prune_aliases(), for example.

What are you talking about?

lock_parent() does the nice "spin_trylock succeeded" special case.

Yes, it will then do the "unlock dentry, do the parent first, then
re-check" too, and callers may need to worry about it.

But that's not what I'm complaining about in your patch. You remove
the simple case, and make dentry_kill() do the "recheck in case I
dropped" every single time.

It's the "turn a simple case into a complex case" that I absolutely detest.

The fact that there are _other_ complex cases doesn't make it any
better. The whole "but Bobby does it too" thing is not a defense.
Would you jump off a bridge just because your friend did it?

               Linus
