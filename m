Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0445C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07F32082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A07F32082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbeJDUK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:10:57 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38704 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727840AbeJDUK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:10:56 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 65443207CC; Thu,  4 Oct 2018 15:17:38 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 78D68208B5;
        Thu,  4 Oct 2018 15:17:19 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, andrew@lunn.ch,
        f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        antoine.tenart@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH v2 5/5] MIPS: mscc: add PCB120 to the ocelot fitImage
Date:   Thu,  4 Oct 2018 15:17:10 +0200
Message-Id: <20181004131710.14978-6-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181004131710.14978-1-quentin.schulz@bootlin.com>
References: <20181004131710.14978-1-quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCB120 and PCB123 are both development boards based on Microsemi Ocelot
so let's use the same fitImage for both.

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 arch/mips/generic/Kconfig                       |  6 +++---
 arch/mips/generic/Platform                      |  2 +-
 ...d-ocelot_pcb123.its.S => board-ocelot.its.S} | 17 +++++++++++++++++
 3 files changed, 21 insertions(+), 4 deletions(-)
 rename arch/mips/generic/{board-ocelot_pcb123.its.S => board-ocelot.its.S} (55%)

diff --git a/arch/mips/generic/Kconfig b/arch/mips/generic/Kconfig
index 08e33c6b2539..fd6019802657 100644
--- a/arch/mips/generic/Kconfig
+++ b/arch/mips/generic/Kconfig
@@ -65,11 +65,11 @@ config FIT_IMAGE_FDT_XILFPGA
 	  Enable this to include the FDT for the MIPSfpga platform
 	  from Imagination Technologies in the FIT kernel image.
 
-config FIT_IMAGE_FDT_OCELOT_PCB123
-	bool "Include FDT for Microsemi Ocelot PCB123"
+config FIT_IMAGE_FDT_OCELOT
+	bool "Include FDT for Microsemi Ocelot development platforms"
 	select MSCC_OCELOT
 	help
-	  Enable this to include the FDT for the Ocelot PCB123 platform
+	  Enable this to include the FDT for the Ocelot development platforms
 	  from Microsemi in the FIT kernel image.
 	  This requires u-boot on the platform.
 
diff --git a/arch/mips/generic/Platform b/arch/mips/generic/Platform
index 879cb80396c8..eaa19d189324 100644
--- a/arch/mips/generic/Platform
+++ b/arch/mips/generic/Platform
@@ -16,5 +16,5 @@ all-$(CONFIG_MIPS_GENERIC)	:= vmlinux.gz.itb
 its-y					:= vmlinux.its.S
 its-$(CONFIG_FIT_IMAGE_FDT_BOSTON)	+= board-boston.its.S
 its-$(CONFIG_FIT_IMAGE_FDT_NI169445)	+= board-ni169445.its.S
-its-$(CONFIG_FIT_IMAGE_FDT_OCELOT_PCB123) += board-ocelot_pcb123.its.S
+its-$(CONFIG_FIT_IMAGE_FDT_OCELOT)	+= board-ocelot.its.S
 its-$(CONFIG_FIT_IMAGE_FDT_XILFPGA)	+= board-xilfpga.its.S
diff --git a/arch/mips/generic/board-ocelot_pcb123.its.S b/arch/mips/generic/board-ocelot.its.S
similarity index 55%
rename from arch/mips/generic/board-ocelot_pcb123.its.S
rename to arch/mips/generic/board-ocelot.its.S
index 5a7d5e1c878a..3da23988149a 100644
--- a/arch/mips/generic/board-ocelot_pcb123.its.S
+++ b/arch/mips/generic/board-ocelot.its.S
@@ -11,6 +11,17 @@
 				algo = "sha1";
 			};
 		};
+
+		fdt@ocelot_pcb120 {
+			description = "MSCC Ocelot PCB120 Device Tree";
+			data = /incbin/("boot/dts/mscc/ocelot_pcb120.dtb");
+			type = "flat_dt";
+			arch = "mips";
+			compression = "none";
+			hash@0 {
+				algo = "sha1";
+			};
+		};
 	};
 
 	configurations {
@@ -19,5 +30,11 @@
 			kernel = "kernel@0";
 			fdt = "fdt@ocelot_pcb123";
 		};
+
+		conf@ocelot_pcb120 {
+			description = "Ocelot Linux kernel";
+			kernel = "kernel@0";
+			fdt = "fdt@ocelot_pcb120";
+		};
 	};
 };
-- 
2.17.1

