Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF884C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DFE20848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78DFE20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeJZBg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 21:36:29 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:45744 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbeJZBg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 21:36:29 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1gFj1z-0006Hm-OV; Thu, 25 Oct 2018 19:02:47 +0200
Message-ID: <2cebeb88640433ce473bc40f9a5c7e06d0661e4d.camel@sipsolutions.net>
Subject: Re: [PATCH 3/3] kernel/workqueue: Suppress a false positive lockdep
 complaint
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bart Van Assche <bvanassche@acm.org>, Tejun Heo <tj@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "tytso@mit.edu" <tytso@mit.edu>
Date:   Thu, 25 Oct 2018 19:02:29 +0200
In-Reply-To: <20181025150540.259281-4-bvanassche@acm.org>
References: <20181025150540.259281-1-bvanassche@acm.org>
         <20181025150540.259281-4-bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-25 at 15:05 +0000, Bart Van Assche wrote:
> It can happen that the direct I/O queue creates and destroys an empty
> workqueue from inside a work function.

So, thinking about this more, can you guarantee (somehow) that the
workqueue is empty at this point? Perhaps then we should encode that
guarantee into the API, and actually make it WARN_ON() if something is
scheduled on it at that point? And then skip lockdep in this case.

You've actually done a superset of this here - you've basically said
this workqueue was never used, not just that it's empty right now.
However, if you could guarantee that it was never used at this point, I
guess I fail to see what you need it for anyway (or alternatively, why
you wouldn't allocate it later after this point.)

It does seem strange to me to make lockdep contingent on "has this
workqueue been used" because there may be things queued on it that only
happen in certain cases (hardware, phases of the moon ;-) ) and lockdep
sort of says "once you execute all the paths that _could_ lead to a
deadlock, I'll warn you about it, even if it never happened". It seems
that we'd want to extend that to workqueues.

Also, I think in a way what this does is try to differentiate the
classes of workqueues: used vs. not used per instance, but I'm not
really sure that's what you want - after all, could it really never have
been used? Surely it has a purpose?

But anyway, I'll need to take a better look at the lockdep splat later
(i.e. when the kids are sleeping.) Do you know how to reproduce this?

johannes

