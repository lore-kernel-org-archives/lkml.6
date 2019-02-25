Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016EFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 03:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFF52087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 03:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfBYDbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 22:31:41 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:37114 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728573AbfBYDbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 22:31:21 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 63C9F5FF38; Mon, 25 Feb 2019 11:31:16 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Quentin Schulz <quentin.schulz@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Hans de Goede <hdegoede@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2 7/9] mfd: axp20x: add USB power supply mfd cell to AXP813
Date:   Mon, 25 Feb 2019 11:31:05 +0800
Message-Id: <20190225033107.17326-8-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225033107.17326-1-wens@csie.org>
References: <20190225033107.17326-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@bootlin.com>

The AXP813 has a VBUS power input. Now that the axp20x_usb_power driver
supports this variant, we can add an mfd cell for it to use it.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
[wens@csie.org: add commit message]
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>

---

Changes since v1:
  - Made axp803_usb_power_supply_resources[] constant
  - Added Lee's acked-by
---
 drivers/mfd/axp20x.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 3c97f2c0fdfe..902f9f27e748 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -198,6 +198,12 @@ static const struct resource axp22x_usb_power_supply_resources[] = {
 	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
 };
 
+/* AXP803 and AXP813/AXP818 share the same interrupts */
+static const struct resource axp803_usb_power_supply_resources[] = {
+	DEFINE_RES_IRQ_NAMED(AXP803_IRQ_VBUS_PLUGIN, "VBUS_PLUGIN"),
+	DEFINE_RES_IRQ_NAMED(AXP803_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
+};
+
 static const struct resource axp22x_pek_resources[] = {
 	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_PEK_RIS_EDGE, "PEK_DBR"),
 	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
@@ -793,6 +799,11 @@ static const struct mfd_cell axp813_cells[] = {
 		.of_compatible	= "x-powers,axp813-ac-power-supply",
 		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
 		.resources	= axp20x_ac_power_supply_resources,
+	}, {
+		.name		= "axp20x-usb-power-supply",
+		.num_resources	= ARRAY_SIZE(axp803_usb_power_supply_resources),
+		.resources	= axp803_usb_power_supply_resources,
+		.of_compatible	= "x-powers,axp813-usb-power-supply",
 	},
 };
 
-- 
2.20.1

