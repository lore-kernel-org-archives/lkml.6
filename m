Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D25BECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DE121521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9DE121521
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbeITIWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:22:41 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12650 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726006AbeITIWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:22:41 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5B7B626923B20;
        Thu, 20 Sep 2018 10:41:38 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.399.0; Thu, 20 Sep 2018 10:41:35 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <gpiccoli@linux.vnet.ibm.com>, <haver@linux.vnet.ibm.com>,
        <arnd@arndb.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] misc: genwqe: should return proper error value.
Date:   Thu, 20 Sep 2018 10:29:13 +0800
Message-ID: <1537410553-23836-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function should return -EFAULT when copy_from_user fails. Even
though the caller does not distinguish them. but we should keep backward
compatibility.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/misc/genwqe/card_utils.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/genwqe/card_utils.c b/drivers/misc/genwqe/card_utils.c
index 8679e0b..f0961ec 100644
--- a/drivers/misc/genwqe/card_utils.c
+++ b/drivers/misc/genwqe/card_utils.c
@@ -298,7 +298,7 @@ static int genwqe_sgl_size(int num_pages)
 int genwqe_alloc_sync_sgl(struct genwqe_dev *cd, struct genwqe_sgl *sgl,
 			  void __user *user_addr, size_t user_size, int write)
 {
-	int rc;
+	int ret = -ENOMEM;
 	struct pci_dev *pci_dev = cd->pci_dev;
 
 	sgl->fpage_offs = offset_in_page((unsigned long)user_addr);
@@ -318,7 +318,7 @@ int genwqe_alloc_sync_sgl(struct genwqe_dev *cd, struct genwqe_sgl *sgl,
 	if (get_order(sgl->sgl_size) > MAX_ORDER) {
 		dev_err(&pci_dev->dev,
 			"[%s] err: too much memory requested!\n", __func__);
-		return -ENOMEM;
+		return ret;
 	}
 
 	sgl->sgl = __genwqe_alloc_consistent(cd, sgl->sgl_size,
@@ -326,7 +326,7 @@ int genwqe_alloc_sync_sgl(struct genwqe_dev *cd, struct genwqe_sgl *sgl,
 	if (sgl->sgl == NULL) {
 		dev_err(&pci_dev->dev,
 			"[%s] err: no memory available!\n", __func__);
-		return -ENOMEM;
+		return ret;
 	}
 
 	/* Only use buffering on incomplete pages */
@@ -339,7 +339,7 @@ int genwqe_alloc_sync_sgl(struct genwqe_dev *cd, struct genwqe_sgl *sgl,
 		/* Sync with user memory */
 		if (copy_from_user(sgl->fpage + sgl->fpage_offs,
 				   user_addr, sgl->fpage_size)) {
-			rc = -EFAULT;
+			ret = -EFAULT;
 			goto err_out;
 		}
 	}
@@ -352,7 +352,7 @@ int genwqe_alloc_sync_sgl(struct genwqe_dev *cd, struct genwqe_sgl *sgl,
 		/* Sync with user memory */
 		if (copy_from_user(sgl->lpage, user_addr + user_size -
 				   sgl->lpage_size, sgl->lpage_size)) {
-			rc = -EFAULT;
+			ret = -EFAULT;
 			goto err_out2;
 		}
 	}
@@ -374,7 +374,8 @@ int genwqe_alloc_sync_sgl(struct genwqe_dev *cd, struct genwqe_sgl *sgl,
 	sgl->sgl = NULL;
 	sgl->sgl_dma_addr = 0;
 	sgl->sgl_size = 0;
-	return -ENOMEM;
+
+	return ret;
 }
 
 int genwqe_setup_sgl(struct genwqe_dev *cd, struct genwqe_sgl *sgl,
-- 
1.7.12.4

