Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeCZK44 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 06:56:56 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39458 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751090AbeCZK4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 06:56:55 -0400
Date: Mon, 26 Mar 2018 11:57:05 +0100
From: Will Deacon <will.deacon@arm.com>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH for-4.17 1/2] arm64: Remove smp_mb() from
 arch_spin_is_locked()
Message-ID: <20180326105705.GA6579@arm.com>
References: <1522060641-6986-1-git-send-email-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522060641-6986-1-git-send-email-andrea.parri@amarulasolutions.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 12:37:21PM +0200, Andrea Parri wrote:
> Commit 38b850a73034f ("arm64: spinlock: order spin_{is_locked,unlock_wait}
> against local locks") added an smp_mb() to arch_spin_is_locked(), in order
> "to ensure that the lock value is always loaded after any other locks have
> been taken by the current CPU", and reported one example (the "insane case"
> in ipc/sem.c) relying on such guarantee.
> 
> It is however understood (and not documented) that spin_is_locked() is not
> required to ensure such an ordering guarantee, guarantee that is currently
> _not_ provided by all implementations/architectures, and that callers rely-
> ing on such ordering should instead insert suitable memory barriers before
> acting on the result of spin_is_locked().
> 
> Following a recent auditing[1] of the callsites of {,raw_}spin_is_locked()
> revealing that none of these callers are relying on the ordering guarantee
> anymore, this commit removes the leading smp_mb() from this primitive thus
> effectively reverting 38b850a73034f.
> 
> [1] https://marc.info/?l=linux-kernel&m=151981440005264&w=2

What is patch 2/2 in this series? I couldn't find it in the archive.

Assuming that patch doesn't do it, please can you remove the comment
about spin_is_locked from mutex_is_locked?

Also -- does this mean we can kill the #ifndef queued_spin_is_locked
guards in asm-generic/qspinlock.h?

Will
