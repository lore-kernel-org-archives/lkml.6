Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967071AbeCAJfj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:35:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:35267 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966966AbeCAJfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:35:24 -0500
Date: Thu, 1 Mar 2018 10:35:22 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, Rik van Riel <riel@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] Detect early free of a live mm
Message-ID: <20180301093522.GC15057@dhcp22.suse.cz>
References: <20180228121458.2230-1-mark.rutland@arm.com>
 <20180228121809.ztpcjb3256tj6tct@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228121809.ztpcjb3256tj6tct@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 28-02-18 12:18:10, Mark Rutland wrote:
> Ugh, I messed up Peter's email when sending this out. please
> s/infraded/infradead/ if replying to the first mail.
> 
> Sorry about that.
> 
> Mark.
> 
> On Wed, Feb 28, 2018 at 12:14:58PM +0000, Mark Rutland wrote:
> > KASAN splats indicate that in some cases we free a live mm, then
> > continue to access it, with potentially disastrous results. This is
> > likely due to a mismatched mmdrop() somewhere in the kernel, but so far
> > the culprit remains elusive.
> > 
> > Let's have __mmdrop() verify that the mm isn't live for the current
> > task, similar to the existing check for init_mm. This way, we can catch
> > this class of issue earlier, and without requiring KASAN.

Wouldn't it be better to check the mm_users count instead?
{VM_}BUG_ON(atomic_read(&mm->mm_users));

Relying on current->mm resetting works currently but this is quite a
subtle dependency.
-- 
Michal Hocko
SUSE Labs
