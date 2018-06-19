Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBD1C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E182083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IxPn2CVg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E182083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965652AbeFSIaV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:30:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50562 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965372AbeFSIaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:30:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5J8TLWD076218;
        Tue, 19 Jun 2018 08:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2017-10-26;
 bh=Hd9ymd0pt2iC3PPOK6Mp1W5se13spbA5pVkIEI/cYSY=;
 b=IxPn2CVgOGQCel6vfCBch+rhrhASqF2l+W0JWQL9mLvPqRcfWYTGBl6DW0zntdgr1vU/
 y1AOueR8LR/pc+3mQ0HnebL8IaoUJ2gWvwIgphmPsmPVvbvQuO3VOWbkhW9mNN1nG80b
 PljlXfSLk+8SB05es4u13EOrAWez+d1IGl/BuYE/spbA+MSwT9XzPbniNJ99upuDKQnJ
 EPy8/dw9m8pwdHH+mR0v+EWIJWvdw8DptfYOW0b6IJnwx6H4y8oaImsqVrau+lHIjKXc
 CVzhT5todXEoRc4BYMTWEis4FdzUrQsS3+1yXxr+AWEyFjuz5/6OW5Xgrx6V5rqf7Sjs pw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2jmu6xq18u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 08:29:46 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5J8TjeT007271
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 08:29:45 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5J8ThiB027698;
        Tue, 19 Jun 2018 08:29:44 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jun 2018 01:29:43 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: not invoke nvme_remove_dead_ctrl when change state fails
Date:   Tue, 19 Jun 2018 16:30:50 +0800
Message-Id: <1529397050-7524-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8928 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=890
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806190098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is race between nvme_remove and nvme_reset_work that can
lead to io hang.

nvme_remove                    nvme_reset_work
-> change state to DELETING
                               -> fail to change state to LIVE
                               -> nvme_remove_dead_ctrl
                                 -> nvme_dev_disable
                                   -> quiesce request_queue
                                 -> queue remove_work
-> cancel_work_sync reset_work
-> nvme_remove_namespaces
  -> splice ctrl->namespaces
                               nvme_remove_dead_ctrl_work
                               -> nvme_kill_queues
  -> nvme_ns_remove               do nothing
    -> blk_cleanup_queue
      -> blk_freeze_queue
Finally, the request_queue is quiesced state when wait freeze,
we will get io hang here.

In fact, when fails to change state in nvme_reset_work, the only
reason is someone has changed state to DELETING. So it is not
necessary to invoke nvme_remove_dead_ctrl in that case.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/nvme/host/pci.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fc33804..fc56e63 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2318,7 +2318,7 @@ static void nvme_reset_work(struct work_struct *work)
 	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_CONNECTING)) {
 		dev_warn(dev->ctrl.device,
 			"failed to mark controller CONNECTING\n");
-		goto out;
+		goto fail_state;
 	}
 
 	result = nvme_pci_enable(dev);
@@ -2390,13 +2390,22 @@ static void nvme_reset_work(struct work_struct *work)
 	if (!nvme_change_ctrl_state(&dev->ctrl, new_state)) {
 		dev_warn(dev->ctrl.device,
 			"failed to mark controller state %d\n", new_state);
-		goto out;
+		goto fail_state;
 	}
 
 	nvme_start_ctrl(&dev->ctrl);
 	return;
 
- out:
+fail_state:
+	/*
+	 * The only possible state here is DELETING, there must be someone
+	 * removing the ctrl right now, so needn't invoke nvme_remove_dead_ctrl.
+	 * The queues may have been quiesced, start them to avoid io hang.
+	 */
+	WARN_ON(dev->ctrl.state != NVME_CTRL_DELETING);
+	nvme_start_queues(&dev->ctrl);
+	return;
+out:
 	nvme_remove_dead_ctrl(dev, result);
 }
 
-- 
2.7.4

