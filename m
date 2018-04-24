Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756080AbeDXOg1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 10:36:27 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54452 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752276AbeDXOgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 10:36:23 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] Partitioned percpu IRQ rework
Date: Tue, 24 Apr 2018 15:36:11 +0100
Message-Id: <20180424143618.16073-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Partitioned percpu interrupts are a very niche sport, even in the ARM
world. They occur when each CPU have a private device connected to a
per-CPU interrupt, but not all the devices are the same.

The best example of this occurs on the Rockchip rk3399 SoC, where all
the CPUs have a PMU connected to the same PPI (very good), except that
because this is a big-little system, we end-up with two different PMUs
(quite bad).

We already have some code to deal with this, but it integrates badly
with the debug infrastructure, and makes assumptions about the trigger
of the source interrupt (see the use of IRQ_TYPE_NONE in the GICv3
driver).

This series provides a better integration with debugfs, and cleans up
some of the most horrible parts of this code by simply moving the
plugging of the partition to the activate callback.

This has been tested on a (specially hack-up) KVM guest.

Thanks,

	M.

Marc Zyngier (7):
  genirq/debugfs: Print percpu affinity for percpu_devid interrupts
  genirq/debugfs: Use irq_print_chip method if available
  genirq/debugfs: Allow irq domain name to be overriden
  irqchip/partition-percpu: Override domain name in debugfs
  irqchip/partition-percpu: Refactor backend method calling
  irqchip/partition-percpu: Allow chained_desc to be NULL
  irqchip/partition-percpu: Move allocation of chained interrupt to
    activate

 drivers/irqchip/irq-gic-v3.c                 |  31 ++----
 drivers/irqchip/irq-partition-percpu.c       | 147 ++++++++++++++++++---------
 include/linux/irqchip/irq-partition-percpu.h |   4 +-
 include/linux/irqdomain.h                    |   1 +
 kernel/irq/debugfs.c                         |  13 ++-
 kernel/irq/irqdomain.c                       |  14 +++
 6 files changed, 138 insertions(+), 72 deletions(-)

-- 
2.14.2
