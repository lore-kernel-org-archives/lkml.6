Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09CFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC94213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ZzmxcNwr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfBZIZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 03:25:55 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2655 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfBZIZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 03:25:54 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c74f81b0000>; Tue, 26 Feb 2019 00:26:03 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 26 Feb 2019 00:25:54 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 26 Feb 2019 00:25:54 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 26 Feb
 2019 08:25:53 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 26 Feb 2019 08:25:53 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c74f80f0002>; Tue, 26 Feb 2019 00:25:53 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <digetx@gmail.com>, <linux@armlinux.org.uk>, <jhogan@kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v2] ARM: tegra: enforce PM requirement
Date:   Tue, 26 Feb 2019 13:55:37 +0530
Message-ID: <1551169537-17548-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551169563; bh=4fjXzXiblLcHOAHLJX6rByOtnCZ/sthi7UoOP0nqIyI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=ZzmxcNwrOqZuOB6T49WnuMMUYQagbSW9zQQnfgyc9AbKrTxkdQne5AFDWCQMAjFaz
         u5eLgOXOw0w78vwVQ0GpuX+sn9+ZcAM0sBvUXvuHLP3edin6eiLYhXRag8rcEY1+Uu
         HYBhpv+4cTO3VZdv9j8skl9ybNAxD02ba1Y9jhor0QZ0q95ehxhP9HMnDHoavTHUd8
         nnzYMJFS8/B0mBcWRHggobZJRNnzI0RcG4OY/+udRnviZGBPwV1JdFe8ahWPe4JwnU
         25F7dbvkpGTZZ12dq/Ravm10TN1L5JwNcjsO4D/wbmLXdcuFXbHNN44U4CCNPSbsXi
         5FuDDNdgoAnzA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The requirement for this came while adding runtime PM support for HDA
driver. There were concerns about driver explicitly handling !PM case.
In general, drivers need to handle !PM case with work arounds for
managing clocks and power explicitly, which is not really necessary
when PM support on tegra is in good shape. In fact ARM 64-bit Tegra
platforms enforce PM support and there is no reason why this cannot be
done for 32-bit.

More details with regards to above can be found in following patch,
http://patchwork.ozlabs.org/patch/1036645/

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

