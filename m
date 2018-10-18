Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EABCC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3B0208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rWx7GeRV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3B0208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeJRRFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:05:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40338 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbeJRRFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EswSLoEMlBvoYgXbjoVLcGGXTkxK5K7C3pahk5Zvq+Y=; b=rWx7GeRVQkco22WsEx7Fq2hyg
        dXQegWpQTWi1137nExpsgyvf1QP63Dyzhn/17AlKuw55l7PVoDxeqBqwODHyjh4I8UUTvRtCKKWwT
        mYKcmWgsdPdDtirVrQ1TszTZXNSmV5cam0wM/s2XQyDyxvUUFAUjqFMCjPFiS3EgGczFwtBnwKAAN
        z4FRkKcJIQ1wq4i2T++Lly1NR6uDV0Zs1I3j6kGXESWDNmLv97crbzbxqBwW4vntqY18BhpnJrB/P
        qKTi344cUQfUVLAFQeF4JhWyXRky0ehA1vYWNHShgZ+5m1K619NqVVYOevPlid0U9l9pqpPfGn2g4
        m78oBoJGw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gD4FX-0003bH-Sk; Thu, 18 Oct 2018 09:05:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 47FAB2029856A; Thu, 18 Oct 2018 11:05:45 +0200 (CEST)
Date:   Thu, 18 Oct 2018 11:05:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] locking/qspinlock_stat: Count instances of nested
 lock slowpaths
Message-ID: <20181018090545.GV3121@hirez.programming.kicks-ass.net>
References: <1539697507-28084-1-git-send-email-longman@redhat.com>
 <20181017073833.GE3121@hirez.programming.kicks-ass.net>
 <b3931b5a-1695-b273-132c-662f1c8c3a14@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3931b5a-1695-b273-132c-662f1c8c3a14@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 05:06:46PM -0400, Waiman Long wrote:
> On 10/17/2018 03:38 AM, Peter Zijlstra wrote:
> > On Tue, Oct 16, 2018 at 09:45:06AM -0400, Waiman Long wrote:
> >> Queued spinlock supports up to 4 levels of lock slowpath nesting -
> >> user context, soft IRQ, hard IRQ and NMI. However, we are not sure how
> >> often the nesting happens. So 3 more per-cpu stat counters are added
> >> to track the number of instances where nesting index goes to 1, 2 and
> >> 3 respectively.
> >>
> >> On a dual-socket 64-core 128-thread Zen server, the following were stat
> >> counter values under different circumstances.
> >>
> >>          State                      slowpath   index1   index2   index3
> >>          -----                      --------   ------   ------   -------
> >>   After bootup                      1,012,150    82       0        0
> >>   After parallel build + perf-top 125,195,009    82       0        0
> > Would probably be good to check a network workload.
> 
> Do you have any suggestion of what network workload? I usually don't
> test on network related workload.

Some netperf runs? Be sure to ask the network folks for 2 systems with
at least 10GBe or something.

> The only way to have a nesting level of 3 is when there is lock
> contention in user context, soft IRQ and hard IRQ simultaneously which
> is very rare,

network should be able to trigger a lot of softirq and hardirqs, which
is why I wondered if it could hit significant 3 levels.

But yeah, I played around a bit, and couldn't get my index* numbers to
move at all. I suppose we've gotten really good at avoiding lock
contention for all the benchmarks we care about :-)
