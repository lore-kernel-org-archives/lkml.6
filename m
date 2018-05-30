Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753694AbeE3LiB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:38:01 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60769 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752187AbeE3LHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:01 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Bastian Stender" <bst@pengutronix.de>,
        "Jan Luebbe" <jlu@pengutronix.de>,
        "Ulf Hansson" <ulf.hansson@linaro.org>
Date: Wed, 30 May 2018 11:52:42 +0100
Message-ID: <lsq.1527677562.809953927@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 128/153] mmc: block: fix updating ext_csd caches on
 ioctl call
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Bastian Stender <bst@pengutronix.de>

commit e74ef2194b41ba5e511fab29fe5ff00e72d2f42a upstream.

PARTITION_CONFIG is cached in mmc_card->ext_csd.part_config and the
currently active partition in mmc_blk_data->part_curr. These caches do
not always reflect changes if the ioctl call modifies the
PARTITION_CONFIG registers, e.g. by changing BOOT_PARTITION_ENABLE.

Write the PARTITION_CONFIG value extracted from the ioctl call to the
cache and update the currently active partition accordingly. This
ensures that the user space cannot change the values behind the
kernel's back. The next call to mmc_blk_part_switch() will operate on
the data set by the ioctl and reflect the changes appropriately.

Signed-off-by: Bastian Stender <bst@pengutronix.de>
Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[bwh: Backported to 3.2:
 - Also add the definition of MMC_EXTRACT_INDEX_FROM_ARG()
 - Adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -59,6 +59,9 @@ MODULE_ALIAS("mmc:block");
 #define INAND_CMD38_ARG_SECTRIM1 0x81
 #define INAND_CMD38_ARG_SECTRIM2 0x88
 
+#define MMC_EXTRACT_INDEX_FROM_ARG(x) ((x & 0x00FF0000) >> 16)
+#define MMC_EXTRACT_VALUE_FROM_ARG(x) ((x & 0x0000FF00) >> 8)
+
 static DEFINE_MUTEX(block_mutex);
 
 /*
@@ -393,6 +396,24 @@ static int mmc_blk_ioctl_cmd(struct bloc
 	}
 
 	/*
+	 * Make sure the cache of the PARTITION_CONFIG register and
+	 * PARTITION_ACCESS bits is updated in case the ioctl ext_csd write
+	 * changed it successfully.
+	 */
+	if ((MMC_EXTRACT_INDEX_FROM_ARG(cmd.arg) == EXT_CSD_PART_CONFIG) &&
+	    (cmd.opcode == MMC_SWITCH)) {
+		struct mmc_blk_data *main_md = dev_get_drvdata(&card->dev);
+		u8 value = MMC_EXTRACT_VALUE_FROM_ARG(cmd.arg);
+
+		/*
+		 * Update cache so the next mmc_blk_part_switch call operates
+		 * on up-to-date data.
+		 */
+		card->ext_csd.part_config = value;
+		main_md->part_curr = value & EXT_CSD_PART_CONFIG_ACC_MASK;
+	}
+
+	/*
 	 * According to the SD specs, some commands require a delay after
 	 * issuing the command.
 	 */
