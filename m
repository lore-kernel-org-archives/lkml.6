Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A911C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 18:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD3B2064E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 18:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD3B2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbeJCBHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 21:07:34 -0400
Received: from outbound-smtp12.blacknight.com ([46.22.139.17]:34270 "EHLO
        outbound-smtp12.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725951AbeJCBHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 21:07:34 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp12.blacknight.com (Postfix) with ESMTPS id BC10C1C28C8
        for <linux-kernel@vger.kernel.org>; Tue,  2 Oct 2018 19:22:50 +0100 (IST)
Received: (qmail 18471 invoked from network); 2 Oct 2018 18:22:50 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.88])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 2 Oct 2018 18:22:50 -0000
Date:   Tue, 2 Oct 2018 19:22:48 +0100
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
Message-ID: <20181002182248.GB7003@techsingularity.net>
References: <20181001100525.29789-1-mgorman@techsingularity.net>
 <20181001100525.29789-3-mgorman@techsingularity.net>
 <20181002124149.GB4593@linux.vnet.ibm.com>
 <20181002135459.GA7003@techsingularity.net>
 <20181002173005.GD4593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20181002173005.GD4593@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 11:00:05PM +0530, Srikar Dronamraju wrote:
> > > 
> > > This does have issues when using with workloads that access more shared faults
> > > than private faults.
> > > 
> > 
> > Not as such. It can have issues on workloads where memory is initialised
> > by one thread, then additional threads are created and access the same
> > memory. They are not necessarily shared once buffers are handed over. In
> > such a case, migrating quickly is the right thing to do. If it's truely
> > shared pages then there may be some unnecessary migrations early in the
> > lifetime of the task but it'll settle down quickly enough.
> > 
> 
> Do you have a workload recommendation to try for shared fault accesses.

NAS parallelised with OMP tends to be ok but I haven't quantified if it's
perfect or a good example. I don't have an example of a workload that
is good at targetting the specific case where pages are shared between
tasks that tend to run on separate nodes. It would be somewhat of an
anti-pattern for any workload regardless of automatic NUMA balancing.

> > > <SNIP>
> > >
> > > Our numa grouping is not fast enough. It can take sometimes several
> > > iterations before all the tasks belonging to the same group end up being
> > > part of the group. With the current check we end up spreading memory faster
> > > than we should hence hurting the chance of early consolidation.
> > > 
> > > Can we restrict to something like this?
> > > 
> > > if (p->numa_scan_seq >=MIN && p->numa_scan_seq <= MIN+4 &&
> > >     (cpupid_match_pid(p, last_cpupid)))
> > > 	return true;
> > > 
> > > meaning, we ran atleast MIN number of scans, and we find the task to be most likely
> > > task using this page.
> > > 
> > 
> 
> 
> > What's MIN? Assuming it's any type of delay, note that this will regress
> > STREAM again because it's very sensitive to the starting state.
> > 
> 
> I was thinking of MIN as 3 to give a chance for things to settle.
> but that might not help STREAM as you pointed out.
> 

Probably not.

> Do you have a hint on which commit made STREAM regress?
> 

2c83362734da ("sched/fair: Consider SD_NUMA when selecting the most idle group to schedule on")

Reverting it hurts workloads that communicate immediately with new processes
or threads as workloads spread prematurely and then get pulled back just
after clone.

> if we want to prioritize STREAM like workloads (i.e private faults) one simpler
> fix could be to change the quadtraic equation
> 
> from:
> 	if (!cpupid_pid_unset(last_cpupid) &&
> 				cpupid_to_nid(last_cpupid) != dst_nid)
> 		return false;
> to:
> 	if (!cpupid_pid_unset(last_cpupid) &&
> 				cpupid_to_nid(last_cpupid) == dst_nid)
> 		return true;
> 
> i.e to say if the group tasks likely consolidated to a node or the task was
> moved to a different node but access were private, just move the memory.
> 
> The drawback though is we keep pulling memory everytime the task moves
> across nodes. (which is probably restricted for long running tasks to some
> extent by your fix)
> 

This has way more consequences as it changes the behaviour for the entire
lifetime of the workload. It could cause excessive migrations in the case
where a machine is almost fully utilised and getting load balanced or in
cases where tasks are pulled frequently cross-node (e.g. worker thread
model or a pipelined computation).

I'm only looking to address the case where the load balancer spreads a
workload early and the memory should move to the new node quickly. If it
turns out there are cases where that decision is wrong, it gets remedied
quickly but if your proposal is ever wrong, the system doesn't recover.

-- 
Mel Gorman
SUSE Labs
