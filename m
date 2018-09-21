Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9E1ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A0A2156E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A0A2156E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390858AbeIUU7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:59:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:13767 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390777AbeIUU7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:59:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Sep 2018 08:10:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,285,1534834800"; 
   d="scan'208";a="88187958"
Received: from 2b52.sc.intel.com ([143.183.136.51])
  by fmsmga002.fm.intel.com with ESMTP; 21 Sep 2018 08:10:27 -0700
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
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [RFC PATCH v4 0/9] Control Flow Enforcement: Branch Tracking, PTRACE
Date:   Fri, 21 Sep 2018 08:05:44 -0700
Message-Id: <20180921150553.21016-1-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous version of CET patches can be found in the following
link:

  https://lkml.org/lkml/2018/8/30/582

Summary of changes from v3:

  Move IBT legacy code bitmap allocation back to when the application
  requests it.  Most application do not need the bitmap.  It is only
  used when an application does dlopen() a legacy library.

  In the previous version, we pre-allocated the bitmap for every IBT-
  enabled application to avoid creating a hole in the linear address.
  However, this created a problem when the system has limited memory.

H.J. Lu (1):
  x86: Insert endbr32/endbr64 to vDSO

Yu-cheng Yu (8):
  x86/cet/ibt: Add Kconfig option for user-mode Indirect Branch Tracking
  x86/cet/ibt: User-mode indirect branch tracking support
  x86/cet/ibt: Add IBT legacy code bitmap allocation function
  mm/mmap: Add IBT bitmap size to address space limit check
  x86/cet/ibt: ELF header parsing for IBT
  x86/cet/ibt: Add arch_prctl functions for IBT
  x86/cet/ibt: Add ENDBR to op-code-map
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
 arch/x86/kernel/cet.c                         | 76 +++++++++++++++++++
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
 23 files changed, 296 insertions(+), 13 deletions(-)

-- 
2.17.1

