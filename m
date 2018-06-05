Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752643AbeFEOnM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 10:43:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37476 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752085AbeFEOnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 10:43:10 -0400
Date: Tue, 5 Jun 2018 16:43:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>, Will Deacon <will.deacon@arm.com>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH 1/7] atomics/tty: add missing atomic_long_t * cast
Message-ID: <20180605144304.GW12180@hirez.programming.kicks-ass.net>
References: <20180529180746.29684-1-mark.rutland@arm.com>
 <20180529180746.29684-2-mark.rutland@arm.com>
 <20180605120021.GH12258@hirez.programming.kicks-ass.net>
 <20180605142051.GB12925@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605142051.GB12925@kroah.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 04:20:51PM +0200, Greg Kroah-Hartman wrote:
> I think Peter Hurley was just trying to hid the atomic mess behind
> function calls, which is why he didn't open-code it like you did here.

No reason to then not use the right types though. I mean, you can still
use the helper functions, but I figured they weren't worth the bother.
Esp. then using try_cmpxchg (which is relatively new) the helpers became
very thin.

> But this makes it a bit more obvious as to what "magic" is happening, so
> I like it.

Well, it also fixes one additional bug in that the old code used a
regular unsigned long load of the value:

-       long count = sem->count;
+       long count = atomic_long_read(&sem->count);

which doesn't guarantee enough. The atomic_long_read() thing implies
READ_ONCE() which ensures the load is single copy atomic (GCC used to
guarantee that for regular loads/stores to naturally aligned native
words, but no longer).

> Care to turn it into a real patch so I can queue it up after 4.18-rc1 is
> out?  Or do you want me to do that?

I can make a proper patch, hold on.
