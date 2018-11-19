Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9373CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F0A206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F0A206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406917AbeKTDc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:32:28 -0500
Received: from foss.arm.com ([217.140.101.70]:33298 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406330AbeKTDc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:32:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A6BE80D;
        Mon, 19 Nov 2018 09:08:09 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9E20F3F5B7;
        Mon, 19 Nov 2018 09:08:07 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc:     marc.zyngier@arm.com, Christoffer.Dall@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, bigeasy@linutronix.de,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH 0/4] KVM: arm/arm64: vgic: Use raw_spinlock for locks taken in IRQ context
Date:   Mon, 19 Nov 2018 17:07:55 +0000
Message-Id: <1542647279-46609-1-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While testing KVM running on PREEMPT_RT, starting guest could simply
freeze the machine. This is because we are using spinlocks for VGIC
locks, which is invalid in the VGIC case since the locks must be take
with interrupts disabled.

The solution is to use raw_spinlock instead of spinlocks.

Replacing those locks also highlighted an issue where we attempt to
cond_resched with interrupts disabled.

Patch 1 fixes the cond_resched issue.
Patch 2-4 replace the VGIC spinlocks with raw_spinlocks

Cheers,

Julien

-->

Julien Thierry (4):
  KVM: arm/arm64: vgic: Do not cond_resched_lock() with IRQs disabled
  KVM: arm/arm64: vgic: Make vgic_irq->irq_lock a raw_spinlock
  KVM: arm/arm64: vgic: Make vgic_dist->lpi_list_lock a raw_spinlock
  KVM: arm/arm64: vgic: Make vgic_cpu->ap_list_lock a raw_spinlock

 include/kvm/arm_vgic.h           |   6 +-
 virt/kvm/arm/vgic/vgic-debug.c   |   4 +-
 virt/kvm/arm/vgic/vgic-init.c    |   8 +--
 virt/kvm/arm/vgic/vgic-its.c     |  22 +++----
 virt/kvm/arm/vgic/vgic-mmio-v2.c |  14 ++---
 virt/kvm/arm/vgic/vgic-mmio-v3.c |  12 ++--
 virt/kvm/arm/vgic/vgic-mmio.c    |  67 +++++++++-----------
 virt/kvm/arm/vgic/vgic-v2.c      |   4 +-
 virt/kvm/arm/vgic/vgic-v3.c      |   8 +--
 virt/kvm/arm/vgic/vgic.c         | 130 +++++++++++++++++++--------------------
 10 files changed, 132 insertions(+), 143 deletions(-)

--
1.9.1
