Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B347C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD09204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:55:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD09204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731597AbeJBUih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:38:37 -0400
Received: from outbound-smtp13.blacknight.com ([46.22.139.230]:33506 "EHLO
        outbound-smtp13.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730694AbeJBUig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:38:36 -0400
Received: from mail.blacknight.com (unknown [81.17.254.10])
        by outbound-smtp13.blacknight.com (Postfix) with ESMTPS id 9B4461C2CCA
        for <linux-kernel@vger.kernel.org>; Tue,  2 Oct 2018 14:55:04 +0100 (IST)
Received: (qmail 6180 invoked from network); 2 Oct 2018 13:55:04 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.88])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 2 Oct 2018 13:55:04 -0000
Date:   Tue, 2 Oct 2018 14:54:59 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jirka Hladky <jhladky@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 2/2] mm, numa: Migrate pages to local nodes quicker early
 in the lifetime of a task
Message-ID: <20181002135459.GA7003@techsingularity.net>
References: <20181001100525.29789-1-mgorman@techsingularity.net>
 <20181001100525.29789-3-mgorman@techsingularity.net>
 <20181002124149.GB4593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20181002124149.GB4593@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 06:11:49PM +0530, Srikar Dronamraju wrote:
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 25c7c7e09cbd..7fc4a371bdd2 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -1392,6 +1392,17 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
> >  	int last_cpupid, this_cpupid;
> >
> >  	this_cpupid = cpu_pid_to_cpupid(dst_cpu, current->pid);
> > +	last_cpupid = page_cpupid_xchg_last(page, this_cpupid);
> > +
> > +	/*
> > +	 * Allow first faults or private faults to migrate immediately early in
> > +	 * the lifetime of a task. The magic number 4 is based on waiting for
> > +	 * two full passes of the "multi-stage node selection" test that is
> > +	 * executed below.
> > +	 */
> > +	if ((p->numa_preferred_nid == -1 || p->numa_scan_seq <= 4) &&
> > +	    (cpupid_pid_unset(last_cpupid) || cpupid_match_pid(p, last_cpupid)))
> > +		return true;
> >
> 
> This does have issues when using with workloads that access more shared faults
> than private faults.
> 

Not as such. It can have issues on workloads where memory is initialised
by one thread, then additional threads are created and access the same
memory. They are not necessarily shared once buffers are handed over. In
such a case, migrating quickly is the right thing to do. If it's truely
shared pages then there may be some unnecessary migrations early in the
lifetime of the task but it'll settle down quickly enough.

> In such workloads, this change would spread the memory causing regression in
> behaviour.
> 
> 5 runs of on 2 socket/ 4 node power 8 box
> 
> 
> Without this patch
> ./numa01.sh      Real:  382.82    454.29    422.31    29.72
> ./numa01.sh      Sys:   40.12     74.53     58.50     13.37
> ./numa01.sh      User:  34230.22  46398.84  40292.62  4915.93
> 
> With this patch
> ./numa01.sh      Real:  415.56    555.04    473.45    51.17    -10.8016%
> ./numa01.sh      Sys:   43.42     94.22     73.59     17.31    -20.5055%
> ./numa01.sh      User:  35271.95  56644.19  45615.72  7165.01  -11.6694%
> 
> Since we are looking at time, smaller numbers are better.
> 

Is it just numa01 that was affected for you? I ask because that particular
workload is an averse workload on any machine with more than sockets and
your machine description says it has 4 nodes. What it is testing is quite
specific to 2-node machines.

> SPECJbb did show some small loss and gains.
> 

That almost always shows small gains and losses so that's not too
surprising.

> Our numa grouping is not fast enough. It can take sometimes several
> iterations before all the tasks belonging to the same group end up being
> part of the group. With the current check we end up spreading memory faster
> than we should hence hurting the chance of early consolidation.
> 
> Can we restrict to something like this?
> 
> if (p->numa_scan_seq >=MIN && p->numa_scan_seq <= MIN+4 &&
>     (cpupid_match_pid(p, last_cpupid)))
> 	return true;
> 
> meaning, we ran atleast MIN number of scans, and we find the task to be most likely
> task using this page.
> 

What's MIN? Assuming it's any type of delay, note that this will regress
STREAM again because it's very sensitive to the starting state.

-- 
Mel Gorman
SUSE Labs
