Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87ECEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E662147C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pSDvhsBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbfB0OZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:25:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55724 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbfB0OZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:25:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PoToglWvtq+BqOVrc5XJV1F0xAESw7WRdlO8ZI4fTpk=; b=pSDvhsBkXrJtUY98k4H+/+7qR
        icGLi1YVu1/ruhTj1cspgXjBEmgMtYFKXQIRFmoWF/ifVohsF7WSSdHX7k65yIAMzS0GdB+naoCoO
        oMu10sJJ2REDJsq80Oe79jb4D81gYXnig8XwJRfMuEsQrbL3wYtC3+eN7tECI3h2639EGRUaARAGc
        Kc98SYArgveNOXjE74W6xbhMeYUOM8gxxG7bq1dR4XOf8xgD/dA0R/G7D6Ce02aoBwYvLGFkOPdrQ
        U4dSEdFL9OU6wdkzNB35EAkgXwtOfqrJ+q+AM6HpQNWEZdgne99pXT9hGgGxa4Gn8hxCN5oVTPyHM
        EUIz4qnrQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gz08i-0003ie-KQ; Wed, 27 Feb 2019 14:24:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 21C7125E4178F; Wed, 27 Feb 2019 15:24:51 +0100 (CET)
Date:   Wed, 27 Feb 2019 15:24:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, mingo@redhat.com,
        will.deacon@arm.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v7 21/23] block: Avoid that flushing triggers a lockdep
 complaint
Message-ID: <20190227142451.GQ32494@hirez.programming.kicks-ass.net>
References: <20190214230058.196511-1-bvanassche@acm.org>
 <20190214230058.196511-22-bvanassche@acm.org>
 <20190215022658.GB21045@ming.t460p>
 <20190226180802.GM2861@worktop.programming.kicks-ass.net>
 <20190227013555.GA16802@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227013555.GA16802@ming.t460p>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 09:35:56AM +0800, Ming Lei wrote:
> On Tue, Feb 26, 2019 at 07:08:02PM +0100, Peter Zijlstra wrote:
> > On Fri, Feb 15, 2019 at 10:26:59AM +0800, Ming Lei wrote:
> > > There might be lots of blk_flush_queue instance which is allocated
> > > for each hctx, then lots of class key slot may be wasted.
> > 
> > What is 'lots' ? for someone who doesn't really know all that much about
> > the block layer.
> 
> Each hw queue has one instance of blk_flush_queue, and one device may
> has lots of hw queues(may be > all possible cpus, such as nvme), and there
> may be lots of block devices in one system.
> 
> Suppose one system has 10 NVMe hosts, 8 disks attached to each host, and
> 256 CPU cores in the system, there can be 10 * 8 * 256 = 20K instances of
> blk_flush_queue.
> 
> Not mention there are other block devices(loop, nbd, scsi, ...) in the system.
> 
> That is why I suggest to use one single lock class for addressing this
> nvme loop specific issue:
> 
> https://marc.info/?l=linux-kernel&m=155019765724564&w=2

Right; that is rather a lot. But what causes the recursion, and thus how
is it specific to NVME ?
