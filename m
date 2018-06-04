Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751227AbeFDTYr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 15:24:47 -0400
Received: from mga05.intel.com ([192.55.52.43]:40503 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750879AbeFDTYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 15:24:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,476,1520924400";
   d="scan'208";a="64240672"
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: Andy Lutomirski <luto@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/6] x86: infrastructure to enable FSGSBASE
Date: Mon,  4 Jun 2018 12:24:23 -0700
Message-Id: <1528140269-26205-1-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given feedbacks from [1], it was asked to make first a few
patches ready as soon as possible. To make FSGSBASE facilitated,
some helper functions and refactoring work are incorporated.
Besides that, it includes Andy's fix for accurate FS/GS base read
and cleanup for the vDSO initialization.

[1] FSGSBASE patch set V2: https://lkml.org/lkml/2018/5/31/686

Andy Lutomirski (1):
  x86/fsgsbase/64: Make ptrace read FS/GS base accurately

Chang S. Bae (5):
  x86/fsgsbase/64: Introduce FS/GS base helper functions
  x86/fsgsbase/64: Use FS/GS base helpers in core dump
  x86/fsgsbase/64: Factor out load FS/GS segments from __switch_to
  x86/msr: write_rdtscp_aux() to use wrmsr_safe()
  x86/vdso: Move out the CPU number store

 arch/x86/entry/vdso/vgetcpu.c   |   4 +-
 arch/x86/entry/vdso/vma.c       |  38 +--------
 arch/x86/include/asm/elf.h      |   6 +-
 arch/x86/include/asm/fsgsbase.h |  47 +++++++++++
 arch/x86/include/asm/msr.h      |   2 +-
 arch/x86/include/asm/segment.h  |  29 ++++++-
 arch/x86/include/asm/vgtod.h    |   2 -
 arch/x86/kernel/cpu/common.c    |   5 ++
 arch/x86/kernel/process_64.c    | 181 +++++++++++++++++++++++++++++++---------
 arch/x86/kernel/ptrace.c        |  28 ++-----
 arch/x86/kernel/setup_percpu.c  |  17 +++-
 11 files changed, 250 insertions(+), 109 deletions(-)
 create mode 100644 arch/x86/include/asm/fsgsbase.h

-- 
2.7.4
