Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932465AbeCMRVO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:21:14 -0400
Received: from foss.arm.com ([217.140.101.70]:41976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751496AbeCMRVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:21:13 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 0/3] irqchip: GIC kexec/kdump improvement and workarounds
Date: Tue, 13 Mar 2018 17:21:00 +0000
Message-Id: <20180313172103.24281-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As kexec and kdump are getting used a bit more intensively, I've been
made aware of a number of shortcomings.

The main gripe is from folks trying to launch a kdump kernel from
within an interrupt handler. If using EOImode==1, things work as
expected. If using EOImode==0 (such as in a guest), the secondary
kernel hangs as the previous interrupt hasn't been EOI'd, and the
active priority is still set. The first two patches are addressing
this situation for both GICv2 and GICv3 by reseting the APRs to their
default value.

The last patch is introduced to workaround an annoying shortcoming on
some GICv3 implementations, where LPIs cannot be disabled once they've
been enabled. This completely kills the whole kexec story, as the
secondary kernel will not be able to configure LPIs, and may
experience random single bit corruption due to interrupts being made
pending in the now reallocated pending tables. Fun!

This is quite annoying in those (limited) situations where you'd like
Linux to act as your bootloader. For this particular use case, we
introduce a kernel command line option "irqchip.gicv3_nolpi=1", which
will force the kernel to ignore LPIs altogether, leaving them intact
to the secondary kernel to enjoy. This has proved to be quite useful
on my Chromebook.

I'd welcome any testing and reviewing. If nobody fundamentaly
disagrees with this, I plan to get it merged in 4.17.

Marc Zyngier (3):
  irqchip/gic-v2: Reset APRn registers at boot time
  irqchip/gic-v3: Reset APgRn registers at boot time
  irqchip/gic-v3: Allow LPIs to be disabled from the command line

 Documentation/admin-guide/kernel-parameters.txt |  8 +++++
 arch/arm/include/asm/arch_gicv3.h               | 41 +++++++++++++++++++------
 drivers/irqchip/irq-gic-v3.c                    | 33 +++++++++++++++++++-
 drivers/irqchip/irq-gic.c                       | 17 ++++++----
 4 files changed, 82 insertions(+), 17 deletions(-)

-- 
2.14.2
