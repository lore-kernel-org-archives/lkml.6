Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFBAC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E94E20874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732217AbeLQOXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:23:10 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:49168 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726647AbeLQOXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:23:04 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBHELl6T018484;
        Mon, 17 Dec 2018 15:22:37 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2pcr8xjc90-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 17 Dec 2018 15:22:37 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 92A243A;
        Mon, 17 Dec 2018 14:22:35 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 881242424;
        Mon, 17 Dec 2018 14:22:35 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 17 Dec
 2018 15:22:34 +0100
Received: from localhost (10.201.20.122) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 17 Dec 2018 15:22:34
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <alexandre.torgue@st.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Fabien Dessenne <fabien.dessenne@st.com>
Subject: [PATCH v3 2/3] irqchip: stm32: protect configuration registers with hwspinlock
Date:   Mon, 17 Dec 2018 15:22:14 +0100
Message-ID: <20181217142215.17493-3-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181217142215.17493-1-benjamin.gaignard@st.com>
References: <20181217142215.17493-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.122]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-17_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a hwspinlock is defined in device tree use it to protect
configuration registers.

Do not request for hwspinlock during the exti driver init since the
hwspinlock driver is not probed yet at that stage and the exti driver
does not support deferred probe.
Instead of this, postpone the hwspinlock request at the first time the
hwspinlock is actually needed.

Use the hwspin_trylock_raw() API which is the most appropriated here
Indeed:
- hwspin_lock_() calls are under spin_lock protection (chip_data->rlock
  or gc->lock).
- the _timeout() API relies on jiffies count which won't work if IRQs
  are disabled which is the case here (a large part of the IRQ setup is
  done atomically (see irq/manage.c))
As a consequence implement the retry/timeout lock from here. And since
all of this is done atomically, reduce the timeout delay to 1 ms.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 drivers/irqchip/irq-stm32-exti.c | 116 +++++++++++++++++++++++++++++++++------
 1 file changed, 100 insertions(+), 16 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 0a2088e12d96..95933745433f 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -6,6 +6,8 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/hwspinlock.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -20,6 +22,9 @@
 
 #define IRQS_PER_BANK 32
 
