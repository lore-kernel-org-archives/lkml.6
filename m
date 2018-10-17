Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAF0ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682612151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EQp2+c1N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682612151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbeJQRBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:01:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47446 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbeJQRBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 13:01:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9H8x6kx068776;
        Wed, 17 Oct 2018 09:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=xar3IM2xcUOuRJ8vfJjoYMneHSe65id2InNHRVWwp3A=;
 b=EQp2+c1Ndp02uPFSrxuN91k54Ptqp7wFL69jMDCtPpAzB+m4W9Cy4tuKINsd/Le+lh/q
 dqulCAKefZT/puIgxYBWA5WLbBsvsP7h6OUEwtx/f2yXDHIrAuiN+MqUxILgFapAcwOS
 a3fBT+yKGLiMbwCnIUGsYMQiwJTH1kmNUhejVCSFMVzn17Yol2iVaftllcY/H43XCiyV
 b2Vigzpq+0NR0fT3Gcxd98MOJA7ozOij4GqZcLfyam2cxO954yina7t5IQE63F4hNtPB
 1Yu1cFXf+8QyibkwvSFg2FUgBD8ltenCv//KL7m7JJbLmmVHvFRcPwXaLeSyiDrgF6z2 Cw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2n39brdh0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Oct 2018 09:05:13 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9H956pw009465
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Oct 2018 09:05:07 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9H955KW026741;
        Wed, 17 Oct 2018 09:05:06 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Oct 2018 02:05:05 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, keith.busch@linux.intel.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/3] nvme-pci: unquiesce queues after update hw queues
Date:   Wed, 17 Oct 2018 17:07:12 +0800
Message-Id: <1539767232-9389-4-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539767232-9389-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1539767232-9389-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9048 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=933
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810170082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

updating hw queues uses bio retrieve to drain the queues. unquiescing
queues before that is not needed and will cause requests to be issued
to dead hw queue. So move unquiescing queues after updating hw queues,
as well as the wait freeze.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d668682..dbf6904 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2327,11 +2327,11 @@ static void nvme_reset_work(struct work_struct *work)
 		nvme_remove_namespaces(&dev->ctrl);
 		new_state = NVME_CTRL_ADMIN_ONLY;
 	} else {
-		nvme_start_queues(&dev->ctrl);
-		nvme_wait_freeze(&dev->ctrl);
 		/* hit this only when allocate tagset fails */
 		if (nvme_dev_add(dev))
 			new_state = NVME_CTRL_ADMIN_ONLY;
+		nvme_start_queues(&dev->ctrl);
+		nvme_wait_freeze(&dev->ctrl);
 		nvme_unfreeze(&dev->ctrl);
 	}
 
-- 
2.7.4

