Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751987AbeDJFMq convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 01:12:46 -0400
Received: from mga04.intel.com ([192.55.52.120]:44470 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751595AbeDJFMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 01:12:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,430,1517904000";
   d="scan'208";a="32440466"
From: "Williams, Dan J" <dan.j.williams@intel.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "inux-nvdimm@lists.01.org" <inux-nvdimm@lists.01.org>
Subject: [GIT PULL] libnvdimm for 4.17
Thread-Topic: [GIT PULL] libnvdimm for 4.17
Thread-Index: AQHT0IqNqnJmVKm5w0qVGEe7sC8Pow==
Date: Tue, 10 Apr 2018 05:12:42 +0000
Message-ID: <1523337147.23102.31.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.186.127]
Content-Type: text/plain; charset="utf-7"
Content-ID: <2389145D2311944ABE7A409A373390E3@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-4.17

...to receive the libnvdimm update for 4.17.

This cycle was was not something I ever want to repeat as there were
several late changes that have only now just settled. Half of the
branch up to commit d2c997c0f145 +ACI-fs, dax: use page-+AD4-mapping to
warn...+ACI- have been in -next for several releases. The of+AF8-pmem driver
and the address range scrub rework were late arrivals, and the dax work
was scaled back at the last moment.

The of+AF8-pmem driver missed a previous merge window due to an oversight.
A sense of obligation to rectify that miss is why it is included for
4.17. It has acks from PowerPC folks. Stephen reported a build failure
that only occurs when merging it with your latest tree, for now I have
fixed that up by disabling modular builds of of+AF8-pmem. A test merge with
your tree has received a build success report from the 0day robot over
156 configs.

An initial version of the ARS rework was submitted before the merge
window. It is self contained to libnvdimm, a net code reduction, and
passing all unit tests.

The filesystem-dax changes are based on the wait+AF8-var+AF8-event()
functionality from tip/sched/core. However, late review feedback showed
that those changes regressed truncate performance to a large degress.
The branch was rewound to drop the truncate behavior change and now
only includes preparation patches and cleanups (with full acks and
reviews). The finalization of this dax-dma-vs-trnucate work will need
to wait for 4.18.

git picked the wait+AF8-var+AF8-event() baseline for the diffstat, so I also
include the diffstat of the test merge below.

