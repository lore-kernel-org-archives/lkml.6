Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64194C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 16:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CB842086B
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 16:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB842086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbeKYDXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 22:23:33 -0500
Received: from www.osadl.org ([62.245.132.105]:37281 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbeKYDXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 22:23:32 -0500
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id wAOGXQgb014525;
        Sat, 24 Nov 2018 17:33:26 +0100
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] pinctrl: rza1: report if devm_kasptrinf() fails
Date:   Sat, 24 Nov 2018 17:30:33 +0100
Message-Id: <1543077033-7016-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_kasprintf() may return NULL on failure of internal allocation 
thus the assignments are not safe if not checked. On error
rza1_pinctrl_register() respectively rza1_parse_gpiochip() return
negative values so -ENOMEM in the (unlikely) failure case of 
devm_kasprintf() should be fine here. 

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 5a49b644b307 ("pinctrl: Renesas RZ/A1 pin and gpio controller")
---

Problem was located with an experimental coccinelle script

The dev_err() for this unlikely case is added so that a failures of
rza1_pinctrl_register() respectively rza1_parse_gpiochip() can be
understood as currently the negative return value is simply passed up
the call stack but it would be hard to identify the cause.

Patch was compile tested with: shmobile_defconfig (implies PINCTRL_RZA1=y)

Patch is against 4.20-rc3 (localversion-next is next-20181123)

 drivers/pinctrl/pinctrl-rza1.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-rza1.c b/drivers/pinctrl/pinctrl-rza1.c
index 14eb576..2533df4 100644
--- a/drivers/pinctrl/pinctrl-rza1.c
+++ b/drivers/pinctrl/pinctrl-rza1.c
@@ -1225,6 +1225,11 @@ static int rza1_parse_gpiochip(struct rza1_pinctrl *rza1_pctl,
 	chip->base	= -1;
 	chip->label	= devm_kasprintf(rza1_pctl->dev, GFP_KERNEL, "%pOFn",
 					 np);
+	if (!chip->label) {
+		dev_err(rza1_pctl->dev, "Failed to allocate label\n");
+		return -ENOMEM;
+	}
+
 	chip->ngpio	= of_args.args[2];
 	chip->of_node	= np;
 	chip->parent	= rza1_pctl->dev;
@@ -1326,6 +1331,11 @@ static int rza1_pinctrl_register(struct rza1_pinctrl *rza1_pctl)
 		pins[i].number = i;
 		pins[i].name = devm_kasprintf(rza1_pctl->dev, GFP_KERNEL,
 					      "P%u-%u", port, pin);
+		if (!pins[i].name) {
+			dev_err(rza1_pctl->dev,
+				"RZ/A1 pin controller allocation failed\n");
+			return -ENOMEM;
+		}
 
 		if (i % RZA1_PINS_PER_PORT == 0) {
 			/*
-- 
2.1.4

