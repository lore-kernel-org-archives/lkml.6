Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932260AbeDCNBy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 09:01:54 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45754 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932130AbeDCNBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 09:01:52 -0400
X-Google-Smtp-Source: AIpwx4/0dVkz2vdSYNzmI+MdCVE+DhvvRUbpd7KO7W8vr9h/vAAb3zvagsutw2tfmFtC+C82e9VAuw==
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH 5/6] clocksource/drivers/imx-tpm: Correct some registers operation flow
Date: Tue,  3 Apr 2018 15:00:29 +0200
Message-Id: <1522760432-32048-5-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522760432-32048-1-git-send-email-daniel.lezcano@linaro.org>
References: <b2886156-4d6e-4c0c-1047-a54da8049ef6@linaro.org>
 <1522760432-32048-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

According to i.MX7ULP reference manual, TPM_SC_CPWMS can ONLY be written when
counter is disabled, TPM_SC_TOF is write-1-clear, TPM_C0SC_CHF is also
write-1-clear, correct these registers initialization flow;

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-imx-tpm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index 3f97d49..7403e49 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -20,6 +20,7 @@
 #define TPM_SC				0x10
 #define TPM_SC_CMOD_INC_PER_CNT		(0x1 << 3)
 #define TPM_SC_CMOD_DIV_DEFAULT		0x3
+#define TPM_SC_TOF_MASK			(0x1 << 7)
 #define TPM_CNT				0x14
 #define TPM_MOD				0x18
 #define TPM_STATUS			0x1c
@@ -29,6 +30,7 @@
 #define TPM_C0SC_MODE_SHIFT		2
 #define TPM_C0SC_MODE_MASK		0x3c
 #define TPM_C0SC_MODE_SW_COMPARE	0x4
+#define TPM_C0SC_CHF_MASK		(0x1 << 7)
 #define TPM_C0V				0x24
 
 static void __iomem *timer_base;
@@ -205,9 +207,13 @@ static int __init tpm_timer_init(struct device_node *np)
 	 * 4) Channel0 disabled
 	 * 5) DMA transfers disabled
 	 */
+	/* make sure counter is disabled */
 	writel(0, timer_base + TPM_SC);
+	/* TOF is W1C */
+	writel(TPM_SC_TOF_MASK, timer_base + TPM_SC);
 	writel(0, timer_base + TPM_CNT);
-	writel(0, timer_base + TPM_C0SC);
+	/* CHF is W1C */
+	writel(TPM_C0SC_CHF_MASK, timer_base + TPM_C0SC);
 
 	/* increase per cnt, div 8 by default */
 	writel(TPM_SC_CMOD_INC_PER_CNT | TPM_SC_CMOD_DIV_DEFAULT,
-- 
2.7.4
