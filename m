Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92183C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5184621525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fM7zMfKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5184621525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388563AbeIUBCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:02:35 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38500 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388353AbeIUBCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:02:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so4822251pfh.5;
        Thu, 20 Sep 2018 12:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/iOAFW9+Dl5OdOZueVtGnfdXxnYdGYFZoxabExxjVt8=;
        b=fM7zMfKGKYtUfsP2esxxZm71fp0FhykD/e9+h6L8omiW9OFEndH0/K1MnzdkLGRMXi
         5Hy3bQPUGdd+REuW31IvH1rsZe8oVLx9Dh7VFg6/+V1o07QR3LlbRxc/LV5r5btBjKqY
         TeO4fpLnwrikDSH4jS5RDoth/OAcPFaSwIIDg+0P+HfrXgNMwRdyISbxzZMn97ugi8A6
         Jg0aZaeoRN0/lVOHYh96L4lEPGaaUfMkpTC3ga1oEYK2vNDf4jvQ/F0vkuVR+t3opOVd
         7P9ign6O3sIrS1estZ2uTIrgoHJBGZvx8Wd+vB/V7T1HUumWuXQc5po6nlvcYVg9SNx3
         tp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/iOAFW9+Dl5OdOZueVtGnfdXxnYdGYFZoxabExxjVt8=;
        b=R+t3UknX79TfPfkb8MaJQ2ueEcdoV/EbzfvA0h85FhovzHckA+vi4kUWkUoFWOHly4
         ZcAXlBeDj1UAjfu/Y2cOtUbVECjDz4Ke8IK0+91RQ0lB6uYZE+3o4oIrLrBJWIKjrH8K
         DUsS1gjFQ53ZUA/VYeGxIF5a4by+kSkWI/3LjT+2tvqHRk2dPk0GXEsMXUBTJo1kmIBM
         lU/EdFmmmDR1StQ0KPjyFA7WrRb9n35L+0pEjjahPODlWzXZCOZrtWx4OcCzvPLyXOSf
         EDudLoorxieZI0IhiySOsV4hlnju/snxgmgdZ1jIvMrMjWUUM7RhVG92zxyOvoaDoZvo
         ORtQ==
X-Gm-Message-State: APzg51D4PyvbGMIDM0sr3mF91KhltpFUQOOQ9oP1X6Beoyvb59NyhXYl
        HElQfNv3k2HgagIWXi3LPzsQcIC3
X-Google-Smtp-Source: ANB0VdalciGYXhF8pNhza9yFrNe1KfxvOjGmdHMCqWPb3XDW3iWY7bK42XqAkCXdqC1DHZZJQMs3hQ==
X-Received: by 2002:a62:e412:: with SMTP id r18-v6mr42814136pfh.25.1537471055274;
        Thu, 20 Sep 2018 12:17:35 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id n9-v6sm40665601pfg.21.2018.09.20.12.17.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 12:17:34 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Al Cooper <alcooperx@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>, Tejun Heo <tj@kernel.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 8/9] ARM: dts: BCM63xx: enable SATA PHY and AHCI controller
Date:   Thu, 20 Sep 2018 12:16:45 -0700
Message-Id: <20180920191646.18198-12-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920191646.18198-1-f.fainelli@gmail.com>
References: <20180920191646.18198-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Device Tree entries for the Broadcom AHCI and SATA PHY controller
found on BCM63138 SoCs

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm63138.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/bcm63138.dtsi b/arch/arm/boot/dts/bcm63138.dtsi
index 6df61518776f..546aabc6f965 100644
--- a/arch/arm/boot/dts/bcm63138.dtsi
+++ b/arch/arm/boot/dts/bcm63138.dtsi
@@ -143,6 +143,36 @@
 			reg = <0x4800e0 0x10>;
 			#reset-cells = <2>;
 		};
+
+		ahci: sata@8000 {
+			compatible = "brcm,bcm63138-ahci", "brcm,sata3-ahci";
+			reg-names = "ahci", "top-ctrl";
+			reg = <0xa000 0x9ac>, <0x8040 0x24>;
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			resets = <&pmb0 3 1>;
+			status = "disabled";
+
+			sata0: sata-port@0 {
+				reg = <0>;
+				phys = <&sata_phy0>;
+			};
+		};
+
+		sata_phy: sata-phy@8100 {
+			compatible = "brcm,bcm63138-sata-phy", "brcm,phy-sata3";
+			reg = <0x8100 0x1e00>;
+			reg-names = "phy";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sata_phy0: sata-phy@0 {
+				reg = <0>;
+				#phy-cells = <0>;
+			};
+		};
 	};
 
 	/* Legacy UBUS base */
-- 
2.17.1

