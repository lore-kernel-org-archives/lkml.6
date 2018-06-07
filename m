Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 61pOIwlmGVuNDAAAmS7hNA
	; Thu, 07 Jun 2018 17:06:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 71F57606DD; Thu,  7 Jun 2018 17:06:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E51F260115;
	Thu,  7 Jun 2018 17:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E51F260115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934577AbeFGRGY (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:06:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:32205 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932789AbeFGRGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:06:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 10:06:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,487,1520924400";
   d="scan'208";a="206183208"
Received: from chang-linux-2.sc.intel.com ([10.3.52.139])
  by orsmga004.jf.intel.com with ESMTP; 07 Jun 2018 10:06:22 -0700
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
Subject: [PATCH v3 0/7] x86: infrastructure to enable FSGSBASE
Date: Thu,  7 Jun 2018 10:06:01 -0700
Message-Id: <1528391168-22224-1-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given feedbacks from [1], it was asked to make first a few
patches ready as soon as possible. To make FSGSBASE facilitated,
some helper functions and refactoring work are incorporated.
Besides that, it includes Andy's fix for accurate FS/GS base read
and cleanup for the vDSO initialization.

Changes from V2 [3]:
* Bisect the CPU number initialization patch
* Drop patches for introducing i386 CPU_NUMBER and switching
write_rdtscp_aux() to use wrmsr_safe()

Changes from V1 [2]:
* Rename the x86-64 CPU_NUMBER segment from PER_CPU
* Add i386 CPU_NUMBER equivalent to x86-64 at GDT entry 23
* Add additional helper function to store CPU number
* Switch write_rdtscp_aux() to use wrmsr_safe()

[1] FSGSBASE patch set V2: https://lkml.org/lkml/2018/5/31/686
[2] infrastructure for FSGSBASE V1: https://lkml.org/lkml/2018/6/4/887
[3] infrastructure for FSGSBASE V2: https://lkml.org/lkml/2018/6/6/582

Andy Lutomirski (1):
  x86/fsgsbase/64: Make ptrace read FS/GS base accurately

Chang S. Bae (6):
  x86/fsgsbase/64: Introduce FS/GS base helper functions
  x86/fsgsbase/64: Use FS/GS base helpers in core dump
  x86/fsgsbase/64: Factor out load FS/GS segments from __switch_to
  x86/segments/64: Rename PER_CPU segment to CPU_NUMBER
  x86/vdso: Introduce CPU number helper functions
  x86/vdso: Move out the CPU number store

 arch/x86/entry/vdso/vgetcpu.c   |   4 +-
 arch/x86/entry/vdso/vma.c       |  38 +--------
 arch/x86/include/asm/elf.h      |   6 +-
 arch/x86/include/asm/fsgsbase.h |  47 +++++++++++
 arch/x86/include/asm/segment.h  |  33 +++++++-
 arch/x86/include/asm/vgtod.h    |   4 +-
 arch/x86/kernel/cpu/common.c    |  13 +++
 arch/x86/kernel/process_64.c    | 181 +++++++++++++++++++++++++++++++---------
 arch/x86/kernel/ptrace.c        |  28 ++-----
 arch/x86/kernel/setup_percpu.c  |  25 ++++++
 10 files changed, 273 insertions(+), 106 deletions(-)
 create mode 100644 arch/x86/include/asm/fsgsbase.h

-- 
2.7.4
