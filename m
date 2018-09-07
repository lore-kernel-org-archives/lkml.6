Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD15BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03BBE2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03BBE2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbeIGTBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 15:01:15 -0400
Received: from outbound-smtp27.blacknight.com ([81.17.249.195]:54530 "EHLO
        outbound-smtp27.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728364AbeIGTBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 15:01:14 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp27.blacknight.com (Postfix) with ESMTPS id 0BBE7B870A
        for <linux-kernel@vger.kernel.org>; Fri,  7 Sep 2018 15:20:04 +0100 (IST)
Received: (qmail 7449 invoked from network); 7 Sep 2018 14:20:03 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.88])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 7 Sep 2018 14:20:03 -0000
Date:   Fri, 7 Sep 2018 15:20:02 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] sched/numa: Stop comparing tasks for NUMA placement
 after selecting an idle core
Message-ID: <20180907142002.GF1719@techsingularity.net>
References: <20180907101139.20760-1-mgorman@techsingularity.net>
 <20180907101139.20760-4-mgorman@techsingularity.net>
 <20180907130553.GB3995@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20180907130553.GB3995@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 06:35:53PM +0530, Srikar Dronamraju wrote:
> * Mel Gorman <mgorman@techsingularity.net> [2018-09-07 11:11:38]:
> 
> > task_numa_migrate is responsible for finding a core on a preferred NUMA
> > node for a task. As part of this, task_numa_find_cpu iterates through
> > the CPUs of a node and evaulates CPUs, both idle and with running tasks,
> > as placement candidates. Generally though, any idle CPU is equivalent in
> > terms of improving imbalances and a search after finding one is pointless.
> > This patch stops examining CPUs on a node if an idle CPU is considered
> > suitable.
> > 
> 
> However there can be a thread on the destination node that might benefit
> from swapping with the current thread. Don't we loose that opportunity to
> swap if skip checking for other threads?
> 
> To articulate.
> Thread A currently running on node 0 wants to move to node 1.
> Thread B currently running on node 1 is better of if it ran on node 0.
> 
> Thread A seems idle cpu before seeing Thread B; skips and looses
> an opportunity to swap.
> 
> Eventually thread B will get an opportunity to move to node 0, when thread B
> calls task_numa_placement but we are probably stopping it from achieving
> earlier.
> 

Potentially this opportunity is missed but I think the only case where
swapping is better than an idle CPU is when both tasks are not running
on their preferred node. For that to happen, it would likely require that
the machine be heavily saturated (or both would just find idle cores). I
would think that's the rare case and it's better just to save the cycles
searching through runqueues and examining tasks and just take the idle
CPU. Furthermore, swapping is guaranteed to disrupt two tasks as they
have to be dequeued, migrated and requeued for what may or may not be an
overall performance gain. Lastly, even if it's the case that there is a
swap candidate out there, that does not justify calling select_idle_sibling
for every idle CPU encountered which is what happens currently.

I think the patch I have is almost certain a win (reduced search costs)
and continuing the search just in case there is a good swap candidate
out there is often going to cost more than it saves.

-- 
Mel Gorman
SUSE Labs
