Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752336AbeCCUUA convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 15:20:00 -0500
Received: from mga18.intel.com ([134.134.136.126]:31690 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752205AbeCCUT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 15:19:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,419,1515484800";
   d="scan'208";a="32179236"
From: "Williams, Dan J" <dan.j.williams@intel.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: [GIT PULL] libnvdimm fixes for 4.16-rc4
Thread-Topic: [GIT PULL] libnvdimm fixes for 4.16-rc4
Thread-Index: AQHTsyz9Kg03qwnzrEGwlD068Z2KPA==
Date: Sat, 3 Mar 2018 20:19:53 +0000
Message-ID: <1520108377.25654.20.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.177.67]
Content-Type: text/plain; charset="utf-7"
Content-ID: <5D4BC69061976042839E62E006438E43@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm libnvdimm-fixes

...to receive a 4.16 regression fix, 3 fixes for -stable, and a cleanup
fix.

+ACo- During the merge window support for the new ACPI NVDIMM Platform
Capabilities structure disabled support for +ACI-deep flush+ACI-, a force-unit-
access like mechanism for persistent memory. Restore that mechanism.

+ACo- VFIO like RDMA is yet one more memory registration / pinning
interface that is incompatible with Filesystem-DAX. Disable long term
pins of Filesystem-DAX mappings via VFIO.

+ACo- The Filesystem-DAX detection to prevent long terms pins mistakenly
also disabled Device-DAX pins which are not subject to the same block-
map collision concerns.

+ACo- Similar to the setup path, softlockup warnings can trigger in the
shutdown path for large persistent memory namespaces. Teach
for+AF8-each+AF8-device+AF8-pfn() to perform cond+AF8-resched() in all cases.

+ACo- Boaz noticed that the might+AF8-sleep() in dax+AF8-direct+AF8-access() is stale
as of the v4.15 kernel.

These have received a build success notification from the 0day robot,
and the longterm pin fixes have appeared in -next. However, I recently
rebased the tree to remove some other fixes that need to be reworked
after review feedback.

---

