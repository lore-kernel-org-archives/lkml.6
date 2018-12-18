Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2537BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF882217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbeLRK62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:58:28 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36517 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbeLRK61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:58:27 -0500
Received: by mail-lj1-f195.google.com with SMTP id g11-v6so13818925ljk.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 02:58:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=UptjuTjRojbxcQjZDmBdO2AOGjImP2Gd9mA9W5E6PDE=;
        b=VAPGSmpGYWEhtc8+gd95yq6W3HJU9ADTQ2fCh5VkEC5fx0wTHLmbbPEywWWjTEPTRG
         miGxObhEKAn/A53WTStM4Z/WHyPXNxvHivzPxcyYv89Z5xAI6IatvYVxXJ1poxieF4bi
         pwVOC3STNl+/QsVThwmERtVkwqFOKS7D/cPTb462UN6B7b7TLFmXu9O5lURBM8UC756Q
         rqGlH+Mt3lUs5wU5VDE5Kb9PS0PbegcfwcVuqHBSJ5USh2p4LARolwgWnYs5OqX3wXe7
         0ap08xxpNZUdfUeIh4N1XY/ksvp1BeqDYi/fZ2sDYFyJgbnn88K19JpbMYGi6OTYcAnt
         dP8Q==
X-Gm-Message-State: AA+aEWZExLDn90s6BkG8z3lkg00oB+F7oD/d4iZcNozc4+CCi8dBZ6LK
        d7V1E2BEiBke4WfzWPEM6Ok=
X-Google-Smtp-Source: AFSGD/ULRqz1Cb4lEWoomSrDJZCeMoMizh5G4QId+Z0iJRrdTBd0iO66/MbI0ZHtGajsJfdO6bm29A==
X-Received: by 2002:a2e:88cf:: with SMTP id a15-v6mr9580843ljk.76.1545130705780;
        Tue, 18 Dec 2018 02:58:25 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id x18-v6sm3230984lji.27.2018.12.18.02.58.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 02:58:25 -0800 (PST)
Date:   Tue, 18 Dec 2018 12:58:13 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        ldewangan@nvidia.com, linux-kernel@vger.kernel.org
Subject: [PATCH] regmap: regmap-irq: Remove default irq type setting from core
Message-ID: <20181218105813.GA6957@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The common code should not set IRQ type. Read HW defaults to the
cache at startup instead of forcing type to EDGE_BOTH. If
default setting is needed this should be done via normal
mechanisms or by chip specific code if normal mechanisms are not
suitable for some reason. Common regmap-irq code should not have
defaults hard-coded but keep the HW/boot defaults untouched.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
So let's try removing the hard-coded default setting from generic
regmap-irq code as discussed with Mark here:
https://lore.kernel.org/lkml/20181217180722.GG27909@sirena.org.uk/

Core code should not care about the default trigger level - such
settings should be done by code which knows the target
platform/board.

I was not able to test this change as I have no max77620 which seems to
be the only user of regmap-irq type-setting in tree as of now.

The patch was created on top of the regulator-next tree, with
"regmap: irq: handle HW using separate rising/falling edge interrupts"
from Bartosz Golaszewski cherry-picked. This should still cleanly apply
on regmap-tree.

 drivers/base/regmap/regmap-irq.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 603b1554f81c..8b216b2e2c19 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -625,26 +625,20 @@ int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
 	}
 
 	if (chip->num_type_reg && !chip->type_in_mask) {
-		for (i = 0; i < chip->num_irqs; i++) {
-			reg = chip->irqs[i].type_reg_offset / map->reg_stride;
-			d->type_buf_def[reg] |= chip->irqs[i].type_rising_mask |
-					chip->irqs[i].type_falling_mask;
-		}
 		for (i = 0; i < chip->num_type_reg; ++i) {
 			if (!d->type_buf_def[i])
 				continue;
 
 			reg = chip->type_base +
 				(i * map->reg_stride * d->type_reg_stride);
-			if (chip->type_invert)
-				ret = regmap_irq_update_bits(d, reg,
-					d->type_buf_def[i], 0xFF);
-			else
-				ret = regmap_irq_update_bits(d, reg,
-					d->type_buf_def[i], 0x0);
-			if (ret != 0) {
-				dev_err(map->dev,
-					"Failed to set type in 0x%x: %x\n",
+
+			ret = regmap_read(map, reg, &d->type_buf_def[i]);
+
+			if (d->chip->type_invert)
+				d->type_buf_def[i] = ~d->type_buf_def[i];
+
+			if (ret) {
+				dev_err(map->dev, "Failed to get type defaults at 0x%x: %d\n",
 					reg, ret);
 				goto err_alloc;
 			}
-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
