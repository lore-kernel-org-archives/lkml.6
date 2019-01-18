Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C7EC1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925172087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbfARVSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 16:18:08 -0500
Received: from mail.ispras.ru ([83.149.199.45]:47094 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729616AbfARVSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 16:18:07 -0500
Received: from localhost.localdomain (ppp85-140-181-158.pppoe.mtu-net.ru [85.140.181.158])
        by mail.ispras.ru (Postfix) with ESMTPSA id 77C56540082;
        Sat, 19 Jan 2019 00:18:04 +0300 (MSK)
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] usb: dwc3: exynos: Fix error handling of clk_prepare_enable
Date:   Sat, 19 Jan 2019 00:17:37 +0300
Message-Id: <1547846257-19970-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If clk_prepare_enable() fails in dwc3_exynos_probe(),
exynos->clks[0] is left undisabled because of usage
preincrement in while condition.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Fixes: 9f2168367a0a ("usb: dwc3: exynos: Rework clock handling and prepare for new variants")
---
 drivers/usb/dwc3/dwc3-exynos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index cb7fcd7c0ad8..e7f6cff27b9a 100644
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
-- 
2.7.4

