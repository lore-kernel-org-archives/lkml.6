Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754106AbeC0QyT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 12:54:19 -0400
Received: from foss.arm.com ([217.140.101.70]:59756 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752179AbeC0QyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 12:54:13 -0400
Date: Tue, 27 Mar 2018 17:54:23 +0100
From: Will Deacon <will.deacon@arm.com>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH for-4.17 1/2] arm64: Remove smp_mb() from
 arch_spin_is_locked()
Message-ID: <20180327165423.GF18435@arm.com>
References: <1522060641-6986-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20180326105705.GA6579@arm.com>
 <20180326141436.GA11739@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326141436.GA11739@andrea>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

On Mon, Mar 26, 2018 at 04:14:36PM +0200, Andrea Parri wrote:
> On Mon, Mar 26, 2018 at 11:57:05AM +0100, Will Deacon wrote:
> > On Mon, Mar 26, 2018 at 12:37:21PM +0200, Andrea Parri wrote:
> > > Commit 38b850a73034f ("arm64: spinlock: order spin_{is_locked,unlock_wait}
> > > against local locks") added an smp_mb() to arch_spin_is_locked(), in order
> > > "to ensure that the lock value is always loaded after any other locks have
> > > been taken by the current CPU", and reported one example (the "insane case"
> > > in ipc/sem.c) relying on such guarantee.
> > > 
> > > It is however understood (and not documented) that spin_is_locked() is not
> > > required to ensure such an ordering guarantee, guarantee that is currently
> > > _not_ provided by all implementations/architectures, and that callers rely-
> > > ing on such ordering should instead insert suitable memory barriers before
> > > acting on the result of spin_is_locked().
> > > 
> > > Following a recent auditing[1] of the callsites of {,raw_}spin_is_locked()
> > > revealing that none of these callers are relying on the ordering guarantee
> > > anymore, this commit removes the leading smp_mb() from this primitive thus
> > > effectively reverting 38b850a73034f.
> > > 
> > > [1] https://marc.info/?l=linux-kernel&m=151981440005264&w=2
> > 
> > What is patch 2/2 in this series? I couldn't find it in the archive.
> 
> 2/2 is this change for powerpc:
> 
>   https://marc.info/?l=linux-kernel&m=152206068707522&w=2
> 
> > 
> > Assuming that patch doesn't do it, please can you remove the comment
> > about spin_is_locked from mutex_is_locked?
> 
> I ended up with the patch below but I suspect that it's not what you had
> in mind; please let me know if you'd like me to add it into this series.

That's exactly what I meant! I think you can remove the #ifndef
queued_spin_is_locked in the same patch. If you do that:

Acked-by: Will Deacon <will.deacon@arm.com>

for the arm64 patch and the mythical core patch we've been discussing.

Will
