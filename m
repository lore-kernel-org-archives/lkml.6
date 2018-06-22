Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDD1C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C3C240DD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C3C240DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754454AbeFVLDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 07:03:13 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:38222 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbeFVLDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 07:03:10 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by baptiste.telenet-ops.be with bizsmtp
        id 1n391y00m3XaVaC01n39CX; Fri, 22 Jun 2018 13:03:09 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fWJqP-0002Kr-No; Fri, 22 Jun 2018 13:03:09 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fWJqP-0008DC-Lu; Fri, 22 Jun 2018 13:03:09 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v4] ata: Remove depends on HAS_DMA in case of platform dependency
Date:   Fri, 22 Jun 2018 13:03:07 +0200
Message-Id: <20180622110307.31523-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dependencies on HAS_DMA where a Kconfig symbol depends on another
symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".
In most cases this other symbol is an architecture or platform specific
symbol, or PCI.

Generic symbols and drivers without platform dependencies keep their
dependencies on HAS_DMA, to prevent compiling subsystems or drivers that
cannot work anyway.

This simplifies the dependencies, and allows to improve compile-testing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Acked-by: Robin Murphy <robin.murphy@arm.com>
---
v4:
  - Rebase to v4.18-rc1 (applies to next-20180622, too),

v3:
  - Rebase to v4.17-rc1,

v2:
  - Add Reviewed-by, Acked-by,
  - Drop RFC state,
  - Split per subsystem.
---
 drivers/ata/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 2b16e7c8fff35764..39b181d6bd0d8cf2 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -398,7 +398,6 @@ config SATA_DWC_VDEBUG
 
 config SATA_HIGHBANK
 	tristate "Calxeda Highbank SATA support"
-	depends on HAS_DMA
 	depends on ARCH_HIGHBANK || COMPILE_TEST
 	help
 	  This option enables support for the Calxeda Highbank SoC's
@@ -408,7 +407,6 @@ config SATA_HIGHBANK
 
 config SATA_MV
 	tristate "Marvell SATA support"
-	depends on HAS_DMA
 	depends on PCI || ARCH_DOVE || ARCH_MV78XX0 || \
 		   ARCH_MVEBU || ARCH_ORION5X || COMPILE_TEST
 	select GENERIC_PHY
-- 
2.17.1

