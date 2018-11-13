Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71044C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443362245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 443362245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733172AbeKMWqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 17:46:04 -0500
Received: from gloria.sntech.de ([185.11.138.130]:54954 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733060AbeKMWqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 17:46:04 -0500
Received: from wd0155.dip.tu-dresden.de ([141.76.108.155] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gMY6s-0001Z8-Ex; Tue, 13 Nov 2018 13:48:02 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     sre@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org, heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@bq.com>
Subject: [PATCH v2] power: supply: bq24190_charger: add support for bq24196 variant
Date:   Tue, 13 Nov 2018 13:47:53 +0100
Message-Id: <20181113124753.29948-1-heiko@sntech.de>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@bq.com>

The bq24196 is another variant of the bq24190 charger ic.
Its register set is identical to the bq24192 and it even reuses
the same part number (0x5).

Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
---
This should go on top of the bq24192 support patches from Brian Masney /
Jonathan Marek [0]

[0] https://patchwork.kernel.org/patch/10663409/

changes in v2:
- add missing compatible to dt-binding

 Documentation/devicetree/bindings/power/supply/bq24190.txt | 1 +
 drivers/power/supply/bq24190_charger.c                     | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.txt b/Documentation/devicetree/bindings/power/supply/bq24190.txt
index c8ac028bd3c7..ffe2be408bb6 100644
--- a/Documentation/devicetree/bindings/power/supply/bq24190.txt
+++ b/Documentation/devicetree/bindings/power/supply/bq24190.txt
@@ -5,6 +5,7 @@ Required properties:
     * "ti,bq24190"
     * "ti,bq24192"
     * "ti,bq24192i"
+    * "ti,bq24196"
 - reg: integer, I2C address of the charger.
 - interrupts[-extended]: configuration for charger INT pin.
 
diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 4e64e6ac95c5..effa7c3c21e6 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -143,7 +143,7 @@
 #define BQ24190_REG_VPRS_PN_MASK		(BIT(5) | BIT(4) | BIT(3))
 #define BQ24190_REG_VPRS_PN_SHIFT		3
 #define BQ24190_REG_VPRS_PN_24190			0x4
-#define BQ24190_REG_VPRS_PN_24192			0x5 /* Also 24193 */
+#define BQ24190_REG_VPRS_PN_24192			0x5 /* Also 24193, 24196 */
 #define BQ24190_REG_VPRS_PN_24192I			0x3
 #define BQ24190_REG_VPRS_TS_PROFILE_MASK	BIT(2)
 #define BQ24190_REG_VPRS_TS_PROFILE_SHIFT	2
@@ -1973,6 +1973,7 @@ static const struct i2c_device_id bq24190_i2c_ids[] = {
 	{ "bq24190" },
 	{ "bq24192" },
 	{ "bq24192i" },
+	{ "bq24196" },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, bq24190_i2c_ids);
@@ -1982,6 +1983,7 @@ static const struct of_device_id bq24190_of_match[] = {
 	{ .compatible = "ti,bq24190", },
 	{ .compatible = "ti,bq24192", },
 	{ .compatible = "ti,bq24192i", },
+	{ .compatible = "ti,bq24196", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bq24190_of_match);
-- 
2.18.0

