Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CADCC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A2D20869
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732069AbfAaOyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:54:18 -0500
Received: from foss.arm.com ([217.140.101.70]:45280 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732001AbfAaOyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 09:54:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AED880D;
        Thu, 31 Jan 2019 06:54:17 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3D98B3F59C;
        Thu, 31 Jan 2019 06:54:16 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, marc.zyngier@arm.com,
        mingo@kernel.org, Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v6 0/4] Provide core API for NMIs
Date:   Thu, 31 Jan 2019 14:53:57 +0000
Message-Id: <1548946441-38546-1-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series provides a way for irqchips to define some IRQs as NMIs.

Updating this series as it is needed for the arm64 pseudo-NMI which we
are considering to merge (I'll post a new version shortly).

Changes since v5[1]:
- Added Marc's Acked-by, Reviewed-by tags
- Fixed locking bug in ready_percpu_nmi()
- Renamed ready_percpu_nmi() to prepare_percpu_nmi()
- Added documentation prepare_percpu_nmi() and teardown_percpu_nmi()

Changes since v4[2]:
- Rebased on v5.0-rc4
- Modified comment for request_percpu_nmi() to detail
  the use of per CPU NMIs a bit more

Changes since v3[3]:
- Rebased on v4.20-rc2

Changes since v2[4]:
- Fix ARM build error reported by kbuild bot
- Fix documentation warnings reported by kbuild bot

Changes since v1[5]:
- Rebased to v4.19-rc1
- Fix some coding style issues

Changes since RFC[6]:
- Rebased to v4.18-rc6
- Remove disable_nmi, one should call disable_nmi_nosync instead
- Remove code related to affinity balancing from NMI functions
- Require PERCPU configuration for NMIs

[1] https://lkml.org/lkml/2019/1/28/541
[2] https://lkml.org/lkml/2018/11/12/2113
[3] https://lkml.org/lkml/2018/8/31/173
[4] https://lkml.org/lkml/2018/8/28/661
[5] https://lkml.org/lkml/2018/7/24/321
[6] https://lkml.org/lkml/2018/7/9/768

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
 include/linux/irqdesc.h   |   5 +
 kernel/irq/chip.c         |  54 +++++++
 kernel/irq/debugfs.c      |   6 +-
 kernel/irq/internals.h    |   2 +
 kernel/irq/irqdesc.c      |  35 ++++
 kernel/irq/manage.c       | 405 +++++++++++++++++++++++++++++++++++++++++++++-
 8 files changed, 532 insertions(+), 3 deletions(-)

--
1.9.1
