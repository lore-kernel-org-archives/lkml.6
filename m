Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56F7C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A83FF21746
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A83FF21746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbeHMOE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 10:04:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38855 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728635AbeHMOE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 10:04:27 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 690E052BC951;
        Mon, 13 Aug 2018 19:22:34 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Mon, 13 Aug 2018 19:22:27 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <john.garry@huawei.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] scsi:ufs: Use PTR_ERR_OR_ZERO to replace the open code
Date:   Mon, 13 Aug 2018 19:10:39 +0800
Message-ID: <1534158640-24353-2-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1534158640-24353-1-git-send-email-zhongjiang@huawei.com>
References: <1534158640-24353-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PTR_ERR_OR_ZERO has implemented the if(IS_ERR(...)) + PTR_ERR, So
just replace them rather than duplicating its implement.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/scsi/ufs/ufs-hisi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-hisi.c b/drivers/scsi/ufs/ufs-hisi.c
index 46df707..e794994 100644
--- a/drivers/scsi/ufs/ufs-hisi.c
+++ b/drivers/scsi/ufs/ufs-hisi.c
@@ -505,10 +505,8 @@ static int ufs_hisi_get_resource(struct ufs_hisi_host *host)
 	/* get resource of ufs sys ctrl */
 	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	host->ufs_sys_ctrl = devm_ioremap_resource(dev, mem_res);
-	if (IS_ERR(host->ufs_sys_ctrl))
-		return PTR_ERR(host->ufs_sys_ctrl);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(host->ufs_sys_ctrl);
 }
 
 static void ufs_hisi_set_pm_lvl(struct ufs_hba *hba)
-- 
1.7.12.4

