Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522F0ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114E72075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 114E72075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbeGROOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:14:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:38138 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730234AbeGROO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:14:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D5357AD97;
        Wed, 18 Jul 2018 13:36:28 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Vijayanand Jitta <vjitta@codeaurora.org>
Subject: [PATCH v3 0/7] kmalloc-reclaimable caches
Date:   Wed, 18 Jul 2018 15:36:13 +0200
Message-Id: <20180718133620.6205-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3 changes:
- fix missing hunk in patch 5/7
- more verbose cover letter and patch 6/7 commit log
v2 changes:
- shorten cache names to kmalloc-rcl-<SIZE>
- last patch shortens <SIZE> for all kmalloc caches to e.g. "1k", "4M"
- include dma caches to the 2D kmalloc_caches[] array to avoid a branch
- vmstat counter nr_indirectly_reclaimable_bytes renamed to
  nr_kernel_misc_reclaimable, doesn't include kmalloc-rcl-*
- /proc/meminfo counter renamed to KReclaimable, includes kmalloc-rcl*
  and nr_kernel_misc_reclaimable

Hi,

as discussed at LSF/MM [1] here's a patchset that introduces
kmalloc-reclaimable caches (more details in the second patch) and uses them for
SLAB freelists and dcache external names. The latter allows us to repurpose the
NR_INDIRECTLY_RECLAIMABLE_BYTES counter later in the series.

With patch 4/7, dcache external names are allocated from kmalloc-rcl-*
caches, eliminating the need for manual accounting. More importantly, it
also ensures the reclaimable kmalloc allocations are grouped in pages
separate from the regular kmalloc allocations. The need for proper
accounting of dcache external names has shown it's easy for misbehaving
process to allocate lots of them, causing premature OOMs. Without the
added grouping, it's likely that a similar workload can interleave the
dcache external names allocations with regular kmalloc allocations
(note: I haven't searched myself for an example of such regular kmalloc
allocation, but I would be very surprised if there wasn't some). A
pathological case would be e.g. one 64byte regular allocations with 63
external dcache names in a page (64x64=4096), which means the page is
not freed even after reclaiming after all dcache names, and the process
can thus "steal" the whole page with single 64byte allocation.

If there other kmalloc users similar to dcache external names become
identified, they can also benefit from the new functionality simply by
adding __GFP_RECLAIMABLE to the kmalloc calls.

Side benefits of the patchset (that could be also merged separately)
include removed branch for detecting __GFP_DMA kmalloc(), and shortening
kmalloc cache names in /proc/slabinfo output. The latter is potentially
an ABI break in case there are tools parsing the names and expecting the
values to be in bytes.

This is how /proc/slabinfo looks like after booting in virtme:

...
kmalloc-rcl-4M         0      0 4194304    1 1024 : tunables    1    1    0 : slabdata      0      0      0
...
kmalloc-rcl-96         7     32    128   32    1 : tunables  120   60    8 : slabdata      1      1      0
kmalloc-rcl-64        25    128     64   64    1 : tunables  120   60    8 : slabdata      2      2      0
kmalloc-rcl-32         0      0     32  124    1 : tunables  120   60    8 : slabdata      0      0      0
kmalloc-4M             0      0 4194304    1 1024 : tunables    1    1    0 : slabdata      0      0      0
kmalloc-2M             0      0 2097152    1  512 : tunables    1    1    0 : slabdata      0      0      0
kmalloc-1M             0      0 1048576    1  256 : tunables    1    1    0 : slabdata      0      0      0
...

/proc/vmstat with renamed nr_indirectly_reclaimable_bytes counter:

...
nr_slab_reclaimable 2817
nr_slab_unreclaimable 1781
...
nr_kernel_misc_reclaimable 0
...

/proc/meminfo with new KReclaimable counter:

...
Shmem:               564 kB
KReclaimable:      11260 kB
Slab:              18368 kB
SReclaimable:      11260 kB
SUnreclaim:         7108 kB
KernelStack:        1248 kB
...

Thanks,
Vlastimil

Vlastimil Babka (7):
  mm, slab: combine kmalloc_caches and kmalloc_dma_caches
  mm, slab/slub: introduce kmalloc-reclaimable caches
  mm, slab: allocate off-slab freelists as reclaimable when appropriate
  dcache: allocate external names from reclaimable kmalloc caches
  mm: rename and change semantics of nr_indirectly_reclaimable_bytes
  mm, proc: add KReclaimable to /proc/meminfo
  mm, slab: shorten kmalloc cache names for large sizes

 Documentation/filesystems/proc.txt          |   4 +
 drivers/base/node.c                         |  19 ++--
 drivers/staging/android/ion/ion_page_pool.c |   8 +-
 fs/dcache.c                                 |  38 ++------
 fs/proc/meminfo.c                           |  16 +--
 include/linux/mmzone.h                      |   2 +-
 include/linux/slab.h                        |  49 +++++++---
 mm/page_alloc.c                             |  19 ++--
 mm/slab.c                                   |  11 ++-
 mm/slab_common.c                            | 102 ++++++++++++--------
 mm/slub.c                                   |  13 +--
 mm/util.c                                   |   3 +-
 mm/vmstat.c                                 |   6 +-
 13 files changed, 161 insertions(+), 129 deletions(-)

-- 
2.18.0

