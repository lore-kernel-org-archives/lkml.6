Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF97C63684
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD988204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dYVeaEjH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD988204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbeIMXRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 19:17:05 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40446 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbeIMXRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 19:17:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id s13-v6so3024439pfi.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 11:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mcD3Gsw2jnJovjOLBdoMu6xKaPO6ftrBI9PWwdc6lAA=;
        b=dYVeaEjHus1bM2c+C4F4blFVr+BbAzeNR6AoTfS3UuP/T5UpbNpgfy1mjWFbgSOlR6
         np+IrjZitgA0UydwXxPNXDRUYB+r3oELexUMaAq2RCiBYzDHa2adEjMuyFJsPmGU5GFY
         hLoDgXdXZyht9kpzdcSJ1kW9outArXsHq16L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mcD3Gsw2jnJovjOLBdoMu6xKaPO6ftrBI9PWwdc6lAA=;
        b=HbMg/xFQJe/42UZztRZIXb5Sd/EvZQLuBx7qDpXnqrulyEkOoHrbNDJa+SgosIwBiv
         UigLZo/MkwHlHy0+7bhndKgERWeu9ZyJhT18nwrpo221hr8g3O28WAwv8norQ2pAvq+h
         scv/CWgqhpHj2YwSaZqqzYZloM54HU0fXW0SF6087E5vySH365N31KyAp7DWGig+nVcd
         aaL816BACrL20MeeP3XQdI/96yBO2WXz/QVKgr6X4kLSp9wmm6QuIjkJF733oVPQcMRy
         tt8CGDE+gXmN88fSXqZQDfONQge/c3ivDhQRFpgoR6GAaqG3z0veZhXt1ivXXch9B/8w
         Sm8w==
X-Gm-Message-State: APzg51CxOX2irBykZD54uvJiifZS/wPJNoOyX/8indz6VCzsvFWHI20m
        hl4l1rfGJoyxgDVF05xYU7sy
X-Google-Smtp-Source: ANB0VdZ6weEzKkqIWO0nTXeAORTY9GcBRDGKXVUoP/6z/F5zTlgevbQ7osZJhtvGASsP9yCqTE/I7A==
X-Received: by 2002:a65:608b:: with SMTP id t11-v6mr8257556pgu.259.1536861988847;
        Thu, 13 Sep 2018 11:06:28 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6115:a36e:955b:f94d:4607:e9b9])
        by smtp.gmail.com with ESMTPSA id u184-v6sm8856802pgd.46.2018.09.13.11.06.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 11:06:28 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     heiko@sntech.de, robh+dt@kernel.org
Cc:     vicencb@gmail.com, shawn.lin@rock-chips.com,
        ezequiel@collabora.com, enric.balletbo@collabora.com,
        pbrobinson@gmail.com, tom@vamrs.com, dev@vamrs.com,
        stephen@vamrs.com, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 3/4] arm64: boot: dts: rockchip: Add support for Rock960 board
Date:   Thu, 13 Sep 2018 23:35:44 +0530
Message-Id: <20180913180545.29756-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180913180545.29756-1-manivannan.sadhasivam@linaro.org>
References: <20180913180545.29756-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree support for Rock960 board, one of the Consumer Edition
boards of the 96Boards family. This board support utilizes the common
Rock960 family board support that includes Ficus 96Board.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../boot/dts/rockchip/rk3399-rock960.dts      | 52 +++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock960.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index b0092d95b574..57c0d76458e6 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -14,5 +14,6 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-firefly.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-bob.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-kevin.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock960.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
new file mode 100644
index 000000000000..3c3308daec98
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2018 Linaro Ltd.
+ */
+
+/dts-v1/;
+#include "rk3399-rock960.dtsi"
+
+/ {
+	model = "96boards Rock960";
+	compatible = "vamrs,rock960", "rockchip,rk3399";
+
+	chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+};
+
+&pcie0 {
+	ep-gpios = <&gpio2 RK_PA2 GPIO_ACTIVE_HIGH>;
+};
+
+&pinctrl {
+	pcie {
+		pcie_drv: pcie-drv {
+			rockchip,pins =
+				<2 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
+			};
+	};
+
+	usb2 {
+		host_vbus_drv: host-vbus-drv {
+			rockchip,pins =
+				<4 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&usbdrd_dwc3_0 {
+	dr_mode = "otg";
+};
+
+&usbdrd_dwc3_1 {
+	dr_mode = "host";
+};
+
+&vcc3v3_pcie {
+	gpio = <&gpio2 5 GPIO_ACTIVE_HIGH>;
+};
+
+&vcc5v0_host {
+	gpio = <&gpio4 25 GPIO_ACTIVE_HIGH>;
+};
-- 
2.17.1

