Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B546ECDE4C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0B220989
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLSOUaH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0B220989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbeKIHdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:33:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:48336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727633AbeKIHdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:03 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8002D20892;
        Thu,  8 Nov 2018 21:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714136;
        bh=fTKkSa2Y3Dd387wzkKAmRy0AMtbhsHgMAc2MQgdnGJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VLSOUaH1EY6fmbZjzGdA+lFrDTJI9e1IU9Loa7tfZFuUzA+UsMagBP/AjmnYGreO3
         zUzB/8unlqCqWSMRho7WwnfsBzgRGCc0Gyhe4x5uzfyypWJuTICu8FVrHG5yue61MJ
         IbZY0C2DXUkcaakZBbZ8hNMJfFXYtKj5AjvZCUTU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenyou Yang <wenyou.yang@atmel.com>,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 069/144] ARM: at91: board-dt-sama5: add phy_fixup to override NAND_Tree
Date:   Thu,  8 Nov 2018 13:50:40 -0800
Message-Id: <20181108215059.921755883@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



