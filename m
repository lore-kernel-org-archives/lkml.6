Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3B6C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202212054F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 202212054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbeJZFAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 01:00:41 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:48260 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbeJZFAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 01:00:40 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1gFmD2-0001Vk-0D; Thu, 25 Oct 2018 22:26:24 +0200
Message-ID: <fa36b3c2bc560c40885ad9502ad1ea69af3b6597.camel@sipsolutions.net>
Subject: Re: [PATCH 3/3] kernel/workqueue: Suppress a false positive lockdep
 complaint
From:   Johannes Berg <johannes@sipsolutions.net>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Bart Van Assche <bvanassche@acm.org>, Tejun Heo <tj@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Date:   Thu, 25 Oct 2018 22:26:04 +0200
In-Reply-To: <20181025202125.GA25649@thunk.org>
References: <20181025150540.259281-1-bvanassche@acm.org>
         <20181025150540.259281-4-bvanassche@acm.org>
         <f7e631f3957f8e4d00b1b2dbf5b660d62d9e45e3.camel@sipsolutions.net>
         <1540482948.66186.21.camel@acm.org>
         <ea0342ec3d6b9b3504e1110cf1e0d3b1af28d877.camel@sipsolutions.net>
         <20181025202125.GA25649@thunk.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-25 at 16:21 -0400, Theodore Y. Ts'o wrote:

> We can guarantee it from someone who is looking at the code path.  In
> dio_set_defer_completion:

[snip]

Right, it's indeed pretty obvious. I shouldn't have tried to reply
before the kids went to bed, that made me cut some corners ;-)

> The race found in the syzbot reproducer has multiple threads all
> running DIO writes at the same time.  So we have multiple threads
> calling sb_init_dio_done_wq, but all but one will lose the race, and
> then call destry_workqueue on the freshly created (but never used)
> workqueue.

Right.

> We could replace the destroy_workqueue(wq) with a
> "I_solemnly_swear_this_workqueue_has_never_been_used_please_destroy(wq)".

:-)

> Or, as Tejun suggested, "destroy_workqueue_skip_drain(wq)", but there is
> no way for the workqueue code to know whether the caller was using the
> interface correctly.  So this basically becomes a philosophical
> question about whether or not we trust the caller to be correct or
> not.

Right. Same with the lockdep annotation I suggested over in my other
email, of course. I think that the set of APIs I wrote there
({drain,flush,destroy}_workqueue_nested()) might be more generally
useful in other cases, not just this one, and I suspect that this code
would basically be the only user of destroy_workqueue_skip_drain().

> I don't see an obvious way that we can test to make sure the workqueue
> is never used without actually taking a performance.  Am I correct
> that we would need to take the wq->mutex before we can mess with the
> wq->flags field?

I don't really know, sorry.

johannes

