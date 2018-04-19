Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753536AbeDSRnw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 13:43:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:59747 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753299AbeDSRnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 13:43:51 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Keith Busch <keith.busch@intel.com>
Cc: James Smart <james.smart@broadcom.com>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] nvme: fc: provide a descriptive error
Date: Thu, 19 Apr 2018 19:43:42 +0200
Message-Id: <20180419174342.27307-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a descriptive error in case an lport to rport association
isn't found when creating the FC-NVME controller.

Currently it's very hard to debug the reason for a failed connect
attempt without a look at the source.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

---
This actually happened to Hannes and me becuase of a typo in a
customer demo today, so yes things like this happen unitl we have a
proper way to do auto-connect.
---
 drivers/nvme/host/fc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 6cb26bcf6ec0..8b66879b4ebf 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3284,6 +3284,8 @@ nvme_fc_create_ctrl(struct device *dev, struct nvmf_ctrl_options *opts)
 	}
 	spin_unlock_irqrestore(&nvme_fc_lock, flags);
 
+	pr_warn("%s: %s - %s combination not found\n",
+		__func__, opts->traddr, opts->host_traddr);
 	return ERR_PTR(-ENOENT);
 }
 
-- 
2.16.3
