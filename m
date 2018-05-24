Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967703AbeEXJv1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 05:51:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48766 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966279AbeEXJvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 05:51:12 -0400
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] nvme-pci: don't send delete cq command when allocate sq return -EINTR
Date: Thu, 24 May 2018 17:51:34 +0800
Message-Id: <1527155494-1891-2-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527155494-1891-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1527155494-1891-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8902 signatures=668700
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805240119
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When allocate sq in nvme_create_queue return -EINTR, it means the
allocate sq command times out and is completed with NVME_REQ_CANCELLED.
At the moment, the controller has been disabled and admin request
queue has been quiesced. Don't send delete cq command, otherwise,
it will incur io hang.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/nvme/host/pci.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 70b79f2..4ce1c89 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1478,7 +1478,15 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 		goto out;
 
 	result = adapter_alloc_sq(dev, qid, nvmeq);
-	if (result < 0)
+	/*
+	 * If return -EINTR, it means the allocate sq command times out and is completed
+	 * with NVME_REQ_CANCELLED. At the time, the controller has been disabled
+	 * and admin request queue has been quiesced. So don't try to send delete cq
+	 * command any more.
+	 */
+	if (result == -EINTR)
+		goto out;
+	else if (result < 0)
 		goto release_cq;
 
 	/*
-- 
2.7.4
