Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04ABEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0ED4218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a4ymj2uP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbeLZXJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 18:09:07 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:20021 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbeLZXJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 18:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1545865747; x=1577401747;
  h=from:to:cc:subject:date:message-id;
  bh=D2ricm/sbPYel2rJ3/2ozWijyVugQCb4BhRoHhAiq5Y=;
  b=a4ymj2uPlQKUMjth2/rBc0NMCPiUy/wouaJ4znBYr2NSpae3Q5PQ1Bml
   nyWutOq+5D4BwEeos6mM3rX7E+e+4RxBCdAtVgNrz75QlJ2kb2Wer6sQd
   +Dq5bKktKE5kUNFY8ErblOqyw+WpcI5nKKJ5y77CV97jZIdkwiWycHw0Z
   YretJXAVJqHqaYXUUcowIm5bK26j2HpyzSjRrYSC/ovjDys8k+inw8Ge5
   ggLbnRiTfgDaQbwa90r1E3mSZItR6IcmIaQk45V9KHDqHVnpP+QvjPhhs
   Jpq2BqFSKiF12NIzKPVVoX6n5WCEHVRs/yndezFIQ+oV2INeib1jx0ko9
   w==;
X-IronPort-AV: E=Sophos;i="5.56,401,1539619200"; 
   d="scan'208";a="98702972"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Dec 2018 07:09:07 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 26 Dec 2018 14:49:51 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Dec 2018 15:09:07 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-riscv@lists.infradead.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Michael Clark <michaeljclark@mac.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        =?UTF-8?q?Patrick=20St=C3=A4hlin?= <me@packi.ch>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: [PATCH 0/3] Non-smp configuration fix
Date:   Wed, 26 Dec 2018 15:08:58 -0800
Message-Id: <1545865741-22795-1-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing upstream kernel doesn't boot for non-smp
configuration. This patch series address various issues
with non-smp configurations.

Tested on QEMU and HiFive Unleashed board.

Atish Patra (3):
RISC-V: Do not wait indefinitely in __cpu_up
RISC-V: Move cpuid to hartid mapping to SMP.
RISC-V: Fix non-smp kernel boot on SMP systems

arch/riscv/include/asm/smp.h      | 13 +++++++++++--
arch/riscv/kernel/cpu.c           |  4 ----
arch/riscv/kernel/setup.c         |  2 ++
arch/riscv/kernel/smp.c           |  1 -
arch/riscv/kernel/smpboot.c       | 19 ++++++++++++++++---
drivers/clocksource/riscv_timer.c | 21 ++++++++++++++++++---
drivers/irqchip/irq-sifive-plic.c |  5 +++++
7 files changed, 52 insertions(+), 13 deletions(-)

--
2.7.4

