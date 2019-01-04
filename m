Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EDAC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7D4218CD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfADSYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:24:32 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48458 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728012AbfADSYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 13:24:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A0E6EBD;
        Fri,  4 Jan 2019 10:24:31 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B2953F5D4;
        Fri,  4 Jan 2019 10:24:30 -0800 (PST)
Date:   Fri, 4 Jan 2019 18:24:27 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com
Subject: [GIT PULL] arm64: fixes for -rc1
Message-ID: <20190104182427.GD6299@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I'm safely chained back up to my desk, so please pull these arm64 fixes
for -rc1 that address some issues that cropped up during the merge window.

Details in the tag.

Cheers,

Will

--->8

The following changes since commit 12f799c8c739518e12248bbd000eb0a246e8e5f8:

  arm64: kaslr: print PHYS_OFFSET in dump_kernel_offset() (2018-12-14 09:33:49 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 7e0b44e870cf265bb4a73fd25e0508c7363fcbd6:

  arm64: compat: Hook up io_pgetevents() for 32-bit tasks (2019-01-04 14:18:01 +0000)

----------------------------------------------------------------
arm64 fixes for -rc1

- Prevent KASLR from mapping the top page of the virtual address space

- Fix device-tree probing of SDEI driver

- Fix incorrect register offset definition in Hisilicon DDRC PMU driver

- Fix compilation issue with older binutils not liking unsigned immediates

- Fix uapi headers so that libc can provide its own sigcontext definition

- Fix handling of private compat syscalls

- Hook up compat io_pgetevents() syscall for 32-bit tasks

- Cleanup to arm64 Makefile (including now to avoid silly conflicts)

----------------------------------------------------------------
Dave Martin (2):
      arm64/sve: ptrace: Fix SVE_PT_REGS_OFFSET definition
      arm64/sve: Disentangle <uapi/asm/ptrace.h> from <uapi/asm/sigcontext.h>

James Morse (1):
      firmware: arm_sdei: Fix DT platform device creation

Mark Rutland (1):
      arm64: entry: remove unused register aliases

Masahiro Yamada (1):
      arm64: replace arm64-obj-* in Makefile with obj-*

Nicolas Saenz Julienne (1):
      firmware: arm_sdei: fix wrong of_node_put() in init function

Shaokun Zhang (2):
      arm64: smp: Fix compilation error
      drivers/perf: hisi: Fixup one DDRC PMU register offset

Will Deacon (3):
      arm64: compat: Avoid sending SIGILL for unallocated syscall numbers
      arm64: compat: Don't pull syscall number from regs in arm_compat_syscall
      arm64: compat: Hook up io_pgetevents() for 32-bit tasks

Yueyi Li (1):
      arm64: kaslr: Reserve size of ARM64_MEMSTART_ALIGN in linear region

 arch/arm64/include/asm/smp.h                  |  8 ++--
 arch/arm64/include/asm/unistd.h               |  7 +--
 arch/arm64/include/asm/unistd32.h             |  2 +
 arch/arm64/include/uapi/asm/ptrace.h          | 39 ++++++++---------
 arch/arm64/include/uapi/asm/sigcontext.h      | 56 ++++++++++++------------
 arch/arm64/include/uapi/asm/sve_context.h     | 53 +++++++++++++++++++++++
 arch/arm64/kernel/Makefile                    | 61 +++++++++++++--------------
 arch/arm64/kernel/entry.S                     | 12 +-----
 arch/arm64/kernel/sys_compat.c                | 11 +++--
 arch/arm64/kernel/syscall.c                   |  9 ++--
 arch/arm64/mm/init.c                          |  2 +-
 drivers/firmware/arm_sdei.c                   |  6 ---
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c |  4 +-
 13 files changed, 153 insertions(+), 117 deletions(-)
 create mode 100644 arch/arm64/include/uapi/asm/sve_context.h
