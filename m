Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF66C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF9320834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF9320834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbeJZDv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:51:56 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:47456 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbeJZDv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:51:56 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1gFl8g-0000Hw-0V; Thu, 25 Oct 2018 21:17:50 +0200
Message-ID: <679b4dc32eaf3c4dee3aa02175dcffa12a258dc8.camel@sipsolutions.net>
Subject: Re: [PATCH 2/3] kernel/workqueue: Surround work execution with
 shared lock annotations
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bart Van Assche <bvanassche@acm.org>, Tejun Heo <tj@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "tytso@mit.edu" <tytso@mit.edu>
Date:   Thu, 25 Oct 2018 21:17:29 +0200
In-Reply-To: <1540488162.66186.35.camel@acm.org> (sfid-20181025_192247_142973_0CC4C4B6)
References: <20181025150540.259281-1-bvanassche@acm.org>
         <20181025150540.259281-3-bvanassche@acm.org>
         <256720b373cf539052d79ce3051214140820d696.camel@sipsolutions.net>
         <1540488162.66186.35.camel@acm.org> (sfid-20181025_192247_142973_0CC4C4B6)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-25 at 10:22 -0700, Bart Van Assche wrote:

> > What's this intended to change? I currently don't see how lockdep's
> > behaviour would differ with read==1, unless you actually tried to do
> > recursive locking, which isn't really possible?
> > 
> > Or perhaps this is actually the right change for the issue described in
> > patch 1, where a work struct flushes another work on the same wq, and
> > that causes recursion of sorts? But that recursion should only happen if
> > the workqueues is actually marked as ordered, in which case it *is* in
> > fact wrong?
> 
> How about modifying the wq->lockdep_map annotations only and not touching the
> work->lockdep_map annotations? My comment about concurrency in the patch
> description refers to a multithreaded workqueue executing multiple different
> work items concurrently. I am aware that great care has been taken in the
> workqueue implementation to ensure that each work item is executed by exactly
> one worker.

Again, I'm not sure what you'd want to achieve by that?

If you look at lockdep, read==1 really doesn't do all that much. Note
read is the 4th arg to lock_acquire() via lock_acquire_shared().

Hold time statistics are accounted differently, but that's meaningless
here.

check_deadlock() will behave differently - if read==2 (recursive read)
it will not complain about recursing into a previous read==1 acquire.
Not relevant here, because you can't recurse into the workqueue while
you're running on it.

Some in-IRQ things are different, but we can't be in-IRQ here.


Note that lockdep doesn't care about multiple threads "holding" the same
lock. Everything it does in terms of this tracking is per-thread, afaict
(uses "current" everywhere, and that's how the reports look like etc.).
So ultimately the only places where this read==1 would matter cannot be
hit (recursion within the same thread). Importantly, it doesn't try to
track across the whole system if you're holding the same lock twice.
That's actually impossible with most locks anyway (one would wait), but
when it does happen like it can here, it doesn't really do anything bad.


I don't think it actually *breaks* anything to make this a read/write
lock, because even with a read/write lock you still get a deadlock if
you do

read(A)
		lock(B)
		write(A)
lock(B)

or

write(A)
		lock(B)
		read(A)
lock(B)


since read/write are mutually exclusive, and you're not changing the
flush-side to also be a readlock. If you were, I'd argue that'd be wrong
since then you *don't* detect such deadlocks:

read(A)
		lock(B)
		read(A)
lock(B)

would not result in a complaint (I think), but in the workqueue case it
*should* because you can't flush the workqueue while holding a lock that
you also hold in a work that's executing on it.


So in the end, I just simply don't see a point in this, and I don't
think you've sufficiently explained why this change should be made.

johannes

