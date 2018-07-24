Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D24ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A2F205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A2F205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388602AbeGXMNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:13:12 -0400
Received: from foss.arm.com ([217.140.101.70]:48448 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388296AbeGXMNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:13:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C80AF80D;
        Tue, 24 Jul 2018 04:07:16 -0700 (PDT)
Received: from e112298-lin.Emea.Arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7315F3F237;
        Tue, 24 Jul 2018 04:07:15 -0700 (PDT)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, marc.zyngier@arm.com,
        ricardo.neri-calderon@linux.intel.com, mingo@kernel.org,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH 0/4] Provide core API for NMIs
Date:   Tue, 24 Jul 2018 12:07:03 +0100
Message-Id: <1532430427-57151-1-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series provides a way for irqchips to define some IRQs as NMIs.

For this to be possible, the irqchip must:
- be a root irqchip
- not require bus locking
- have the NMI support flag

Once these conditions are met, interrupt lines can be requested as NMIs.
These lines must not be shared and the IRQ handling must not be threaded.
Callbacks are added to the irqchip in order to set up (clean up) the
necessary resources for NMIs before enabling (before releasing) the
corresponding interrupt line.

For reference, see the examples of the support provided by GICv3 [1] and
for the request and management of an NMI in the arm_pmu driver [2]. (These
are not on the list yet as I'd like the focus of the discussion to be on
the API for now)

This work was motivated by a discussion on Ricardo Neri's patch [3]

Patches 1 & 2 provide functions necessary to request and manage NMIs.
Patches 3 & 4 provide functions for NMI handling.

Changes since RFC[4]:
- Rebased to v4.18-rc6
- Remove disable_nmi, one should call disable_nmi_nosync instead
- Remove code related to affinity balancing from NMI functions
- Require PERCPU configuration for NMIs

[1] http://www.linux-arm.org/git?p=linux-jt.git;a=commitdiff;h=be1beaf15fe840c8a430b9a8191a5b33877f3c0f
[2] http://www.linux-arm.org/git?p=linux-jt.git;a=commitdiff;h=cc35056203445a38b1343fc23d6f3a7b2d707603
[3] https://patchwork.kernel.org/patch/10461381/
[4] https://lkml.org/lkml/2018/7/9/768

Thanks,

Julien

-->

Julien Thierry (4):
  genirq: Provide basic NMI management for interrupt lines
  genirq: Provide NMI management for percpu_devid interrupts
  genirq: Provide NMI handlers
  irqdesc: Add domain handler for NMIs

 include/linux/interrupt.h |  18 +++
 include/linux/irq.h       |  10 ++
 include/linux/irqdesc.h   |   3 +
 kernel/irq/chip.c         |  54 +++++++
 kernel/irq/debugfs.c      |   6 +-
 kernel/irq/internals.h    |   1 +
 kernel/irq/irqdesc.c      |  33 ++++
 kernel/irq/manage.c       | 377 +++++++++++++++++++++++++++++++++++++++++++++-
 8 files changed, 499 insertions(+), 3 deletions(-)

--
1.9.1
