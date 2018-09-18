Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D4DC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55DCB20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55DCB20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbeISEob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 00:44:31 -0400
Received: from mga14.intel.com ([192.55.52.115]:3122 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbeISEob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 00:44:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 16:09:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,391,1531810800"; 
   d="scan'208";a="87288044"
Received: from chang-linux-2.sc.intel.com ([10.3.52.139])
  by fmsmga002.fm.intel.com with ESMTP; 18 Sep 2018 16:09:39 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 0/8] x86: infrastructure to enable FSGSBASE
Date:   Tue, 18 Sep 2018 16:08:51 -0700
Message-Id: <1537312139-5580-1-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from V5 [5]:
* Unified name-space for the new FS/GS helpers
* Port patch #7 to latest -tip (resolve conflict with
e78e5a91456f: 'x86/vdso: Fix lsl operand order')
* Minor updates on comments and descriptions

Changes from V4 [4]:
* Change patch ordering; putting the fix first before introducing
the helper functions
* Cleanup further for vDSO CPU initialization codes

Changes from V3 [3]:
* Unify CPU number initialization

Changes from V2 [2]:
* Bisect the CPU number initialization patch
* Drop patches for introducing i386 CPU_NUMBER and switching
write_rdtscp_aux() to use wrmsr_safe()

Changes from V1 [1]:
* Rename the x86-64 CPU_NUMBER segment from PER_CPU
* Add i386 CPU_NUMBER equivalent to x86-64 at GDT entry 23
* Add additional helper function to store CPU number
* Switch write_rdtscp_aux() to use wrmsr_safe()

[1] V1: https://lore.kernel.org/patchwork/cover/913139/
[2] V2: https://lore.kernel.org/patchwork/cover/913644/
[3] V3: https://lore.kernel.org/patchwork/cover/949775/
[4] V4: https://lore.kernel.org/patchwork/cover/951712/
[5] V5: https://lore.kernel.org/patchwork/cover/956526/

Andy Lutomirski (1):
  x86/arch_prctl/64: Make ptrace read FS/GS base accurately

Chang S. Bae (7):
  x86/fsgsbase/64: Introduce FS/GS base helper functions
  x86/fsgsbase/64: Make ptrace use correct FS/GS base helpers
  x86/fsgsbase/64: Use FS/GS base helpers in core dump
  x86/fsgsbase/64: Factor out load FS/GS segments from __switch_to()
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

