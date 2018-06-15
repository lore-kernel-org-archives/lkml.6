Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AA8F6C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 01:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D4F20891
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 01:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hlSLdanw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D4F20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965368AbeFOB4e (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 21:56:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40964 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965063AbeFOB4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 21:56:33 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5F1niKE162968;
        Fri, 15 Jun 2018 01:56:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2017-10-26;
 bh=ieBe5KcsAVZwQyLqWbPeLFVkCjo2bxl5ZS3Q/HlI7nU=;
 b=hlSLdanwqn77WKEuecoV4Fdqe4J3225oVjfIaHWcwd8c+I2Kl5MykvQsnR8WVkg42UYr
 N6X79WdLHzf2z44xkefDi/rJoQ5CtiywWgZ41uCWec7+xi4LSLBhi2NYqujQrj0DD39q
 Qu9GOpHH8kIIQvou+UM3zQn3nvyao2eGG1YbWXwhdq39zzVIMdTqFdNI6mRNZ+CgTxuX
 QMQVJfZv7LLz9zDadSILLckAqkBXMm8s1Ww25eFyJ8cyltgo9HRA0bhmkea2+T4VjHcF
 /trqe3Y2L+ujYLbM9mVqKTc1QP71/m1hnW09fS5vLQQubCAz8xvC2Z6SY2UdIZTsnyCb 0g== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2jk0xrf89d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 01:56:27 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5F1uRHL008267
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 01:56:27 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5F1uQjB019035;
        Fri, 15 Jun 2018 01:56:26 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Jun 2018 18:56:25 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk, hch@lst.de
Cc:     jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] block: export __blk_complete_request
Date:   Fri, 15 Jun 2018 09:57:26 +0800
Message-Id: <1529027847-29085-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8924 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806150018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After f6e7d48 (block: remove BLK_EH_HANDLED), LLDD is responsible
to complete the timed out request, however, for blk-legacy, the
'complete' is still marked, blk_complete_request will do nothing,
we export __blk_complete_request for LLDD to complete the request
in timeout path.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-softirq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-softirq.c b/block/blk-softirq.c
index 01e2b35..15c1f5e 100644
--- a/block/blk-softirq.c
+++ b/block/blk-softirq.c
@@ -144,6 +144,7 @@ void __blk_complete_request(struct request *req)
 
 	local_irq_restore(flags);
 }
+EXPORT_SYMBOL(__blk_complete_request);
 
 /**
  * blk_complete_request - end I/O on a request
-- 
2.7.4

