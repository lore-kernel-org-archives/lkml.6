Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33958C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7FB0208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ry8W+mNi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7FB0208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbeHJMWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 08:22:46 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33320 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbeHJMWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 08:22:45 -0400
Received: by mail-pl0-f68.google.com with SMTP id b90-v6so3851479plb.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 02:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aSAAa+s6BC6vmUVrsIHnMhod2TH+xc3yY1ux/OMaXVk=;
        b=Ry8W+mNiPbEr7ySiW6xp3QCzonGbNdhrFXMQc9y0rPup1Kykmlv1P3eBScv/3QPzhA
         x4AXJmUbLX7XDHFGC8IfQI/y9CZSP+/ooQ4yl9c7J3qLogdn/G+UVHJUb5JB2AWmr9Pt
         TLjd+DXU/aW9g6cUjolrqn4Ne2/jxbSuwaCTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aSAAa+s6BC6vmUVrsIHnMhod2TH+xc3yY1ux/OMaXVk=;
        b=i6B1EMeAmTpJ9T+ZQcBfcWldNGpsvnk64uJQQNTccktAnkLiXTBCpj5ofTDjKLIvEZ
         9cHEq/I2PweiWzRxKzSZY3XEU5LJ/i6fwGn7sS0nd4fcwg/Cl4ju9DeABkGplZ0czAxn
         NGaAzhMqm9IoHFx8H1XwUZjWy6/CFq1LretegCf22qjg0NRcyDmU2jn53MYHJn5ybzKV
         0HWMtnopqRgchFQLj1NKsiImR7kMJd+jts1LoyCnmms1nj2kSqxo9NIa1fe4HAro8rEy
         KD5jOlviY4P5/X40WioUd5FqCoYDx7Njkl69o2/4b0OnBDPzKh8STJ5YUDuRMws5tUPm
         PbFA==
X-Gm-Message-State: AOUpUlHDvxdo/mQAQP+93J/52k1hNRfqi4grrpwePIBL0wezhfsiTLpF
        hI844WIoC2quYAORfh8Du8Rl
X-Google-Smtp-Source: AA+uWPy0hMGh1Ob0chLJ7rd4lgdz8mhvYgrD8/Oh033HBzPftskWuek34rxfn9ITXbYVu1EcI3txWA==
X-Received: by 2002:a17:902:a58b:: with SMTP id az11-v6mr5441735plb.36.1533894816716;
        Fri, 10 Aug 2018 02:53:36 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6391:e983:9562:f5f7:1a60:4363])
        by smtp.gmail.com with ESMTPSA id n83-v6sm25315120pfk.19.2018.08.10.02.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 02:53:36 -0700 (PDT)
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
Subject: [PATCH v3 7/9] clk: actions: Add Actions Semi Owl SoCs Reset Management Unit support
Date:   Fri, 10 Aug 2018 15:21:11 +0530
Message-Id: <20180810095113.25292-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180810095113.25292-1-manivannan.sadhasivam@linaro.org>
References: <20180810095113.25292-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Reset Management Unit (RMU) support for Actions Semi Owl SoCs.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/actions/Kconfig      |  1 +
 drivers/clk/actions/Makefile     |  1 +
 drivers/clk/actions/owl-common.h |  2 +
 drivers/clk/actions/owl-reset.c  | 66 ++++++++++++++++++++++++++++++++
 drivers/clk/actions/owl-reset.h  | 31 +++++++++++++++
 5 files changed, 101 insertions(+)
 create mode 100644 drivers/clk/actions/owl-reset.c
 create mode 100644 drivers/clk/actions/owl-reset.h

diff --git a/drivers/clk/actions/Kconfig b/drivers/clk/actions/Kconfig
index dc38c85a4833..04f0a6355726 100644
--- a/drivers/clk/actions/Kconfig
+++ b/drivers/clk/actions/Kconfig
@@ -2,6 +2,7 @@ config CLK_ACTIONS
 	bool "Clock driver for Actions Semi SoCs"
 	depends on ARCH_ACTIONS || COMPILE_TEST
 	select REGMAP_MMIO
+	select RESET_CONTROLLER
 	default ARCH_ACTIONS
 
 if CLK_ACTIONS
