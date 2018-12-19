Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F804C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDB0218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbeLSPz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:55:57 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:16160 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727667AbeLSPz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:55:56 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2696CE722EF50;
        Wed, 19 Dec 2018 23:55:51 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Wed, 19 Dec 2018 23:55:44 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, Luo Jiaxing <luojiaxing@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 3/8] scsi: hisi_sas: Take debugfs snapshot for all regs
Date:   Wed, 19 Dec 2018 23:56:41 +0800
Message-ID: <1545235006-151716-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1545235006-151716-1-git-send-email-john.garry@huawei.com>
References: <1545235006-151716-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luo Jiaxing <luojiaxing@huawei.com>

This patch take snapshot for global regs, port regs, CQ, DQ, IOST, ITCT.

Then, Add code for snapshot trig and generate dump directory.

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h       |  15 +++-
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 125 +++++++++++++++++++++++++++++++++
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |   9 ++-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  37 +++++++++-
 4 files changed, 180 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index eca7e47..3b5fd6d 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -223,6 +223,12 @@ struct hisi_sas_slot {
 
 struct hisi_sas_debugfs_reg {
 	int count;
+	int base_off;
+	union {
+		u32 (*read_global_reg)(struct hisi_hba *hisi_hba, u32 off);
+		u32 (*read_port_reg)(struct hisi_hba *hisi_hba, int port,
+				     u32 off);
+	};
 };
 
 struct hisi_sas_hw {
@@ -264,8 +270,10 @@ struct hisi_sas_hw {
 	u32 (*get_phys_state)(struct hisi_hba *hisi_hba);
 	int (*write_gpio)(struct hisi_hba *hisi_hba, u8 reg_type,
 				u8 reg_index, u8 reg_count, u8 *write_data);
-	void (*wait_cmds_complete_timeout)(struct hisi_hba *hisi_hba,
-					   int delay_ms, int timeout_ms);
+	int (*wait_cmds_complete_timeout)(struct hisi_hba *hisi_hba,
+					  int delay_ms, int timeout_ms);
+	void (*snapshot_prepare)(struct hisi_hba *hisi_hba);
+	void (*snapshot_restore)(struct hisi_hba *hisi_hba);
 	int max_command_entries;
 	int complete_hdr_size;
 	struct scsi_host_template *sht;
@@ -337,6 +345,7 @@ struct hisi_hba {
 	const struct hisi_sas_hw *hw;	/* Low level hw interface */
 	unsigned long sata_dev_bitmap[BITS_TO_LONGS(HISI_SAS_MAX_DEVICES)];
 	struct work_struct rst_work;
+	struct work_struct debugfs_work;
 	u32 phy_state;
 	u32 intr_coal_ticks;	/* Time of interrupt coalesce in us */
 	u32 intr_coal_count;	/* Interrupt count to coalesce */
@@ -350,6 +359,7 @@ struct hisi_hba {
 	struct hisi_sas_itct *debugfs_itct;
 
 	struct dentry *debugfs_dir;
+	struct dentry *debugfs_dump_dentry;
 };
 
 /* Generic HW DMA host memory structures */
@@ -517,4 +527,5 @@ extern bool hisi_sas_notify_phy_event(struct hisi_sas_phy *phy,
 extern void hisi_sas_controller_reset_done(struct hisi_hba *hisi_hba);
 extern void hisi_sas_debugfs_init(struct hisi_hba *hisi_hba);
 extern void hisi_sas_debugfs_exit(struct hisi_hba *hisi_hba);
+extern void hisi_sas_debugfs_work_handler(struct work_struct *work);
 #endif
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 0b0dbaab..742f71a 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1429,6 +1429,10 @@ static int hisi_sas_controller_reset(struct hisi_hba *hisi_hba)
 	struct Scsi_Host *shost = hisi_hba->shost;
 	int rc;
 
+	if (hisi_sas_debugfs_enable && hisi_hba->debugfs_itct &&
+	    !hisi_hba->debugfs_dump_dentry)
+		queue_work(hisi_hba->wq, &hisi_hba->debugfs_work);
+
 	if (!hisi_hba->hw->soft_reset)
 		return -1;
 
@@ -1923,6 +1927,7 @@ static int hisi_sas_query_task(struct sas_task *task)
 				slot->task = NULL;
 			}
 			dev_err(dev, "internal task abort: timeout and not done.\n");
+
 			res = -EIO;
 			goto exit;
 		} else
@@ -2459,6 +2464,126 @@ int hisi_sas_probe(struct platform_device *pdev,
 
 struct dentry *hisi_sas_debugfs_dir;
 
+static void hisi_sas_debugfs_snapshot_cq_reg(struct hisi_hba *hisi_hba)
+{
+	int queue_entry_size = hisi_hba->hw->complete_hdr_size;
+	int i;
+
+	for (i = 0; i < hisi_hba->queue_count; i++)
+		memcpy(hisi_hba->debugfs_complete_hdr[i],
+		       hisi_hba->complete_hdr[i],
+		       HISI_SAS_QUEUE_SLOTS * queue_entry_size);
+}
+
+static void hisi_sas_debugfs_snapshot_dq_reg(struct hisi_hba *hisi_hba)
+{
+	int queue_entry_size = hisi_hba->hw->complete_hdr_size;
+	int i;
+
+	for (i = 0; i < hisi_hba->queue_count; i++)
+		memcpy(hisi_hba->debugfs_cmd_hdr[i],
+		       hisi_hba->cmd_hdr[i],
+		       HISI_SAS_QUEUE_SLOTS * queue_entry_size);
+}
+
+static void hisi_sas_debugfs_snapshot_port_reg(struct hisi_hba *hisi_hba)
+{
+	const struct hisi_sas_debugfs_reg *port =
+		hisi_hba->hw->debugfs_reg_port;
+	int i, phy_cnt;
+	u32 offset;
+	u32 *databuf;
+
+	for (phy_cnt = 0; phy_cnt < hisi_hba->n_phy; phy_cnt++) {
+		databuf = (u32 *)hisi_hba->debugfs_port_reg[phy_cnt];
+		for (i = 0; i < port->count; i++, databuf++) {
+			offset = port->base_off + 4 * i;
+			*databuf = port->read_port_reg(hisi_hba, phy_cnt,
+						       offset);
+		}
+	}
+}
+
+static void hisi_sas_debugfs_snapshot_global_reg(struct hisi_hba *hisi_hba)
+{
+	u32 *databuf = (u32 *)hisi_hba->debugfs_global_reg;
+	const struct hisi_sas_debugfs_reg *global =
+		hisi_hba->hw->debugfs_reg_global;
+	int i;
+
+	for (i = 0; i < global->count; i++, databuf++)
+		*databuf = global->read_global_reg(hisi_hba, 4 * i);
+}
+
+static void hisi_sas_debugfs_snapshot_itct_reg(struct hisi_hba *hisi_hba)
+{
+	void *databuf = hisi_hba->debugfs_itct;
+	struct hisi_sas_itct *itct;
+	int i;
+
+	itct = hisi_hba->itct;
+
+	for (i = 0; i < HISI_SAS_MAX_ITCT_ENTRIES; i++, itct++) {
+		memcpy(databuf, itct, sizeof(struct hisi_sas_itct));
+		databuf += sizeof(struct hisi_sas_itct);
+	}
+}
+
+static void hisi_sas_debugfs_snapshot_iost_reg(struct hisi_hba *hisi_hba)
+{
+	int max_command_entries = hisi_hba->hw->max_command_entries;
+	void *databuf = hisi_hba->debugfs_iost;
+	struct hisi_sas_iost *iost;
+	int i;
+
+	iost = hisi_hba->iost;
+
+	for (i = 0; i < max_command_entries; i++, iost++) {
+		memcpy(databuf, iost, sizeof(struct hisi_sas_iost));
+		databuf += sizeof(struct hisi_sas_iost);
+	}
+}
+
+static void hisi_sas_debugfs_create_files(struct hisi_hba *hisi_hba)
+{
+	struct dentry *dump_dentry;
+
+	/* Create dump dir inside device dir */
+	dump_dentry = debugfs_create_dir("dump", hisi_hba->debugfs_dir);
+	if (!dump_dentry)
+		goto fail;
+
+	hisi_hba->debugfs_dump_dentry = dump_dentry;
+	return;
+fail:
+	debugfs_remove_recursive(hisi_hba->debugfs_dir);
+}
+
+static void hisi_sas_debugfs_snapshot_regs(struct hisi_hba *hisi_hba)
+{
+	hisi_hba->hw->snapshot_prepare(hisi_hba);
+
+	hisi_sas_debugfs_snapshot_global_reg(hisi_hba);
+	hisi_sas_debugfs_snapshot_port_reg(hisi_hba);
+	hisi_sas_debugfs_snapshot_cq_reg(hisi_hba);
+	hisi_sas_debugfs_snapshot_dq_reg(hisi_hba);
+	hisi_sas_debugfs_snapshot_itct_reg(hisi_hba);
+	hisi_sas_debugfs_snapshot_iost_reg(hisi_hba);
+
+	hisi_sas_debugfs_create_files(hisi_hba);
+
+	hisi_hba->hw->snapshot_restore(hisi_hba);
+}
+
+void hisi_sas_debugfs_work_handler(struct work_struct *work)
+{
+	struct hisi_hba *hisi_hba =
+		container_of(work, struct hisi_hba, debugfs_work);
+
+	hisi_sas_debugfs_snapshot_regs(hisi_hba);
+}
+EXPORT_SYMBOL_GPL(hisi_sas_debugfs_work_handler);
+
 void hisi_sas_debugfs_init(struct hisi_hba *hisi_hba)
 {
 	int max_command_entries = hisi_hba->hw->max_command_entries;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 9083205..8c97cf2 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3544,8 +3544,8 @@ static int write_gpio_v2_hw(struct hisi_hba *hisi_hba, u8 reg_type,
 	return 0;
 }
 
-static void wait_cmds_complete_timeout_v2_hw(struct hisi_hba *hisi_hba,
-					     int delay_ms, int timeout_ms)
+static int wait_cmds_complete_timeout_v2_hw(struct hisi_hba *hisi_hba,
+					    int delay_ms, int timeout_ms)
 {
 	struct device *dev = hisi_hba->dev;
 	int entries, entries_old = 0, time;
@@ -3559,7 +3559,12 @@ static void wait_cmds_complete_timeout_v2_hw(struct hisi_hba *hisi_hba,
 		msleep(delay_ms);
 	}
 
+	if (time >= timeout_ms)
+		return -ETIMEDOUT;
+
 	dev_dbg(dev, "wait commands complete %dms\n", time);
+
+	return 0;
 }
 
 static struct device_attribute *host_attrs_v2_hw[] = {
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 6efa61e..4dd48ac 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2203,8 +2203,8 @@ static int write_gpio_v3_hw(struct hisi_hba *hisi_hba, u8 reg_type,
 	return 0;
 }
 
-static void wait_cmds_complete_timeout_v3_hw(struct hisi_hba *hisi_hba,
-					     int delay_ms, int timeout_ms)
+static int wait_cmds_complete_timeout_v3_hw(struct hisi_hba *hisi_hba,
+					    int delay_ms, int timeout_ms)
 {
 	struct device *dev = hisi_hba->dev;
 	int entries, entries_old = 0, time;
@@ -2218,7 +2218,12 @@ static void wait_cmds_complete_timeout_v3_hw(struct hisi_hba *hisi_hba,
 		msleep(delay_ms);
 	}
 
+	if (time >= timeout_ms)
+		return -ETIMEDOUT;
+
 	dev_dbg(dev, "wait commands complete %dms\n", time);
+
+	return 0;
 }
 
 static ssize_t intr_conv_v3_hw_show(struct device *dev,
@@ -2335,11 +2340,36 @@ static ssize_t intr_coal_count_v3_hw_store(struct device *dev,
 };
 
 static const struct hisi_sas_debugfs_reg debugfs_port_reg = {
+	.base_off = PORT_BASE,
+	.read_port_reg = hisi_sas_phy_read32,
 };
 
 static const struct hisi_sas_debugfs_reg debugfs_global_reg = {
+	.read_global_reg = hisi_sas_read32,
 };
 
+static void debugfs_snapshot_prepare_v3_hw(struct hisi_hba *hisi_hba)
+{
+	struct device *dev = hisi_hba->dev;
+
+	set_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags);
+
+	hisi_sas_write32(hisi_hba, DLVRY_QUEUE_ENABLE, 0);
+
+	if (wait_cmds_complete_timeout_v3_hw(hisi_hba, 100, 5000) == -ETIMEDOUT)
+		dev_dbg(dev, "Wait commands complete timeout!\n");
+
+	hisi_sas_kill_tasklets(hisi_hba);
+}
+
+static void debugfs_snapshot_restore_v3_hw(struct hisi_hba *hisi_hba)
+{
+	hisi_sas_write32(hisi_hba, DLVRY_QUEUE_ENABLE,
+			 (u32)((1ULL << hisi_hba->queue_count) - 1));
+
+	clear_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags);
+}
+
 static struct scsi_host_template sht_v3_hw = {
 	.name			= DRV_NAME,
 	.module			= THIS_MODULE,
@@ -2390,6 +2420,8 @@ static ssize_t intr_coal_count_v3_hw_store(struct device *dev,
 	.wait_cmds_complete_timeout = wait_cmds_complete_timeout_v3_hw,
 	.debugfs_reg_global = &debugfs_global_reg,
 	.debugfs_reg_port = &debugfs_port_reg,
+	.snapshot_prepare = debugfs_snapshot_prepare_v3_hw,
+	.snapshot_restore = debugfs_snapshot_restore_v3_hw,
 };
 
 static struct Scsi_Host *
@@ -2407,6 +2439,7 @@ static ssize_t intr_coal_count_v3_hw_store(struct device *dev,
 	hisi_hba = shost_priv(shost);
 
 	INIT_WORK(&hisi_hba->rst_work, hisi_sas_rst_work_handler);
+	INIT_WORK(&hisi_hba->debugfs_work, hisi_sas_debugfs_work_handler);
 	hisi_hba->hw = &hisi_sas_v3_hw;
 	hisi_hba->pci_dev = pdev;
 	hisi_hba->dev = dev;
-- 
1.9.1

