Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752420AbeDCQLX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 12:11:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:44540 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752289AbeDCQLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 12:11:22 -0400
Date: Tue, 3 Apr 2018 18:11:19 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-patch-test@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joelaf@google.com>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1] kernel/trace:check the val against the available mem
Message-ID: <20180403161119.GE5501@dhcp22.suse.cz>
References: <1522320104-6573-1-git-send-email-zhaoyang.huang@spreadtrum.com>
 <20180330102038.2378925b@gandalf.local.home>
 <20180403110612.GM5501@dhcp22.suse.cz>
 <20180403075158.0c0a2795@gandalf.local.home>
 <20180403121614.GV5501@dhcp22.suse.cz>
 <20180403082348.28cd3c1c@gandalf.local.home>
 <20180403123514.GX5501@dhcp22.suse.cz>
 <20180403093245.43e7e77c@gandalf.local.home>
 <20180403135607.GC5501@dhcp22.suse.cz>
 <20180403101753.3391a639@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403101753.3391a639@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-04-18 10:17:53, Steven Rostedt wrote:
> On Tue, 3 Apr 2018 15:56:07 +0200
> Michal Hocko <mhocko@kernel.org> wrote:
[...]
> > I simply do not see the difference between the two. Both have the same
> > deadly effect in the end. The direct OOM has an arguable advantage that
> > the effect is immediate rather than subtle with potential performance
> > side effects until the machine OOMs after crawling for quite some time.
> 
> The difference is if the allocation succeeds or not. If it doesn't
> succeed, we free all memory that we tried to allocate. If it succeeds
> and causes issues, then yes, that's the admins fault.

What am I trying to say is that this is so extremely time and workload
sensitive that you can hardly have a stable behavior. It will become a
pure luck whether the failure happens.

> I'm worried about
> the accidental putting in too big of a number, either by an admin by
> mistake, or some stupid script that just thinks the current machines
> has terabytes of memory.

I would argue that stupid scripts should have no business calling root
only interfaces which can allocate a lot of memory and cause OOMs.

> I'm under the assumption that if I allocate an allocation of 32 pages
> with RETRY_MAYFAIL, and there's 2 pages available, but not 32, and
> while my allocation is reclaiming memory, and another task comes in and
> asks for a single page, it can still succeed. This would be why I would
> be using RETRY_MAYFAIL with higher orders of pages, that it doesn't
> take all memory in the system if it fails. Is this assumption incorrect?

Yes. There is no guarantee that the allocation will get the memory it
reclaimed in the direct reclaim. Pages are simply freed back into the
pool and it is a matter of timing who gets them.

> The current approach of allocating 1 page at a time with RETRY_MAYFAIL
> is that it will succeed to get any pages that are available, until
> there are none, and if some unlucky task asks for memory during that
> time, it is guaranteed to fail its allocation triggering an OOM.
> 
> I was thinking of doing something like:
> 
> 	large_pages = nr_pages / 32;
> 	if (large_pages) {
> 		pages = alloc_pages_node(cpu_to_node(cpu),
> 				GFP_KERNEL | __GFP_RETRY_MAYFAIL, 5);
> 		if (pages)
> 			/* break up pages */
> 		else
> 			/* try to allocate with NORETRY */
> 	}

You can do so, of course. In fact it would have some advantages over
single pages because you would fragment the memory less but this is not
a reliable prevention from OOM killing and the complete memory
depletion if you allow arbitrary trace buffer sizes.

> Now it will allocate memory in 32 page chunks using reclaim. If it
> fails to allocate them, it would not have taken up any smaller chunks
> that were available, leaving them for other users. It would then go
> back to singe pages, allocating with RETRY. Or I could just say screw
> it, and make the allocation of the ring buffer always be 32 page chunks
> (or at least make it user defined).

yes a fallback is questionable. Whether to make the batch size
configuration is a matter of how much internal details you want to
expose to userspace.
-- 
Michal Hocko
SUSE Labs
