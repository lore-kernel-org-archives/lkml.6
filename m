Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2C8C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359462081C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 359462081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeLEFhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 00:37:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53072 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbeLEFhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 00:37:01 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 40D9930820EA;
        Wed,  5 Dec 2018 05:37:01 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-120-80.rdu2.redhat.com [10.10.120.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C730A5C57E;
        Wed,  5 Dec 2018 05:36:58 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>
Subject: [PATCH v2 0/3] mmu notifier contextual informations
Date:   Wed,  5 Dec 2018 00:36:25 -0500
Message-Id: <20181205053628.3210-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 05 Dec 2018 05:37:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

Changes since v1:

- Fixed the case where mmu notifier is not enabled and avoid wasting
  memory and resource when that is the case.
- Fixed bug in migrate code.
- Use kernel doc format for describing kernel enum


v1 cover letter:

This patchset add contextual information, why an invalidation is
happening, to mmu notifier callback. This is necessary for user
of mmu notifier that wish to maintains their own data structure
without having to add new fields to struct vm_area_struct (vma).

For instance device can have they own page table that mirror the
process address space. When a vma is unmap (munmap() syscall) the
device driver can free the device page table for the range.

Today we do not have any information on why a mmu notifier call
back is happening and thus device driver have to assume that it
is always an munmap(). This is inefficient at it means that it
needs to re-allocate device page table on next page fault and
rebuild the whole device driver data structure for the range.

Other use case beside munmap() also exist, for instance it is
pointless for device driver to invalidate the device page table
when the invalidation is for the soft dirtyness tracking. Or
device driver can optimize away mprotect() that change the page
table permission access for the range.

This patchset enable all this optimizations for device driver.
I do not include any of those in this serie but other patchset
i am posting will leverage this.


From code point of view the patchset is pretty simple, the first
two patches consolidate all mmu notifier arguments into a struct
so that it is easier to add/change arguments. The last patch adds
the contextual information (munmap, protection, soft dirty, clear,
...).

Cheers,
Jérôme

Jérôme Glisse (3):
  mm/mmu_notifier: use structure for invalidate_range_start/end callback
  mm/mmu_notifier: use structure for invalidate_range_start/end calls v2
  mm/mmu_notifier: contextual information for event triggering
    invalidation v2

 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c  |  43 ++++----
 drivers/gpu/drm/i915/i915_gem_userptr.c |  14 ++-
 drivers/gpu/drm/radeon/radeon_mn.c      |  16 ++-
 drivers/infiniband/core/umem_odp.c      |  20 ++--
 drivers/infiniband/hw/hfi1/mmu_rb.c     |  13 +--
 drivers/misc/mic/scif/scif_dma.c        |  11 +-
 drivers/misc/sgi-gru/grutlbpurge.c      |  14 ++-
 drivers/xen/gntdev.c                    |  12 +--
 fs/dax.c                                |  15 ++-
 fs/proc/task_mmu.c                      |   8 +-
 include/linux/mm.h                      |   4 +-
 include/linux/mmu_notifier.h            | 132 ++++++++++++++++++------
 kernel/events/uprobes.c                 |  11 +-
 mm/hmm.c                                |  23 ++---
 mm/huge_memory.c                        |  58 +++++------
 mm/hugetlb.c                            |  54 +++++-----
 mm/khugepaged.c                         |  11 +-
 mm/ksm.c                                |  23 ++---
 mm/madvise.c                            |  22 ++--
 mm/memory.c                             | 103 +++++++++---------
 mm/migrate.c                            |  26 ++---
 mm/mmu_notifier.c                       |  22 ++--
 mm/mprotect.c                           |  16 +--
 mm/mremap.c                             |  11 +-
 mm/oom_kill.c                           |  17 +--
 mm/rmap.c                               |  32 +++---
 virt/kvm/kvm_main.c                     |  14 +--
 27 files changed, 404 insertions(+), 341 deletions(-)

-- 
2.17.2

