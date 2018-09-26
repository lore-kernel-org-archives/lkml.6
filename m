Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0278C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C10214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:42:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C10214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbeIZRyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:54:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34631 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727139AbeIZRyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:54:52 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8A3EF727834F8;
        Wed, 26 Sep 2018 19:42:15 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.399.0; Wed, 26 Sep 2018
 19:42:07 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <matthew@wil.cx>, <hare@suse.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] advansys: use correct srb_tag in adv_isr_callback
Date:   Wed, 26 Sep 2018 19:41:07 +0800
Message-ID: <20180926114107.13532-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'srb_tag' should be used in the scsi_host_find_tag,
rather than 'scsiqp->srb_tag'.

Fixes: 9c17c62aedb0 ("advansys: use shared host tag map for command lookup")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/advansys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
index 713f690..23f313c 100644
--- a/drivers/scsi/advansys.c
+++ b/drivers/scsi/advansys.c
@@ -5966,7 +5966,7 @@ static void adv_isr_callback(ADV_DVC_VAR *adv_dvc_varp, ADV_SCSI_REQ_Q *scsiqp)
 	 * completed ADV_SCSI_REQ_Q structure.
 	 */
 	srb_tag = le32_to_cpu(scsiqp->srb_tag);
-	scp = scsi_host_find_tag(boardp->shost, scsiqp->srb_tag);
+	scp = scsi_host_find_tag(boardp->shost, srb_tag);
 
 	ASC_DBG(1, "scp 0x%p\n", scp);
 	if (scp == NULL) {
-- 
1.8.3.1


