Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DEBC37123
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A578D20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbfAUVYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 16:24:05 -0500
Received: from mail.ispras.ru ([83.149.199.45]:33784 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727137AbfAUVYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 16:24:04 -0500
Received: from localhost.localdomain (unknown [85.140.183.8])
        by mail.ispras.ru (Postfix) with ESMTPSA id 3ABAE54006B;
        Tue, 22 Jan 2019 00:24:01 +0300 (MSK)
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH v2] usb: dwc3: exynos: Fix error handling of clk_prepare_enable
Date:   Tue, 22 Jan 2019 00:23:50 +0300
Message-Id: <1548105830-26376-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If clk_prepare_enable() fails in dwc3_exynos_probe() or in
dwc3_exynos_resume(), exynos->clks[0] is left undisabled
because of usage preincrement in while condition.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Fixes: 9f2168367a0a ("usb: dwc3: exynos: Rework clock handling and prepare for new variants")
---
v2: Add fix for the second instance in dwc3_exynos_resume() per Marek Szyprowski note.

 drivers/usb/dwc3/dwc3-exynos.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index cb7fcd7c0ad8..c1e9ea621f41 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -78,7 +78,7 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
 	for (i = 0; i < exynos->num_clks; i++) {
 		ret = clk_prepare_enable(exynos->clks[i]);
 		if (ret) {
-			while (--i > 0)
+			while (i-- > 0)
 				clk_disable_unprepare(exynos->clks[i]);
 			return ret;
 		}
@@ -223,7 +223,7 @@ static int dwc3_exynos_resume(struct device *dev)
 	for (i = 0; i < exynos->num_clks; i++) {
 		ret = clk_prepare_enable(exynos->clks[i]);
 		if (ret) {
-			while (--i > 0)
+			while (i-- > 0)
 				clk_disable_unprepare(exynos->clks[i]);
 			return ret;
 		}
-- 
2.7.4

