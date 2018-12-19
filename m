Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C652C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8B221871
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="gOiZbwZe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeLSLSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 06:18:11 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52900 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727155AbeLSLSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 06:18:10 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so5686644wml.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 03:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TqKqWnuzhLbrzsGGpVafyPrzq3m458cHAEUpEwoTcTg=;
        b=gOiZbwZeCICmVnsjTiZw3HgUFYqa/UwXZtbnVgHtwo58IKdyJAtXj46tres2v+TfHk
         ub0G0IFTLJdjkSwoy55falOWEw9vSxD/0s1FiVf2f8SysFi32CyQNosLrc+EIdhNy0O1
         WTgNe+7MtqtYrUCdh46PCaST2yytWDmuiH9Q6Vxd+5TCU738yMEvM6edNRkzzvxDvuMV
         T6QzzPZbCN8LmWI2PvVdb6aqhTkJFA7tABbch0N7lbuZodtHfWIMmgKl/qXgGj3d+VsG
         JlGQ6TcFPnxfLn8UjeMmiXqbIeApOio7P3XwL1igOvxtpkzT3eOOif2/ZNZoOnDBB7eK
         abRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TqKqWnuzhLbrzsGGpVafyPrzq3m458cHAEUpEwoTcTg=;
        b=sZJpvBGUfAAhkdtckk66F9SuMDqmqzKiXjRGd16OOziTDQtXHfYfL2a6Ej/TZqanm8
         ytZ9vQafrS0AeWl0Su+cZMOqApKDESuMkwaKtmbyMoqLvjNGu7Hmt81iOZDa/qvAfJs3
         iGmZFQPcJbovYLASTDfiMRLPWb84PWY1zqzhgPNqyyUt4+NNM6Ds/vu4gGaBPszbFAft
         uI9dopMd+X/lxzYUiD9dOgdci1BhO1FCFS2BrxRtA8sWLdVMZLpI/YwxIb2zLDTZFWdn
         VVFEMj2exwo1aEZ8ChTXeU6rca/K4Ee414RVoa0W78hNh4I8viLitA4WQA2iFJlEurfG
         zdWw==
X-Gm-Message-State: AA+aEWYYSyW5Qd/qiioSsZux9/Gf6+cJTjTlMIWML+WSPU08G3PRUHyu
        y6mmBuWiTNNHcqi9HT90jMgGnw==
X-Google-Smtp-Source: AFSGD/U5VoB2R2oRuSPIp7wjKsMNJiPVEDg/suucku1MGOhIk7L2qMcYL8P/6ys8qZQS9cc6wpwOgw==
X-Received: by 2002:a1c:ae88:: with SMTP id x130mr6459235wme.91.1545218288225;
        Wed, 19 Dec 2018 03:18:08 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id z7sm4320111wrw.22.2018.12.19.03.18.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 03:18:07 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] regmap: irq: add an option to clear status registers on unmask
Date:   Wed, 19 Dec 2018 12:18:05 +0100
Message-Id: <20181219111805.18048-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Some interrupt controllers whose interrupts are acked on read will set
the status bits for masked interrupts without changing the state of
the IRQ line.

Some chips have an additional "feature" where if those set bits are
not cleared before unmasking their respective interrupts, the IRQ
line will change the state and we'll interpret this as an interrupt
although it actually fired when it was masked.

Add a new field to the irq chip struct that tells the regmap irq chip
code to always clear the status registers before actually changing the
irq mask values.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
Hi Mark,

there's one more problem I noticed with max77650. When a condition for
a masked interrupt is met - its status bit is set but the irq line
doesn't go low. Now if we don't clear that bit and unmask its
respective interrupt, the line will go low and we'll interpret it as
if an interrupt fired right after we enabled it.

This patch tries to address it in a generic way.

 drivers/base/regmap/regmap-irq.c | 23 +++++++++++++++++++++++
 include/linux/regmap.h           |  4 ++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 8b216b2e2c19..5a454fcd10db 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -44,6 +44,8 @@ struct regmap_irq_chip_data {
 
 	unsigned int irq_reg_stride;
 	unsigned int type_reg_stride;
+
+	bool clear_status:1;
 };
 
 static inline const
@@ -77,6 +79,7 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 	int i, ret;
 	u32 reg;
 	u32 unmask_offset;
+	u32 val;
 
 	if (d->chip->runtime_pm) {
 		ret = pm_runtime_get_sync(map->dev);
@@ -85,6 +88,20 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 				ret);
 	}
 
+	if (d->clear_status) {
+		for (i = 0; i < d->chip->num_regs; i++) {
+			reg = d->chip->status_base +
+				(i * map->reg_stride * d->irq_reg_stride);
+
+			ret = regmap_read(map, reg, &val);
+			if (ret)
+				dev_err(d->map->dev,
+					"Failed to clear the interrupt status bits\n");
+		}
+
+		d->clear_status = false;
+	}
+
 	/*
 	 * If there's been a change in the mask write it back to the
 	 * hardware.  We rely on the use of the regmap core cache to
@@ -217,6 +234,9 @@ static void regmap_irq_enable(struct irq_data *data)
 	else
 		mask = irq_data->mask;
 
+	if (d->chip->clear_on_unmask)
+		d->clear_status = true;
+
 	d->mask_buf[irq_data->reg_offset / map->reg_stride] &= ~mask;
 }
 
@@ -459,6 +479,9 @@ int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
 	if (chip->num_regs <= 0)
 		return -EINVAL;
 
+	if (chip->clear_on_unmask && (chip->ack_base || chip->use_ack))
+		return -EINVAL;
+
 	for (i = 0; i < chip->num_irqs; i++) {
 		if (chip->irqs[i].reg_offset % map->reg_stride)
 			return -EINVAL;
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index b7aa50cfb306..23dfacf281f8 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1134,6 +1134,9 @@ struct regmap_irq {
  * @type_in_mask: Use the mask registers for controlling irq type. For
  *                interrupts defining type_rising/falling_mask use mask_base
  *                for edge configuration and never update bits in type_base.
+ * @clear_on_unmask: For chips with interrupts cleared on read: read the status
+ *                   registers before unmasking interrupts to clear any bits
+ *                   set when they were masked.
  * @runtime_pm:  Hold a runtime PM lock on the device when accessing it.
  *
  * @num_regs:    Number of registers in each control bank.
@@ -1173,6 +1176,7 @@ struct regmap_irq_chip {
 	bool runtime_pm:1;
 	bool type_invert:1;
 	bool type_in_mask:1;
+	bool clear_on_unmask:1;
 
 	int num_regs;
 
-- 
2.19.1

