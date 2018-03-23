Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751898AbeCWAeP convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 20:34:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:37373 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751668AbeCWAeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 20:34:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,347,1517904000";
   d="scan'208";a="213857345"
From: "Williams, Dan J" <dan.j.williams@intel.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: [GIT PULL] libnvdimm fixes for 4.16-rc7
Thread-Topic: [GIT PULL] libnvdimm fixes for 4.16-rc7
Thread-Index: AQHTwj6pW0vPdQ0I50qtHHoReqyFMw==
Date: Fri, 23 Mar 2018 00:34:10 +0000
Message-ID: <1521765242.9257.19.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.24.9.1]
Content-Type: text/plain; charset="utf-7"
Content-ID: <A20C5207B42157439D50FD9D053FAC95@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm libnvdimm-fixes

...to receive 2 regression fixes, 2 bug fixes for older issues, 2
fixes for new functionality added this cycle that have userspace ABI
concerns, and a small cleanup. These have appeared in a linux-next
release and have a build success report from the 0day robot.

+ACo- The 4.16 rework of altmap handling led to some configurations leaking
page table allocations due to freeing from the altmap reservation
rather than the page allocator. The impact without the fix is leaked
memory and a WARN() message when tearing down libnvdimm namespaces. The
rework also missed a place where error handling code needed to be
removed that can lead to a crash if devm+AF8-memremap+AF8-pages() fails.

+ACo- acpi+AF8-map+AF8-pxm+AF8-to+AF8-node() had a latent bug whereby it could misidentify
the closest online node to a given proximity domain.

+ACo- Block integrity handling was reworked several kernels back to allow
calling add+AF8-disk() after setting up the integrity profile. The nd+AF8-btt
and nd+AF8-blk drivers are just now catching up to fix automatic partition
detection at driver load time.

+ACo- The new peristence+AF8-domain attribute, a platform indicator of whether
cpu caches are powerfail protected for example, is meant to be a single
value enum and not a set of flags. This oversight was caught while
reviewing new userspace code in libndctl to communicate the attribute.
Fix this new enabling up so that we are not stuck with an unwanted
userspace ABI.

The following changes since commit 661e50bc853209e41a5c14a290ca4decc43cbfd1:

  Linux 4.16-rc4 (2018-03-04 14:54:11 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm libnvdimm-fixes

for you to fetch changes up to fe9a552e715dfe5167d52deb74ea16335896bdaf:

  libnvdimm, nfit: fix persistence domain reporting (2018-03-21 15:12:07 -0700)

----------------------------------------------------------------
Colin Ian King (1):
      libnvdimm: remove redundant assignment to pointer 'dev'

Dan Williams (4):
      x86, memremap: fix altmap accounting at free
      acpi, numa: fix pxm to online numa node associations
      libnvdimm, region: hide persistence+AF8-domain when unknown
      libnvdimm, nfit: fix persistence domain reporting

Oliver O'Halloran (1):
      kernel/memremap: Remove stale devres+AF8-free() call

Vishal Verma (1):
      libnvdimm, +AHs-btt, blk+AH0-: do integrity setup before add+AF8-disk()

 arch/x86/mm/init+AF8-64.c        +AHw- 60 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+------------------------
 drivers/acpi/nfit/core.c     +AHw- 10 +-+-+-+-+----
 drivers/acpi/numa.c          +AHw- 10 +-+-+-+-+----
 drivers/nvdimm/blk.c         +AHw-  3 +---
 drivers/nvdimm/btt.c         +AHw-  3 +---
 drivers/nvdimm/pfn+AF8-devs.c    +AHw-  2 +--
 drivers/nvdimm/region+AF8-devs.c +AHw- 17 +-+-+-+-+-+-+-+-+-+----
 kernel/memremap.c            +AHw-  1 -
 8 files changed, 57 insertions(+-), 49 deletions(-)
