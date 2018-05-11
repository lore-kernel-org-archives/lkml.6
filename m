Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752014AbeEKWDX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 18:03:23 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40171 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751904AbeEKWDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 18:03:06 -0400
X-Google-Smtp-Source: AB8JxZrmQn/YgpUOIU3EpCFp0jr4xo0G3byeLzfwnYHDaEPwsFGp/7jHv6DVabdGDbSbgs4ZQEaDfg==
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        Doug Berger <opendmb@gmail.com>, Justin Chen <justinpopo6@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] soc: bcm: brcmstb: Add missing DDR MEMC compatible strings
Date: Fri, 11 May 2018 15:02:42 -0700
Message-Id: <20180511220242.837-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180511220242.837-1-f.fainelli@gmail.com>
References: <20180511220242.837-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We would not be matching the following chip/compatible strings
combinations, which would lead to not setting the warm boot flag
correctly, fix that:

    7260A0/B0: brcm,brcmstb-memc-ddr-rev-b.2.1
    7255A0: brcm,brcmstb-memc-ddr-rev-b.2.3
    7278Bx: brcm,brcmstb-memc-ddr-rev-b.3.1

The B2.1 core (which is in 7260 A0 and B0) doesn't have the
SHIMPHY_ADDR_CNTL_0_DDR_PAD_CNTRL setup in the memsys init code, nor
does it have the warm boot flag re-definition on entry. Those changes
were for B2.2 and later MEMSYS cores. Fall back to the previous S2/S3
entry method for these specific chips.

Fixes: 0b741b8234c8 ("soc: bcm: brcmstb: Add support for S2/S3/S5 suspend states (ARM)")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt |  3 +++
 drivers/soc/bcm/brcmstb/pm/pm-arm.c                        | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
index fb762059e68e..104cc9b41df4 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
@@ -189,8 +189,11 @@ Power-Down (SRPD), among other things.
 
 Required properties:
 - compatible     : should contain one of these
+	"brcm,brcmstb-memc-ddr-rev-b.2.1"
 	"brcm,brcmstb-memc-ddr-rev-b.2.2"
+	"brcm,brcmstb-memc-ddr-rev-b.2.3"
 	"brcm,brcmstb-memc-ddr-rev-b.3.0"
+	"brcm,brcmstb-memc-ddr-rev-b.3.1"
 	"brcm,brcmstb-memc-ddr"
 - reg            : the MEMC DDR register range
 
diff --git a/drivers/soc/bcm/brcmstb/pm/pm-arm.c b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
index ade724677238..a5577dd5eb08 100644
--- a/drivers/soc/bcm/brcmstb/pm/pm-arm.c
+++ b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
@@ -627,14 +627,26 @@ static const struct of_device_id ddr_shimphy_dt_ids[] = {
 };
 
 static const struct of_device_id brcmstb_memc_of_match[] = {
+	{
+		.compatible = "brcm,brcmstb-memc-ddr-rev-b.2.1",
+		.data = &ddr_seq,
+	},
 	{
 		.compatible = "brcm,brcmstb-memc-ddr-rev-b.2.2",
 		.data = &ddr_seq_b22,
 	},
+	{
+		.compatible = "brcm,brcmstb-memc-ddr-rev-b.2.3",
+		.data = &ddr_seq_b22,
+	},
 	{
 		.compatible = "brcm,brcmstb-memc-ddr-rev-b.3.0",
 		.data = &ddr_seq_b22,
 	},
+	{
+		.compatible = "brcm,brcmstb-memc-ddr-rev-b.3.1",
+		.data = &ddr_seq_b22,
+	},
 	{
 		.compatible = "brcm,brcmstb-memc-ddr",
 		.data = &ddr_seq,
-- 
2.14.1
