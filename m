Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD983C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971B921872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="THT3ZaH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfBAMPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 07:15:32 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44558 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfBAMPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 07:15:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bu/b7nFEJ2kP/+Hhq3XEF5fxfN9MQP+Vpv0CcIQffeg=; b=THT3ZaH8IaeQyci1Jdd7QmeTI
        BR4joPfK1s/6vNIXXn1xJgXhSVTYB97akLZbEkNAQnhvRtT3xjS/zAS7AdXzs9z+ZDrJTmWLMpTBz
        HL2o+615WUpT5j6BP62x0eAsR8ciUD3JlxCMGzaV8HBhX7qXGiamfH69Q49RaFB8288VVo1V8zkxm
        fgox/zVds4LsPGc5tTgcxQJXiKcENXNHVfD3WDTDd4rhOHOydU4O+Y2us6fx98Xe5gAvuz6pOP6Mz
        EUCQ8SnObVPgkxayPunvUMJjt6iiVvSq6FcqZau2H1R5rXsF9sefuSdbXotE/LPfgNwykI3H9RQCI
        +HBb6MxfQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gpXj0-0008Mp-Fi; Fri, 01 Feb 2019 12:15:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CD13523D667A2; Fri,  1 Feb 2019 13:15:10 +0100 (CET)
Date:   Fri, 1 Feb 2019 13:15:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 00/16] locking/lockdep: Add support for dynamic keys
Message-ID: <20190201121510.GC31516@hirez.programming.kicks-ass.net>
References: <20190109210204.192109-1-bvanassche@acm.org>
 <20190111124835.GP1900@hirez.programming.kicks-ass.net>
 <1547222103.83374.72.camel@acm.org>
 <20190111165529.GA14054@worktop.programming.kicks-ass.net>
 <1547226101.83374.80.camel@acm.org>
 <20190114125235.GB20726@hirez.programming.kicks-ass.net>
 <1547484753.83374.109.camel@acm.org>
 <20190118094808.GA27931@hirez.programming.kicks-ass.net>
 <1250147c-27bc-92e1-3ff5-211f3ba56891@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1250147c-27bc-92e1-3ff5-211f3ba56891@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 06:34:20PM -0800, Bart Van Assche wrote:

> I agree with what you wrote. The only code I know of that accesses list
> entries using RCU is the __bfs() function. In that function I found the
> following loop:
> 
> 	list_for_each_entry_rcu(entry, head, entry) { [ ... ] }

Thing is; I can't seem to find any __bfs() usage outside of graph_lock.

  count_{fwd,bwd}_deps() - takes graph lock

  check_{noncircular,redudant}() - called from check_prev_add() <-
  check_prevs_add() <- validate_chain() which takes graph lock

  find_usage{,_fwd,_bwd}
    <- check_usage() <- check_irq_usage() <- check_prev_add_irq() <-
    check_prev_add <- check_prevs_add() <- validate_chain() which takes
    graph lock

    <- check_usage_{fwd,bdw}() <- mark_lock_irq() <- mark_lock() which
    takes graph lock

Or did I miss something? If there are no __bfs() users outside of graph
lock, then we can simply remove that _rcu from the iteration, and
simplify all that.

> Since zap_class() calls list_del_rcu(&entry->entry), since a grace period
> occurs between the call_rcu() invocation and the RCU callback function,
> since at least an RCU reader lock must be held around RCU loops and since
> sleeping is not allowed while holding an RCU read lock I think there is
> no risk that __bfs() will examine a list entry after it has been freed.

So you agree that list_entry_being_freed() should only check the current
pf?



Also; yes, I seem to have completely misplaced your #14, I've not idea
how I totally lost one patch, that was certainly not intentional, sorry
about that.


