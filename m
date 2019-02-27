Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AD0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2178218E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbfB0Bgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 20:36:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35260 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729574AbfB0BgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 20:36:12 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 956FF30BEE32;
        Wed, 27 Feb 2019 01:36:11 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C0D0528DE4;
        Wed, 27 Feb 2019 01:36:01 +0000 (UTC)
Date:   Wed, 27 Feb 2019 09:35:56 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Bart Van Assche <bvanassche@acm.org>, mingo@redhat.com,
        will.deacon@arm.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v7 21/23] block: Avoid that flushing triggers a lockdep
 complaint
Message-ID: <20190227013555.GA16802@ming.t460p>
References: <20190214230058.196511-1-bvanassche@acm.org>
 <20190214230058.196511-22-bvanassche@acm.org>
 <20190215022658.GB21045@ming.t460p>
 <20190226180802.GM2861@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226180802.GM2861@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 27 Feb 2019 01:36:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 07:08:02PM +0100, Peter Zijlstra wrote:
> On Fri, Feb 15, 2019 at 10:26:59AM +0800, Ming Lei wrote:
> > There might be lots of blk_flush_queue instance which is allocated
> > for each hctx, then lots of class key slot may be wasted.
> 
> What is 'lots' ? for someone who doesn't really know all that much about
> the block layer.

Each hw queue has one instance of blk_flush_queue, and one device may
has lots of hw queues(may be > all possible cpus, such as nvme), and there
may be lots of block devices in one system.

Suppose one system has 10 NVMe hosts, 8 disks attached to each host, and
256 CPU cores in the system, there can be 10 * 8 * 256 = 20K instances of
blk_flush_queue.

Not mention there are other block devices(loop, nbd, scsi, ...) in the system.

That is why I suggest to use one single lock class for addressing this
nvme loop specific issue:

https://marc.info/?l=linux-kernel&m=155019765724564&w=2

Thanks,
Ming
