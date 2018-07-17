Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C2DECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E232146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E232146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731538AbeGQNkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:40:13 -0400
Received: from nautica.notk.org ([91.121.71.147]:52364 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731324AbeGQNkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:40:12 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 0D98AC009; Tue, 17 Jul 2018 15:07:35 +0200 (CEST)
Date:   Tue, 17 Jul 2018 15:07:20 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     jiangyiwen <jiangyiwen@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [V9fs-developer] [PATCH v2] net/9p: Fix a deadlock case in the
 virtio transport
Message-ID: <20180717130720.GA23759@nautica>
References: <5B4DCD0A.8040600@huawei.com>
 <20180717114215.GA14414@nautica>
 <5B4DE09F.5000800@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B4DE09F.5000800@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

jiangyiwen wrote on Tue, Jul 17, 2018:
> On 2018/7/17 19:42, Dominique Martinet wrote:
> > 
> >> Subject: net/9p: Fix a deadlock case in the virtio transport
> > 
> > I hadn't noticed in the v1, but how is that a deadlock fix?
> > The previous code doesn't look like it deadlocks to me, the commit
> > message is more correct.
> > 
> 
> If cpu is running in the irq context for a long time,
> NMI watchdog will detect the hard lockup in the cpu,
> and then it will cause kernel panic. So I use this
> subject to underline the scenario.

That's still not a deadlock - fix lockup would be more appropriate?


> > Do we have a guarantee that req_done is only called if there is at least
> > one buf to read?
> > For example, that there isn't two threads queueing the same callback but
> > the first one reads everything and the second has nothing to read?
> > 
> > If virtblk_done takes care of setting up a "req_done" bool to only
> > notify waiters if something has been done I'd rather have a reason to do
> > differently, even if you can argue that nothing bad will happen in case
> > of a gratuitous wake_up
> > 
> 
> Sorry, I don't fully understand what your mean.
> I think even if the ring buffer don't have the data, wakeup operation
> will not cause any other problem, and the loss of performance can be
> ignored.

I just mean "others do check, why not us?". It's almost free to check if
we had something to read, but if there are many pending read/writes
waiting for a buffer they will all wake up and spin uselessly.

I've checked other callers of virtqueue_get_buf() and out of 9 that loop
around in a callback then wake another thread up, 6 do check before
waking up, two check that something happened just to print a debug
statement if not (virtio_test and virtgpu) and one doesn't check
(virtio_input); so I guess we wouldn't be the first ones, just not
following the trend.

But yes, nothing bad will happen, so let's agree to disagree and I'll
defer to others opinion on this


Thanks,
-- 
Dominique Martinet
