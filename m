Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965926AbeEIWfo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 18:35:44 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35542 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965118AbeEIWfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 18:35:43 -0400
Date: Thu, 10 May 2018 00:35:40 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, tglx@linutronix.de,
        "Steven J . Hill" <steven.hill@cavium.com>,
        Tejun Heo <htejun@gmail.com>, Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH REPOST] Revert mm/vmstat.c: fix vmstat_update()
 preemption BUG
Message-ID: <20180509223539.43aznhri72ephluc@linutronix.de>
References: <20180504104451.20278-1-bigeasy@linutronix.de>
 <513014a0-a149-5141-a5a0-9b0a4ce9a8d8@suse.cz>
 <20180508160257.6e19707ccf1dabe5ec9e8847@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180508160257.6e19707ccf1dabe5ec9e8847@linux-foundation.org>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-08 16:02:57 [-0700], Andrew Morton wrote:
> On Mon, 7 May 2018 09:31:05 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:
> 
> > In any case I agree that the revert should be done immediately even
> > before fixing the underlying bug. The preempt_disable/enable doesn't
> > prevent the bug, it only prevents the debugging code from actually
> > reporting it! Note that it's debugging code (CONFIG_DEBUG_PREEMPT) that
> > production kernels most likely don't have enabled, so we are not even
> > helping them not crash (while allowing possible data corruption).
> 
> Grumble.
> 
> I don't see much benefit in emitting warnings into end-users' logs for
> bugs which we already know about.

not end-users (not to mention that neither Debian Stretch nor F28 has
preemption enabled in their kernels). And if so, they may provide
additional information for someone to fix the bug in the end. I wasn't
able to reproduce the bug but I don't have access to anything MIPSish
where I can boot my own kernels. At least two people were looking at the
code after I posted the revert and nobody spotted the bug.

> The only thing this buys us is that people will hassle us if we forget
> to fix the bug, and how pathetic is that?  I mean, we may as well put
> 
> 	printk("don't forget to fix the vmstat_update() bug!\n");

No that is different. That would be seen by everyone. The bug was only
reported by Steven J. Hill which did not respond since. This message
would also imply that we know how to fix the bug but didn't do it yet
which is not the case. We seen that something was wrong but have no idea
*how* it got there.

The preempt_disable() was added by the end of v4.16. The
smp_processor_id() in vmstat_update() was added in commit 7cc36bbddde5
("vmstat: on-demand vmstat workers V8") which was in v3.18-rc1. The
hotplug rework took place in v4.10-rc1. And it took (counting from the
hotplug rework) 6 kernel releases for someone to trigger that warning
_if_ this was related to the hotplug rework.

What we have *now* is way worse: We have a possible bug that triggered
the warning. As we see in report the code in question was _already_
invoked on the wrong CPU. The preempt_disable() just silences the
warning, hiding the real issue so nobody will do a thing about it since
it will be never reported again (in a kernel with preemption and debug
enabled).

> into start_kernel().

Sebastian
