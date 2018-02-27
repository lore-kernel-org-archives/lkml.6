Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932069AbeB0Ld5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 06:33:57 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:47750 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752439AbeB0Ldz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 06:33:55 -0500
From: Harish Jenny K N <harish_kandiga@mentor.com>
To: <ulf.hansson@linaro.org>, <linus.walleij@linaro.org>,
        <adrian.hunter@intel.com>, <shawn.lin@rock-chips.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <harish_kandiga@mentor.com>
Subject: [PATCH] mmc: card: Don't show eMMC RPMB and BOOT areas in /proc/partitions
Date: Tue, 27 Feb 2018 17:03:49 +0530
Message-ID: <1519731229-19141-1-git-send-email-harish_kandiga@mentor.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Gabbasov <andrew_gabbasov@mentor.com>

Since RPMB area is accessible via special ioctl only and boot areas
are unlikely to contain any partitions, exclude them all from listing
in /proc/partitions. This will hide them from various user-level
software (e.g. fdisk), thus avoiding unnecessary access attempts.

Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
---
 drivers/mmc/core/block.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 20135a5..376e47e 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2341,7 +2341,8 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	set_disk_ro(md->disk, md->read_only || default_ro);
 	md->disk->flags = GENHD_FL_EXT_DEVT;
 	if (area_type & (MMC_BLK_DATA_AREA_RPMB | MMC_BLK_DATA_AREA_BOOT))
-		md->disk->flags |= GENHD_FL_NO_PART_SCAN;
+		md->disk->flags |= GENHD_FL_NO_PART_SCAN
+				   | GENHD_FL_SUPPRESS_PARTITION_INFO;
 
 	/*
 	 * As discussed on lkml, GENHD_FL_REMOVABLE should:
-- 
1.9.1
