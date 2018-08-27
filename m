Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCDCC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2DA208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D2DA208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeH1BbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 21:31:15 -0400
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:16838 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726994AbeH1BbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 21:31:12 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl6.internode.on.net with ESMTP; 28 Aug 2018 07:12:44 +0930
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fuPHW-0008W3-V8; Tue, 28 Aug 2018 07:42:42 +1000
Date:   Tue, 28 Aug 2018 07:42:42 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Waiman Long <longman@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] xfs: Prevent multiple wakeups of the same log
 space waiter
Message-ID: <20180827214242.GH2234@dastard>
References: <1535316795-21560-1-git-send-email-longman@redhat.com>
 <1535316795-21560-3-git-send-email-longman@redhat.com>
 <20180827002134.GE2234@dastard>
 <20180827073906.GA24831@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827073906.GA24831@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 12:39:06AM -0700, Christoph Hellwig wrote:
> On Mon, Aug 27, 2018 at 10:21:34AM +1000, Dave Chinner wrote:
> > tl; dr: Once you pass a certain point, ramdisks can be *much* slower
> > than SSDs on journal intensive workloads like AIM7. Hence it would be
> > useful to see if you have the same problems on, say, high
> > performance nvme SSDs.
> 
> Note that all these ramdisk issues you mentioned below will also apply
> to using the pmem driver on nvdimms, which might be a more realistic
> version.  Even worse at least for cases where the nvdimms aren't
> actually powerfail dram of some sort with write through caching and
> ADR the latency is going to be much higher than the ramdisk as well.

Yes, I realise that.

I am expecting that when it comes to optimising for pmem, we'll
actually rewrite the journal to map pmem and memcpy() directly
rather than go through the buffering and IO layers we currently do
so we can minimise write latency and control concurrency ourselves.
Hence I'm not really concerned by performance issues with pmem at
this point - most of our still users have traditional storage and
will for a long time to come....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
