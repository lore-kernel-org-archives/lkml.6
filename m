Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0DEC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41DBF205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41DBF205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbeJXEt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 00:49:56 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:44856 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeJXEt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 00:49:56 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1gF3ET-0004yf-W5; Tue, 23 Oct 2018 22:24:54 +0200
Message-ID: <4663c2864855cdb59659af5bb855972a9b57f12f.camel@sipsolutions.net>
Subject: Re: [PATCH] Revert "workqueue: re-add lockdep dependencies for
 flushing"
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bart Van Assche <bvanassche@acm.org>, Tejun Heo <tj@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme @ lists . infradead . org" 
        <linux-nvme@lists.infradead.org>
Date:   Tue, 23 Oct 2018 22:24:35 +0200
In-Reply-To: <dc47992cfd3300884aab8885caebe1072ddd6c71.camel@sipsolutions.net>
References: <20181022151818.135163-1-bvanassche@acm.org>
         <13901aed5074f4b1fbd259d03928efb6ab40c65a.camel@sipsolutions.net>
         <094669f3df1690dec5913c2086f6a6d8c470f685.camel@sipsolutions.net>
         <1540241646.128590.16.camel@acm.org>
         <d45d54e8a46028c2b83296c5bf25a89500a289c4.camel@sipsolutions.net>
         <8d1a9c8c-fddb-7fb9-4bba-377bc6d51829@acm.org>
         (sfid-20181023_031737_471584_691D2EF3) <dc47992cfd3300884aab8885caebe1072ddd6c71.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-23 at 21:50 +0200, Johannes Berg wrote:
> 
> The reason for the report is that with the workqueue annotations, we've
> added new links to the chains that lockdep sees. I _think_ those
> annotations are correct and only create links in the chain when they are
> actually present, but since those links are between *classes* not
> *instances* these new links may cause false positives.

So over in the nvmet-rdma thread you asked:

> Are the lockdep annotations in kernel/workqueue.c correct? My understanding
> is that lock_map_acquire() should only be used to annotate mutually exclusive
> locking (e.g. mutex, spinlock). However, multiple work items associated with
> the same workqueue can be executed concurrently. From lockdep.h:
> 
> #define lock_map_acquire(l) lock_acquire_exclusive(l, 0, 0, NULL, _THIS_IP_)

Yes, I will admit that I'm not entirely sure that they are indeed
correct, because there are complexities with single-threaded/ordered and
multi-threaded workqueues.

The annotations are like this though:

1) when the work runs, we have

        lock_map_acquire(&pwq->wq->lockdep_map);
        lock_map_acquire(&work->lockdep_map);

	call_work_function()

        lock_map_release(&work->lockdep_map);
        lock_map_release(&pwq->wq->lockdep_map);

(where &work->lockdep_map is &lockdep_map in the actual code, but that's
a copy of it and we just use it because the work might free itself, it's
not relevant for lockdep's purposes)

This should be OK, since if you're running the work struct on a given
work queue you've undoubtedly caused a dependency chain of
	workqueue -> work item -> anything in the worker function.

Note that this is actually limited, see the comments around this code.


2) flush_workqueue does:

        lock_map_acquire(&wq->lockdep_map);
        lock_map_release(&wq->lockdep_map);

which causes a chain
	whatever the caller holds -> workqueue.

This should similarly be OK. Note that this already lets you find bugs,
because if you flush a workqueue that might run a work that takes a
lock, while holding the same lock, you deadlock:

CPU0			CPU1
lock(A)
			run work X on W:
			  lock(A)	// waiting to acquire
flush_workqueue(W)

-> deadlock, but flagged by lockdep even if typically work X finishes
well before CPU0 gets to lock(A).


3) start_flush_work/__flush_work

These are a bit more tricky, and actually fairly limited.

The &work->lockdep_map ones here are actually straight-forward - if you
try to wait for a work item to finish while holding a lock that this
work item might also take, you need this dependency to flag it in
lockdep.

The &pwq->wq->lockdep_map are a bit trickier. Basically, they let you
catch things like

workqueue  W
work items S1, S2
lock       A

W is single-threaded/ordered and can execute both S1 and S2.

executing S1 creates: W -> S1 -> A // let's say S1 locks A
executing S2 creates: W -> S2

Now if you do

	lock(A);
	flush_work(S2);

that seems fine, on the face of it, since S2 doesn't lock A. However,
there's a problem now. If S1 was scheduled to run before S2 but hasn't
completed yet, it might be waiting for lock(A) inside S1, and S2 is
waiting for S1 because the workqueue is single-threaded.

The way this is expressed in lockdep is that the flush side will
additionally create a dependency chain of

A -> W

with lock_map_acquire in start_flush_work(), given the right
circumstances. Together with the chains created above, you'd get a
report of

A -> W -> S1 -> A

which can cause a deadlock, even though you were trying to flush S2 and
that doesn't even show up here! This is one of the trickier reports to
actually understand, but we've had quite a few of these in the past.

I think all the conditions here are fine, and Tejun did look at them I
believe.

Now, I said this was limited - the problem here is that
start_flush_work() will only ever find a pwq in a limited amount of
scenarios, which basically means that we're creating fewer chain links
than we should. We just don't know that workqueue this item might
execute on unless it's currently pending, so if it typically completes
by the time you get to flush_work(S2), this code can no longer create
the "A -> W" dependency and will miss issues in a significant number of
cases, since that's really the typical case of flushing a work (that
it's not currently pending or running). With the "A -> W" dependency
missing we're left with just the chains

W -> S1 -> A
W -> S2
A -> S2

and don't see any problem even though it clearly exists. The original
code before Tejun's workqueue refactoring was actually better in this 
regard, I believe.

Come to think of it, perhaps we could address it by turning around the
dependencies when we run the work? then we'd end up with

     S1 -> W -> A
     S2 -> W
A -> S2

and actually _have_ a link from A back to itself in this case. But I'd
have to analyse the other cases in more detail to see whether that makes
sense. However, I don't think we depend on the S1 <-> W links much right
now, so it's tempting to do this, let's say next year after the
currently flagged issues are more under control :-)


As for your question regarding exclusive, I must admit that I don't
recall exactly why that was chosen. I want to believe I discussed that
with PeterZ back when I originally added the workqueue lockdep
annotations (before they were mostly lost), but I couldn't point you to
any discussions (which probably were on IRC anyway), and I can't say I
remember the exact details of which type of lockdep acquire to choose at
what time. I do seem to recall that it's not so much about exclusiveness
but about the type of tracking that happens internally regarding things
like lock recursion.

johannes

