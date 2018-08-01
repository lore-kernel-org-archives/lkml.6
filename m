Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058A9C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A343820862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A343820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390217AbeHASER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 14:04:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45405 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389562AbeHASER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 14:04:17 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fktom-0006y6-5P; Wed, 01 Aug 2018 16:17:44 +0000
From:   Colin King <colin.king@canonical.com>
To:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Varun Prakash <varun@chelsio.com>, linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: csiostor: avoid null pointer dereference on card_fw allocation failure
Date:   Wed,  1 Aug 2018 17:17:43 +0100
Message-Id: <20180801161743.22301-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently if card_fw fails to be allocated then a null pointer
dereference occurs on card_fd when calling csio_hw_prep_fw. Fix this
by checking for a failed allocation and returning -ENOMEM.

Detected by CoverityScan, CID#1271213 ("Dereference null return value")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/csiostor/csio_hw.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/csiostor/csio_hw.c b/drivers/scsi/csiostor/csio_hw.c
index a10cf25ee7f9..aa637e9ea9ba 100644
--- a/drivers/scsi/csiostor/csio_hw.c
+++ b/drivers/scsi/csiostor/csio_hw.c
@@ -2275,8 +2275,8 @@ static int csio_hw_prep_fw(struct csio_hw *hw, struct fw_info *fw_info,
 }
 
 /*
- * Returns -EINVAL if attempts to flash the firmware failed
- * else returns 0,
+ * Returns -EINVAL if attempts to flash the firmware failed,
+ * -ENOMEM if allocation failed, else returns 0,
  * if flashing was not attempted because the card had the
  * latest firmware ECANCELED is returned
  */
@@ -2321,6 +2321,8 @@ csio_hw_flash_fw(struct csio_hw *hw, int *reset)
 	 * card
 	 */
 	card_fw = kmalloc(sizeof(*card_fw), GFP_KERNEL);
+	if (!card_fw)
+		return -ENOMEM;
 
 	/* upgrade FW logic */
 	ret = csio_hw_prep_fw(hw, fw_info, fw_data, fw_size, card_fw,
-- 
2.17.1

