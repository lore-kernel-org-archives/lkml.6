Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753911AbeENOnP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:43:15 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44000 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753284AbeENOnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:43:14 -0400
From: Punit Agrawal <punit.agrawal@arm.com>
To: kvmarm@lists.cs.columbia.edu
Cc: Punit Agrawal <punit.agrawal@arm.com>,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, linux-kernel@vger.kernel.org,
        suzuki.poulose@arm.com
Subject: [PATCH v3 0/4] KVM: Support PUD hugepages at stage 2
Date: Mon, 14 May 2018 15:43:00 +0100
Message-Id: <20180514144304.10484-1-punit.agrawal@arm.com>
X-Mailer: git-send-email 2.17.0
X-ARM-No-Footer: FoSSMail
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset adds support for PUD hugepages at stage 2. This feature
is useful on cores that have support for large sized TLB mappings
(e.g., 1GB for 4K granule). Previous postings can be found at
[0][1][2].

Support is added to code that is shared between arm and arm64. Dummy
helpers for arm are provided as the port does not support PUD hugepage
sizes.

There is a small conflict with the series to add support for 52 bit
IPA[3]. The patches have been functionally tested on an A57 based
system. The patchset is based on v4.17-rc5 and incorporates feedback
received on the previous version.

Thanks,
Punit

v2 -> v3:
* Update vma_pagesize directly if THP [1/4]. Previsouly this was done
  indirectly via hugetlb
* Added review tag [4/4]

v1 -> v2:
* Create helper to check if the page should have exec permission [1/4]
* Fix broken condition to detect THP hugepage [1/4]
* Fix in-correct hunk resulting from a rebase [4/4]

[0] https://www.spinics.net/lists/arm-kernel/msg628053.html
[1] https://lkml.org/lkml/2018/4/20/566
[2] https://lkml.org/lkml/2018/5/1/133
[3] https://lwn.net/Articles/750176/


Punit Agrawal (4):
  KVM: arm/arm64: Share common code in user_mem_abort()
  KVM: arm/arm64: Introduce helpers to manupulate page table entries
  KVM: arm64: Support dirty page tracking for PUD hugepages
  KVM: arm64: Add support for PUD hugepages at stage 2

 arch/arm/include/asm/kvm_mmu.h         |  40 ++++++++
 arch/arm64/include/asm/kvm_mmu.h       |  30 ++++++
 arch/arm64/include/asm/pgtable-hwdef.h |   4 +
 arch/arm64/include/asm/pgtable.h       |   2 +
 virt/kvm/arm/mmu.c                     | 121 +++++++++++++++++--------
 5 files changed, 161 insertions(+), 36 deletions(-)

-- 
2.17.0
