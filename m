Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4819C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E6020870
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E6020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389512AbeGJSns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:43:48 -0400
Received: from foss.arm.com ([217.140.101.70]:51806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389002AbeGJSdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:33:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D52E280D;
        Tue, 10 Jul 2018 10:17:27 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.210.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 59B3B3F589;
        Tue, 10 Jul 2018 10:17:25 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, robh+dt@kernel.org, frowand.list@gmail.com,
        gregkh@linuxfoundation.org, joro@8bytes.org, x86@kernel.org
Subject: [RFC PATCH 0/4] Stop losing firmware-set DMA masks
Date:   Tue, 10 Jul 2018 18:17:15 +0100
Message-Id: <cover.1531239284.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.17.1.dirty
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whilst the common firmware code invoked by dma_configure() initialises
devices' DMA masks according to limitations described by the respective
properties ("dma-ranges" for OF and _DMA/IORT for ACPI), the nature of
the dma_set_mask() API leads to that information getting lost when
well-behaved drivers probe and set a 64-bit mask, since in general
there's no way to tell the difference between a firmware-described mask
(which should be respected) and whatever default may have come from the
bus code (which should be replaced outright). This can break DMA on
systems with certain IOMMU topologies (e.g. [1]) where the IOMMU driver
only knows its maximum supported address size, not how many of those
address bits might actually be wired up between any of its input
interfaces and the associated DMA master devices. Similarly, some PCIe
root complexes only have a 32-bit native interface on their host bridge,
which leads to the same DMA-address-truncation problem in systems with a
larger physical memory map and RAM above 4GB (e.g. [2]).

These patches attempt to deal with this in the simplest way possible by
generalising the specific quirk for 32-bit bridges into an arbitrary
mask which can then also be plumbed into the firmware code. In the
interest of being minimally invasive, I've only included a point fix
for the IOMMU issue as seen on arm64 - there may be further tweaks
needed in DMA ops to catch all possible incarnations of this problem,
but this initial RFC is mostly about the impact beyond the dma-mapping
subsystem itself.

Robin.


[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/580804.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-December/474443.html

Robin Murphy (4):
  dma-mapping: Generalise dma_32bit_limit flag
  ACPI/IORT: Set bus DMA mask as appropriate
  of/device: Set bus DMA mask as appropriate
  iommu/dma: Respect bus DMA limit for IOVAs

 arch/x86/kernel/pci-dma.c | 2 +-
 drivers/acpi/arm64/iort.c | 1 +
 drivers/iommu/dma-iommu.c | 3 +++
 drivers/of/device.c       | 1 +
 include/linux/device.h    | 6 +++---
 kernel/dma/direct.c       | 2 +-
 6 files changed, 10 insertions(+), 5 deletions(-)

-- 
2.17.1.dirty

