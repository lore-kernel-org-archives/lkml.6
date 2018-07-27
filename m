Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DFFC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D0A20671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kc7nCAeH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D0A20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389198AbeG0UK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 16:10:26 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42922 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389175AbeG0UK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 16:10:26 -0400
Received: by mail-pl0-f68.google.com with SMTP id z7-v6so2670800plo.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 11:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8mrfDo7xkeP5gS1zJZIyaAkBnN9j6DHJcwUnfsPeMO8=;
        b=kc7nCAeHKvABHKmgMRjqAo1DC1qrHpgncMLKHFbxjC9kCpQyLXm6ikTi/8rwfbfFXj
         C+FjCjUuIiWubFv8WNIt6LtU5/WmUHrnRxEUA9WDseyV6zY6c/HeOClvy6lsLGhUgysK
         JUBzfvSzX264V4++vC7l8julcBzB6qniLq9Kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8mrfDo7xkeP5gS1zJZIyaAkBnN9j6DHJcwUnfsPeMO8=;
        b=jC2up14j68o3LeJrt7tb09xBMZNkHcA94E1LRXlBuhhegwrvSJOV256Nfb0XLQnXP6
         NzzLSPeLv3+LsvZ5rY7loR/lhlgpUxl9NVQrTLJ2v55LgirB2ywnVDemTbUFOA6Zq5Ju
         P6xLww7uAOZxC5kb/NotZKWYto+rDq+kS582N7J9pKY4pGldVIrdnbvnX/8NqkNU33go
         EjVqIzM4E5t3likOoMUtVWumFaO4Wq9btXlpqUFndiCvm+s6UMqQwBRpf73idKxPnzzJ
         /tF1uPOdomKAcz6AhIZgZ8IXTkXQNL04lp1RGGvW3po6ILASm0o8qM9hbAyE/jKNa8Qt
         VbeA==
X-Gm-Message-State: AOUpUlF2LuDRg7+3EvLldOMfiE8NXym1v8/nKHw2Ut/0wggRIHlaTv2I
        FF9qcB8D6Qf84W+iYXcEcXN/
X-Google-Smtp-Source: AAOMgpeCGB4bnhLOQGdXUj7iZvZ/kO+78BVYzfvAtqkPJYtoawFg/ztcYmM0xgK9pY4Zlg34T82+ew==
X-Received: by 2002:a17:902:ab94:: with SMTP id f20-v6mr7023099plr.231.1532717236801;
        Fri, 27 Jul 2018 11:47:16 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7308:c330:41b:cc59:b463:ec7b])
        by smtp.gmail.com with ESMTPSA id t69-v6sm13817959pfj.7.2018.07.27.11.47.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 11:47:16 -0700 (PDT)
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
Subject: [PATCH 3/9] dt-bindings: reset: Add binding constants for Actions Semi S700 RMU
Date:   Sat, 28 Jul 2018 00:15:21 +0530
Message-Id: <20180727184527.13287-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
References: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding constants for Actions Semi S700 SoC Reset
Management Unit (RMU).

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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

