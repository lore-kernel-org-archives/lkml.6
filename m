Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00F7C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73802275D1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73802275D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967168AbeF1PVS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:21:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53356 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967059AbeF1PUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:20:07 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D482120DD2; Thu, 28 Jun 2018 17:20:04 +0200 (CEST)
Received: from localhost (nat.foo.tf [163.172.35.26])
        by mail.bootlin.com (Postfix) with ESMTPSA id A223E203EC;
        Thu, 28 Jun 2018 17:20:04 +0200 (CEST)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        gregory.clement@bootlin.com, andrew@lunn.ch, jason@lakedaemon.net,
        sebastian.hesselbarth@gmail.com
Cc:     Ofer Heifetz <oferh@marvell.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, igall@marvell.com,
        Antoine Tenart <antoine.tenart@bootlin.com>
Subject: [PATCH 11/14] crypto: inside-secure - reset CDR and RDR rings on module removal
Date:   Thu, 28 Jun 2018 17:15:41 +0200
Message-Id: <20180628151544.22134-12-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628151544.22134-1-antoine.tenart@bootlin.com>
References: <20180628151544.22134-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofer Heifetz <oferh@marvell.com>

This patch adds extra steps in the module removal path, to reset the
command and result rings. The corresponding interrupts are cleared, and
the ring address configuration is reset.

Signed-off-by: Ofer Heifetz <oferh@marvell.com>
[Antoine: small reworks, commit message]
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/crypto/inside-secure/safexcel.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
index b70694090353..5feb83c6238b 100644
--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -1125,6 +1125,24 @@ static int safexcel_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static void safexcel_hw_reset_rings(struct safexcel_crypto_priv *priv)
+{
+	int i;
+
+	for (i = 0; i < priv->config.rings; i++) {
+		/* clear any pending interrupt */
+		writel(GENMASK(5, 0), EIP197_HIA_CDR(priv, i) + EIP197_HIA_xDR_STAT);
+		writel(GENMASK(7, 0), EIP197_HIA_RDR(priv, i) + EIP197_HIA_xDR_STAT);
+
+		/* Reset the CDR base address */
+		writel(0, EIP197_HIA_CDR(priv, i) + EIP197_HIA_xDR_RING_BASE_ADDR_LO);
+		writel(0, EIP197_HIA_CDR(priv, i) + EIP197_HIA_xDR_RING_BASE_ADDR_HI);
+
+		/* Reset the RDR base address */
+		writel(0, EIP197_HIA_RDR(priv, i) + EIP197_HIA_xDR_RING_BASE_ADDR_LO);
+		writel(0, EIP197_HIA_RDR(priv, i) + EIP197_HIA_xDR_RING_BASE_ADDR_HI);
+	}
+}
 
 static int safexcel_remove(struct platform_device *pdev)
 {
@@ -1132,6 +1150,8 @@ static int safexcel_remove(struct platform_device *pdev)
 	int i;
 
 	safexcel_unregister_algorithms(priv);
+	safexcel_hw_reset_rings(priv);
+
 	clk_disable_unprepare(priv->clk);
 
 	for (i = 0; i < priv->config.rings; i++)
-- 
2.17.1

