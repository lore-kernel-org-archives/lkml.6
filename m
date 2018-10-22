Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816F9C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 21:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E7020665
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 21:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E7020665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbeJWFYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 01:24:52 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:55912 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbeJWFYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 01:24:51 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1gEhNO-0003Hr-DQ; Mon, 22 Oct 2018 23:04:38 +0200
Message-ID: <d45d54e8a46028c2b83296c5bf25a89500a289c4.camel@sipsolutions.net>
Subject: Re: [PATCH] Revert "workqueue: re-add lockdep dependencies for
 flushing"
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bart Van Assche <bvanassche@acm.org>, Tejun Heo <tj@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme @ lists . infradead . org" 
        <linux-nvme@lists.infradead.org>
Date:   Mon, 22 Oct 2018 23:04:19 +0200
In-Reply-To: <1540241646.128590.16.camel@acm.org> (sfid-20181022_225411_316091_CE34F84D)
References: <20181022151818.135163-1-bvanassche@acm.org>
         <13901aed5074f4b1fbd259d03928efb6ab40c65a.camel@sipsolutions.net>
         <094669f3df1690dec5913c2086f6a6d8c470f685.camel@sipsolutions.net>
         <1540241646.128590.16.camel@acm.org> (sfid-20181022_225411_316091_CE34F84D)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-22 at 13:54 -0700, Bart Van Assche wrote:
> On Mon, 2018-10-22 at 22:28 +0200, Johannes Berg wrote:
> > The lockdep report even more or less tells you what's going on. Perhaps
> > we need to find a way to make lockdep not print "lock()" but "start()"
> > or "flush()" for work items ... but if you read it this way, you see:
> > 
> > CPU0			CPU1
> > 
> > lock(i_mutex_key)
> > 			start(dio->complete_work)
> > 			lock(i_mutex_key)
> > flush(wq dio/...)
> > 
> > which is *clearly* a problem.
> 
> Your patch made lockdep report that the direct I/O code deadlocks although it
> clearly doesn't deadlock. So where do you think the bug is? In the direct I/O
> code or in your patch?

I think you see things too black and white.

When lockdep was added, the networking socket locks also were (mostly)
fine, recursion there only happened on different types of sockets. Yet,
lockdep did in fact report issues with it, because originally they
weren't split into different classes.

Did we remove lockdep again because it was reporting a potential problem
in the socket lock code?

> The code in the column with label "CPU0" is code called by do_blockdev_direct_IO().
> From the body of that function:
> 
> 			/* will be released by direct_io_worker */
> 			inode_lock(inode);

I don't think this is related. If this comment is true (and I have no
reason to believe it's not), then the inode lock is - by nature of
allowing lock/unlock to happen in different processes - not something
lockdep can track to start with.

> I think that is sufficient evidence that the direct I/O code is fine 

I have no reason to doubt that.

> and that
> your patch caused lockdep to produce an incorrect deadlock report.

Obviously, I disagree.

As I thought I made pretty clear, the report is in fact valid. I have no
reason to believe your judgement that the code is also valid.

However, you're basically assuming that these two statements are
mutually exclusive, when they aren't. Just like the socket lock I've
been pointing to, there are things that lockdep doesn't know about
unless you teach it.

Yes, adding workqueues to lockdep tracking has the effect that now it'll
give you a report about "non-issues" because it doesn't know about
subclasses (of work items/workqueues) that happen to be fine for
recursion / flushing with locks held.

This isn't really a new thing. Any kind of lock that lockdep tracks has
exactly this problem. We've solved this in the past without giving up
and saying "I don't like this report, so let's remove lockdep".

I really don't understand how you can argue that lockdep tracking
something is a *bad* thing. You do realize that this workqueue tracking
stuff has been around for a few years (and got removed again in
refactoring, etc.) and has found countless bugs? When it was first added
to the very old workqueue code, I analysed countless bugs and told
people that no, flushing a work struct under a lock that was also taken
by the work struct is in fact _not_ a good thing to do.

johannes

