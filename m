Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD396C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 09:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587E920855
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 09:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 587E920855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbeIHNrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 09:47:39 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54569 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726171AbeIHNrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 09:47:39 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 194CC2874053A;
        Sat,  8 Sep 2018 17:02:33 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.399.0; Sat, 8 Sep 2018 17:02:31 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <freude@linux.ibm.com>, <schwidefsky@de.ibm.com>,
        <heiko.carstens@de.ibm.com>
CC:     <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] s390/zcrypt: Use kmemdup to replace kmalloc + memcpy
Date:   Sat, 8 Sep 2018 16:50:21 +0800
Message-ID: <1536396621-19363-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup has implemented the function that kmalloc() + memcpy() will
do. and we prefer to use the kmemdup rather than the open coded implementation.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/s390/crypto/zcrypt_msgtype6.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index 2101776..9ac960d 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -1131,10 +1131,9 @@ unsigned int get_cprb_fc(struct ica_xcRB *xcRB,
 	ap_msg->receive = zcrypt_msgtype6_receive;
 	ap_msg->psmid = (((unsigned long long) current->pid) << 32) +
 				atomic_inc_return(&zcrypt_step);
-	ap_msg->private = kmalloc(sizeof(resp_type), GFP_KERNEL);
+	ap_msg->private = kmemdup(&resp_type, sizeof(resp_type), GFP_KERNEL);
 	if (!ap_msg->private)
 		return -ENOMEM;
-	memcpy(ap_msg->private, &resp_type, sizeof(resp_type));
 	return XCRB_msg_to_type6CPRB_msgX(ap_msg, xcRB, func_code, dom);
 }
 
@@ -1187,10 +1186,9 @@ unsigned int get_ep11cprb_fc(struct ep11_urb *xcrb,
 	ap_msg->receive = zcrypt_msgtype6_receive_ep11;
 	ap_msg->psmid = (((unsigned long long) current->pid) << 32) +
 				atomic_inc_return(&zcrypt_step);
-	ap_msg->private = kmalloc(sizeof(resp_type), GFP_KERNEL);
+	ap_msg->private = kmemdup(&resp_type, sizeof(resp_type), GFP_KERNEL);
 	if (!ap_msg->private)
 		return -ENOMEM;
-	memcpy(ap_msg->private, &resp_type, sizeof(resp_type));
 	return xcrb_msg_to_type6_ep11cprb_msgx(ap_msg, xcrb, func_code);
 }
 
@@ -1282,10 +1280,9 @@ unsigned int get_rng_fc(struct ap_message *ap_msg, int *func_code,
 	ap_msg->receive = zcrypt_msgtype6_receive;
 	ap_msg->psmid = (((unsigned long long) current->pid) << 32) +
 				atomic_inc_return(&zcrypt_step);
-	ap_msg->private = kmalloc(sizeof(resp_type), GFP_KERNEL);
+	ap_msg->private = kmemdup(&resp_type, sizeof(resp_type), GFP_KERNEL);
 	if (!ap_msg->private)
 		return -ENOMEM;
-	memcpy(ap_msg->private, &resp_type, sizeof(resp_type));
 
 	rng_type6CPRB_msgX(ap_msg, ZCRYPT_RNG_BUFFER_SIZE, domain);
 
-- 
1.7.12.4

