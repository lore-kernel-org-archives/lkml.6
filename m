Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC01EC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797A320870
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2ZdXCkoR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797A320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730783AbeJYWwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:52:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730693AbeJYWwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:52:51 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7564520848;
        Thu, 25 Oct 2018 14:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477193;
        bh=qeSyqK9kOo6RwS1oWgbvIqfnP7l8awFQsKKeur+nY1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2ZdXCkoRKg+tvULHjXAn2/caWealFwVxtAz3lUOquYHittVhfil/iUsmbY+nbxve0
         GLAm6/oU0tcdegHHklIjRLK8GYo9b5UW0OTNEKJIooTOathRCF3bCG/QSJiE9SHSHR
         U/pxV4goc3JXxvor+akwqeBHCZXBtell4kRteGIM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wenyou Yang <wenyou.yang@atmel.com>,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 40/98] ARM: at91: board-dt-sama5: add phy_fixup to override NAND_Tree
Date:   Thu, 25 Oct 2018 10:17:55 -0400
Message-Id: <20181025141853.214051-40-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenyou Yang <wenyou.yang@atmel.com>

[ Upstream commit b8659752c37ec157ee254cff443b1c9d523aea22 ]

Appearance: On some SAMA5D4EK boards, after power up, the Eth1 doesn't work.

Reason: The PIOE2 pin is connected to the NAND_Tree# of KSZ8081,
But it outputs LOW during the reset period, which cause the NAND_Tree# enabled.

Add phy_fixup() to disable NAND_Tree by overriding the Operation
Mode Strap Override register(i.e. Register 16h) to clear the NAND_Tree bit.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-at91/board-dt-sama5.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/mach-at91/board-dt-sama5.c b/arch/arm/mach-at91/board-dt-sama5.c
index 129e2917506b..5e4cedfa5c51 100644
--- a/arch/arm/mach-at91/board-dt-sama5.c
+++ b/arch/arm/mach-at91/board-dt-sama5.c
@@ -17,6 +17,7 @@
 #include <linux/of_platform.h>
 #include <linux/phy.h>
 #include <linux/clk-provider.h>
+#include <linux/phy.h>
 
 #include <asm/setup.h>
 #include <asm/irq.h>
@@ -27,8 +28,25 @@
 #include "at91_aic.h"
 #include "generic.h"
 
+static int ksz8081_phy_fixup(struct phy_device *phy)
+{
+	int value;
+
+	value = phy_read(phy, 0x16);
+	value &= ~0x20;
+	phy_write(phy, 0x16, value);
+
+	return 0;
+}
+
 static void __init sama5_dt_device_init(void)
 {
+	if (of_machine_is_compatible("atmel,sama5d4ek") &&
+	   IS_ENABLED(CONFIG_PHYLIB)) {
+		phy_register_fixup_for_id("fc028000.etherne:00",
+						ksz8081_phy_fixup);
+	}
+
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-- 
2.17.1

