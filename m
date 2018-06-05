Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751900AbeFELoU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:44:20 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:50607 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751819AbeFELoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:44:19 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ludovic Barre <ludovic.barre@st.com>,
        Rob Herring <robh@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] irqchip/stm32: fix non-SMP build warning
Date: Tue,  5 Jun 2018 13:43:34 +0200
Message-Id: <20180605114347.1347128-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:6KhzIBMf76MS69gmFQuvp4KMTEktmb+ApIpuBYw4tviDx0ahOme
 vcb2BXFtT4pmNFiKdx90jvC0YcF2xKseqEjvcp2INK98lNR4mnxXgqd2e5744SgHP9EHzFe
 gG/UNdHlcAF9FeVS5+HBTV+V+ZiM8IfCeC5CGLfQd37WohtpO3bxJH1AvU5YgOreV5lXsRl
 1uV8HLzq9mZ7scTf61azw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QU+Pqz4ZbB8=:ltzrkOP3CEU+rTY3Fylymv
 LHTr5y7Yjibv11H+S1QUAqdM2r3TbbR0VK8QHV3Y3aMC6dEZS6BHCZ2WL4muKBNxbyBxMbR3P
 9MvAPJsnxlfQYiyLxtRSlnl5nO12TWqXdMcwbeY/aqMQXulHqHUCUKdvBeE+3mTV0mtzPeWa7
 4KraApxodNRyAhfvBboYfGPZ6E9c4z4NQX9mq7n40cKQBaiqOhXly+W9/PuyQjYtUURjjvKAS
 T3AAHS5gXriOXy++mIGm0YeldH8E6496vYHlNe7hPeYEK4UCPgtSmekdxt2hSJdXY/fDMTFiI
 jGmwFIDMD+sKJ2h7jL6HlKX3OfFCycefSV7zuwzBOk35DI1tTXHNgcpg58SLMfoRqK4KKZoey
 VPbo57n2IJ7+w+eq4q3/IQEW1ZGnSTqi04HzVceNSY7QWHZ8PUsJfUTwkXtl/18josa+WPP9i
 8m8pow5x7PMIxOjC6gf+fRDF2Vr3IkoiAPydcQUeWtTX0FX5c9pOTSjm3FIYLzm4jpRYDez80
 wRkewUKFijpMKzItiJj4IUY42WTYk14da7USGN6Zz6sWazLrrN6y5jV4OKyXy7LWGAYfoDT0z
 X9hhcv7xfUpUXbCq3AnrPGeVxHn2FXkh6i/rZkkbgd5D9IsNobe+jDfvU0s9tqHJdWRk/x4Kh
 gPEgaqFJbFNgng6snXMoQfSACD/WEVggYnSNZGGAlagUbEk3Khr5uFdx2sbw+jrUSwwU=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without CONFIG_SMP, we get a harmless compile-time warning:

drivers/irqchip/irq-stm32-exti.c:495:12: error: 'stm32_exti_h_set_affinity' defined but not used [-Werror=unused-function]

The #ifdef is inconsistent here, and it's better to use an IS_ENABLED() check
that lets the compiler silently drop that function.

Fixes: 927abfc4461e ("irqchip/stm32: Add stm32mp1 support with hierarchy domain")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/irqchip/irq-stm32-exti.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 5089c1e2838d..3a7e8905a97e 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -552,9 +552,7 @@ static struct irq_chip stm32_exti_h_chip = {
 	.irq_set_type		= stm32_exti_h_set_type,
 	.irq_set_wake		= stm32_exti_h_set_wake,
 	.flags			= IRQCHIP_MASK_ON_SUSPEND,
-#ifdef CONFIG_SMP
-	.irq_set_affinity	= stm32_exti_h_set_affinity,
-#endif
+	.irq_set_affinity	= IS_ENABLED(CONFIG_SMP) ? stm32_exti_h_set_affinity : NULL,
 };
 
 static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
-- 
2.9.0
