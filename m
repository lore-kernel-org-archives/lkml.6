Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A814FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8234121909
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389443AbeLUKNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:13:49 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:28225 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731874AbeLUKNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:13:49 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 5CD3513F8BA;
        Fri, 21 Dec 2018 11:13:18 +0100 (CET)
To:     Kishon Vijay Abraham <kishon@ti.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Yaniv Gardi <ygardi@codeaurora.org>
Cc:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        Matt Wagantall <mattw@codeaurora.org>,
        Mitchel Humpherys <mitchelh@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [PATCH v1] phy: qcom-ufs: Use iopoll.h readl_poll_timeout macro
Message-ID: <88cd3a2e-2acc-02ff-9f27-284d3b679d10@free.fr>
Date:   Fri, 21 Dec 2018 11:13:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The private copy of readl_poll_timeout is no longer needed.
Use the implementation in iopoll.h instead.

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 drivers/phy/qualcomm/phy-qcom-ufs-i.h | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-ufs-i.h b/drivers/phy/qualcomm/phy-qcom-ufs-i.h
index 681644e43248..f798fb64de94 100644
--- a/drivers/phy/qualcomm/phy-qcom-ufs-i.h
+++ b/drivers/phy/qualcomm/phy-qcom-ufs-i.h
@@ -23,24 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/delay.h>
-
-#define readl_poll_timeout(addr, val, cond, sleep_us, timeout_us) \
-({ \
-	ktime_t timeout = ktime_add_us(ktime_get(), timeout_us); \
-	might_sleep_if(timeout_us); \
-	for (;;) { \
-		(val) = readl(addr); \
-		if (cond) \
-			break; \
-		if (timeout_us && ktime_compare(ktime_get(), timeout) > 0) { \
-			(val) = readl(addr); \
-			break; \
-		} \
-		if (sleep_us) \
-			usleep_range(DIV_ROUND_UP(sleep_us, 4), sleep_us); \
-	} \
-	(cond) ? 0 : -ETIMEDOUT; \
-})
+#include <linux/iopoll.h>
 
 #define UFS_QCOM_PHY_CAL_ENTRY(reg, val)	\
 	{				\
-- 
2.17.1
