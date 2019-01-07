Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD14C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7472089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbfAGPGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:06:33 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:32898 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729334AbfAGPGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:06:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF30180D;
        Mon,  7 Jan 2019 07:06:32 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 016303F5B7;
        Mon,  7 Jan 2019 07:06:30 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc:     marc.zyngier@arm.com, Christoffer.Dall@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, bigeasy@linutronix.de,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v3 0/3] KVM: arm/arm64: vgic: Use raw_spinlock for locks taken in IRQ context
Date:   Mon,  7 Jan 2019 15:06:14 +0000
Message-Id: <1546873577-13895-1-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While testing KVM running on PREEMPT_RT, starting guest could simply
freeze the machine. This is because we are using spinlocks for VGIC
locks, which is invalid in the VGIC case since the locks must be take
with interrupts disabled.

The solution is to use raw_spinlock instead of spinlocks.

Changes since v2[1]:
- Rebase on v5.0-rc1
- Remove first patch from series as it has been applied

Changes since v1[2]:
- Rebase on v4.20-rc4
- Add Christoffer's Acked-by
- Fix potential lock up when waiting for vcpus to halt

[1] https://lkml.org/lkml/2018/11/27/20
[2] https://lkml.org/lkml/2018/11/19/776

Cheers,

Julien

-->

Julien Thierry (3):
  KVM: arm/arm64: vgic: Make vgic_irq->irq_lock a raw_spinlock
  KVM: arm/arm64: vgic: Make vgic_dist->lpi_list_lock a raw_spinlock
  KVM: arm/arm64: vgic: Make vgic_cpu->ap_list_lock a raw_spinlock

 include/kvm/arm_vgic.h           |   6 +-
 virt/kvm/arm/vgic/vgic-debug.c   |   4 +-
 virt/kvm/arm/vgic/vgic-init.c    |   8 +--
 virt/kvm/arm/vgic/vgic-its.c     |  22 ++++----
 virt/kvm/arm/vgic/vgic-mmio-v2.c |  14 ++---
 virt/kvm/arm/vgic/vgic-mmio-v3.c |  12 ++--
 virt/kvm/arm/vgic/vgic-mmio.c    |  34 +++++------
 virt/kvm/arm/vgic/vgic-v2.c      |   4 +-
 virt/kvm/arm/vgic/vgic-v3.c      |   8 +--
 virt/kvm/arm/vgic/vgic.c         | 118 +++++++++++++++++++--------------------
 10 files changed, 115 insertions(+), 115 deletions(-)

--
1.9.1
