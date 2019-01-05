Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D44DC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3A7218DE
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfAERtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 12:49:09 -0500
Received: from kozue.soulik.info ([108.61.200.231]:40184 "EHLO
        kozue.soulik.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbfAERtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 12:49:05 -0500
Received: from misaki.sumomo.pri (unknown [IPv6:2001:470:b30d:2:c604:15ff:0:a00])
        by kozue.soulik.info (Postfix) with ESMTPA id F0844101811;
        Sun,  6 Jan 2019 02:49:41 +0900 (JST)
From:   Randy Li <ayaka@soulik.info>
To:     linux-rockchip@lists.infradead.org
Cc:     Randy Li <ayaka@soulik.info>, mturquette@baylibre.com,
        sboyd@kernel.org, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, zhangqing@rock-chips.com,
        geert+renesas@glider.be, Caesar Wang <wxt@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH 3/3] soc: rockchip: power-domain: export idle request
Date:   Sun,  6 Jan 2019 01:48:37 +0800
Message-Id: <20190105174837.19378-4-ayaka@soulik.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190105174837.19378-1-ayaka@soulik.info>
References: <20190105174837.19378-1-ayaka@soulik.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to put the power status of HEVC IP into IDLE unless
we can't reset that IP or the SoC would crash down.
rockchip_pmu_idle_request(dev, true)---> enter idle
rockchip_pmu_idle_request(dev, false)---> exit idle

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Randy Li <ayaka@soulik.info>
---
 drivers/soc/rockchip/pm_domains.c | 23 +++++++++++++++++++++++
 include/soc/rockchip/pm_domains.h | 18 ++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 include/soc/rockchip/pm_domains.h

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 847c7c482b26..3e2e252cb64b 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -199,6 +199,29 @@ static int rockchip_pmu_set_idle_request(struct rockchip_pm_domain *pd,
 	return 0;
 }
 
+int rockchip_pmu_idle_request(struct device *dev, bool idle)
+{
+	struct generic_pm_domain *genpd;
+	struct rockchip_pm_domain *pd;
+	int ret;
+
+	if (IS_ERR_OR_NULL(dev))
+		return -EINVAL;
+
+	if (IS_ERR_OR_NULL(dev->pm_domain))
+		return -EINVAL;
+
+	genpd = pd_to_genpd(dev->pm_domain);
+	pd = to_rockchip_pd(genpd);
+
+	mutex_lock(&pd->pmu->mutex);
+	ret = rockchip_pmu_set_idle_request(pd, idle);
+	mutex_unlock(&pd->pmu->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL(rockchip_pmu_idle_request);
+
 static int rockchip_pmu_save_qos(struct rockchip_pm_domain *pd)
 {
 	int i;
diff --git a/include/soc/rockchip/pm_domains.h b/include/soc/rockchip/pm_domains.h
new file mode 100644
index 000000000000..690db6118636
--- /dev/null
+++ b/include/soc/rockchip/pm_domains.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __SOC_ROCKCHIP_PM_DOMAINS_H
+#define __SOC_ROCKCHIP_PM_DOMAINS_H
+
+#include <linux/errno.h>
+
+struct device;
+
+#ifdef CONFIG_ROCKCHIP_PM_DOMAINS
+int rockchip_pmu_idle_request(struct device *dev, bool idle);
+#else
+static inline int rockchip_pmu_idle_request(struct device *dev, bool idle)
+{
+	return -ENOTSUPP;
+}
+#endif
+
+#endif
-- 
2.20.1

