Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F32FECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6EC62086E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6EC62086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390514AbeIUTbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:31:39 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45167 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389581AbeIUTbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:31:36 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B8E074F85401F;
        Fri, 21 Sep 2018 21:42:37 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.399.0; Fri, 21 Sep 2018 21:42:38 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <george.cherian@cavium.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] crypto: cavium: remove redundant null pointer check before kfree
Date:   Fri, 21 Sep 2018 21:30:15 +0800
Message-ID: <1537536615-46814-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kfree has taken the null pointer into account. hence it is safe
to remove the redundant null pointer check before kfree.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/crypto/cavium/cpt/cptvf_reqmanager.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/crypto/cavium/cpt/cptvf_reqmanager.c b/drivers/crypto/cavium/cpt/cptvf_reqmanager.c
index b0ba433..ca549c5 100644
--- a/drivers/crypto/cavium/cpt/cptvf_reqmanager.c
+++ b/drivers/crypto/cavium/cpt/cptvf_reqmanager.c
@@ -308,21 +308,11 @@ void do_request_cleanup(struct cpt_vf *cptvf,
 		}
 	}
 
-	if (info->scatter_components)
-		kzfree(info->scatter_components);
-
-	if (info->gather_components)
-		kzfree(info->gather_components);
-
-	if (info->out_buffer)
-		kzfree(info->out_buffer);
-
-	if (info->in_buffer)
-		kzfree(info->in_buffer);
-
-	if (info->completion_addr)
-		kzfree((void *)info->completion_addr);
-
+	kzfree(info->scatter_components);
+	kzfree(info->gather_components);
+	kzfree(info->out_buffer);
+	kzfree(info->in_buffer);
+	kzfree((void *)info->completion_addr);
 	kzfree(info);
 }
 
-- 
1.7.12.4

