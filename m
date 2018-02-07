Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754200AbeBGAG3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 19:06:29 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:4164 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754095AbeBGAG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 19:06:28 -0500
X-IronPort-AV: E=Sophos;i="5.46,470,1511827200";
   d="scan'208";a="721472249"
From: David Woodhouse <dwmw@amazon.co.uk>
To: tglx@linutronix.de, torvalds@linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, peterz@infradead.org,
        tim.c.chen@linux.intel.com, dave.hansen@intel.com,
        arjan.van.de.ven@intel.com
Subject: [RFC PATCH 0/4] Retpoline / IBRS_ALL
Date: Wed,  7 Feb 2018 00:03:10 +0000
Message-Id: <1517961794-14972-1-git-send-email-dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using retpoline ensures the kernel is safe because it doesn't contain
any indirect branches, but firmware still can — and we make calls into
firmware at runtime. Where the IBRS microcode support is available, use
that before calling into firmware.

While doing that, I noticed that we were calling C functions without
telling the compiler about the call-clobbered registers. Stop that.

This also contains the always_inline fix for the performance problem 
introduced by retpoline in KVM code, and finally adds IBRS_ALL support 
for future CPUs, where we can disable the retpoline but still want to 
use IBPB on context switch etc. I'll repeat the comment from that commit 
here, for clarity:

This does not actually *set* the IBRS bit in the SPEC_CTRL register,
because Intel's documentation is wrong. Not wrong in the sense of
"does not accurately describe Intel's planned future hardware", but
more in the sense that if Intel make hardware like that, then they
are Doing It Wrong™.

With IBRS_ALL advertised in IA32_ARCH_CAPABILITIES, the IBRS bit in
the MSR should do *nothing*. The safe mode where the CPU honours the
tags in the BTB/RSB should be enabled *unconditionally*.


David Woodhouse (4):
  Revert "x86/speculation: Simplify indirect_branch_prediction_barrier()"
  KVM: x86: Reduce retpoline performance impact in slot_handle_level_range()
  x86/speculation: Use IBRS if available before calling into firmware
  x86/speculation: Support "Enhanced IBRS" on future CPUs

 arch/x86/include/asm/apm.h           |  6 ++++++
 arch/x86/include/asm/cpufeatures.h   |  1 +
 arch/x86/include/asm/efi.h           | 13 +++++++++++--
 arch/x86/include/asm/nospec-branch.h | 34 +++++++++++++++++++++++++++++-----
 arch/x86/include/asm/processor.h     |  3 ---
 arch/x86/kernel/cpu/bugs.c           | 29 ++++++++++++++++++++++-------
 arch/x86/kvm/mmu.c                   | 10 +++++-----
 drivers/watchdog/hpwdt.c             |  3 +++
 8 files changed, 77 insertions(+), 22 deletions(-)

-- 
2.7.4
