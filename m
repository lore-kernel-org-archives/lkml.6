Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580A7C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1389820813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1389820813
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbeJXEXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 00:23:21 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:44464 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725740AbeJXEXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 00:23:21 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1gF2or-0004RV-5j; Tue, 23 Oct 2018 21:58:25 +0200
Message-ID: <adabc379f7d90ba018ac88877d6e9c42418360f7.camel@sipsolutions.net>
Subject: Re: [PATCH] Revert "workqueue: re-add lockdep dependencies for
 flushing"
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bart Van Assche <bvanassche@acm.org>, Tejun Heo <tj@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme @ lists . infradead . org" 
        <linux-nvme@lists.infradead.org>
Date:   Tue, 23 Oct 2018 21:58:04 +0200
In-Reply-To: <3abaaea3cd2477fbcf8830f0dd34dbfcc4cfbcc2.camel@sipsolutions.net>
References: <20181022151818.135163-1-bvanassche@acm.org>
         <13901aed5074f4b1fbd259d03928efb6ab40c65a.camel@sipsolutions.net>
         <094669f3df1690dec5913c2086f6a6d8c470f685.camel@sipsolutions.net>
         <1540241646.128590.16.camel@acm.org>
         (sfid-20181022_225411_316091_CE34F84D) <d45d54e8a46028c2b83296c5bf25a89500a289c4.camel@sipsolutions.net>
         <1540243592.128590.36.camel@acm.org>
         (sfid-20181022_232636_906722_14E48F04) <3abaaea3cd2477fbcf8830f0dd34dbfcc4cfbcc2.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-23 at 21:44 +0200, Johannes Berg wrote:

> > There is
> > no agreement however that the kind of checking implemented by the "crosslock"
> > code made sense. My understanding is that you are trying to reintroduce
> > through a backdoor some of the crosslock code. 
> 
> Not at all.

Perhaps I should elaborate on this, although I'm not really entirely
sure of it.

As I understand it, crosslock was trying to solve an entirely different
problem, namely that of tracking locks that can be acquired in one
thread, and released in another. This obviously still causes deadlocks,
but doesn't lend itself to actual tracking in the lockdep chain, since
you don't really know how directly long the lock was held.

With a classic mutex (spinlock, ...), you always have

lock(A)
do_something()
unlock(A)

in the same thread, so if do_something() contains another lock(B), you
know that you've got a dependency A->B.

If A instead is something that might be released in another thread, e.g.
a completion or semaphore, it's really hard to tell whether you have

down(A)
do_something()
up(A)

in a single thread, or if the up(A) happens elsewhere entirely.
Therefore, things like this aren't tracked by lockdep at all.

Crosslock tried to address this.

The workqueue annotations, on the other hand, *are* within the same
thread. You're either executing from the work struct, and the same
thread will obviously end up going out of the work struct again, or
you're flushing (and waiting) for the workqueue, so all of that also
happens in the same thread (apart from the actual work that you wait
for, but that's unrelated).

johannes

