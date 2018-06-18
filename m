Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97D2C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7678020864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7678020864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966835AbeFRJS5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:18:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:38574 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933604AbeFRJSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:18:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CEB39ACE9;
        Mon, 18 Jun 2018 09:18:27 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-api@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Vijayanand Jitta <vjitta@codeaurora.org>
Subject: [PATCH v2 0/7] kmalloc-reclaimable caches
Date:   Mon, 18 Jun 2018 11:18:01 +0200
Message-Id: <20180618091808.4419-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 drivers/staging/android/ion/ion_page_pool.c |   4 +-
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
 13 files changed, 159 insertions(+), 127 deletions(-)

-- 
2.17.1

