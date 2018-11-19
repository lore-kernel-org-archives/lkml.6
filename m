Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B99C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4AB206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CddQCmjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4AB206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407167AbeKTDft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:35:49 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45352 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405982AbeKTDfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:35:48 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so14099129pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 09:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lovS/nwfxXz2YQe0/HUnsKL9fcLTGfnOgEY8rFfiAyU=;
        b=CddQCmjcYAEaTSt498fRfW4QuqE5SMdherwu6BY/7EDDv0VSDQ9/LFXfnRby/YcqFs
         VLUMEtKHQv3+nbARCSpN68eXQKRN/O0Fsd2QXHuPAHbmmYesAnCKmNWr4+Wzc7bdYtVs
         FMWYNp7GKqEF+caL+ZtcQF407J3d9ntN+K9ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lovS/nwfxXz2YQe0/HUnsKL9fcLTGfnOgEY8rFfiAyU=;
        b=Go28RQEsL85AbMYWK3C4vqaVcr9QCNWHghFoGMeYcT4LfSeRrHdfIkV7vafGIhVq3j
         YCd9OH0mE6E7YckCLcwD9d05H4gI+h5xQUMEPl/e5+qqKWDekj6nkyaQV3Uv0N7JkEen
         opBjG9443pSt3tPgcP+4gVMFLuKkxi1wwD623pPpVKzw1ZFvF0jAohgQ0wqRJdDQcX7s
         xhBubh67C86aFQF/Tb3lYsha793RifUDKpYwXx9qxiC6XqqBBvDxIBXKniagqZpoOsuE
         zVWrfbUd+qhpyGT8pv0YhiC9Hi4meqyclXfxbSKKvPG2K30MKUQZ/EiRuiSZU/gXEsAN
         wM8g==
X-Gm-Message-State: AGRZ1gKrq43XN6KVYJl4HFVSu5MlwoGqPyshHRmrstAVWNww5BXsglSg
        zfuf2d6qQAs8omjm1aa44DrG
X-Google-Smtp-Source: AJdET5fgBhwcR8YQuSASyKwl4zwuC089789aAuuJwH65n7CQ4LuKCcNpDddiC/MKYqaFLZuIwdhtOg==
X-Received: by 2002:a62:e30d:: with SMTP id g13mr12105001pfh.151.1542647489171;
        Mon, 19 Nov 2018 09:11:29 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:631b:44eb:3905:6402:e2fb:2d7])
        by smtp.gmail.com with ESMTPSA id 186-v6sm46175458pfe.39.2018.11.19.09.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 09:11:28 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        service@rdamicro.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH 05/16] arm: dts: Add devicetree for OrangePi 2G IoT board
Date:   Mon, 19 Nov 2018 22:39:28 +0530
Message-Id: <20181119170939.19153-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
References: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial devicetree support for OrangePi 2G IoT board from Xunlong.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/Makefile                    |  2 ++
 .../boot/dts/rda8810pl-orangepi-2g-iot.dts    | 35 +++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 arch/arm/boot/dts/rda8810pl-orangepi-2g-iot.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b0e966d625b9..a0fdad8f10dd 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -806,6 +806,8 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-msm8974-sony-xperia-castor.dtb \
 	qcom-msm8974-sony-xperia-honami.dtb \
 	qcom-mdm9615-wp8548-mangoh-green.dtb
+dtb-$(CONFIG_ARCH_RDA) += \
+	rda8810pl-orangepi-2g-iot.dtb
 dtb-$(CONFIG_ARCH_REALVIEW) += \
 	arm-realview-pb1176.dtb \
 	arm-realview-pb11mp.dtb \
diff --git a/arch/arm/boot/dts/rda8810pl-orangepi-2g-iot.dts b/arch/arm/boot/dts/rda8810pl-orangepi-2g-iot.dts
new file mode 100644
index 000000000000..4b49a7424b6a
--- /dev/null
+++ b/arch/arm/boot/dts/rda8810pl-orangepi-2g-iot.dts
@@ -0,0 +1,35 @@
+/*
+ * Copyright (c) 2017 Andreas Färber
+ * Copyright (c) 2018 Manivannan Sadhasivam
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+/dts-v1/;
+
+#include "rda8810pl.dtsi"
+
+/ {
+	compatible = "xunlong,orangepi-2g-iot", "rda,8810pl";
+	model = "Orange Pi 2G-IoT";
+
+	chosen {
+		stdout-path = "serial2:921600n8";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x10000000>;
+	};
+
+	uart2_clk: uart2-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <921600>;
+		#clock-cells = <0>;
+	};
+};
+
+&uart2 {
+	status = "okay";
+	clocks = <&uart2_clk>;
+};
-- 
2.17.1

