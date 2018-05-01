Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755059AbeEAKkb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 06:40:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58580 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754511AbeEAKk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 06:40:28 -0400
Date: Tue, 1 May 2018 12:40:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Kohli, Gaurav" <gkohli@codeaurora.org>
Cc: tglx@linutronix.de, mpe@ellerman.id.au, mingo@kernel.org,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v1] kthread/smpboot: Serialize kthread parking against
 wakeup
Message-ID: <20180501104015.GE12235@hirez.programming.kicks-ass.net>
References: <1524645199-5596-1-git-send-email-gkohli@codeaurora.org>
 <20180425200917.GZ4082@hirez.programming.kicks-ass.net>
 <20180426084131.GV4129@hirez.programming.kicks-ass.net>
 <20180426085719.GW4129@hirez.programming.kicks-ass.net>
 <4d3f68f8-e599-6b27-a2e8-9e96b401d57a@codeaurora.org>
 <20180430111744.GE4082@hirez.programming.kicks-ass.net>
 <3af3365b-4e3f-e388-8e90-45a3bd4120fd@codeaurora.org>
 <20180501101845.GE12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180501101845.GE12217@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 12:18:45PM +0200, Peter Zijlstra wrote:
> Aaaah... I think I've spotted a problem there. We clear SHOULD_PARK
> before we rebind, so if the thread lost the first PARKED store,
> does the completion, gets migrated, cycles through the loop and now
> observes !SHOULD_PARK and bails the wait-loop, then __kthread_bind()
> will forever wait.
> 
> Is that what you had in mind?

Another possible problem is concurrent thread_park(), if both observe
!IS_PARKED, we'll end up with 2 threads waiting on the completion, but
we only do a single complete().

Of course, this might not be a suppored use of the API, and I don't
think this will ever actually happen. But the whole !test_bit(IS_PARKED)
thing seems to suggest it is fine calling this on an already parked
thread.

Confusing stuff that should be cleared up in any case.
