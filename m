Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752646AbeBFJMu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 04:12:50 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:42217 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752288AbeBFJMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 04:12:46 -0500
Date: Tue, 6 Feb 2018 10:12:39 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Subhra Mazumdar <subhra.mazumdar@oracle.com>
Cc: Steven Sistare <steven.sistare@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        dhaval.giani@oracle.com
Subject: Re: [RESEND RFC PATCH V3] sched: Improve scalability of
 select_idle_sibling using SMT balance
Message-ID: <20180206091239.GA2269@hirez.programming.kicks-ass.net>
References: <20180129233102.19018-1-subhra.mazumdar@oracle.com>
 <20180201123335.GV2249@hirez.programming.kicks-ass.net>
 <911d42cf-54c7-4776-c13e-7c11f8ebfd31@oracle.com>
 <20180202171708.GN2269@hirez.programming.kicks-ass.net>
 <93db4b69-5ec6-732f-558e-5e64d9ba0cf9@oracle.com>
 <20180205121947.GW2269@hirez.programming.kicks-ass.net>
 <930364e4-bbfe-8c8f-d095-0dd4256a5104@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <930364e4-bbfe-8c8f-d095-0dd4256a5104@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 02:09:11PM -0800, Subhra Mazumdar wrote:
> The pseudo random is also used for choosing a random core to compare with,
> how will transposing achieve that?

Not entirely sure what your point is. Current code doesn't compare to
just _one_ other core, and I don't think we'd ever want to do that.

So currently select_idle_core() will, if there is an idle core, iterate
the whole thing trying to find it. If it fails, it clears the
'have_idle_core' state.

select_idle_cpu, which we'll fall back to, will limit the scanning based
on the average idle time.


The crucial point however, is that concurrent wakeups will not, on
average, do the same iteration because of the target offset.
