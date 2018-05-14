Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752126AbeENJq5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 05:46:57 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38168 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751780AbeENJq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 05:46:56 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        dave.martin@arm.com, james.morse@arm.com, linux@dominikbrodowski.net,
        linux-fsdevel@vger.kernel.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, viro@zeniv.linux.org.uk, will.deacon@arm.com
Subject: [PATCH 00/18] arm64: invoke syscalls with pt_regs
Date: Mon, 14 May 2018 10:46:22 +0100
Message-Id: <20180514094640.27569-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series reworks arm64's syscall handling to minimize the propagation
of user-controlled register values into speculated code paths. As with
x86 [1], a wrapper is generated for each syscall, which extracts the
argument from a struct pt_regs. During kernel entry from userspace,
registers are zeroed.

The arm64 kernel code directly invokes some syscalls which the x86 code
doesn't, so I've added ksys_* wrappers for these, following the x86
example. The rest of the series is arm64-specific.

I've pushed the series out to my arm64/syscall-regs branch [2] on
kernel.org.

Thanks,
Mark.

[1] https://lkml.kernel.org/r/20180330093720.6780-1-linux@dominikbrodowski.net
[2] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git

Mark Rutland (18):
  arm64: consistently use unsigned long for thread flags
  arm64: move SCTLR_EL{1,2} assertions to <asm/sysreg.h>
  arm64: introduce sysreg_clear_set()
  arm64: kill config_sctlr_el1()
  arm64: kill change_cpacr()
  arm64: move sve_user_{enable,disable} to <asm/fpsimd.h>
  arm64: remove sigreturn wrappers
  arm64: convert raw syscall invocation to C
  arm64: convert syscall trace logic to C
  arm64: convert native/compat syscall entry to C
  arm64: zero GPRs upon entry from EL0
  kernel: add ksys_personality()
  kernel: add kcompat_sys_{f,}statfs64()
  arm64: remove in-kernel call to sys_personality()
  arm64: use {COMPAT,}SYSCALL_DEFINE0 for sigreturn
  arm64: use SYSCALL_DEFINE6() for mmap
  arm64: convert compat wrappers to C
  arm64: implement syscall wrappers

 arch/arm64/Kconfig                       |   1 +
 arch/arm64/include/asm/fpsimd.h          |  17 ++++-
 arch/arm64/include/asm/syscall_wrapper.h |  80 ++++++++++++++++++++
 arch/arm64/include/asm/sysreg.h          |  33 ++++----
 arch/arm64/include/asm/unistd32.h        |  26 +++----
 arch/arm64/kernel/Makefile               |   5 +-
 arch/arm64/kernel/armv8_deprecated.c     |   8 +-
 arch/arm64/kernel/cpu_errata.c           |   3 +-
 arch/arm64/kernel/entry.S                | 126 +++----------------------------
 arch/arm64/kernel/entry32.S              | 121 -----------------------------
 arch/arm64/kernel/fpsimd.c               |  20 -----
 arch/arm64/kernel/signal.c               |   5 +-
 arch/arm64/kernel/signal32.c             |   6 +-
 arch/arm64/kernel/sys.c                  |  19 +++--
 arch/arm64/kernel/sys32.c                | 116 ++++++++++++++++++++++++----
 arch/arm64/kernel/syscall.c              | 113 +++++++++++++++++++++++++++
 arch/arm64/kernel/traps.c                |   4 +-
 arch/arm64/mm/fault.c                    |   2 +-
 fs/statfs.c                              |  14 +++-
 include/linux/syscalls.h                 |   9 +++
 kernel/exec_domain.c                     |   7 +-
 21 files changed, 411 insertions(+), 324 deletions(-)
 create mode 100644 arch/arm64/include/asm/syscall_wrapper.h
 delete mode 100644 arch/arm64/kernel/entry32.S
 create mode 100644 arch/arm64/kernel/syscall.c

-- 
2.11.0
