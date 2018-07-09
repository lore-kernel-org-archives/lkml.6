Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977D0C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5674B20873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5674B20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933292AbeGIQOX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:14:23 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34378 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932951AbeGIQOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:14:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61FA3ED1;
        Mon,  9 Jul 2018 09:14:21 -0700 (PDT)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0D2A93F589;
        Mon,  9 Jul 2018 09:14:19 -0700 (PDT)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     ricardo.neri-calderon@linux.intel.com, tglx@linutronix.de,
        marc.zyngier@arm.com, peterz@infradead.org, mingo@kernel.org,
        Julien Thierry <julien.thierry@arm.com>
Subject: [RFC PATCH 0/4] Provide core API for NMIs
Date:   Mon,  9 Jul 2018 17:14:02 +0100
Message-Id: <1531152846-19374-1-git-send-email-julien.thierry@arm.com>
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

[1] http://www.linux-arm.org/git?p=linux-jt.git;a=commitdiff;h=6401387983ce39a60a3cee12c8975dd18ac0b20e
[2] http://www.linux-arm.org/git?p=linux-jt.git;a=commitdiff;h=1e5105197ed20dc0f7061e4918e0fb6a84799908
[3] https://patchwork.kernel.org/patch/10461381/

Thanks,

Julien

-->

Julien Thierry (4):
  genirq: Provide basic NMI management for interrupt lines
  genirq: Provide NMI management for percpu_devid interrupts
  genirq: Provide NMI handlers
  irqdesc: Add domain handler for NMIs

 include/linux/interrupt.h |  19 +++
 include/linux/irq.h       |  10 ++
 include/linux/irqdesc.h   |   3 +
 kernel/irq/chip.c         |  54 +++++++
 kernel/irq/debugfs.c      |   6 +-
 kernel/irq/internals.h    |   1 +
 kernel/irq/irqdesc.c      |  33 ++++
 kernel/irq/manage.c       | 399 ++++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 523 insertions(+), 2 deletions(-)

--
1.9.1
