Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395BAECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9C420779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cZ7b1jb0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9C420779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388511AbeGWQXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:23:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59542 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388055AbeGWQXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7mFXKtYMyzpmgKCtU+8mlw5jZcD1eEprS04f3H4EX/4=; b=cZ7b1jb0BByrA/zLkkOpul/oo
        uk99gn66GrVJVNrdOKlxTIqx94yG+f2Mr2w0mMsYiAMdMJfkODawsxGOuf6MuIB3YLFElA4r62J4T
        ZQuA5susowKDoWnPjCG+VgXg6RIObbznlI0kwd0d3s1/bWvEU1AJZ8OC+uX7YGhJw2pG8CyhnRDT0
        CCdIIOevfPknQPLkuvGjEEOP44DeIuHo9aGzqsxn3K/9o0wc845JicvFBMlA2hq8WYrFhq/suscs6
        uZdzPJxJgTVJzxojyGxHBJ9m1kv4QKumMfSpFUUtU8ecV2mAJyG+oCbbnklwHyxN1Nx0Z9kPlMGw3
        9tbBz/1AA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhcej-0008Q9-KJ; Mon, 23 Jul 2018 15:21:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C281620275F36; Mon, 23 Jul 2018 17:21:47 +0200 (CEST)
Date:   Mon, 23 Jul 2018 17:21:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 00/19]  Fixes for sched/numa_balancing
Message-ID: <20180723152147.GE2494@hirez.programming.kicks-ass.net>
References: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
 <20180723135700.GX2458@hirez.programming.kicks-ass.net>
 <20180723150954.GI30345@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723150954.GI30345@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 08:09:55AM -0700, Srikar Dronamraju wrote:

> > >   sched/numa: Stop multiple tasks from moving to the cpu at the same time
> 
> This patch has go-ahead from Mel and Rik and no outstanding comments.

I left it out because it's part of the big xchg() mess.

In particular:

+       if (xchg(&rq->numa_migrate_on, 1))
+               return;
+
+       if (env->best_cpu != -1) {
+               rq = cpu_rq(env->best_cpu);
+               WRITE_ONCE(rq->numa_migrate_on, 0);
+       }

I'm again confused by clearing numa_migrate_on at this point..

> > >   sched/numa: Updation of scan period need not be in lock
> 
> I didnt see any comments for this apart from an ack from Rik.
> + It thought it was trivial and shouldnt have any side-effect.

Oh, my bad I actually have this one.
