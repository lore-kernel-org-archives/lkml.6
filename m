Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653B3C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FAF920818
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FAF920818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbeKHGOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:14:14 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42402 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbeKHGON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 01:14:13 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gKUeP-0000GJ-91; Wed, 07 Nov 2018 20:42:09 +0000
From:   Colin King <colin.king@canonical.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-i3c@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][i3c-next] i3c: fix incorrect update to max_read_ds
Date:   Wed,  7 Nov 2018 20:42:08 +0000
Message-Id: <20181107204208.7411-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently max_read_ds is being updated twice, which is incorrect.
The second assignment should be to max_write_ds instead. Fix this.

Detected by CoverityScan, CID#1475379 ("Unused value")

Fixes: 50cacdabeae1 ("i3c: Add core I3C infrastructure")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/i3c/master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 68d6553dbd75..0ea7bb045fad 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1093,7 +1093,7 @@ static int i3c_master_getmxds_locked(struct i3c_master_controller *master,
 	}
 
 	info->max_read_ds = getmaxds->maxrd;
-	info->max_read_ds = getmaxds->maxwr;
+	info->max_write_ds = getmaxds->maxwr;
 	if (dest.payload.len == 5)
 		info->max_read_turnaround = getmaxds->maxrdturn[0] |
 					    ((u32)getmaxds->maxrdturn[1] << 8) |
-- 
2.19.1

