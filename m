Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932074AbeDYSMa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:12:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:41705 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755684AbeDYSM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:12:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,327,1520924400";
   d="scan'208";a="35243599"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V3 00/39] Intel(R) Resource Director Technology Cache Pseudo-Locking enabling
Date: Wed, 25 Apr 2018 03:09:36 -0700
Message-Id: <cover.1524649902.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Maintainers,

This third series of Cache Pseudo-Locking enabling addresses all feedback
received during the upstream review of RFC V2.

The last patch of this series depends on the series:
"[RFC PATCH 0/3] Interface for higher order contiguous allocations"
submitted at:
http://lkml.kernel.org/r/20180212222056.9735-1-mike.kravetz@oracle.com
A new version of this was submitted recently and currently being discussed
at:
http://lkml.kernel.org/r/20180417020915.11786-1-mike.kravetz@oracle.com
Without this upstream MM work (and patch 39/39 of this series) it would
just not be possible to create pseudo-locked regions larger than 4MB. To
simplify this work we could temporarily drop the last patch of this
series until the upstream MM work is complete.

Changes since v2:
- Introduce resource group "modes" and a new resctrl file "mode" associated
  with each resource group that exposes the associated resource group's mode.
  A resource group's mode is used by the system administrator to enable or
  disable resource sharing between resource groups. A resource group in
  "shareable" mode allows its allocations to be shared with other resource
  groups. This is the default mode and reflects existing behavior. A resource
  group in "exclusive" mode does not allow any sharing of its allocated
  resources. When a schemata is written to any resource group it is not
  allowed to overlap with allocations of any resource group that is in
  "exclusive" mode. A resource group's allocations are not allowed to overlap
  at the time it is set to be "exclusive".  Cache pseudo-locking builds on
  "exclusive" mode and is supported using two new modes: "pseudo-locksetup"
  lets the user indicate that this resource group will be used by a
  pseudo-locked region. A subsequent write of a schemata to the "schemata"
  file will create the corresponding pseudo-locked region and the mode will
  then automatically change to "pseudo-locked".
- A resource group's mode can only be changed to "pseudo-locksetup" if the
  platform has been verified to support cache pseudo-locking and the
  resource group is unused. Unused means that, no monitoring is in progress,
  and no tasks or cpus are assigned to the resource group. Once a resource
  group enters "pseudo-locksetup" it becomes "locked down" such that no
  new tasks or cpus can be assigned to it. Neither can any new monitoring
  be started.
- Each resource group obtains a new "size" file that mirrors the schemata
  file to display the size in bytes of each allocation. There is a difference
  in the implementation from the review feedback. In the review feedback an
  example of output was:
     L2:0=128K;1=256K;
     L3:0=1M;1=2M;
  Within the kernel I could find many examples of support for user _input_ with
  mem suffixes. This is broadly supported with lib/cmdline.c:memparse().
  I was not able to find as clear support or usage of such flexible
  _output_ of size. My conclusion was that the output of size tends to always
  be using the same unit. I also found that printing the size in one unit, in
  this case bytes, does simplify validation.
- A new "bit_usage" file within the info/<resource> sub-directories contain
  annotated bitmaps of how the resources are used.
- Cache pseudo-locked regions are now associated 1:1 with a resource group.
- Do not make any changes to capacity bitmask (CBM) associated with the
  default class-of-service (CLOS). If a pseudo-locked region is requested its
  cache region has to be unused at the time of request.
- Second mutex removed.
- Tabular fashion respected when making struct changes.
- Lifetime of pseudo-locked region (by extension the resource group it
  belongs to) connected to mmap region.
- Do not call preempt_disable() and local_irq_save(). Only local_irq_disable().
- Improve comments in pseudo-locking loop to explain why prefetcher needs
  disabling.
- Ensure that possibility of pseudo-locked region success takes into
  account all levels of cache in the hierarchy, not just the level at which
  it is requested.
- Preloading of code was suggested in review to improve pseudo-locking
  success. We have since been able to connect a hardware debugger to our
  target platform and with current locking flow we are able to lock 100%
  of kernel memory into the cache of an Intel(R) Celeron(R) Processor J3455.
- Above testing with hardware debugger revealed that speculative execution
  of the loop loads data beyond the end of the buffer. Add a read barrier
  to the locking loops to prevent this speculation.
- The name of the debugfs file used to trigger measurements was changed
  from "measure_trigger" to "pseudo_lock_measure".

