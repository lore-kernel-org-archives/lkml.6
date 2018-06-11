Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id qv7XLPiCHlsREQAAmS7hNA
	; Mon, 11 Jun 2018 14:11:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E2FF6607A4; Mon, 11 Jun 2018 14:11:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5D955600D0;
	Mon, 11 Jun 2018 14:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5D955600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933724AbeFKOLS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:11:18 -0400
Received: from outbound-smtp04.blacknight.com ([81.17.249.35]:53167 "EHLO
        outbound-smtp04.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932394AbeFKOLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:11:16 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp04.blacknight.com (Postfix) with ESMTPS id 81FF298939
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 14:11:14 +0000 (UTC)
Received: (qmail 32286 invoked from network); 11 Jun 2018 14:11:14 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.237.171])
  by 81.17.254.9 with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 11 Jun 2018 14:11:14 -0000
Date: Mon, 11 Jun 2018 15:11:13 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Jirka Hladky <jhladky@redhat.com>
Cc: Jakub Racek <jracek@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        "kkolakow@redhat.com" <kkolakow@redhat.com>
Subject: Re: [4.17 regression] Performance drop on kernel-4.17 visible on
 Stream, Linpack and NAS parallel benchmarks
Message-ID: <20180611141113.pfuttg7npch3jtg6@techsingularity.net>
References: <CAE4VaGBRFBM-uZEE=DdUzQkcNmpnUHdjK-7hgEeywmG8bvOOgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAE4VaGBRFBM-uZEE=DdUzQkcNmpnUHdjK-7hgEeywmG8bvOOgw@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 12:04:34PM +0200, Jirka Hladky wrote:
> Hi Mel,
> 
> your suggestion about the commit which has caused the regression was right
> - it's indeed this commit:
> 
> 2c83362734dad8e48ccc0710b5cd2436a0323893
> 
> The question now is what can be done to improve the results. I have made
> stream to run longer and I see that data are moved very slowly from NODE#1
> to NODE#0.
> 

Ok, this is somewhat expected although I suspect the scan rate slowed a lot
in the early phase of the program and that's why the migration is slow --
slow scan means fewer samples and takes longer to reach the 2-pass filter.

> The process has started on NODE#1 where all memory has been allocated.
> Right after the start, the process has been moved to NODE#0 but only part
> of the memory has been moved to that node. numa_preferred_nid has stayed 1
> for 30 seconds. The numa_preferred_nid has changed to 0 at
> 2018-Jun-09_03h35m58s and most of the memory has been finally reallocated.
> See the logs below.
> 
> Could we try to make numa_preferred_nid to change faster?
> 

What catches us is that each element in itself makes sense, it's just not a
universal win. The identified patch makes a reasonable choice in that fork
shouldn't necessary spread across the machine as it hurts short-lived
or communicating processes. Unfortunately, if a load is NUMA-aware
and the processes are independent then automatic NUMA balancing has to
take action which means there is a period of time where performance is
sub-optimal. Similarly, the load balancer is making a reasonable decision
when a socket gets overloaded. Fixing any part of it for STREAM will end
up regressing something else.

The numa_preferred_nid can probably be changed faster by adjusting the scan
rate. Unfortunately, it comes with the penalty that system CPU overhead
will be higher and stalls in the process increase to handle the PTE updates
and the subsequent faults. This might help STREAM but anything that is
latency sensitive will be hurt. Worse, if a socket is over-saturated and
there is a high frequency of cross-node migrations to load balance then
the scan rate might always stay at the max frequency and a very high cost
incurred so we end up with another class of regression.

Srikar Dronamra did have a series with two patches that increase the scan
rate when there is a cross-node migration. It may be the case that it
also has the impact of changing numa_preferred_nid faster but it has a
real risk of introducing regressions. Still, for the purposes of testing
you might be interested in testing the following two patches?

Srikar Dronamra [PATCH 17/19] sched/numa: Pass destination cpu as a parameter to migrate_task_rq
Srikar Dronamra [PATCH 18/19] sched/numa: Reset scan rate whenever task moves across nodes

-- 
Mel Gorman
SUSE Labs
