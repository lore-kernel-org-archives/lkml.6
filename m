Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9C6C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A792520870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbfBAM56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 07:57:58 -0500
Received: from mgwym01.jp.fujitsu.com ([211.128.242.40]:44066 "EHLO
        mgwym01.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfBAM56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 07:57:58 -0500
X-Greylist: delayed 672 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Feb 2019 07:57:56 EST
Received: from yt-mxq.gw.nic.fujitsu.com (unknown [192.168.229.66]) by mgwym01.jp.fujitsu.com with smtp
         id 244b_dc0a_4018021c_3a36_4dec_a528_74ea1fe4e7f9;
        Fri, 01 Feb 2019 21:46:37 +0900
Received: from g01jpfmpwyt03.exch.g01.fujitsu.local (g01jpfmpwyt03.exch.g01.fujitsu.local [10.128.193.57])
        by yt-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id D422DAC01EA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Feb 2019 21:46:36 +0900 (JST)
Received: from G01JPEXCHYT16.g01.fujitsu.local (G01JPEXCHYT16.g01.fujitsu.local [10.128.194.55])
        by g01jpfmpwyt03.exch.g01.fujitsu.local (Postfix) with ESMTP id DD5F246E7E0;
        Fri,  1 Feb 2019 21:46:35 +0900 (JST)
Received: from localhost.localdomain (10.0.195.148) by
 G01JPEXCHYT16.g01.fujitsu.local (10.128.194.55) with Microsoft SMTP Server id
 14.3.408.0; Fri, 1 Feb 2019 21:46:34 +0900
X-SecurityPolicyCheck: OK by SHieldMailChecker v2.5.2
X-SHieldMailCheckerPolicyVersion: FJ-ISEC-20170217-enc
X-SHieldMailCheckerMailID: 893db2178fb94d4e8d29922d5d720cad
From:   Takao Indoh <indou.takao@jp.fujitsu.com>
To:     <keith.busch@intel.com>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>
CC:     <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Takao Indoh" <indou.takao@fujitsu.com>
Subject: [PATCH] nvme: Enable acceleration feature of A64FX processor
Date:   Fri, 1 Feb 2019 21:46:15 +0900
Message-ID: <20190201124615.16107-1-indou.takao@jp.fujitsu.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takao Indoh <indou.takao@fujitsu.com>

Fujitsu A64FX processor has a feature to accelerate data transfer of
internal bus by relaxed ordering. It is enabled when the bit 56 of dma
address is set to 1.

This patch introduces this acceleration feature to the NVMe driver to
enhance NVMe device performance.

Signed-off-by: Takao Indoh <indou.takao@fujitsu.com>
---
 drivers/nvme/host/core.c |  6 ++++
 drivers/nvme/host/nvme.h |  7 +++++
 drivers/nvme/host/pci.c  | 65 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 150e49723c15..8167c3756b05 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -37,6 +37,9 @@
 
 #define NVME_MINORS		(1U << MINORBITS)
 
+DEFINE_STATIC_KEY_FALSE(nvme_quirk_a64fx_force_relax_key);
+EXPORT_SYMBOL_GPL(nvme_quirk_a64fx_force_relax_key);
+
 unsigned int admin_timeout = 60;
 module_param(admin_timeout, uint, 0644);
 MODULE_PARM_DESC(admin_timeout, "timeout in seconds for admin commands");
@@ -2493,6 +2496,9 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		ctrl->quirks &= ~NVME_QUIRK_NO_DEEPEST_PS;
 	}
 
+	if (ctrl->quirks & NVME_QUIRK_A64FX_FORCE_RELAX)
+		static_branch_enable(&nvme_quirk_a64fx_force_relax_key);
+
 	ctrl->crdt[0] = le16_to_cpu(id->crdt1);
 	ctrl->crdt[1] = le16_to_cpu(id->crdt2);
 	ctrl->crdt[2] = le16_to_cpu(id->crdt3);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ab961bdeea89..fe02d021ee9c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -23,6 +23,7 @@
 #include <linux/sed-opal.h>
 #include <linux/fault-inject.h>
 #include <linux/rcupdate.h>
+#include <linux/jump_label.h>
 
 extern unsigned int nvme_io_timeout;
 #define NVME_IO_TIMEOUT	(nvme_io_timeout * HZ)
