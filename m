Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751677AbeCZIma (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:42:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:39689 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750989AbeCZIm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:42:29 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] nvme: unexport nvme_start_keep_alive
Date: Mon, 26 Mar 2018 10:40:15 +0200
Message-Id: <20180326084015.9269-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nvme_start_keep_alive() isn't used outside core.c so unexport it and
make it static.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/nvme/host/core.c | 3 +--
 drivers/nvme/host/nvme.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7aeca5db7916..884061c7ebee 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -828,7 +828,7 @@ static void nvme_keep_alive_work(struct work_struct *work)
 	}
 }
 
-void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
+static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
 {
 	if (unlikely(ctrl->kato == 0))
 		return;
@@ -838,7 +838,6 @@ void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
 	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
 	schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
 }
-EXPORT_SYMBOL_GPL(nvme_start_keep_alive);
 
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d733b14ede9d..7915d6d3fc3f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -394,7 +394,6 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		unsigned timeout, int qid, int at_head,
 		blk_mq_req_flags_t flags);
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
-void nvme_start_keep_alive(struct nvme_ctrl *ctrl);
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
-- 
2.16.2
