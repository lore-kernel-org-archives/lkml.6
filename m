Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F315DC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89D920893
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZotF9bUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89D920893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbeH1M0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:26:45 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54531 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbeH1M0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1535445407; x=1566981407;
  h=from:to:cc:subject:date:message-id;
  bh=Wykkqqy7tUmxM6aSYALi1eP8zK57QFGS7kw1FeXnjc0=;
  b=ZotF9bUYzlduGKOK/idFOCf37w79xpzb1AQTXAEShP5QsersFvxgvvXz
   oTJJRYceivjgUcX9cV0kQIRGWr2Rj0Xv9k8h3+7efmY9n48Mw3EqB+V3Z
   MEK3Ca2kVEIiZDEXvNd5q1mShXKatuItfeoLxaihl/zFv7JmYVcXyttHv
   LIvJj6n4r39W7BQb5tDZ3QgycCyKDK2YqRc1/9vHS6S0WieH28MJURCuM
   Xohyn/bjmnAOgE86e2U4fx0y8TtXX4rkPI5upjbBnO1Z0HB4CBT2QxthW
   5nVKIkx/sKH5N/YAj9hpXcIOpYggCFczgRrIejKU1IXPmb0Hw1qsWHy13
   Q==;
X-IronPort-AV: E=Sophos;i="5.53,298,1531756800"; 
   d="scan'208";a="185994289"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2018 16:36:46 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 28 Aug 2018 01:23:08 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Aug 2018 01:36:11 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        mark.rutland@arm.com, anup@brainfault.org, hch@infradead.org
Cc:     atish.patra@wdc.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, damein@vger.kernel.org
Subject: [PATCH v2 0/3] RISC-V: Add new smp features
Date:   Tue, 28 Aug 2018 01:36:07 -0700
Message-Id: <1535445370-19004-1-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series implements following smp related features.
Some of the work has been inspired from ARM64.

1. Decouple linux logical cpu ids from hardware cpu id
2. Support cpu hotplug.

Tested on QEMU & HighFive Unleashed board with/without SMP enabled.

v1->v2:

1. Dropped cpu_ops patch.
2. Moved back IRQ cause definiations to irq.h
3. Keep boot cpu hart id and assign zero as the cpu id for boot cpu.
4. Renamed cpu id and hart id correctly. 

Atish Patra (3):
  RISC-V: Add logical CPU indexing for RISC-V
  RISC-V: Use Linux logical cpu number instead of hartid
  RISC-V: Support cpu hotplug.

 arch/riscv/Kconfig                | 12 +++++-
 arch/riscv/include/asm/irq.h      |  1 +
 arch/riscv/include/asm/smp.h      | 33 ++++++++++++++-
 arch/riscv/include/asm/tlbflush.h | 17 ++++++--
 arch/riscv/kernel/cpu.c           |  8 ++--
 arch/riscv/kernel/head.S          | 17 +++++++-
 arch/riscv/kernel/irq.c           | 27 +++++++++++-
 arch/riscv/kernel/process.c       |  7 ++++
 arch/riscv/kernel/setup.c         | 25 ++++++++++-
 arch/riscv/kernel/smp.c           | 51 +++++++++++++++++++----
 arch/riscv/kernel/smpboot.c       | 87 +++++++++++++++++++++++++++++++++------
 arch/riscv/kernel/traps.c         |  6 +--
 drivers/clocksource/riscv_timer.c | 12 ++++--
 drivers/irqchip/irq-sifive-plic.c | 11 +++--
 14 files changed, 269 insertions(+), 45 deletions(-)

-- 
2.7.4

