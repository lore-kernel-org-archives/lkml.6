Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A25EC282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B0142184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbfA3FOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 00:14:48 -0500
Received: from mga14.intel.com ([192.55.52.115]:6052 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfA3FOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 00:14:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 21:14:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,539,1539673200"; 
   d="scan'208";a="316032024"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jan 2019 21:14:47 -0800
Subject: [PATCH v9 0/3] mm: Randomize free memory
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 29 Jan 2019 21:02:10 -0800
Message-ID: <154882453052.1338686.16411162273671426494.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v8 [1]:
* Rework shuffle call sites from 3 locations to 2, i.e. one for the
  initial memory online path, and one for the hotplug memory online path.
  This simplification results in an incremental diffstat of "7 files
  changed, 31 insertions(+), 82 deletions(-)". The consolidation of the
  initial shuffle in page_alloc_init_late() leads to a beneficial increase
  in the number of shuffles performed in a qemu-VM test. (Michal)

* Drop the CONFIG_SHUFFLE_PAGE_ORDER configuration option. If it turns out
  that there is a use case to make the shuffle-order dynamic that can be
  addressed in a follow on update, but no such case is known at present.
  (Michal)

* Replace lkml.org links with lkml.kernel.org, where possible.
  Unfortunately lkml.kernel.org failed to capture Mel's feedback, so the
  lkml.org link remains for that one. (Michal)

* Fix definition of pfn_present() in the !sparsemem case. (Michal)

* Collect Michal's ack on patch2, and open code rmv_page_order() in its
  only caller.

[1]: https://lkml.kernel.org/r/154767945660.1983228.12167020940431682725.stgit@dwillia2-desk3.amr.corp.intel.com

---

Hi Andrew,

As you can see the series is improved thanks to Michal's review. Please
await his ack, but I believe this version addresses all pending
feedback.

Still based on v5.0-rc1 for my tests, but it applies and builds cleanly
to current linux-next.

---

Quote Patch 1:

Randomization of the page allocator improves the average utilization of
a direct-mapped memory-side-cache. Memory side caching is a platform
capability that Linux has been previously exposed to in HPC
(high-performance computing) environments on specialty platforms. In
that instance it was a smaller pool of high-bandwidth-memory relative to
higher-capacity / lower-bandwidth DRAM. Now, this capability is going to
be found on general purpose server platforms where DRAM is a cache in
front of higher latency persistent memory [2].

Robert offered an explanation of the state of the art of Linux
interactions with memory-side-caches [3], and I copy it here:

    It's been a problem in the HPC space:
    http://www.nersc.gov/research-and-development/knl-cache-mode-performance-coe/

    A kernel module called zonesort is available to try to help:
    https://software.intel.com/en-us/articles/xeon-phi-software

    and this abandoned patch series proposed that for the kernel:
    https://lkml.kernel.org/r/20170823100205.17311-1-lukasz.daniluk@intel.com

    Dan's patch series doesn't attempt to ensure buffers won't conflict, but
    also reduces the chance that the buffers will. This will make performance
    more consistent, albeit slower than "optimal" (which is near impossible
    to attain in a general-purpose kernel).  That's better than forcing
    users to deploy remedies like:
        "To eliminate this gradual degradation, we have added a Stream
         measurement to the Node Health Check that follows each job;
         nodes are rebooted whenever their measured memory bandwidth
         falls below 300 GB/s."

A replacement for zonesort was merged upstream in commit cc9aec03e58f
"x86/numa_emulation: Introduce uniform split capability". With this
numa_emulation capability, memory can be split into cache sized
("near-memory" sized) numa nodes. A bind operation to such a node, and
disabling workloads on other nodes, enables full cache performance.
However, once the workload exceeds the cache size then cache conflicts
are unavoidable. While HPC environments might be able to tolerate
time-scheduling of cache sized workloads, for general purpose server
platforms, the oversubscribed cache case will be the common case.

The worst case scenario is that a server system owner benchmarks a
workload at boot with an un-contended cache only to see that performance
degrade over time, even below the average cache performance due to
excessive conflicts. Randomization clips the peaks and fills in the
valleys of cache utilization to yield steady average performance.

See patch 1 for more details.

[2]: https://itpeernetwork.intel.com/intel-optane-dc-persistent-memory-operating-modes/
[3]: https://lkml.kernel.org/r/AT5PR8401MB1169D656C8B5E121752FC0F8AB120@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM

---

Dan Williams (3):
      mm: Shuffle initial free memory to improve memory-side-cache utilization
      mm: Move buddy list manipulations into helpers
      mm: Maintain randomization of page free lists


 include/linux/list.h     |   17 ++++
 include/linux/mm.h       |    3 -
 include/linux/mm_types.h |    3 +
 include/linux/mmzone.h   |   62 ++++++++++++++
 include/linux/shuffle.h  |   57 +++++++++++++
 init/Kconfig             |   23 +++++
 mm/Makefile              |    7 +-
 mm/compaction.c          |    4 -
 mm/memblock.c            |    1 
 mm/memory_hotplug.c      |    3 +
 mm/page_alloc.c          |   85 +++++++++----------
 mm/shuffle.c             |  204 ++++++++++++++++++++++++++++++++++++++++++++++
 12 files changed, 419 insertions(+), 50 deletions(-)
 create mode 100644 include/linux/shuffle.h
 create mode 100644 mm/shuffle.c
