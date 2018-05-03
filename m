Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbeECPAp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 11:00:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:47652 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750954AbeECPAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 11:00:44 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        James Smart <james.smart@broadcom.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] nvmet: switch loopback target state to connecting when resetting
Date: Thu,  3 May 2018 17:00:35 +0200
Message-Id: <20180503150035.13918-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit bb06ec31452f ("nvme: expand nvmf_check_if_ready checks")
resetting of the loopback nvme target failed as we forgot to switch
it's state to NVME_CTRL_CONNECTING before we reconnect the admin
queues. Therefore the checks in nvmf_check_if_ready() choose to go to
the reject_io case and thus we couldn't sent out an identify
controller command to reconnect.

Change the controller state to NVME_CTRL_CONNECTING after tearing down
the old connection and before re-establishing the connection.

Fixes: bb06ec31452f ("nvme: expand nvmf_check_if_ready checks")
Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/nvme/target/loop.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 31fdfba556a8..27a8561c0cb9 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -469,6 +469,12 @@ static void nvme_loop_reset_ctrl_work(struct work_struct *work)
 	nvme_stop_ctrl(&ctrl->ctrl);
 	nvme_loop_shutdown_ctrl(ctrl);
 
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
+		/* state change failure should never happen */
+		WARN_ON_ONCE(1);
+		return;
+	}
+
 	ret = nvme_loop_configure_admin_queue(ctrl);
 	if (ret)
 		goto out_disable;
-- 
2.16.3
