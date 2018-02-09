Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751062AbeBIMBB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 07:01:01 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:53785 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbeBIMBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 07:01:00 -0500
Date: Fri, 9 Feb 2018 13:00:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Morten Rasmussen <morten.rasmussen@foss.arm.com>,
        Brendan Jackman <brendan.jackman@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 1/3] sched: Stop nohz stats when decayed
Message-ID: <20180209120053.GL25201@hirez.programming.kicks-ass.net>
References: <1517944987-343-1-git-send-email-vincent.guittot@linaro.org>
 <1517944987-343-2-git-send-email-vincent.guittot@linaro.org>
 <20180208140005.GH25201@hirez.programming.kicks-ass.net>
 <CAKfTPtB0dDmovt=iM=efXUG1EY7GnOAuTTCf0VqTvx08fatWeQ@mail.gmail.com>
 <20180208154459.GA25181@hirez.programming.kicks-ass.net>
 <CAKfTPtA0kmgD0XtMMweESojfuGFW1t9fT53=2QqtrJVbPV4QBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtA0kmgD0XtMMweESojfuGFW1t9fT53=2QqtrJVbPV4QBw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 05:52:00PM +0100, Vincent Guittot wrote:
> On 8 February 2018 at 16:44, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Thu, Feb 08, 2018 at 04:05:58PM +0100, Vincent Guittot wrote:
> >> On 8 February 2018 at 15:00, Peter Zijlstra <peterz@infradead.org> wrote:
> >> > On Tue, Feb 06, 2018 at 08:23:05PM +0100, Vincent Guittot wrote:
> >> >
> >> >> @@ -9207,13 +9231,15 @@ void nohz_balance_enter_idle(int cpu)
> >> >>       if (!housekeeping_cpu(cpu, HK_FLAG_SCHED))
> >> >>               return;
> >> >>
> >> >> +     rq->has_blocked_load = 1;
> >
> > Should we not set that with rq->lock held? We already clear it while
> > holding rq->lock.
> 
> I think it's safe because it is used to re-enable the periodic decay
> unconditionally.
> It is cleared with  rq->lock held to prevents any update of the cfs_rq
> *_avg  while deciding if we can clear has_blocked_load

Yes, and that clearing must then have observed the new addition. But
please put so in a comment.
