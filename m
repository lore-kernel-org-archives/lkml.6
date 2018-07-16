Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B75DECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A62208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A62208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbeGPPIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 11:08:16 -0400
Received: from ozlabs.org ([203.11.71.1]:50727 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727150AbeGPPIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 11:08:16 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41TmKh5hhYz9ryt;
        Tue, 17 Jul 2018 00:40:24 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        andrea.parri@amarulasolutions.com,
        Will Deacon <will.deacon@arm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nick Piggin <npiggin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and remove it for ordinary release/acquire
In-Reply-To: <20180713164239.GZ2494@hirez.programming.kicks-ass.net>
References: <20180712134821.GT2494@hirez.programming.kicks-ass.net> <Pine.LNX.4.44L0.1807121236470.1306-100000@iolanthe.rowland.org> <20180712172838.GU3593@linux.vnet.ibm.com> <20180712180511.GP2476@hirez.programming.kicks-ass.net> <CA+55aFxwez8zSa2f2GpcaAkFX27Vt-s0nWdd0mZ6yGM8ipCR0A@mail.gmail.com> <20180713110851.GY2494@hirez.programming.kicks-ass.net> <87tvp3xonl.fsf@concordia.ellerman.id.au> <20180713164239.GZ2494@hirez.programming.kicks-ass.net>
Date:   Tue, 17 Jul 2018 00:40:19 +1000
Message-ID: <87601fz1kc.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:
> On Fri, Jul 13, 2018 at 11:15:26PM +1000, Michael Ellerman wrote:
...
>> 
>> 
>> So 18-32% slower, or 23-47 cycles.
>
> Very good info. Note that another option is to put the SYNC in lock() it
> doesn't really matter which of the two primitives gets it. I don't
> suppose it really matters for timing either way around.

If the numbers can be trusted it is actually slower to put the sync in
lock, at least on one of the machines:

              Time
lwsync_sync   84,932,987,977
sync_lwsync   93,185,930,333

On the other machine it's slower but only by 0.1%, so that's slightly
weird.

The other advantage of putting the sync in unlock is we could get rid of
our SYNC_IO logic, which conditionally puts a sync in unlock to order
IO accesses vs unlock.


>> Next week I can do some macro benchmarks, to see if it's actually
>> detectable at all.


I guess arguably it's not a very macro benchmark, but we have a
context_switch benchmark in the tree[1] which we often use to tune
things, and it degrades badly. It just spins up two threads and has them
ping-pong using yield.


The numbers are context switch iterations, so more == better.

	   | Before     | After      | Change     | Change %
	   +------------+------------+------------+----------
	   | 35,601,160 | 32,371,164 | -3,229,996 | -9.07%
	   | 35,762,126 | 32,438,798 | -3,323,328 | -9.29%
	   | 35,690,870 | 32,353,676 | -3,337,194 | -9.35%
	   | 35,440,346 | 32,336,750 | -3,103,596 | -8.76%
	   | 35,614,868 | 32,676,378 | -2,938,490 | -8.25%
	   | 35,659,690 | 32,462,624 | -3,197,066 | -8.97%
	   | 35,594,058 | 32,403,922 | -3,190,136 | -8.96%
	   | 35,682,682 | 32,353,146 | -3,329,536 | -9.33%
	   | 35,954,454 | 32,306,168 | -3,648,286 | -10.15%
	   | 35,849,314 | 32,291,094 | -3,558,220 | -9.93%
 ----------+------------+------------+------------+----------
 Average   | 35,684,956 | 32,399,372 | -3,285,584 | -9.21%
 Std Dev   |    143,877 |    111,385 |
 Std Dev % |      0.40% |      0.34% |

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/powerpc/benchmarks/context_switch.c


I'll do some kernbench runs tomorrow and see if it shows up there.


>> My personal preference would be to switch to sync, we don't want to be
>> the only arch finding (or not finding!) exotic ordering bugs.
>> 
>> But we'd also rather not make our slow locks any slower than they have
>> to be.
>
> I completely understand, but I'll get you beer (lots) if you do manage
> to make SYNC happen :-) :-)

Just so we're clear Fosters is not beer :)

cheers
