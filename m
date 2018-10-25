Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7938DECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF7120883
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oma9YBXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF7120883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731119AbeJYWxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:53:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbeJYWxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:53:33 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2F9D20883;
        Thu, 25 Oct 2018 14:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477235;
        bh=GzQQssWj+vwvgP7yLm+ItKkQ/L4GpmpQxQ4JnxtollU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oma9YBXIsY4ZIaZV6VtpvqbtwR9V5jqAdfEKx1Xk+pspZdwHgdxawmhVphX+De7ju
         rFUJLJhCgcYtyh8BEWY1ve5FfBe/duJp33RvRxOBvDtjF+mme+tzdkZE+JRrFlPE18
         8UEuGAfi0A3o/RyHwhRFZyHJ4TIRMYiiBGHAAHKc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 67/98] net: ethernet: davicom: fix devicetree irq resource
Date:   Thu, 25 Oct 2018 10:18:22 -0400
Message-Id: <20181025141853.214051-67-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Jarzmik <robert.jarzmik@free.fr>

[ Upstream commit b5a099c67a1c36b91356624ce86eb3f9f48a82c7 ]

The dm9000 driver doesn't work in at least one device-tree
configuration, spitting an error message on irq resource :
[    1.062495] dm9000 8000000.ethernet: insufficient resources
[    1.068439] dm9000 8000000.ethernet: not found (-2).
[    1.073451] dm9000: probe of 8000000.ethernet failed with error -2

The reason behind is that the interrupt might be provided by a gpio
controller, not probed when dm9000 is probed, and needing the probe
deferral mechanism to apply.

Currently, the interrupt is directly taken from resources. This patch
changes this to use the more generic platform_get_irq(), which handles
the deferral.

Moreover, since commit Fixes: 7085a7401ba5 ("drivers: platform: parse
IRQ flags from resources"), the interrupt trigger flags are honored in
platform_get_irq(), so remove the needless code in dm9000.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Acked-by: Marcel Ziswiler <marcel@ziswiler.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Tested-by: Sergei Ianovich <ynvich@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/davicom/dm9000.c | 34 +++++++++++++--------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/davicom/dm9000.c b/drivers/net/ethernet/davicom/dm9000.c
index f3ba840cbf7b..ef24b60b4d3f 100644
--- a/drivers/net/ethernet/davicom/dm9000.c
+++ b/drivers/net/ethernet/davicom/dm9000.c
@@ -125,7 +125,6 @@ struct board_info {
 	struct resource *data_res;
 	struct resource	*addr_req;   /* resources requested */
 	struct resource *data_req;
-	struct resource *irq_res;
 
 	int		 irq_wake;
 
@@ -1297,22 +1296,16 @@ static int
 dm9000_open(struct net_device *dev)
 {
 	struct board_info *db = netdev_priv(dev);
-	unsigned long irqflags = db->irq_res->flags & IRQF_TRIGGER_MASK;
 
 	if (netif_msg_ifup(db))
 		dev_dbg(db->dev, "enabling %s\n", dev->name);
 
-	/* If there is no IRQ type specified, default to something that
-	 * may work, and tell the user that this is a problem */
-
-	if (irqflags == IRQF_TRIGGER_NONE)
-		irqflags = irq_get_trigger_type(dev->irq);
-
-	if (irqflags == IRQF_TRIGGER_NONE)
+	/* If there is no IRQ type specified, tell the user that this is a
+	 * problem
+	 */
+	if (irq_get_trigger_type(dev->irq) == IRQF_TRIGGER_NONE)
 		dev_warn(db->dev, "WARNING: no IRQ resource flags set.\n");
 
-	irqflags |= IRQF_SHARED;
-
 	/* GPIO0 on pre-activate PHY, Reg 1F is not set by reset */
 	iow(db, DM9000_GPR, 0);	/* REG_1F bit0 activate phyxcer */
 	mdelay(1); /* delay needs by DM9000B */
@@ -1320,7 +1313,8 @@ dm9000_open(struct net_device *dev)
 	/* Initialize DM9000 board */
 	dm9000_init_dm9000(dev);
 
-	if (request_irq(dev->irq, dm9000_interrupt, irqflags, dev->name, dev))
+	if (request_irq(dev->irq, dm9000_interrupt, IRQF_SHARED,
+			dev->name, dev))
 		return -EAGAIN;
 	/* Now that we have an interrupt handler hooked up we can unmask
 	 * our interrupts
@@ -1460,15 +1454,22 @@ dm9000_probe(struct platform_device *pdev)
 
 	db->addr_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	db->data_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	db->irq_res  = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 
-	if (db->addr_res == NULL || db->data_res == NULL ||
-	    db->irq_res == NULL) {
-		dev_err(db->dev, "insufficient resources\n");
+	if (!db->addr_res || !db->data_res) {
+		dev_err(db->dev, "insufficient resources addr=%p data=%p\n",
+			db->addr_res, db->data_res);
 		ret = -ENOENT;
 		goto out;
 	}
 
+	ndev->irq = platform_get_irq(pdev, 0);
+	if (ndev->irq < 0) {
+		dev_err(db->dev, "interrupt resource unavailable: %d\n",
+			ndev->irq);
+		ret = ndev->irq;
+		goto out;
+	}
+
 	db->irq_wake = platform_get_irq(pdev, 1);
 	if (db->irq_wake >= 0) {
 		dev_dbg(db->dev, "wakeup irq %d\n", db->irq_wake);
@@ -1530,7 +1531,6 @@ dm9000_probe(struct platform_device *pdev)
 
 	/* fill in parameters for net-dev structure */
 	ndev->base_addr = (unsigned long)db->io_addr;
-	ndev->irq	= db->irq_res->start;
 
 	/* ensure at least we have a default set of IO routines */
 	dm9000_set_io(db, iosize);
-- 
2.17.1

