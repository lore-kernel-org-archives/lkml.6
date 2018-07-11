Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A7DC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E2F208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="li3HUyug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E2F208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733260AbeGKLht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:37:49 -0400
Received: from 8bytes.org ([81.169.241.247]:37164 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732770AbeGKLd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:33:56 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 0A290521; Wed, 11 Jul 2018 13:29:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1531308599; bh=KFpFB50nHXW/DVuDCx/bocNgmiMy4GT830lwxgNNjCk=;
        h=From:To:Cc:Subject:Date:From;
        b=li3HUyugrvKmahOAYSPtd9LfymHcvFe0KJIPADxfciNxaerQYmatdy1NHTFLYbUX1
         vpcdk+fYPQHPSO+TSdZcD/wJXZYQaO+ozv02BKzskBITrkGpXzk/lnY1uq6VjOCiCY
         6R48f/K9eyUipe1HzlRlkmtDZnb1VteFHueF6K5MzLP8x9QQzHGYi+ndxDwrm9WoDL
         O3qyr4SctfEpD/2m19HrKUzo72HQof1/80T205R1P/OHwCrSP+1vlvUM4RTOePSGWa
         i2CPl/QsfteS2VYqk5VFEDuDQoi5s+YgvGlg95cqZ5xkSVw9J2vKZj8JeKmaYNDgx3
         KorniF++854tg==
From:   Joerg Roedel <joro@8bytes.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
        daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        jroedel@suse.de, joro@8bytes.org
Subject: [PATCH 00/39 v7] PTI support for x86-32
Date:   Wed, 11 Jul 2018 13:29:07 +0200
Message-Id: <1531308586-29340-1-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here is version 7 of my patches to enable PTI on x86-32.
Changes to the previous version are:

	* Rebased to v4.18-rc4

	* Introduced pti_finalize() which is called after
	  mark_readonly() and used to update the kernel
	  mappings in the user page-table after RO/NX
	  protections are in place.

The patches need the vmalloc/ioremap fixes in tip/x86/mm to
work correctly, because this enablement makes the issues
fixed there more likely to happen.

I did the load-testing again with 'perf top', the ldt_gdt
self-test and a kernel-compile running in a loop again. The
patches posted here were tested for 16 hours without any
regression showing up. An earlier version of these patches
based on v4.18-rc1 survived this test for over a week before
I canceled the test. The test ran with enabled CR3 debugging
added in the last patch of this series.

A git-branch with these patches and the fixes from
tip/x86/mm merged can be found at:

	git://git.kernel.org/pub/scm/linux/kernel/git/joro/linux.git pti-x32-v7

The previous version of these patches can be found at:

	* For v6:
	  Post : https://lore.kernel.org/lkml/1524498460-25530-1-git-send-email-joro@8bytes.org/
	  Git  : git://git.kernel.org/pub/scm/linux/kernel/git/joro/linux.git pti-x32-v6

	* For v5:
	  Post : https://marc.info/?l=linux-kernel&m=152389297705480&w=2
	  Git  : git://git.kernel.org/pub/scm/linux/kernel/git/joro/linux.git pti-x32-v5

	* For v4:
	  Post : https://marc.info/?l=linux-kernel&m=152122860630236&w=2
	  Git  : git://git.kernel.org/pub/scm/linux/kernel/git/joro/linux.git pti-x32-v4

	* For v3:
	  Post : https://marc.info/?l=linux-kernel&m=152024559419876&w=2
	  Git  : git://git.kernel.org/pub/scm/linux/kernel/git/joro/linux.git pti-x32-v3

	* For v2:
	  Post : https://marc.info/?l=linux-kernel&m=151816914932088&w=2
	  Git  : git://git.kernel.org/pub/scm/linux/kernel/git/joro/linux.git pti-x32-v2

Please review.

Thanks,

	Joerg

Joerg Roedel (39):
  x86/asm-offsets: Move TSS_sp0 and TSS_sp1 to asm-offsets.c
  x86/entry/32: Rename TSS_sysenter_sp0 to TSS_entry_stack
  x86/entry/32: Load task stack from x86_tss.sp1 in SYSENTER handler
  x86/entry/32: Put ESPFIX code into a macro
  x86/entry/32: Unshare NMI return path
  x86/entry/32: Split off return-to-kernel path
  x86/entry/32: Enter the kernel via trampoline stack
  x86/entry/32: Leave the kernel via trampoline stack
  x86/entry/32: Introduce SAVE_ALL_NMI and RESTORE_ALL_NMI
  x86/entry/32: Handle Entry from Kernel-Mode on Entry-Stack
  x86/entry/32: Simplify debug entry point
  x86/32: Use tss.sp1 as cpu_current_top_of_stack
  x86/entry/32: Add PTI cr3 switch to non-NMI entry/exit points
  x86/entry/32: Add PTI cr3 switches to NMI handler code
  x86/pgtable: Rename pti_set_user_pgd to pti_set_user_pgtbl
  x86/pgtable/pae: Unshare kernel PMDs when PTI is enabled
  x86/pgtable/32: Allocate 8k page-tables when PTI is enabled
  x86/pgtable: Move pgdp kernel/user conversion functions to pgtable.h
  x86/pgtable: Move pti_set_user_pgtbl() to pgtable.h
  x86/pgtable: Move two more functions from pgtable_64.h to pgtable.h
  x86/mm/pae: Populate valid user PGD entries
  x86/mm/pae: Populate the user page-table with user pgd's
  x86/mm/legacy: Populate the user page-table with user pgd's
  x86/mm/pti: Add an overflow check to pti_clone_pmds()
  x86/mm/pti: Define X86_CR3_PTI_PCID_USER_BIT on x86_32
  x86/mm/pti: Clone CPU_ENTRY_AREA on PMD level on x86_32
  x86/mm/pti: Make pti_clone_kernel_text() compile on 32 bit
  x86/mm/pti: Keep permissions when cloning kernel text in
    pti_clone_kernel_text()
  x86/mm/pti: Introduce pti_finalize()
  x86/mm/pti: Clone entry-text again in pti_finalize()
  x86/mm/dump_pagetables: Define INIT_PGD
  x86/pgtable/pae: Use separate kernel PMDs for user page-table
  x86/ldt: Reserve address-space range on 32 bit for the LDT
  x86/ldt: Define LDT_END_ADDR
  x86/ldt: Split out sanity check in map_ldt_struct()
  x86/ldt: Enable LDT user-mapping for PAE
  x86/pti: Allow CONFIG_PAGE_TABLE_ISOLATION for x86_32
  x86/mm/pti: Add Warning when booting on a PCID capable CPU
  x86/entry/32: Add debug code to check entry/exit cr3

 arch/x86/Kconfig.debug                      |  12 +
 arch/x86/entry/entry_32.S                   | 640 +++++++++++++++++++++++-----
 arch/x86/include/asm/mmu_context.h          |   5 -
 arch/x86/include/asm/pgtable-2level.h       |   9 +
 arch/x86/include/asm/pgtable-2level_types.h |   3 +
 arch/x86/include/asm/pgtable-3level.h       |   7 +
 arch/x86/include/asm/pgtable-3level_types.h |   6 +-
 arch/x86/include/asm/pgtable.h              |  87 ++++
 arch/x86/include/asm/pgtable_32.h           |   2 -
 arch/x86/include/asm/pgtable_32_types.h     |   9 +-
 arch/x86/include/asm/pgtable_64.h           |  89 +---
 arch/x86/include/asm/pgtable_64_types.h     |   3 +
 arch/x86/include/asm/pgtable_types.h        |  28 +-
 arch/x86/include/asm/processor-flags.h      |   8 +-
 arch/x86/include/asm/processor.h            |   4 -
 arch/x86/include/asm/pti.h                  |   3 +-
 arch/x86/include/asm/sections.h             |   1 +
 arch/x86/include/asm/switch_to.h            |   6 +-
 arch/x86/include/asm/thread_info.h          |   2 -
 arch/x86/kernel/asm-offsets.c               |   5 +
 arch/x86/kernel/asm-offsets_32.c            |   2 +-
 arch/x86/kernel/asm-offsets_64.c            |   2 -
 arch/x86/kernel/cpu/common.c                |   9 +-
 arch/x86/kernel/head_32.S                   |  20 +-
 arch/x86/kernel/ldt.c                       | 137 ++++--
 arch/x86/kernel/process.c                   |   2 -
 arch/x86/kernel/process_32.c                |   4 +-
 arch/x86/kernel/vmlinux.lds.S               |  17 +-
 arch/x86/mm/dump_pagetables.c               |  21 +-
 arch/x86/mm/init_64.c                       |   6 -
 arch/x86/mm/pgtable.c                       | 105 ++++-
 arch/x86/mm/pti.c                           |  67 ++-
 include/linux/pti.h                         |   1 +
 init/main.c                                 |   7 +
 security/Kconfig                            |   2 +-
 35 files changed, 1008 insertions(+), 323 deletions(-)

-- 
2.7.4

