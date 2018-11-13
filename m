Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370A6C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE071223D0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XgncWIX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE071223D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388047AbeKNAqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:46:49 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39282 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387826AbeKNAqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:46:48 -0500
Received: by mail-wm1-f67.google.com with SMTP id u13-v6so11695335wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 06:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PUhwzWCNINq4G85hsADLvAv0JEEBgq+q7zMHSmbBlVE=;
        b=XgncWIX1EZWUylAev/wmIv9MjzWUO7r7khEGbvyzzxLutmjm2VtJvJ0zed2I9BAzXQ
         Z3bQmkeHUk2sQchvtZzb9GKFEHZkRhHZnYBjwO3VFiVIUUylfV0T8qUPvmOyAjK7n1wU
         HqHHR6d+lzNLFXiWMetkTTKyNEeyPoR8pJ8yA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PUhwzWCNINq4G85hsADLvAv0JEEBgq+q7zMHSmbBlVE=;
        b=c5X1LxL12TfNq1c4n1kY6u4lluAdjHzApEgUpJPZ0sUNZ77zF3nAKKlYTOfDxMiG/g
         VtHT1rjGslcxFFcj5SJJ4klN9lgCj6qlHeT8hgEFD53nXX3mGm5V5YvHSHiePr1b8AFj
         h1itZb24gFdKrypAK/8w8nH/sXcC3pWTCWH+xf5d1iXM9/KxsdAJthVJvpw8UcNPmZL+
         bGRNDp0F+34ca8Vsf8LAPFzoViq1Cn3RJ8QyH4wM8gSBKMR9b8uYRDn8UXuNZPr3YWt0
         u45QmFJAsIXvSLwUbYTvUnUdhVJkLHhGcEbH7q1KIKs2ufTtszbH5iEO+zBvrWk0jbFA
         c9jw==
X-Gm-Message-State: AGRZ1gJBorNIvUCuKcRr0bB1GhpXlwm+SEW2q2BPuA9Dpkgzh5Sv3Ke2
        kSzg4enC3dA9KVZy0+ZfxX9MYQ==
X-Google-Smtp-Source: AJdET5dD9UmnOyZZYggdhIFKtSXDsgO+s4IbNhtPpFX2ptLvr4IUWRV8T4cX2uKlI18zkVaLnKZH7w==
X-Received: by 2002:a1c:9c85:: with SMTP id f127-v6mr3421310wme.73.1542120498199;
        Tue, 13 Nov 2018 06:48:18 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:1088:2b4c:8cab:bca7:b2f2:d2bb])
        by smtp.gmail.com with ESMTPSA id s16sm3292020wrt.77.2018.11.13.06.48.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Nov 2018 06:48:17 -0800 (PST)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 2/3] irqchip: stm32: protect configuration registers with hwspinlock
Date:   Tue, 13 Nov 2018 15:48:04 +0100
Message-Id: <20181113144805.1054-3-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181113144805.1054-1-benjamin.gaignard@st.com>
References: <20181113144805.1054-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a hwspinlock is defined in device tree use it to protect
configuration registers.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/irqchip/irq-stm32-exti.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 0a2088e12d96..a010a2eed078 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/hwspinlock.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -20,6 +21,8 @@
 
 #define IRQS_PER_BANK 32
 
+#define HWSPINLOCK_TIMEOUT	5 /* msec */
+
 struct stm32_exti_bank {
 	u32 imr_ofst;
 	u32 emr_ofst;
@@ -47,6 +50,7 @@ struct stm32_exti_drv_data {
 struct stm32_exti_chip_data {
 	struct stm32_exti_host_data *host_data;
 	const struct stm32_exti_bank *reg_bank;
+	struct hwspinlock *hwlock;
 	struct raw_spinlock rlock;
 	u32 wake_active;
 	u32 mask_cache;
@@ -275,25 +279,34 @@ static int stm32_irq_set_type(struct irq_data *d, unsigned int type)
 	struct stm32_exti_chip_data *chip_data = gc->private;
 	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
 	u32 rtsr, ftsr;
-	int err;
+	int err = 0;
 
 	irq_gc_lock(gc);
 
+	if (chip_data->hwlock)
+		err = hwspin_lock_timeout(chip_data->hwlock,
+					  HWSPINLOCK_TIMEOUT);
+
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
+	if (chip_data->hwlock)
+		hwspin_unlock(chip_data->hwlock);
+unlock:
 	irq_gc_unlock(gc);
 
-	return 0;
+	return err;
 }
 
 static void stm32_chip_suspend(struct stm32_exti_chip_data *chip_data,
@@ -670,6 +683,7 @@ static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
 	int nr_irqs, ret, i;
 	struct irq_chip_generic *gc;
 	struct irq_domain *domain;
+	struct hwspinlock *hwlock = NULL;
 
 	host_data = stm32_exti_host_init(drv_data, node);
 	if (!host_data)
@@ -692,12 +706,22 @@ static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
 		goto out_free_domain;
 	}
 
+	/* hwspinlock is optional */
+	ret = of_hwspin_lock_get_id(node, 0);
+	if (ret < 0) {
+		if (ret == -EPROBE_DEFER)
+			goto out_free_domain;
+	} else {
+		hwlock = hwspin_lock_request_specific(ret);
+	}
+
 	for (i = 0; i < drv_data->bank_nr; i++) {
 		const struct stm32_exti_bank *stm32_bank;
 		struct stm32_exti_chip_data *chip_data;
 
 		stm32_bank = drv_data->exti_banks[i];
 		chip_data = stm32_exti_chip_init(host_data, i, node);
+		chip_data->hwlock = hwlock;
 
 		gc = irq_get_domain_generic_chip(domain, i * IRQS_PER_BANK);
 
-- 
2.15.0

