Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55C6C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BC1214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Bey5pOIp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbfA2IpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:45:04 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36206 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbfA2IoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:44:23 -0500
Received: by mail-wm1-f68.google.com with SMTP id p6so16715068wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 00:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LyKOxtNvIzNO612oh1cgft6iGoalHffCBs8NIdrqxbg=;
        b=Bey5pOIpEYce6rE72UEsnLBBCz3oPP86VduaN172XUV0ZfD19faJAkikztUOzHSvie
         k8jDpfXqDlFc/jeGmog+0/xhdugXk/es3OFhQVlWC5DRxONpEzmHfnATudv9QvYWWGS9
         8TUP1HQyopP39ObgpNBL5+OUedzPArQTClGc0GYhxoCy4Wudlft5aywTPxr/+/EQtKKR
         Odxch5ZRdR3ajitQ8kPMyH5eJPxW972joNT4xyCvFxRO8UU4EL1tVd29j73a2AA3FsTi
         beIPoq7odo+ZMdszbKGQoYgYe5w+K1hFA7aJz3H+5JyTpgGQ3IsY2ZSNox5O6QJd/g6Q
         sfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LyKOxtNvIzNO612oh1cgft6iGoalHffCBs8NIdrqxbg=;
        b=bTwJ8qKvaoosDMPpY2/jKjhiCfAxn7wVDFnNnrdMTksDKwmxtP55xAPW87YJ/FDJcF
         q2p0TWdLrp0VYeMCgTQRLUWFuRpmxhKkBo0mJ1/tyYgULhwldTfPBGLyCOmA6iF/C/xv
         37qs/0LTNkt7IaqFCan1r7nvvTE7mVqqQKUtnYoWEG3jBAG6cFzLhmTuxZF9wl9EdI0o
         zPmhXpK0ESFtKxVUJ0YU+T29nVzMWpp77AOYlUwPRIycuCFniheOm4hRuWKYSryCTQwD
         vuU/x22P5E6t+n0VyKYL+3h6QidHxIXOzozKo+50x3PybiIGfkn2inY/ohUa+rRDyNCO
         DXwg==
X-Gm-Message-State: AJcUukcKvREnlX9T6XaUEdMZtK2q6K3ofw9xwA7QExfO6N7RjLgz7OFg
        tCP7cIKnHT8qX6fCNFlvySkYiA==
X-Google-Smtp-Source: ALg8bN4TCg2CGHRaz+V3V2hIkJog0VDogHDLlA+h0Y8lfAQa/XOdHdPx8tvCFvoPGeBSGgUF2AY2Ww==
X-Received: by 2002:a1c:f112:: with SMTP id p18mr19060358wmh.83.1548751462018;
        Tue, 29 Jan 2019 00:44:22 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id c1sm3979319wmb.14.2019.01.29.00.44.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 00:44:21 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 3/9] irq/irq_sim: provide irq_sim_fire_type()
Date:   Tue, 29 Jan 2019 09:44:05 +0100
Message-Id: <20190129084411.30495-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190129084411.30495-1-brgl@bgdev.pl>
References: <20190129084411.30495-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Provide a more specialized variant of irq_sim_fire() that allows to
specify the type of the fired interrupt. The type is stored in the
dummy irq context struct via the set_type callback.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/irq_sim.h |  9 ++++++++-
 kernel/irq/irq_sim.c    | 26 ++++++++++++++++++++++----
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/include/linux/irq_sim.h b/include/linux/irq_sim.h
index b96c2f752320..647a6c8ffb31 100644
--- a/include/linux/irq_sim.h
+++ b/include/linux/irq_sim.h
@@ -23,6 +23,7 @@ struct irq_sim_work_ctx {
 
 struct irq_sim_irq_ctx {
 	bool			enabled;
+	unsigned int		type;
 };
 
 struct irq_sim {
@@ -37,7 +38,13 @@ int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs);
 int devm_irq_sim_init(struct device *dev, struct irq_sim *sim,
 		      unsigned int num_irqs);
 void irq_sim_fini(struct irq_sim *sim);
-void irq_sim_fire(struct irq_sim *sim, unsigned int offset);
+void irq_sim_fire_type(struct irq_sim *sim,
+		       unsigned int offset, unsigned int type);
 int irq_sim_irqnum(struct irq_sim *sim, unsigned int offset);
 
+static inline void irq_sim_fire(struct irq_sim *sim, unsigned int offset)
+{
+	irq_sim_fire_type(sim, offset, IRQ_TYPE_DEFAULT);
+}
+
 #endif /* _LINUX_IRQ_SIM_H */
diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index 2bcdbab1bc5a..e3160b5e59b8 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -25,6 +25,15 @@ static void irq_sim_irqunmask(struct irq_data *data)
 	irq_ctx->enabled = true;
 }
 
+static int irq_sim_set_type(struct irq_data *data, unsigned int type)
+{
+	struct irq_sim_irq_ctx *irq_ctx = irq_data_get_irq_chip_data(data);
+
+	irq_ctx->type = type;
+
+	return 0;
+}
+
 static void irq_sim_handle_irq(struct irq_work *work)
 {
 	struct irq_sim_work_ctx *work_ctx;
@@ -107,6 +116,7 @@ int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs)
 	sim->chip.name = "irq_sim";
 	sim->chip.irq_mask = irq_sim_irqmask;
 	sim->chip.irq_unmask = irq_sim_irqunmask;
+	sim->chip.irq_set_type = irq_sim_set_type;
 
 	sim->work_ctx.pending = bitmap_zalloc(num_irqs, GFP_KERNEL);
 	if (!sim->work_ctx.pending) {
@@ -192,21 +202,29 @@ irq_sim_get_ctx(struct irq_sim *sim, unsigned int offset)
 }
 
 /**
- * irq_sim_fire - Enqueue an interrupt.
+ * irq_sim_fire_type - Enqueue an interrupt.
  *
  * @sim:        The interrupt simulator object.
  * @offset:     Offset of the simulated interrupt which should be fired.
+ * @type:	Type of the fired interrupt. Must be one of the following:
+ *		IRQ_TYPE_EDGE_RISING, IRQ_TYPE_EDGE_FALLING,
+ *		IRQ_TYPE_EDGE_BOTH, IRQ_TYPE_LEVEL_HIGH,
+ *		IRQ_TYPE_LEVEL_LOW, IRQ_TYPE_DEFAULT
  */
-void irq_sim_fire(struct irq_sim *sim, unsigned int offset)
+void irq_sim_fire_type(struct irq_sim *sim,
+		       unsigned int offset, unsigned int type)
 {
 	struct irq_sim_irq_ctx *ctx = irq_sim_get_ctx(sim, offset);
 
-	if (ctx->enabled) {
+	/* Only care about relevant flags. */
+	type &= IRQ_TYPE_SENSE_MASK;
+
+	if (ctx->enabled && (ctx->type & type)) {
 		set_bit(offset, sim->work_ctx.pending);
 		irq_work_queue(&sim->work_ctx.work);
 	}
 }
-EXPORT_SYMBOL_GPL(irq_sim_fire);
+EXPORT_SYMBOL_GPL(irq_sim_fire_type);
 
 /**
  * irq_sim_irqnum - Get the allocated number of a dummy interrupt.
-- 
2.19.1

