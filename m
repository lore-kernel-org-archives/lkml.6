Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946074AbeCBKZD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 05:25:03 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52560 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1426446AbeCBKZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 05:25:01 -0500
Date: Fri, 2 Mar 2018 10:24:54 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michal Hocko <mhocko@suse.com>, Peter Zijlstra <peterz@infraded.org>,
        Rik van Riel <riel@redhat.com>, Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] Detect early free of a live mm
Message-ID: <20180302102453.4jhp6cmuqr4yodr5@lakrids.cambridge.arm.com>
References: <20180228121458.2230-1-mark.rutland@arm.com>
 <20180301171609.c1968b89a15320186122e34e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301171609.c1968b89a15320186122e34e@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 05:16:09PM -0800, Andrew Morton wrote:
> On Wed, 28 Feb 2018 12:14:58 +0000 Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > KASAN splats indicate that in some cases we free a live mm, then
> > continue to access it, with potentially disastrous results. This is
> > likely due to a mismatched mmdrop() somewhere in the kernel, but so far
> > the culprit remains elusive.
> > 
> > Let's have __mmdrop() verify that the mm isn't live for the current
> > task, similar to the existing check for init_mm. This way, we can catch
> > this class of issue earlier, and without requiring KASAN.
> 
> Presumably the results usually aren't disastrous. 

It seems so.

> But they will be if we go and add BUG_ON()s!  Can we make this
> WARN_ON[_ONCE]()?  We should still get the same info from testers.

I fuzz the kernel with panic_on_warn=1, so that's practically the same
for me.

I'll respin to that effect.

Thanks,
Mark.
