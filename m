Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495C2C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 02:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7B4206E0
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 02:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbeLOCBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 21:01:07 -0500
Received: from mga02.intel.com ([134.134.136.20]:36104 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727668AbeLOCBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 21:01:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Dec 2018 18:01:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,355,1539673200"; 
   d="scan'208";a="118505194"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga002.jf.intel.com with ESMTP; 14 Dec 2018 18:01:05 -0800
Subject: [PATCH v5 0/5] mm: Randomize free memory
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Lutomirski <luto@kernel.org>, linux-mm@kvack.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 14 Dec 2018 17:48:30 -0800
Message-ID: <154483851047.1672629.15001135860756738866.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v4: [1]
* Default the randomization to off and enable it dynamically based on
  the detection of a memory side cache advertised by platform firmware.
  In the case of x86 this enumeration comes from the ACPI HMAT. (Michal
  and Mel)
* Improve the changelog of the patch that introduces the shuffling to
  clarify the motivation and better explain the tradeoffs. (Michal and
  Mel)
* Include the required HMAT enabling in the series.

[1]: https://lkml.kernel.org/r/153922180166.838512.8260339805733812034.stgit@dwillia2-desk3.amr.corp.intel.com

---

Quote patch 3:

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
    https://lkml.org/lkml/2017/8/23/195

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

See patch 3 for more details.

[2]: https://itpeernetwork.intel.com/intel-optane-dc-persistent-memory-operating-modes/
[3]: https://lkml.org/lkml/2018/9/22/54

---                                                                                        
                                                                                           
Dan Williams (3):
      mm: Shuffle initial free memory to improve memory-side-cache utilization
      mm: Move buddy list manipulations into helpers
      mm: Maintain randomization of page free lists

Keith Busch (2):
      acpi: Create subtable parsing infrastructure
      acpi/numa: Set the memory-side-cache size in memblocks


 arch/ia64/kernel/acpi.c                       |   12 +
 arch/x86/Kconfig                              |    1 
 arch/x86/kernel/acpi/boot.c                   |   36 ++--
 drivers/acpi/numa.c                           |   48 +++++
 drivers/acpi/scan.c                           |    4 
 drivers/acpi/tables.c                         |   67 ++++++--
 drivers/irqchip/irq-gic-v2m.c                 |    2 
 drivers/irqchip/irq-gic-v3-its-pci-msi.c      |    2 
 drivers/irqchip/irq-gic-v3-its-platform-msi.c |    2 
 drivers/irqchip/irq-gic-v3-its.c              |    6 -
 drivers/irqchip/irq-gic-v3.c                  |    8 -
 drivers/irqchip/irq-gic.c                     |    4 
 drivers/mailbox/pcc.c                         |    2 
 include/linux/acpi.h                          |    5 -
 include/linux/list.h                          |   17 ++
 include/linux/memblock.h                      |   36 ++++
 include/linux/mm.h                            |   53 ++++++
 include/linux/mm_types.h                      |    3 
 include/linux/mmzone.h                        |   65 +++++++
 init/Kconfig                                  |   36 ++++
 mm/Kconfig                                    |    3 
 mm/Makefile                                   |    7 +
 mm/compaction.c                               |    4 
 mm/memblock.c                                 |   37 ++++
 mm/memory_hotplug.c                           |    2 
 mm/page_alloc.c                               |   81 ++++-----
 mm/shuffle.c                                  |  222 +++++++++++++++++++++++++
 27 files changed, 657 insertions(+), 108 deletions(-)
 create mode 100644 mm/shuffle.c

--
Signature
