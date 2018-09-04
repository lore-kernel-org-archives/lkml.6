Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B09EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A636020652
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A636020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbeIDVQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 17:16:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:3525 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbeIDVQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 17:16:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 09:50:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,329,1531810800"; 
   d="scan'208";a="260629698"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.255.229.157]) ([10.255.229.157])
  by fmsmga006.fm.intel.com with ESMTP; 04 Sep 2018 09:50:20 -0700
Subject: Re: [PATCH V2 0/6] perf/core and x86/intel_rdt: Fix lack of
 coordination with perf
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1534450299.git.reinette.chatre@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <7e94d3e1-26db-48c2-f525-eb36bed79d0c@intel.com>
Date:   Tue, 4 Sep 2018 09:50:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1534450299.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Maintainers,

This series is still needed to complete the initial cache pseudo-locking
implementation and still applies cleanly to both x86/cache of tip.git as
well as v4.19-rc2.

At this time users are unable to measure the success of their cache
pseudo-locked regions and either need to manually apply this series or
revert the commit that disables the current measurement mechanisms
"4a7a54a55e7237386cacc73f173e74329773ac93 x86/intel_rdt: Disable PMU
access".

Is there perhaps an opportunity to include this series into v4.19?
Patches 2-6 from this series fixes code that does not exist in earlier
kernels. Patch 1 was suggested by Peter and is a fix to perf.

Your consideration would be greatly appreciated.

Thank you

Reinette

On 8/16/2018 1:16 PM, Reinette Chatre wrote:
> Dear Maintainers,
> 
> This is the second attempt at fixing the lack of coordination between the
> pseudo-locking measurement code and perf. Thank you very much for your
> feedback on the first version. The entire solution, including the cover
> letter, has been reworked based on your feedback, while submitted as a V2,
> none of the patches from V1 remained.
> 
> Changes since V1:
> - Use in-kernel interface to perf.
> - Do not write directly to PMU registers.
> - Do not introduce another PMU owner. perf maintains role as performing
>   resource arbitration for PMU.
> - User space is able to use perf and resctrl at the same time.
> - event_base_rdpmc is accessed and used only within an interrupts
>   disabled section.
> - Internals of events are never accessed directly, inline function used.
> - Due to "pinned" usage the scheduling of event may have failed.  Error
>   state is checked in recommended way and have a credible error
>   handling.
> - use X86_CONFIG
> 
> This code is based on the x86/cache branch of tip.git
> 
> The success of Cache Pseudo-Locking, as measured by how many cache lines
> from a physical memory region has been locked to cache, can be measured
> via the use of hardware performance events. Specifically, the number of
> cache hits and misses reading a memory region after it has been
> pseudo-locked to cache. This measurement is triggered via the resctrl
> debugfs interface.
> 
> The current solution accesses performance counters and their configuration
> registers directly without coordination with other performance event users
> (perf).
> Two of the issues that exist with the current solution:
> - By writing to the performance monitoring registers directly a new owner
>   for these resources is introduced. The perf infrastructure already exist
>   to perform resource arbitration and the in-kernel infrastructure should
>   be used to do so.
> - The current lack of coordination with perf will have consequences any time
>   two users, for example perf and cache pseudo-locking, attempt to do any
>   kind of measurement at the same time.
> 
> In this series the measurement of Cache Pseudo-Lock regions is moved to use
> the in-kernel interface to perf. During the rework of the measurement
> function the L2 and L3 cache measurements are separated to avoid the
> additional code needed to decide on which measurement causing unrelated
> cache hits and misses.
> 
> Your feedback on this work will be greatly appreciated.
> 
> Reinette
> 
> Reinette Chatre (6):
>   perf/core: Add sanity check to deal with pinned event failure
>   x86/intel_rdt: Remove local register variables
>   x86/intel_rdt: Create required perf event attributes
>   x86/intel_rdt: Add helper to obtain performance counter index
>   x86/intel_rdt: Use perf infrastructure for measurements
>   x86/intel_rdt: Re-enable pseudo-lock measurements
> 
>  Documentation/x86/intel_rdt_ui.txt          |  22 +-
>  arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 419 ++++++++++++++------
>  kernel/events/core.c                        |   6 +
>  3 files changed, 310 insertions(+), 137 deletions(-)
> 

