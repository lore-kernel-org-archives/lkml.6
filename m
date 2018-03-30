Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeC3UyE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 16:54:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48416 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752568AbeC3UyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 16:54:02 -0400
Date: Fri, 30 Mar 2018 13:53:56 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-patch-test@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joelaf@google.com>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v1] kernel/trace:check the val against the available mem
Message-ID: <20180330205356.GA13332@bombadil.infradead.org>
References: <1522320104-6573-1-git-send-email-zhaoyang.huang@spreadtrum.com>
 <20180330102038.2378925b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330102038.2378925b@gandalf.local.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 30, 2018 at 10:20:38AM -0400, Steven Rostedt wrote:
> That said, it appears you are having issues that were caused by the
> change by commit 848618857d2 ("tracing/ring_buffer: Try harder to
> allocate"), where we replaced NORETRY with RETRY_MAYFAIL. The point of
> NORETRY was to keep allocations of the tracing ring-buffer from causing
> OOMs. But the RETRY was too strong in that case, because there were
> those that wanted to allocate large ring buffers but it would fail due
> to memory being used that could be reclaimed. Supposedly, RETRY_MAYFAIL
> is to allocate with reclaim but still allow to fail, and isn't suppose
> to trigger an OOM. From my own tests, this is obviously not the case.

That's not exactly what the comment says in gfp.h:

 * __GFP_RETRY_MAYFAIL: The VM implementation will retry memory reclaim
 *   procedures that have previously failed if there is some indication
 *   that progress has been made else where.  It can wait for other
 *   tasks to attempt high level approaches to freeing memory such as
 *   compaction (which removes fragmentation) and page-out.
 *   There is still a definite limit to the number of retries, but it is
 *   a larger limit than with __GFP_NORETRY.
 *   Allocations with this flag may fail, but only when there is
 *   genuinely little unused memory. While these allocations do not
 *   directly trigger the OOM killer, their failure indicates that
 *   the system is likely to need to use the OOM killer soon.  The
 *   caller must handle failure, but can reasonably do so by failing
 *   a higher-level request, or completing it only in a much less
 *   efficient manner.
 *   If the allocation does fail, and the caller is in a position to
 *   free some non-essential memory, doing so could benefit the system
 *   as a whole.

It seems to me that what you're asking for at the moment is
lower-likelihood-of-failure-than-GFP_KERNEL, and it's not entirely
clear to me why your allocation is so much more important than other
allocations in the kernel.

Also, the pattern you have is very close to that of vmalloc.  You're
allocating one page at a time to satisfy a multi-page request.  In lieu
of actually thinking about what you should do, I might recommend using the
same GFP flags as vmalloc() which works out to GFP_KERNEL | __GFP_NOWARN
(possibly | __GFP_HIGHMEM if you can tolerate having to kmap the pages
when accessed from within the kernel).
