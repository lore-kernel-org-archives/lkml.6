Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA1DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BAE12086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BAE12086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731684AbeKTIUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:20:34 -0500
Received: from mga09.intel.com ([134.134.136.24]:32114 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731175AbeKTIUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:20:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2018 13:54:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,254,1539673200"; 
   d="scan'208";a="92423875"
Received: from yyu32-desk1.sc.intel.com ([143.183.136.147])
  by orsmga006.jf.intel.com with ESMTP; 19 Nov 2018 13:54:51 -0800
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
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [RFC PATCH v6 00/11] Control-flow Enforcement: Branch Tracking, PTRACE
Date:   Mon, 19 Nov 2018 13:49:23 -0800
Message-Id: <20181119214934.6174-1-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous version of CET Branch Tracking/PTRACE patches is at the following
link:

  https://lkml.org/lkml/2018/10/11/662

Summary of changes from v5:

  Remove the legacy code bitmap allocation from kernel.  Now GLIBC
  allocates the bitmap and passes it to the kernel.

  Some small fixes.

H.J. Lu (3):
  x86: Insert endbr32/endbr64 to vDSO
  x86/vsyscall/32: Add ENDBR32 to vsyscall entry point
  x86/vsyscall/64: Add ENDBR64 to vsyscall entry points

Yu-cheng Yu (8):
  x86/cet/ibt: Add Kconfig option for user-mode Indirect Branch Tracking
  x86/cet/ibt: User-mode indirect branch tracking support
  x86/cet/ibt: Add IBT legacy code bitmap setup function
  mm/mmap: Add IBT bitmap size to address space limit check
  x86/cet/ibt: ELF header parsing for IBT
  x86/cet/ibt: Add arch_prctl functions for IBT
  x86/cet/ibt: Add ENDBR to op-code-map
  x86/cet: Add PTRACE interface for CET

 arch/x86/Kconfig                              | 16 ++++++
 arch/x86/Makefile                             |  7 +++
 arch/x86/entry/vdso/.gitignore                |  4 ++
 arch/x86/entry/vdso/Makefile                  | 12 ++++-
 arch/x86/entry/vdso/vdso-layout.lds.S         |  1 +
 arch/x86/entry/vdso/vdso32/system_call.S      |  3 ++
 arch/x86/entry/vsyscall/vsyscall_emu_64.S     |  9 ++++
 arch/x86/include/asm/cet.h                    |  8 +++
 arch/x86/include/asm/disabled-features.h      |  8 ++-
 arch/x86/include/asm/fpu/regset.h             |  7 +--
 arch/x86/include/asm/mmu_context.h            | 10 ++++
 arch/x86/include/uapi/asm/elf_property.h      |  1 +
 arch/x86/include/uapi/asm/prctl.h             |  2 +
 arch/x86/kernel/cet.c                         | 54 +++++++++++++++++++
 arch/x86/kernel/cet_prctl.c                   | 21 ++++++++
 arch/x86/kernel/cpu/common.c                  | 17 ++++++
 arch/x86/kernel/elf.c                         |  5 ++
 arch/x86/kernel/fpu/regset.c                  | 41 ++++++++++++++
 arch/x86/kernel/process.c                     |  1 +
 arch/x86/kernel/ptrace.c                      | 16 ++++++
 arch/x86/lib/x86-opcode-map.txt               | 13 ++++-
 include/uapi/linux/elf.h                      |  1 +
 mm/mmap.c                                     | 19 ++++++-
 .../arch/x86/include/asm/disabled-features.h  |  8 ++-
 tools/objtool/arch/x86/lib/x86-opcode-map.txt | 13 ++++-
 25 files changed, 286 insertions(+), 11 deletions(-)

-- 
2.17.1

