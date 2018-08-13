Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72F4C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617D4216F2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617D4216F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbeHMPQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 11:16:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59960 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728926AbeHMPQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 11:16:01 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BEF64E95F9C5D;
        Mon, 13 Aug 2018 20:33:51 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.399.0; Mon, 13 Aug 2018 20:33:51 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <don.brace@microsemi.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] scsi: Use vmemdup_user to replace the open code
Date:   Mon, 13 Aug 2018 20:22:04 +0800
Message-ID: <1534162924-27490-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmemdup_user is better than duplicating its implementation, So just
replace the open code.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/scsi/hpsa.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 58bb70b..948576a 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -6381,13 +6381,9 @@ static int hpsa_big_passthru_ioctl(struct ctlr_info *h, void __user *argp)
 		return -EINVAL;
 	if (!capable(CAP_SYS_RAWIO))
 		return -EPERM;
-	ioc = kmalloc(sizeof(*ioc), GFP_KERNEL);
-	if (!ioc) {
-		status = -ENOMEM;
-		goto cleanup1;
-	}
-	if (copy_from_user(ioc, argp, sizeof(*ioc))) {
-		status = -EFAULT;
+	ioc = vmemdup_user(argp, sizeof(*ioc));
+	if (IS_ERR(ioc)) {
+		status = PTR_ERR(ioc);
 		goto cleanup1;
 	}
 	if ((ioc->buf_size < 1) &&
-- 
1.7.12.4