@@ -37,6 +38,8 @@ extern struct workqueue_struct *nvme_wq;
 extern struct workqueue_struct *nvme_reset_wq;
 extern struct workqueue_struct *nvme_delete_wq;
 
+DECLARE_STATIC_KEY_FALSE(nvme_quirk_a64fx_force_relax_key);
+
 enum {
 	NVME_NS_LBA		= 0,
 	NVME_NS_LIGHTNVM	= 1,
@@ -95,6 +98,10 @@ enum nvme_quirks {
 	 * Ignore device provided subnqn.
 	 */
 	NVME_QUIRK_IGNORE_DEV_SUBNQN		= (1 << 8),
+	/*
+	 * Force relaxed ordering for A64FX controller
+	 */
+	NVME_QUIRK_A64FX_FORCE_RELAX		= (1 << 9),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9bc585415d9b..cffe390d4c41 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -835,6 +835,45 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
 	return BLK_STS_OK;
 }
 
+static inline void nvme_pci_enable_a64fx_relax_bit(struct nvme_sgl_desc *sge)
+{
+	sge->addr |= (1ULL << 56);
+}
+
+/*
+ * A64FX's controller allow relaxed order by setting 1 on bit 56 of dma address
+ * for performance enhancement.
+ *
+ * This traverses the sgl list and set the bit on ever dma address for
+ * data read.
+ */
+static void nvme_pci_quirk_a64fx_force_relax(struct request *req,
+		struct nvme_rw_command *cmd, int entries)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct nvme_sgl_desc *sg_list;
+	int i, j;
+
+	/* do nothing if sgl is not used or command is not read */
+	if (!iod->use_sgl || cmd->opcode != nvme_cmd_read)
+		return;
+
+	if (entries == 1) {
+		nvme_pci_enable_a64fx_relax_bit(&cmd->dptr.sgl);
+		return;
+	}
+
+	i = 0; j = 0;
+	sg_list = nvme_pci_iod_list(req)[j];
+	do {
+		if (i == SGES_PER_PAGE) {
+			i = 0;
+			sg_list = nvme_pci_iod_list(req)[++j];
+		}
+		nvme_pci_enable_a64fx_relax_bit(&sg_list[i++]);
+	} while (--entries > 0);
+}
+
 static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		struct nvme_command *cmnd)
 {
@@ -869,6 +908,9 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	if (ret != BLK_STS_OK)
 		goto out_unmap;
 
+	if (static_branch_unlikely(&nvme_quirk_a64fx_force_relax_key))
+		nvme_pci_quirk_a64fx_force_relax(req, &cmnd->rw, nr_mapped);
+
 	ret = BLK_STS_IOERR;
 	if (blk_integrity_rq(req)) {
 		if (blk_rq_count_integrity_sg(q, req->bio) != 1)
@@ -2748,6 +2790,27 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 	return 0;
 }
 
+/*
+ * PCI vendor id of Fujitsu and device id for root port in the A64FX processor
+ */
+#define PCI_VENDOR_ID_FUJITSU			0x10cf
+#define PCI_DEVICE_ID_FUJITSU_A64FX_ROOTPORT	0x1952
+
+static unsigned long check_system_vendor_acceleration(void)
+{
+	struct pci_dev *pdev_root;
+	/*
+	 * When Fujitsu A64FX Root Port is found, acceleration feature
+	 * can be enabled.
+	 */
+	pdev_root = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
+	if (pdev_root && (pdev_root->vendor == PCI_VENDOR_ID_FUJITSU) &&
+	    (pdev_root->device == PCI_DEVICE_ID_FUJITSU_A64FX_ROOTPORT))
+		return NVME_QUIRK_A64FX_FORCE_RELAX;
+
+	return 0;
+}
+
 static void nvme_async_probe(void *data, async_cookie_t cookie)
 {
 	struct nvme_dev *dev = data;
@@ -2794,6 +2857,8 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	quirks |= check_vendor_combination_bug(pdev);
 
+	quirks |= check_system_vendor_acceleration();
+
 	/*
 	 * Double check that our mempool alloc size will cover the biggest
 	 * command we support.
-- 
2.20.1


