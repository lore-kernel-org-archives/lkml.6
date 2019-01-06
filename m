Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E935C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579682184C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfAFIiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 03:38:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:57236 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726477AbfAFIiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 03:38:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CA9FAADF2;
        Sun,  6 Jan 2019 08:38:04 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-lpwan@lists.infradead.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Ben Whitten <ben.whitten@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH lora-next 07/11] net: lora: sx130x: Force regmap field writes before function boundaries
Date:   Sun,  6 Jan 2019 09:37:50 +0100
Message-Id: <20190106083754.6004-8-afaerber@suse.de>
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

As a cautionary step, force writing out registers before calling helpers
or returning.

Cc: Ben Whitten <ben.whitten@gmail.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/net/lora/sx130x.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/lora/sx130x.c b/drivers/net/lora/sx130x.c
index bc2d4b1165d8..a0759e277574 100644
--- a/drivers/net/lora/sx130x.c
+++ b/drivers/net/lora/sx130x.c
@@ -315,7 +315,7 @@ static int sx130x_load_firmware(struct sx130x_priv *priv, int mcu, const struct
 
 	kfree(buf);
 
-	ret = sx130x_field_write(priv, select_mux, 1);
+	ret = sx130x_field_force_write(priv, select_mux, 1);
 	if (ret) {
 		dev_err(priv->dev, "MCU RAM release mux failed\n");
 		return ret;
@@ -359,7 +359,7 @@ static int sx130x_agc_calibrate(struct sx130x_priv *priv)
 		return ret;
 	}
 
-	ret = sx130x_field_write(priv, F_MCU_RST_1, 0);
+	ret = sx130x_field_force_write(priv, F_MCU_RST_1, 0);
 	if (ret) {
 		dev_err(priv->dev, "MCU 1 reset failed\n");
 		return ret;
@@ -459,7 +459,7 @@ static int sx130x_load_all_firmware(struct sx130x_priv *priv)
 		return ret;
 	}
 
-	ret = sx130x_field_write(priv, F_MCU_RST_1, 0);
+	ret = sx130x_field_force_write(priv, F_MCU_RST_1, 0);
 	if (ret) {
 		dev_err(priv->dev, "MCU 1 release failed\n");
 		return ret;
@@ -542,7 +542,7 @@ static int sx130x_loradev_open(struct net_device *netdev)
 		goto err_reg;
 	}
 
-	ret = sx130x_field_write(priv, F_CLK32M_EN, 1);
+	ret = sx130x_field_force_write(priv, F_CLK32M_EN, 1);
 	if (ret) {
 		dev_err(priv->dev, "enable 32M clock failed (%d)\n", ret);
 		goto err_reg;
@@ -708,7 +708,7 @@ int sx130x_probe(struct device *dev)
 
 	msleep(5);
 
-	ret = sx130x_field_write(priv, F_RADIO_RST, 0);
+	ret = sx130x_field_force_write(priv, F_RADIO_RST, 0);
 	if (ret) {
 		dev_err(dev, "radio deassert reset failed (%d)\n", ret);
 		return ret;
-- 
2.16.4

