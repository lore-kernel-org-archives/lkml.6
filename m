Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2724C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 03:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F5B20840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 03:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FxmRuULI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F5B20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733078AbeHAFYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 01:24:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35936 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731454AbeHAFYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 01:24:55 -0400
Received: by mail-pf1-f194.google.com with SMTP id b11-v6so1930211pfo.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 20:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bLZERzJcsBKallzHCWYCzW5/4DVNzq1sHF/567lQEeM=;
        b=FxmRuULI6IVipPlB7j2Djl9s6LW/wW/4cHy7aQk6bmf9+BowQkdoSzT5sBbM71VFvE
         uz+lcGrShCrmh8yIP1uxRHoLMA42sM3gGpjqlmEZvzdREVC2VFBRpBZxMLq1HSYEjbjE
         /iFKynr21lQoHBZQh6VaeFjmVtSLyB01qj4hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bLZERzJcsBKallzHCWYCzW5/4DVNzq1sHF/567lQEeM=;
        b=gbYxREnF+fyCbhqpXaKUxMcFKlnIcNbZ/9Hc6CUeb1jr7wn0zCcGmiVYgX0jiAvR02
         oxRgqC/3hXbwjnd5qr5i5EHu+G7sL4I6V6mQ1aOacO9R/766uqYZx+v+uOB0ZWQ77DHl
         kRTlE9wR+ZueCun7TNKoqtFUvgTsurkGERe137q5bWWnbzhj/MqFBTsNmg5q3dkUVCuD
         fYwUtEZcNys8SlTp6p7WOBbdB/YIglqa/CztIINVzhTJlKmjFi+tsM6Bvv55D8VVW6nq
         jW4siDdeI73h5jJwlfkM8h+NDXBU9EzywWDxzowR0ScOIUMPQw4q3NEfc7uw4jl3+bK8
         /XFw==
X-Gm-Message-State: AOUpUlFP6F7Ba0CI+VVGtbgiCqGJl5ooir/Q0Bopr/lpJwYS9+2LkdQ9
        STgeHL+HOO9PDMMm2qcS/scO
X-Google-Smtp-Source: AAOMgpcDv/PHok7tDswm3voYBq/ghOFkmLF8DzYDUdh7nZ6TiVC0oHYPxYizdNCRF7EDsVG5grXQCA==
X-Received: by 2002:a63:4c21:: with SMTP id z33-v6mr22749300pga.383.1533094888018;
        Tue, 31 Jul 2018 20:41:28 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:730e:f0ae:ac4e:9cdd:28a2:4bf9])
        by smtp.gmail.com with ESMTPSA id d19-v6sm34879545pgi.50.2018.07.31.20.41.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 20:41:27 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        afaerber@suse.de, robh+dt@kernel.org, lee.jones@linaro.org,
        arnd@arndb.de
Cc:     linux-clk@vger.kernel.org, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br, sravanhome@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 09/10] reset: Add Actions Semi S700 SoC Reset Management Unit support
Date:   Wed,  1 Aug 2018 09:09:14 +0530
Message-Id: <20180801033915.15880-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801033915.15880-1-manivannan.sadhasivam@linaro.org>
References: <20180801033915.15880-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Reset Management Unit (RMU) support for Actions Semi S700 SoC
of the Owl family series. RMU belongs to the Owl SoCs system-controller
which also includes CMU (Clock Management Unit).

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/reset/reset-owl.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/reset/reset-owl.c b/drivers/reset/reset-owl.c
index c4f07691fb36..2e761c64f81b 100644
--- a/drivers/reset/reset-owl.c
+++ b/drivers/reset/reset-owl.c
@@ -12,6 +12,7 @@
 #include <linux/reset-controller.h>
 
 #include <dt-bindings/reset/actions,s900-rmu.h>
+#include <dt-bindings/reset/actions,s700-rmu.h>
 
 #define CMU_DEVRST0 0x00a8
 #define CMU_DEVRST1 0x00ac
@@ -84,11 +85,42 @@ static const struct owl_reset_map s900_resets[] = {
 	[S900_RESET_I2C3]		= { CMU_DEVRST1, BIT(19) },
 };
 
+static const struct owl_reset_map s700_resets[] = {
+	[S700_RESET_DE]      = { CMU_DEVRST0, BIT(0) },
+	[S700_RESET_LCD0]    = { CMU_DEVRST0, BIT(1) },
+	[S700_RESET_DSI]     = { CMU_DEVRST0, BIT(2) },
+	[S700_RESET_CSI]     = { CMU_DEVRST0, BIT(13) },
+	[S700_RESET_SI]      = { CMU_DEVRST0, BIT(14) },
+	[S700_RESET_I2C0]    = { CMU_DEVRST1, BIT(0) },
+	[S700_RESET_I2C1]    = { CMU_DEVRST1, BIT(1) },
+	[S700_RESET_I2C2]    = { CMU_DEVRST1, BIT(2) },
+	[S700_RESET_I2C3]    = { CMU_DEVRST1, BIT(3) },
+	[S700_RESET_SPI0]    = { CMU_DEVRST1, BIT(4) },
+	[S700_RESET_SPI1]    = { CMU_DEVRST1, BIT(5) },
+	[S700_RESET_SPI2]    = { CMU_DEVRST1, BIT(6) },
+	[S700_RESET_SPI3]    = { CMU_DEVRST1, BIT(7) },
+	[S700_RESET_UART0]   = { CMU_DEVRST1, BIT(8) },
+	[S700_RESET_UART1]   = { CMU_DEVRST1, BIT(9) },
+	[S700_RESET_UART2]   = { CMU_DEVRST1, BIT(10) },
+	[S700_RESET_UART3]   = { CMU_DEVRST1, BIT(11) },
+	[S700_RESET_UART4]   = { CMU_DEVRST1, BIT(12) },
+	[S700_RESET_UART5]   = { CMU_DEVRST1, BIT(13) },
+	[S700_RESET_UART6]   = { CMU_DEVRST1, BIT(14) },
+	[S700_RESET_KEY]     = { CMU_DEVRST1, BIT(24) },
+	[S700_RESET_GPIO]    = { CMU_DEVRST1, BIT(25) },
+	[S700_RESET_AUDIO]   = { CMU_DEVRST1, BIT(29) },
+};
+
 static const struct owl_reset_hw s900_reset_hw = {
 	.resets = s900_resets,
 	.num_resets = ARRAY_SIZE(s900_resets),
 };
 
+static const struct owl_reset_hw s700_reset_hw = {
+	.resets = s700_resets,
+	.num_resets = ARRAY_SIZE(s700_resets),
+};
+
 static inline struct owl_reset *to_owl_reset(struct reset_controller_dev *rcdev)
 {
 	return container_of(rcdev, struct owl_reset, rcdev);
@@ -179,6 +211,7 @@ static int owl_reset_probe(struct platform_device *pdev)
 
 static const struct of_device_id owl_reset_of_match[] = {
 	{ .compatible = "actions,s900-rmu", .data = &s900_reset_hw },
+	{ .compatible = "actions,s700-rmu", .data = &s700_reset_hw },
 	{ /* sentinel */ }
 };
 
-- 
2.17.1

