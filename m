Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /JPAEnJSGVsXFwAAmS7hNA
	; Thu, 07 Jun 2018 15:43:45 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 88C416089E; Thu,  7 Jun 2018 15:43:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1CE1D6074D;
	Thu,  7 Jun 2018 15:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1CE1D6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934796AbeFGPnm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:43:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:36344 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934259AbeFGOl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:41:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 07:41:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,486,1520924400";
   d="scan'208";a="62632615"
Received: from 2b52.sc.intel.com ([143.183.136.51])
  by orsmga001.jf.intel.com with ESMTP; 07 Jun 2018 07:41:28 -0700
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
Subject: [PATCH 00/10] Control Flow Enforcement - Part (3)
Date: Thu,  7 Jun 2018 07:37:57 -0700
Message-Id: <20180607143807.3611-1-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces CET - Shadow stack

At the high level, shadow stack is:

	Allocated from a task's address space with vm_flags VM_SHSTK;
	Its PTEs must be read-only and dirty;
	Fixed sized, but the default size can be changed by sys admin.

For a forked child, the shadow stack is duplicated when the next
shadow stack access takes place.

For a pthread child, a new shadow stack is allocated.

The signal handler uses the same shadow stack as the main program.

Yu-cheng Yu (10):
  x86/cet: User-mode shadow stack support
  x86/cet: Introduce WRUSS instruction
  x86/cet: Signal handling for shadow stack
  x86/cet: Handle thread shadow stack
  x86/cet: ELF header parsing of Control Flow Enforcement
  x86/cet: Add arch_prctl functions for shadow stack
  mm: Prevent mprotect from changing shadow stack
  mm: Prevent mremap of shadow stack
  mm: Prevent madvise from changing shadow stack
  mm: Prevent munmap and remap_file_pages of shadow stack

 arch/x86/Kconfig                              |   4 +
 arch/x86/ia32/ia32_signal.c                   |   5 +
 arch/x86/include/asm/cet.h                    |  48 ++++++
 arch/x86/include/asm/disabled-features.h      |   8 +-
 arch/x86/include/asm/elf.h                    |   5 +
 arch/x86/include/asm/mmu_context.h            |   3 +
 arch/x86/include/asm/msr-index.h              |  14 ++
 arch/x86/include/asm/processor.h              |   5 +
 arch/x86/include/asm/special_insns.h          |  44 +++++
 arch/x86/include/uapi/asm/elf_property.h      |  16 ++
 arch/x86/include/uapi/asm/prctl.h             |  15 ++
 arch/x86/include/uapi/asm/sigcontext.h        |   4 +
 arch/x86/kernel/Makefile                      |   4 +
 arch/x86/kernel/cet.c                         | 224 ++++++++++++++++++++++++
 arch/x86/kernel/cet_prctl.c                   | 203 ++++++++++++++++++++++
 arch/x86/kernel/cpu/common.c                  |  24 +++
 arch/x86/kernel/elf.c                         | 236 ++++++++++++++++++++++++++
 arch/x86/kernel/process.c                     |  10 ++
 arch/x86/kernel/process_64.c                  |   7 +
 arch/x86/kernel/signal.c                      |  11 ++
 arch/x86/lib/x86-opcode-map.txt               |   2 +-
 arch/x86/mm/fault.c                           |  13 +-
 fs/binfmt_elf.c                               |  16 ++
 fs/proc/task_mmu.c                            |   3 +
 include/uapi/linux/elf.h                      |   1 +
 mm/madvise.c                                  |   9 +
 mm/mmap.c                                     |  13 ++
 mm/mprotect.c                                 |   9 +
 mm/mremap.c                                   |   5 +-
 tools/objtool/arch/x86/lib/x86-opcode-map.txt |   2 +-
 30 files changed, 958 insertions(+), 5 deletions(-)
 create mode 100644 arch/x86/include/asm/cet.h
 create mode 100644 arch/x86/include/uapi/asm/elf_property.h
 create mode 100644 arch/x86/kernel/cet.c
 create mode 100644 arch/x86/kernel/cet_prctl.c
 create mode 100644 arch/x86/kernel/elf.c

-- 
2.15.1
