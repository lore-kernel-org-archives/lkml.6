Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F387C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569822184C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfAFIiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 03:38:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:57222 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726508AbfAFIiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 03:38:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1C747ACFA;
        Sun,  6 Jan 2019 08:38:04 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-lpwan@lists.infradead.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Ben Whitten <ben.whitten@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH lora-next 05/11] net: lora: sx130x: Fix regmap field toggles
Date:   Sun,  6 Jan 2019 09:37:48 +0100
Message-Id: <20190106083754.6004-6-afaerber@suse.de>
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

When toggling the value of a regmap field, such as for F_RADIO_RST or
F_EMERGENCY_FORCE_HOST_CTRL, we need to ensure it gets written out.

Sadly the timing of the writes got lost in the regmap field conversion.

Introduce an sx130x_field_force_write() helper for this.
While at it, make trivial sx130x_field_write() static inline, too.

Cc: Ben Whitten <ben.whitten@gmail.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/net/lora/sx130x.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/lora/sx130x.c b/drivers/net/lora/sx130x.c
index 4ba02836a35d..457f2396d9ee 100644
--- a/drivers/net/lora/sx130x.c
+++ b/drivers/net/lora/sx130x.c
@@ -174,12 +174,18 @@ const struct regmap_config sx130x_regmap_config = {
 };
 EXPORT_SYMBOL_GPL(sx130x_regmap_config);
 
-static int sx130x_field_write(struct sx130x_priv *priv,
+static inline int sx130x_field_write(struct sx130x_priv *priv,
 		enum sx130x_fields field_id, u8 val)
 {
 	return regmap_field_write(priv->regmap_fields[field_id], val);
 }
 
+static inline int sx130x_field_force_write(struct sx130x_priv *priv,
+		enum sx130x_fields field_id, u8 val)
+{
+	return regmap_field_force_write(priv->regmap_fields[field_id], val);
+}
+
 static int sx130x_soft_reset(struct sx130x_priv *priv)
 {
 	int ret;
@@ -373,7 +379,7 @@ static int sx130x_agc_calibrate(struct sx130x_priv *priv)
 		return -EIO;
 	}
 
-	ret = sx130x_field_write(priv, F_EMERGENCY_FORCE_HOST_CTRL, 0);
+	ret = sx130x_field_force_write(priv, F_EMERGENCY_FORCE_HOST_CTRL, 0);
 	if (ret) {
 		dev_err(priv->dev, "emergency force failed\n");
 		return ret;
@@ -694,7 +700,7 @@ int sx130x_probe(struct device *dev)
 
 	msleep(500);
 
-	ret = sx130x_field_write(priv, F_RADIO_RST, 1);
+	ret = sx130x_field_force_write(priv, F_RADIO_RST, 1);
 	if (ret) {
 		dev_err(dev, "radio assert reset failed (%d)\n", ret);
 		return ret;
-- 
2.16.4

