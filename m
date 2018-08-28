Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6DDC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBCE520867
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBCE520867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeH1TWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:22:09 -0400
Received: from foss.arm.com ([217.140.101.70]:40460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbeH1TWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:22:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9767718A;
        Tue, 28 Aug 2018 08:29:58 -0700 (PDT)
Received: from e112298-lin.Emea.Arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 650233F557;
        Tue, 28 Aug 2018 08:29:57 -0700 (PDT)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, marc.zyngier@arm.com,
        mingo@kernel.org, Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v2 0/4] Provide core API for NMIs
Date:   Tue, 28 Aug 2018 16:29:44 +0100
Message-Id: <1535470188-38155-1-git-send-email-julien.thierry@arm.com>
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

I'll soon post a series making use of the API for Arm's GICv3.

Patches 1 & 2 provide functions necessary to request and manage NMIs.
Patches 3 & 4 provide functions for NMI handling.

Changes since v1[1]:
- Rebased to v4.19-rc1
- Fix some coding style issues

Changes since RFC[2]:
- Rebased to v4.18-rc6
- Remove disable_nmi, one should call disable_nmi_nosync instead
- Remove code related to affinity balancing from NMI functions
- Require PERCPU configuration for NMIs

[1] https://lkml.org/lkml/2018/7/24/321
[2] https://lkml.org/lkml/2018/7/9/768

Cheers,

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
 kernel/irq/internals.h    |   2 +
 kernel/irq/irqdesc.c      |  33 ++++
 kernel/irq/manage.c       | 377 +++++++++++++++++++++++++++++++++++++++++++++-
 8 files changed, 500 insertions(+), 3 deletions(-)

--
1.9.1
