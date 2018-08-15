Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9419C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED39E214EE
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rTq9pm5y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED39E214EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbeHPCut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 22:50:49 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:25856 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbeHPCut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 22:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1534377379; x=1565913379;
  h=from:to:cc:subject:date:message-id;
  bh=/ALim0HvIQixEG/GWULXYgvQPEPt76plpIPUiQHzn/g=;
  b=rTq9pm5ybgZAHAVG0DDw9kF3N8kv1Pd+sRhPUPC5R/zRSh6D5ftr4mNB
   F8u3FnmVT6zKiEy6BjP516mviaWilsufldmyHy8wPhE9d+P74zC6nmABA
   l/ojwlpdFBGO0lD3HFkSxgdaCHYLUjaqu+D1j2lo+cx6nvFhRhDBFXu2w
   s0mFJNz4yjNuosPNhwJxD86B4wKgEHAcCNmFWW43bTw7SgE2oNJdksX9j
   vMdnnpL/orEgfoJs4VETMABL/4w0DwD3vS1k64LhHQ1IDAz7Mhv8Euiew
   vOYH5qKnac9XL0pq8Hv4mMpInIK1YxHGHu9kvUxzfyyaSZwZcORoyzmCZ
   Q==;
X-IronPort-AV: E=Sophos;i="5.53,245,1531756800"; 
   d="scan'208";a="88557060"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2018 07:56:18 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 15 Aug 2018 16:44:16 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Aug 2018 16:56:18 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        mark.rutland@arm.com, anup@brainfault.org, hch@infradead.org
Cc:     atish.patra@wdc.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Damien.LeMoal@wdc.com
Subject: [RFC PATCH 0/5] RISC-V: Improve smp functionality & support cpu hotplug 
Date:   Wed, 15 Aug 2018 16:56:12 -0700
Message-Id: <1534377377-70108-1-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series implements following smp related features.
Some of the work has been inspired from ARM64.

1. Decouple linux logical cpu ids from hardware cpu id
2. Introduce cpu_operations structure for better flexibility &
  extesnability of future smp enablement methods. It also makes it
  easier to implement different booting algorithms later.
3. Support cpu hotplug.

Tested on QEMU & HighFive Unleashed board with/without SMP enabled.

Atish Patra (5):
  RISC-V: Add logical CPU indexing for RISC-V
  RISC-V: Use Linux logical cpu number instead of hartid
  RISC-V: Add cpu_operatios structure
  RISC-V: Move interrupt cause declarations to irq.h
  RISC-V: Support cpu hotplug.

 arch/riscv/Kconfig                |  12 ++-
 arch/riscv/include/asm/irq.h      |   7 ++
 arch/riscv/include/asm/smp.h      |  42 +++++++++-
 arch/riscv/include/asm/tlbflush.h |  17 +++-
 arch/riscv/kernel/cpu.c           |   4 +-
 arch/riscv/kernel/head.S          |  13 +++
 arch/riscv/kernel/irq.c           |   7 --
 arch/riscv/kernel/process.c       |   7 ++
 arch/riscv/kernel/setup.c         |  27 +++++++
 arch/riscv/kernel/smp.c           |  51 +++++++++---
 arch/riscv/kernel/smpboot.c       | 161 +++++++++++++++++++++++++++++++++-----
 arch/riscv/kernel/traps.c         |   6 +-
 drivers/clocksource/riscv_timer.c |  12 ++-
 drivers/irqchip/irq-sifive-plic.c |  11 ++-
 14 files changed, 325 insertions(+), 52 deletions(-)

-- 
2.7.4

