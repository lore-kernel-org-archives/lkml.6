Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B4AC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E182D2497F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E182D2497F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966769AbeF1PXt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:23:49 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53335 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966896AbeF1PUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:20:05 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E235220CFE; Thu, 28 Jun 2018 17:20:02 +0200 (CEST)
Received: from localhost (nat.foo.tf [163.172.35.26])
        by mail.bootlin.com (Postfix) with ESMTPSA id B0083203EC;
        Thu, 28 Jun 2018 17:20:02 +0200 (CEST)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        gregory.clement@bootlin.com, andrew@lunn.ch, jason@lakedaemon.net,
        sebastian.hesselbarth@gmail.com
Cc:     Ofer Heifetz <oferh@marvell.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, igall@marvell.com,
        Antoine Tenart <antoine.tenart@bootlin.com>
Subject: [PATCH 06/14] crypto: inside-secure - dynamic ring configuration allocation
Date:   Thu, 28 Jun 2018 17:15:36 +0200
Message-Id: <20180628151544.22134-7-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628151544.22134-1-antoine.tenart@bootlin.com>
References: <20180628151544.22134-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofer Heifetz <oferh@marvell.com>

The Inside Secure SafeXcel driver currently uses 4 rings, but the
eip197d engines has 8 of them. This patch updates the driver so that
rings are allocated dynamically based on the number of available rings
supported by a given engine.

Signed-off-by: Ofer Heifetz <oferh@marvell.com>
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/crypto/inside-secure/safexcel.c      |  7 ++
 drivers/crypto/inside-secure/safexcel.h      | 68 ++++++++++----------
 drivers/crypto/inside-secure/safexcel_ring.c | 10 +--
 3 files changed, 47 insertions(+), 38 deletions(-)

diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
index 579e7ae2cb14..baf8320d9c84 100644
--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -981,6 +981,13 @@ static int safexcel_probe(struct platform_device *pdev)
 
 	safexcel_configure(priv);
 
