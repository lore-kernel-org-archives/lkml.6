Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F5CECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107CC208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107CC208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbeGMNaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 09:30:10 -0400
Received: from ozlabs.org ([203.11.71.1]:36861 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729623AbeGMNaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 09:30:10 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Rtb34SWGz9ryt;
        Fri, 13 Jul 2018 23:15:27 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paul McKenney <paulmck@linux.vnet.ibm.com>,
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
In-Reply-To: <20180713110851.GY2494@hirez.programming.kicks-ass.net>
References: <20180712134821.GT2494@hirez.programming.kicks-ass.net> <Pine.LNX.4.44L0.1807121236470.1306-100000@iolanthe.rowland.org> <20180712172838.GU3593@linux.vnet.ibm.com> <20180712180511.GP2476@hirez.programming.kicks-ass.net> <CA+55aFxwez8zSa2f2GpcaAkFX27Vt-s0nWdd0mZ6yGM8ipCR0A@mail.gmail.com> <20180713110851.GY2494@hirez.programming.kicks-ass.net>
Date:   Fri, 13 Jul 2018 23:15:26 +1000
Message-ID: <87tvp3xonl.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Thu, Jul 12, 2018 at 11:10:58AM -0700, Linus Torvalds wrote:
>> On Thu, Jul 12, 2018 at 11:05 AM Peter Zijlstra <peterz@infradead.org> wrote:
>> >
>> > The locking pattern is fairly simple and shows where RCpc comes apart
>> > from expectation real nice.
>> 
>> So who does RCpc right now for the unlock-lock sequence? Somebody
>> mentioned powerpc. Anybody else?
>
> RISC-V followed, because the LKMM currently states it is allowed, in
> fact LKMM is currently weaker than even PowerPC, which is what this
> current discussion is about.
>
> A number of people, including myself, are arguing for stronger lock
> ordering (RCsc) but getting the LKMM to be at least as strong as Power
> (RCtsc as coined by Daniel) which disallows full RCpc.
>
>> How nasty would be be to make powerpc conform? I will always advocate
>> tighter locking and ordering rules over looser ones..
>
> mpe did a micro-bench a little while ago:
>
>   http://lkml.iu.edu/hypermail/linux/kernel/1804.0/01990.html
>
> which says 30% more expensive for uncontended lock+unlock. Which I admit
> is fairly yuck. No macro bench results though.

I reran some numbers today with some slightly updated tests.

It varies quite a bit across machines and CPU revisions.

On one I get:

Lock/Unlock    Time             Time %    Total Cycles     Cycles  Cycles Delta
lwsync/lwsync   79,290,859,955  100.0 %   290,160,065,087  145     -
lwsync/sync    104,903,703,237  132.3 %   383,966,199,430  192     47

Another:

Lock/Unlock    Time             Time %    Total Cycles     Cycles  Cycles Delta
lwsync/lwsync  71,662,395,722   100.0 %   252,403,777,715  126     -
lwsync/sync    84,932,987,977   118.5 %   299,141,951,285  150     23


So 18-32% slower, or 23-47 cycles.

Next week I can do some macro benchmarks, to see if it's actually
detectable at all.

The other question is how they behave on a heavily loaded system.


My personal preference would be to switch to sync, we don't want to be
the only arch finding (or not finding!) exotic ordering bugs.

But we'd also rather not make our slow locks any slower than they have
to be.

cheers