+#define HWSPNLCK_TIMEOUT	1000 /* usec */
+#define HWSPNLCK_RETRY_DELAY	100  /* usec */
+
 struct stm32_exti_bank {
 	u32 imr_ofst;
 	u32 emr_ofst;
@@ -32,6 +37,12 @@ struct stm32_exti_bank {
 
 #define UNDEF_REG ~0
 
+enum stm32_exti_hwspinlock {
+	HWSPINLOCK_UNKNOWN,
+	HWSPINLOCK_NONE,
+	HWSPINLOCK_READY,
+};
+
 struct stm32_desc_irq {
 	u32 exti;
 	u32 irq_parent;
@@ -58,6 +69,9 @@ struct stm32_exti_host_data {
 	void __iomem *base;
 	struct stm32_exti_chip_data *chips_data;
 	const struct stm32_exti_drv_data *drv_data;
+	struct device_node *node;
+	enum stm32_exti_hwspinlock hwlock_state;
+	struct hwspinlock *hwlock;
 };
 
 static struct stm32_exti_host_data *stm32_host_data;
@@ -269,6 +283,64 @@ static int stm32_exti_set_type(struct irq_data *d,
 	return 0;
 }
 
+static int stm32_exti_hwspin_lock(struct stm32_exti_chip_data *chip_data)
+{
+	struct stm32_exti_host_data *host_data = chip_data->host_data;
+	struct hwspinlock *hwlock;
+	int id, ret = 0, timeout = 0;
+
+	/* first time, check for hwspinlock availability */
+	if (unlikely(host_data->hwlock_state == HWSPINLOCK_UNKNOWN)) {
+		id = of_hwspin_lock_get_id(host_data->node, 0);
+		if (id >= 0) {
+			hwlock = hwspin_lock_request_specific(id);
+			if (hwlock) {
+				/* found valid hwspinlock */
+				host_data->hwlock_state = HWSPINLOCK_READY;
+				host_data->hwlock = hwlock;
+				pr_debug("%s hwspinlock = %d\n", __func__, id);
+			} else {
+				host_data->hwlock_state = HWSPINLOCK_NONE;
+			}
+		} else if (id != -EPROBE_DEFER) {
+			host_data->hwlock_state = HWSPINLOCK_NONE;
+		} else {
+			/* hwspinlock driver shall be ready at that stage */
+			ret = -EPROBE_DEFER;
+		}
+	}
+
+	if (likely(host_data->hwlock_state == HWSPINLOCK_READY)) {
+		/*
+		 * Use the x_raw API since we are under spin_lock protection.
+		 * Do not use the x_timeout API because we are under irq_disable
+		 * mode (see __setup_irq())
+		 */
+		do {
+			ret = hwspin_trylock_raw(host_data->hwlock);
+			if (!ret)
+				return 0;
+
+			udelay(HWSPNLCK_RETRY_DELAY);
+			timeout += HWSPNLCK_RETRY_DELAY;
+		} while (timeout < HWSPNLCK_TIMEOUT);
+
+		if (ret == -EBUSY)
+			ret = -ETIMEDOUT;
+	}
+
+	if (ret)
+		pr_err("%s can't get hwspinlock (%d)\n", __func__, ret);
+
+	return ret;
+}
+
+static void stm32_exti_hwspin_unlock(struct stm32_exti_chip_data *chip_data)
+{
+	if (likely(chip_data->host_data->hwlock_state == HWSPINLOCK_READY))
+		hwspin_unlock_raw(chip_data->host_data->hwlock);
+}
+
 static int stm32_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
@@ -279,21 +351,26 @@ static int stm32_irq_set_type(struct irq_data *d, unsigned int type)
 
 	irq_gc_lock(gc);
 
+	err = stm32_exti_hwspin_lock(chip_data);
+	if (err)
+		goto unlock;
+
 	rtsr = irq_reg_readl(gc, stm32_bank->rtsr_ofst);
 	ftsr = irq_reg_readl(gc, stm32_bank->ftsr_ofst);
 
 	err = stm32_exti_set_type(d, type, &rtsr, &ftsr);
-	if (err) {
-		irq_gc_unlock(gc);
-		return err;
-	}
+	if (err)
+		goto unspinlock;
 
 	irq_reg_writel(gc, rtsr, stm32_bank->rtsr_ofst);
 	irq_reg_writel(gc, ftsr, stm32_bank->ftsr_ofst);
 
+unspinlock:
+	stm32_exti_hwspin_unlock(chip_data);
+unlock:
 	irq_gc_unlock(gc);
 
-	return 0;
+	return err;
 }
 
 static void stm32_chip_suspend(struct stm32_exti_chip_data *chip_data,
@@ -460,20 +537,27 @@ static int stm32_exti_h_set_type(struct irq_data *d, unsigned int type)
 	int err;
 
 	raw_spin_lock(&chip_data->rlock);
+
+	err = stm32_exti_hwspin_lock(chip_data);
+	if (err)
+		goto unlock;
+
 	rtsr = readl_relaxed(base + stm32_bank->rtsr_ofst);
 	ftsr = readl_relaxed(base + stm32_bank->ftsr_ofst);
 
 	err = stm32_exti_set_type(d, type, &rtsr, &ftsr);
-	if (err) {
-		raw_spin_unlock(&chip_data->rlock);
-		return err;
-	}
+	if (err)
+		goto unspinlock;
 
 	writel_relaxed(rtsr, base + stm32_bank->rtsr_ofst);
 	writel_relaxed(ftsr, base + stm32_bank->ftsr_ofst);
+
+unspinlock:
+	stm32_exti_hwspin_unlock(chip_data);
+unlock:
 	raw_spin_unlock(&chip_data->rlock);
 
-	return 0;
+	return err;
 }
 
 static int stm32_exti_h_set_wake(struct irq_data *d, unsigned int on)
@@ -599,6 +683,8 @@ stm32_exti_host_data *stm32_exti_host_init(const struct stm32_exti_drv_data *dd,
 		return NULL;
 
 	host_data->drv_data = dd;
+	host_data->node = node;
+	host_data->hwlock_state = HWSPINLOCK_UNKNOWN;
 	host_data->chips_data = kcalloc(dd->bank_nr,
 					sizeof(struct stm32_exti_chip_data),
 					GFP_KERNEL);
@@ -625,8 +711,7 @@ stm32_exti_host_data *stm32_exti_host_init(const struct stm32_exti_drv_data *dd,
 
 static struct
 stm32_exti_chip_data *stm32_exti_chip_init(struct stm32_exti_host_data *h_data,
-					   u32 bank_idx,
-					   struct device_node *node)
+					   u32 bank_idx)
 {
 	const struct stm32_exti_bank *stm32_bank;
 	struct stm32_exti_chip_data *chip_data;
@@ -656,8 +741,7 @@ stm32_exti_chip_data *stm32_exti_chip_init(struct stm32_exti_host_data *h_data,
 	if (stm32_bank->fpr_ofst != UNDEF_REG)
 		writel_relaxed(~0UL, base + stm32_bank->fpr_ofst);
 
-	pr_info("%s: bank%d, External IRQs available:%#x\n",
-		node->full_name, bank_idx, irqs_mask);
+	pr_info("%pOF: bank%d\n", h_data->node, bank_idx);
 
 	return chip_data;
 }
@@ -697,7 +781,7 @@ static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
 		struct stm32_exti_chip_data *chip_data;
 
 		stm32_bank = drv_data->exti_banks[i];
-		chip_data = stm32_exti_chip_init(host_data, i, node);
+		chip_data = stm32_exti_chip_init(host_data, i);
 
 		gc = irq_get_domain_generic_chip(domain, i * IRQS_PER_BANK);
 
@@ -760,7 +844,7 @@ __init stm32_exti_hierarchy_init(const struct stm32_exti_drv_data *drv_data,
 		return -ENOMEM;
 
 	for (i = 0; i < drv_data->bank_nr; i++)
-		stm32_exti_chip_init(host_data, i, node);
+		stm32_exti_chip_init(host_data, i);
 
 	domain = irq_domain_add_hierarchy(parent_domain, 0,
 					  drv_data->bank_nr * IRQS_PER_BANK,
-- 
2.15.0