The following changes since commit 91ab883eb21325ad80f3473633f794c78ac87f51:

  Linux 4.16-rc2 (2018-02-18 17:29:42 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm libnvdimm-fixes

for you to fetch changes up to 949b93250a566cc7a578b4f829cf76b70d19a62c:

  memremap: fix softlockup reports at teardown (2018-03-02 19:34:50 -0800)

----------------------------------------------------------------
Boaz Harrosh (1):
      dax: -+AD4-direct+AF8-access does not sleep anymore

Dan Williams (3):
      dax: fix vma+AF8-is+AF8-fsdax() helper
      vfio: disable filesystem-dax page pinning
      memremap: fix softlockup reports at teardown

Dave Jiang (1):
      libnvdimm: re-enable deep flush for pmem devices via fsync()

 drivers/dax/super.c             +AHw-  6 ------
 drivers/nvdimm/pmem.c           +AHw-  3 +---
 drivers/vfio/vfio+AF8-iommu+AF8-type1.c +AHw- 18 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+----
 include/linux/fs.h              +AHw-  2 +--
 kernel/memremap.c               +AHw- 15 +-+-+-+-+-+-+-+-+-+------
 5 files changed, 27 insertions(+-), 17 deletions(-)

---

commit 9d4949b4935831be10534d5432bf611285a572a5
Author: Boaz Harrosh +ADw-boazh+AEA-netapp.com+AD4-
Date:   Mon Feb 26 18:50:35 2018 +-0200

    dax: -+AD4-direct+AF8-access does not sleep anymore
    
    In Patch:
            +AFs-7a862fb+AF0- brd: remove dax support
    
      Dan Williams has removed the only might+AF8-sleep
      implementation of -+AD4-direct+AF8-access.
      So we no longer need to check for it.
    
    CC: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-
    Signed-off-by: Boaz Harrosh +ADw-boazh+AEA-netapp.com+AD4-
    Signed-off-by: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-

commit 230f5a8969d8345fc9bbe3683f068246cf1be4b8
Author: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-
Date:   Wed Feb 21 17:08:01 2018 -0800

    dax: fix vma+AF8-is+AF8-fsdax() helper
    
    Gerd reports that -+AD4-i+AF8-mode may contain other bits besides S+AF8-IFCHR. Use
    S+AF8-ISCHR() instead. Otherwise, get+AF8-user+AF8-pages+AF8-longterm() may fail on
    device-dax instances when those are meant to be explicitly allowed.
    
    Fixes: 2bb6d2837083 (+ACI-mm: introduce get+AF8-user+AF8-pages+AF8-longterm+ACI-)
    Cc: +ADw-stable+AEA-vger.kernel.org+AD4-
    Reported-by: Gerd Rausch +ADw-gerd.rausch+AEA-oracle.com+AD4-
    Acked-by: Jane Chu +ADw-jane.chu+AEA-oracle.com+AD4-
    Reported-by: Haozhong Zhang +ADw-haozhong.zhang+AEA-intel.com+AD4-
    Reviewed-by: Jan Kara +ADw-jack+AEA-suse.cz+AD4-
    Signed-off-by: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-

commit 94db151dc89262bfa82922c44e8320cea2334667
Author: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-
Date:   Sun Feb 4 10:34:02 2018 -0800

    vfio: disable filesystem-dax page pinning
    
    Filesystem-DAX is incompatible with 'longterm' page pinning. Without
    page cache indirection a DAX mapping maps filesystem blocks directly.
    This means that the filesystem must not modify a file's block map while
    any page in a mapping is pinned. In order to prevent the situation of
    userspace holding of filesystem operations indefinitely, disallow
    'longterm' Filesystem-DAX mappings.
    
    RDMA has the same conflict and the plan there is to add a 'with lease'
    mechanism to allow the kernel to notify userspace that the mapping is
    being torn down for block-map maintenance. Perhaps something similar can
    be put in place for vfio.
    
    Note that xfs and ext4 still report:
    
       +ACI-DAX enabled. Warning: EXPERIMENTAL, use at your own risk+ACI-
    
    ...at mount time, and resolving the dax-dma-vs-truncate problem is one
    of the last hurdles to remove that designation.
    
    Acked-by: Alex Williamson +ADw-alex.williamson+AEA-redhat.com+AD4-
    Cc: Michal Hocko +ADw-mhocko+AEA-suse.com+AD4-
    Cc: kvm+AEA-vger.kernel.org
    Cc: +ADw-stable+AEA-vger.kernel.org+AD4-
    Reported-by: Haozhong Zhang +ADw-haozhong.zhang+AEA-intel.com+AD4-
    Tested-by: Haozhong Zhang +ADw-haozhong.zhang+AEA-intel.com+AD4-
    Fixes: d475c6346a38 (+ACI-dax,ext2: replace XIP read and write with DAX I/O+ACI-)
    Reviewed-by: Christoph Hellwig +ADw-hch+AEA-lst.de+AD4-
    Signed-off-by: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-

commit 5fdf8e5ba5666fe153bd61f851a40078a6347822
Author: Dave Jiang +ADw-dave.jiang+AEA-intel.com+AD4-
Date:   Fri Mar 2 19:31:40 2018 -0800

    libnvdimm: re-enable deep flush for pmem devices via fsync()
    
    Re-enable deep flush so that users always have a way to be sure that a
    write makes it all the way out to media. Writes from the PMEM driver
    always arrive at the NVDIMM since movnt is used to bypass the cache, and
    the driver relies on the ADR (Asynchronous DRAM Refresh) mechanism to
    flush write buffers on power failure. The Deep Flush mechanism is there
    to explicitly write buffers to protect against (rare) ADR failure.  This
    change prevents a regression in deep flush behavior so that applications
    can continue to depend on fsync() as a mechanism to trigger deep flush
    in the filesystem-DAX case.
    
    Fixes: 06e8ccdab15f4 (+ACI-acpi: nfit: Add support for detect platform CPU cache...+ACI-)
    Reviewed-by: Jeff Moyer +ADw-jmoyer+AEA-redhat.com+AD4-
    Signed-off-by: Dave Jiang +ADw-dave.jiang+AEA-intel.com+AD4-
    Signed-off-by: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-

commit 949b93250a566cc7a578b4f829cf76b70d19a62c
Author: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-
Date:   Tue Feb 6 19:34:11 2018 -0800

    memremap: fix softlockup reports at teardown
    
    The cond+AF8-resched() currently in the setup path needs to be duplicated in
    the teardown path. Rather than require each instance of
    for+AF8-each+AF8-device+AF8-pfn() to open code the same sequence, embed it in the
    helper.
    
    Link: https://github.com/intel/ixpdimm+AF8-sw/issues/11
    Cc: +ACI-J+AOk-r+APQ-me Glisse+ACI- +ADw-jglisse+AEA-redhat.com+AD4-
    Cc: Michal Hocko +ADw-mhocko+AEA-suse.com+AD4-
    Cc: Christoph Hellwig +ADw-hch+AEA-lst.de+AD4-
    Cc: +ADw-stable+AEA-vger.kernel.org+AD4-
    Fixes: 71389703839e (+ACI-mm, zone+AF8-device: Replace +AHs-get, put+AH0AXw-zone+AF8-device+AF8-page()...+ACI-)
    Signed-off-by: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-
