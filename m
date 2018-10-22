Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1BBC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC6620651
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC6620651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbeJWEtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 00:49:07 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:53318 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeJWEtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 00:49:06 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1gEgow-0002XR-JC; Mon, 22 Oct 2018 22:29:02 +0200
Message-ID: <094669f3df1690dec5913c2086f6a6d8c470f685.camel@sipsolutions.net>
Subject: Re: [PATCH] Revert "workqueue: re-add lockdep dependencies for
 flushing"
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bart Van Assche <bvanassche@acm.org>, Tejun Heo <tj@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme @ lists . infradead . org" 
        <linux-nvme@lists.infradead.org>
Date:   Mon, 22 Oct 2018 22:28:42 +0200
In-Reply-To: <13901aed5074f4b1fbd259d03928efb6ab40c65a.camel@sipsolutions.net>
References: <20181022151818.135163-1-bvanassche@acm.org>
         <13901aed5074f4b1fbd259d03928efb6ab40c65a.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-22 at 22:14 +0200, Johannes Berg wrote:

> "False positives" - which in this case really should more accurately be
> called "bad lockdep annotations" - of the kind you report here are
> inherent in how lockdep works, and thus following your argument to the
> ultimate conclusion you should remove lockdep.

> I must also say that I'm disappointed you'd try to do things this way.
> I'd be (have been?) willing to actually help you understand the problem
> and add the annotations, but rather than answer my question ("where do I
> find the right git tree"!) you just send a revert patch.

Actually, wait, you have a different problem in the patch than the one
you reported earlier? Which I haven't even seen at all...

And this one is actually either the same missing subclass annotation, or
completely valid. You have here

 * dio/... workqueue
 * dio->complete_work, running on that workqueue
 * i_mutex_key#16

The lockdep report even more or less tells you what's going on. Perhaps
we need to find a way to make lockdep not print "lock()" but "start()"
or "flush()" for work items ... but if you read it this way, you see:

CPU0			CPU1

lock(i_mutex_key)
			start(dio->complete_work)
			lock(i_mutex_key)
flush(wq dio/...)

which is *clearly* a problem. You can't flush a workqueue under lock
that is (or might be) currently running a work item that takes the same
lock. You've already acquired the lock, and so the complete_work is
waiting for the lock, but you're now in the flush waiting for it to
finish ... pretty much a classic ABBA deadlock, just with workqueues.

It's possible, of course, that multiple instances of the same class are
involved and they're somehow ordered/nested in a way that is in fact
safe, say in this case CPU0 and CPU1 have acquired (or are trying to
acquire) fundamentally different instances of "i_mutex_key#16", or the
dio->complete_work here doesn't actually run on the dio workqueue in
question, but somehow a different one.

With workqueues, it's also possible that something out-of-band, other
than the flush_workqueue(), prevents dio->complete_work from being
running at this point in time - but in that case you might actually be
able to get rid of the flush_workqueue() entirely.

It ought to be possible to annotate this too though, but again, I'm not
an expert on what the correct and safe nesting here would be, and thus
wouldn't be able to say how to do it.

johannes

