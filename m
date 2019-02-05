Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF7BC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF212077B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="gGe3KpN6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfBELRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:17:06 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8718 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfBELRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 06:17:06 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5970920000>; Tue, 05 Feb 2019 03:16:34 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 05 Feb 2019 03:17:04 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 05 Feb 2019 03:17:04 -0800
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 5 Feb
 2019 11:17:04 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 5 Feb 2019 11:17:04 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c5970ad0014>; Tue, 05 Feb 2019 03:17:03 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <linux@armlinux.org.uk>, <jhogan@kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH] ARM: tegra: enforce PM requirement
Date:   Tue, 5 Feb 2019 16:46:58 +0530
Message-ID: <1549365418-26283-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549365394; bh=upWYMJJj7VUHNj03N/Pj0XxtmbTt4ge25Lw5rdzXDSU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=gGe3KpN6AZbmVjPTksdRhpW3lBHlVaT1o9Zsw5IHx/XU7KKgV9lhpJYVjEhCM9nPI
         UDgHuE17tF8Gt+ZlsD5jFgErLC+v9U0M++WhJVGeADLxondhW8kZBBumKbzPTEL2lc
         pos2vTtcIqmX0kLSTeZfeGAv6J9VlAoIWqbc+JTsWbHcVsUYyTa6UKsp6Suq7p1NcK
         OfFQdVhs8dVvWVmXHxb8DFnmCJ1bvoziQsgfLm7S86PsHD/LGdyi/xjSYjIDI1+n9X
         GHmXrwb9UxJ7PCyo9cmtZcd9mEMCUIV2QnqEq3kNavKJnBE+1k2l8CpvFWTHZG+eO7
         +zTB6aPKU8BMw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers need to handle !PM case with work arounds for managing clocks
and power explicitly, which is not really necessary when PM support on
tegra is in good shape. In fact ARM 64-bit tegra platforms enforce PM
support and there is no reason why this cannot be done for 32-bit.

This patch selects PM unconditionally and drivers can rely on runtime
PM framework for clock and power management.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Reviewed-by: Thierry Reding <treding@nvidia.com>
Reviewed-by: Jonathan Hunter <jonathanh@nvidia.com>
---
 arch/arm/mach-tegra/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 7f3b83e..51a8fa3 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -10,6 +10,7 @@ menuconfig ARCH_TEGRA
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select PINCTRL
+	select PM
 	select PM_OPP
 	select ARCH_HAS_RESET_CONTROLLER
 	select RESET_CONTROLLER
-- 
2.7.4

