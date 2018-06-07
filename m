Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id QzcIG3lDGVviCAAAmS7hNA
	; Thu, 07 Jun 2018 14:40:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 602EC6089E; Thu,  7 Jun 2018 14:40:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E93BA602FC;
	Thu,  7 Jun 2018 14:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E93BA602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934510AbeFGOkh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:40:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:36280 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932912AbeFGOkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:40:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 07:40:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,486,1520924400";
   d="scan'208";a="47542281"
Received: from 2b52.sc.intel.com ([143.183.136.51])
  by orsmga008.jf.intel.com with ESMTP; 07 Jun 2018 07:40:31 -0700
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
To: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH 0/9] Control Flow Enforcement - Part (2)
Date: Thu,  7 Jun 2018 07:36:56 -0700
Message-Id: <20180607143705.3531-1-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of changes:

  Shadow stack kernel config option;
  Control protection exception; and
  Shadow stack memory management.

The shadow stack PTE needs to be read-only and dirty.  Changes
are made to:

  Use the read-only and hardware dirty combination exclusively
  for shadow stack;

  Use a PTE spare bit to indicate other PTE dirty conditions;

  Shadow stack page fault handling.

Yu-cheng Yu (9):
  x86/cet: Control protection exception handler
  x86/cet: Add Kconfig option for user-mode shadow stack
  mm: Introduce VM_SHSTK for shadow stack memory
  x86/mm: Change _PAGE_DIRTY to _PAGE_DIRTY_HW
  x86/mm: Introduce _PAGE_DIRTY_SW
  x86/mm: Introduce ptep_set_wrprotect_flush and related functions
  x86/mm: Shadow stack page fault error checking
  x86/cet: Handle shadow stack page fault
  x86/cet: Handle THP/HugeTLB shadow stack page copying

 arch/x86/Kconfig                     |  24 ++++++
 arch/x86/entry/entry_32.S            |   5 ++
 arch/x86/entry/entry_64.S            |   2 +-
 arch/x86/include/asm/pgtable.h       | 149 ++++++++++++++++++++++++++++++-----
 arch/x86/include/asm/pgtable_types.h |  31 +++++---
 arch/x86/include/asm/traps.h         |   5 ++
 arch/x86/kernel/idt.c                |   1 +
 arch/x86/kernel/relocate_kernel_64.S |   2 +-
 arch/x86/kernel/traps.c              |  61 ++++++++++++++
 arch/x86/kvm/vmx.c                   |   2 +-
 arch/x86/mm/fault.c                  |  11 +++
 include/asm-generic/pgtable.h        |  38 +++++++++
 include/linux/mm.h                   |   8 ++
 mm/huge_memory.c                     |  10 ++-
 mm/hugetlb.c                         |   2 +-
 mm/internal.h                        |   8 ++
 mm/memory.c                          |  32 +++++++-
 17 files changed, 353 insertions(+), 38 deletions(-)

-- 
2.15.1
