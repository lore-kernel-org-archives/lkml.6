Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6074B60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753487AbeFFQXd (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 12:23:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:61007 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752952AbeFFQXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 12:23:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,483,1520924400";
   d="scan'208";a="62323457"
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/8] x86: infrastructure to enable FSGSBASE
Date: Wed,  6 Jun 2018 09:23:11 -0700
Message-Id: <1528302199-29619-1-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given feedbacks from [1], it was asked to make first a few
patches ready as soon as possible. To make FSGSBASE facilitated,
some helper functions and refactoring work are incorporated.
Besides that, it includes Andy's fix for accurate FS/GS base read
and cleanup for the vDSO initialization.

Changes from V1:
* Rename the x86-64 CPU_NUMBER segment from PER_CPU
* Add i386 CPU_NUMBER equivalent to x86-64 at GDT entry 23
* Add additional helper function to store CPU number

[1] FSGSBASE patch set V2: https://lkml.org/lkml/2018/5/31/686
[2] infrastructure to enable FSGSBASE V1: https://lkml.org/lkml/2018/6/4/887

Andy Lutomirski (1):
  x86/fsgsbase/64: Make ptrace read FS/GS base accurately

Chang S. Bae (7):
  x86/fsgsbase/64: Introduce FS/GS base helper functions
  x86/fsgsbase/64: Use FS/GS base helpers in core dump
  x86/fsgsbase/64: Factor out load FS/GS segments from __switch_to
  x86/msr: write_rdtscp_aux() to use wrmsr_safe()
  x86/segments/64: Rename PER_CPU segment to CPU_NUMBER
  x86/segments/32: Introduce CPU_NUMBER segment
  x86/vdso: Move out the CPU number store

 arch/x86/entry/vdso/vgetcpu.c   |   4 +-
 arch/x86/entry/vdso/vma.c       |  38 +--------
 arch/x86/include/asm/elf.h      |   6 +-
 arch/x86/include/asm/fsgsbase.h |  47 +++++++++++
 arch/x86/include/asm/msr.h      |   2 +-
 arch/x86/include/asm/segment.h  |  60 ++++++++++---
 arch/x86/include/asm/vgtod.h    |   4 +-
 arch/x86/kernel/cpu/common.c    |   5 ++
 arch/x86/kernel/process_64.c    | 181 +++++++++++++++++++++++++++++++---------
 arch/x86/kernel/ptrace.c        |  28 ++-----
 arch/x86/kernel/setup_percpu.c  |  25 ++++++
 11 files changed, 284 insertions(+), 116 deletions(-)
 create mode 100644 arch/x86/include/asm/fsgsbase.h

-- 
2.7.4
