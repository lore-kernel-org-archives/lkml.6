Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9460BC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4A420838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4A420838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbeLGKim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:38:42 -0500
Received: from www.osadl.org ([62.245.132.105]:36688 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbeLGKil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:38:41 -0500
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id wB7AbVAV016632;
        Fri, 7 Dec 2018 11:37:31 +0100
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH V2] pinctrl: rza1: handle devm_kasprintf() failure cases
Date:   Fri,  7 Dec 2018 11:34:27 +0100
Message-Id: <1544178867-13169-1-git-send-email-hofrat@osadl.org>
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

Problem was located with an experimental coccinelle script

V2: drop the dev_err() messages as requested by Geert Uytterhoeven
    <geert@linux-m68k.org> - thanks !

Patch was compile tested with: shmobile_defconfig (implies PINCTRL_RZA1=y)

Patch is against 4.20-rc5 (localversion-next is next-20181207)

 drivers/pinctrl/pinctrl-rza1.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-rza1.c b/drivers/pinctrl/pinctrl-rza1.c
index 14eb576..9cfe9d0 100644
--- a/drivers/pinctrl/pinctrl-rza1.c
+++ b/drivers/pinctrl/pinctrl-rza1.c
@@ -1225,6 +1225,9 @@ static int rza1_parse_gpiochip(struct rza1_pinctrl *rza1_pctl,
 	chip->base	= -1;
 	chip->label	= devm_kasprintf(rza1_pctl->dev, GFP_KERNEL, "%pOFn",
 					 np);
+	if (!chip->label)
+		return -ENOMEM;
+
 	chip->ngpio	= of_args.args[2];
 	chip->of_node	= np;
 	chip->parent	= rza1_pctl->dev;
@@ -1326,6 +1329,8 @@ static int rza1_pinctrl_register(struct rza1_pinctrl *rza1_pctl)
 		pins[i].number = i;
 		pins[i].name = devm_kasprintf(rza1_pctl->dev, GFP_KERNEL,
 					      "P%u-%u", port, pin);
+		if (!pins[i].name)
+			return -ENOMEM;
 
 		if (i % RZA1_PINS_PER_PORT == 0) {
 			/*
-- 
2.1.4

