Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504ACC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07BD6223EA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gx/ZiKv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07BD6223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeHJMV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 08:21:58 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34757 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbeHJMV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 08:21:57 -0400
Received: by mail-pl0-f68.google.com with SMTP id f6-v6so3848315plo.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 02:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NS8UBL4W/CarR63b2sZoTAS5k7ni5obK/2A4TXpVF1Q=;
        b=Gx/ZiKv2inFXe0wTJnychBnLtRNT01PImry3eVPP/+45vTNgHgmtA199x5fiLUrzzz
         i+9icVR+oT3dvMoWKtA8cZnbRA3793spjQx7LMD64AJbMyfN97otwIxti1q4HvJGKY09
         0D45s2o/SSiZXh5DDjOP/4UmXTXlg3LD1sEq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NS8UBL4W/CarR63b2sZoTAS5k7ni5obK/2A4TXpVF1Q=;
        b=rCw+i98T/mvx32RZ31Kxe3UFxmmKQPWVLgsGKg+VhscL/PDjRzGw61EO0EQKdtQF3d
         R9yvvknyAgk1ZHcEc63gv9xMrq1sxLFOqHJp7PX8+vMwcIAbIltg2ajQmSdZAUUwpdBg
         EkenVeqtMMLY4QI5wkbpi9EuuBJZD8ok7xKyh62Z5MpzWVJellE19b3wXB97c3qfjgoW
         gj7JdwD/OCL8X1Og8DdWHG7pTdw2kXAf1Q+HvFUhT/YATEnDzsuqm8F+gD9dVUu3ZQNm
         GYCgW5KwwqV1sWo32XBqptzkcgX6JTImtGu8tZP/smb4iEHBYYO3igKmWTfwmpYS782I
         oaiw==
X-Gm-Message-State: AOUpUlEW3ZD+GDOoiWeR6Xyc9w5AEFnPBmfDhTyHV7QKkTIpPO6+e51W
        y6b+yyLh/pjONUjCPbzZTd/T
X-Google-Smtp-Source: AA+uWPxqUcRK6xfy7IXMI8d+YMxpT5wIwF5ZYq/9251fH6WhlLhxixxLnxvty/hzE5PPi1TCZnD0Ag==
X-Received: by 2002:a17:902:3204:: with SMTP id y4-v6mr5521591plb.195.1533894769320;
        Fri, 10 Aug 2018 02:52:49 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6391:e983:9562:f5f7:1a60:4363])
        by smtp.gmail.com with ESMTPSA id n83-v6sm25315120pfk.19.2018.08.10.02.52.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 02:52:48 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        afaerber@suse.de, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br, sravanhome@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 3/9] dt-bindings: reset: Add binding constants for Actions Semi S700 RMU
Date:   Fri, 10 Aug 2018 15:21:07 +0530
Message-Id: <20180810095113.25292-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180810095113.25292-1-manivannan.sadhasivam@linaro.org>
References: <20180810095113.25292-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding constants for Actions Semi S700 SoC Reset
Management Unit (RMU).

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../dt-bindings/reset/actions,s700-reset.h    | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 include/dt-bindings/reset/actions,s700-reset.h

diff --git a/include/dt-bindings/reset/actions,s700-reset.h b/include/dt-bindings/reset/actions,s700-reset.h
new file mode 100644
index 000000000000..5e3b16b8ef53
--- /dev/null
+++ b/include/dt-bindings/reset/actions,s700-reset.h
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+//
+// Device Tree binding constants for Actions Semi S700 Reset Management Unit
+//
+// Copyright (c) 2018 Linaro Ltd.
+
+#ifndef __DT_BINDINGS_ACTIONS_S700_RESET_H
+#define __DT_BINDINGS_ACTIONS_S700_RESET_H
+
+#define RESET_AUDIO				0
+#define RESET_CSI				1
+#define RESET_DE				2
+#define RESET_DSI				3
+#define RESET_GPIO				4
+#define RESET_I2C0				5
+#define RESET_I2C1				6
+#define RESET_I2C2				7
+#define RESET_I2C3				8
+#define RESET_KEY				9
+#define RESET_LCD0				10
+#define RESET_SI				11
+#define RESET_SPI0				12
+#define RESET_SPI1				13
+#define RESET_SPI2				14
+#define RESET_SPI3				15
+#define RESET_UART0				16
+#define RESET_UART1				17
+#define RESET_UART2				18
+#define RESET_UART3				19
+#define RESET_UART4				20
+#define RESET_UART5				21
+#define RESET_UART6				22
+
+#endif /* __DT_BINDINGS_ACTIONS_S700_RESET_H */
-- 
2.17.1

