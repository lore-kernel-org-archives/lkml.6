Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195A9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4642217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545244709;
	bh=A9nmwXb6J2JsmoViaCuYfnpVRai0WHxFQ4t6bOXefVo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=gAHczAKc1EeO5eOBsDjkf41HHsDAtn8bBIQif1HSe45OV6wqRTJ3IUMvMKV/bD//6
	 nyLkzQP2Ni4a8meQjt1liHJieIYZ7YVNuy/3hWJ+L+K7yzL35b2hZn1FdIW9Lhi0/2
	 eI6jzqau/klOEppttsTqos8LJ3aSEmHx1zmD6ubo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbeLSSi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 13:38:29 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40548 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727694AbeLSSi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 13:38:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Asq4JRnjBzoR/uQaJAoLpElZ3E8aQDpbVFgVhWfS4Qc=; b=T164bibY7wEz
        MpmRC4CswYaq9Wa/2YuO747QPqAonrKbqRTwK/+L9RNDvM8vr5KOSbrMUQIgJkoS4JVXC4CK9+ELu
        2JXnHdsQCccxEDNvcrO29F6kT8Bt5IMTghWufpUqUVfsTdLHEFf4d1Ka3z0VqPuERDFD5NAvEmovz
        6Na5E=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gZgjh-0005Li-Nw; Wed, 19 Dec 2018 18:38:25 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 4304111259E9; Wed, 19 Dec 2018 18:38:25 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regmap: irq: add an option to clear status registers on unmask" to the regmap tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181219183825.4304111259E9@debutante.sirena.org.uk>
Date:   Wed, 19 Dec 2018 18:38:25 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: irq: add an option to clear status registers on unmask

has been applied to the regmap tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From c82ea33ead18801605b236523f21e5c893c7c253 Mon Sep 17 00:00:00 2001
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Wed, 19 Dec 2018 12:18:05 +0100
Subject: [PATCH] regmap: irq: add an option to clear status registers on
 unmask

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-irq.c | 23 +++++++++++++++++++++++
 include/linux/regmap.h           |  4 ++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 31d23c9a5ae7..1bd1145ad8b5 100644
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
 
@@ -474,6 +494,9 @@ int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
 	if (chip->num_regs <= 0)
 		return -EINVAL;
 
+	if (chip->clear_on_unmask && (chip->ack_base || chip->use_ack))
+		return -EINVAL;
+
 	for (i = 0; i < chip->num_irqs; i++) {
 		if (chip->irqs[i].reg_offset % map->reg_stride)
 			return -EINVAL;
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 0f1832e4c2c8..1781b6cb793c 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1155,6 +1155,9 @@ struct regmap_irq {
  * @type_in_mask: Use the mask registers for controlling irq type. For
  *                interrupts defining type_rising/falling_mask use mask_base
  *                for edge configuration and never update bits in type_base.
+ * @clear_on_unmask: For chips with interrupts cleared on read: read the status
+ *                   registers before unmasking interrupts to clear any bits
+ *                   set when they were masked.
  * @runtime_pm:  Hold a runtime PM lock on the device when accessing it.
  *
  * @num_regs:    Number of registers in each control bank.
@@ -1194,6 +1197,7 @@ struct regmap_irq_chip {
 	bool runtime_pm:1;
 	bool type_invert:1;
 	bool type_in_mask:1;
+	bool clear_on_unmask:1;
 
 	int num_regs;
 
-- 
2.19.0.rc2

