Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1DFC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E1520820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nvUPFSMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E1520820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408287AbeKWR56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 12:57:58 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60774 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732103AbeKWR56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 12:57:58 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAN7AJ5a031888;
        Fri, 23 Nov 2018 07:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=Zc7adYy73by/XXxhaui01rmwfqa9GPowNXVreIDcn7U=;
 b=nvUPFSMdyf0xgcqHrnlcuBzX69k832V9pehiK+QtqtFgwPx7wEbZgor4dmaYjVdRNlo1
 3mKwcSLGwG7HWofjD5xDhHdTq+SG/FPhEoGZF6OIgIUGia83TSBR9vttHfUMH9O9XPHa
 tNdqDZupdnuXoAIadbvpW3pD4Jl+I+v9O+vS+VKkMY8FVLDaAiNyNm0wn4OtGD30Q01V
 gImSmLk5XneKCsAGzK0JnFGqKAFZZi24rxzUW8d+Io4SYQyKh1OgP1acWk7J0A0U1RYs
 8/Kg6nEPL95qlks7bkzg7OVDeGKkCRaSwL3ETjygsbbqgP45y5gCwOerpDJIwac0Bsaz jg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2ntadu9euy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Nov 2018 07:14:54 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAN7ErMi012827
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Nov 2018 07:14:53 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAN7Ertf028055;
        Fri, 23 Nov 2018 07:14:53 GMT
Received: from kili.mountain (/197.157.0.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 22 Nov 2018 23:14:52 -0800
Date:   Fri, 23 Nov 2018 10:14:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] i3c: fix an error code in i3c_master_add_i3c_dev_locked()
Message-ID: <20181123071324.iwmbay2yrbiocisf@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9085 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=687
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811230057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should return "ret" as-is.  The "newdev" variable is a valid pointer.

Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/i3c/master.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 0ea7bb045fad..bda4b9613e53 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1823,10 +1823,8 @@ int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
 		return PTR_ERR(newdev);
 
 	ret = i3c_master_attach_i3c_dev(master, newdev);
-	if (ret) {
-		ret = PTR_ERR(newdev);
+	if (ret)
 		goto err_free_dev;
-	}
 
 	ret = i3c_master_retrieve_dev_info(newdev);
 	if (ret)
-- 
2.11.0

