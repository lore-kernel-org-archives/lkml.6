Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753392AbeC0SAq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 14:00:46 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40894 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753106AbeC0SAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 14:00:43 -0400
X-Google-Smtp-Source: AIpwx4/ZO8OilObSH7qlTZXHIsykub73KZzEXA2snc9OnvDr7JXnK96T8FFw15kuBl+L7m1Q+u3hhg==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: keith.busch@intel.com
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH] nvme: enforce 64bit offset for nvme_get_log_ext fn
Date: Tue, 27 Mar 2018 20:00:33 +0200
Message-Id: <20180327180033.28316-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling on 32 bits system produces a warning for the shift width
when shifting 32 bit integer with 64bit integer.

Make sure that offset always is 64bit, and use macros for retrieving
lower and upper bits of the offset.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/nvme/host/core.c | 6 +++---
 drivers/nvme/host/nvme.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f81e3b323366..a22fc5304cd7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2220,7 +2220,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 
 int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		     u8 log_page, void *log,
-		     size_t size, size_t offset)
+		     size_t size, u64 offset)
 {
 	struct nvme_command c = { };
 	unsigned long dwlen = size / 4 - 1;
@@ -2235,8 +2235,8 @@ int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.get_log_page.lid = log_page;
 	c.get_log_page.numdl = cpu_to_le16(dwlen & ((1 << 16) - 1));
 	c.get_log_page.numdu = cpu_to_le16(dwlen >> 16);
-	c.get_log_page.lpol = cpu_to_le32(offset & ((1ULL << 32) - 1));
-	c.get_log_page.lpou = cpu_to_le32(offset >> 32ULL);
+	c.get_log_page.lpol = cpu_to_le32(lower_32_bits(offset));
+	c.get_log_page.lpou = cpu_to_le32(upper_32_bits(offset));
 
 	return nvme_submit_sync_cmd(ctrl->admin_q, &c, log, size);
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index aa10842a6709..e9cca9c59a68 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -430,7 +430,7 @@ int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
 int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
 
 int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-		u8 log_page, void *log, size_t size, size_t offset);
+		u8 log_page, void *log, size_t size, u64 offset);
 
 extern const struct attribute_group nvme_ns_id_attr_group;
 extern const struct block_device_operations nvme_ns_head_ops;
-- 
2.11.0
