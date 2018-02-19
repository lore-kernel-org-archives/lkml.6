Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752334AbeBTNFh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 08:05:37 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55424 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751931AbeBTNCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 08:02:00 -0500
Date: Mon, 19 Feb 2018 15:04:34 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@kernel.org
Subject: Re: [RFC PATCH 3/5] asm-generic/bitops/atomic.h: Rewrite using
 atomic_fetch_*
Message-ID: <20180219140434.GS25201@hirez.programming.kicks-ass.net>
References: <1518708575-12284-1-git-send-email-will.deacon@arm.com>
 <1518708575-12284-4-git-send-email-will.deacon@arm.com>
 <20180215170847.GD25181@hirez.programming.kicks-ass.net>
 <20180215182049.GC15274@arm.com>
 <20180216102100.GB25201@hirez.programming.kicks-ass.net>
 <20180219140142.GD30394@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219140142.GD30394@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 02:01:43PM +0000, Will Deacon wrote:
> >     The non serializing __clear_bit() was getting "lost"
> >     
> >      80543b8e:      ld_s       r2,[r13,0] <--- (A) Finds PG_locked is set
> >      80543b90:      or         r3,r2,1    <--- (B) other core unlocks right here
> >      80543b94:      st_s       r3,[r13,0] <--- (C) sets PG_locked (overwrites unlock)
> 
> Ah, so it's problematic for the case where atomics are built using locks.
> Got it. I'll err on the side of caution here and have the asm-generic header
> (which should be bitops/lock.h not bitops/atomic.h) conditionally define
> __clear_bit_unlock as clear_bit_lock unless the architecture has provided
> its own implementation.

So I think we get it all right if we use atomic_set_release(). If the
atomics are implemented using locks, atomic_set*() should be implemented
like atomic_xchg() and avoid the above problem.
