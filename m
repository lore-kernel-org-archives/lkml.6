Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843CAC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B3A218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388127AbfAaQKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:10:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52310 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbfAaQKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:10:16 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 80D073DBD2;
        Thu, 31 Jan 2019 16:10:14 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4530C5D717;
        Thu, 31 Jan 2019 16:10:08 +0000 (UTC)
Date:   Thu, 31 Jan 2019 11:10:06 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jan Kara <jack@suse.cz>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, kvm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 0/9] mmu notifier provide context informations
Message-ID: <20190131161006.GA16593@redhat.com>
References: <20190123222315.1122-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190123222315.1122-1-jglisse@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 31 Jan 2019 16:10:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew what is your plan for this ? I had a discussion with Peter Xu
and Andrea about change_pte() and kvm. Today the change_pte() kvm
optimization is effectively disabled because of invalidate_range
calls. With a minimal couple lines patch on top of this patchset
we can bring back the kvm change_pte optimization and we can also
optimize some other cases like for instance when write protecting
after fork (but i am not sure this is something qemu does often so
it might not help for real kvm workload).

I will be posting a the extra patch as an RFC, but in the meantime
i wanted to know what was the status for this.


Jan, Christian does your previous ACK still holds for this ?


On Wed, Jan 23, 2019 at 05:23:06PM -0500, jglisse@redhat.com wrote:
> From: Jérôme Glisse <jglisse@redhat.com>
> 
> Hi Andrew, i see that you still have my event patch in you queue [1].
> This patchset replace that single patch and is broken down in further
> step so that it is easier to review and ascertain that no mistake were
> made during mechanical changes. Here are the step:
> 
>     Patch 1 - add the enum values
>     Patch 2 - coccinelle semantic patch to convert all call site of
>               mmu_notifier_range_init to default enum value and also
>               to passing down the vma when it is available
>     Patch 3 - update many call site to more accurate enum values
>     Patch 4 - add the information to the mmu_notifier_range struct
>     Patch 5 - helper to test if a range is updated to read only
> 
> All the remaining patches are update to various driver to demonstrate
> how this new information get use by device driver. I build tested
> with make all and make all minus everything that enable mmu notifier
> ie building with MMU_NOTIFIER=no. Also tested with some radeon,amd
> gpu and intel gpu.
> 
> If they are no objections i believe best plan would be to merge the
> the first 5 patches (all mm changes) through your queue for 5.1 and
> then to delay driver update to each individual driver tree for 5.2.
> This will allow each individual device driver maintainer time to more
> thouroughly test this more then my own testing.
> 
> Note that i also intend to use this feature further in nouveau and
> HMM down the road. I also expect that other user like KVM might be
> interested into leveraging this new information to optimize some of
> there secondary page table invalidation.
> 
> Here is an explaination on the rational for this patchset:
> 
> 
> CPU page table update can happens for many reasons, not only as a result
> of a syscall (munmap(), mprotect(), mremap(), madvise(), ...) but also
> as a result of kernel activities (memory compression, reclaim, migration,
> ...).
> 
> This patch introduce a set of enums that can be associated with each of
> the events triggering a mmu notifier. Latter patches take advantages of
> those enum values.
> 
> - UNMAP: munmap() or mremap()
> - CLEAR: page table is cleared (migration, compaction, reclaim, ...)
> - PROTECTION_VMA: change in access protections for the range
> - PROTECTION_PAGE: change in access protections for page in the range
> - SOFT_DIRTY: soft dirtyness tracking
> 
> Being able to identify munmap() and mremap() from other reasons why the
> page table is cleared is important to allow user of mmu notifier to
> update their own internal tracking structure accordingly (on munmap or
> mremap it is not longer needed to track range of virtual address as it
> becomes invalid).
> 
> [1] https://www.ozlabs.org/~akpm/mmotm/broken-out/mm-mmu_notifier-contextual-information-for-event-triggering-invalidation-v2.patch
> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthew Wilcox <mawilcox@microsoft.com>
> Cc: Ross Zwisler <zwisler@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: kvm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-rdma@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Arnd Bergmann <arnd@arndb.de>
> 
> Jérôme Glisse (9):
>   mm/mmu_notifier: contextual information for event enums
>   mm/mmu_notifier: contextual information for event triggering
>     invalidation
>   mm/mmu_notifier: use correct mmu_notifier events for each invalidation
>   mm/mmu_notifier: pass down vma and reasons why mmu notifier is
>     happening
>   mm/mmu_notifier: mmu_notifier_range_update_to_read_only() helper
>   gpu/drm/radeon: optimize out the case when a range is updated to read
>     only
>   gpu/drm/amdgpu: optimize out the case when a range is updated to read
>     only
>   gpu/drm/i915: optimize out the case when a range is updated to read
>     only
>   RDMA/umem_odp: optimize out the case when a range is updated to read
>     only
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c  | 13 ++++++++
>  drivers/gpu/drm/i915/i915_gem_userptr.c | 16 ++++++++++
>  drivers/gpu/drm/radeon/radeon_mn.c      | 13 ++++++++
>  drivers/infiniband/core/umem_odp.c      | 22 +++++++++++--
>  fs/proc/task_mmu.c                      |  3 +-
>  include/linux/mmu_notifier.h            | 42 ++++++++++++++++++++++++-
>  include/rdma/ib_umem_odp.h              |  1 +
>  kernel/events/uprobes.c                 |  3 +-
>  mm/huge_memory.c                        | 14 +++++----
>  mm/hugetlb.c                            | 11 ++++---
>  mm/khugepaged.c                         |  3 +-
>  mm/ksm.c                                |  6 ++--
>  mm/madvise.c                            |  3 +-
>  mm/memory.c                             | 25 +++++++++------
>  mm/migrate.c                            |  5 ++-
>  mm/mmu_notifier.c                       | 10 ++++++
>  mm/mprotect.c                           |  4 ++-
>  mm/mremap.c                             |  3 +-
>  mm/oom_kill.c                           |  3 +-
>  mm/rmap.c                               |  6 ++--
>  20 files changed, 171 insertions(+), 35 deletions(-)
> 
> -- 
> 2.17.2
> 
