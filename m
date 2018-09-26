Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1FBC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A854D20684
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A854D20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbeIZTVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:21:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46618 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbeIZTVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:21:47 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1g59Yf-00065j-9S; Wed, 26 Sep 2018 13:08:49 +0000
From:   Colin King <colin.king@canonical.com>
To:     QLogic-Storage-Upstream@qlogic.com,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qla4xxx: remove redundant check on drvr_wait
Date:   Wed, 26 Sep 2018 14:08:48 +0100
Message-Id: <20180926130848.30645-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The check for a non-zero drvr_wait is redundant as the same check
is performed earlier in the outer while loop, the inner check will
always be true if we reached this point inside the while loop.
Remove the redundant if check.

Detected by cppcheck:
(warning) Identical inner 'if' condition is always true.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/qla4xxx/ql4_init.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_init.c b/drivers/scsi/qla4xxx/ql4_init.c
index 52b1a0bc93c9..1ef74aa2d00a 100644
--- a/drivers/scsi/qla4xxx/ql4_init.c
+++ b/drivers/scsi/qla4xxx/ql4_init.c
@@ -766,12 +766,10 @@ int ql4xxx_lock_drvr_wait(struct scsi_qla_host *a)
 	while (drvr_wait) {
 		if (ql4xxx_lock_drvr(a) == 0) {
 			ssleep(QL4_LOCK_DRVR_SLEEP);
-			if (drvr_wait) {
-				DEBUG2(printk("scsi%ld: %s: Waiting for "
-					      "Global Init Semaphore(%d)...\n",
-					      a->host_no,
-					      __func__, drvr_wait));
-			}
+			DEBUG2(printk("scsi%ld: %s: Waiting for "
+				      "Global Init Semaphore(%d)...\n",
+				      a->host_no,
+				      __func__, drvr_wait));
 			drvr_wait -= QL4_LOCK_DRVR_SLEEP;
 		} else {
 			DEBUG2(printk("scsi%ld: %s: Global Init Semaphore "
-- 
2.17.1

