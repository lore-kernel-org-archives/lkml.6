Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id oXt3MRlQHltsSQAAmS7hNA
	; Mon, 11 Jun 2018 11:37:44 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 377EE607A4; Mon, 11 Jun 2018 11:37:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A8E9960541;
	Mon, 11 Jun 2018 11:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A8E9960541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=lucaceresoli.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933099AbeFKLhm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:37:42 -0400
Received: from srv-hp10-72.netsons.net ([94.141.22.72]:35419 "EHLO
        srv-hp10-72.netsons.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932956AbeFKLgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:36:16 -0400
Received: from [109.168.11.45] (port=54392 helo=pc-ceresoli.dev.aim)
        by srv-hp10.netsons.net with esmtpa (Exim 4.89_1)
        (envelope-from <luca@lucaceresoli.net>)
        id 1fSL7N-00B1A2-8G; Mon, 11 Jun 2018 13:36:13 +0200
From: Luca Ceresoli <luca@lucaceresoli.net>
To: linux-media@vger.kernel.org
Cc: Luca Ceresoli <luca@lucaceresoli.net>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Leon Luo <leonl@leopardimaging.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/8] media: imx274: simplify imx274_write_table()
Date: Mon, 11 Jun 2018 13:35:36 +0200
Message-Id: <1528716939-17015-6-git-send-email-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528716939-17015-1-git-send-email-luca@lucaceresoli.net>
References: <1528716939-17015-1-git-send-email-luca@lucaceresoli.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - srv-hp10.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: srv-hp10.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: srv-hp10.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

imx274_write_table() is a mere wrapper (and the only user) to
imx274_regmap_util_write_table_8(). Remove this useless indirection by
merging the two functions into one.

Also get rid of the wait_ms_addr and end_addr parameters since it does
not make any sense to give them any values other than
IMX274_TABLE_WAIT_MS and IMX274_TABLE_END.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>

---
Changed v3 -> v4: nothing

Changed v2 -> v3: nothing

Changed v1 -> v2:
 - add "media: " prefix to commit message
---
 drivers/media/i2c/imx274.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/media/i2c/imx274.c b/drivers/media/i2c/imx274.c
index ceeec97cd330..48343c2ade83 100644
--- a/drivers/media/i2c/imx274.c
+++ b/drivers/media/i2c/imx274.c
@@ -597,20 +597,18 @@ static inline struct stimx274 *to_imx274(struct v4l2_subdev *sd)
 }
 
 /*
- * imx274_regmap_util_write_table_8 - Function for writing register table
- * @regmap: Pointer to device reg map structure
- * @table: Table containing register values
- * @wait_ms_addr: Flag for performing delay
- * @end_addr: Flag for incating end of table
+ * Writing a register table
+ *
+ * @priv: Pointer to device
+ * @table: Table containing register values (with optional delays)
  *
  * This is used to write register table into sensor's reg map.
  *
  * Return: 0 on success, errors otherwise
  */
-static int imx274_regmap_util_write_table_8(struct regmap *regmap,
-					    const struct reg_8 table[],
-					    u16 wait_ms_addr, u16 end_addr)
+static int imx274_write_table(struct stimx274 *priv, const struct reg_8 table[])
 {
+	struct regmap *regmap = priv->regmap;
 	int err = 0;
 	const struct reg_8 *next;
 	u8 val;
@@ -622,8 +620,8 @@ static int imx274_regmap_util_write_table_8(struct regmap *regmap,
 
 	for (next = table;; next++) {
 		if ((next->addr != range_start + range_count) ||
-		    (next->addr == end_addr) ||
-		    (next->addr == wait_ms_addr) ||
+		    (next->addr == IMX274_TABLE_END) ||
+		    (next->addr == IMX274_TABLE_WAIT_MS) ||
 		    (range_count == max_range_vals)) {
 			if (range_count == 1)
 				err = regmap_write(regmap,
@@ -642,10 +640,10 @@ static int imx274_regmap_util_write_table_8(struct regmap *regmap,
 			range_count = 0;
 
 			/* Handle special address values */
-			if (next->addr == end_addr)
+			if (next->addr == IMX274_TABLE_END)
 				break;
 
-			if (next->addr == wait_ms_addr) {
+			if (next->addr == IMX274_TABLE_WAIT_MS) {
 				msleep_range(next->val);
 				continue;
 			}
@@ -692,12 +690,6 @@ static inline int imx274_write_reg(struct stimx274 *priv, u16 addr, u8 val)
 	return err;
 }
 
-static int imx274_write_table(struct stimx274 *priv, const struct reg_8 table[])
-{
-	return imx274_regmap_util_write_table_8(priv->regmap,
-		table, IMX274_TABLE_WAIT_MS, IMX274_TABLE_END);
-}
-
 /*
  * Set mode registers to start stream.
  * @priv: Pointer to device structure
-- 
2.7.4
