Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6915C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACF720823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Gyy/7pUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbfBFL2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:28:52 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:13318 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfBFL2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:28:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549452544; x=1580988544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=JnAfbYYqhyA0a6+hSXiNKjPba0BriVEMh7OFZHYa0WU=;
  b=Gyy/7pUU1C+K+ZjSYRfUBCQ+L7e+QXeUtkEbi0+uOP+z44hbi2sR8aZJ
   nKlJpEAyDmvHA7EwM955bvFYE6JCLYyEnNmrxwQWTfmNGk1Nvy4rJGYIS
   WTURktwXtaN77jXMijHxC/7Z2XyswM06BUUcv7ZliXcyTl3M8FUwl3BsC
   9KIWf9A5QF+ibi8Sc0YKn+p090Fhlth6ZYXv/RoDGgZcx5p5isvB4DP6V
   rI3qixZXNfFeOj1iXAnE1kjBiQ7dKFrcWmY6Toa79Q+o7zYmyoNN6TQeA
   VtF4NgXuW4/zufOWv2NxpDgEDgEAhW621mzUlX+rNIRsTA65kpV5o6XG5
   w==;
X-IronPort-AV: E=Sophos;i="5.56,564,1539619200"; 
   d="scan'208";a="198777069"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2019 19:29:04 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 06 Feb 2019 03:09:38 -0800
Received: from kfae422988.sdcorp.global.sandisk.com ([10.0.230.227])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Feb 2019 03:28:49 -0800
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 1/3] mmc: core: Calculate the discard arg only once
Date:   Wed,  6 Feb 2019 13:28:05 +0200
Message-Id: <1549452487-17193-2-git-send-email-avri.altman@wdc.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1549452487-17193-1-git-send-email-avri.altman@wdc.com>
References: <1549452487-17193-1-git-send-email-avri.altman@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In MMC, the discard arg is a read-only ext_csd parameter - set it once
on card init. To be consistent, do that for SD as well even though its
discard arg is always 0x0.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/block.c | 12 +++---------
 drivers/mmc/core/core.c  |  4 ++--
 drivers/mmc/core/mmc.c   |  8 ++++++++
 drivers/mmc/core/sd.c    |  2 ++
 include/linux/mmc/card.h |  1 +
 include/linux/mmc/sd.h   |  5 +++++
 6 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index b08fb91..131e80e 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1124,7 +1124,7 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 {
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
-	unsigned int from, nr, arg;
+	unsigned int from, nr;
 	int err = 0, type = MMC_BLK_DISCARD;
 	blk_status_t status = BLK_STS_OK;
 
@@ -1136,24 +1136,18 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 	from = blk_rq_pos(req);
 	nr = blk_rq_sectors(req);
 
-	if (mmc_can_discard(card))
-		arg = MMC_DISCARD_ARG;
-	else if (mmc_can_trim(card))
-		arg = MMC_TRIM_ARG;
-	else
-		arg = MMC_ERASE_ARG;
 	do {
 		err = 0;
 		if (card->quirks & MMC_QUIRK_INAND_CMD38) {
 			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 					 INAND_CMD38_ARG_EXT_CSD,
-					 arg == MMC_TRIM_ARG ?
+					 card->erase_arg == MMC_TRIM_ARG ?
 					 INAND_CMD38_ARG_TRIM :
 					 INAND_CMD38_ARG_ERASE,
 					 0);
 		}
 		if (!err)
-			err = mmc_erase(card, from, nr, arg);
+			err = mmc_erase(card, from, nr, card->erase_arg);
 	} while (err == -EIO && !mmc_blk_reset(md, card->host, type));
 	if (err)
 		status = BLK_STS_IOERR;
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5bd58b9..de0f1a1 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2164,7 +2164,7 @@ static unsigned int mmc_align_erase_size(struct mmc_card *card,
  * @card: card to erase
  * @from: first sector to erase
  * @nr: number of sectors to erase
- * @arg: erase command argument (SD supports only %MMC_ERASE_ARG)
+ * @arg: erase command argument (SD supports only %SD_ERASE_ARG)
  *
  * Caller must claim host before calling this function.
  */
@@ -2181,7 +2181,7 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
 	if (!card->erase_size)
 		return -EOPNOTSUPP;
 
-	if (mmc_card_sd(card) && arg != MMC_ERASE_ARG)
+	if (mmc_card_sd(card) && arg != SD_ERASE_ARG)
 		return -EOPNOTSUPP;
 
 	if ((arg & MMC_SECURE_ARGS) &&
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index da892a5..09c688f 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1743,6 +1743,14 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			card->ext_csd.power_off_notification = EXT_CSD_POWER_ON;
 	}
 
+	/* set erase_arg */
+	if (mmc_can_discard(card))
+		card->erase_arg = MMC_DISCARD_ARG;
+	else if (mmc_can_trim(card))
+		card->erase_arg = MMC_TRIM_ARG;
+	else
+		card->erase_arg = MMC_ERASE_ARG;
+
 	/*
 	 * Select timing interface
 	 */
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index d0d9f90..bd48b28 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -271,6 +271,8 @@ static int mmc_read_ssr(struct mmc_card *card)
 		}
 	}
 
+	card->erase_arg = SD_ERASE_ARG;
+
 	return 0;
 }
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index de73778..8f429b6 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -277,6 +277,7 @@ struct mmc_card {
  	unsigned int		erase_shift;	/* if erase unit is power 2 */
  	unsigned int		pref_erase;	/* in sectors */
 	unsigned int		eg_boundary;	/* don't cross erase-group boundaries */
+	unsigned int		erase_arg;	/* erase / trim / discard */
  	u8			erased_byte;	/* value of erased bytes */
 
 	u32			raw_cid[4];	/* raw card CID */
diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
index 1ebcf9b..1a6d10f 100644
--- a/include/linux/mmc/sd.h
+++ b/include/linux/mmc/sd.h
@@ -91,4 +91,9 @@
 #define SD_SWITCH_ACCESS_DEF	0
 #define SD_SWITCH_ACCESS_HS	1
 
+/*
+ * Erase/discard
+ */
+#define SD_ERASE_ARG			0x00000000
+
 #endif /* LINUX_MMC_SD_H */
-- 
1.9.1