Changes since v1:
- Enable allocation of contiguous regions larger than what SLAB allocators
  can support. This removes the 4MB Cache Pseudo-Locking limitation
  documented in v1 submission.
  This depends on "mm: drop hotplug lock from lru_add_drain_all",
  now in v4.16-rc1 as 9852a7212324fd25f896932f4f4607ce47b0a22f.
- Convert to debugfs_file_get() and -put() from the now obsolete
  debugfs_use_file_start() and debugfs_use_file_finish() calls.
- Rebase on top of, and take into account, recent L2 CDP enabling.
- Simplify tracing output to print cache hits and miss counts on same line.

No changes below. It is verbatim from first submission (except for
diffstat at the end that reflects v3).

Dear Maintainers,

Cache Allocation Technology (CAT), part of Intel(R) Resource Director
Technology (Intel(R) RDT), enables a user to specify the amount of cache
space into which an application can fill. Cache pseudo-locking builds on
the fact that a CPU can still read and write data pre-allocated outside
its current allocated area on cache hit. With cache pseudo-locking data
can be preloaded into a reserved portion of cache that no application can
fill, and from that point on will only serve cache hits. The cache
pseudo-locked memory is made accessible to user space where an application
can map it into its virtual address space and thus have a region of
memory with reduced average read latency.

The cache pseudo-locking approach relies on generation-specific behavior
of processors. It may provide benefits on certain processor generations,
but is not guaranteed to be supported in the future. It is not a guarantee
that data will remain in the cache. It is not a guarantee that data will
remain in certain levels or certain regions of the cache. Rather, cache
pseudo-locking increases the probability that data will remain in a certain
level of the cache via carefully configuring the CAT feature and carefully
controlling application behavior.

Known limitations:
Instructions like INVD, WBINVD, CLFLUSH, etc. can still evict pseudo-locked
memory from the cache. Power management C-states may still shrink or power
off cache causing eviction of cache pseudo-locked memory. We utilize
PM QoS to prevent entering deeper C-states on cores associated with cache
pseudo-locked regions at the time they (the pseudo-locked regions) are
created.

Known software limitation:
Cache pseudo-locked regions are currently limited to 4MB, even on
platforms that support larger cache sizes. Work is in progress to
support larger regions.

Graphs visualizing the benefits of cache pseudo-locking on an Intel(R)
NUC NUC6CAYS (it has an Intel(R) Celeron(R) Processor J3455) with the
default 2GB DDR3L-1600 memory are available. In these tests the patches
from this series were applied on the x86/cache branch of tip.git at the
time the HEAD was:

commit 87943db7dfb0c5ee5aa74a9ac06346fadd9695c8 (tip/x86/cache)
Author: Reinette Chatre <reinette.chatre@intel.com>
Date:   Fri Oct 20 02:16:59 2017 -0700
    x86/intel_rdt: Fix potential deadlock during resctrl mount

DISCLAIMER: Tests document performance of components on a particular test,
in specific systems. Differences in hardware, software, or configuration
will affect actual performance. Performance varies depending on system
configuration.

- https://github.com/rchatre/data/blob/master/cache_pseudo_locking/rfc_v1/perfcount.png
Above shows the few L2 cache misses possible with cache pseudo-locking
on the Intel(R) NUC with default configuration. Each test, which is
repeated 100 times, pseudo-locks schemata shown and then measure from
the kernel via precision counters the number of cache misses when
accessing the memory afterwards. This test is run on an idle system as
well as a system with significant noise (using stress-ng) from a
neighboring core associated with the same cache. This plot shows us that:
(1) the number of cache misses remain consistent irrespective of the size
of region being pseudo-locked, and (2) the number of cache misses for a
pseudo-locked region remains low when traversing memory regions ranging
in size from 256KB (4096 cache lines) to 896KB (14336 cache lines).

- https://github.com/rchatre/data/blob/master/cache_pseudo_locking/rfc_v1/userspace_malloc_with_load.png
Above shows the read latency experienced by an application running with
default CAT CLOS after it allocated 256KB memory with malloc() (and using
mlockall()). In this example the application reads randomly (to not trigger
hardware prefetcher) from its entire allocated region at 2 second intervals
while there is a noisy neighbor present. Each individual access is 32 bytes
in size and the latency of each access is measured using the rdtsc
instruction. In this visualization we can observe two groupings of data,
the group with lower latency indicating cache hits, and the group with
higher latency indicating cache misses. We can see a significant portion
of memory reads experience larger latencies.

