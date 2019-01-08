Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6615FC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353DC206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CIfdy/27"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfAHJir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:38:47 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:8878 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfAHJiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:38:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1546940325; x=1578476325;
  h=from:to:cc:subject:date:message-id;
  bh=uS25H3RUV70CmFga3KxRSuzV/HDyoT7Yqt9qv2SDLGo=;
  b=CIfdy/27kRoMNGTx3E5urqiwQfkpAjaHlQyimX2aMERsFGYSsi8VidPf
   1PLPQrVoZEkIhLvzj9bb51Cb4mpj/p4NRUXwfKCPrr9RCMTsqsQE9UlFQ
   5o+L6EWmuR6hHQUIENoAWCUipJXqPE1oubejVCDm4wG+BsICi8euTMf7n
   sA11EpiR163WS0FY0iBAbrmWCK2uORjLGi3Wu+HBhz8uDnMHITatX03W3
   T88NKb8FvgoE+MOtFz82epPaR+CQnhaDL17o5iUP/HE55pGkZaKiDmKNY
   sYS3PuM7OeFifvtHSbLjD+80TIiMquOCoM6Ti3S1pxs8gjw7Z7ocrhGnW
   A==;
X-IronPort-AV: E=Sophos;i="5.56,453,1539619200"; 
   d="scan'208";a="99458398"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jan 2019 17:38:45 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 08 Jan 2019 01:18:50 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Jan 2019 01:38:45 -0800
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
        Michael Clark <michaeljclark@mac.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        =?UTF-8?q?Patrick=20St=C3=A4hlin?= <me@packi.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zong Li <zongbox@gmail.com>
Subject: [PATCH v2 0/8] Various SMP related fixes
Date:   Tue,  8 Jan 2019 01:38:30 -0800
Message-Id: <1546940318-9752-1-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing upstream kernel doesn't boot for non-smp
configuration. This patch series address various issues
with non-smp configurations.

Tested on QEMU and HiFive Unleashed board.

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
RISC-V: Add required checks during clock source init
RISC-V: Check and continue in case of an invalid cpuid.
RISC-V: Assign hwcap only according to current cpu.

arch/riscv/include/asm/smp.h      | 15 ++++++++++++---
arch/riscv/kernel/cpu.c           |  4 ----
arch/riscv/kernel/cpufeature.c    | 11 +++++++----
arch/riscv/kernel/setup.c         |  9 ---------
arch/riscv/kernel/smp.c           | 10 +++++++++-
arch/riscv/kernel/smpboot.c       | 19 ++++++++++++++++---
drivers/clocksource/timer-riscv.c | 23 ++++++++++++++++++++---
drivers/irqchip/irq-sifive-plic.c |  5 +++++
8 files changed, 69 insertions(+), 27 deletions(-)

--
2.7.4

