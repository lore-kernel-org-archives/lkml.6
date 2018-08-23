Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE85C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9791A208F7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9791A208F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbeHWUPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 16:15:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:1808 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbeHWUPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 16:15:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2018 09:45:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,278,1531810800"; 
   d="scan'208";a="227129252"
Received: from chang-linux-2.sc.intel.com ([10.3.52.139])
  by orsmga004.jf.intel.com with ESMTP; 23 Aug 2018 09:45:14 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH V5 0/8] x86: infrastructure to enable FSGSBASE
Date:   Thu, 23 Aug 2018 09:44:30 -0700
Message-Id: <1535042678-31366-1-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending the patchset that was posted before [6].

Given feedbacks from [1], it was suggested to separate two parts
and to (re-)submit this patchset first.

To facilitate FSGSBASE, Andy's FS/GS base read fix is first
ordered, then some helper functions and refactoring work
are included. Cleanup for the vDSO initialization is
for preparing per-CPU base finder that will be used in the
paranoid entry, when FSGSBASE enabled.

Changes from V4 [5]:
* Change patch ordering; putting the fix first before introducing
the helper functions
* Cleanup further for vDSO CPU initialization codes

Changes from V3 [4]:
* Unify CPU number initialization

Changes from V2 [3]:
* Bisect the CPU number initialization patch
* Drop patches for introducing i386 CPU_NUMBER and switching
write_rdtscp_aux() to use wrmsr_safe()

Changes from V1 [2]:
* Rename the x86-64 CPU_NUMBER segment from PER_CPU
* Add i386 CPU_NUMBER equivalent to x86-64 at GDT entry 23
* Add additional helper function to store CPU number
* Switch write_rdtscp_aux() to use wrmsr_safe()

[1] FSGSBASE patch set V2: 
    https://lore.kernel.org/patchwork/cover/912063/
[2] infrastructure for FSGSBASE 
    V1: https://lore.kernel.org/patchwork/cover/913139/
[3] V2: https://lore.kernel.org/patchwork/cover/913644/
[4] V3: https://lore.kernel.org/patchwork/cover/949775/
[5] V4: https://lore.kernel.org/patchwork/cover/951712/
[6] V5: https://lore.kernel.org/patchwork/cover/956526/

Andy Lutomirski (1):
  x86/arch_prctl/64: Make ptrace read FS/GS base accurately

Chang S. Bae (7):
  x86/fsgsbase/64: Introduce FS/GS base helper functions
  x86/fsgsbase/64: Make ptrace use FS/GS base helpers
  x86/fsgsbase/64: Use FS/GS base helpers in core dump
  x86/fsgsbase/64: Factor out load FS/GS segments from __switch_to
  x86/segments/64: Rename PER_CPU segment to CPU_NUMBER
  x86/vdso: Introduce helper functions for CPU and node number
  x86/vdso: Move out the CPU initialization

 arch/x86/entry/vdso/vgetcpu.c   |   9 +-
 arch/x86/entry/vdso/vma.c       |  38 +--------
 arch/x86/include/asm/elf.h      |   6 +-
 arch/x86/include/asm/fsgsbase.h |  47 +++++++++++
 arch/x86/include/asm/segment.h  |  46 +++++++++-
 arch/x86/include/asm/vgtod.h    |  26 ------
 arch/x86/kernel/cpu/common.c    |  24 ++++++
 arch/x86/kernel/process_64.c    | 183 +++++++++++++++++++++++++++++++---------
 arch/x86/kernel/ptrace.c        |  28 ++----
 9 files changed, 270 insertions(+), 137 deletions(-)
 create mode 100644 arch/x86/include/asm/fsgsbase.h

-- 
2.7.4

