Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800FFC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C10720834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C10720834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbeJZEeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 00:34:10 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:47972 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeJZEeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 00:34:10 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1gFlnS-00011P-M5; Thu, 25 Oct 2018 21:59:58 +0200
Message-ID: <ea0342ec3d6b9b3504e1110cf1e0d3b1af28d877.camel@sipsolutions.net>
Subject: Re: [PATCH 3/3] kernel/workqueue: Suppress a false positive lockdep
 complaint
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bart Van Assche <bvanassche@acm.org>, Tejun Heo <tj@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "tytso@mit.edu" <tytso@mit.edu>
Date:   Thu, 25 Oct 2018 21:59:38 +0200
In-Reply-To: <1540482948.66186.21.camel@acm.org> (sfid-20181025_175553_256485_FAC088A9)
References: <20181025150540.259281-1-bvanassche@acm.org>
         <20181025150540.259281-4-bvanassche@acm.org>
         <f7e631f3957f8e4d00b1b2dbf5b660d62d9e45e3.camel@sipsolutions.net>
         <1540482948.66186.21.camel@acm.org> (sfid-20181025_175553_256485_FAC088A9)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-25 at 08:55 -0700, Bart Van Assche wrote:

> Please have a look at the call trace in the description of this patch and also
> at the direct I/O code. The lockdep complaint in the description of this patch
> really is a false positive. 

I agree. I just don't agree that it's a false positive because of the
lockdep tracking of workqueues (which you're essentially saying since
you want to change it), I think it's a false positive because the user
isn't telling lockdep properly what it's doing.

> What I think needs further discussion is on how to
> address this false positive - track whether or not a work queue has been used
> or follow Tejun's proposal that I became aware of after I posted this patch,
> namely introduce a new function for destroying a work queue that skips draining,
> e.g. destroy_workqueue_skip_drain() (https://lkml.org/lkml/2018/10/24/2).

Agree. Ted's suggestion is basically what I meant in my other email when
I said:

> So, thinking about this more, can you guarantee (somehow) that the
> workqueue is empty at this point?

(I hadn't looked at the code then - obviously that's guaranteed)

> Perhaps then we should encode that
> guarantee into the API, and actually make it WARN_ON() if something is
> scheduled on it at that point? And then skip lockdep in this case.

So that API I'm talking about is what Ted suggests with
destroy_never_used_workqueue() or Tejun's suggestion of
destroy_workqueue_skip_drain(). Either is fine with me, though I'd
probably think it would make sense to actually check that it really was
never used, or at least is actually empty right now and thus doesn't
need the train.

However, I think more generally useful would be the
destroy_workqueue_nested() API I've proposed in my other reply just
moments ago, since that could be used in other code with non-empty
workqueues, as long as you can ensure that there's a guaranteed layering
of them. Then you could even have two objects A and B of the same class,
but separate instances, and flush B's workqueue from a work executing on
A's workqueue, which may come in handy in other places to address false
positives similar to this one.

johannes

