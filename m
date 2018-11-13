Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F210FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB59B223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB59B223C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=packi.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbeKNF57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:57:59 -0500
Received: from mail.binarylogic.ch ([88.198.23.72]:47876 "EHLO
        mail.binarylogic.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeKNF57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:57:59 -0500
Received: from fortknox.localdomain (unknown [192.168.122.1])
        by mail.binarylogic.ch (Postfix) with ESMTP id 49195DF386;
        Tue, 13 Nov 2018 20:58:18 +0100 (CET)
From:   =?UTF-8?q?Patrick=20St=C3=A4hlin?= <me@packi.ch>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Patrick=20St=C3=A4hlin?= <me@packi.ch>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: [RFC/RFT 0/2] RISC-V: kprobes/kretprobe support
Date:   Tue, 13 Nov 2018 20:58:02 +0100
Message-Id: <20181113195804.22825-1-me@packi.ch>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is first version of kprobes/kretprobe support for RISC-V. Most of
the code is based on arm64 but obviously without the single-step
functionality.

It will insert a C.EBREAK instruction that is later being captured. The
only instruction supported at the moment is C.ADDISP16 as this sets-up
the stack frames for all the functions I've tested.

I've tested this on QEMU with multiple CPUs but don't have any real
hardware available for testing, and from experience that's when things
start breaking.

The plan is to expand compressed instructions to full ones and simulate
those to reduce the decoding overhead per intercepted call.

Please let me know if you have any objections to path I've chosen and
which instructions you absolutely need for a first version.

To enable this you need the following defines:

CONFIG_FUNCTION_TRACER=y
CONFIG_KPROBES=y
CONFIG_MODULES=y

The CONFIG_FUNCTION_TRACER is not strictly needed but makes testing
easier using debugfs.

After that, any example documented in 
Documentation/trace/kprobetrace.rst should work.

Patrick Stählin (2):
  RISC-V: Implement ptrace regs and stack API
  RISC-V: kprobes/kretprobe support

 arch/riscv/Kconfig                            |   6 +-
 arch/riscv/include/asm/kprobes.h              |  30 ++
 arch/riscv/include/asm/probes.h               |  26 ++
 arch/riscv/include/asm/ptrace.h               |  34 ++
 arch/riscv/kernel/Makefile                    |   1 +
 arch/riscv/kernel/probes/Makefile             |   3 +
 arch/riscv/kernel/probes/decode-insn.c        |  38 ++
 arch/riscv/kernel/probes/decode-insn.h        |  23 +
 arch/riscv/kernel/probes/kprobes.c            | 401 ++++++++++++++++++
 arch/riscv/kernel/probes/kprobes_trampoline.S |  91 ++++
 arch/riscv/kernel/probes/simulate-insn.c      |  33 ++
 arch/riscv/kernel/probes/simulate-insn.h      |   8 +
 arch/riscv/kernel/ptrace.c                    |  99 +++++
 arch/riscv/kernel/traps.c                     |  13 +-
 arch/riscv/mm/fault.c                         |  28 +-
 15 files changed, 828 insertions(+), 6 deletions(-)
 create mode 100644 arch/riscv/include/asm/probes.h
 create mode 100644 arch/riscv/kernel/probes/Makefile
 create mode 100644 arch/riscv/kernel/probes/decode-insn.c
 create mode 100644 arch/riscv/kernel/probes/decode-insn.h
 create mode 100644 arch/riscv/kernel/probes/kprobes.c
 create mode 100644 arch/riscv/kernel/probes/kprobes_trampoline.S
 create mode 100644 arch/riscv/kernel/probes/simulate-insn.c
 create mode 100644 arch/riscv/kernel/probes/simulate-insn.h

-- 
2.17.1

