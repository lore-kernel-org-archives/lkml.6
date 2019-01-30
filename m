Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E44C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A0E218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UAjfHz6k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbfA3N1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:27:23 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48976 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfA3N1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:27:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=G2lTC6aaW8j1XTqRBEhmZhbX9tXTChEr3UjB/Rn8254=; b=UAjfHz6kFrJezfX/kCuZw+g8A
        4unAFVdO/gd495CA0jbhatUpoMVEbT16ZQM3v415Id9BvcXIXHqM5uu9WCOPVWc6X+G8EOLXlqNdh
        FfNgL7883ZSFF/s0C0YiXiMODHdoF02CjlZVG9UYut+hEMWOipBIoAeF+Ss2MpsIOAS66LcNZsByy
        HtaDhvywuNt9+xSn1cdIzkY/ndB8GaTVirB3Zr/jSL60qI/5gKtpUu9u2G8Zxu4XtDkt+Yabdug/m
        zj04yaBEE5thU6rgcwuLVSF/uraYAIA31YqFR0h4M6z79TwMfRXR/mMnEKOB1zTyLt60R9cxRC80h
        6XUwebEQA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gopte-0001cY-Nf; Wed, 30 Jan 2019 13:27:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 76DDD20276ABC; Wed, 30 Jan 2019 14:27:17 +0100 (CET)
Date:   Wed, 30 Jan 2019 14:27:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, tj@kernel.org,
        sargun@sargun.me
Subject: Re: [PATCH v2] sched/fair: Fix insertion in rq->leaf_cfs_rq_list
Message-ID: <20190130132717.GC3103@hirez.programming.kicks-ass.net>
References: <1548782332-18591-1-git-send-email-vincent.guittot@linaro.org>
 <1548825767-10799-1-git-send-email-vincent.guittot@linaro.org>
 <20190130130410.GG2278@hirez.programming.kicks-ass.net>
 <20190130130620.GB3103@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130130620.GB3103@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 02:06:20PM +0100, Peter Zijlstra wrote:
> On Wed, Jan 30, 2019 at 02:04:10PM +0100, Peter Zijlstra wrote:

> > So I don't much like this; at all. But maybe I misunderstand, this is
> > somewhat tricky stuff and I've not looked at it in a while.
> > 
> > So per normal we do:
> > 
> > 	enqueue_task_fair()
> > 	  for_each_sched_entity() {
> > 	    if (se->on_rq)
> > 	      break;
> > 	    enqueue_entity()
> > 	      list_add_leaf_cfs_rq();
> > 	  }
> > 
> > This ensures that all parents are already enqueued, right? because this
> > is what enqueues those parents.
> > 
> > And in this case you add an unconditional second
> > for_each_sched_entity(); even though it is completely redundant, afaict.
> 
> Ah, it doesn't do a second iteration; it continues where the previous
> two left off.
> 
> Still, why isn't this in unthrottle?

Aah, I see, because we need:

  rq->tmp_alone_branch == &rq->lead_cfs_rq_list

at the end of enqueue_task_fair(); having had that assertion would've
saved some pain I suppose.
