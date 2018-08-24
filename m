Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A37C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C69A21557
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C69A21557
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbeHXSmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:42:24 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60006 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbeHXSmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:42:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0D8EED1;
        Fri, 24 Aug 2018 08:07:20 -0700 (PDT)
Received: from approximate.Emea.Arm.com (approximate.emea.arm.com [10.4.13.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 577ED3F5BC;
        Fri, 24 Aug 2018 08:07:19 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Heiko Stuebner <heiko@sntech.de>,
        Jeffy Chen <jeffy.chen@rock-chips.com>, arm@kernel.org
Subject: [PATCH v2 0/4] iommu/rockchip: Runtime PM fixes
Date:   Fri, 24 Aug 2018 16:06:33 +0100
Message-Id: <20180824150637.15316-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small series addresses a couple of runtime PM issues I've spotted
while running 4.18 on a Chromebook Plus (kevin, rk3399) platform, and
specifically doing kexec.

In order to avoid making a complete mess of the IOMMU code, Heiko has
requested that all RK platforms would select CONFIG_PM, which
simplifies a lot of things. I've kept 32 and 64bit patches separate,
but feel free to squash them into on if that's more convenient.

Note that even with these patches, kexec is still fairly broken on
rk3399, as the VOP is never turned off (see [1] for a fix).

[1] https://www.spinics.net/lists/arm-kernel/msg670229.html

* From v1:
  - Collected RBs from Heiko
  - Added two patches forcing CONFIG_PM on all Rockchip platforms at
    Heiko's request, following the example set by Tegra platforms.

Marc Zyngier (4):
  ARM: rockchip: Force CONFIG_PM on Rockchip systems
  arm64: rockchip: Force CONFIG_PM on Rockchip systems
  iommu/rockchip: Handle errors returned from PM framework
  iommu/rockchip: Move irq request past pm_runtime_enable

 arch/arm/mach-rockchip/Kconfig |  1 +
 arch/arm64/Kconfig.platforms   |  1 +
 drivers/iommu/rockchip-iommu.c | 45 +++++++++++++++++++++-------------
 3 files changed, 30 insertions(+), 17 deletions(-)

-- 
2.18.0

