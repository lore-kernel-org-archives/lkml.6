Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E433BFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41AB20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A41AB20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeG3Jpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:45:33 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55900 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbeG3Jpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:45:30 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 4139E27E071
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@linux.ie>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Derek Basehore <dbasehore@chromium.org>,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, Lin Huang <hl@rock-chips.com>,
        kernel@collabora.com, robin.murphy@arm.com,
        Sean Paul <seanpaul@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/8] devfreq: rockchip-dfi: Move GRF definitions to a common place.
Date:   Mon, 30 Jul 2018 10:11:17 +0200
Message-Id: <20180730081124.30698-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180730081124.30698-1-enric.balletbo@collabora.com>
References: <20180730081124.30698-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some rk3399 GRF (Generic Register Files) definitions can be used for
different drivers. Move these definitions to a common include so we
don't need to duplicate these definitions.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v1:
- [RFC 1/10] Add Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
- [RFC 1/10] s/Generic/General/ (Robin Murphy)
- [RFC 4/10] Removed from the series. I did not found a use case where not holding the mutex causes the issue.
- [RFC 7/10] Removed from the series. I did not found a use case where this matters.

 drivers/devfreq/event/rockchip-dfi.c | 23 +++++++----------------
 include/soc/rockchip/rk3399_grf.h    | 21 +++++++++++++++++++++
 2 files changed, 28 insertions(+), 16 deletions(-)
 create mode 100644 include/soc/rockchip/rk3399_grf.h

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 22b113363ffc..2fbbcbeb644f 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -26,6 +26,8 @@
 #include <linux/list.h>
 #include <linux/of.h>
 
+#include <soc/rockchip/rk3399_grf.h>
+
 #define RK3399_DMC_NUM_CH	2
 
 /* DDRMON_CTRL */
@@ -43,18 +45,6 @@
 #define DDRMON_CH1_COUNT_NUM		0x3c
 #define DDRMON_CH1_DFI_ACCESS_NUM	0x40
 
-/* pmu grf */
-#define PMUGRF_OS_REG2	0x308
-#define DDRTYPE_SHIFT	13
-#define DDRTYPE_MASK	7
-
-enum {
-	DDR3 = 3,
-	LPDDR3 = 6,
-	LPDDR4 = 7,
-	UNUSED = 0xFF
-};
-
 struct dmc_usage {
 	u32 access;
 	u32 total;
@@ -83,16 +73,17 @@ static void rockchip_dfi_start_hardware_counter(struct devfreq_event_dev *edev)
 	u32 ddr_type;
 
 	/* get ddr type */
-	regmap_read(info->regmap_pmu, PMUGRF_OS_REG2, &val);
-	ddr_type = (val >> DDRTYPE_SHIFT) & DDRTYPE_MASK;
+	regmap_read(info->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
+	ddr_type = (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
+		    RK3399_PMUGRF_DDRTYPE_MASK;
 
 	/* clear DDRMON_CTRL setting */
 	writel_relaxed(CLR_DDRMON_CTRL, dfi_regs + DDRMON_CTRL);
 
 	/* set ddr type to dfi */
-	if (ddr_type == LPDDR3)
+	if (ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR3)
 		writel_relaxed(LPDDR3_EN, dfi_regs + DDRMON_CTRL);
-	else if (ddr_type == LPDDR4)
+	else if (ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR4)
 		writel_relaxed(LPDDR4_EN, dfi_regs + DDRMON_CTRL);
 
 	/* enable count, use software mode */
diff --git a/include/soc/rockchip/rk3399_grf.h b/include/soc/rockchip/rk3399_grf.h
new file mode 100644
index 000000000000..3eebabcb2812
--- /dev/null
+++ b/include/soc/rockchip/rk3399_grf.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Rockchip General Register Files definitions
+ *
+ * Copyright (c) 2018, Collabora Ltd.
+ * Author: Enric Balletbo i Serra <enric.balletbo@collabora.com>
+ */
+
+#ifndef __SOC_RK3399_GRF_H
+#define __SOC_RK3399_GRF_H
+
+/* PMU GRF Registers */
+#define RK3399_PMUGRF_OS_REG2		0x308
+#define RK3399_PMUGRF_DDRTYPE_SHIFT	13
+#define RK3399_PMUGRF_DDRTYPE_MASK	7
+#define RK3399_PMUGRF_DDRTYPE_DDR3	3
+#define RK3399_PMUGRF_DDRTYPE_LPDDR2	5
+#define RK3399_PMUGRF_DDRTYPE_LPDDR3	6
+#define RK3399_PMUGRF_DDRTYPE_LPDDR4	7
+
+#endif
-- 
2.18.0

