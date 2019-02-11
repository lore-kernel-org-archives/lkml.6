Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39132C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6EC222A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897049;
	bh=8OCIOAXaxylSTZqze/oDBmDjrWo091/A3ZJ6mYd/Ncc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MIeyZeTqrjdj4c6rdCYcIXV5zjvXr3UGH/CFmvGenfm3uJfgNj/tnFKBL9L78Jt4K
	 /9HK7pFVkmyjpaK/HI6wSoAnWEvOzWEAPGj9qY54MtK1s0j//jo6uBSZ84nCew6UBi
	 MJHg90hJLzIHIxcQGz1dYEjgf4sm4iAPticrnAwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389354AbfBKO50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:57:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:44768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388835AbfBKO5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:57:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B566A2229E;
        Mon, 11 Feb 2019 14:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897041;
        bh=8OCIOAXaxylSTZqze/oDBmDjrWo091/A3ZJ6mYd/Ncc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b7ka8LvBIjQUaRnodLvtxwmpCo/hRLVw+6snZ93gIErk+4c5M8mzzeoHDv76nD681
         mvLC/WHDh5sblsWNVQ7h3AxuyFmFqvtyEUJpRwvWV3OsZI31xx+OSHgtTmOK/Lwor+
         DaMUjjG3oWy8/pCbcbUO6us2RbHVyL/o7gYietgw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 071/205] pinctrl: sx150x: handle failure case of devm_kstrdup
Date:   Mon, 11 Feb 2019 15:17:49 +0100
Message-Id: <20190211141833.373147740@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit a9d9f6b83f1bb05da849b3540e6d1f70ef1c2343 ]

devm_kstrdup() may return NULL if internal allocation failed.
Thus using  label, name  is unsafe without checking. Therefor
in the unlikely case of allocation failure, sx150x_probe() simply
returns -ENOMEM.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 9e80f9064e73 ("pinctrl: Add SX150X GPIO Extender Pinctrl Driver")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-sx150x.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-sx150x.c b/drivers/pinctrl/pinctrl-sx150x.c
index 70a0228f4e7f..2d0f4f760326 100644
--- a/drivers/pinctrl/pinctrl-sx150x.c
+++ b/drivers/pinctrl/pinctrl-sx150x.c
@@ -1166,7 +1166,6 @@ static int sx150x_probe(struct i2c_client *client,
 	}
 
 	/* Register GPIO controller */
-	pctl->gpio.label = devm_kstrdup(dev, client->name, GFP_KERNEL);
 	pctl->gpio.base = -1;
 	pctl->gpio.ngpio = pctl->data->npins;
 	pctl->gpio.get_direction = sx150x_gpio_get_direction;
@@ -1180,6 +1179,10 @@ static int sx150x_probe(struct i2c_client *client,
 	pctl->gpio.of_node = dev->of_node;
 #endif
 	pctl->gpio.can_sleep = true;
+	pctl->gpio.label = devm_kstrdup(dev, client->name, GFP_KERNEL);
+	if (!pctl->gpio.label)
+		return -ENOMEM;
+
 	/*
 	 * Setting multiple pins is not safe when all pins are not
 	 * handled by the same regmap register. The oscio pin (present
@@ -1200,13 +1203,15 @@ static int sx150x_probe(struct i2c_client *client,
 
 	/* Add Interrupt support if an irq is specified */
 	if (client->irq > 0) {
-		pctl->irq_chip.name = devm_kstrdup(dev, client->name,
-						   GFP_KERNEL);
 		pctl->irq_chip.irq_mask = sx150x_irq_mask;
 		pctl->irq_chip.irq_unmask = sx150x_irq_unmask;
 		pctl->irq_chip.irq_set_type = sx150x_irq_set_type;
 		pctl->irq_chip.irq_bus_lock = sx150x_irq_bus_lock;
 		pctl->irq_chip.irq_bus_sync_unlock = sx150x_irq_bus_sync_unlock;
+		pctl->irq_chip.name = devm_kstrdup(dev, client->name,
+						   GFP_KERNEL);
+		if (!pctl->irq_chip.name)
+			return -ENOMEM;
 
 		pctl->irq.masked = ~0;
 		pctl->irq.sense = 0;
-- 
2.19.1



