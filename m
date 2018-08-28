Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565B8C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124CA208E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 124CA208E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbeH1LcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 07:32:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:45376 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727315AbeH1LbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 07:31:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 69FE7AF89;
        Tue, 28 Aug 2018 07:40:38 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org
Cc:     akataria@vmware.com, rusty@rustcorp.com.au,
        boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, Juergen Gross <jgross@suse.com>
Subject: [PATCH v3 00/15] x86/paravirt, xen: several cleanups
Date:   Tue, 28 Aug 2018 09:40:11 +0200
Message-Id: <20180828074026.820-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes some no longer needed stuff from paravirt
infrastructure and puts large quantities of paravirt ops under a new
config option PARAVIRT_XXL which is selected by XEN_PV only.

Some Xen related cleanups:
- move some pv-only code from CONFIG_XEN to CONFIG_XEN_PV
- use CONFIG_XEN_PVHVM in Makefile instead of #ifdef around a complete source
- add SPDX identifier where missing

A pvops kernel without XEN_PV being configured is about 2.5% smaller
with this series applied.

Changes in V3:
- merged with the Xen cleanup series which is a prerequisite for the
  pv cleanup
- fix build errors on ARM
- let VSMP select PARAVIRT_XXL, put all irq_ops under PARAVIRT_XXL

Changes in V2:
- patch 4: shorten pv_ops sub-structure names (Jan Beulich)
- patch 11: new patch

Juergen Gross (15):
  xen: move pv irq related functions under CONFIG_XEN_PV umbrella
  xen: move pv specific parts of arch/x86/xen/mmu.c to mmu_pv.c
  xen: link platform-pci-unplug.o only if CONFIG_XEN_PVHVM
  xen: add SPDX identifier in arch/x86/xen files
  x86/paravirt: make paravirt_patch_call() and paravirt_patch_jmp()
    static
  x86/paravirt: remove clobbers parameter from paravirt patch functions
  x86/paravirt: remove clobbers from struct paravirt_patch_site
  x86/paravirt: use a single ops structure
  x86/paravirt: remove unused paravirt bits
  x86/paravirt: introduce new config option PARAVIRT_XXL
  x86/paravirt: move items in pv_info under PARAVIRT_XXL umbrella
  x86/paravirt: move the Xen-only pv_cpu_ops under the PARAVIRT_XXL
    umbrella
  x86/paravirt: move the pv_irq_ops under the PARAVIRT_XXL umbrella
  x86/paravirt: move the Xen-only pv_mmu_ops under the PARAVIRT_XXL
    umbrella
  x86/paravirt: remove unneeded mmu related paravirt ops bits

 arch/arm/include/asm/paravirt.h             |   9 +-
 arch/arm/kernel/paravirt.c                  |   4 +-
 arch/arm/xen/enlighten.c                    |  34 ---
 arch/arm64/include/asm/paravirt.h           |   9 +-
 arch/arm64/kernel/paravirt.c                |   4 +-
 arch/x86/Kconfig                            |   4 +
 arch/x86/boot/compressed/misc.h             |   1 +
 arch/x86/entry/entry_32.S                   |   8 +-
 arch/x86/entry/entry_64.S                   |   8 +-
 arch/x86/hyperv/mmu.c                       |   4 +-
 arch/x86/include/asm/debugreg.h             |   2 +-
 arch/x86/include/asm/desc.h                 |   4 +-
 arch/x86/include/asm/fixmap.h               |   2 +-
 arch/x86/include/asm/irqflags.h             |  16 +-
 arch/x86/include/asm/mmu_context.h          |   4 +-
 arch/x86/include/asm/msr.h                  |   4 +-
 arch/x86/include/asm/paravirt.h             | 415 +++++++++++++---------------
 arch/x86/include/asm/paravirt_types.h       |  82 +++---
 arch/x86/include/asm/pgalloc.h              |   2 +-
 arch/x86/include/asm/pgtable-3level_types.h |   2 +-
 arch/x86/include/asm/pgtable.h              |   7 +-
 arch/x86/include/asm/processor.h            |   4 +-
 arch/x86/include/asm/ptrace.h               |   2 +-
 arch/x86/include/asm/segment.h              |   2 +-
 arch/x86/include/asm/special_insns.h        |   4 +-
 arch/x86/kernel/alternative.c               |   2 +-
 arch/x86/kernel/asm-offsets.c               |  13 +-
 arch/x86/kernel/asm-offsets_64.c            |   9 +-
 arch/x86/kernel/cpu/common.c                |   4 +-
 arch/x86/kernel/cpu/vmware.c                |   4 +-
 arch/x86/kernel/head_64.S                   |   2 +-
 arch/x86/kernel/kvm.c                       |  19 +-
 arch/x86/kernel/kvmclock.c                  |   4 +-
 arch/x86/kernel/paravirt-spinlocks.c        |  15 +-
 arch/x86/kernel/paravirt.c                  | 305 ++++++++++----------
 arch/x86/kernel/paravirt_patch_32.c         |  57 ++--
 arch/x86/kernel/paravirt_patch_64.c         |  65 ++---
 arch/x86/kernel/tsc.c                       |   2 +-
 arch/x86/kernel/vsmp_64.c                   |  26 +-
 arch/x86/mm/mem_encrypt_identity.c          |   1 +
 arch/x86/xen/Kconfig                        |   1 +
 arch/x86/xen/Makefile                       |  41 ++-
 arch/x86/xen/efi.c                          |  14 +-
 arch/x86/xen/enlighten.c                    |   2 +
 arch/x86/xen/enlighten_hvm.c                |   2 +
 arch/x86/xen/enlighten_pv.c                 |  31 ++-
 arch/x86/xen/grant-table.c                  |  25 +-
 arch/x86/xen/irq.c                          |   2 +-
 arch/x86/xen/mmu.c                          | 188 +------------
 arch/x86/xen/mmu_hvm.c                      |   2 +-
 arch/x86/xen/mmu_pv.c                       | 168 ++++++++++-
 arch/x86/xen/p2m.c                          |   2 +
 arch/x86/xen/pci-swiotlb-xen.c              |   2 +
 arch/x86/xen/platform-pci-unplug.c          |  18 +-
 arch/x86/xen/spinlock.c                     |  11 +-
 arch/x86/xen/time.c                         |   4 +-
 arch/x86/xen/vdso.h                         |   2 +
 arch/x86/xen/xen-pvh.S                      |  15 +-
 drivers/xen/time.c                          |   2 +-
 include/xen/events.h                        |   2 +
 include/xen/interface/memory.h              |   6 -
 include/xen/xen-ops.h                       | 133 ++++++---
 62 files changed, 880 insertions(+), 958 deletions(-)

-- 
2.16.4

