Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F111DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F022133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731514AbeLQKLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:11:24 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:64686 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbeLQKLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 05:11:24 -0500
Received: from 79.184.255.25.ipv4.supernova.orange.pl (79.184.255.25) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 5497a8a5e3a7d10e; Mon, 17 Dec 2018 11:11:21 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/5] mm: Randomize free memory
Date:   Mon, 17 Dec 2018 11:10:57 +0100
Message-ID: <2153922.MoOcIFpNeT@aspire.rjw.lan>
In-Reply-To: <154483851047.1672629.15001135860756738866.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <154483851047.1672629.15001135860756738866.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, December 15, 2018 2:48:30 AM CET Dan Williams wrote:
> Changes since v4: [1]
> * Default the randomization to off and enable it dynamically based on
>   the detection of a memory side cache advertised by platform firmware.
>   In the case of x86 this enumeration comes from the ACPI HMAT. (Michal
>   and Mel)
> * Improve the changelog of the patch that introduces the shuffling to
>   clarify the motivation and better explain the tradeoffs. (Michal and
>   Mel)
> * Include the required HMAT enabling in the series.
> 
> [1]: https://lkml.kernel.org/r/153922180166.838512.8260339805733812034.stgit@dwillia2-desk3.amr.corp.intel.com
> 
> ---
> 
> Quote patch 3:
> 
> Randomization of the page allocator improves the average utilization of
> a direct-mapped memory-side-cache. Memory side caching is a platform
> capability that Linux has been previously exposed to in HPC
> (high-performance computing) environments on specialty platforms. In
> that instance it was a smaller pool of high-bandwidth-memory relative to
> higher-capacity / lower-bandwidth DRAM. Now, this capability is going to
> be found on general purpose server platforms where DRAM is a cache in
> front of higher latency persistent memory [2].
> 
> Robert offered an explanation of the state of the art of Linux
> interactions with memory-side-caches [3], and I copy it here:
> 
>     It's been a problem in the HPC space:
>     http://www.nersc.gov/research-and-development/knl-cache-mode-performance-coe/
> 
>     A kernel module called zonesort is available to try to help:
>     https://software.intel.com/en-us/articles/xeon-phi-software
> 
>     and this abandoned patch series proposed that for the kernel:
>     https://lkml.org/lkml/2017/8/23/195
> 
>     Dan's patch series doesn't attempt to ensure buffers won't conflict, but
>     also reduces the chance that the buffers will. This will make performance
>     more consistent, albeit slower than "optimal" (which is near impossible
>     to attain in a general-purpose kernel).  That's better than forcing
>     users to deploy remedies like:
>         "To eliminate this gradual degradation, we have added a Stream
>          measurement to the Node Health Check that follows each job;
>          nodes are rebooted whenever their measured memory bandwidth
>          falls below 300 GB/s."
> 
> A replacement for zonesort was merged upstream in commit cc9aec03e58f
> "x86/numa_emulation: Introduce uniform split capability". With this
> numa_emulation capability, memory can be split into cache sized
> ("near-memory" sized) numa nodes. A bind operation to such a node, and
> disabling workloads on other nodes, enables full cache performance.
> However, once the workload exceeds the cache size then cache conflicts
> are unavoidable. While HPC environments might be able to tolerate
> time-scheduling of cache sized workloads, for general purpose server
> platforms, the oversubscribed cache case will be the common case.
> 
> The worst case scenario is that a server system owner benchmarks a
> workload at boot with an un-contended cache only to see that performance
> degrade over time, even below the average cache performance due to
> excessive conflicts. Randomization clips the peaks and fills in the
> valleys of cache utilization to yield steady average performance.
> 
> See patch 3 for more details.
> 
> [2]: https://itpeernetwork.intel.com/intel-optane-dc-persistent-memory-operating-modes/
> [3]: https://lkml.org/lkml/2018/9/22/54

Has this hibernation been tested with this series applied?

