Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A7AC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5BA2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5BA2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeJXRXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:23:54 -0400
Received: from outbound-smtp13.blacknight.com ([46.22.139.230]:47788 "EHLO
        outbound-smtp13.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727226AbeJXRXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 13:23:54 -0400
Received: from mail.blacknight.com (unknown [81.17.254.17])
        by outbound-smtp13.blacknight.com (Postfix) with ESMTPS id 5AC711C1EA6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 09:56:38 +0100 (IST)
Received: (qmail 31158 invoked from network); 24 Oct 2018 08:56:38 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.142])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 24 Oct 2018 08:56:38 -0000
Date:   Wed, 24 Oct 2018 09:56:36 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Yi Wang <wang.yi59@zte.com.cn>, zhong.weidong@zte.com.cn,
        Yi Liu <liu.yi24@zte.com.cn>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] sched/core: Don't mix isolcpus and housekeeping CPUs
Message-ID: <20181024085636.GB23537@techsingularity.net>
References: <1540350169-18581-1-git-send-email-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1540350169-18581-1-git-send-email-srikar@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 08:32:49AM +0530, Srikar Dronamraju wrote:
> Load balancer and NUMA balancer are not suppose to work on isolcpus.
> 
> Currently when setting sched affinity, there are no checks to see if the
> requested cpumask has CPUs from both isolcpus and housekeeping CPUs.
> 
> If user passes a mix of isolcpus and housekeeping CPUs, then
> NUMA balancer can pick a isolcpu to schedule.
> With this change, if a combination of isolcpus and housekeeping CPUs are
> provided, then we restrict ourselves to housekeeping CPUs.
> 
> For example: System with 32 CPUs
> $ grep -o "isolcpus=[,,1-9]*" /proc/cmdline
> isolcpus=1,5,9,13
> $ grep -i cpus_allowed /proc/$$/status
> Cpus_allowed:   ffffdddd
> Cpus_allowed_list:      0,2-4,6-8,10-12,14-31
> 
> Running "perf bench numa mem --no-data_rand_walk -p 4 -t 8 -G 0 -P 3072
> -T 0 -l 50 -c -s 1000" which  calls sched_setaffinity to all CPUs in
> system.
> 

Forgive my naivety, but is it wrong for a process to bind to both isolated
CPUs and housekeeping CPUs? It would certainly be a bit odd because the
application is asking for some protection but no guarantees are given
and the application is not made aware via an error code that there is a
problem. Asking the application to parse dmesg hoping to find the right
error message is going to be fragile.

Would it be more appropriate to fail sched_setaffinity when there is a
mix of isolated and housekeeping CPUs? In that case, an info message in
dmesg may be appropriate as it'll likely be a once-off configuration
error that's obvious due to an application failure. Alternatively,
should NUMA balancing ignore isolated CPUs? The latter seems unusual as
the application has specified a mask that allows those CPUs and it's not
clear why NUMA balancing should ignore them. If anything, an application
that wants to avoid all interference should also be using memory policies
to bind to nodes so it behaves predictably with respect to access latencies
(presumably if an application cannot tolerate kernel threads interfering
then it also cannot tolerate remote access latencies) or disabling NUMA
balancing entirely to avoid incurring minor faults.

Thanks.

-- 
Mel Gorman
SUSE Labs
