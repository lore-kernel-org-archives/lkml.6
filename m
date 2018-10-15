Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2ABAC28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 07:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F222086A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 07:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F222086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbeJOPKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 11:10:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:56764 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbeJOPKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 11:10:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2018 00:26:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,383,1534834800"; 
   d="scan'208";a="271372875"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 15 Oct 2018 00:26:10 -0700
Received: from [10.125.251.255] (abudanko-mobl.ccr.corp.intel.com [10.125.251.255])
        by linux.intel.com (Postfix) with ESMTP id 4AC9E580113;
        Mon, 15 Oct 2018 00:26:07 -0700 (PDT)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [RFC][PATCH] perf: Rewrite core context handling
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        songliubraving@fb.com, eranian@google.com, tglx@linutronix.de,
        mark.rutland@arm.com, megha.dey@intel.com, frederic@kernel.org
References: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
Organization: Intel Corp.
Message-ID: <3a738a08-2295-a4e9-dce7-a3e2b2ad794e@linux.intel.com>
Date:   Mon, 15 Oct 2018 10:26:06 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10.10.2018 13:45, Peter Zijlstra wrote:
> Hi all,
> 
> There have been various issues and limitations with the way perf uses
> (task) contexts to track events. Most notable is the single hardware PMU
> task context, which has resulted in a number of yucky things (both
> proposed and merged).
> 
> Notably:
> 
>  - HW breakpoint PMU
>  - ARM big.little PMU
>  - Intel Branch Monitoring PMU
> 
> Since we now track the events in RB trees, we can 'simply' add a pmu
> order to them and have them grouped that way, reducing to a single
> context. Of course, reality never quite works out that simple, and below
> ends up adding an intermediate data structure to bridge the context ->
> pmu mapping.
> 
> Something a little like:
> 
>               ,------------------------[1:n]---------------------.
>               V                                                  V
>     perf_event_context <-[1:n]-> perf_event_pmu_context <--- perf_event
>               ^                      ^     |                     |
>               `--------[1:n]---------'     `-[n:1]-> pmu <-[1:n]-'
> 
> This patch builds (provided you disable CGROUP_PERF), boots and survives
> perf-top without the machine catching fire.
> 
> There's still a fair bit of loose ends (look for XXX), but I think this
> is the direction we should be going.
> 
> Comments?
> 
> Not-Quite-Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/powerpc/perf/core-book3s.c |    4 
>  arch/x86/events/core.c          |    4 
>  arch/x86/events/intel/core.c    |    6 
>  arch/x86/events/intel/ds.c      |    6 
>  arch/x86/events/intel/lbr.c     |   16 
>  arch/x86/events/perf_event.h    |    6 
>  include/linux/perf_event.h      |   80 +-
>  include/linux/sched.h           |    2 
>  kernel/events/core.c            | 1412 ++++++++++++++++++++--------------------
>  9 files changed, 815 insertions(+), 721 deletions(-)

Rewrite is impressive however it doesn't result in code base reduction as it is.
Nonetheless there is a clear demand for per pmu events groups tracking and rotation 
in single cpu context (HW breakpoints, ARM big.little, Intel LBRs) and there is 
a supply thru groups ordering on RB-tree.

This might be driven into the kernel by some new Perf features that would base on 
that RB-tree groups ordering or by refactoring of existing code but in the way it 
would result in overall code base reduction thus lowering support cost.

Thanks,
Alexey
