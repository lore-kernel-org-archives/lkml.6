Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE88ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1AF206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:10:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC1AF206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbeGPRih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 13:38:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:13644 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727843AbeGPRig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 13:38:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 10:10:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,362,1526367600"; 
   d="scan'208";a="72792359"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga001.fm.intel.com with ESMTP; 16 Jul 2018 10:10:17 -0700
Subject: [PATCH v2 00/14] mm: Asynchronous + multithreaded memmap init for
 ZONE_DEVICE
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Tony Luck <tony.luck@intel.com>, Huaisheng Ye <yehs1@lenovo.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Dave Jiang <dave.jiang@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Rich Felker <dalias@libc.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michal Hocko <mhocko@suse.com>,
        Paul Mackerras <paulus@samba.org>,
        Christoph Hellwig <hch@lst.de>,
        =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org,
        Logan Gunthorpe <logang@deltatee.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-mm@kvack.org, jack@suse.cz, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 16 Jul 2018 10:00:19 -0700
Message-ID: <153176041838.12695.3365448145295112857.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1 [1]:
* Teach memmap_sync() to take over a sub-set of memmap initialization in
  the foreground. This foreground work still needs to await the
  completion of vmemmap_populate_hugepages(), but it will otherwise
  steal 1/1024th of the 'struct page' init work for the given range.
  (Jan)
* Add kernel-doc for all the new 'async' structures.
* Split foreach_order_pgoff() to its own patch.
* Add Pavel and Daniel to the cc as they have been active in the memory
  hotplug code.
* Fix a typo that prevented CONFIG_DAX_DRIVER_DEBUG=y from performing
  early pfn retrieval at dax-filesystem mount time.
* Improve some of the changelogs

[1]: https://lwn.net/Articles/759117/

---

In order to keep pfn_to_page() a simple offset calculation the 'struct
page' memmap needs to be mapped and initialized in advance of any usage
of a page. This poses a problem for large memory systems as it delays
full availability of memory resources for 10s to 100s of seconds.

For typical 'System RAM' the problem is mitigated by the fact that large
memory allocations tend to happen after the kernel has fully initialized
and userspace services / applications are launched. A small amount, 2GB
of memory, is initialized up front. The remainder is initialized in the
background and freed to the page allocator over time.

Unfortunately, that scheme is not directly reusable for persistent
memory and dax because userspace has visibility to the entire resource
pool and can choose to access any offset directly at its choosing. In
other words there is no allocator indirection where the kernel can
satisfy requests with arbitrary pages as they become initialized.

That said, we can approximate the optimization by performing the
initialization in the background, allow the kernel to fully boot the
platform, start up pmem block devices, mount filesystems in dax mode,
and only incur delay at the first userspace dax fault. When that initial
fault occurs that process is delegated a portion of the memmap to
initialize in the foreground so that it need not wait for initialization
of resources that it does not immediately need.

With this change an 8 socket system was observed to initialize pmem
namespaces in ~4 seconds whereas it was previously taking ~4 minutes.

These patches apply on top of the HMM + devm_memremap_pages() reworks:

https://marc.info/?l=linux-mm&m=153128668008585&w=2

---

Dan Williams (10):
      mm: Plumb dev_pagemap instead of vmem_altmap to memmap_init_zone()
      mm: Enable asynchronous __add_pages() and vmemmap_populate_hugepages()
      mm: Teach memmap_init_zone() to initialize ZONE_DEVICE pages
      mm: Multithread ZONE_DEVICE initialization
      mm, memremap: Up-level foreach_order_pgoff()
      mm: Allow an external agent to coordinate memmap initialization
      filesystem-dax: Make mount time pfn validation a debug check
      libnvdimm, pmem: Initialize the memmap in the background
      device-dax: Initialize the memmap in the background
      libnvdimm, namespace: Publish page structure init state / control

Huaisheng Ye (4):
      libnvdimm, pmem: Allow a NULL-pfn to ->direct_access()
      tools/testing/nvdimm: Allow a NULL-pfn to ->direct_access()
      s390, dcssblk: Allow a NULL-pfn to ->direct_access()
      filesystem-dax: Do not request a pfn when not required


 arch/ia64/mm/init.c             |    5 +
 arch/powerpc/mm/mem.c           |    5 +
 arch/s390/mm/init.c             |    8 +
 arch/sh/mm/init.c               |    5 +
 arch/x86/mm/init_32.c           |    8 +
 arch/x86/mm/init_64.c           |   27 ++--
 drivers/dax/Kconfig             |   10 +
 drivers/dax/dax-private.h       |    2 
 drivers/dax/device-dax.h        |    2 
 drivers/dax/device.c            |   16 ++
 drivers/dax/pmem.c              |    5 +
 drivers/dax/super.c             |   64 ++++++---
 drivers/nvdimm/nd.h             |    2 
 drivers/nvdimm/pfn_devs.c       |   50 +++++--
 drivers/nvdimm/pmem.c           |   17 ++
 drivers/nvdimm/pmem.h           |    1 
 drivers/s390/block/dcssblk.c    |    5 -
 fs/dax.c                        |   10 -
 include/linux/memmap_async.h    |  110 ++++++++++++++++
 include/linux/memory_hotplug.h  |   18 ++-
 include/linux/memremap.h        |   31 ++++
 include/linux/mm.h              |    8 +
 kernel/memremap.c               |   85 ++++++------
 mm/memory_hotplug.c             |   73 ++++++++---
 mm/page_alloc.c                 |  271 +++++++++++++++++++++++++++++++++++----
 mm/sparse-vmemmap.c             |   56 ++++++--
 tools/testing/nvdimm/pmem-dax.c |   11 +-
 27 files changed, 717 insertions(+), 188 deletions(-)
 create mode 100644 include/linux/memmap_async.h
