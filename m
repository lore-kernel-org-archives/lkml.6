Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80113C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44ED020863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wU4kfxQ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbfBAI1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:27:00 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42438 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbfBAI1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:27:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bD/HAUVU3CJpn1uqh5ZgcGs2AWd8b4ab6ML6LMiPHmQ=; b=wU4kfxQ9BTUlhPVwgaGoazLS7
        QztAI8bAx8RNVk0Cp5wCtWNPCifMda4QuAuWYnJufW4dVCphxEUrcrrb3TPAYoHHG2XzC9o6xbvCu
        FP1BbXdZq60Dc7tAsEEqpiqILUJjqWI69WMiLHBgKTvzqm/PnS09756d2w5gRyzFlIvW4zHOFGMd2
        TZg3SpV3To5XixSyfhAdm2uPaMab7v/ypn+OTAacjiuiQeIfJYe4Dvx+L8Fkg/vw8hLD+Q5rVGE6W
        lm9MTVZRaoWKV77vxsFKHkAqWa4LV81Pz6ng0dAbdtuPjpvCXYbLiT6fTCeXjDPjAosfNDpRbUMUp
        NID9PsMQA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gpU9y-0005uB-Jt; Fri, 01 Feb 2019 08:26:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0C62228480B5C; Fri,  1 Feb 2019 09:26:48 +0100 (CET)
Date:   Fri, 1 Feb 2019 09:26:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2] sched: Use READ_ONCE()/WRITE_ONCE() in
 move_queued_task()/task_rq_lock()
Message-ID: <20190201082647.GA31498@hirez.programming.kicks-ass.net>
References: <20190121155240.27173-1-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121155240.27173-1-andrea.parri@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 04:52:40PM +0100, Andrea Parri wrote:
> move_queued_task() synchronizes with task_rq_lock() as follows:
> 
> 	move_queued_task()		task_rq_lock()
> 
> 	[S] ->on_rq = MIGRATING		[L] rq = task_rq()
> 	WMB (__set_task_cpu())		ACQUIRE (rq->lock);
> 	[S] ->cpu = new_cpu		[L] ->on_rq
> 
> where "[L] rq = task_rq()" is ordered before "ACQUIRE (rq->lock)" by an
> address dependency and, in turn, "ACQUIRE (rq->lock)" is ordered before
> "[L] ->on_rq" by the ACQUIRE itself.
> 
> Use READ_ONCE() to load ->cpu in task_rq() (c.f., task_cpu()) to honor
> this address dependency.  Also, mark the accesses to ->cpu and ->on_rq
> with READ_ONCE()/WRITE_ONCE() to comply with the LKMM.
> 
> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>

Thanks!