diff --git a/drivers/clk/actions/Makefile b/drivers/clk/actions/Makefile
index 78c17d56f991..ccfdf9781cef 100644
--- a/drivers/clk/actions/Makefile
+++ b/drivers/clk/actions/Makefile
@@ -7,6 +7,7 @@ clk-owl-y			+= owl-divider.o
 clk-owl-y			+= owl-factor.o
 clk-owl-y			+= owl-composite.o
 clk-owl-y			+= owl-pll.o
+clk-owl-y			+= owl-reset.o
 
 # SoC support
 obj-$(CONFIG_CLK_OWL_S700)	+= owl-s700.o
diff --git a/drivers/clk/actions/owl-common.h b/drivers/clk/actions/owl-common.h
index 56f01f7774aa..5a866a8b913d 100644
--- a/drivers/clk/actions/owl-common.h
+++ b/drivers/clk/actions/owl-common.h
@@ -26,6 +26,8 @@ struct owl_clk_desc {
 	struct owl_clk_common		**clks;
 	unsigned long			num_clks;
 	struct clk_hw_onecell_data	*hw_clks;
+	const struct owl_reset_map	*resets;
+	unsigned long			num_resets;
 	struct regmap			*regmap;
 };
 
diff --git a/drivers/clk/actions/owl-reset.c b/drivers/clk/actions/owl-reset.c
new file mode 100644
index 000000000000..203f8f34a8d4
--- /dev/null
+++ b/drivers/clk/actions/owl-reset.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// Actions Semi Owl SoCs Reset Management Unit driver
+//
+// Copyright (c) 2018 Linaro Ltd.
+// Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+#include <linux/delay.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+
+#include "owl-reset.h"
+
+static int owl_reset_assert(struct reset_controller_dev *rcdev,
+			    unsigned long id)
+{
+	struct owl_reset *reset = to_owl_reset(rcdev);
+	const struct owl_reset_map *map = &reset->reset_map[id];
+
+	return regmap_update_bits(reset->regmap, map->reg, map->bit, 0);
+}
+
+static int owl_reset_deassert(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	struct owl_reset *reset = to_owl_reset(rcdev);
+	const struct owl_reset_map *map = &reset->reset_map[id];
+
+	return regmap_update_bits(reset->regmap, map->reg, map->bit, map->bit);
+}
+
+static int owl_reset_reset(struct reset_controller_dev *rcdev,
+			   unsigned long id)
+{
+	owl_reset_assert(rcdev, id);
+	udelay(1);
+	owl_reset_deassert(rcdev, id);
+
+	return 0;
+}
+
+static int owl_reset_status(struct reset_controller_dev *rcdev,
+			    unsigned long id)
+{
+	struct owl_reset *reset = to_owl_reset(rcdev);
+	const struct owl_reset_map *map = &reset->reset_map[id];
+	u32 reg;
+	int ret;
+
+	ret = regmap_read(reset->regmap, map->reg, &reg);
+	if (ret)
+		return ret;
+
+	/*
+	 * The reset control API expects 0 if reset is not asserted,
+	 * which is the opposite of what our hardware uses.
+	 */
+	return !(map->bit & reg);
+}
+
+const struct reset_control_ops owl_reset_ops = {
+	.assert		= owl_reset_assert,
+	.deassert	= owl_reset_deassert,
+	.reset		= owl_reset_reset,
+	.status		= owl_reset_status,
+};
diff --git a/drivers/clk/actions/owl-reset.h b/drivers/clk/actions/owl-reset.h
new file mode 100644
index 000000000000..10f5774979a6
--- /dev/null
+++ b/drivers/clk/actions/owl-reset.h
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// Actions Semi Owl SoCs Reset Management Unit driver
+//
+// Copyright (c) 2018 Linaro Ltd.
+// Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+#ifndef _OWL_RESET_H_
+#define _OWL_RESET_H_
+
+#include <linux/reset-controller.h>
+
+struct owl_reset_map {
+	u32	reg;
+	u32	bit;
+};
+
+struct owl_reset {
+	struct reset_controller_dev	rcdev;
+	const struct owl_reset_map	*reset_map;
+	struct regmap			*regmap;
+};
+
+static inline struct owl_reset *to_owl_reset(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct owl_reset, rcdev);
+}
+
+extern const struct reset_control_ops owl_reset_ops;
+
+#endif /* _OWL_RESET_H_ */
-- 
2.17.1

