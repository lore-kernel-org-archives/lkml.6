Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C6DC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F2F205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FLnLkzID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F2F205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389294AbeG0ULT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 16:11:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39895 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389048AbeG0ULS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 16:11:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id j8-v6so2022837pff.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 11:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5CIXTx7NCxUlFat9MTaYTt8/hPDWpQD7jz34bQ1ARxs=;
        b=FLnLkzID2VmHOpo/owikfxC2ygo6fajCxOLu+OO30ti3/f1P/iqXLlGHrsetJRBTuB
         5uI9xfR1Tg6NnTaX2MrSYwrx+6XfwIE26lXRaY/gZ2vYEBxu/LztLkSTewbTPtFt8VJq
         HdZ+i89BVlr9YR7rhqwmGsdL0hIAnMIHFe+BY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5CIXTx7NCxUlFat9MTaYTt8/hPDWpQD7jz34bQ1ARxs=;
        b=VEWMsCDQ2K3qxqBLigkChE2kR/5sO35X49aGy6MNYUK04HDS40SO67ajTQwysQPmq0
         c/lvTtKwZ6/lOWq3ITMnagdU8goVC2KpzOy3rjRmcVDBucyw8rPda8NYRerCtN9KnT2y
         yj0Q4i21p6qw0v7vKRkYoYVliQ6+v/L0gxruOvOt/Vw5bLdUbj+jj0bFXOwu5j5OMqcA
         nwzplamgYifK4mV3mj9ODnqkSkAVDqr0rsECCMI5YyAMlU/HmHDKj69FmlhDvAA0eOMW
         CuRjCwe99RAhw4ssby02mUh2omoG1ZMmsjA74waYhGT4VWnETTeqz6FbMXxf8HQOvCCM
         r7uw==
X-Gm-Message-State: AOUpUlEsK8bEKdQo3qPOQveZi2rGcAMZggR5W6+hrn8ZYB5uG5yCHxum
        pk6W/M3qEdosSGPDot32+Ndy
X-Google-Smtp-Source: AAOMgpcXLderDVCvNk4UTCvsvF1ThUDT8cVMtAYoyYbS6u8hGrs5FcORhc/JMPCfy69JIZgoEpg9Hg==
X-Received: by 2002:a65:5004:: with SMTP id f4-v6mr7249080pgo.54.1532717288886;
        Fri, 27 Jul 2018 11:48:08 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7308:c330:41b:cc59:b463:ec7b])
        by smtp.gmail.com with ESMTPSA id t69-v6sm13817959pfj.7.2018.07.27.11.47.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 11:48:08 -0700 (PDT)
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
Subject: [PATCH 7/9] clk: actions: Add Actions Semi Owl SoCs Reset Management Unit support
Date:   Sat, 28 Jul 2018 00:15:25 +0530
Message-Id: <20180727184527.13287-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
References: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
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
 drivers/clk/actions/owl-reset.c  | 72 ++++++++++++++++++++++++++++++++
 drivers/clk/actions/owl-reset.h  | 32 ++++++++++++++
 5 files changed, 108 insertions(+)
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
index 56f01f7774aa..4dc7f286831f 100644
--- a/drivers/clk/actions/owl-common.h
+++ b/drivers/clk/actions/owl-common.h
@@ -26,6 +26,8 @@ struct owl_clk_desc {
 	struct owl_clk_common		**clks;
 	unsigned long			num_clks;
 	struct clk_hw_onecell_data	*hw_clks;
+	struct owl_reset_map		*resets;
+	unsigned long			num_resets;
 	struct regmap			*regmap;
 };
 
diff --git a/drivers/clk/actions/owl-reset.c b/drivers/clk/actions/owl-reset.c
new file mode 100644
index 000000000000..91b161cc68de
--- /dev/null
+++ b/drivers/clk/actions/owl-reset.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// Actions Semi Owl SoCs Reset Management Unit driver
+//
+// Copyright (c) 2018 Linaro Ltd.
+// Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+#include <linux/delay.h>
+#include <linux/io.h>
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
+	u32 reg;
+
+	regmap_read(reset->regmap, map->reg, &reg);
+	regmap_write(reset->regmap, map->reg, reg & ~map->bit);
+
+	return 0;
+}
+
+static int owl_reset_deassert(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	struct owl_reset *reset = to_owl_reset(rcdev);
+	const struct owl_reset_map *map = &reset->reset_map[id];
+	u32 reg;
+
+	regmap_read(reset->regmap, map->reg, &reg);
+	regmap_write(reset->regmap, map->reg, reg | map->bit);
+
+	return 0;
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
+
+	regmap_read(reset->regmap, map->reg, &reg);
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
index 000000000000..1a5e987ba99b
--- /dev/null
+++ b/drivers/clk/actions/owl-reset.h
@@ -0,0 +1,32 @@
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
+#include <linux/spinlock.h>
+
+struct owl_reset_map {
+	u16	reg;
+	u32	bit;
+};
+
+struct owl_reset {
+	struct reset_controller_dev	rcdev;
+	struct owl_reset_map		*reset_map;
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

