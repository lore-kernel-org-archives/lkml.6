Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0FD80601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752403AbeFFKKZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:10:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36549 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751397AbeFFKKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:10:23 -0400
Date: Wed, 6 Jun 2018 03:10:03 -0700
From: tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-a84277bf3efcc7bb5b5a5eec62de5c134cb47ee5@git.kernel.org>
Cc: alexandre.torgue@st.com, linux-kernel@vger.kernel.org,
        marc.zyngier@arm.com, hpa@zytor.com, tglx@linutronix.de,
        radoslaw.pietrzyk@gmail.com, benjamin.gaignard@linaro.org,
        jason@lakedaemon.net, mcoquelin.stm32@gmail.com,
        ludovic.barre@st.com, robh@kernel.org, mingo@kernel.org,
        arnd@arndb.de
Reply-To: alexandre.torgue@st.com, marc.zyngier@arm.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          radoslaw.pietrzyk@gmail.com, benjamin.gaignard@linaro.org,
          jason@lakedaemon.net, ludovic.barre@st.com,
          mcoquelin.stm32@gmail.com, mingo@kernel.org, robh@kernel.org,
          arnd@arndb.de
In-Reply-To: <20180605114347.1347128-1-arnd@arndb.de>
References: <20180605114347.1347128-1-arnd@arndb.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/urgent] irqchip/stm32: Fix non-SMP build warning
Git-Commit-ID: a84277bf3efcc7bb5b5a5eec62de5c134cb47ee5
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a84277bf3efcc7bb5b5a5eec62de5c134cb47ee5
Gitweb:     https://git.kernel.org/tip/a84277bf3efcc7bb5b5a5eec62de5c134cb47ee5
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Tue, 5 Jun 2018 13:43:34 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 6 Jun 2018 12:05:19 +0200

irqchip/stm32: Fix non-SMP build warning

A CONFIG_SMP=n build emits a harmless compile-time warning:

drivers/irqchip/irq-stm32-exti.c:495:12: error: 'stm32_exti_h_set_affinity' defined but not used [-Werror=unused-function]

The #ifdef is inconsistent here, and it's better to use an IS_ENABLED() check
that lets the compiler silently drop that function.

Fixes: 927abfc4461e ("irqchip/stm32: Add stm32mp1 support with hierarchy domain")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ludovic Barre <ludovic.barre@st.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Link: https://lkml.kernel.org/r/20180605114347.1347128-1-arnd@arndb.de

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
