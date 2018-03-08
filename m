Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935550AbeCHGWj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 01:22:39 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:48102 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935509AbeCHGWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 01:22:31 -0500
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/5] nvme: do atomically bit operations on nvme_request.flags
Date: Thu,  8 Mar 2018 14:19:27 +0800
Message-Id: <1520489971-31174-2-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520489971-31174-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1520489971-31174-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8825 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=930
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803080079
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do atomically bit operations on nvme_request.flags instead of
regular read/write, then we could add other flags and set/clear
them safely.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/nvme/host/core.c     | 4 ++--
 drivers/nvme/host/lightnvm.c | 4 ++--
 drivers/nvme/host/nvme.h     | 4 ++--
 drivers/nvme/host/pci.c      | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 29ead91..7b8df47 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -674,7 +674,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	blk_execute_rq(req->q, NULL, req, at_head);
 	if (result)
 		*result = nvme_req(req)->result;
-	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
+	if (test_bit(NVME_REQ_CANCELLED, &nvme_req(req)->flags))
 		ret = -EINTR;
 	else
 		ret = nvme_req(req)->status;
@@ -763,7 +763,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	}
 
 	blk_execute_rq(req->q, disk, req, 0);
-	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
+	if (test_bit(NVME_REQ_CANCELLED, &nvme_req(req)->flags))
 		ret = -EINTR;
 	else
 		ret = nvme_req(req)->status;
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 50ef71ee..fd0c499 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -470,7 +470,7 @@ static int nvme_nvm_submit_io_sync(struct nvm_dev *dev, struct nvm_rq *rqd)
 	 * handle the error accordingly.
 	 */
 	blk_execute_rq(q, NULL, rq, 0);
-	if (nvme_req(rq)->flags & NVME_REQ_CANCELLED)
+	if (test_bit(NVME_REQ_CANCELLED, &nvme_req(rq)->flags))
 		ret = -EINTR;
 
 	rqd->ppa_status = le64_to_cpu(nvme_req(rq)->result.u64);
@@ -599,7 +599,7 @@ static int nvme_nvm_submit_user_cmd(struct request_queue *q,
 
 	blk_execute_rq(q, NULL, rq, 0);
 
-	if (nvme_req(rq)->flags & NVME_REQ_CANCELLED)
+	if (test_bit(NVME_REQ_CANCELLED, &nvme_req(rq)->flags))
 		ret = -EINTR;
 	else if (nvme_req(rq)->status & 0x7ff)
 		ret = -EIO;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e80fd74..02097e8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -93,8 +93,8 @@ struct nvme_request {
 	struct nvme_command	*cmd;
 	union nvme_result	result;
 	u8			retries;
-	u8			flags;
 	u16			status;
+	unsigned long flags;
 };
 
 /*
@@ -103,7 +103,7 @@ struct nvme_request {
 #define REQ_NVME_MPATH		REQ_DRV
 
 enum {
-	NVME_REQ_CANCELLED		= (1 << 0),
+	NVME_REQ_CANCELLED		= 0,
 };
 
 static inline struct nvme_request *nvme_req(struct request *req)
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 73036d2..e186158 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1222,7 +1222,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 			 "I/O %d QID %d timeout, disable controller\n",
 			 req->tag, nvmeq->qid);
 		nvme_dev_disable(dev, false);
-		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
+		set_bit(NVME_REQ_CANCELLED, &nvme_req(req)->flags);
 		return BLK_EH_HANDLED;
 	default:
 		break;
@@ -1244,7 +1244,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		 * Mark the request as handled, since the inline shutdown
 		 * forces all outstanding requests to complete.
 		 */
-		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
+		set_bit(NVME_REQ_CANCELLED, &nvme_req(req)->flags);
 		return BLK_EH_HANDLED;
 	}
 
-- 
2.7.4
