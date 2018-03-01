Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030235AbeCALWr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 06:22:47 -0500
Received: from foss.arm.com ([217.140.101.70]:36406 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030215AbeCALWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 06:22:45 -0500
Date: Thu, 1 Mar 2018 11:22:37 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, Rik van Riel <riel@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] Detect early free of a live mm
Message-ID: <20180301112237.pjn5rmvkkpxcntl7@lakrids.cambridge.arm.com>
References: <20180228121458.2230-1-mark.rutland@arm.com>
 <20180228121809.ztpcjb3256tj6tct@lakrids.cambridge.arm.com>
 <20180301093522.GC15057@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301093522.GC15057@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 10:35:22AM +0100, Michal Hocko wrote:
> On Wed 28-02-18 12:18:10, Mark Rutland wrote:
> > Ugh, I messed up Peter's email when sending this out. please
> > s/infraded/infradead/ if replying to the first mail.
> > 
> > Sorry about that.
> > 
> > Mark.
> > 
> > On Wed, Feb 28, 2018 at 12:14:58PM +0000, Mark Rutland wrote:
> > > KASAN splats indicate that in some cases we free a live mm, then
> > > continue to access it, with potentially disastrous results. This is
> > > likely due to a mismatched mmdrop() somewhere in the kernel, but so far
> > > the culprit remains elusive.
> > > 
> > > Let's have __mmdrop() verify that the mm isn't live for the current
> > > task, similar to the existing check for init_mm. This way, we can catch
> > > this class of issue earlier, and without requiring KASAN.
> 
> Wouldn't it be better to check the mm_users count instead?
> {VM_}BUG_ON(atomic_read(&mm->mm_users));

Perhaps, but that won't catch a mismatched mmput(), which could
decrement mm_users (and mm_count) to zero early, before current->mm is
cleared in exit_mm().

Locally, I'm testing with:

  BUG_ON(mm == current->mm);
  BUG_ON(mm == current->active_mm);
  BUG_ON(refcount_read(&mm->mm_users) != 0);
  BUG_ON(refcount_read(&mm->mm_count) != 0);

... so as to also catch an early free from another thread.

> Relying on current->mm resetting works currently but this is quite a
> subtle dependency.

Do you mean because it only catches an early free in a thread using that
mm, or is there another subtlety you had in mind?

Thanks,
Mark.
