Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FC6ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB33020846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB33020846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbeGWFDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 01:03:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:48454 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725754AbeGWFDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 01:03:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 668E9AE62;
        Mon, 23 Jul 2018 04:04:28 +0000 (UTC)
Date:   Sun, 22 Jul 2018 21:04:23 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Mark Ray <mark.ray@hpe.com>,
        Joe Mario <jmario@redhat.com>,
        Scott Norton <scott.norton@hpe.com>
Subject: Re: [PATCH v2] locking/rwsem: Take read lock immediate if queue
 empty with no writer
Message-ID: <20180723040423.hntq6dzzzf3sagfb@linux-r8p5>
References: <1531506653-5244-1-git-send-email-longman@redhat.com>
 <20180718161639.GT2494@hirez.programming.kicks-ass.net>
 <d9a125b2-3421-9c11-ff30-78812e42edc5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d9a125b2-3421-9c11-ff30-78812e42edc5@redhat.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2018, Waiman Long wrote:

>The key here is that we don't want other incoming readers to observe
>that there are waiters in the wait queue and hence have to go into the
>slowpath until the single waiter in the queue is sure that it probably
>will need to go to sleep if there is writer.
>
>With a constant stream of incoming readers, a major portion of them will
>observe the a negative count and be serialized to enter the slowpath.
>There are certainly other readers that do not observe the negative count
>in the in between period after one reader clear the count in the unlock
>path and a waiter set the count to negative again. Those readers can go
>ahead and do the read in parallel. But it is the serialized readers that
>cause the performance loss and the observation of spinlock contention in
>the perf output.

This makes sense and seems feasible in that the optimization is done with
the wait_lock held.

>
>It is the constant stream of incoming readers that sustain the spinlock
>queue and the repeated clearing and negative setting of the count.

This would not affect optimistic spinners that haven't yet arrived at the
waitqueue phase because the lock is anonymously owned, so they won't spin
in the first place, right?

Thanks,
Davidlohr
