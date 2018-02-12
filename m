Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933197AbeBLW5c (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:57:32 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37523 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932252AbeBLWs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:26 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 06/45] rtc: ds1305: call rtc_nvmem_register()
Date: Mon, 12 Feb 2018 23:47:20 +0100
Message-Id: <20180212224759.15999-7-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
References: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call rtc_nvmem_register instead of letting the core do it and stop using
the nvmem_config member of struct rtc_device.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1305.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ds1305.c b/drivers/rtc/rtc-ds1305.c
index d8df2e9e14ad..affa90da26f1 100644
--- a/drivers/rtc/rtc-ds1305.c
+++ b/drivers/rtc/rtc-ds1305.c
@@ -703,15 +703,15 @@ static int ds1305_probe(struct spi_device *spi)
 	ds1305->rtc->ops = &ds1305_ops;
 
 	ds1305_nvmem_cfg.priv = ds1305;
-	ds1305->rtc->nvmem_config = &ds1305_nvmem_cfg;
 	ds1305->rtc->nvram_old_abi = true;
-
 	status = rtc_register_device(ds1305->rtc);
 	if (status) {
 		dev_dbg(&spi->dev, "register rtc --> %d\n", status);
 		return status;
 	}
 
+	rtc_nvmem_register(ds1305->rtc, &ds1305_nvmem_cfg);
+
 	/* Maybe set up alarm IRQ; be ready to handle it triggering right
 	 * away.  NOTE that we don't share this.  The signal is active low,
 	 * and we can't ack it before a SPI message delay.  We temporarily
-- 
2.16.1
