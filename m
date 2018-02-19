Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752616AbeBSKvQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 05:51:16 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:12272 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752392AbeBSKvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 05:51:14 -0500
X-IronPort-AV: E=Sophos;i="5.46,534,1511827200";
   d="scan'208";a="708596422"
From: David Woodhouse <dwmw@amazon.co.uk>
To: tglx@linutronix.de, karahmed@amazon.de, x86@kernel.org,
        kvm@vger.kernel.org, torvalds@linux-foundation.org,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org, bp@alien8.de,
        peterz@infradead.org, jmattson@google.com, rkrcmar@redhat.com,
        arjan.van.de.ven@intel.com, dave.hansen@intel.com, mingo@kernel.org
Subject: [PATCH v3 0/4] Speculation control improvements
Date: Mon, 19 Feb 2018 10:50:53 +0000
Message-Id: <1519037457-7643-1-git-send-email-dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On CPUs which advertise IBRS_ALL, enable it and disable the retpoline
as IBRS_ALL will be faster. Guests which still frob IBRS on every kernel
entry/exit will trap and the MSR access will be emulated, but this should
not be any slower than what they *thought* they were doing anyway. If
Paolo genuinely cares about such guests, a later patch can attempt to
optimise this somehow. As long as it doesn't penalise the host and the
other guests while it's at it.

Also use IBRS whenever it's available before calling into firmware at
runtime.

Revert another bikeshedding patch that was broken, and add support for
retpoline builds with clang.

---
v2: Remember to export spectre_v2_enabled
v3: No changes; just rebase to current tip/x86/pti and clarify the state
    of the discussion about SPEC_CTRL trapping for IBRS_ALL.

David Woodhouse (4):
  x86/speculation: Use IBRS if available before calling into firmware
  x86/speculation: Support "Enhanced IBRS" on future CPUs
  Revert "x86/retpoline: Simplify vmexit_fill_RSB()"
  x86/retpoline: Support retpoline build with Clang

 arch/x86/Makefile                     |   5 +-
 arch/x86/entry/entry_32.S             |   3 +-
 arch/x86/entry/entry_64.S             |   3 +-
 arch/x86/include/asm/apm.h            |   6 ++
 arch/x86/include/asm/asm-prototypes.h |   3 -
 arch/x86/include/asm/cpufeatures.h    |   1 +
 arch/x86/include/asm/efi.h            |  17 ++++-
 arch/x86/include/asm/nospec-branch.h  | 118 +++++++++++++++++++++++++++++-----
 arch/x86/kernel/cpu/bugs.c            |  27 +++++++-
 arch/x86/kvm/vmx.c                    |  31 +++++----
 arch/x86/lib/Makefile                 |   1 -
 arch/x86/lib/retpoline.S              |  56 ----------------
 include/linux/compiler-clang.h        |   5 ++
 include/linux/compiler-gcc.h          |   4 ++
 include/linux/init.h                  |   8 +--
 15 files changed, 186 insertions(+), 102 deletions(-)

-- 
2.7.4
