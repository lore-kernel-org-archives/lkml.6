Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964799AbeBMMuT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:50:19 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34840 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935079AbeBMMuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:50:15 -0500
X-Google-Smtp-Source: AH8x226Kg243N8ZK0Su4yBO8J7tF4Mo/dc/WNvEPpRH0euWGXG12FKgaZu2gQTqUq4Ga3mAH24UN9g==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: hch@lst.de, keith.busch@intel.com
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        javier@cnexlabs.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH 1/1] nvme: implement log page low/high offset and dwords
Date: Tue, 13 Feb 2018 13:49:16 +0100
Message-Id: <20180213124916.28653-2-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180213124916.28653-1-mb@lightnvm.io>
References: <20180213124916.28653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVMe 1.2.1 extends the get log page interface to include 64 bit
offset and increases the number of dwords to 32 bits. Implement
for future use.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/nvme/host/core.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 740ceb28067c..f59527b93444 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -80,11 +80,6 @@ static struct class *nvme_subsys_class;
 static void nvme_ns_remove(struct nvme_ns *ns);
 static int nvme_revalidate_disk(struct gendisk *disk);
 
-static __le32 nvme_get_log_dw10(u8 lid, size_t size)
-{
-	return cpu_to_le32((((size / 4) - 1) << 16) | lid);
-}
-
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
 {
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
@@ -2132,16 +2127,33 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	return ret;
 }
 
+int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+			    u8 log_page, void *log,
+			    size_t size, size_t offset)
+{
+	struct nvme_command c = { };
+	unsigned long dwlen = (size / 4) - 1;
+
+	c.get_log_page.opcode = nvme_admin_get_log_page;
+
+	if (ns)
+		c.get_log_page.nsid = cpu_to_le32(ns->head->ns_id);
+	else
+		c.get_log_page.nsid = cpu_to_le32(NVME_NSID_ALL);
+
+	c.get_log_page.lid = log_page;
+	c.get_log_page.numdl = cpu_to_le16(dwlen & ((1 << 16) - 1));
+	c.get_log_page.numdu = cpu_to_le16(dwlen >> 16);
+	c.get_log_page.lpol = cpu_to_le32(offset & ((1ULL << 32) - 1));
+	c.get_log_page.lpou = cpu_to_le32(offset >> 32);
+
+	return nvme_submit_sync_cmd(ctrl->admin_q, &c, log, size);
+}
+
 static int nvme_get_log(struct nvme_ctrl *ctrl, u8 log_page, void *log,
 			size_t size)
 {
-	struct nvme_command c = { };
-
-	c.common.opcode = nvme_admin_get_log_page;
-	c.common.nsid = cpu_to_le32(NVME_NSID_ALL);
-	c.common.cdw10[0] = nvme_get_log_dw10(log_page, size);
-
-	return nvme_submit_sync_cmd(ctrl->admin_q, &c, log, size);
+	return nvme_get_log_ext(ctrl, NULL, log_page, log, size, 0);
 }
 
 static int nvme_get_effects_log(struct nvme_ctrl *ctrl)
-- 
2.11.0
