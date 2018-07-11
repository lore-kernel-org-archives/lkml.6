Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC54C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F1A208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F1A208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388331AbeGKOBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:01:34 -0400
Received: from foss.arm.com ([217.140.101.70]:36288 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388248AbeGKOBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:01:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 756297A9;
        Wed, 11 Jul 2018 06:57:05 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 63FDE3F5B1;
        Wed, 11 Jul 2018 06:57:03 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com
Cc:     catalin.marinas@arm.com, dave.martin@arm.com, hch@infradead.org,
        james.morse@arm.com, linux@dominikbrodowski.net,
        linux-fsdevel@vger.kernel.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, viro@zeniv.linux.org.uk
Subject: [PATCHv5 00/21] arm64: invoke syscalls with pt_regs
Date:   Wed, 11 Jul 2018 14:56:35 +0100
Message-Id: <20180711135656.20670-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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

Since v1 [3]:
* Rebase atop of arm64 for-next/core (for SSBD conflicts)
* Move ksys_personality logic into <linux/syscalls.h>
* Move kcompat_sys_* wrappers to <linux/compat.h>
* Fix scno bounds check to use unsigned comparison
* Fix sve_user_reset() call in el0_svc_handler()
* Add BUILD_BUG() to the !CONFIG_ARM64_SVE stubs
* Accumulate acked-by / reviewed-by tags

Since v2 [4]:
* Rebase to v4.18-rc1
* Take upper 32 RES0 bits of SCTLR_ELx into account
* Accumulate acks

Since v3 [5]:
* Rebase to v4.18-rc3 to avoid conflict with FPSIMD/SVE fixes
* Accumulate acks / reviewed-by tags
* Rework __invoke_syscall() for consistency with do_ni_syscall()
* Rename sve_user_reset() to sve_user_discard()
* Tidied up comment placement
* Typo fixes

Since v4 [6]:
* Rework label names in apply_ssbd
* Clean up {compat_,}sys_call_table types
* Made syscall_fn_t[] arguments const
* Drop {compat_,}sys_call_table alignment

Thanks,
Mark.

[1] https://lkml.kernel.org/r/20180330093720.6780-1-linux@dominikbrodowski.net
[2] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
[3] https://lkml.kernel.org/r/20180514094640.27569-1-mark.rutland@arm.com
[4] https://lkml.kernel.org/r/20180601112441.37810-1-mark.rutland@arm.com
[5] https://lkml.kernel.org/r/20180618120310.39527-1-mark.rutland@arm.com
[6] https://lkml.kernel.org/r/20180702110415.10465-1-mark.rutland@arm.com

Mark Rutland (21):
  arm64: consistently use unsigned long for thread flags
  arm64: move SCTLR_EL{1,2} assertions to <asm/sysreg.h>
  arm64: kill config_sctlr_el1()
  arm64: kill change_cpacr()
  arm64: move sve_user_{enable,disable} to <asm/fpsimd.h>
  arm64: remove sigreturn wrappers
  arm64: introduce syscall_fn_t
  arm64: convert raw syscall invocation to C
  arm64: convert syscall trace logic to C
  arm64: convert native/compat syscall entry to C
  arm64: don't restore GPRs when context tracking
  arm64: don't reload GPRs after apply_ssbd
  arm64: zero GPRs upon entry from EL0
  arm64: drop alignment from syscall tables
  kernel: add ksys_personality()
  kernel: add kcompat_sys_{f,}statfs64()
  arm64: remove in-kernel call to sys_personality()
  arm64: use {COMPAT,}SYSCALL_DEFINE0 for sigreturn
  arm64: use SYSCALL_DEFINE6() for mmap
  arm64: convert compat wrappers to C
  arm64: implement syscall wrappers

 arch/arm64/Kconfig                       |   1 +
 arch/arm64/include/asm/fpsimd.h          |  17 +++-
 arch/arm64/include/asm/syscall.h         |   8 +-
 arch/arm64/include/asm/syscall_wrapper.h |  80 ++++++++++++++++
 arch/arm64/include/asm/sysreg.h          |  30 ++----
 arch/arm64/include/asm/unistd32.h        |  26 ++---
 arch/arm64/kernel/Makefile               |   5 +-
 arch/arm64/kernel/armv8_deprecated.c     |   8 +-
 arch/arm64/kernel/cpu_errata.c           |   3 +-
 arch/arm64/kernel/entry.S                | 157 ++++---------------------------
 arch/arm64/kernel/entry32.S              | 121 ------------------------
 arch/arm64/kernel/fpsimd.c               |  19 ----
 arch/arm64/kernel/signal.c               |   5 +-
 arch/arm64/kernel/signal32.c             |   6 +-
 arch/arm64/kernel/sys.c                  |  29 +++---
 arch/arm64/kernel/sys32.c                | 135 ++++++++++++++++++++++----
 arch/arm64/kernel/syscall.c              | 132 ++++++++++++++++++++++++++
 arch/arm64/kernel/traps.c                |  18 +---
 arch/arm64/mm/fault.c                    |   2 +-
 fs/statfs.c                              |  14 ++-
 include/linux/compat.h                   |  11 +++
 include/linux/syscalls.h                 |  11 +++
 22 files changed, 462 insertions(+), 376 deletions(-)
 create mode 100644 arch/arm64/include/asm/syscall_wrapper.h
 delete mode 100644 arch/arm64/kernel/entry32.S
 create mode 100644 arch/arm64/kernel/syscall.c

-- 
2.11.0

