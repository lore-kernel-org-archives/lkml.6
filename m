Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754606AbeDBXRU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 19:17:20 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:41885 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754550AbeDBXRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 19:17:19 -0400
X-Google-Smtp-Source: AIpwx49xYSqsPD/wLhu6WjJJGdw+dKUO82CjUYDpy47WK7vvNnB8ot8MJiwk4aGpwV390OZI2zK4wg==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: jonas.gorski@gmail.com, Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: dsa: b53: Fix sparse warnings in b53_mmap.c
Date: Mon,  2 Apr 2018 16:17:01 -0700
Message-Id: <20180402231701.17348-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse complains about the following warnings:

drivers/net/dsa/b53/b53_mmap.c:33:31: warning: incorrect type in
initializer (different address spaces)
drivers/net/dsa/b53/b53_mmap.c:33:31:    expected unsigned char
[noderef] [usertype] <asn:2>*regs
drivers/net/dsa/b53/b53_mmap.c:33:31:    got void *priv

and indeed, while what we are doing is functional, we are dereferencing
a void * pointer into a void __iomem * which is not great. Just use the
defined b53_mmap_priv structure which holds our register base and use
that.

Fixes: 967dd82ffc52 ("net: dsa: b53: Add support for Broadcom RoboSwitch")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/dsa/b53/b53_mmap.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_mmap.c b/drivers/net/dsa/b53/b53_mmap.c
index ef63d24fef81..c628d0980c0b 100644
--- a/drivers/net/dsa/b53/b53_mmap.c
+++ b/drivers/net/dsa/b53/b53_mmap.c
@@ -30,7 +30,8 @@ struct b53_mmap_priv {
 
 static int b53_mmap_read8(struct b53_device *dev, u8 page, u8 reg, u8 *val)
 {
-	u8 __iomem *regs = dev->priv;
+	struct b53_mmap_priv *priv = dev->priv;
+	void __iomem *regs = priv->regs;
 
 	*val = readb(regs + (page << 8) + reg);
 
@@ -39,7 +40,8 @@ static int b53_mmap_read8(struct b53_device *dev, u8 page, u8 reg, u8 *val)
 
 static int b53_mmap_read16(struct b53_device *dev, u8 page, u8 reg, u16 *val)
 {
-	u8 __iomem *regs = dev->priv;
+	struct b53_mmap_priv *priv = dev->priv;
+	void __iomem *regs = priv->regs;
 
 	if (WARN_ON(reg % 2))
 		return -EINVAL;
@@ -54,7 +56,8 @@ static int b53_mmap_read16(struct b53_device *dev, u8 page, u8 reg, u16 *val)
 
 static int b53_mmap_read32(struct b53_device *dev, u8 page, u8 reg, u32 *val)
 {
-	u8 __iomem *regs = dev->priv;
+	struct b53_mmap_priv *priv = dev->priv;
+	void __iomem *regs = priv->regs;
 
 	if (WARN_ON(reg % 4))
 		return -EINVAL;
@@ -69,7 +72,8 @@ static int b53_mmap_read32(struct b53_device *dev, u8 page, u8 reg, u32 *val)
 
 static int b53_mmap_read48(struct b53_device *dev, u8 page, u8 reg, u64 *val)
 {
-	u8 __iomem *regs = dev->priv;
+	struct b53_mmap_priv *priv = dev->priv;
+	void __iomem *regs = priv->regs;
 
 	if (WARN_ON(reg % 2))
 		return -EINVAL;
@@ -107,7 +111,8 @@ static int b53_mmap_read48(struct b53_device *dev, u8 page, u8 reg, u64 *val)
 
 static int b53_mmap_read64(struct b53_device *dev, u8 page, u8 reg, u64 *val)
 {
-	u8 __iomem *regs = dev->priv;
+	struct b53_mmap_priv *priv = dev->priv;
+	void __iomem *regs = priv->regs;
 	u32 hi, lo;
 
 	if (WARN_ON(reg % 4))
@@ -128,7 +133,8 @@ static int b53_mmap_read64(struct b53_device *dev, u8 page, u8 reg, u64 *val)
 
 static int b53_mmap_write8(struct b53_device *dev, u8 page, u8 reg, u8 value)
 {
-	u8 __iomem *regs = dev->priv;
+	struct b53_mmap_priv *priv = dev->priv;
+	void __iomem *regs = priv->regs;
 
 	writeb(value, regs + (page << 8) + reg);
 
@@ -138,7 +144,8 @@ static int b53_mmap_write8(struct b53_device *dev, u8 page, u8 reg, u8 value)
 static int b53_mmap_write16(struct b53_device *dev, u8 page, u8 reg,
 			    u16 value)
 {
-	u8 __iomem *regs = dev->priv;
+	struct b53_mmap_priv *priv = dev->priv;
+	void __iomem *regs = priv->regs;
 
 	if (WARN_ON(reg % 2))
 		return -EINVAL;
@@ -154,7 +161,8 @@ static int b53_mmap_write16(struct b53_device *dev, u8 page, u8 reg,
 static int b53_mmap_write32(struct b53_device *dev, u8 page, u8 reg,
 			    u32 value)
 {
-	u8 __iomem *regs = dev->priv;
+	struct b53_mmap_priv *priv = dev->priv;
+	void __iomem *regs = priv->regs;
 
 	if (WARN_ON(reg % 4))
 		return -EINVAL;
@@ -223,12 +231,19 @@ static const struct b53_io_ops b53_mmap_ops = {
 static int b53_mmap_probe(struct platform_device *pdev)
 {
 	struct b53_platform_data *pdata = pdev->dev.platform_data;
+	struct b53_mmap_priv *priv;
 	struct b53_device *dev;
 
 	if (!pdata)
 		return -EINVAL;
 
-	dev = b53_switch_alloc(&pdev->dev, &b53_mmap_ops, pdata->regs);
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->regs = pdata->regs;
+
+	dev = b53_switch_alloc(&pdev->dev, &b53_mmap_ops, priv);
 	if (!dev)
 		return -ENOMEM;
 
-- 
2.14.1
