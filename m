Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA875C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC63B22510
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC63B22510
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730988AbeKMQaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 11:30:09 -0500
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:5128 "EHLO
        alexa-out-blr.qualcomm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726173AbeKMQaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 11:30:08 -0500
X-IronPort-AV: E=Sophos;i="5.54,498,1534789800"; 
   d="scan'208";a="237808"
Received: from ironmsg03-blr.qualcomm.com ([10.86.208.132])
  by alexa-out-blr.qualcomm.com with ESMTP/TLS/AES256-SHA; 13 Nov 2018 12:03:26 +0530
X-IronPort-AV: E=McAfee;i="5900,7806,9075"; a="2020977"
Received: from blr-ubuntu-104.ap.qualcomm.com (HELO blr-ubuntu-104.qualcomm.com) ([10.79.40.64])
  by ironmsg03-blr.qualcomm.com with ESMTP; 13 Nov 2018 12:03:26 +0530
Received: by blr-ubuntu-104.qualcomm.com (Postfix, from userid 346745)
        id CA7AA269C; Tue, 13 Nov 2018 12:03:24 +0530 (IST)
From:   Arun KS <arunks@codeaurora.org>
Cc:     keescook@chromium.org, khlebnikov@yandex-team.ru,
        minchan@kernel.org, getarunks@gmail.com,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        mhocko@kernel.org, vbabka@suse.cz, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vatsa@codeaurora.org, willy@infradead.org,
        Arun KS <arunks@codeaurora.org>
Subject: [PATCH v5 0/4] mm: convert totalram_pages, totalhigh_pages and managed pages to atomic
Date:   Tue, 13 Nov 2018 12:03:06 +0530
Message-Id: <1542090790-21750-1-git-send-email-arunks@codeaurora.org>
X-Mailer: git-send-email 1.9.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series convert totalram_pages, totalhigh_pages and
zone->managed_pages to atomic variables.

The patch was comiple tested on x86(x86_64_defconfig & i386_defconfig)
on 4.20-rc2. And memory hotplug tested on arm64, but on an older version
of kernel.

totalram_pages, zone->managed_pages and totalhigh_pages updates
are protected by managed_page_count_lock, but readers never care
about it. Convert these variables to atomic to avoid readers
potentially seeing a store tear.

Main motivation was that managed_page_count_lock handling was
complicating things. It was discussed in length here,
https://lore.kernel.org/patchwork/patch/995739/#1181785
It seemes better to remove the lock and convert variables
to atomic. With the change, preventing poteintial store-to-read
tearing comes as a bonus.

Changes in v5:
- totalram_pgs renamed to nr_pages.
https://lore.kernel.org/patchwork/patch/1011293/#1194248

Changes in v4:
- Fixed kbuild test robot error.
- Modified changelog.
- Rebased to 4.20.-rc2

Changes in v3:
- Fixed kbuild test robot errors.
- Modified changelogs to be more clear.
- EXPORT_SYMBOL for _totalram_pages and _totalhigh_pages.

Arun KS (4):
  mm: reference totalram_pages and managed_pages once per function
  mm: convert zone->managed_pages to atomic variable
  mm: convert totalram_pages and totalhigh_pages variables to atomic
  mm: Remove managed_page_count spinlock

 arch/csky/mm/init.c                           |  4 +-
 arch/powerpc/platforms/pseries/cmm.c          | 10 ++--
 arch/s390/mm/init.c                           |  2 +-
 arch/um/kernel/mem.c                          |  4 +-
 arch/x86/kernel/cpu/microcode/core.c          |  5 +-
 drivers/char/agp/backend.c                    |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  2 +-
 drivers/gpu/drm/i915/i915_gem.c               |  2 +-
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c |  4 +-
 drivers/hv/hv_balloon.c                       | 19 +++----
 drivers/md/dm-bufio.c                         |  2 +-
 drivers/md/dm-crypt.c                         |  2 +-
 drivers/md/dm-integrity.c                     |  2 +-
 drivers/md/dm-stats.c                         |  2 +-
 drivers/media/platform/mtk-vpu/mtk_vpu.c      |  2 +-
 drivers/misc/vmw_balloon.c                    |  2 +-
 drivers/parisc/ccio-dma.c                     |  4 +-
 drivers/parisc/sba_iommu.c                    |  4 +-
 drivers/staging/android/ion/ion_system_heap.c |  2 +-
 drivers/xen/xen-selfballoon.c                 |  6 +--
 fs/ceph/super.h                               |  2 +-
 fs/file_table.c                               |  7 +--
 fs/fuse/inode.c                               |  2 +-
 fs/nfs/write.c                                |  2 +-
 fs/nfsd/nfscache.c                            |  2 +-
 fs/ntfs/malloc.h                              |  2 +-
 fs/proc/base.c                                |  2 +-
 include/linux/highmem.h                       | 28 ++++++++++-
 include/linux/mm.h                            | 27 +++++++++-
 include/linux/mmzone.h                        | 15 +++---
 include/linux/swap.h                          |  1 -
 kernel/fork.c                                 |  5 +-
 kernel/kexec_core.c                           |  5 +-
 kernel/power/snapshot.c                       |  2 +-
 lib/show_mem.c                                |  2 +-
 mm/highmem.c                                  |  5 +-
 mm/huge_memory.c                              |  2 +-
 mm/kasan/quarantine.c                         |  2 +-
 mm/memblock.c                                 |  6 +--
 mm/mm_init.c                                  |  2 +-
 mm/oom_kill.c                                 |  2 +-
 mm/page_alloc.c                               | 72 +++++++++++++--------------
 mm/shmem.c                                    |  7 +--
 mm/slab.c                                     |  2 +-
 mm/swap.c                                     |  2 +-
 mm/util.c                                     |  2 +-
 mm/vmalloc.c                                  |  4 +-
 mm/vmstat.c                                   |  4 +-
 mm/workingset.c                               |  2 +-
 mm/zswap.c                                    |  4 +-
 net/dccp/proto.c                              |  7 +--
 net/decnet/dn_route.c                         |  2 +-
 net/ipv4/tcp_metrics.c                        |  2 +-
 net/netfilter/nf_conntrack_core.c             |  7 +--
 net/netfilter/xt_hashlimit.c                  |  5 +-
 net/sctp/protocol.c                           |  7 +--
 security/integrity/ima/ima_kexec.c            |  2 +-
 57 files changed, 196 insertions(+), 142 deletions(-)

-- 
1.9.1

