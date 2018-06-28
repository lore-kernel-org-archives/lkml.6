Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC60DC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74943275BB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74943275BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967081AbeF1PUJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:20:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53335 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967051AbeF1PUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:20:06 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 76F8B20DD1; Thu, 28 Jun 2018 17:20:04 +0200 (CEST)
Received: from localhost (nat.foo.tf [163.172.35.26])
        by mail.bootlin.com (Postfix) with ESMTPSA id 445F4203EC;
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
Subject: [PATCH 10/14] crypto: inside-secure - adjust the TRC configuration for EIP197D
Date:   Thu, 28 Jun 2018 17:15:40 +0200
Message-Id: <20180628151544.22134-11-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628151544.22134-1-antoine.tenart@bootlin.com>
References: <20180628151544.22134-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofer Heifetz <oferh@marvell.com>

This patch updates the TRC configuration so that the version of the
EIP197 engine being used is taken into account, as the configuration
differs between the EIP197B and the EIP197D.

Signed-off-by: Ofer Heifetz <oferh@marvell.com>
[Antoine: commit message]
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/crypto/inside-secure/safexcel.c | 30 +++++++++++++++++--------
 drivers/crypto/inside-secure/safexcel.h | 12 +++++++---
 2 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
index 4ad1bfd77359..b70694090353 100644
--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -33,7 +33,19 @@ MODULE_PARM_DESC(max_rings, "Maximum number of rings to use.");
 static void eip197_trc_cache_init(struct safexcel_crypto_priv *priv)
 {
 	u32 val, htable_offset;
-	int i;
+	int i, cs_rc_max, cs_ht_wc, cs_trc_rec_wc, cs_trc_lg_rec_wc;
+
+	if (priv->version == EIP197B) {
+		cs_rc_max = EIP197B_CS_RC_MAX;
+		cs_ht_wc = EIP197B_CS_HT_WC;
+		cs_trc_rec_wc = EIP197B_CS_TRC_REC_WC;
+		cs_trc_lg_rec_wc = EIP197B_CS_TRC_LG_REC_WC;
+	} else {
+		cs_rc_max = EIP197D_CS_RC_MAX;
+		cs_ht_wc = EIP197D_CS_HT_WC;
+		cs_trc_rec_wc = EIP197D_CS_TRC_REC_WC;
+		cs_trc_lg_rec_wc = EIP197D_CS_TRC_LG_REC_WC;
+	}
 
 	/* Enable the record cache memory access */
 	val = readl(priv->base + EIP197_CS_RAM_CTRL);
@@ -54,7 +66,7 @@ static void eip197_trc_cache_init(struct safexcel_crypto_priv *priv)
 	writel(val, priv->base + EIP197_TRC_PARAMS);
 
 	/* Clear all records */
-	for (i = 0; i < EIP197_CS_RC_MAX; i++) {
+	for (i = 0; i < cs_rc_max; i++) {
 		u32 val, offset = EIP197_CLASSIFICATION_RAMS + i * EIP197_CS_RC_SIZE;
 
 		writel(EIP197_CS_RC_NEXT(EIP197_RC_NULL) |
@@ -64,14 +76,14 @@ static void eip197_trc_cache_init(struct safexcel_crypto_priv *priv)
 		val = EIP197_CS_RC_NEXT(i+1) | EIP197_CS_RC_PREV(i-1);
 		if (i == 0)
 			val |= EIP197_CS_RC_PREV(EIP197_RC_NULL);
-		else if (i == EIP197_CS_RC_MAX - 1)
+		else if (i == cs_rc_max - 1)
 			val |= EIP197_CS_RC_NEXT(EIP197_RC_NULL);
 		writel(val, priv->base + offset + sizeof(u32));
 	}
 
 	/* Clear the hash table entries */
-	htable_offset = EIP197_CS_RC_MAX * EIP197_CS_RC_SIZE;
-	for (i = 0; i < 64; i++)
+	htable_offset = cs_rc_max * EIP197_CS_RC_SIZE;
+	for (i = 0; i < cs_ht_wc; i++)
 		writel(GENMASK(29, 0),
 		       priv->base + EIP197_CLASSIFICATION_RAMS + htable_offset + i * sizeof(u32));
 
@@ -82,16 +94,16 @@ static void eip197_trc_cache_init(struct safexcel_crypto_priv *priv)
 
 	/* Write head and tail pointers of the record free chain */
 	val = EIP197_TRC_FREECHAIN_HEAD_PTR(0) |
-	      EIP197_TRC_FREECHAIN_TAIL_PTR(EIP197_CS_RC_MAX - 1);
+	      EIP197_TRC_FREECHAIN_TAIL_PTR(cs_rc_max - 1);
 	writel(val, priv->base + EIP197_TRC_FREECHAIN);
 
 	/* Configure the record cache #1 */
-	val = EIP197_TRC_PARAMS2_RC_SZ_SMALL(EIP197_CS_TRC_REC_WC) |
-	      EIP197_TRC_PARAMS2_HTABLE_PTR(EIP197_CS_RC_MAX);
+	val = EIP197_TRC_PARAMS2_RC_SZ_SMALL(cs_trc_rec_wc) |
+	      EIP197_TRC_PARAMS2_HTABLE_PTR(cs_rc_max);
 	writel(val, priv->base + EIP197_TRC_PARAMS2);
 
 	/* Configure the record cache #2 */
-	val = EIP197_TRC_PARAMS_RC_SZ_LARGE(EIP197_CS_TRC_LG_REC_WC) |
+	val = EIP197_TRC_PARAMS_RC_SZ_LARGE(cs_trc_lg_rec_wc) |
 	      EIP197_TRC_PARAMS_BLK_TIMER_SPEED(1) |
 	      EIP197_TRC_PARAMS_HTABLE_SZ(2);
 	writel(val, priv->base + EIP197_TRC_PARAMS);
diff --git a/drivers/crypto/inside-secure/safexcel.h b/drivers/crypto/inside-secure/safexcel.h
index 46c72306ca9f..94a89664f3d0 100644
--- a/drivers/crypto/inside-secure/safexcel.h
+++ b/drivers/crypto/inside-secure/safexcel.h
@@ -361,13 +361,19 @@ struct safexcel_context_record {
 #define EIP197_TRC_PARAMS2_RC_SZ_SMALL(n)	((n) << 18)
 
 /* Cache helpers */
-#define EIP197_CS_RC_MAX			52
+#define EIP197B_CS_RC_MAX			52
+#define EIP197D_CS_RC_MAX			96
 #define EIP197_CS_RC_SIZE			(4 * sizeof(u32))
 #define EIP197_CS_RC_NEXT(x)			(x)
 #define EIP197_CS_RC_PREV(x)			((x) << 10)
 #define EIP197_RC_NULL				0x3ff
-#define EIP197_CS_TRC_REC_WC			59
-#define EIP197_CS_TRC_LG_REC_WC			73
+#define EIP197B_CS_TRC_REC_WC			59
+#define EIP197D_CS_TRC_REC_WC			64
+#define EIP197B_CS_TRC_LG_REC_WC		73
+#define EIP197D_CS_TRC_LG_REC_WC		80
+#define EIP197B_CS_HT_WC			64
+#define EIP197D_CS_HT_WC			256
+
 
 /* Result data */
 struct result_data_desc {
-- 
2.17.1

