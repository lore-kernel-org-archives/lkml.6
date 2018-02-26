Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeBZQHC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 11:07:02 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:38043 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbeBZQHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 11:07:01 -0500
X-Google-Smtp-Source: AG47ELsHIx6hBKGSh4vG2QWj+N48pnpBEokcsfWvdZDwgi56+QiWObPBJf4YQSEZZGkhX9GBttK+IfuPLpjpMNw8lQ0=
MIME-Version: 1.0
In-Reply-To: <20180226142107.uid5vtv5r7zbso33@yquem.inria.fr>
References: <1519301990-11766-1-git-send-email-parri.andrea@gmail.com>
 <20180222134004.GN25181@hirez.programming.kicks-ass.net> <20180222141249.GA14033@andrea>
 <82beae6a-2589-6136-b563-3946d7c4fc60@nvidia.com> <20180222181317.GI2855@linux.vnet.ibm.com>
 <20180222182717.GS25181@hirez.programming.kicks-ass.net> <563431d0-4fb5-9efd-c393-83cc5197e934@nvidia.com>
 <20180226142107.uid5vtv5r7zbso33@yquem.inria.fr>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 26 Feb 2018 08:06:59 -0800
X-Google-Sender-Auth: cMCb4WadqRBhWl4I8ZHV2u08Hls
Message-ID: <CA+55aFwu5jat5vV-d6RVaUFo=Bjeyv-7eXWUJySg6xFUTnfbWQ@mail.gmail.com>
Subject: Re: [RFC PATCH] riscv/locking: Strengthen spin_lock() and spin_unlock()
To: Luc Maranget <luc.maranget@inria.fr>
Cc: Daniel Lustig <dlustig@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>, Akira Yokosawa <akiyks@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 6:21 AM, Luc Maranget <luc.maranget@inria.fr> wrote:
>
> That is, locks are not implemented from more basic primitive but are specified.
> The specification can be described as behaving that way:
>   - A lock behaves as a read-modify-write. the read behaving as a read-acquire

This is wrong, or perhaps just misleading.

The *whole* r-m-w acts as an acquire. Not just the read part. The
write is very much part of it.

Maybe that's what you meant, but it read to me as "just the read part
of the rmw behaves as a read-acquire".

Because it is very important that the _write_ part of the rmw is also
ordered wrt everything that is inside the spinlock.

So doing a spinlock as

 (a) read-locked-acquire
   modify
 (c) write-conditional

would be wrong, because the accesses inside the spinlock are ordered
not just wrt the read-acquire, they have to be ordered wrt the write
too.

So it is closer to say that it's the _write_ of the r-m-w sequence
that has the acquire semantics, not the read.

>   - A unlock behaves as a store release.

Yes.

                  Linus
