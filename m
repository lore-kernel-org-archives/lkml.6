Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0714EC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A9D20672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A9D20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeLJQuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:50:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:49188 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727062AbeLJQuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:50:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D5286B002;
        Mon, 10 Dec 2018 16:50:14 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        dave.stevenson@raspberrypi.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: raspberrypi-exp: decrease refcount on firmware dt node
Date:   Mon, 10 Dec 2018 17:50:05 +0100
Message-Id: <20181210165005.27965-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're getting a reference RPi's firmware node in order to be able to
communicate with it's driver. We should decrease the reference count on
the dt node after being done with it.

Fixes: a98d90e7d588 ("gpio: raspberrypi-exp: Driver for RPi3 GPIO expander via mailbox service")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/gpio/gpio-raspberrypi-exp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-raspberrypi-exp.c b/drivers/gpio/gpio-raspberrypi-exp.c
index d6d36d537e37..b77ea16ffa03 100644
--- a/drivers/gpio/gpio-raspberrypi-exp.c
+++ b/drivers/gpio/gpio-raspberrypi-exp.c
@@ -206,6 +206,7 @@ static int rpi_exp_gpio_probe(struct platform_device *pdev)
 	}
 
 	fw = rpi_firmware_get(fw_node);
+	of_node_put(fw_node);
 	if (!fw)
 		return -EPROBE_DEFER;
 
-- 
2.19.2

