Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752411AbeBWVgD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 16:36:03 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:35048 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbeBWVfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 16:35:54 -0500
X-Google-Smtp-Source: AG47ELvqCSZQQUjPAYpgqy3dlZmW1E5hZbkHKrTJ7/yzQ9YPkO096rsIF6M5pjE3w8UHXzPMV+s80BJJwRLZyHkDbfU=
MIME-Version: 1.0
In-Reply-To: <20180223201317.GG30522@ZenIV.linux.org.uk>
References: <20180222235025.28662-1-john.ogness@linutronix.de>
 <20180222235025.28662-7-john.ogness@linutronix.de> <20180223035814.GZ30522@ZenIV.linux.org.uk>
 <20180223040814.GA30522@ZenIV.linux.org.uk> <87h8q7erlo.fsf@linutronix.de>
 <20180223150928.GC30522@ZenIV.linux.org.uk> <20180223174216.GD30522@ZenIV.linux.org.uk>
 <20180223201317.GG30522@ZenIV.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 23 Feb 2018 13:35:52 -0800
X-Google-Sender-Auth: 9NHaGNqzwm_npAGDdalsRbQS6TI
Message-ID: <CA+55aFyP9JtyzUzA_S2sdKCK+8CZtNoA3UkXg5X4J0Hf2_ekjg@mail.gmail.com>
Subject: Re: [BUG] lock_parent() breakage when used from shrink_dentry_list()
 (was Re: [PATCH v2 6/6] fs/dcache: Avoid remaining try_lock loop in shrink_dentry_list())
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Ogness <john.ogness@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 12:13 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> Look:
>         dentry placed on a shrink list
>         we pick the fucker from the list and lock it.
>         we call lock_parent() on it.
>                 dentry is not a root and it's not deleted, so we proceed.
>                 trylock fails.
>                 we grab rcu_read_lock()
>                 we drop dentry->d_lock

[ deleted the bad things ]

Should we just instead get the ref to the dentry before dropping the
lock, so that nobody else can get to dentry_kill?

This is too subtle, and your fix to check d_lockref.count < 0 sounds
wrong to me. If it's really gone, maybe it has been reused and the
refcount is positive again, but it's something else than a dentry
entirely?

Hmm.

No, you extended the rcu read section, so I guess your patch is fine.
And lock_parent already has that pattern, soiit's not new.

Ok, I agree, looks like lock_parent should just re-check that thing
that it already checked earler, but that now might be true again
because of we dropped d_lock.

              Linus
