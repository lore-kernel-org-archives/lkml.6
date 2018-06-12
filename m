Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 603A5C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A61B2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TNCzBA9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A61B2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933392AbeFLKzz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 06:55:55 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38029 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933277AbeFLKzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 06:55:52 -0400
Received: by mail-lf0-f65.google.com with SMTP id i83-v6so35293125lfh.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 03:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ZU3YeEU8NY37ah8kUZqdRgYcmcdIceilqJcD26/ugtA=;
        b=TNCzBA9nlVNF9zMGGflcePqzSP0AuUh5G5L6KQ11c4UonGfOQKgdcA1i4EKZDqOtNt
         jpLKEmGCXuBsJl/Z8Ut+mNU6BhTPmUDsQl8SGmRKge+8RupkVyglgHPNybmYoIGnH4kt
         xzdF/TeGj+zCjSiBC2RDNA0uY8kB4VuyLvvY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ZU3YeEU8NY37ah8kUZqdRgYcmcdIceilqJcD26/ugtA=;
        b=lfKhn8hUgO37UEshmq2dnbMNJ8F2NudoojgnDPy5/Zu/yP5bKUBljI9yLLDv5qxaEh
         97LZx2ayAYhSyQra2D4eYBcK4j1/o1WlPFhQ6wnM0SFrN77JWW7OzJCmDw631fJ2xqjp
         gWya6UW2B2meArmvFHJUpzt24v1OilBCD7YdqzLI5fH8DjqZ9ziwo+t3x4kRfW3mJWql
         dYuMNKHG/Bs88q+hVQg/lsUXcA0H89k7mk2VJn+Jjz0N+3JDiUbO/sBfwxm3F++tvQAe
         MKbHzj+KdjVSG/iDl/WlOaKB+94ooGN4uBLEvp0lziPifHPaK7Qvwe+70bQCojzjvRPC
         P5iA==
X-Gm-Message-State: APt69E0R5nc0rYisTu4dIpfvNk0I5gdU/cN7oAMATwNxm6gQ/ZGqbAgm
        DBUriu0Esgu+N/tWxeJoIl4qFLE2GJc=
X-Google-Smtp-Source: ADUXVKLV+ScE3jlhIvSPcitHY0bQIqVRsLY8moqW2wTHHgz6O3uryuxpfuToBUe97yxcTmjQk/9cQA==
X-Received: by 2002:a2e:1d59:: with SMTP id d86-v6mr2145279ljd.104.1528800950694;
        Tue, 12 Jun 2018 03:55:50 -0700 (PDT)
Received: from localhost (85-76-96-64-nat.elisa-mobile.fi. [85.76.96.64])
        by smtp.gmail.com with ESMTPSA id o11-v6sm163996lji.0.2018.06.12.03.55.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 03:55:50 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v2 4/5] thermal: tsens: Add support for SDM845
Date:   Tue, 12 Jun 2018 13:54:56 +0300
Message-Id: <f048a97d1599a54aef3d00126a379f4e5c937057.1528799892.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1528799892.git.amit.kucheria@linaro.org>
References: <cover.1528799892.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1528799892.git.amit.kucheria@linaro.org>
References: <cover.1528799892.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDM845 uses the TSENS v2 IP block

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.txt |  1 +
 drivers/thermal/qcom/Makefile                            |  2 +-
 drivers/thermal/qcom/tsens-sdm845.c                      | 15 +++++++++++++++
 drivers/thermal/qcom/tsens.c                             |  3 +++
 drivers/thermal/qcom/tsens.h                             |  5 ++++-
 5 files changed, 24 insertions(+), 2 deletions(-)
 create mode 100644 drivers/thermal/qcom/tsens-sdm845.c

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
index 292ed89..8652499 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
@@ -5,6 +5,7 @@ Required properties:
  - "qcom,msm8916-tsens" : For 8916 Family of SoCs
  - "qcom,msm8974-tsens" : For 8974 Family of SoCs
  - "qcom,msm8996-tsens" : For 8996 Family of SoCs
+ - "qcom,sdm845-tsens"  : For SDM845 Family of SoCs
 
 - reg: Address range of the thermal registers
 - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
index 2cc2193..dc9f169 100644
--- a/drivers/thermal/qcom/Makefile
+++ b/drivers/thermal/qcom/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
-qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o tsens-8996.o
+qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o tsens-8996.o tsens-sdm845.o
diff --git a/drivers/thermal/qcom/tsens-sdm845.c b/drivers/thermal/qcom/tsens-sdm845.c
new file mode 100644
index 0000000..a647265
--- /dev/null
+++ b/drivers/thermal/qcom/tsens-sdm845.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, Linaro Limited
+ */
+
+#include "tsens.h"
+
+static const struct tsens_ops ops_sdm845 = {
+	.init		= init_common,
+	.get_temp	= get_temp_tsens_v2,
+};
+
+const struct tsens_data data_sdm845 = {
+	.ops		= &ops_sdm845,
+};
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 3f9fe6a..314a20f 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -72,6 +72,9 @@ static const struct of_device_id tsens_table[] = {
 	}, {
 		.compatible = "qcom,msm8996-tsens",
 		.data = &data_8996,
+	}, {
+		.compatible = "qcom,sdm845-tsens",
+		.data = &data_sdm845,
 	},
 	{}
 };
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 80b273d..e4c0a38 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -88,6 +88,9 @@ int init_common(struct tsens_device *);
 int get_temp_common(struct tsens_device *, int, int *);
 int get_temp_tsens_v2(struct tsens_device *, int, int *);
 
-extern const struct tsens_data data_8916, data_8974, data_8960, data_8996;
+/* TSENS v1 targets */
+extern const struct tsens_data data_8916, data_8974, data_8960;
+/* TSENS v2 targets */
+extern const struct tsens_data data_8996, data_sdm845;
 
 #endif /* __QCOM_TSENS_H__ */
-- 
2.7.4

