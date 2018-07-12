Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C68DC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43933213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43933213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732534AbeGLMEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:04:06 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57996 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbeGLMEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:04:05 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B8D8C20731; Thu, 12 Jul 2018 13:54:51 +0200 (CEST)
Received: from mc-bl-xps13.lan (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6D1B4206A6;
        Thu, 12 Jul 2018 13:54:51 +0200 (CEST)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net-next 09/18] net: mvpp2: fix RSS register definitions
Date:   Thu, 12 Jul 2018 13:54:18 +0200
Message-Id: <20180712115427.27375-10-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180712115427.27375-1-maxime.chevallier@bootlin.com>
References: <20180712115427.27375-1-maxime.chevallier@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no RSS_TABLE register in PPv2 Controller. The register 0x1510
which was specified is actually named "RSS_HASH_SEL", but isn't used by
this driver at all.

Based on how this register was used, it should have been the
RXQ2RSS_TABLE register, which allows to select the RSS table that will
be used for the incoming packet.

The RSS_TABLE_POINTER is actually a field of this RXQ2RSS_TABLE
register.

Since RSS tables are actually not used by the driver for now, this
commit does not fix a runtime bug.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h     | 4 ++--
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index dee5231b0073..e6b182d8be5b 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -73,9 +73,9 @@
 #define     MVPP22_RSS_INDEX_TABLE_ENTRY(idx)	(idx)
 #define     MVPP22_RSS_INDEX_TABLE(idx)		((idx) << 8)
 #define     MVPP22_RSS_INDEX_QUEUE(idx)		((idx) << 16)
-#define MVPP22_RSS_TABLE_ENTRY			0x1508
-#define MVPP22_RSS_TABLE			0x1510
+#define MVPP22_RXQ2RSS_TABLE			0x1504
 #define     MVPP22_RSS_TABLE_POINTER(p)		(p)
+#define MVPP22_RSS_TABLE_ENTRY			0x1508
 #define MVPP22_RSS_WIDTH			0x150c
 
 /* Classifier Registers */
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
index 4d187f30725c..fe4bcaf983b2 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -123,7 +123,7 @@ void mvpp22_init_rss(struct mvpp2_port *port)
 	 */
 	for (i = 0; i < MVPP2_CLS_RX_QUEUES; i++) {
 		mvpp2_write(priv, MVPP22_RSS_INDEX, MVPP22_RSS_INDEX_QUEUE(i));
-		mvpp2_write(priv, MVPP22_RSS_TABLE,
+		mvpp2_write(priv, MVPP22_RXQ2RSS_TABLE,
 			    MVPP22_RSS_TABLE_POINTER(0));
 	}
 
-- 
2.11.0

