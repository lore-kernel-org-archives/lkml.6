Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDE3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C27B20779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C27B20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388762AbeGWR4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:56:40 -0400
Received: from bran.ispras.ru ([83.149.199.196]:25583 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728206AbeGWR4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:56:40 -0400
Received: from myklebust.intra.ispras.ru (unknown [10.10.2.207])
        by smtp.ispras.ru (Postfix) with ESMTP id 8DF12203C3;
        Mon, 23 Jul 2018 19:54:33 +0300 (MSK)
From:   Anton Vasilyev <vasilyev@ispras.ru>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Anton Vasilyev <vasilyev@ispras.ru>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] gpio: ml-ioh: Fix buffer underwrite on probe error path
Date:   Mon, 23 Jul 2018 19:53:30 +0300
Message-Id: <20180723165330.25213-1-vasilyev@ispras.ru>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If ioh_gpio_probe() fails on devm_irq_alloc_descs() then chip may point
to any element of chip_save array, so reverse iteration from pointer chip
may become chip_save[-1] and gpiochip_remove() will operate with wrong
memory.

The patch fix the error path of ioh_gpio_probe() to correctly bypass
chip_save array.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
 drivers/gpio/gpio-ml-ioh.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-ml-ioh.c b/drivers/gpio/gpio-ml-ioh.c
index b23d9a36be1f..51c7d1b84c2e 100644
--- a/drivers/gpio/gpio-ml-ioh.c
+++ b/drivers/gpio/gpio-ml-ioh.c
@@ -496,9 +496,10 @@ static int ioh_gpio_probe(struct pci_dev *pdev,
 	return 0;
 
 err_gpiochip_add:
+	chip = chip_save;
 	while (--i >= 0) {
-		chip--;
 		gpiochip_remove(&chip->gpio);
+		chip++;
 	}
 	kfree(chip_save);
 
-- 
2.18.0

