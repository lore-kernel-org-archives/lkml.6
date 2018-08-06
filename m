Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A02C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88031219EA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88031219EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeHFLFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:05:02 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34728 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbeHFLFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:05:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A6C07A9;
        Mon,  6 Aug 2018 01:56:59 -0700 (PDT)
Received: from approximate.Emea.Arm.com (approximate.emea.arm.com [10.4.13.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E7943F5D0;
        Mon,  6 Aug 2018 01:56:58 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [GIT PULL] irqchip updates for 4.19
Date:   Mon,  6 Aug 2018 09:56:39 +0100
Message-Id: <20180806085639.17510-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

The 4.19 PR is more of a GICv3 special than an actual irqchip PR.

It reworks the way we allocate LPIs so that it can be much more fine
grained (instead of the allocation in chunks of 32 interrupts that
we've used so far). This allows supporting system that have thousands
of devices (not kidding!), each one using a single MSI... It also helps in
situation where the hypervisor enforces a very small number of
available LPIs.

Another change is the conversion of the ITS driver to using raw
spinlocks, making it work on RT (yay!).

Please pull,

       M.

The following changes since commit 9d3cce1e8b8561fed5f383d22a4d6949db4eadbe:

  Linux 4.18-rc5 (2018-07-15 12:49:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-4.19

for you to fetch changes up to a8db74564b0c634667e1722264bde303d296f566:

  irqchip/gic-v3-its: Make its_lock a raw_spin_lock_t (2018-08-06 09:16:19 +0100)

----------------------------------------------------------------
irqchip updates for 4.19

- GICv3 ITS LPI allocation revamp
- GICv3 support for hypervisor-enforced LPI range
- GICv3 ITS conversion to raw spinlock

----------------------------------------------------------------
Marc Zyngier (7):
      irqchip/gic-v3-its: Refactor LPI allocator
      irqchip/gic-v3-its: Use full range of LPIs
      irqchip/gic-v3-its: Move minimum LPI requirements to individual busses
      irqchip/gic-v3-its: Drop chunk allocation compatibility
      irqchip/gic-v3: Expose GICD_TYPER in the rdist structure
      irqchip/gic-v3-its: Honor hypervisor enforced LPI range
      irqchip/gic-v3-its: Reduce minimum LPI allocation to 1 for PCI devices

Sebastian Andrzej Siewior (1):
      irqchip/gic-v3-its: Make its_lock a raw_spin_lock_t

 drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c   |   3 +
 drivers/irqchip/irq-gic-v3-its-pci-msi.c      |  16 +-
 drivers/irqchip/irq-gic-v3-its-platform-msi.c |   2 +
 drivers/irqchip/irq-gic-v3-its.c              | 243 +++++++++++++++++---------
 drivers/irqchip/irq-gic-v3.c                  |   4 +-
 include/linux/irqchip/arm-gic-v3.h            |   3 +-
 6 files changed, 178 insertions(+), 93 deletions(-)
