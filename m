Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F46C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970D020836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970D020836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754265AbeFTNxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:53:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37424 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753651AbeFTNxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:53:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E3A780D;
        Wed, 20 Jun 2018 06:53:00 -0700 (PDT)
Received: from big-swifty.cambridge.arm.com (big-swifty.cambridge.arm.com [10.1.31.224])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E99503F578;
        Wed, 20 Jun 2018 06:52:53 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Shanker Donthineni <shankerd@codeaurora.org>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        MaJun <majun258@huawei.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Lei Zhang <zhang.lei@jp.fujitsu.com>
Subject: [PATCH 0/7] irqchip/gic-v3: LPI allocation refactoring
Date:   Wed, 20 Jun 2018 14:52:27 +0100
Message-Id: <20180620135234.32101-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GICv3 LPI allocator has served us well so far, but a number of new
use cases have recently showed up:

- A new extension to the GICv3 architecture allows a hypervisor to
  dramatically restrict the range of available LPIs. This means that
  our current policy of allocating LPIs in blocks of 32 may quickly
  deplete the number of devices that get LPIs

- New and currently undisclosed busses seem to come with thousands of
  devices, each requiring a single LPI. Again, our current allocation
  policy means they quickly run out of LPIs.

Simply expanding the bitmap doesn't seem to be a great idea, so let's
change the LPI allocator altogether. This means we can move individual
busses to a more minimal allocation scheme, though we only do it for
PCI at the moment (Platform MSI looks like the Far West, and I'm
clueless about the FSL MC thing).

This is a pretty invasive change, and I'm thus cc'ing the usual
suspects that have access to weird and wonderful HW to verify
everything still works as expected, and let me know if we can relax
the allocation for their own pet bus implementation.

Only lightly tested in a KVM guest (PCI).


Marc Zyngier (7):
  irqchip/gic-v3-its: Refactor LPI allocator
  irqchip/gic-v3-its: Use full range of LPIs
  irqchip/gic-v3-its: Move minimum LPI requirements to individual busses
  irqchip/gic-v3-its: Drop chunk allocation compatibility
  irqchip/gic-v3: Expose GICD_TYPER in the rdist structure
  irqchip/gic-v3-its: Honor hypervisor enforced LPI range
  irqchip/gic-v3-its: Reduce minimum LPI allocation to 1 for PCI devices

 drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c   |   3 +
 drivers/irqchip/irq-gic-v3-its-pci-msi.c      |  16 +-
 drivers/irqchip/irq-gic-v3-its-platform-msi.c |   2 +
 drivers/irqchip/irq-gic-v3-its.c              | 225 ++++++++++++------
 drivers/irqchip/irq-gic-v3.c                  |   4 +-
 include/linux/irqchip/arm-gic-v3.h            |   3 +-
 6 files changed, 169 insertions(+), 84 deletions(-)

-- 
2.17.1