The following changes since commit 3eb2ce825ea1ad89d20f7a3b5780df850e4be274:

  Linux 4.16-rc7 (2018-03-25 12:44:30 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-4.17

for you to fetch changes up to e13e75b86ef2f88e3a47d672dd4c52a293efb95b:

  Merge branch 'for-4.17/dax' into libnvdimm-for-next (2018-04-09 10:50:17 -0700)

----------------------------------------------------------------
libnvdimm for 4.17

+ACo- A rework of the filesytem-dax implementation provides for detection of
  unmap operations (truncate / hole punch) colliding with in-progress
  device-DMA. A fix for these collisions remains a work-in-progress
  pending resolution of truncate latency and starvation regressions.

+ACo- The of+AF8-pmem driver expands the users of libnvdimm outside of x86 and
  ACPI to describe an implementation of persistent memory on PowerPC with
  Open Firmware / Device tree.

+ACo- Address Range Scrub (ARS) handling is completely rewritten to account for
  the fact that ARS may run for 100s of seconds and there is no platform
  defined way to cancel it. ARS will now no longer block namespace
  initialization.

+ACo- The NVDIMM Namespace Label implementation is updated to handle label
  areas as small as 1K, down from 128K.

+ACo- Miscellaneous cleanups and updates to unit test infrastructure.

----------------------------------------------------------------
Dan Williams (26):
      libnvdimm: remove redundant +AF8AXw-func+AF8AXw- in dev+AF8-dbg
      device-dax: remove redundant +AF8AXw-func+AF8AXw- in dev+AF8-dbg
      nfit: skip region registration for incomplete control regions
      acpi, nfit: rework NVDIMM leaf method detection
      dax: store pfns in the radix
      fs, dax: prepare for dax-specific address+AF8-space+AF8-operations
      block, dax: remove dead code in blkdev+AF8-writepages()
      xfs, dax: introduce xfs+AF8-dax+AF8-aops
      ext4, dax: introduce ext4+AF8-dax+AF8-aops
      nfit: fix region registration vs block-data-window ranges
      ext2, dax: introduce ext2+AF8-dax+AF8-aops
      fs, dax: use page-+AD4-mapping to warn if truncate collides with a busy page
      dax: introduce CONFIG+AF8-DAX+AF8-DRIVER
      dax, dm: allow device-mapper to operate without dax support
      nfit, address-range-scrub: fix scrub in-progress reporting
      libnvdimm: add an api to cast a 'struct nd+AF8-region' to its 'struct device'
      nfit, address-range-scrub: introduce nfit+AF8-spa-+AD4-ars+AF8-state
      libnvdimm, dimm: fix dpa reservation vs uninitialized label area
      libnvdimm, namespace: use a safe lookup for dimm device name
      libnvdimm, region: quiet region probe
      nfit, address-range-scrub: determine one platform max+AF8-ars value
      nfit, address-range-scrub: rework and simplify ARS state machine
      nfit, address-range-scrub: add module option to skip initial ars
      libnvdimm, of+AF8-pmem: workaround OF+AF8-NUMA+AD0-n build error
      Merge branch 'for-4.17/libnvdimm' into libnvdimm-for-next
      Merge branch 'for-4.17/dax' into libnvdimm-for-next

Johannes Thumshirn (4):
      acpi, nfit: remove redundant +AF8AXw-func+AF8AXw- in dev+AF8-dbg
      libnvdimm: provide module+AF8-nd+AF8-driver wrapper
      libnvdimm, pmem: use module+AF8-nd+AF8-driver
      device-dax: use module+AF8-nd+AF8-driver

Oliver O'Halloran (4):
      libnvdimm: Add of+AF8-node to region and bus descriptors
      libnvdimm: Add device-tree based driver
      doc/devicetree: Persistent memory region bindings
      powerpc/powernv: Create platform devs for nvdimm buses

Ross Zwisler (3):
      nfit+AF8-test: improve structure offset handling
      nfit+AF8-test: fix buffer overrun, add sanity check
      nfit+AF8-test: prevent parsing error of nfit+AF8-test.0

Toshi Kani (2):
      libnvdimm, label: change min label storage size per UEFI 2.7
      libnvdimm, label: change nvdimm+AF8-num+AF8-label+AF8-slots per UEFI 2.7

Vishal Verma (2):
      libnvdimm, testing: Add emulation for smart injection commands
      libnvdimm, testing: update the default smart ctrl+AF8-temperature

 Documentation/admin-guide/kernel-parameters.txt    +AHw-  11 +-
 .../devicetree/bindings/pmem/pmem-region.txt       +AHw-  65 +-+-
 MAINTAINERS                                        +AHw-   8 +-
 arch/powerpc/platforms/powernv/opal.c              +AHw-   3 +-
 drivers/acpi/nfit/core.c                           +AHw- 679 +-+-+-+-+-+-+-+-+-+------------
 drivers/acpi/nfit/mce.c                            +AHw-   5 +--
 drivers/acpi/nfit/nfit.h                           +AHw-  22 +--
 drivers/dax/Kconfig                                +AHw-   5 +--
 drivers/dax/device.c                               +AHw-  38 +--
 drivers/dax/pmem.c                                 +AHw-  18 +--
 drivers/dax/super.c                                +AHw-  15 +--
 drivers/md/Kconfig                                 +AHw-   2 +--
 drivers/md/dm-linear.c                             +AHw-   6 +-
 drivers/md/dm-log-writes.c                         +AHw-  95 +---
 drivers/md/dm-stripe.c                             +AHw-   6 +-
 drivers/md/dm.c                                    +AHw-  10 +--
 drivers/nvdimm/Kconfig                             +AHw-  13 +--
 drivers/nvdimm/Makefile                            +AHw-   1 +-
 drivers/nvdimm/btt+AF8-devs.c                          +AHw-  21 +--
 drivers/nvdimm/bus.c                               +AHw-  14 +--
 drivers/nvdimm/claim.c                             +AHw-   2 +--
 drivers/nvdimm/core.c                              +AHw-   6 +--
 drivers/nvdimm/dax+AF8-devs.c                          +AHw-   5 +--
 drivers/nvdimm/dimm.c                              +AHw-   8 +--
 drivers/nvdimm/dimm+AF8-devs.c                         +AHw-   7 +--
 drivers/nvdimm/label.c                             +AHw-  85 +---
 drivers/nvdimm/label.h                             +AHw-   2 +--
 drivers/nvdimm/namespace+AF8-devs.c                    +AHw-  42 +--
 drivers/nvdimm/nd.h                                +AHw-   1 -
 drivers/nvdimm/of+AF8-pmem.c                           +AHw- 119 +-+-+-+-
 drivers/nvdimm/pfn+AF8-devs.c                          +AHw-  25 +--
 drivers/nvdimm/pmem.c                              +AHw-  14 +--
 drivers/nvdimm/region.c                            +AHw-   4 +--
 drivers/nvdimm/region+AF8-devs.c                       +AHw-   9 +-
 drivers/s390/block/Kconfig                         +AHw-   2 +--
 fs/block+AF8-dev.c                                     +AHw-   5 -
 fs/dax.c                                           +AHw- 146 +-+-+---
 fs/ext2/ext2.h                                     +AHw-   1 +-
 fs/ext2/inode.c                                    +AHw-  46 +--
 fs/ext2/namei.c                                    +AHw-  18 +--
 fs/ext4/inode.c                                    +AHw-  42 +--
 fs/libfs.c                                         +AHw-  39 +-+-
 fs/xfs/xfs+AF8-aops.c                                  +AHw-  34 +--
 fs/xfs/xfs+AF8-aops.h                                  +AHw-   1 +-
 fs/xfs/xfs+AF8-iops.c                                  +AHw-   5 +--
 include/linux/dax.h                                +AHw-  42 +--
 include/linux/fs.h                                 +AHw-   4 +-
 include/linux/libnvdimm.h                          +AHw-   4 +-
 include/linux/nd.h                                 +AHw-   6 +-
 include/linux/sched/deadline.h                     +AHw-   6 -
 include/linux/sched/isolation.h                    +AHw-   1 +-
 include/linux/sched/nohz.h                         +AHw-   4 -
 include/linux/tick.h                               +AHw-   4 +--
 include/linux/wait+AF8-bit.h                           +AHw-  70 +-+-+-
 kernel/sched/Makefile                              +AHw-   5 +--
 kernel/sched/autogroup.c                           +AHw-  21 +--
 kernel/sched/autogroup.h                           +AHw-  12 +--
 kernel/sched/clock.c                               +AHw-  36 +--
 kernel/sched/completion.c                          +AHw-   5 +--
 kernel/sched/core.c                                +AHw- 165 +-+-+---
 kernel/sched/cpuacct.c                             +AHw-  33 +--
 kernel/sched/cpudeadline.c                         +AHw-  23 +--
 kernel/sched/cpudeadline.h                         +AHw-  29 +--
 kernel/sched/cpufreq.c                             +AHw-   1 -
 kernel/sched/cpufreq+AF8-schedutil.c                   +AHw- 137 +-+----
 kernel/sched/cpupri.c                              +AHw-  15 +--
 kernel/sched/cpupri.h                              +AHw-  25 +--
 kernel/sched/cputime.c                             +AHw-  58 +--
 kernel/sched/deadline.c                            +AHw-  78 +---
 kernel/sched/debug.c                               +AHw-  99 +-+--
 kernel/sched/fair.c                                +AHw- 299 +-+-+-+-+-----
 kernel/sched/idle.c                                +AHw- 142 +-+-+-+--
 kernel/sched/idle+AF8-task.c                           +AHw- 110 ----
 kernel/sched/isolation.c                           +AHw-  14 +--
 kernel/sched/loadavg.c                             +AHw-  34 +--
 kernel/sched/membarrier.c                          +AHw-  27 +--
 kernel/sched/rt.c                                  +AHw-  51 +--
 kernel/sched/sched.h                               +AHw- 623 +-+-+-+-+-+-+-+-+-+----------
 kernel/sched/stats.c                               +AHw-  20 +--
 kernel/sched/stats.h                               +AHw-  86 +-+--
 kernel/sched/stop+AF8-task.c                           +AHw-  11 +--
 kernel/sched/swait.c                               +AHw-   6 +--
 kernel/sched/topology.c                            +AHw-  46 +--
 kernel/sched/wait.c                                +AHw-  13 +--
 kernel/sched/wait+AF8-bit.c                            +AHw-  71 +-+--
 kernel/time/tick-sched.c                           +AHw-  15 +--
 kernel/workqueue.c                                 +AHw-   3 +--
 tools/testing/nvdimm/test/nfit.c                   +AHw- 239 +-+-+-+-+----
 tools/testing/nvdimm/test/nfit+AF8-test.h              +AHw-  16 +-
 89 files changed, 2513 insertions(+-), 1901 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pmem/pmem-region.txt
 create mode 100644 drivers/nvdimm/of+AF8-pmem.c
 delete mode 100644 kernel/sched/idle+AF8-task.c

---
Test merge diffstat:

 .../devicetree/bindings/pmem/pmem-region.txt       +AHw-  65 +-+-
 MAINTAINERS                                        +AHw-   8 +-
 arch/powerpc/platforms/powernv/opal.c              +AHw-   3 +-
 drivers/acpi/nfit/core.c                           +AHw- 679 +-+-+-+-+-+-+-+-+-+------------
 drivers/acpi/nfit/mce.c                            +AHw-   5 +--
 drivers/acpi/nfit/nfit.h                           +AHw-  22 +--
 drivers/dax/Kconfig                                +AHw-   5 +--
 drivers/dax/device.c                               +AHw-  38 +--
 drivers/dax/pmem.c                                 +AHw-  18 +--
 drivers/dax/super.c                                +AHw-  15 +--
 drivers/md/Kconfig                                 +AHw-   2 +--
 drivers/md/dm-linear.c                             +AHw-   6 +-
 drivers/md/dm-log-writes.c                         +AHw-  95 +---
 drivers/md/dm-stripe.c                             +AHw-   6 +-
 drivers/md/dm.c                                    +AHw-  10 +--
 drivers/nvdimm/Kconfig                             +AHw-  13 +--
 drivers/nvdimm/Makefile                            +AHw-   1 +-
 drivers/nvdimm/btt+AF8-devs.c                          +AHw-  21 +--
 drivers/nvdimm/bus.c                               +AHw-  14 +--
 drivers/nvdimm/claim.c                             +AHw-   2 +--
 drivers/nvdimm/core.c                              +AHw-   6 +--
 drivers/nvdimm/dax+AF8-devs.c                          +AHw-   5 +--
 drivers/nvdimm/dimm.c                              +AHw-   8 +--
 drivers/nvdimm/dimm+AF8-devs.c                         +AHw-   7 +--
 drivers/nvdimm/label.c                             +AHw-  85 +---
 drivers/nvdimm/label.h                             +AHw-   2 +--
 drivers/nvdimm/namespace+AF8-devs.c                    +AHw-  42 +--
 drivers/nvdimm/nd.h                                +AHw-   1 -
 drivers/nvdimm/of+AF8-pmem.c                           +AHw- 119 +-+-+-+-
 drivers/nvdimm/pfn+AF8-devs.c                          +AHw-  25 +--
 drivers/nvdimm/pmem.c                              +AHw-  14 +--
 drivers/nvdimm/region.c                            +AHw-   4 +--
 drivers/nvdimm/region+AF8-devs.c                       +AHw-   9 +-
 drivers/s390/block/Kconfig                         +AHw-   2 +--
 fs/block+AF8-dev.c                                     +AHw-   5 -
 fs/dax.c                                           +AHw- 146 +-+-+---
 fs/ext2/ext2.h                                     +AHw-   1 +-
 fs/ext2/inode.c                                    +AHw-  46 +--
 fs/ext2/namei.c                                    +AHw-  18 +--
 fs/ext4/inode.c                                    +AHw-  42 +--
 fs/libfs.c                                         +AHw-  39 +-+-
 fs/xfs/xfs+AF8-aops.c                                  +AHw-  34 +--
 fs/xfs/xfs+AF8-aops.h                                  +AHw-   1 +-
 fs/xfs/xfs+AF8-iops.c                                  +AHw-   5 +--
 include/linux/dax.h                                +AHw-  42 +--
 include/linux/fs.h                                 +AHw-   4 +-
 include/linux/libnvdimm.h                          +AHw-   4 +-
 include/linux/nd.h                                 +AHw-   6 +-
 tools/testing/nvdimm/test/nfit.c                   +AHw- 239 +-+-+-+-+----
 tools/testing/nvdimm/test/nfit+AF8-test.h              +AHw-  16 +-
 50 files changed, 1217 insertions(+-), 788 deletions(-)
