Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FC7C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F075120652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:15:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F075120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932411AbeFTXP3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 19:15:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:8666 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754299AbeFTXP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 19:15:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 16:15:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,249,1526367600"; 
   d="scan'208";a="66325204"
Received: from chang-linux-2.sc.intel.com ([10.3.52.139])
  by orsmga001.jf.intel.com with ESMTP; 20 Jun 2018 16:15:24 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/7] x86: infrastructure to enable FSGSBASE
Date:   Wed, 20 Jun 2018 16:14:59 -0700
Message-Id: <1529536506-26237-1-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given feedbacks from [1], it was suggested to separate two parts
and to (re-)submit this patchset first.

To facilitate FSGSBASE, helper functions and refactoring work
are incorporated. Also, it includes Andy's fix for accurate
FS/GS base read and cleanup for the vDSO initialization.

Changes from V3 [4]:
* Unify CPU number initialization
* Rebase on 4.18-rc1

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
[3] V2: https://lkml.org/lkml/2018/6/6/582
[4] V3: https://lkml.org/lkml/2018/6/7/975

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
 arch/x86/kernel/cpu/common.c    |  28 +++++++
 arch/x86/kernel/process_64.c    | 181 +++++++++++++++++++++++++++++++---------
 arch/x86/kernel/ptrace.c        |  28 ++-----
 9 files changed, 263 insertions(+), 106 deletions(-)
 create mode 100644 arch/x86/include/asm/fsgsbase.h

-- 
2.7.4

