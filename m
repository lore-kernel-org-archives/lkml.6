Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC15C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9632085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TjuvEU/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388655AbfBRRka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:40:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59062 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729728AbfBRRka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GbcwH6MTE7vIHDLQR5mHm2uiwRLpzBfLve9qxk9Cyls=; b=TjuvEU/Gwj1gh5cMJgKYIWugs
        hINJuUY0+9RgzBelD7y4eS3yvaq9np/+mogF6QCXnoQi6rOyVc32rB0LLNCyxoq1NJQD0juHtAyq4
        w5AH1srB/MRenSwTTZMTxXDTudr5FluD98vwe0UTLcc0HeoD0WA7oIRI8ZKBUVOtg02VRG49tF7x7
        TpEQwurMHc/va4lNgjtDqrGtbzDoJXmrYtls9/LY4WQe6t79MQCU+vs6aBoB5ZLmZ6KB+FCYqg5kW
        777b56VWpbqhUj7U179UNDeNMyq/Lgy5V8IQfmoPzaQDPw1FBLtzfvcxzpS0uDClUAI7Hg9tvrWei
        W3KmJz1Pw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gvmu1-0005yh-1A; Mon, 18 Feb 2019 17:40:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 146E42848B872; Mon, 18 Feb 2019 18:40:23 +0100 (CET)
Message-Id: <20190218165620.383905466@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 18 Feb 2019 17:56:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        tim.c.chen@linux.intel.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [RFC][PATCH 00/16] sched: Core scheduling
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A much 'demanded' feature: core-scheduling :-(

I still hate it with a passion, and that is part of why it took a little
longer than 'promised'.

While this one doesn't have all the 'features' of the previous (never
published) version and isn't L1TF 'complete', I tend to like the structure
better (relatively speaking: I hate it slightly less).

This one is sched class agnostic and therefore, in principle, doesn't horribly
wreck RT (in fact, RT could 'ab'use this by setting 'task->core_cookie = task'
to force-idle siblings).

Now, as hinted by that, there are semi sane reasons for actually having this.
Various hardware features like Intel RDT - Memory Bandwidth Allocation, work
per core (due to SMT fundamentally sharing caches) and therefore grouping
related tasks on a core makes it more reliable.

However; whichever way around you turn this cookie; it is expensive and nasty.

It doesn't help that there are truly bonghit crazy proposals for using this out
there, and I really hope to never see them in code.

These patches are lightly tested and didn't insta explode, but no promises,
they might just set your pets on fire.

'enjoy'

@pjt; I know this isn't quite what we talked about, but this is where I ended
up after I started typing. There's plenty design decisions to question and my
changelogs don't even get close to beginning to cover them all. Feel free to ask.

---
 include/linux/sched.h    |   9 +-
 kernel/Kconfig.preempt   |   8 +-
 kernel/sched/core.c      | 762 ++++++++++++++++++++++++++++++++++++++++++++---
 kernel/sched/deadline.c  |  99 +++---
 kernel/sched/debug.c     |   4 +-
 kernel/sched/fair.c      | 129 +++++---
 kernel/sched/idle.c      |  42 ++-
 kernel/sched/pelt.h      |   2 +-
 kernel/sched/rt.c        |  96 +++---
 kernel/sched/sched.h     | 183 ++++++++----
 kernel/sched/stop_task.c |  35 ++-
 kernel/sched/topology.c  |   4 +-
 kernel/stop_machine.c    |   2 +
 13 files changed, 1096 insertions(+), 279 deletions(-)


