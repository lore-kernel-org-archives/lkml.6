Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A1CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A3D20652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Q+wEZBVK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A3D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeIFMjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:39:48 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:53549 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeIFMjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1536221192; x=1567757192;
  h=from:to:cc:subject:date:message-id;
  bh=4oo6+SbMmSOSFb/2H4GxBqrHEoNLI+kFgM9/hsbh9Tk=;
  b=Q+wEZBVKqewO5ZwCDRJto9Dh4VrAAUFWPLKYdnYMyftSJL1eOe0ia6sS
   dG1dHEbqbjkMTYxGtRkxUwvqxUkZfj3uVAVFxqBH6f2f63Uofl19uIWyJ
   9VrhVVD10NtJ7MPhBrOLk4vg7EEyET1idoKeG2sOoh6FBtHtFbb6wQQyo
   kd3SYHdKoPHaK8eNVdb2SjV4Fjxggl41D4SO33zWGdoSSxaaNFtIOqYMH
   SuiXZC61XuPEgvzqonrUb3mHKVIHmBSfSfIiUwWswMwl22LYNWGV1wCA6
   ivpZj6kmyvkRtOh771pQY8ErG2wFundOA4tpTfBPW6UIY7dWFcpLy6GlA
   Q==;
X-IronPort-AV: E=Sophos;i="5.53,337,1531756800"; 
   d="scan'208";a="186673934"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2018 16:06:32 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 06 Sep 2018 00:52:11 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Sep 2018 01:05:36 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        hch@infradead.org, anup@brainfault.org
Cc:     mark.rutland@arm.com, atish.patra@wdc.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Damien.LeMoal@wdc.com,
        marc.zyngier@arm.com, jeremy.linton@arm.com,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        catalin.marinas@arm.com, dmitriy@oss-tech.org,
        ard.biesheuvel@linaro.org
Subject: [PATCH v3 00/12] SMP cleanup and new features 
Date:   Thu,  6 Sep 2018 01:05:23 -0700
Message-Id: <1536221135-182613-1-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series has updated the assorted cleanup series by palmer.
The original cleanup patch series can be found here.
http://lists.infradead.org/pipermail/linux-riscv/2018-August/001232.html

It also implemented following smp related features.
Some of the work has been inspired from ARM64.

1. Decouple linux logical cpu ids from hardware cpu id
2. Support cpu hotplug.

Tested on QEMU & HighFive Unleashed board with/without SMP enabled.

Both the patch series have been combined to avoid conflicts as a lot
of common code is changed in both the series. I have mostly addressed
review comments and fixed checkpatch errors from palmer's series.

Palmer: I hope it's not a problem. I would be happy to drop the patches
if you want to take over.

v1->v2:

1. Dropped cpu_ops patch.
2. Moved back IRQ cause definitions to irq.h
3. Keep boot cpu hart id and assign zero as the cpu id for boot cpu.
4. Renamed cpu id and hart id correctly.

v2-v3:

1. Added cleanup patches from palmer.
2. Moved the hotplug related functions to it's own file.
3. Updated stub functions as per coding guidelines.
4. Renamed __cpu_logical_map to a more coherent name.

Atish Patra (5):
  RISC-V: Disable preemption before enabling interrupts
  RISC-V: User WRITE_ONCE instead of direct access
  RISC-V: Add logical CPU indexing for RISC-V
  RISC-V: Use Linux logical cpu number instead of hartid
  RISC-V: Support cpu hotplug.

Palmer Dabbelt (7):
  RISC-V: Don't set cacheinfo.{physical_line_partition,attributes}
  RISC-V: Filter ISA and MMU values in cpuinfo
  RISC-V: Comment on the TLB flush in smp_callin()
  RISC-V: Provide a cleaner raw_smp_processor_id()
  RISC-V: Rename riscv_of_processor_hart to riscv_of_processor_hartid
  RISC-V: Rename im_okay_therefore_i_am to found_boot_cpu
  RISC-V: Use mmgrab()

 arch/riscv/Kconfig                 | 12 +++++-
 arch/riscv/include/asm/irq.h       |  1 +
 arch/riscv/include/asm/processor.h |  2 +-
 arch/riscv/include/asm/smp.h       | 66 +++++++++++++++++++++++++-----
 arch/riscv/include/asm/tlbflush.h  | 16 ++++++--
 arch/riscv/kernel/Makefile         |  1 +
 arch/riscv/kernel/cacheinfo.c      |  7 ----
 arch/riscv/kernel/cpu-hotplug.c    | 72 +++++++++++++++++++++++++++++++++
 arch/riscv/kernel/cpu.c            | 83 ++++++++++++++++++++++++++++++++------
 arch/riscv/kernel/head.S           | 17 +++++++-
 arch/riscv/kernel/irq.c            | 24 +++++++++++
 arch/riscv/kernel/setup.c          | 27 ++++++++++++-
 arch/riscv/kernel/smp.c            | 49 +++++++++++++++-------
 arch/riscv/kernel/smpboot.c        | 53 ++++++++++++++++--------
 arch/riscv/kernel/traps.c          |  6 +--
 drivers/clocksource/riscv_timer.c  | 12 ++++--
 drivers/irqchip/irq-sifive-plic.c  | 10 +++--
 17 files changed, 379 insertions(+), 79 deletions(-)
 create mode 100644 arch/riscv/kernel/cpu-hotplug.c

-- 
2.7.4

