Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754790AbeDCHhN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 03:37:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56154 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753267AbeDCHhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 03:37:12 -0400
Date: Tue, 3 Apr 2018 09:37:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Ingo Molnar <mingo@kernel.org>, Norbert Manthey <nmanthey@amazon.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: v4.16+ seeing many unaligned access in dequeue_task_fair() on
 IA64
Message-ID: <20180403073706.GV4082@hirez.programming.kicks-ass.net>
References: <20180402232448.fbop7k5xicblski5@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180402232448.fbop7k5xicblski5@agluck-desk>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 04:24:49PM -0700, Luck, Tony wrote:
> v4.16 boots cleanly. But with the first bunch of merges
> (Linus HEAD = 46e0d28bdb8e6d00e27a0fe9e1d15df6098f0ffb)
> I see a bunch of:
> 
> ia64_handle_unaligned: 4863 callbacks suppressed
> kernel unaligned access to 0xe00000031660fd74, ip=0xa0000001000f23e0
> kernel unaligned access to 0xe00000033bdffbcc, ip=0xa0000001000f2370
> kernel unaligned access to 0xe00000031660fd74, ip=0xa0000001000f23e0
> kernel unaligned access to 0xe00000033bdffbcc, ip=0xa0000001000f2370
> kernel unaligned access to 0xe00000031660fd74, ip=0xa0000001000f23e0
> 
> The addresses are all 4-byte, but not 8-byte aligned.
> 
> Any guesses before I start to bisect?

That doesn't sound good. The only guess I have at this moment is you
accidentially enabled RANDSTRUCT_PLUGIN and that messes things up.

struct task_struct whould be at least L1_CACHE_BYTES aligned, and C
otherwise makes it fairly hard to cause unaligned accesses. Packed
structures and/or casting are required, and I don't think we added
anything dodgy like that here.
