Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C952C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E8320858
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E8320858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390306AbeKQEz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 23:55:57 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41696 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbeKQEz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 23:55:57 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gNj4R-0005fu-JY; Fri, 16 Nov 2018 18:42:23 +0000
From:   Colin King <colin.king@canonical.com>
To:     Vitor Soares <vitor.soares@synopsys.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][i3c-next] i3c: master: fix mask operation by using the correct operator
Date:   Fri, 16 Nov 2018 18:42:23 +0000
Message-Id: <20181116184223.28240-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The masking operation on status is using a bitwise 'or' rather than
a bitwise 'and' operator, and hence the result is always non-zero
which is probably not what is intended. Fix this by using the correct
operator.

Detected by CoverityScan, CID#1475523 ("Wrong operator used")

Fixes: 88acc98a712a ("i3c: master: Add driver for Synopsys DesignWare IP")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/i3c/master/dw-i3c-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 0153e6e9de52..b532e2c9cf5c 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -1085,7 +1085,7 @@ static irqreturn_t dw_i3c_master_irq_handler(int irq, void *dev_id)
 
 	spin_lock(&master->xferqueue.lock);
 	dw_i3c_master_end_xfer_locked(master, status);
-	if (status | INTR_TRANSFER_ERR_STAT)
+	if (status & INTR_TRANSFER_ERR_STAT)
 		writel(INTR_TRANSFER_ERR_STAT, master->regs + INTR_STATUS);
 	spin_unlock(&master->xferqueue.lock);
 
-- 
2.19.1

