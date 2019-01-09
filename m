Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3A9C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D4B20859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbfAIMkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:40:55 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:53666 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730609AbfAIMky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 07:40:54 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id EB1DA72CA5E;
        Wed,  9 Jan 2019 15:40:44 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id DB66A7CCE38; Wed,  9 Jan 2019 15:40:44 +0300 (MSK)
Date:   Wed, 9 Jan 2019 15:40:44 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/14] Prepare syscall_get_arch for PTRACE_GET_SYSCALL_INFO
Message-ID: <20190109124044.GA11935@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syscall_get_arch() is required to be implemented on all architectures in order
to extend the generic ptrace API with PTRACE_GET_SYSCALL_INFO request:
syscall_get_arch() is going to be called from ptrace_request() along with
syscall_get_nr(), syscall_get_arguments(), syscall_get_error(), and
syscall_get_return_value() functions with a tracee as their argument.

The primary intent is that the triple (audit_arch, syscall_nr, arg1..arg6)
should describe what system call is being called and what its arguments are.

This patchset began as a series called "Prepare for PTRACE_GET_SYSCALL_INFO",
then I merged it into a series called "ptrace: add PTRACE_GET_SYSCALL_INFO request"
that also contains ptrace-specific changes.

The ptrace-specific part, however, needs more attention to workaround problems
on niche architectures like alpha, while the syscall_get_arch() part is
straightforward, so I decided to split it out into a separate patchset that
just prepares syscall_get_arch() for PTRACE_GET_SYSCALL_INFO: it adds
syscall_get_arch() to those architectures that haven't implemented it yet,
and then adds "struct task_struct *" argument to syscall_get_arch()
on all architectures.

All patches from this patchset have been already reviewed, so it's ready
to be merged without waiting for the ptrace-specific part.  As it's all
about syscall_get_arch(), it should probably go via audit tree.

Dmitry V. Levin (14):
  Move EM_ARCOMPACT and EM_ARCV2 to uapi/linux/elf-em.h
  arc: define syscall_get_arch()
  c6x: define syscall_get_arch()
  h8300: define syscall_get_arch()
  Move EM_HEXAGON to uapi/linux/elf-em.h
  hexagon: define syscall_get_arch()
  m68k: define syscall_get_arch()
  Move EM_NDS32 to uapi/linux/elf-em.h
  nds32: define syscall_get_arch()
  nios2: define syscall_get_arch()
  riscv: define syscall_get_arch()
  Move EM_UNICORE to uapi/linux/elf-em.h
  unicore32: define syscall_get_arch()
  syscall_get_arch: add "struct task_struct *" argument

 arch/alpha/include/asm/syscall.h      |  2 +-
 arch/arc/include/asm/elf.h            |  6 +-----
 arch/arc/include/asm/syscall.h        | 11 +++++++++++
 arch/arm/include/asm/syscall.h        |  2 +-
 arch/arm64/include/asm/syscall.h      |  4 ++--
 arch/c6x/include/asm/syscall.h        |  7 +++++++
 arch/csky/include/asm/syscall.h       |  2 +-
 arch/h8300/include/asm/syscall.h      |  6 ++++++
 arch/hexagon/include/asm/elf.h        |  6 +-----
 arch/hexagon/include/asm/syscall.h    |  8 ++++++++
 arch/ia64/include/asm/syscall.h       |  2 +-
 arch/m68k/include/asm/syscall.h       | 12 ++++++++++++
 arch/microblaze/include/asm/syscall.h |  2 +-
 arch/mips/include/asm/syscall.h       |  6 +++---
 arch/mips/kernel/ptrace.c             |  2 +-
 arch/nds32/include/asm/elf.h          |  3 +--
 arch/nds32/include/asm/syscall.h      |  9 +++++++++
 arch/nios2/include/asm/syscall.h      |  6 ++++++
 arch/openrisc/include/asm/syscall.h   |  2 +-
 arch/parisc/include/asm/syscall.h     |  4 ++--
 arch/powerpc/include/asm/syscall.h    | 10 ++++++++--
 arch/riscv/include/asm/syscall.h      | 10 ++++++++++
 arch/s390/include/asm/syscall.h       |  4 ++--
 arch/sh/include/asm/syscall_32.h      |  2 +-
 arch/sh/include/asm/syscall_64.h      |  2 +-
 arch/sparc/include/asm/syscall.h      |  5 +++--
 arch/unicore32/include/asm/elf.h      |  3 +--
 arch/unicore32/include/asm/syscall.h  | 12 ++++++++++++
 arch/x86/include/asm/syscall.h        |  8 +++++---
 arch/x86/um/asm/syscall.h             |  2 +-
 arch/xtensa/include/asm/syscall.h     |  2 +-
 include/asm-generic/syscall.h         |  5 +++--
 include/uapi/linux/audit.h            | 14 ++++++++++++++
 include/uapi/linux/elf-em.h           |  6 ++++++
 kernel/auditsc.c                      |  4 ++--
 kernel/seccomp.c                      |  4 ++--
 36 files changed, 148 insertions(+), 47 deletions(-)
 create mode 100644 arch/m68k/include/asm/syscall.h
 create mode 100644 arch/unicore32/include/asm/syscall.h

-- 
ldv
