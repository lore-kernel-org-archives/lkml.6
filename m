Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2995C282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8833C218D2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbfAYCBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 21:01:09 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2231 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727983AbfAYCBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 21:01:08 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7525EC374AD9A5CD857B;
        Fri, 25 Jan 2019 10:01:06 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Fri, 25 Jan 2019
 10:00:55 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <satishkh@cisco.com>, <sebaddel@cisco.com>, <kartilak@cisco.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] scsi: fnic: Remove set but not used variable 'vdev'
Date:   Fri, 25 Jan 2019 10:00:14 +0800
Message-ID: <20190125020014.11184-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/scsi/fnic/vnic_wq.c: In function 'vnic_wq_alloc_bufs':
drivers/scsi/fnic/vnic_wq.c:50:19: warning:
 variable 'vdev' set but not used [-Wunused-but-set-variable]

drivers/scsi/fnic/vnic_rq.c: In function 'vnic_rq_alloc_bufs':
drivers/scsi/fnic/vnic_rq.c:30:19: warning:
 variable 'vdev' set but not used [-Wunused-but-set-variable]

It never used since introduction

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/fnic/vnic_rq.c | 3 ---
 drivers/scsi/fnic/vnic_wq.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/drivers/scsi/fnic/vnic_rq.c b/drivers/scsi/fnic/vnic_rq.c
index 74d2f2c..6a35b1b 100644
--- a/drivers/scsi/fnic/vnic_rq.c
+++ b/drivers/scsi/fnic/vnic_rq.c
@@ -27,12 +27,9 @@
 static int vnic_rq_alloc_bufs(struct vnic_rq *rq)
 {
 	struct vnic_rq_buf *buf;
-	struct vnic_dev *vdev;
 	unsigned int i, j, count = rq->ring.desc_count;
 	unsigned int blks = VNIC_RQ_BUF_BLKS_NEEDED(count);
 
-	vdev = rq->vdev;
-
 	for (i = 0; i < blks; i++) {
 		rq->bufs[i] = kzalloc(VNIC_RQ_BUF_BLK_SZ, GFP_ATOMIC);
 		if (!rq->bufs[i]) {
diff --git a/drivers/scsi/fnic/vnic_wq.c b/drivers/scsi/fnic/vnic_wq.c
index 74cfc56..015af2c 100644
--- a/drivers/scsi/fnic/vnic_wq.c
+++ b/drivers/scsi/fnic/vnic_wq.c
@@ -47,12 +47,9 @@ int vnic_wq_alloc_ring(struct vnic_dev *vdev, struct vnic_wq *wq,
 static int vnic_wq_alloc_bufs(struct vnic_wq *wq)
 {
 	struct vnic_wq_buf *buf;
-	struct vnic_dev *vdev;
 	unsigned int i, j, count = wq->ring.desc_count;
 	unsigned int blks = VNIC_WQ_BUF_BLKS_NEEDED(count);
 
-	vdev = wq->vdev;
-
 	for (i = 0; i < blks; i++) {
 		wq->bufs[i] = kzalloc(VNIC_WQ_BUF_BLK_SZ, GFP_ATOMIC);
 		if (!wq->bufs[i]) {
-- 
2.7.0


