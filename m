Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC03C0044B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1D42147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="J0wINNfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436647AbfBMUS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 15:18:57 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:63574 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732903AbfBMUSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 15:18:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550089100; x=1581625100;
  h=from:to:cc:subject:date:message-id;
  bh=snRz3dxhJ3mJ1sCcBiRAupRtv4dSEiuNGvoXjteiknM=;
  b=J0wINNfdbm2hFk6ExIUta2C7slaT+xtciHvKoq910/UPpztw9vP+IAIH
   NYkImpHjZYTXuIGdhJwWEElZ5UbLFpIDMucP04klaRlA/9UNNADe8jbiM
   o/iQ8ZuUobS+BKPUrg8ha8iBiUFDysiusYY2fn4ZF1I5Mhs1vmIU9YKAu
   0aOtU7aLubFGhUh/3+t79Bn3ytKNyGIUX8yXzztgBLZ6F1rN6krQY6O9T
   Bu//38KtfXYBQ4vaLmzKIFqjR6mLSFPUEvVpGDYU8zwnKYrJtkdeUmEgC
   1FMnqkoHSytqDpOQewJ2cSfMAWjtKLIao9KDmmKHSVCbCxyAe/QL7uc/c
   w==;
X-IronPort-AV: E=Sophos;i="5.58,366,1544457600"; 
   d="scan'208";a="206321176"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2019 04:18:19 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 13 Feb 2019 11:58:53 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Feb 2019 12:18:20 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-riscv@lists.infradead.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jason Cooper <jason@lakedaemon.net>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [v5 PATCH 0/8] Various SMP related fixes
Date:   Wed, 13 Feb 2019 12:18:04 -0800
Message-Id: <1550089092-28783-1-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing upstream kernel doesn't boot for non-smp configuration.
This patch series address various issues with non-smp configurations.

The patch series is based on 5.0-rc5 + Johan's below mentioned patch
series. Tested on both QEMU and HiFive Unleashed board using both
OpenSBI & BBL.

https://lore.kernel.org/lkml/20190118140308.9599-1-johan@kernel.org/   

Changes from v4->v5
1. Continue processing other harts even if isa string is incorrect for
   a single hart during HWCAP processing.

Changes from v3->v4
1. Fixed commit text length issues.
2. Updated hwcap patch to use common capabilities of all harts.
3. Rebased on Johan's patch series.

Changes from v2->v3

1. Fixed spurious white space.
2. Added lockdep for smpboot completion variable.
2. Added a sanity check for hwcap.

Changes from v1->v2

1. Move the cpuid to hartid map to smp.c from setup.c
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
irqchip/irq-sifive-plic: Check and continue in case of an invalid
cpuid.
RISC-V: Assign hwcap as per comman capabilities.

arch/riscv/include/asm/smp.h      | 18 ++++++++++++-----
arch/riscv/kernel/cpu.c           |  4 ----
arch/riscv/kernel/cpufeature.c    | 41 +++++++++++++++++++++------------------
arch/riscv/kernel/setup.c         |  9 ---------
arch/riscv/kernel/smp.c           | 10 +++++++++-
arch/riscv/kernel/smpboot.c       | 20 ++++++++++++++++---
drivers/clocksource/timer-riscv.c | 23 +++++++++++++++++++---
drivers/irqchip/irq-sifive-plic.c |  5 +++++
8 files changed, 86 insertions(+), 44 deletions(-)

--
2.7.4

