Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id kt2bD7BLGVsDXQAAmS7hNA
	; Thu, 07 Jun 2018 15:13:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 19A926063F; Thu,  7 Jun 2018 15:13:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8DE02601B4;
	Thu,  7 Jun 2018 15:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8DE02601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964810AbeFGPCO (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:02:14 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41430 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934978AbeFGPCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:02:09 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbG-0005a0-79; Thu, 07 Jun 2018 15:09:14 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbD-0003Fu-13; Thu, 07 Jun 2018 15:09:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Jan Luebbe" <jlu@pengutronix.de>,
        "Bastian Stender" <bst@pengutronix.de>,
        "Ulf Hansson" <ulf.hansson@linaro.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.701370749@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 362/410] mmc: block: fix updating ext_csd caches on
 ioctl call
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.16:
 - Also add the definition of MMC_EXTRACT_INDEX_FROM_ARG()
 - Adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -67,6 +67,9 @@ MODULE_ALIAS("mmc:block");
 #define PACKED_CMD_VER	0x01
 #define PACKED_CMD_WR	0x02
 
+#define MMC_EXTRACT_INDEX_FROM_ARG(x) ((x & 0x00FF0000) >> 16)
+#define MMC_EXTRACT_VALUE_FROM_ARG(x) ((x & 0x0000FF00) >> 8)
+
 static DEFINE_MUTEX(block_mutex);
 
 /*
@@ -569,6 +572,24 @@ static int mmc_blk_ioctl_cmd(struct bloc
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
