Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A832AC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 01:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6031920891
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 01:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q8iG+fXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6031920891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965399AbeFOB4j (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 21:56:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41014 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965063AbeFOB4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 21:56:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5F1qWou164421;
        Fri, 15 Jun 2018 01:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=wra2lQURA+dFCnoJSJkM9Jupnkni2a1HRYzKOIMpIUA=;
 b=q8iG+fXr2FmoEwgE/sBvOIuelMyoTtiHGUXfexT4mZl96YFdHgyRq4lH721hwZ7a4cRD
 sbED8m9w86v8yJu2S8XMMLqT5ExZr1BFKf/QM7I8bFhRwjhuFttzu74W8Sy0+yxthBQS
 x3NPjNS8pDqDCUzoscK0Nfiapkf/yB+gvdgbjLh/78thKyL6/iFg9ya4yjv0lAehFQRh
 7DyiCbOC47xAtvX9bvk7kYCxzZjnR2+M5WSqZM9Nps1lZWE9/FzvbC1hGqSvUteFdT9B
 bEmoswz27BiBJkEnr3gUQy+t39M0/TrczH7Efm05HC3RbSbXnlQEdCOlBW++/JLdoRt2 YA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2jk0xrf89e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 01:56:31 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5F1uUK6022814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 01:56:30 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5F1uSNY010604;
        Fri, 15 Jun 2018 01:56:29 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Jun 2018 18:56:28 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk, hch@lst.de
Cc:     jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] scsi_transport_fc: use __blk_complete_request in fc_bsg_job_timeout
Date:   Fri, 15 Jun 2018 09:57:27 +0800
Message-Id: <1529027847-29085-2-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529027847-29085-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1529027847-29085-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8924 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806150018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bsg is based on blk-legacy, so we should use blk-legacy interface
here. On the other hand, for blk-legacy, the timed out request
has 'complete' mark, so use __blk_complete_request.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/scsi/scsi_transport_fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index 1da3d71..1394810 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -3592,7 +3592,7 @@ fc_bsg_job_timeout(struct request *req)
 
 	/* the blk_end_sync_io() doesn't check the error */
 	if (inflight)
-		blk_mq_complete_request(req);
+		__blk_complete_request(req);
 	return BLK_EH_DONE;
 }
 
-- 
2.7.4

