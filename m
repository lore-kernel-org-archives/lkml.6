Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA73C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A9920856
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548695941;
	bh=Uwr4dWGAsV4+A0M6VpMaibSMQ0CMvPDgdj4xvIvbNFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tu5rcqLveaUMP+7Jt4wwtyf4A8hh0k1VhELlR3EBfJQ0oLTvVziqXAwdH+fx2PTbE
	 85zR9s0ldAaG1mriscygYwbaMzVe5OMP022wx3/MGX/Pz1GffP675hPZDf+vOLX8e3
	 hk4LlcHAYiYSJtQ3NqYIKexRECOMjLo3qai1zHbk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731951AbfA1RTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:19:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:51136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728490AbfA1QFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:05:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADCD521738;
        Mon, 28 Jan 2019 16:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691499;
        bh=Uwr4dWGAsV4+A0M6VpMaibSMQ0CMvPDgdj4xvIvbNFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JhaCrVw/3ZlsTkvKnT4Re493PoJleCnyZNnrh+EBYYDWijprYRFNq8mhLQACzrHkL
         hgxU9NoEazQPMwn67fX/cntcJgcqkeUReEkSBzzcYW6rkqfRN7Cwv7XLHLFiiYddQx
         T3CDH/DeHVDQsjzWGYxIFMaXuaqvWD5zIt49xhYE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 117/258] pinctrl: sx150x: handle failure case of devm_kstrdup
Date:   Mon, 28 Jan 2019 10:57:03 -0500
Message-Id: <20190128155924.51521-117-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

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
index cbf58a10113d..4d87d75b9c6e 100644
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

