Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id o1g+LcVDGVtFDAAAmS7hNA
	; Thu, 07 Jun 2018 14:40:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F02206089E; Thu,  7 Jun 2018 14:40:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 67342602FC;
	Thu,  7 Jun 2018 14:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 67342602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934126AbeFGOkD (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:40:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:61088 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934377AbeFGOj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:39:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 07:39:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,486,1520924400";
   d="scan'208";a="54825980"
Received: from 2b52.sc.intel.com ([143.183.136.51])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jun 2018 07:39:57 -0700
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
Subject: [PATCH 0/5] Control Flow Enforcement - Part (1)
Date: Thu,  7 Jun 2018 07:35:39 -0700
Message-Id: <20180607143544.3477-1-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Control flow enforcement technology (CET) is an upcoming Intel
processor family feature that prevents return/jmp-oriented
programming attacks.  It has two components: shadow stack (SHSTK)
and indirect branch tracking (IBT).

The specification is at:

  https://software.intel.com/sites/default/files/managed/4d/2a/
  control-flow-enforcement-technology-preview.pdf

The SHSTK is a secondary stack allocated from system memory.
The CALL instruction stores a secure copy of the return address
on the SHSTK; the RET instruction compares the return address
from the program stack to the SHSTK copy.  Any mismatch
triggers a control protection fault.

When the IBT is enabled, the processor verifies an indirect
CALL/JMP destination is an ENDBR instruction; otherwise, it
raises a control protection fault.  The compiler inserts ENDBRs
at all valid branch targets.

CET can be enabled for both kernel and user mode protection.
The Linux kernel patches being posted are for user-mode
protection.  They are grouped into four series:

  (1) CPUID enumeration, CET XSAVES system states, and
      documentation;
  (2) Kernel config, exception handling, and memory management
      changes;
  (3) SHSTK support;
  (4) IBT support, command-line tool, PTRACE.

Yu-cheng Yu (5):
  x86/cpufeatures: Add CPUIDs for Control-flow Enforcement Technology
    (CET)
  x86/fpu/xstate: Change some names to separate XSAVES system and user
    states
  x86/fpu/xstate: Enable XSAVES system states
  x86/fpu/xstate: Add XSAVES system states for shadow stack
  Documentation/x86: Add CET description

 Documentation/admin-guide/kernel-parameters.txt |   6 +
 Documentation/x86/intel_cet.txt                 | 161 ++++++++++++++++++++++++
 arch/x86/include/asm/cpufeatures.h              |   2 +
 arch/x86/include/asm/fpu/internal.h             |   6 +-
 arch/x86/include/asm/fpu/types.h                |  22 ++++
 arch/x86/include/asm/fpu/xstate.h               |  31 ++---
 arch/x86/include/uapi/asm/processor-flags.h     |   2 +
 arch/x86/kernel/cpu/scattered.c                 |   1 +
 arch/x86/kernel/fpu/core.c                      |  11 +-
 arch/x86/kernel/fpu/init.c                      |  10 --
 arch/x86/kernel/fpu/signal.c                    |   6 +-
 arch/x86/kernel/fpu/xstate.c                    | 152 +++++++++++++---------
 12 files changed, 319 insertions(+), 91 deletions(-)
 create mode 100644 Documentation/x86/intel_cet.txt

-- 
2.15.1
