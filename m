Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BEAECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46E520645
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C46E520645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731334AbeISPIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 11:08:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43233 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731125AbeISPHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 11:07:17 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A8002208C7; Wed, 19 Sep 2018 11:30:12 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 79C0D208D9;
        Wed, 19 Sep 2018 11:30:02 +0200 (CEST)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 07/12] net: mvpp2: make the per-cpu helpers static
Date:   Wed, 19 Sep 2018 11:27:06 +0200
Message-Id: <20180919092711.22296-8-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919092711.22296-1-antoine.tenart@bootlin.com>
References: <20180919092711.22296-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Marvell PPv2 driver has per-cpu functions. As they only are used in
the main file, make them static and remove their prototype from the
header.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h      | 7 -------
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 6 +++---
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index 57fea9193a49..5247f2d1f573 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -1099,13 +1099,6 @@ u32 mvpp2_read(struct mvpp2 *priv, u32 offset);
 
 u32 mvpp2_read_relaxed(struct mvpp2 *priv, u32 offset);
 
-void mvpp2_percpu_write(struct mvpp2 *priv, unsigned int cpu, u32 offset,
-			u32 data);
-u32 mvpp2_percpu_read(struct mvpp2 *priv, unsigned int cpu, u32 offset);
-
-void mvpp2_percpu_write_relaxed(struct mvpp2 *priv, unsigned int cpu,
-				u32 offset, u32 data);
-
 void mvpp2_dbgfs_init(struct mvpp2 *priv, const char *name);
 
 void mvpp2_dbgfs_cleanup(struct mvpp2 *priv);
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 8d4e5d0c0ad8..f5edde2994e0 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -123,19 +123,19 @@ u32 mvpp2_read_relaxed(struct mvpp2 *priv, u32 offset)
  *   MVPP2_TXQ_PREF_BUF_REG    (related to MVPP2_TXQ_NUM_REG)
  *   MVPP2_TXQ_PREF_BUF_REG    (related to MVPP2_TXQ_NUM_REG)
  */
-void mvpp2_percpu_write(struct mvpp2 *priv, unsigned int cpu,
+static void mvpp2_percpu_write(struct mvpp2 *priv, unsigned int cpu,
 			       u32 offset, u32 data)
 {
 	writel(data, priv->swth_base[cpu] + offset);
 }
 
-u32 mvpp2_percpu_read(struct mvpp2 *priv, unsigned int cpu,
+static u32 mvpp2_percpu_read(struct mvpp2 *priv, unsigned int cpu,
 			     u32 offset)
 {
 	return readl(priv->swth_base[cpu] + offset);
 }
 
-void mvpp2_percpu_write_relaxed(struct mvpp2 *priv, unsigned int cpu,
+static void mvpp2_percpu_write_relaxed(struct mvpp2 *priv, unsigned int cpu,
 				       u32 offset, u32 data)
 {
 	writel_relaxed(data, priv->swth_base[cpu] + offset);
-- 
2.17.1

