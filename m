Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56300C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E084218A3
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfAFIjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 03:39:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:57184 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726438AbfAFIiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 03:38:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 04EB1ACAE;
        Sun,  6 Jan 2019 08:38:03 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-lpwan@lists.infradead.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH lora-next 02/11] net: lora: sx130x: Fix error codes
Date:   Sun,  6 Jan 2019 09:37:45 +0100
Message-Id: <20190106083754.6004-3-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190106083754.6004-1-afaerber@suse.de>
References: <20190106083754.6004-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of -ENXIO results in a misleading error message from ip command:

  RTNETLINK answers: No such device or address

Switch to -EIO for more accurate description:

  RTNETLINK answers: Input/output error

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/net/lora/sx130x.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/lora/sx130x.c b/drivers/net/lora/sx130x.c
index 88d4ce1aabcf..21db0ddb101f 100644
--- a/drivers/net/lora/sx130x.c
+++ b/drivers/net/lora/sx130x.c
@@ -353,7 +353,7 @@ static int sx130x_agc_calibrate(struct sx130x_priv *priv)
 	if (val != SX1301_MCU_AGC_CAL_FW_VERSION) {
 		dev_err(priv->dev, "unexpected firmware version, expecting %u\n",
 				SX1301_MCU_AGC_CAL_FW_VERSION);
-		return -ENXIO;
+		return -EIO;
 	}
 
 	ret = sx130x_field_write(priv, F_EMERGENCY_FORCE_HOST_CTRL, 0);
@@ -380,7 +380,7 @@ static int sx130x_agc_calibrate(struct sx130x_priv *priv)
 	dev_info(priv->dev, "AGC status: %02x\n", (unsigned)val);
 	if ((val & (BIT(7) | BIT(0))) != (BIT(7) | BIT(0))) {
 		dev_err(priv->dev, "AGC calibration failed\n");
-		return -ENXIO;
+		return -EIO;
 	}
 
 	return 0;
@@ -453,7 +453,7 @@ static int sx130x_load_all_firmware(struct sx130x_priv *priv)
 	if (val != SX1301_MCU_AGC_FW_VERSION) {
 		dev_err(priv->dev, "unexpected firmware version, expecting %u\n",
 				SX1301_MCU_AGC_FW_VERSION);
-		return -ENXIO;
+		return -EIO;
 	}
 
 	ret = sx130x_arb_ram_read(priv, 0x20, &val);
@@ -467,7 +467,7 @@ static int sx130x_load_all_firmware(struct sx130x_priv *priv)
 	if (val != SX1301_MCU_ARB_FW_VERSION) {
 		dev_err(priv->dev, "unexpected firmware version, expecting %u\n",
 				SX1301_MCU_ARB_FW_VERSION);
-		return -ENXIO;
+		return -EIO;
 	}
 
 	return 0;
@@ -636,7 +636,7 @@ int sx130x_probe(struct device *dev)
 
 	if (ver != SX1301_CHIP_VERSION) {
 		dev_err(dev, "unexpected version: %u\n", ver);
-		return -ENXIO;
+		return -EIO;
 	}
 
 	ret = regmap_write(priv->regmap, SX1301_PAGE, 0);
-- 
2.16.4

