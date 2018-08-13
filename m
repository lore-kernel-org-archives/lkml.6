Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE60C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C33F217C5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C33F217C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbeHMKSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 06:18:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:41848 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726704AbeHMKSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 06:18:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 239D3AE41;
        Mon, 13 Aug 2018 07:37:44 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org
Cc:     akataria@vmware.com, rusty@rustcorp.com.au,
        boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH v2 00/11] x86/paravirt: several cleanups
Date:   Mon, 13 Aug 2018 09:37:28 +0200
Message-Id: <20180813073739.26108-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes some no longer needed stuff from paravirt
infrastructure and puts large quantities of paravirt ops under a new
config option PARAVIRT_XXL which is selected by XEN_PV only.

A pvops kernel without XEN_PV being configured is about 2.5% smaller
with this series applied.

tip commit 5800dc5c19f34e6e03b5adab1282535cb102fafd ("x86/paravirt:
Fix spectre-v2 mitigations for paravirt guests") is a prerequisite
for this series.

The last 4 patches of this series require my Xen cleanup series
https://lore.kernel.org/lkml/20180717120113.12756-1-jgross@suse.com/
which hides more Xen PV-only code behind CONFIG_XEN_PV.

Changes in V2:
- patch 4: shorten pv_ops sub-structure names (Jan Beulich)
- patch 11: new patch

Juergen Gross (11):
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
  x86/paravirt: move the Xen-only pv_irq_ops under the PARAVIRT_XXL
    umbrella
  x86/paravirt: move the Xen-only pv_mmu_ops under the PARAVIRT_XXL
    umbrella
  x86/paravirt: remove unneeded mmu related paravirt ops bits

 arch/x86/Kconfig                            |   3 +
 arch/x86/hyperv/mmu.c                       |   4 +-
 arch/x86/include/asm/debugreg.h             |   2 +-
 arch/x86/include/asm/desc.h                 |   4 +-
 arch/x86/include/asm/fixmap.h               |   2 +-
 arch/x86/include/asm/irqflags.h             |  56 ++--
 arch/x86/include/asm/mmu_context.h          |   4 +-
 arch/x86/include/asm/msr.h                  |   4 +-
 arch/x86/include/asm/paravirt.h             | 399 +++++++++++++---------------
 arch/x86/include/asm/paravirt_types.h       |  77 +++---
 arch/x86/include/asm/pgalloc.h              |   2 +-
 arch/x86/include/asm/pgtable-3level_types.h |   2 +-
 arch/x86/include/asm/pgtable.h              |   7 +-
 arch/x86/include/asm/processor.h            |   4 +-
 arch/x86/include/asm/ptrace.h               |   3 +-
 arch/x86/include/asm/segment.h              |   2 +-
 arch/x86/include/asm/special_insns.h        |   4 +-
 arch/x86/kernel/alternative.c               |   2 +-
 arch/x86/kernel/asm-offsets.c               |  13 +-
 arch/x86/kernel/asm-offsets_64.c            |   9 +-
 arch/x86/kernel/cpu/common.c                |   4 +-
 arch/x86/kernel/cpu/vmware.c                |   4 +-
 arch/x86/kernel/head_64.S                   |   2 +-
 arch/x86/kernel/kvm.c                       |  17 +-
 arch/x86/kernel/kvmclock.c                  |   4 +-
 arch/x86/kernel/paravirt-spinlocks.c        |  15 +-
 arch/x86/kernel/paravirt.c                  | 292 ++++++++++----------
 arch/x86/kernel/paravirt_patch_32.c         |  57 ++--
 arch/x86/kernel/paravirt_patch_64.c         |  65 ++---
 arch/x86/kernel/tsc.c                       |   2 +-
 arch/x86/kernel/vsmp_64.c                   |  24 +-
 arch/x86/xen/Kconfig                        |   1 +
 arch/x86/xen/enlighten_pv.c                 |  31 ++-
 arch/x86/xen/irq.c                          |   2 +-
 arch/x86/xen/mmu_hvm.c                      |   2 +-
 arch/x86/xen/mmu_pv.c                       |  28 +-
 arch/x86/xen/spinlock.c                     |  11 +-
 arch/x86/xen/time.c                         |   4 +-
 drivers/xen/time.c                          |   2 +-
 39 files changed, 575 insertions(+), 595 deletions(-)

-- 
2.13.7

