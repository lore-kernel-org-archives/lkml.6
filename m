Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6133FC282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C7D21916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kmfCsVtV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfBHBvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 20:51:35 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:13327 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfBHBvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 20:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549590695; x=1581126695;
  h=from:to:cc:subject:date:message-id;
  bh=ekA27SFnkSXYPCaYcQ+ZFq+nJ4ufZt1MgKQdXNWxxgQ=;
  b=kmfCsVtV1ujjQCLo/lySEVxQEGUbHGhxHr7PIuM2udJ7r0XKrd00289H
   eA1ex66zPJyRHGlDTayeWti9Z31LP9wjn79zZvQg1YntTh7Z43xBwY3Tv
   hjpSeW/Z566D10sulJJEqZfWPyLk9ZP78Qa3GuAWWMtn1Y4HqJfQIY6kg
   XCE3VIv8/7icAPiXWPsdmqhI0wuT2x8JXuLi+cTg91XoT58s9haSHt09t
   eAgxQTzmndiaTn3IfPfOjuO94djhvv1soYU+yzrCaGy7yRzib/1osSmwt
   uFD4v9kfdKjwplFf2NpLr8xhPOda74iYHWIiFG9Q6q/2MzKukjVqeTgjU
   A==;
X-IronPort-AV: E=Sophos;i="5.58,346,1544457600"; 
   d="scan'208";a="100752776"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2019 09:51:35 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Feb 2019 17:32:18 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Feb 2019 17:51:35 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-riscv@lists.infradead.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        =?UTF-8?q?Patrick=20St=C3=A4hlin?= <me@packi.ch>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zong Li <zongbox@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: [v3 PATCH 0/8] Various SMP related fixes
Date:   Thu,  7 Feb 2019 17:51:13 -0800
Message-Id: <1549590681-24125-1-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing upstream kernel doesn't boot for non-smp
configuration. This patch series address various issues
with non-smp configurations.

The patch series is based on 5.0-rc5. Tested on QEMU and
HiFive Unleashed board using both OpenSBI & BBL.

Changes from v2->v3

1. Fixed spurious white space.
2. Added lockdep for smpboot completion variable.
2. Added a sanity check for hwcap.

Changes from v1->v2

1. Move the cpuid to hartd id map to smp.c from setup.c
2. Split 3rd patch into several small patches based on
   logical grouping.
3. Added a new patch that fixes an issue in hwcap query.
4. Changed the title of the patch series.

Atish Patra (8):
RISC-V: Do not wait indefinitely in __cpu_up
RISC-V: Move cpuid to hartid mapping to SMP.
RISC-V: Remove NR_CPUs check during hartid search from DT
RISC-V: Allow hartid-to-cpuid function to fail.
RISC-V: Compare cpuid with NR_CPUS before mapping.
clocksource/drivers/riscv: Add required checks during clock source
init
irqchip/irq-sifive-plic:: Check and continue in case of an invalid
cpuid.
RISC-V: Assign hwcap only according to boot cpu.

arch/riscv/include/asm/smp.h      | 14 ++++++++---
arch/riscv/kernel/cpu.c           |  4 ---
arch/riscv/kernel/cpufeature.c    | 52 +++++++++++++++++++++++++++------------
arch/riscv/kernel/setup.c         |  9 -------
arch/riscv/kernel/smp.c           | 10 +++++++-
arch/riscv/kernel/smpboot.c       | 20 ++++++++++++---
drivers/clocksource/timer-riscv.c | 23 ++++++++++++++---
drivers/irqchip/irq-sifive-plic.c |  5 ++++
8 files changed, 98 insertions(+), 39 deletions(-)

--
2.7.4

