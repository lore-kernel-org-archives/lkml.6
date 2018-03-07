Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933688AbeCGRre (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:47:34 -0500
Received: from g2t2354.austin.hpe.com ([15.233.44.27]:4317 "EHLO
        g2t2354.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeCGRrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:47:33 -0500
From: Toshi Kani <toshi.kani@hpe.com>
To: mhocko@suse.com, akpm@linux-foundation.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, bp@suse.de, catalin.marinas@arm.com
Cc: guohanjun@huawei.com, will.deacon@arm.com, wxf.wang@hisilicon.com,
        linux-mm@kvack.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] fix memory leak / panic in ioremap huge pages
Date: Wed,  7 Mar 2018 11:32:25 -0700
Message-Id: <20180307183227.17983-1-toshi.kani@hpe.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On architectures with CONFIG_HAVE_ARCH_HUGE_VMAP set, ioremap()
may create pud/pmd mappings.  Kernel panic was observed on arm64
systems with Cortex-A75 in the following steps as described by
Hanjun Guo. [1]

1. ioremap a 4K size, valid page table will build,
2. iounmap it, pte0 will set to 0;
3. ioremap the same address with 2M size, pgd/pmd is unchanged,
   then set the a new value for pmd;
4. pte0 is leaked;
5. CPU may meet exception because the old pmd is still in TLB,
   which will lead to kernel panic.

This panic is not reproducible on x86.  INVLPG, called from iounmap,
purges all levels of entries associated with purged address on x86.
x86 still has memory leak.

Patch 01 adds new interfaces as stubs, which work as workaround of
this issue.  This patch 01 was leveraged from Hanjun's patch. [1]
Patch 02 fixes the issue on x86 by implementing the interfaces.

[1] https://patchwork.kernel.org/patch/10134581/

---
Toshi Kani (2):
 1/2 mm/vmalloc: Add interfaces to free unused page table
 2/2 x86/mm: implement free pmd/pte page interfaces

---
 arch/arm64/mm/mmu.c           | 10 ++++++++++
 arch/x86/mm/pgtable.c         | 44 +++++++++++++++++++++++++++++++++++++++++++
 include/asm-generic/pgtable.h | 10 ++++++++++
 lib/ioremap.c                 |  6 ++++--
 4 files changed, 68 insertions(+), 2 deletions(-)
