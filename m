Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8393ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822D02087A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 822D02087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391403AbeIVBum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 21:50:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41254 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390726AbeIVBum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 21:50:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E27D218A;
        Fri, 21 Sep 2018 13:00:17 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 961EF3F5BD;
        Fri, 21 Sep 2018 13:00:17 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH 00/10] GICv3 support for kexec/kdump on EFI systems
Date:   Fri, 21 Sep 2018 20:59:44 +0100
Message-Id: <20180921195954.21574-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GICv3 architecture has the remarkable feature that once LPI tables
have been assigned to redistributors and that LPI delivery is enabled,
there is no guarantee that LPIs can be turned off (and most
implementations do not allow it), nor can it be reprogrammed to use
other tables.

This is a bit of a problem for kexec, where the secondary kernel
completely looses track of the previous allocations. If the secondary
kernel doesn't allocate the tables exactly the same way, no LPIs will
be delivered by the GIC (which continues to use the old tables), and
memory previously allocated for the pending tables will be slowly
corrupted, one bit at a time.

The workaround for this is based on a series[1] by Ard Biesheuvel,
which adds the required infrastructure for memory reservations to be
passed from one kernel to another using an EFI table.

This infrastructure is then used to register the allocation of GIC
tables with EFI, and allow the GIC driver to safely reuse the existing
programming if it detects that the tables have been correctly
registered. On non-EFI systems, there is not much we can do.

This has been tested on a TX2 system both as a host and a guest. I'd
welcome additional testing of different HW. For convenience, I've
stashed a branch containing the whole thing at [2].

[1] https://marc.info/?l=linux-efi&m=153754757208163&w=2
[2] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/gicv3-kdump

Marc Zyngier (10):
  irqchip/gic-v3-its: Change initialization ordering for LPIs
  irqchip/gic-v3-its: Consolidate LPI_PENDBASE_SZ usage
  irqchip/gic-v3-its: Split property table clearing from allocation
  irqchip/gic-v3-its: Move pending table allocation to init time
  irqchip/gic-v3-its: Keep track of property table's PA and VA
  irqchip/gic-v3-its: Allow use of pre-programmed LPI tables
  irqchip/gic-v3-its: Use pre-programmed redistributor tables with kdump
    kernels
  irqchip/gic-v3-its: Check that all RDs have the same property table
  irqchip/gic-v3-its: Register LPI tables with EFI config table
  irqchip/gic-v3-its: Allow use of LPI tables in reserved memory

 drivers/irqchip/irq-gic-v3-its.c   | 249 ++++++++++++++++++++++-------
 drivers/irqchip/irq-gic-v3.c       |  20 ++-
 include/linux/irqchip/arm-gic-v3.h |   4 +-
 3 files changed, 208 insertions(+), 65 deletions(-)

-- 
2.18.0

