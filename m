Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752985AbeC2WM6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 18:12:58 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39019 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752553AbeC2WHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 18:07:19 -0400
X-Google-Smtp-Source: AIpwx4+Uez9Ir+DXcTolBLdRpugd1vUtsHk2z897piK7X3whbXtuahLJ8MXN4RLUInU2CB8GBaifdw==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, javier@cnexlabs.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 18/37] nvme: lightnvm: add late setup of block size and metadata
Date: Fri, 30 Mar 2018 00:05:05 +0200
Message-Id: <20180329220524.30363-19-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180329220524.30363-1-mb@lightnvm.io>
References: <20180329220524.30363-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nvme driver sets up the size of the nvme namespace in two steps.
First it initializes the device with standard logical block and
metadata sizes, and then sets the correct logical block and metadata
size. Due to the OCSSD 2.0 specification relies on the namespace to
expose these sizes for correct initialization, let it be updated
appropriately on the LightNVM side as well.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
Acked-by: Keith Busch <keith.busch@intel.com>
---
 drivers/lightnvm/core.c      | 3 ---
 drivers/nvme/host/core.c     | 2 ++
 drivers/nvme/host/lightnvm.c | 8 ++++++++
 drivers/nvme/host/nvme.h     | 2 ++
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 9704db219866..3eec948d1b7e 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -864,8 +864,6 @@ static int nvm_core_init(struct nvm_dev *dev)
 	geo->ws_seq = id->ws_seq;
 	geo->ws_per_chk = id->ws_per_chk;
 	geo->nr_chks = id->num_chk;
-	geo->sec_size = id->csecs;
-	geo->oob_size = id->sos;
 	geo->mccap = id->mccap;
 
 	geo->sec_per_chk = id->clba;
@@ -893,7 +891,6 @@ static int nvm_core_init(struct nvm_dev *dev)
 	if (ret)
 		goto err_fmtype;
 
-	blk_queue_logical_block_size(dev->q, geo->sec_size);
 	return 0;
 err_fmtype:
 	kfree(dev->lun_map);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9ee919422669..e7ec2fb5c59a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1448,6 +1448,8 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	if (ns->noiob)
 		nvme_set_chunk_size(ns);
 	nvme_update_disk_info(disk, ns, id);
+	if (ns->ndev)
+		nvme_nvm_update_nvm_info(ns);
 #ifdef CONFIG_NVME_MULTIPATH
 	if (ns->head->disk)
 		nvme_update_disk_info(ns->head->disk, ns, id);
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index e38d835b15b5..839c0b96466a 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -812,6 +812,14 @@ int nvme_nvm_ioctl(struct nvme_ns *ns, unsigned int cmd, unsigned long arg)
 	}
 }
 
+void nvme_nvm_update_nvm_info(struct nvme_ns *ns)
+{
+	struct nvm_dev *ndev = ns->ndev;
+
+	ndev->identity.csecs = ndev->geo.sec_size = 1 << ns->lba_shift;
+	ndev->identity.sos = ndev->geo.oob_size = ns->ms;
+}
+
 int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
 {
 	struct request_queue *q = ns->queue;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c393e4b56f39..aa10842a6709 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -500,12 +500,14 @@ static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
 #endif /* CONFIG_NVME_MULTIPATH */
 
 #ifdef CONFIG_NVM
+void nvme_nvm_update_nvm_info(struct nvme_ns *ns);
 int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node);
 void nvme_nvm_unregister(struct nvme_ns *ns);
 int nvme_nvm_register_sysfs(struct nvme_ns *ns);
 void nvme_nvm_unregister_sysfs(struct nvme_ns *ns);
 int nvme_nvm_ioctl(struct nvme_ns *ns, unsigned int cmd, unsigned long arg);
 #else
+static inline void nvme_nvm_update_nvm_info(struct nvme_ns *ns) {};
 static inline int nvme_nvm_register(struct nvme_ns *ns, char *disk_name,
 				    int node)
 {
-- 
2.11.0
