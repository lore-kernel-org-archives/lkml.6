Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DE9C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0605B20844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0605B20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732484AbeGaSGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:06:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50058 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728052AbeGaSGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:06:03 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 256EC9F4DD96F;
        Wed,  1 Aug 2018 00:24:54 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.399.0; Wed, 1 Aug 2018 00:24:49 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] block/bsg-lib: use PTR_ERR_OR_ZERO to simplify the flow path
Date:   Wed, 1 Aug 2018 00:13:14 +0800
Message-ID: <1533053594-35244-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the code by using the PTR_ERR_OR_ZERO, instead of the
open code. It is better.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 block/bsg-lib.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index 9419def..f3501cd 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -48,9 +48,8 @@ static int bsg_transport_fill_hdr(struct request *rq, struct sg_io_v4 *hdr,
 
 	job->request_len = hdr->request_len;
 	job->request = memdup_user(uptr64(hdr->request), hdr->request_len);
-	if (IS_ERR(job->request))
-		return PTR_ERR(job->request);
-	return 0;
+
+	return PTR_ERR_OR_ZERO(job->request);
 }
 
 static int bsg_transport_complete_rq(struct request *rq, struct sg_io_v4 *hdr)
-- 
1.7.12.4

