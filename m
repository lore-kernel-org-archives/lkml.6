Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750937AbeBPXbZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 18:31:25 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:33297 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbeBPXbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 18:31:23 -0500
X-Google-Smtp-Source: AH8x22777UvF6p4LYEXFqvwAF72DKbykA/Ck6znXF0srpxI1qKNGvL7x3g9dBtj16oo/SV8d4vWSvcBlOLM97IMH+Fk=
MIME-Version: 1.0
In-Reply-To: <87r2pk358g.fsf@linutronix.de>
References: <20180216150933.971-1-john.ogness@linutronix.de>
 <20180216150933.971-5-john.ogness@linutronix.de> <CA+55aFyo6jrvU62DiwKJZaTnmwLYQe4krNJCbAUui8R+=bDVdQ@mail.gmail.com>
 <87y3js36s7.fsf@linutronix.de> <CA+55aFxku7bB9BEBrqgREc5ac4MK9CGLir1c7ZA-7bjp-Q2tAg@mail.gmail.com>
 <87r2pk358g.fsf@linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 16 Feb 2018 15:31:22 -0800
X-Google-Sender-Auth: O_PC3C0KlLjTVh2C567_XVoDC40
Message-ID: <CA+55aFzfug3S_dRrHDh=Zdat0KZVar13NQVzyqXd3-xHLzeSjA@mail.gmail.com>
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

On Fri, Feb 16, 2018 at 3:05 PM, John Ogness <john.ogness@linutronix.de> wrote:
>
> dentry_kill() calls both dentry_lock_inode() and lock_parent() in the
> common case. So by changing the semantics of lock_parent(), I am
> removing two "recheck in case I dropped" in the common case rather than
> just the one you pointed out.

Ok, that would be lovely, but doesn't that end up being a nasty patch?
You can't just move the trylock into the caller, since then you need
to move all the other stuff too?

Or were you planning on splitting lock_parent() into two, for the
"fast case vs compex case"?

Or maybe I'm entirely missing something and we're miscommunicating.

I'm actually not so much worried about the cost of re-checking (the
real cost tends to be the locked cycle itself) as I am about the code
looking understandable. Your d_delete() patch didn't make me  go "that
looks more complicated", probably partl ybecause of the nice helper
function.

So it may be that my dislike of the "re-check after possibly dropping
the lock" is not really about the re-checking, but about just how it
made that function look much more complicated.

             Linus
