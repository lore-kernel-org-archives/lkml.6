Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933178AbeBLWya (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:54:30 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37576 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932938AbeBLWsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:37 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 21/45] rtc: ds1343: simplify regmap initialization
Date: Mon, 12 Feb 2018 23:47:35 +0100
Message-Id: <20180212224759.15999-22-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
References: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid using memset as gcc can properly initialize structures.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1343.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-ds1343.c b/drivers/rtc/rtc-ds1343.c
index 895fbeeb47fe..b5102cdd7f61 100644
--- a/drivers/rtc/rtc-ds1343.c
+++ b/drivers/rtc/rtc-ds1343.c
@@ -599,15 +599,11 @@ static const struct rtc_class_ops ds1343_rtc_ops = {
 static int ds1343_probe(struct spi_device *spi)
 {
 	struct ds1343_priv *priv;
-	struct regmap_config config;
+	struct regmap_config config = { .reg_bits = 8, .val_bits = 8,
+					.write_flag_mask = 0x80, };
 	unsigned int data;
 	int res;
 
-	memset(&config, 0, sizeof(config));
-	config.reg_bits = 8;
-	config.val_bits = 8;
-	config.write_flag_mask = 0x80;
-
 	priv = devm_kzalloc(&spi->dev, sizeof(struct ds1343_priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
-- 
2.16.1
