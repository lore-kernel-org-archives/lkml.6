Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5E7C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F84207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfAXNnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 08:43:14 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2228 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726105AbfAXNnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 08:43:14 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C39814B312EBD136C31C;
        Thu, 24 Jan 2019 21:43:10 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Thu, 24 Jan 2019 21:43:00 +0800
From:   chenxiang <chenxiang66@hisilicon.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <john.garry@huawei.com>,
        chenxiang <chenxiang66@hisilicon.com>
Subject: [PATCH] block: set rq->cmd_flags with bio->opf instead of data->cmd_flags when bio is not Null
Date:   Thu, 24 Jan 2019 21:43:50 +0800
Message-ID: <1548337430-66690-1-git-send-email-chenxiang66@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function blk_mq_make_request(), though data->cmd_flags will be
initialized with bio->opf, later bio->opf may be set as REQ_INTEGRITY
if enabled DIX. So need to use bio->opf instead of data->cmd_flags in
function blk_mq_rq_ctx_init(), or  flags REQ_INTEGRITY will not be set
for rq->cmd_flags. It will cause dix=0 in function
sd_setup_read_write_cmnd() when enabled DIX, which will cause IO 
exception when enabled DIX.

For some IOs such as internal IO from SCSI layer, the parameter bio of
function blk_mq_get_request() is Null, so need to check bio to
decise rq->cmd_flags.

Fixes: f9afca4d367b ("blk-mq: pass in request/bio flags to queue mapping")

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Reviewed-by: John Garry <john.garry@huawei.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3ba37b9..c4a1c63 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -394,7 +394,7 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 		return NULL;
 	}
 
-	rq = blk_mq_rq_ctx_init(data, tag, data->cmd_flags);
+	rq = blk_mq_rq_ctx_init(data, tag, bio ? bio->bi_opf : data->cmd_flags);
 	if (!op_is_flush(data->cmd_flags)) {
 		rq->elv.icq = NULL;
 		if (e && e->type->ops.prepare_request) {
-- 
2.8.1