+	priv->ring = devm_kzalloc(dev, priv->config.rings * sizeof(*priv->ring),
+				  GFP_KERNEL);
+	if (!priv->ring) {
+		ret = -ENOMEM;
+		goto err_reg_clk;
+	}
+
 	for (i = 0; i < priv->config.rings; i++) {
 		char irq_name[6] = {0}; /* "ringX\0" */
 		char wq_name[9] = {0}; /* "wq_ringX\0" */
diff --git a/drivers/crypto/inside-secure/safexcel.h b/drivers/crypto/inside-secure/safexcel.h
index f62111eba30d..f370f055fd80 100644
--- a/drivers/crypto/inside-secure/safexcel.h
+++ b/drivers/crypto/inside-secure/safexcel.h
@@ -487,7 +487,7 @@ enum eip197_fw {
 	FW_NB
 };
 
-struct safexcel_ring {
+struct safexcel_desc_ring {
 	void *base;
 	void *base_end;
 	dma_addr_t base_dma;
@@ -528,6 +528,35 @@ struct safexcel_work_data {
 	int ring;
 };
 
+struct safexcel_ring {
+	spinlock_t lock;
+	spinlock_t egress_lock;
+
+	struct list_head list;
+	struct workqueue_struct *workqueue;
+	struct safexcel_work_data work_data;
+
+	/* command/result rings */
+	struct safexcel_desc_ring cdr;
+	struct safexcel_desc_ring rdr;
+
+	/* queue */
+	struct crypto_queue queue;
+	spinlock_t queue_lock;
+
+	/* Number of requests in the engine. */
+	int requests;
+
+	/* The ring is currently handling at least one request */
+	bool busy;
+
+	/* Store for current requests when bailing out of the dequeueing
+	 * function when no enough resources are available.
+	 */
+	struct crypto_async_request *req;
+	struct crypto_async_request *backlog;
+};
+
 enum safexcel_eip_version {
 	EIP97IES = BIT(0),
 	EIP197B  = BIT(1),
@@ -566,34 +595,7 @@ struct safexcel_crypto_priv {
 
 	atomic_t ring_used;
 
-	struct {
-		spinlock_t lock;
-		spinlock_t egress_lock;
-
-		struct list_head list;
-		struct workqueue_struct *workqueue;
-		struct safexcel_work_data work_data;
-
-		/* command/result rings */
-		struct safexcel_ring cdr;
-		struct safexcel_ring rdr;
-
-		/* queue */
-		struct crypto_queue queue;
-		spinlock_t queue_lock;
-
-		/* Number of requests in the engine. */
-		int requests;
-
-		/* The ring is currently handling at least one request */
-		bool busy;
-
-		/* Store for current requests when bailing out of the dequeueing
-		 * function when no enough resources are available.
-		 */
-		struct crypto_async_request *req;
-		struct crypto_async_request *backlog;
-	} ring[EIP197_MAX_RINGS];
+	struct safexcel_ring *ring;
 };
 
 struct safexcel_context {
@@ -651,13 +653,13 @@ int safexcel_invalidate_cache(struct crypto_async_request *async,
 			      dma_addr_t ctxr_dma, int ring,
 			      struct safexcel_request *request);
 int safexcel_init_ring_descriptors(struct safexcel_crypto_priv *priv,
-				   struct safexcel_ring *cdr,
-				   struct safexcel_ring *rdr);
+				   struct safexcel_desc_ring *cdr,
+				   struct safexcel_desc_ring *rdr);
 int safexcel_select_ring(struct safexcel_crypto_priv *priv);
 void *safexcel_ring_next_rptr(struct safexcel_crypto_priv *priv,
-			      struct safexcel_ring *ring);
+			      struct safexcel_desc_ring *ring);
 void safexcel_ring_rollback_wptr(struct safexcel_crypto_priv *priv,
-				 struct safexcel_ring *ring);
+				 struct safexcel_desc_ring *ring);
 struct safexcel_command_desc *safexcel_add_cdesc(struct safexcel_crypto_priv *priv,
 						 int ring_id,
 						 bool first, bool last,
diff --git a/drivers/crypto/inside-secure/safexcel_ring.c b/drivers/crypto/inside-secure/safexcel_ring.c
index c9d2a8716b5b..cfd843b834f1 100644
--- a/drivers/crypto/inside-secure/safexcel_ring.c
+++ b/drivers/crypto/inside-secure/safexcel_ring.c
@@ -14,8 +14,8 @@
 #include "safexcel.h"
 
 int safexcel_init_ring_descriptors(struct safexcel_crypto_priv *priv,
-				   struct safexcel_ring *cdr,
-				   struct safexcel_ring *rdr)
+				   struct safexcel_desc_ring *cdr,
+				   struct safexcel_desc_ring *rdr)
 {
 	cdr->offset = sizeof(u32) * priv->config.cd_offset;
 	cdr->base = dmam_alloc_coherent(priv->dev,
@@ -46,7 +46,7 @@ inline int safexcel_select_ring(struct safexcel_crypto_priv *priv)
 }
 
 static void *safexcel_ring_next_wptr(struct safexcel_crypto_priv *priv,
-				     struct safexcel_ring *ring)
+				     struct safexcel_desc_ring *ring)
 {
 	void *ptr = ring->write;
 
@@ -62,7 +62,7 @@ static void *safexcel_ring_next_wptr(struct safexcel_crypto_priv *priv,
 }
 
 void *safexcel_ring_next_rptr(struct safexcel_crypto_priv *priv,
-			      struct safexcel_ring *ring)
+			      struct safexcel_desc_ring *ring)
 {
 	void *ptr = ring->read;
 
@@ -78,7 +78,7 @@ void *safexcel_ring_next_rptr(struct safexcel_crypto_priv *priv,
 }
 
 void safexcel_ring_rollback_wptr(struct safexcel_crypto_priv *priv,
-				 struct safexcel_ring *ring)
+				 struct safexcel_desc_ring *ring)
 {
 	if (!ring->nr)
 		return;
-- 
2.17.1

