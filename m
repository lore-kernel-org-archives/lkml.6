Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABC2C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA292173B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbfADLVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 06:21:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:52408 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727625AbfADLVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 06:21:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1F256AE65;
        Fri,  4 Jan 2019 11:21:44 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-lpwan@lists.infradead.org, linux-serial@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: [PATCH lora-next 2/5] net: lora: sx130x: Prepare storing driver-specific data
Date:   Fri,  4 Jan 2019 12:21:28 +0100
Message-Id: <20190104112131.14451-3-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190104112131.14451-1-afaerber@suse.de>
References: <20190104112131.14451-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers (e.g., serdev) may need to access private data not part of
the core sx130x_priv, which is inaccessible to other source files.
As the sx130x core expects to obtain the net_device from the dev's drvdata,
we can't reuse that in derived drivers and need a new field plus helpers.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/net/lora/sx130x.c   | 19 +++++++++++++++++++
 include/linux/lora/sx130x.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/lora/sx130x.c b/drivers/net/lora/sx130x.c
index 840052955874..978c921ca5ec 100644
--- a/drivers/net/lora/sx130x.c
+++ b/drivers/net/lora/sx130x.c
@@ -58,6 +58,7 @@ struct sx130x_priv {
 	struct regmap		*regmap;
 	struct regmap_field	*regmap_fields[ARRAY_SIZE(sx130x_regmap_fields)];
 	struct mutex		io_lock;
+	void			*drvdata;
 };
 
 struct regmap *sx130x_get_regmap(struct device *dev)
@@ -68,6 +69,24 @@ struct regmap *sx130x_get_regmap(struct device *dev)
 	return priv->regmap;
 }
 
+void sx130x_set_drvdata(struct device *dev, void *drvdata)
+{
+	struct net_device *netdev = dev_get_drvdata(dev);
+	struct sx130x_priv *priv = netdev_priv(netdev);
+
+	priv->drvdata = drvdata;
+}
+EXPORT_SYMBOL_GPL(sx130x_set_drvdata);
+
+void *sx130x_get_drvdata(struct device *dev)
+{
+	struct net_device *netdev = dev_get_drvdata(dev);
+	struct sx130x_priv *priv = netdev_priv(netdev);
+
+	return priv->drvdata;
+}
+EXPORT_SYMBOL_GPL(sx130x_get_drvdata);
+
 void sx130x_io_lock(struct device *dev)
 {
 	struct net_device *netdev = dev_get_drvdata(dev);
diff --git a/include/linux/lora/sx130x.h b/include/linux/lora/sx130x.h
index d6f027ef283f..85b088ec77b8 100644
--- a/include/linux/lora/sx130x.h
+++ b/include/linux/lora/sx130x.h
@@ -14,6 +14,8 @@
 #include <linux/regmap.h>
 
 extern const struct regmap_config sx130x_regmap_config;
+void sx130x_set_drvdata(struct device *dev, void *drvdata);
+void *sx130x_get_drvdata(struct device *dev);
 int sx130x_early_probe(struct regmap *regmap, struct gpio_desc *rst);
 int sx130x_probe(struct device *dev);
 int sx130x_remove(struct device *dev);
-- 
2.16.4