- https://github.com/rchatre/data/blob/master/cache_pseudo_locking/rfc_v1/userspace_psl_with_load.png
Above plots a similar test as the previous, but instead of the application
reading from a 256KB malloc() region it reads from a 256KB pseudo-locked
region that was mmap()'ed into its address space. When comparing these
latencies to that of regular malloc() latencies we do see a significant
improvement in latencies experienced.

https://github.com/rchatre/data/blob/master/cache_pseudo_locking/rfc_v1/userspace_malloc_and_cat_with_load_clos0_fixed.png
Applications that are sensitive to latencies may use existing CAT
technology to isolate the sensitive application. In this plot we show an
application running with a dedicated CAT CLOS double the size (512KB) of
the memory being tested (256KB). A dedicated CLOS with CBM 0x0f is created and
the default CLOS changed to CBM 0xf0. We see in this plot that even though
the application runs within a dedicated portion of cache it still
experiences significant latency accessing its memory (when compared to
pseudo-locking).

Your feedback about this proposal for enabling of Cache Pseudo-Locking
will be greatly appreciated.

Regards,

Reinette

Reinette Chatre (39):
  x86/intel_rdt: Document new mode, size, and bit_usage
  x86/intel_rdt: Introduce RDT resource group mode
  x86/intel_rdt: Associate mode with each RDT resource group
  x86/intel_rdt: Introduce resource group's mode resctrl file
  x86/intel_rdt: Introduce test to determine if closid is in use
  x86/intel_rdt: Make useful functions available internally
  x86/intel_rdt: Initialize new resource group with sane defaults
  x86/intel_rdt: Introduce new "exclusive" mode
  x86/intel_rdt: Enable setting of exclusive mode
  x86/intel_rdt: Making CBM name and type more explicit
  x86/intel_rdt: Support flexible data to parsing callbacks
  x86/intel_rdt: Ensure requested schemata respects mode
  x86/intel_rdt: Introduce "bit_usage" to display cache allocations
    details
  x86/intel_rdt: Display resource groups' allocations' size in bytes
  x86/intel_rdt: Documentation for Cache Pseudo-Locking
  x86/intel_rdt: Introduce the Cache Pseudo-Locking modes
  x86/intel_rdt: Respect read and write access
  x86/intel_rdt: Add utility to test if tasks assigned to resource group
  x86/intel_rdt: Add utility to restrict/restore access to resctrl files
  x86/intel_rdt: Protect against resource group changes during locking
  x86/intel_rdt: Utilities to restrict/restore access to specific files
  x86/intel_rdt: Add check to determine if monitoring in progress
  x86/intel_rdt: Introduce pseudo-locked region
  x86/intel_rdt: Support enter/exit of locksetup mode
  x86/intel_rdt: Enable entering of pseudo-locksetup mode
  x86/intel_rdt: Split resource group removal in two
  x86/intel_rdt: Add utilities to test pseudo-locked region possibility
  x86/intel_rdt: Discover supported platforms via prefetch disable bits
  x86/intel_rdt: Pseudo-lock region creation/removal core
  x86/intel_rdt: Support creation/removal of pseudo-locked region
  x86/intel_rdt: resctrl files reflect pseudo-locked information
  x86/intel_rdt: Ensure RDT cleanup on exit
  x86/intel_rdt: Create resctrl debug area
  x86/intel_rdt: Create debugfs files for pseudo-locking testing
  x86/intel_rdt: Create character device exposing pseudo-locked region
  x86/intel_rdt: More precise L2 hit/miss measurements
  x86/intel_rdt: Support L3 cache performance event of Broadwell
  x86/intel_rdt: Limit C-states dynamically when pseudo-locking active
  x86/intel_rdt: Support contiguous memory of all sizes

 Documentation/x86/intel_rdt_ui.txt                |  375 ++++-
 arch/x86/Kconfig                                  |   11 +
 arch/x86/kernel/cpu/Makefile                      |    4 +-
 arch/x86/kernel/cpu/intel_rdt.c                   |   11 +
 arch/x86/kernel/cpu/intel_rdt.h                   |  144 +-
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c       |  129 +-
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c       | 1562 +++++++++++++++++++++
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h |   42 +
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c          |  765 +++++++++-
 9 files changed, 2971 insertions(+), 72 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
 create mode 100644 arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h

-- 
2.13.6
