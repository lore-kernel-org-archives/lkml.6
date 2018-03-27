Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751082AbeC0FbT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 01:31:19 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42586 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750869AbeC0FbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 01:31:16 -0400
X-Google-Smtp-Source: AG47ELtXgGX8ZxW1Ib/HnVN03acXKevfEEwV8gTWMQxzW5cSRbXcjz7NBa4OGHlE+8inyRgjo1TlEg==
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v5 1/3] regulator: axp20x: add drivevbus support for axp803
Date: Tue, 27 Mar 2018 11:01:02 +0530
Message-Id: <20180327053104.3812-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like axp221, axp223, axp813 the axp803 is also supporting external
regulator to drive the  OTG VBus through N_VBUSEN PMIC pin.

Add support for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
Changes for v5:
- Collect Chen-Yu reviewed-by tag
Changes for v4:
- rebase on master
Changes for v3:
- Update drivevbus in table of regulators

 Documentation/devicetree/bindings/mfd/axp20x.txt | 3 ++-
 drivers/regulator/axp20x-regulator.c             | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
index 9455503b0299..d1762f3b30af 100644
--- a/Documentation/devicetree/bindings/mfd/axp20x.txt
+++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
@@ -43,7 +43,7 @@ Optional properties:
 			  regulator to drive the OTG VBus, rather then
 			  as an input pin which signals whether the
 			  board is driving OTG VBus or not.
-			  (axp221 / axp223 / axp813 only)
+			  (axp221 / axp223 / axp803/ axp813 only)
 
 - x-powers,master-mode: Boolean (axp806 only). Set this when the PMIC is
 			wired for master mode. The default is slave mode.
@@ -132,6 +132,7 @@ FLDO2		: LDO		: fldoin-supply		: shared supply
 LDO_IO0		: LDO		: ips-supply		: GPIO 0
 LDO_IO1		: LDO		: ips-supply		: GPIO 1
 RTC_LDO		: LDO		: ips-supply		: always on
+DRIVEVBUS	: Enable output	: drivevbus-supply	: external regulator
 
 AXP806 regulators, type, and corresponding input supply names:
 
diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 181622b2813d..91b8ff8bac15 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -721,6 +721,8 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 	case AXP803_ID:
 		regulators = axp803_regulators;
 		nregulators = AXP803_REG_ID_MAX;
+		drivevbus = of_property_read_bool(pdev->dev.parent->of_node,
+						  "x-powers,drive-vbus-en");
 		break;
 	case AXP806_ID:
 		regulators = axp806_regulators;
-- 
2.14.3
