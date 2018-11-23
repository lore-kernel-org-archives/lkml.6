Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9411FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D2B20685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D2B20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410156AbeKXDC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 22:02:57 -0500
Received: from www.osadl.org ([62.245.132.105]:55776 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410139AbeKXDC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 22:02:57 -0500
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id wANGFvuB020480;
        Fri, 23 Nov 2018 17:15:57 +0100
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Tomer Maimon <tmaimon77@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] pinctrl: nuvoton: check for devm_kasprintf() failure
Date:   Fri, 23 Nov 2018 17:12:58 +0100
Message-Id: <1542989578-21200-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_kasprintf() may return NULL on failure of internal allocation thus
the assignment to  .label  is not safe if not checked. On error
npcm7xx_gpio_of() returns negative values so -ENOMEM in the
(unlikely) failure case of devm_kasprintf() should be fine here.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 3b588e43ee5c ("pinctrl: nuvoton: add NPCM7xx pinctrl and GPIO driver")
---

Problem located with experimental coccinelle script

The only call-site is the probe function (npcm7xx_pinctrl_probe()) wich
will bail out on error - it seems like no further cleanup is expected.

Also while the code generally uses the  if (!var)  construct that would
not be very readable in this case so I think the:
     if (pctrl->gpio_bank[id].gc.label == NULL)
is more appropriate here not sure though what the general preference is.

Patch was compile tested with: multi_v7_defconfig + ARCH_NPCM=y,
ARCH_NPCM7XX=y (implies PINCTRL_NPCM7XX=y)
(sparse reports a number of "obsolete array initializer" warnings)

Patch is against 4.20-rc3 (localversion-next is next-20181123)

 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
index b455209..17f909d 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
@@ -1925,6 +1925,9 @@ static int npcm7xx_gpio_of(struct npcm7xx_pinctrl *pctrl)
 			pctrl->gpio_bank[id].gc.label =
 				devm_kasprintf(pctrl->dev, GFP_KERNEL, "%pOF",
 					       np);
+			if (pctrl->gpio_bank[id].gc.label == NULL)
+				return -ENOMEM;
+
 			pctrl->gpio_bank[id].gc.dbg_show = npcmgpio_dbg_show;
 			pctrl->gpio_bank[id].direction_input =
 				pctrl->gpio_bank[id].gc.direction_input;
-- 
2.1.4

