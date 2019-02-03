Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31B8C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 08:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31A220855
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 08:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RHfQ/pZz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfBCIvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 03:51:01 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:15410 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfBCIvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 03:51:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549183861; x=1580719861;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Vx2WNxuKIv+Lg2L8oPKMd0BLI1DEP0XstOGQcRLuzuQ=;
  b=RHfQ/pZzmgwsUzr3ClYPJZc5igRkCgPVctjt1Xv/gOQQf6j5NoH4jtta
   OXVO8HazYowWMScRoUfuKV2qASU/zRyTrFQUgx3a+LkUHhnNa/3+7sNFg
   aOnnaMxIASyeGMbBMtZwO18eV5mSREWtQ7vaQ3XfgzCJXufguoTvvHH7u
   24ORpNkq88zg6gCnuNh5A0AEvz6yZ7baVu+GHP1LpIBtBAmNgyFN+mUci
   /A72Gvos+0/UDyARZp9glF7oLWqNR5Epl8zqdqXzyNAbBu3R/UwEfKaDT
   nOuICSGG3diQ9Z8yuqycVb7j8xB0p/YVjTKuaCHjCbF+Fpuvq195j07Ky
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,555,1539619200"; 
   d="scan'208";a="105387540"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2019 16:51:01 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 03 Feb 2019 00:31:52 -0800
Received: from kfae422988.sdcorp.global.sandisk.com ([10.0.230.227])
  by uls-op-cesaip01.wdc.com with ESMTP; 03 Feb 2019 00:50:58 -0800
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 1/3] mmc: core: Calculate the discard arg only once
Date:   Sun,  3 Feb 2019 10:50:26 +0200
Message-Id: <1549183828-17316-2-git-send-email-avri.altman@wdc.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1549183828-17316-1-git-send-email-avri.altman@wdc.com>
References: <1549183828-17316-1-git-send-email-avri.altman@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The discard arg is a read-only ext_csd parameter -
set it once on card init.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/block.c | 12 +++---------
 drivers/mmc/core/mmc.c   |  8 ++++++++
 include/linux/mmc/card.h |  2 ++
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index b08fb91..3502f2c 100644
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
+					 card->discard_arg == MMC_TRIM_ARG ?
 					 INAND_CMD38_ARG_TRIM :
 					 INAND_CMD38_ARG_ERASE,
 					 0);
 		}
 		if (!err)
-			err = mmc_erase(card, from, nr, arg);
+			err = mmc_erase(card, from, nr, card->discard_arg);
 	} while (err == -EIO && !mmc_blk_reset(md, card->host, type));
 	if (err)
 		status = BLK_STS_IOERR;
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index da892a5..120739c 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1743,6 +1743,14 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			card->ext_csd.power_off_notification = EXT_CSD_POWER_ON;
 	}
 
+	/* set discard_arg */
+	if (mmc_can_discard(card))
+		card->discard_arg = MMC_DISCARD_ARG;
+	else if (mmc_can_trim(card))
+		card->discard_arg = MMC_TRIM_ARG;
+	else
+		card->discard_arg = MMC_ERASE_ARG;
+
 	/*
 	 * Select timing interface
 	 */
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index de73778..447648b 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -308,6 +308,8 @@ struct mmc_card {
 	unsigned int    nr_parts;
 
 	unsigned int		bouncesz;	/* Bounce buffer size */
+
+	unsigned int		discard_arg;	/* discard args */
 };
 
 static inline bool mmc_large_sector(struct mmc_card *card)
-- 
1.9.1

