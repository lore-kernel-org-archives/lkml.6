Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBE3C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE42020848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE42020848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbeJZB1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 21:27:42 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:45680 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbeJZB1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 21:27:42 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1gFitX-00067J-7e; Thu, 25 Oct 2018 18:54:03 +0200
Message-ID: <256720b373cf539052d79ce3051214140820d696.camel@sipsolutions.net>
Subject: Re: [PATCH 2/3] kernel/workqueue: Surround work execution with
 shared lock annotations
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bart Van Assche <bvanassche@acm.org>, Tejun Heo <tj@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "tytso@mit.edu" <tytso@mit.edu>
Date:   Thu, 25 Oct 2018 18:53:44 +0200
In-Reply-To: <20181025150540.259281-3-bvanassche@acm.org>
References: <20181025150540.259281-1-bvanassche@acm.org>
         <20181025150540.259281-3-bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-25 at 15:05 +0000, Bart Van Assche wrote:
> Surround execution of work with a shared lockdep annotation because multiple
> work items associated with a work queue may execute concurrently.

Hmm. So, I'm not really entirely sure of the semantics here, but I fail
to see how "may execute concurrently" means "can be taken recursively"?

After all, if they execute concurrently, that's in a different thread,
right? So each thread is really just doing something with this work. It
may not match mutex semantics in how mutexes would lock each other out
and prevent concurrency, but I don't think that matters to lockdep at
all.

In fact, I'm not sure this actually changes anything, since you can't
really execute a work struct while executing one already?

What's this intended to change? I currently don't see how lockdep's
behaviour would differ with read==1, unless you actually tried to do
recursive locking, which isn't really possible?

Or perhaps this is actually the right change for the issue described in
patch 1, where a work struct flushes another work on the same wq, and
that causes recursion of sorts? But that recursion should only happen if
the workqueues is actually marked as ordered, in which case it *is* in
fact wrong?

johannes


