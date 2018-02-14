Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032060AbeBNX3f (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 18:29:35 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:40192 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032006AbeBNX3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 18:29:33 -0500
X-IronPort-AV: E=Sophos;i="5.46,514,1511827200";
   d="scan'208";a="719700854"
From: David Woodhouse <dwmw@amazon.co.uk>
To: tglx@linutronix.de, karahmed@amazon.de, x86@kernel.org,
        kvm@vger.kernel.org, torvalds@linux-foundation.org,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org, bp@alien8.de,
        peterz@infradead.org, jmattson@google.com, rkrcmar@redhat.com,
        arjan.van.de.ven@intel.com, dave.hansen@intel.com, mingo@kernel.org
Subject: [PATCH v2 0/4] Speculation control improvements
Date: Wed, 14 Feb 2018 23:29:14 +0000
Message-Id: <1518650958-550-1-git-send-email-dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On CPUs which advertise IBRS_ALL, enable it and disable the retpoline
as IBRS_ALL will be faster.

Also use IBRS whenever it's available before calling into firmware at
runtime.

Revert another bikeshedding patch that was broken, and add support for
retpoline builds with clang.

---
v2: Remember to export spectre_v2_enabled

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
