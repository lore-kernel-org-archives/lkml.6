Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B897CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D38D20834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D38D20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbeH3SrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:47:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:18694 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729149AbeH3SrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:47:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 07:44:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,307,1531810800"; 
   d="scan'208";a="228910330"
Received: from 2b52.sc.intel.com ([143.183.136.52])
  by orsmga004.jf.intel.com with ESMTP; 30 Aug 2018 07:44:29 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromiun.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [RFC PATCH v3 0/8] Control Flow Enforcement: Branch Tracking, PTRACE
Date:   Thu, 30 Aug 2018 07:40:01 -0700
Message-Id: <20180830144009.3314-1-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set includes CET Indirect Branch Tracking patches and a PTRACE patch.

Summary of changes from v2:

  Allocate IBT bitmap at the start of a task.

H.J. Lu (1):
  x86: Insert endbr32/endbr64 to vDSO

Yu-cheng Yu (7):
  x86/cet/ibt: Add Kconfig option for user-mode Indirect Branch Tracking
  x86/cet/ibt: User-mode indirect branch tracking support
  x86/cet/ibt: ELF header parsing for IBT
  x86/cet/ibt: Add arch_prctl functions for IBT
  x86/cet/ibt: Add ENDBR to op-code-map
  mm/mmap: Add IBT bitmap size to address space limit check
  x86/cet: Add PTRACE interface for CET

 arch/x86/Kconfig                              | 12 +++
 arch/x86/Makefile                             |  7 ++
 arch/x86/entry/vdso/.gitignore                |  4 +
 arch/x86/entry/vdso/Makefile                  | 12 ++-
 arch/x86/entry/vdso/vdso-layout.lds.S         |  1 +
 arch/x86/include/asm/cet.h                    |  8 ++
 arch/x86/include/asm/disabled-features.h      |  8 +-
 arch/x86/include/asm/fpu/regset.h             |  7 +-
 arch/x86/include/uapi/asm/elf_property.h      |  1 +
 arch/x86/include/uapi/asm/prctl.h             |  1 +
 arch/x86/include/uapi/asm/resource.h          |  5 ++
 arch/x86/kernel/cet.c                         | 74 +++++++++++++++++++
 arch/x86/kernel/cet_prctl.c                   | 38 +++++++++-
 arch/x86/kernel/cpu/common.c                  | 20 ++++-
 arch/x86/kernel/elf.c                         |  8 +-
 arch/x86/kernel/fpu/regset.c                  | 41 ++++++++++
 arch/x86/kernel/process.c                     |  2 +
 arch/x86/kernel/ptrace.c                      | 16 ++++
 arch/x86/lib/x86-opcode-map.txt               | 13 +++-
 include/uapi/asm-generic/resource.h           |  3 +
 include/uapi/linux/elf.h                      |  1 +
 mm/mmap.c                                     | 12 ++-
 tools/objtool/arch/x86/lib/x86-opcode-map.txt | 13 +++-
 23 files changed, 294 insertions(+), 13 deletions(-)

-- 
2.17.1

