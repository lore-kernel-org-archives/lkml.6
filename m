Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907FCC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D842089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27D842089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933703AbeGIUQD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 16:16:03 -0400
Received: from labrats.qualcomm.com ([199.106.110.90]:6632 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933040AbeGIUOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 16:14:32 -0400
X-IronPort-AV: E=Sophos;i="5.51,330,1526367600"; 
   d="scan'208";a="39007200"
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by labrats.qualcomm.com with ESMTP; 09 Jul 2018 13:08:23 -0700
Received: from sdias-linux.qualcomm.com (HELO sdias-linux1.qualcomm.com) ([192.168.140.71])
  by ironmsg01-sd.qualcomm.com with ESMTP; 09 Jul 2018 13:08:22 -0700
Received: by sdias-linux1.qualcomm.com (Postfix, from userid 84243)
        id 67CB6150B; Mon,  9 Jul 2018 13:08:22 -0700 (PDT)
From:   Sujeev Dias <sdias@codeaurora.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Sujeev Dias <sdias@codeaurora.org>,
        Tony Truong <truong@codeaurora.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
Subject: [PATCH v2 2/7] mhi_bus: core: add power management support
Date:   Mon,  9 Jul 2018 13:08:09 -0700
Message-Id: <1531166894-30984-3-git-send-email-sdias@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531166894-30984-1-git-send-email-sdias@codeaurora.org>
References: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
 <1531166894-30984-1-git-send-email-sdias@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for MHI power management operations such as
power on, off, suspend, and resume.

Signed-off-by: Sujeev Dias <sdias@codeaurora.org>
Reviewed-by: Tony Truong <truong@codeaurora.org>
Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
---
 drivers/bus/mhi/core/Makefile       |    2 +-
 drivers/bus/mhi/core/mhi_boot.c     |  533 ++++++++++++++++++
 drivers/bus/mhi/core/mhi_init.c     |  695 +++++++++++++++++++++++-
 drivers/bus/mhi/core/mhi_internal.h |  491 +++++++++++++++++
 drivers/bus/mhi/core/mhi_main.c     |  528 +++++++++++++++++-
 drivers/bus/mhi/core/mhi_pm.c       | 1027 +++++++++++++++++++++++++++++++++++
 include/linux/mhi.h                 |  121 +++++
 7 files changed, 3394 insertions(+), 3 deletions(-)
 create mode 100644 drivers/bus/mhi/core/mhi_boot.c
 create mode 100644 drivers/bus/mhi/core/mhi_pm.c

diff --git a/drivers/bus/mhi/core/Makefile b/drivers/bus/mhi/core/Makefile
index a015809..a6015ab 100644
--- a/drivers/bus/mhi/core/Makefile
+++ b/drivers/bus/mhi/core/Makefile
@@ -1 +1 @@
-obj-$(CONFIG_MHI_BUS) +=mhi_init.o mhi_main.o
+obj-$(CONFIG_MHI_BUS) +=mhi_init.o mhi_main.o mhi_pm.o mhi_boot.o
diff --git a/drivers/bus/mhi/core/mhi_boot.c b/drivers/bus/mhi/core/mhi_boot.c
new file mode 100644
index 0000000..a8e4a15
--- /dev/null
+++ b/drivers/bus/mhi/core/mhi_boot.c
@@ -0,0 +1,533 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ *
+ */
+
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
+#include <linux/firmware.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/of.h>
+#include <linux/module.h>
+#include <linux/random.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
+#include <linux/mhi.h>
+#include "mhi_internal.h"
+
+
+/* setup rddm vector table for rddm transfer */
+static void mhi_rddm_prepare(struct mhi_controller *mhi_cntrl,
+			     struct image_info *img_info)
+{
+	struct mhi_buf *mhi_buf = img_info->mhi_buf;
+	struct bhi_vec_entry *bhi_vec = img_info->bhi_vec;
+	int i = 0;
+
+	for (i = 0; i < img_info->entries - 1; i++, mhi_buf++, bhi_vec++) {
+		bhi_vec->dma_addr = mhi_buf->dma_addr;
+		bhi_vec->size = mhi_buf->len;
+	}
+}
+
+/* collect rddm during kernel panic */
+static int __mhi_download_rddm_in_panic(struct mhi_controller *mhi_cntrl)
+{
+	int ret;
+	struct mhi_buf *mhi_buf;
+	u32 sequence_id;
+	u32 rx_status;
+	enum MHI_EE ee;
+	struct image_info *rddm_image = mhi_cntrl->rddm_image;
+	const u32 delayus = 100;
+	u32 retry = (mhi_cntrl->timeout_ms * 1000) / delayus;
+	void __iomem *base = mhi_cntrl->bhie;
+
+	dev_info(mhi_cntrl->dev,
+		 "Entered with pm_state:%s dev_state:%s ee:%s\n",
+		to_mhi_pm_state_str(mhi_cntrl->pm_state),
+		TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+		TO_MHI_EXEC_STR(mhi_cntrl->ee));
+
+	/*
+	 * This should only be executing during a kernel panic, we expect all
+	 * other cores to shutdown while we're collecting rddm buffer. After
+	 * returning from this function, we expect device to reset.
+	 *
+	 * Normaly, we would read/write pm_state only after grabbing
+	 * pm_lock, since we're in a panic, skipping it.
+	 */
+
+	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state))
+		return -EIO;
+
+	/*
+	 * There is no gurantee this state change would take effect since
+	 * we're setting it w/o grabbing pmlock, it's best effort
+	 */
+	mhi_cntrl->pm_state = MHI_PM_LD_ERR_FATAL_DETECT;
+	/* update should take the effect immediately */
+	smp_wmb();
+
+	/* setup the RX vector table */
+	mhi_rddm_prepare(mhi_cntrl, rddm_image);
+	mhi_buf = &rddm_image->mhi_buf[rddm_image->entries - 1];
+
+	mhi_write_reg(mhi_cntrl, base, BHIE_RXVECADDR_HIGH_OFFS,
+		      upper_32_bits(mhi_buf->dma_addr));
+
+	mhi_write_reg(mhi_cntrl, base, BHIE_RXVECADDR_LOW_OFFS,
+		      lower_32_bits(mhi_buf->dma_addr));
+
+	mhi_write_reg(mhi_cntrl, base, BHIE_RXVECSIZE_OFFS, mhi_buf->len);
+	sequence_id = prandom_u32() & BHIE_RXVECSTATUS_SEQNUM_BMSK;
+
+	if (unlikely(!sequence_id))
+		sequence_id = 1;
+
+
+	mhi_write_reg_field(mhi_cntrl, base, BHIE_RXVECDB_OFFS,
+			    BHIE_RXVECDB_SEQNUM_BMSK, BHIE_RXVECDB_SEQNUM_SHFT,
+			    sequence_id);
+
+	mhi_set_mhi_state(mhi_cntrl, MHI_STATE_SYS_ERR);
+
+	while (retry--) {
+		ret = mhi_read_reg_field(mhi_cntrl, base, BHIE_RXVECSTATUS_OFFS,
+					 BHIE_RXVECSTATUS_STATUS_BMSK,
+					 BHIE_RXVECSTATUS_STATUS_SHFT,
+					 &rx_status);
+		if (ret)
+			return -EIO;
+
+		if (rx_status == BHIE_RXVECSTATUS_STATUS_XFER_COMPL)
+			return 0;
+
+		udelay(delayus);
+	}
+
+	ee = mhi_get_exec_env(mhi_cntrl);
+	ret = mhi_read_reg(mhi_cntrl, base, BHIE_RXVECSTATUS_OFFS, &rx_status);
+
+	dev_err(mhi_cntrl->dev, "Did not complete RDDM transfer\n");
+	dev_err(mhi_cntrl->dev, "Current EE:%s\n", TO_MHI_EXEC_STR(ee));
+	dev_err(mhi_cntrl->dev, "RXVEC_STATUS:0x%x, ret:%d\n", rx_status, ret);
+
+	return -EIO;
+}
+
+/* download ramdump image from device */
+int mhi_download_rddm_img(struct mhi_controller *mhi_cntrl, bool in_panic)
+{
+	void __iomem *base = mhi_cntrl->bhie;
+	rwlock_t *pm_lock = &mhi_cntrl->pm_lock;
+	struct image_info *rddm_image = mhi_cntrl->rddm_image;
+	struct mhi_buf *mhi_buf;
+	int ret;
+	u32 rx_status;
+	u32 sequence_id;
+
+	if (!rddm_image)
+		return -ENOMEM;
+
+	if (in_panic)
+		return __mhi_download_rddm_in_panic(mhi_cntrl);
+
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+				 mhi_cntrl->ee == MHI_EE_RDDM ||
+				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
+				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		dev_err(mhi_cntrl->dev,
+			"MHI is not in valid state, pm_state:%s ee:%s\n",
+			to_mhi_pm_state_str(mhi_cntrl->pm_state),
+			TO_MHI_EXEC_STR(mhi_cntrl->ee));
+		return -EIO;
+	}
+
+	mhi_rddm_prepare(mhi_cntrl, mhi_cntrl->rddm_image);
+
+	/* vector table is the last entry */
+	mhi_buf = &rddm_image->mhi_buf[rddm_image->entries - 1];
+
+	read_lock_bh(pm_lock);
+	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
+		read_unlock_bh(pm_lock);
+		return -EIO;
+	}
+
+	mhi_write_reg(mhi_cntrl, base, BHIE_RXVECADDR_HIGH_OFFS,
+		      upper_32_bits(mhi_buf->dma_addr));
+
+	mhi_write_reg(mhi_cntrl, base, BHIE_RXVECADDR_LOW_OFFS,
+		      lower_32_bits(mhi_buf->dma_addr));
+
+	mhi_write_reg(mhi_cntrl, base, BHIE_RXVECSIZE_OFFS, mhi_buf->len);
+
+	sequence_id = prandom_u32() & BHIE_RXVECSTATUS_SEQNUM_BMSK;
+	mhi_write_reg_field(mhi_cntrl, base, BHIE_RXVECDB_OFFS,
+			    BHIE_RXVECDB_SEQNUM_BMSK, BHIE_RXVECDB_SEQNUM_SHFT,
+			    sequence_id);
+	read_unlock_bh(pm_lock);
+
+	/* waiting for image download completion */
+	wait_event_timeout(mhi_cntrl->state_event,
+			   MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state) ||
+			   mhi_read_reg_field(mhi_cntrl, base,
+					      BHIE_RXVECSTATUS_OFFS,
+					      BHIE_RXVECSTATUS_STATUS_BMSK,
+					      BHIE_RXVECSTATUS_STATUS_SHFT,
+					      &rx_status) || rx_status,
+			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))
+		return -EIO;
+
+	return (rx_status == BHIE_RXVECSTATUS_STATUS_XFER_COMPL) ? 0 : -EIO;
+}
+EXPORT_SYMBOL(mhi_download_rddm_img);
+
+static int mhi_fw_load_amss(struct mhi_controller *mhi_cntrl,
+			    const struct mhi_buf *mhi_buf)
+{
+	void __iomem *base = mhi_cntrl->bhie;
+	rwlock_t *pm_lock = &mhi_cntrl->pm_lock;
+	u32 tx_status;
+
+	read_lock_bh(pm_lock);
+	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
+		read_unlock_bh(pm_lock);
+		return -EIO;
+	}
+
+	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECADDR_HIGH_OFFS,
+		      upper_32_bits(mhi_buf->dma_addr));
+
+	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECADDR_LOW_OFFS,
+		      lower_32_bits(mhi_buf->dma_addr));
+
+	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECSIZE_OFFS, mhi_buf->len);
+
+	mhi_cntrl->sequence_id = prandom_u32() & BHIE_TXVECSTATUS_SEQNUM_BMSK;
+	mhi_write_reg_field(mhi_cntrl, base, BHIE_TXVECDB_OFFS,
+			    BHIE_TXVECDB_SEQNUM_BMSK, BHIE_TXVECDB_SEQNUM_SHFT,
+			    mhi_cntrl->sequence_id);
+	read_unlock_bh(pm_lock);
+
+	/* waiting for image download completion */
+	wait_event_timeout(mhi_cntrl->state_event,
+			   MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state) ||
+			   mhi_read_reg_field(mhi_cntrl, base,
+					      BHIE_TXVECSTATUS_OFFS,
+					      BHIE_TXVECSTATUS_STATUS_BMSK,
+					      BHIE_TXVECSTATUS_STATUS_SHFT,
+					      &tx_status) || tx_status,
+			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))
+		return -EIO;
+
+	return (tx_status == BHIE_TXVECSTATUS_STATUS_XFER_COMPL) ? 0 : -EIO;
+}
+
+static int mhi_fw_load_sbl(struct mhi_controller *mhi_cntrl,
+			   void *buf,
+			   size_t size)
+{
+	u32 tx_status, val;
+	int i, ret;
+	void __iomem *base = mhi_cntrl->bhi;
+	rwlock_t *pm_lock = &mhi_cntrl->pm_lock;
+	dma_addr_t dma_addr = dma_map_single(mhi_cntrl->dev, buf, size,
+					     DMA_TO_DEVICE);
+	struct {
+		char *name;
+		u32 offset;
+	} error_reg[] = {
+		{ "ERROR_CODE", BHI_ERRCODE },
+		{ "ERROR_DBG1", BHI_ERRDBG1 },
+		{ "ERROR_DBG2", BHI_ERRDBG2 },
+		{ "ERROR_DBG3", BHI_ERRDBG3 },
+		{ NULL },
+	};
+
+	if (dma_mapping_error(mhi_cntrl->dev, dma_addr))
+		return -ENOMEM;
+
+	/* program start sbl download via  bhi protocol */
+	read_lock_bh(pm_lock);
+	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
+		read_unlock_bh(pm_lock);
+		goto invalid_pm_state;
+	}
+
+	mhi_write_reg(mhi_cntrl, base, BHI_STATUS, 0);
+	mhi_write_reg(mhi_cntrl, base, BHI_IMGADDR_HIGH,
+		      upper_32_bits(dma_addr));
+	mhi_write_reg(mhi_cntrl, base, BHI_IMGADDR_LOW,
+		      lower_32_bits(dma_addr));
+	mhi_write_reg(mhi_cntrl, base, BHI_IMGSIZE, size);
+	mhi_cntrl->session_id = prandom_u32() & BHI_TXDB_SEQNUM_BMSK;
+	mhi_write_reg(mhi_cntrl, base, BHI_IMGTXDB, mhi_cntrl->session_id);
+	read_unlock_bh(pm_lock);
+
+	/* waiting for image download completion */
+	wait_event_timeout(mhi_cntrl->state_event,
+			   MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state) ||
+			   mhi_read_reg_field(mhi_cntrl, base, BHI_STATUS,
+					      BHI_STATUS_MASK, BHI_STATUS_SHIFT,
+					      &tx_status) || tx_status,
+			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))
+		goto invalid_pm_state;
+
+	if (tx_status == BHI_STATUS_ERROR) {
+		dev_err(mhi_cntrl->dev, "Image transfer failed\n");
+		read_lock_bh(pm_lock);
+		if (MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
+			for (i = 0; error_reg[i].name; i++) {
+				ret = mhi_read_reg(mhi_cntrl, base,
+						   error_reg[i].offset, &val);
+				if (ret)
+					break;
+				dev_err(mhi_cntrl->dev, "reg:%s value:0x%x\n",
+					error_reg[i].name, val);
+			}
+		}
+		read_unlock_bh(pm_lock);
+		goto invalid_pm_state;
+	}
+
+	dma_unmap_single(mhi_cntrl->dev, dma_addr, size, DMA_TO_DEVICE);
+
+	return (tx_status == BHI_STATUS_SUCCESS) ? 0 : -ETIMEDOUT;
+
+invalid_pm_state:
+	dma_unmap_single(mhi_cntrl->dev, dma_addr, size, DMA_TO_DEVICE);
+
+	return -EIO;
+}
+
+void mhi_free_bhie_table(struct mhi_controller *mhi_cntrl,
+			 struct image_info *image_info)
+{
+	int i;
+	struct mhi_buf *mhi_buf = image_info->mhi_buf;
+
+	for (i = 0; i < image_info->entries; i++, mhi_buf++)
+		mhi_free_coherent(mhi_cntrl, mhi_buf->len, mhi_buf->buf,
+				  mhi_buf->dma_addr);
+
+	kfree(image_info->mhi_buf);
+	kfree(image_info);
+}
+
+int mhi_alloc_bhie_table(struct mhi_controller *mhi_cntrl,
+			 struct image_info **image_info,
+			 size_t alloc_size)
+{
+	size_t seg_size = mhi_cntrl->seg_len;
+	/* requier additional entry for vec table */
+	int segments = DIV_ROUND_UP(alloc_size, seg_size) + 1;
+	int i;
+	struct image_info *img_info;
+	struct mhi_buf *mhi_buf;
+
+	img_info = kzalloc(sizeof(*img_info), GFP_KERNEL);
+	if (!img_info)
+		return -ENOMEM;
+
+	/* allocate memory for entries */
+	img_info->mhi_buf = kcalloc(segments, sizeof(*img_info->mhi_buf),
+				    GFP_KERNEL);
+	if (!img_info->mhi_buf)
+		goto error_alloc_mhi_buf;
+
+	/* allocate and populate vector table */
+	mhi_buf = img_info->mhi_buf;
+	for (i = 0; i < segments; i++, mhi_buf++) {
+		size_t vec_size = seg_size;
+
+		/* last entry is for vector table */
+		if (i == segments - 1)
+			vec_size = sizeof(struct bhi_vec_entry) * i;
+
+		mhi_buf->len = vec_size;
+		mhi_buf->buf = mhi_alloc_coherent(mhi_cntrl, vec_size,
+					&mhi_buf->dma_addr, GFP_KERNEL);
+		if (!mhi_buf->buf)
+			goto error_alloc_segment;
+	}
+
+	img_info->bhi_vec = img_info->mhi_buf[segments - 1].buf;
+	img_info->entries = segments;
+	*image_info = img_info;
+
+	return 0;
+
+error_alloc_segment:
+	for (--i, --mhi_buf; i >= 0; i--, mhi_buf--)
+		mhi_free_coherent(mhi_cntrl, mhi_buf->len, mhi_buf->buf,
+				  mhi_buf->dma_addr);
+
+error_alloc_mhi_buf:
+	kfree(img_info);
+
+	return -ENOMEM;
+}
+
+static void mhi_firmware_copy(struct mhi_controller *mhi_cntrl,
+			      const struct firmware *firmware,
+			      struct image_info *img_info)
+{
+	size_t remainder = firmware->size;
+	size_t to_cpy;
+	const u8 *buf = firmware->data;
+	int i = 0;
+	struct mhi_buf *mhi_buf = img_info->mhi_buf;
+	struct bhi_vec_entry *bhi_vec = img_info->bhi_vec;
+
+	while (remainder) {
+		to_cpy = min(remainder, mhi_buf->len);
+		memcpy(mhi_buf->buf, buf, to_cpy);
+		bhi_vec->dma_addr = mhi_buf->dma_addr;
+		bhi_vec->size = to_cpy;
+
+		buf += to_cpy;
+		remainder -= to_cpy;
+		i++;
+		bhi_vec++;
+		mhi_buf++;
+	}
+}
+
+void mhi_fw_load_worker(struct work_struct *work)
+{
+	int ret;
+	struct mhi_controller *mhi_cntrl;
+	const char *fw_name;
+	const struct firmware *firmware;
+	struct image_info *image_info;
+	void *buf;
+	size_t size;
+
+	mhi_cntrl = container_of(work, struct mhi_controller, fw_worker);
+
+	dev_info(mhi_cntrl->dev, "Waiting for device to enter PBL from EE:%s\n",
+		TO_MHI_EXEC_STR(mhi_cntrl->ee));
+
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+				 MHI_IN_PBL(mhi_cntrl->ee) ||
+				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
+				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		dev_err(mhi_cntrl->dev, "MHI is not in valid state\n");
+		return;
+	}
+
+	/* if device in pthru, we do not have to load firmware */
+	if (mhi_cntrl->ee == MHI_EE_PTHRU)
+		return;
+
+	fw_name = (mhi_cntrl->ee == MHI_EE_EDL) ?
+		mhi_cntrl->edl_image : mhi_cntrl->fw_image;
+
+	if (!fw_name || (mhi_cntrl->fbc_download && (!mhi_cntrl->sbl_size ||
+						     !mhi_cntrl->seg_len))) {
+		dev_err(mhi_cntrl->dev,
+			"No firmware image defined or !sbl_size || !seg_len\n");
+		return;
+	}
+
+	ret = request_firmware(&firmware, fw_name, mhi_cntrl->dev);
+	if (ret) {
+		dev_err(mhi_cntrl->dev, "Error loading firmware, ret:%d\n",
+			ret);
+		return;
+	}
+
+	size = (mhi_cntrl->fbc_download) ? mhi_cntrl->sbl_size : firmware->size;
+
+	/* the sbl size provided is maximum size, not necessarily image size */
+	if (size > firmware->size)
+		size = firmware->size;
+
+	buf = kmemdup(firmware->data, size, GFP_KERNEL);
+	if (!buf) {
+		release_firmware(firmware);
+		return;
+	}
+
+	/* load sbl image */
+	ret = mhi_fw_load_sbl(mhi_cntrl, buf, size);
+	kfree(buf);
+
+	if (!mhi_cntrl->fbc_download || ret || mhi_cntrl->ee == MHI_EE_EDL)
+		release_firmware(firmware);
+
+	/* error or in edl, we're done */
+	if (ret || mhi_cntrl->ee == MHI_EE_EDL)
+		return;
+
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	mhi_cntrl->dev_state = MHI_STATE_RESET;
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+
+	/*
+	 * if we're doing fbc, populate vector tables while
+	 * device transitioning into MHI READY state
+	 */
+	if (mhi_cntrl->fbc_download) {
+		ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->fbc_image,
+					   firmware->size);
+		if (ret)
+			goto error_alloc_fw_table;
+
+		/* load the firmware into BHIE vec table */
+		mhi_firmware_copy(mhi_cntrl, firmware, mhi_cntrl->fbc_image);
+	}
+
+	/* transitioning into MHI RESET->READY state */
+	ret = mhi_ready_state_transition(mhi_cntrl);
+
+	if (!mhi_cntrl->fbc_download)
+		return;
+
+	if (ret)
+		goto error_read;
+
+	/* wait for BHIE event */
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+				 mhi_cntrl->ee == MHI_EE_BHIE ||
+				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
+				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		dev_err(mhi_cntrl->dev, "MHI did not enter BHIE\n");
+		goto error_read;
+	}
+
+	/* start full firmware image download */
+	image_info = mhi_cntrl->fbc_image;
+	ret = mhi_fw_load_amss(mhi_cntrl,
+			       /* last entry is vec table */
+			       &image_info->mhi_buf[image_info->entries - 1]);
+
+	release_firmware(firmware);
+
+	return;
+
+error_read:
+	mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->fbc_image);
+	mhi_cntrl->fbc_image = NULL;
+
+error_alloc_fw_table:
+	release_firmware(firmware);
+}
diff --git a/drivers/bus/mhi/core/mhi_init.c b/drivers/bus/mhi/core/mhi_init.c
index b8c30f8..7b3d12a 100644
--- a/drivers/bus/mhi/core/mhi_init.c
+++ b/drivers/bus/mhi/core/mhi_init.c
@@ -17,6 +17,537 @@
 #include <linux/mhi.h>
 #include "mhi_internal.h"
 
+const char * const mhi_ee_str[MHI_EE_MAX] = {
+	[MHI_EE_PBL] = "PBL",
+	[MHI_EE_SBL] = "SBL",
+	[MHI_EE_AMSS] = "AMSS",
+	[MHI_EE_BHIE] = "BHIE",
+	[MHI_EE_RDDM] = "RDDM",
+	[MHI_EE_PTHRU] = "PASS THRU",
+	[MHI_EE_EDL] = "EDL",
+	[MHI_EE_DISABLE_TRANSITION] = "DISABLE",
+};
+
+const char * const mhi_state_tran_str[MHI_ST_TRANSITION_MAX] = {
+	[MHI_ST_TRANSITION_PBL] = "PBL",
+	[MHI_ST_TRANSITION_READY] = "READY",
+	[MHI_ST_TRANSITION_SBL] = "SBL",
+	[MHI_ST_TRANSITION_AMSS] = "AMSS",
+	[MHI_ST_TRANSITION_BHIE] = "BHIE",
+};
+
+const char * const mhi_state_str[MHI_STATE_MAX] = {
+	[MHI_STATE_RESET] = "RESET",
+	[MHI_STATE_READY] = "READY",
+	[MHI_STATE_M0] = "M0",
+	[MHI_STATE_M1] = "M1",
+	[MHI_STATE_M2] = "M2",
+	[MHI_STATE_M3] = "M3",
+	[MHI_STATE_BHI] = "BHI",
+	[MHI_STATE_SYS_ERR] = "SYS_ERR",
+};
+
+static const char * const mhi_pm_state_str[] = {
+	[MHI_PM_BIT_DISABLE] = "DISABLE",
+	[MHI_PM_BIT_POR] = "POR",
+	[MHI_PM_BIT_M0] = "M0",
+	[MHI_PM_BIT_M2] = "M2",
+	[MHI_PM_BIT_M3_ENTER] = "M?->M3",
+	[MHI_PM_BIT_M3] = "M3",
+	[MHI_PM_BIT_M3_EXIT] = "M3->M0",
+	[MHI_PM_BIT_FW_DL_ERR] = "FW DL Error",
+	[MHI_PM_BIT_SYS_ERR_DETECT] = "SYS_ERR Detect",
+	[MHI_PM_BIT_SYS_ERR_PROCESS] = "SYS_ERR Process",
+	[MHI_PM_BIT_SHUTDOWN_PROCESS] = "SHUTDOWN Process",
+	[MHI_PM_BIT_LD_ERR_FATAL_DETECT] = "LD or Error Fatal Detect",
+};
+
+const char *to_mhi_pm_state_str(enum MHI_PM_STATE state)
+{
+	int index = find_last_bit((unsigned long *)&state, 32);
+
+	if (index >= ARRAY_SIZE(mhi_pm_state_str))
+		return "Invalid State";
+
+	return mhi_pm_state_str[index];
+}
+
+/* MHI protocol require transfer ring to be aligned to ring length */
+static int mhi_alloc_aligned_ring(struct mhi_controller *mhi_cntrl,
+				  struct mhi_ring *ring,
+				  u64 len)
+{
+	ring->alloc_size = len + (len - 1);
+	ring->pre_aligned = mhi_alloc_coherent(mhi_cntrl, ring->alloc_size,
+					       &ring->dma_handle, GFP_KERNEL);
+	if (!ring->pre_aligned)
+		return -ENOMEM;
+
+	ring->iommu_base = (ring->dma_handle + (len - 1)) & ~(len - 1);
+	ring->base = ring->pre_aligned + (ring->iommu_base - ring->dma_handle);
+
+	return 0;
+}
+
+void mhi_deinit_free_irq(struct mhi_controller *mhi_cntrl)
+{
+	int i;
+	struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
+
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		if (mhi_event->offload_ev)
+			continue;
+
+		free_irq(mhi_cntrl->irq[mhi_event->msi], mhi_event);
+	}
+
+	free_irq(mhi_cntrl->irq[0], mhi_cntrl);
+}
+
+int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
+{
+	int i;
+	int ret;
+	struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
+
+	/* for BHI INTVEC msi */
+	ret = request_threaded_irq(mhi_cntrl->irq[0], mhi_intvec_handlr,
+				   mhi_intvec_threaded_handlr, IRQF_ONESHOT,
+				   "mhi", mhi_cntrl);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		if (mhi_event->offload_ev)
+			continue;
+
+		ret = request_irq(mhi_cntrl->irq[mhi_event->msi],
+				  mhi_msi_handlr, IRQF_SHARED, "mhi",
+				  mhi_event);
+		if (ret) {
+			dev_err(mhi_cntrl->dev,
+				"Error requesting irq:%d for ev:%d\n",
+				mhi_cntrl->irq[mhi_event->msi], i);
+			goto error_request;
+		}
+	}
+
+	return 0;
+
+error_request:
+	for (--i, --mhi_event; i >= 0; i--, mhi_event--) {
+		if (mhi_event->offload_ev)
+			continue;
+
+		free_irq(mhi_cntrl->irq[mhi_event->msi], mhi_event);
+	}
+	free_irq(mhi_cntrl->irq[0], mhi_cntrl);
+
+	return ret;
+}
+
+void mhi_deinit_dev_ctxt(struct mhi_controller *mhi_cntrl)
+{
+	int i;
+	struct mhi_ctxt *mhi_ctxt = mhi_cntrl->mhi_ctxt;
+	struct mhi_cmd *mhi_cmd;
+	struct mhi_event *mhi_event;
+	struct mhi_ring *ring;
+
+	mhi_cmd = mhi_cntrl->mhi_cmd;
+	for (i = 0; i < NR_OF_CMD_RINGS; i++, mhi_cmd++) {
+		ring = &mhi_cmd->ring;
+		mhi_free_coherent(mhi_cntrl, ring->alloc_size,
+				  ring->pre_aligned, ring->dma_handle);
+		ring->base = NULL;
+		ring->iommu_base = 0;
+	}
+
+	mhi_free_coherent(mhi_cntrl,
+			  sizeof(*mhi_ctxt->cmd_ctxt) * NR_OF_CMD_RINGS,
+			  mhi_ctxt->cmd_ctxt, mhi_ctxt->cmd_ctxt_addr);
+
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		if (mhi_event->offload_ev)
+			continue;
+
+		ring = &mhi_event->ring;
+		mhi_free_coherent(mhi_cntrl, ring->alloc_size,
+				  ring->pre_aligned, ring->dma_handle);
+		ring->base = NULL;
+		ring->iommu_base = 0;
+	}
+
+	mhi_free_coherent(mhi_cntrl, sizeof(*mhi_ctxt->er_ctxt) *
+			  mhi_cntrl->total_ev_rings, mhi_ctxt->er_ctxt,
+			  mhi_ctxt->er_ctxt_addr);
+
+	mhi_free_coherent(mhi_cntrl, sizeof(*mhi_ctxt->chan_ctxt) *
+			  mhi_cntrl->max_chan, mhi_ctxt->chan_ctxt,
+			  mhi_ctxt->chan_ctxt_addr);
+
+	kfree(mhi_ctxt);
+	mhi_cntrl->mhi_ctxt = NULL;
+}
+
+void mhi_init_debugfs(struct mhi_controller *mhi_cntrl)
+{
+	struct dentry *dentry;
+	char node[32];
+
+	if (!mhi_cntrl->parent)
+		return;
+
+	snprintf(node, sizeof(node), "%04x_%02u:%02u.%02u",
+		 mhi_cntrl->dev_id, mhi_cntrl->domain, mhi_cntrl->bus,
+		 mhi_cntrl->slot);
+
+	dentry = debugfs_create_dir(node, mhi_cntrl->parent);
+	if (IS_ERR(dentry))
+		return;
+
+	mhi_cntrl->dentry = dentry;
+}
+
+void mhi_deinit_debugfs(struct mhi_controller *mhi_cntrl)
+{
+	debugfs_remove_recursive(mhi_cntrl->dentry);
+	mhi_cntrl->dentry = NULL;
+}
+
+int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl)
+{
+	struct mhi_ctxt *mhi_ctxt;
+	struct mhi_chan_ctxt *chan_ctxt;
+	struct mhi_event_ctxt *er_ctxt;
+	struct mhi_cmd_ctxt *cmd_ctxt;
+	struct mhi_chan *mhi_chan;
+	struct mhi_event *mhi_event;
+	struct mhi_cmd *mhi_cmd;
+	int ret = -ENOMEM, i;
+
+	atomic_set(&mhi_cntrl->dev_wake, 0);
+	atomic_set(&mhi_cntrl->alloc_size, 0);
+
+	mhi_ctxt = kzalloc(sizeof(*mhi_ctxt), GFP_KERNEL);
+	if (!mhi_ctxt)
+		return -ENOMEM;
+
+	/* setup channel ctxt */
+	mhi_ctxt->chan_ctxt = mhi_alloc_coherent(mhi_cntrl,
+			sizeof(*mhi_ctxt->chan_ctxt) * mhi_cntrl->max_chan,
+			&mhi_ctxt->chan_ctxt_addr, GFP_KERNEL);
+	if (!mhi_ctxt->chan_ctxt)
+		goto error_alloc_chan_ctxt;
+
+	mhi_chan = mhi_cntrl->mhi_chan;
+	chan_ctxt = mhi_ctxt->chan_ctxt;
+	for (i = 0; i < mhi_cntrl->max_chan; i++, chan_ctxt++, mhi_chan++) {
+		/* If it's offload channel skip this step */
+		if (mhi_chan->offload_ch)
+			continue;
+
+		chan_ctxt->chstate = MHI_CH_STATE_DISABLED;
+		chan_ctxt->brstmode = mhi_chan->db_cfg.brstmode;
+		chan_ctxt->pollcfg = mhi_chan->db_cfg.pollcfg;
+		chan_ctxt->chtype = mhi_chan->dir;
+		chan_ctxt->erindex = mhi_chan->er_index;
+
+		mhi_chan->ch_state = MHI_CH_STATE_DISABLED;
+		mhi_chan->tre_ring.db_addr = &chan_ctxt->wp;
+	}
+
+	/* setup event context */
+	mhi_ctxt->er_ctxt = mhi_alloc_coherent(mhi_cntrl,
+			sizeof(*mhi_ctxt->er_ctxt) * mhi_cntrl->total_ev_rings,
+			&mhi_ctxt->er_ctxt_addr, GFP_KERNEL);
+	if (!mhi_ctxt->er_ctxt)
+		goto error_alloc_er_ctxt;
+
+	er_ctxt = mhi_ctxt->er_ctxt;
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, er_ctxt++,
+		     mhi_event++) {
+		struct mhi_ring *ring = &mhi_event->ring;
+
+		/* it's a satellite ev, we do not touch it */
+		if (mhi_event->offload_ev)
+			continue;
+
+		er_ctxt->intmodc = 0;
+		er_ctxt->intmodt = mhi_event->intmod;
+		er_ctxt->ertype = MHI_ER_TYPE_VALID;
+		er_ctxt->msivec = mhi_event->msi;
+		mhi_event->db_cfg.db_mode = true;
+
+		ring->el_size = sizeof(struct mhi_tre);
+		ring->len = ring->el_size * ring->elements;
+		ret = mhi_alloc_aligned_ring(mhi_cntrl, ring, ring->len);
+		if (ret)
+			goto error_alloc_er;
+
+		ring->rp = ring->wp = ring->base;
+		er_ctxt->rbase = ring->iommu_base;
+		er_ctxt->rp = er_ctxt->wp = er_ctxt->rbase;
+		er_ctxt->rlen = ring->len;
+		ring->ctxt_wp = &er_ctxt->wp;
+	}
+
+	/* setup cmd context */
+	mhi_ctxt->cmd_ctxt = mhi_alloc_coherent(mhi_cntrl,
+				sizeof(*mhi_ctxt->cmd_ctxt) * NR_OF_CMD_RINGS,
+				&mhi_ctxt->cmd_ctxt_addr, GFP_KERNEL);
+	if (!mhi_ctxt->cmd_ctxt)
+		goto error_alloc_er;
+
+	mhi_cmd = mhi_cntrl->mhi_cmd;
+	cmd_ctxt = mhi_ctxt->cmd_ctxt;
+	for (i = 0; i < NR_OF_CMD_RINGS; i++, mhi_cmd++, cmd_ctxt++) {
+		struct mhi_ring *ring = &mhi_cmd->ring;
+
+		ring->el_size = sizeof(struct mhi_tre);
+		ring->elements = CMD_EL_PER_RING;
+		ring->len = ring->el_size * ring->elements;
+		ret = mhi_alloc_aligned_ring(mhi_cntrl, ring, ring->len);
+		if (ret)
+			goto error_alloc_cmd;
+
+		ring->rp = ring->wp = ring->base;
+		cmd_ctxt->rbase = ring->iommu_base;
+		cmd_ctxt->rp = cmd_ctxt->wp = cmd_ctxt->rbase;
+		cmd_ctxt->rlen = ring->len;
+		ring->ctxt_wp = &cmd_ctxt->wp;
+	}
+
+	mhi_cntrl->mhi_ctxt = mhi_ctxt;
+
+	return 0;
+
+error_alloc_cmd:
+	for (--i, --mhi_cmd; i >= 0; i--, mhi_cmd--) {
+		struct mhi_ring *ring = &mhi_cmd->ring;
+
+		mhi_free_coherent(mhi_cntrl, ring->alloc_size,
+				  ring->pre_aligned, ring->dma_handle);
+	}
+	mhi_free_coherent(mhi_cntrl,
+			  sizeof(*mhi_ctxt->cmd_ctxt) * NR_OF_CMD_RINGS,
+			  mhi_ctxt->cmd_ctxt, mhi_ctxt->cmd_ctxt_addr);
+	i = mhi_cntrl->total_ev_rings;
+	mhi_event = mhi_cntrl->mhi_event + i;
+
+error_alloc_er:
+	for (--i, --mhi_event; i >= 0; i--, mhi_event--) {
+		struct mhi_ring *ring = &mhi_event->ring;
+
+		if (mhi_event->offload_ev)
+			continue;
+
+		mhi_free_coherent(mhi_cntrl, ring->alloc_size,
+				  ring->pre_aligned, ring->dma_handle);
+	}
+	mhi_free_coherent(mhi_cntrl, sizeof(*mhi_ctxt->er_ctxt) *
+			  mhi_cntrl->total_ev_rings, mhi_ctxt->er_ctxt,
+			  mhi_ctxt->er_ctxt_addr);
+
+error_alloc_er_ctxt:
+	mhi_free_coherent(mhi_cntrl, sizeof(*mhi_ctxt->chan_ctxt) *
+			  mhi_cntrl->max_chan, mhi_ctxt->chan_ctxt,
+			  mhi_ctxt->chan_ctxt_addr);
+
+error_alloc_chan_ctxt:
+	kfree(mhi_ctxt);
+
+	return ret;
+}
+
+int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
+{
+	u32 val;
+	int i, ret;
+	struct mhi_chan *mhi_chan;
+	struct mhi_event *mhi_event;
+	void __iomem *base = mhi_cntrl->regs;
+	struct {
+		u32 offset;
+		u32 mask;
+		u32 shift;
+		u32 val;
+	} reg_info[] = {
+		{
+			CCABAP_HIGHER, U32_MAX, 0,
+			upper_32_bits(mhi_cntrl->mhi_ctxt->chan_ctxt_addr),
+		},
+		{
+			CCABAP_LOWER, U32_MAX, 0,
+			lower_32_bits(mhi_cntrl->mhi_ctxt->chan_ctxt_addr),
+		},
+		{
+			ECABAP_HIGHER, U32_MAX, 0,
+			upper_32_bits(mhi_cntrl->mhi_ctxt->er_ctxt_addr),
+		},
+		{
+			ECABAP_LOWER, U32_MAX, 0,
+			lower_32_bits(mhi_cntrl->mhi_ctxt->er_ctxt_addr),
+		},
+		{
+			CRCBAP_HIGHER, U32_MAX, 0,
+			upper_32_bits(mhi_cntrl->mhi_ctxt->cmd_ctxt_addr),
+		},
+		{
+			CRCBAP_LOWER, U32_MAX, 0,
+			lower_32_bits(mhi_cntrl->mhi_ctxt->cmd_ctxt_addr),
+		},
+		{
+			MHICFG, MHICFG_NER_MASK, MHICFG_NER_SHIFT,
+			mhi_cntrl->total_ev_rings,
+		},
+		{
+			MHICFG, MHICFG_NHWER_MASK, MHICFG_NHWER_SHIFT,
+			mhi_cntrl->hw_ev_rings,
+		},
+		{
+			MHICTRLBASE_HIGHER, U32_MAX, 0,
+			upper_32_bits(mhi_cntrl->iova_start),
+		},
+		{
+			MHICTRLBASE_LOWER, U32_MAX, 0,
+			lower_32_bits(mhi_cntrl->iova_start),
+		},
+		{
+			MHIDATABASE_HIGHER, U32_MAX, 0,
+			upper_32_bits(mhi_cntrl->iova_start),
+		},
+		{
+			MHIDATABASE_LOWER, U32_MAX, 0,
+			lower_32_bits(mhi_cntrl->iova_start),
+		},
+		{
+			MHICTRLLIMIT_HIGHER, U32_MAX, 0,
+			upper_32_bits(mhi_cntrl->iova_stop),
+		},
+		{
+			MHICTRLLIMIT_LOWER, U32_MAX, 0,
+			lower_32_bits(mhi_cntrl->iova_stop),
+		},
+		{
+			MHIDATALIMIT_HIGHER, U32_MAX, 0,
+			upper_32_bits(mhi_cntrl->iova_stop),
+		},
+		{
+			MHIDATALIMIT_LOWER, U32_MAX, 0,
+			lower_32_bits(mhi_cntrl->iova_stop),
+		},
+		{ 0, 0, 0 }
+	};
+
+	dev_info(mhi_cntrl->dev, "Initializing MHI registers\n");
+
+	/* set up DB register for all the chan rings */
+	ret = mhi_read_reg_field(mhi_cntrl, base, CHDBOFF, CHDBOFF_CHDBOFF_MASK,
+				 CHDBOFF_CHDBOFF_SHIFT, &val);
+	if (ret)
+		return -EIO;
+
+	/* setup wake db */
+	mhi_cntrl->wake_db = base + val + (8 * MHI_DEV_WAKE_DB);
+	mhi_write_reg(mhi_cntrl, mhi_cntrl->wake_db, 4, 0);
+	mhi_write_reg(mhi_cntrl, mhi_cntrl->wake_db, 0, 0);
+	mhi_cntrl->wake_set = false;
+
+	/* setup channel db addresses */
+	mhi_chan = mhi_cntrl->mhi_chan;
+	for (i = 0; i < mhi_cntrl->max_chan; i++, val += 8, mhi_chan++)
+		mhi_chan->tre_ring.db_addr = base + val;
+
+	/* setup event ring db addresses */
+	ret = mhi_read_reg_field(mhi_cntrl, base, ERDBOFF, ERDBOFF_ERDBOFF_MASK,
+				 ERDBOFF_ERDBOFF_SHIFT, &val);
+	if (ret)
+		return -EIO;
+
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, val += 8, mhi_event++) {
+		if (mhi_event->offload_ev)
+			continue;
+
+		mhi_event->ring.db_addr = base + val;
+	}
+
+	/* set up DB register for primary CMD rings */
+	mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING].ring.db_addr = base + CRDB_LOWER;
+
+	for (i = 0; reg_info[i].offset; i++)
+		mhi_write_reg_field(mhi_cntrl, base, reg_info[i].offset,
+				    reg_info[i].mask, reg_info[i].shift,
+				    reg_info[i].val);
+
+	return 0;
+}
+
+void mhi_deinit_chan_ctxt(struct mhi_controller *mhi_cntrl,
+			  struct mhi_chan *mhi_chan)
+{
+	struct mhi_ring *buf_ring;
+	struct mhi_ring *tre_ring;
+	struct mhi_chan_ctxt *chan_ctxt;
+
+	buf_ring = &mhi_chan->buf_ring;
+	tre_ring = &mhi_chan->tre_ring;
+	chan_ctxt = &mhi_cntrl->mhi_ctxt->chan_ctxt[mhi_chan->chan];
+
+	mhi_free_coherent(mhi_cntrl, tre_ring->alloc_size,
+			  tre_ring->pre_aligned, tre_ring->dma_handle);
+	kfree(buf_ring->base);
+
+	buf_ring->base = tre_ring->base = NULL;
+	chan_ctxt->rbase = 0;
+}
+
+int mhi_init_chan_ctxt(struct mhi_controller *mhi_cntrl,
+		       struct mhi_chan *mhi_chan)
+{
+	struct mhi_ring *buf_ring;
+	struct mhi_ring *tre_ring;
+	struct mhi_chan_ctxt *chan_ctxt;
+	int ret;
+
+	buf_ring = &mhi_chan->buf_ring;
+	tre_ring = &mhi_chan->tre_ring;
+	tre_ring->el_size = sizeof(struct mhi_tre);
+	tre_ring->len = tre_ring->el_size * tre_ring->elements;
+	chan_ctxt = &mhi_cntrl->mhi_ctxt->chan_ctxt[mhi_chan->chan];
+	ret = mhi_alloc_aligned_ring(mhi_cntrl, tre_ring, tre_ring->len);
+	if (ret)
+		return -ENOMEM;
+
+	buf_ring->el_size = sizeof(struct mhi_buf_info);
+	buf_ring->len = buf_ring->el_size * buf_ring->elements;
+	buf_ring->base = kzalloc(buf_ring->len, GFP_KERNEL);
+
+	if (!buf_ring->base) {
+		mhi_free_coherent(mhi_cntrl, tre_ring->alloc_size,
+				  tre_ring->pre_aligned, tre_ring->dma_handle);
+		return -ENOMEM;
+	}
+
+	chan_ctxt->chstate = MHI_CH_STATE_ENABLED;
+	chan_ctxt->rbase = tre_ring->iommu_base;
+	chan_ctxt->rp = chan_ctxt->wp = chan_ctxt->rbase;
+	chan_ctxt->rlen = tre_ring->len;
+	tre_ring->ctxt_wp = &chan_ctxt->wp;
+
+	tre_ring->rp = tre_ring->wp = tre_ring->base;
+	buf_ring->rp = buf_ring->wp = buf_ring->base;
+	mhi_chan->db_cfg.db_mode = 1;
+
+	/* update to all cores */
+	smp_wmb();
+
+	return 0;
+}
+
 static int of_parse_ev_cfg(struct mhi_controller *mhi_cntrl,
 			   struct device_node *of_node)
 {
@@ -331,6 +862,9 @@ int of_register_mhi_controller(struct mhi_controller *mhi_cntrl)
 	rwlock_init(&mhi_cntrl->pm_lock);
 	spin_lock_init(&mhi_cntrl->transition_lock);
 	spin_lock_init(&mhi_cntrl->wlock);
+	INIT_WORK(&mhi_cntrl->st_worker, mhi_pm_st_worker);
+	INIT_WORK(&mhi_cntrl->fw_worker, mhi_fw_load_worker);
+	INIT_WORK(&mhi_cntrl->syserr_worker, mhi_pm_sys_err_worker);
 	init_waitqueue_head(&mhi_cntrl->state_event);
 
 	mhi_cmd = mhi_cntrl->mhi_cmd;
@@ -436,6 +970,61 @@ struct mhi_controller *mhi_alloc_controller(size_t size)
 }
 EXPORT_SYMBOL(mhi_alloc_controller);
 
+int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
+{
+	int ret;
+
+	mutex_lock(&mhi_cntrl->pm_mutex);
+
+	ret = mhi_init_dev_ctxt(mhi_cntrl);
+	if (ret)
+		goto error_dev_ctxt;
+
+	ret = mhi_init_irq_setup(mhi_cntrl);
+	if (ret)
+		goto error_setup_irq;
+
+	/*
+	 * allocate rddm table if specified, this table is for debug purpose
+	 * so we'll ignore erros
+	 */
+	if (mhi_cntrl->rddm_size)
+		mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->rddm_image,
+				     mhi_cntrl->rddm_size);
+
+	mhi_cntrl->pre_init = true;
+
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+
+	return 0;
+
+error_setup_irq:
+	mhi_deinit_dev_ctxt(mhi_cntrl);
+
+error_dev_ctxt:
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL(mhi_prepare_for_power_up);
+
+void mhi_unprepare_after_power_down(struct mhi_controller *mhi_cntrl)
+{
+	if (mhi_cntrl->fbc_image) {
+		mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->fbc_image);
+		mhi_cntrl->fbc_image = NULL;
+	}
+
+	if (mhi_cntrl->rddm_image) {
+		mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->rddm_image);
+		mhi_cntrl->rddm_image = NULL;
+	}
+
+	mhi_deinit_free_irq(mhi_cntrl);
+	mhi_deinit_dev_ctxt(mhi_cntrl);
+	mhi_cntrl->pre_init = false;
+}
+
 /* match dev to drv */
 static int mhi_match(struct device *dev, struct device_driver *drv)
 {
@@ -471,11 +1060,115 @@ struct bus_type mhi_bus_type = {
 
 static int mhi_driver_probe(struct device *dev)
 {
-	return -EINVAL;
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct device_driver *drv = dev->driver;
+	struct mhi_driver *mhi_drv = to_mhi_driver(drv);
+	struct mhi_event *mhi_event;
+	struct mhi_chan *ul_chan = mhi_dev->ul_chan;
+	struct mhi_chan *dl_chan = mhi_dev->dl_chan;
+
+	if (ul_chan) {
+		/* lpm notification require status_cb */
+		if (ul_chan->lpm_notify && !mhi_drv->status_cb)
+			return -EINVAL;
+
+		if (!ul_chan->offload_ch && !mhi_drv->ul_xfer_cb)
+			return -EINVAL;
+
+		ul_chan->xfer_cb = mhi_drv->ul_xfer_cb;
+		mhi_dev->status_cb = mhi_drv->status_cb;
+	}
+
+	if (dl_chan) {
+		if (dl_chan->lpm_notify && !mhi_drv->status_cb)
+			return -EINVAL;
+
+		if (!dl_chan->offload_ch && !mhi_drv->dl_xfer_cb)
+			return -EINVAL;
+
+		mhi_event = &mhi_cntrl->mhi_event[dl_chan->er_index];
+
+		/*
+		 * if this channal event ring manage by client, then
+		 * status_cb must be defined so we can send the async
+		 * cb whenever there are pending data
+		 */
+		if (mhi_event->cl_manage && !mhi_drv->status_cb)
+			return -EINVAL;
+
+		dl_chan->xfer_cb = mhi_drv->dl_xfer_cb;
+
+		/* ul & dl uses same status cb */
+		mhi_dev->status_cb = mhi_drv->status_cb;
+	}
+
+	return mhi_drv->probe(mhi_dev, mhi_dev->id);
 }
 
 static int mhi_driver_remove(struct device *dev)
 {
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+	struct mhi_driver *mhi_drv = to_mhi_driver(dev->driver);
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_chan *mhi_chan;
+	enum MHI_CH_STATE ch_state[] = {
+		MHI_CH_STATE_DISABLED,
+		MHI_CH_STATE_DISABLED
+	};
+	int dir;
+
+	/* control device has no work to do */
+	if (mhi_dev->dev_type == MHI_CONTROLLER_TYPE)
+		return 0;
+
+	/* reset both channels */
+	for (dir = 0; dir < 2; dir++) {
+		mhi_chan = dir ? mhi_dev->ul_chan : mhi_dev->dl_chan;
+
+		if (!mhi_chan)
+			continue;
+
+		/* wake all threads waiting for completion */
+		write_lock_irq(&mhi_chan->lock);
+		mhi_chan->ccs = MHI_EV_CC_INVALID;
+		complete_all(&mhi_chan->completion);
+		write_unlock_irq(&mhi_chan->lock);
+
+		/* move channel state to disable, no more processing */
+		mutex_lock(&mhi_chan->mutex);
+		write_lock_irq(&mhi_chan->lock);
+		ch_state[dir] = mhi_chan->ch_state;
+		mhi_chan->ch_state = MHI_CH_STATE_DISABLED;
+		write_unlock_irq(&mhi_chan->lock);
+	}
+
+	/* destroy the device */
+	mhi_drv->remove(mhi_dev);
+
+	/* de_init channel if it was enabled */
+	for (dir = 0; dir < 2; dir++) {
+		mhi_chan = dir ? mhi_dev->ul_chan : mhi_dev->dl_chan;
+
+		if (!mhi_chan)
+			continue;
+
+		if (ch_state[dir] == MHI_CH_STATE_ENABLED &&
+		    !mhi_chan->offload_ch)
+			mhi_deinit_chan_ctxt(mhi_cntrl, mhi_chan);
+
+		/* remove associated device */
+		mhi_chan->mhi_dev = NULL;
+
+		mutex_unlock(&mhi_chan->mutex);
+	}
+
+	/* relinquish any pending votes */
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	while (atomic_read(&mhi_dev->dev_wake))
+		mhi_device_put(mhi_dev);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
 	return 0;
 }
 
diff --git a/drivers/bus/mhi/core/mhi_internal.h b/drivers/bus/mhi/core/mhi_internal.h
index 90c40de..0091245 100644
--- a/drivers/bus/mhi/core/mhi_internal.h
+++ b/drivers/bus/mhi/core/mhi_internal.h
@@ -9,6 +9,315 @@
 
 extern struct bus_type mhi_bus_type;
 
+/* MHI mmio register mapping */
+#define PCI_INVALID_READ(val) (val == U32_MAX)
+
+#define MHIREGLEN (0x0)
+#define MHIREGLEN_MHIREGLEN_MASK (0xFFFFFFFF)
+#define MHIREGLEN_MHIREGLEN_SHIFT (0)
+
+#define MHIVER (0x8)
+#define MHIVER_MHIVER_MASK (0xFFFFFFFF)
+#define MHIVER_MHIVER_SHIFT (0)
+
+#define MHICFG (0x10)
+#define MHICFG_NHWER_MASK (0xFF000000)
+#define MHICFG_NHWER_SHIFT (24)
+#define MHICFG_NER_MASK (0xFF0000)
+#define MHICFG_NER_SHIFT (16)
+#define MHICFG_NHWCH_MASK (0xFF00)
+#define MHICFG_NHWCH_SHIFT (8)
+#define MHICFG_NCH_MASK (0xFF)
+#define MHICFG_NCH_SHIFT (0)
+
+#define CHDBOFF (0x18)
+#define CHDBOFF_CHDBOFF_MASK (0xFFFFFFFF)
+#define CHDBOFF_CHDBOFF_SHIFT (0)
+
+#define ERDBOFF (0x20)
+#define ERDBOFF_ERDBOFF_MASK (0xFFFFFFFF)
+#define ERDBOFF_ERDBOFF_SHIFT (0)
+
+#define BHIOFF (0x28)
+#define BHIOFF_BHIOFF_MASK (0xFFFFFFFF)
+#define BHIOFF_BHIOFF_SHIFT (0)
+
+#define BHIEOFF (0x2C)
+#define BHIEOFF_BHIEOFF_MASK (0xFFFFFFFF)
+#define BHIEOFF_BHIEOFF_SHIFT (0)
+
+#define DEBUGOFF (0x30)
+#define DEBUGOFF_DEBUGOFF_MASK (0xFFFFFFFF)
+#define DEBUGOFF_DEBUGOFF_SHIFT (0)
+
+#define MHICTRL (0x38)
+#define MHICTRL_MHISTATE_MASK (0x0000FF00)
+#define MHICTRL_MHISTATE_SHIFT (8)
+#define MHICTRL_RESET_MASK (0x2)
+#define MHICTRL_RESET_SHIFT (1)
+
+#define MHISTATUS (0x48)
+#define MHISTATUS_MHISTATE_MASK (0x0000FF00)
+#define MHISTATUS_MHISTATE_SHIFT (8)
+#define MHISTATUS_SYSERR_MASK (0x4)
+#define MHISTATUS_SYSERR_SHIFT (2)
+#define MHISTATUS_READY_MASK (0x1)
+#define MHISTATUS_READY_SHIFT (0)
+
+#define CCABAP_LOWER (0x58)
+#define CCABAP_LOWER_CCABAP_LOWER_MASK (0xFFFFFFFF)
+#define CCABAP_LOWER_CCABAP_LOWER_SHIFT (0)
+
+#define CCABAP_HIGHER (0x5C)
+#define CCABAP_HIGHER_CCABAP_HIGHER_MASK (0xFFFFFFFF)
+#define CCABAP_HIGHER_CCABAP_HIGHER_SHIFT (0)
+
+#define ECABAP_LOWER (0x60)
+#define ECABAP_LOWER_ECABAP_LOWER_MASK (0xFFFFFFFF)
+#define ECABAP_LOWER_ECABAP_LOWER_SHIFT (0)
+
+#define ECABAP_HIGHER (0x64)
+#define ECABAP_HIGHER_ECABAP_HIGHER_MASK (0xFFFFFFFF)
+#define ECABAP_HIGHER_ECABAP_HIGHER_SHIFT (0)
+
+#define CRCBAP_LOWER (0x68)
+#define CRCBAP_LOWER_CRCBAP_LOWER_MASK (0xFFFFFFFF)
+#define CRCBAP_LOWER_CRCBAP_LOWER_SHIFT (0)
+
+#define CRCBAP_HIGHER (0x6C)
+#define CRCBAP_HIGHER_CRCBAP_HIGHER_MASK (0xFFFFFFFF)
+#define CRCBAP_HIGHER_CRCBAP_HIGHER_SHIFT (0)
+
+#define CRDB_LOWER (0x70)
+#define CRDB_LOWER_CRDB_LOWER_MASK (0xFFFFFFFF)
+#define CRDB_LOWER_CRDB_LOWER_SHIFT (0)
+
+#define CRDB_HIGHER (0x74)
+#define CRDB_HIGHER_CRDB_HIGHER_MASK (0xFFFFFFFF)
+#define CRDB_HIGHER_CRDB_HIGHER_SHIFT (0)
+
+#define MHICTRLBASE_LOWER (0x80)
+#define MHICTRLBASE_LOWER_MHICTRLBASE_LOWER_MASK (0xFFFFFFFF)
+#define MHICTRLBASE_LOWER_MHICTRLBASE_LOWER_SHIFT (0)
+
+#define MHICTRLBASE_HIGHER (0x84)
+#define MHICTRLBASE_HIGHER_MHICTRLBASE_HIGHER_MASK (0xFFFFFFFF)
+#define MHICTRLBASE_HIGHER_MHICTRLBASE_HIGHER_SHIFT (0)
+
+#define MHICTRLLIMIT_LOWER (0x88)
+#define MHICTRLLIMIT_LOWER_MHICTRLLIMIT_LOWER_MASK (0xFFFFFFFF)
+#define MHICTRLLIMIT_LOWER_MHICTRLLIMIT_LOWER_SHIFT (0)
+
+#define MHICTRLLIMIT_HIGHER (0x8C)
+#define MHICTRLLIMIT_HIGHER_MHICTRLLIMIT_HIGHER_MASK (0xFFFFFFFF)
+#define MHICTRLLIMIT_HIGHER_MHICTRLLIMIT_HIGHER_SHIFT (0)
+
+#define MHIDATABASE_LOWER (0x98)
+#define MHIDATABASE_LOWER_MHIDATABASE_LOWER_MASK (0xFFFFFFFF)
+#define MHIDATABASE_LOWER_MHIDATABASE_LOWER_SHIFT (0)
+
+#define MHIDATABASE_HIGHER (0x9C)
+#define MHIDATABASE_HIGHER_MHIDATABASE_HIGHER_MASK (0xFFFFFFFF)
+#define MHIDATABASE_HIGHER_MHIDATABASE_HIGHER_SHIFT (0)
+
+#define MHIDATALIMIT_LOWER (0xA0)
+#define MHIDATALIMIT_LOWER_MHIDATALIMIT_LOWER_MASK (0xFFFFFFFF)
+#define MHIDATALIMIT_LOWER_MHIDATALIMIT_LOWER_SHIFT (0)
+
+#define MHIDATALIMIT_HIGHER (0xA4)
+#define MHIDATALIMIT_HIGHER_MHIDATALIMIT_HIGHER_MASK (0xFFFFFFFF)
+#define MHIDATALIMIT_HIGHER_MHIDATALIMIT_HIGHER_SHIFT (0)
+
+/* MHI BHI offfsets */
+#define BHI_BHIVERSION_MINOR (0x00)
+#define BHI_BHIVERSION_MAJOR (0x04)
+#define BHI_IMGADDR_LOW (0x08)
+#define BHI_IMGADDR_HIGH (0x0C)
+#define BHI_IMGSIZE (0x10)
+#define BHI_RSVD1 (0x14)
+#define BHI_IMGTXDB (0x18)
+#define BHI_TXDB_SEQNUM_BMSK (0x3FFFFFFF)
+#define BHI_TXDB_SEQNUM_SHFT (0)
+#define BHI_RSVD2 (0x1C)
+#define BHI_INTVEC (0x20)
+#define BHI_RSVD3 (0x24)
+#define BHI_EXECENV (0x28)
+#define BHI_STATUS (0x2C)
+#define BHI_ERRCODE (0x30)
+#define BHI_ERRDBG1 (0x34)
+#define BHI_ERRDBG2 (0x38)
+#define BHI_ERRDBG3 (0x3C)
+#define BHI_SERIALNU (0x40)
+#define BHI_SBLANTIROLLVER (0x44)
+#define BHI_NUMSEG (0x48)
+#define BHI_MSMHWID(n) (0x4C + (0x4 * n))
+#define BHI_OEMPKHASH(n) (0x64 + (0x4 * n))
+#define BHI_RSVD5 (0xC4)
+#define BHI_STATUS_MASK (0xC0000000)
+#define BHI_STATUS_SHIFT (30)
+#define BHI_STATUS_ERROR (3)
+#define BHI_STATUS_SUCCESS (2)
+#define BHI_STATUS_RESET (0)
+
+/* MHI BHIE offsets */
+#define BHIE_MSMSOCID_OFFS (0x0000)
+#define BHIE_TXVECADDR_LOW_OFFS (0x002C)
+#define BHIE_TXVECADDR_HIGH_OFFS (0x0030)
+#define BHIE_TXVECSIZE_OFFS (0x0034)
+#define BHIE_TXVECDB_OFFS (0x003C)
+#define BHIE_TXVECDB_SEQNUM_BMSK (0x3FFFFFFF)
+#define BHIE_TXVECDB_SEQNUM_SHFT (0)
+#define BHIE_TXVECSTATUS_OFFS (0x0044)
+#define BHIE_TXVECSTATUS_SEQNUM_BMSK (0x3FFFFFFF)
+#define BHIE_TXVECSTATUS_SEQNUM_SHFT (0)
+#define BHIE_TXVECSTATUS_STATUS_BMSK (0xC0000000)
+#define BHIE_TXVECSTATUS_STATUS_SHFT (30)
+#define BHIE_TXVECSTATUS_STATUS_RESET (0x00)
+#define BHIE_TXVECSTATUS_STATUS_XFER_COMPL (0x02)
+#define BHIE_TXVECSTATUS_STATUS_ERROR (0x03)
+#define BHIE_RXVECADDR_LOW_OFFS (0x0060)
+#define BHIE_RXVECADDR_HIGH_OFFS (0x0064)
+#define BHIE_RXVECSIZE_OFFS (0x0068)
+#define BHIE_RXVECDB_OFFS (0x0070)
+#define BHIE_RXVECDB_SEQNUM_BMSK (0x3FFFFFFF)
+#define BHIE_RXVECDB_SEQNUM_SHFT (0)
+#define BHIE_RXVECSTATUS_OFFS (0x0078)
+#define BHIE_RXVECSTATUS_SEQNUM_BMSK (0x3FFFFFFF)
+#define BHIE_RXVECSTATUS_SEQNUM_SHFT (0)
+#define BHIE_RXVECSTATUS_STATUS_BMSK (0xC0000000)
+#define BHIE_RXVECSTATUS_STATUS_SHFT (30)
+#define BHIE_RXVECSTATUS_STATUS_RESET (0x00)
+#define BHIE_RXVECSTATUS_STATUS_XFER_COMPL (0x02)
+#define BHIE_RXVECSTATUS_STATUS_ERROR (0x03)
+
+struct mhi_event_ctxt {
+	u32 reserved : 8;
+	u32 intmodc : 8;
+	u32 intmodt : 16;
+	u32 ertype;
+	u32 msivec;
+
+	u64 rbase __packed __aligned(4);
+	u64 rlen __packed __aligned(4);
+	u64 rp __packed __aligned(4);
+	u64 wp __packed __aligned(4);
+};
+
+struct mhi_chan_ctxt {
+	u32 chstate : 8;
+	u32 brstmode : 2;
+	u32 pollcfg : 6;
+	u32 reserved : 16;
+	u32 chtype;
+	u32 erindex;
+
+	u64 rbase __packed __aligned(4);
+	u64 rlen __packed __aligned(4);
+	u64 rp __packed __aligned(4);
+	u64 wp __packed __aligned(4);
+};
+
+struct mhi_cmd_ctxt {
+	u32 reserved0;
+	u32 reserved1;
+	u32 reserved2;
+
+	u64 rbase __packed __aligned(4);
+	u64 rlen __packed __aligned(4);
+	u64 rp __packed __aligned(4);
+	u64 wp __packed __aligned(4);
+};
+
+struct mhi_tre {
+	u64 ptr;
+	u32 dword[2];
+};
+
+struct bhi_vec_entry {
+	u64 dma_addr;
+	u64 size;
+};
+
+enum mhi_cmd_type {
+	MHI_CMD_TYPE_NOP = 1,
+	MHI_CMD_TYPE_RESET = 16,
+	MHI_CMD_TYPE_STOP = 17,
+	MHI_CMD_TYPE_START = 18,
+	MHI_CMD_TYPE_TSYNC = 24,
+};
+
+/* no operation command */
+#define MHI_TRE_CMD_NOOP_PTR (0)
+#define MHI_TRE_CMD_NOOP_DWORD0 (0)
+#define MHI_TRE_CMD_NOOP_DWORD1 (MHI_CMD_TYPE_NOP << 16)
+
+/* channel reset command */
+#define MHI_TRE_CMD_RESET_PTR (0)
+#define MHI_TRE_CMD_RESET_DWORD0 (0)
+#define MHI_TRE_CMD_RESET_DWORD1(chid) ((chid << 24) | \
+					(MHI_CMD_TYPE_RESET << 16))
+
+/* channel stop command */
+#define MHI_TRE_CMD_STOP_PTR (0)
+#define MHI_TRE_CMD_STOP_DWORD0 (0)
+#define MHI_TRE_CMD_STOP_DWORD1(chid) ((chid << 24) | (MHI_CMD_TYPE_STOP << 16))
+
+/* channel start command */
+#define MHI_TRE_CMD_START_PTR (0)
+#define MHI_TRE_CMD_START_DWORD0 (0)
+#define MHI_TRE_CMD_START_DWORD1(chid) ((chid << 24) | \
+					(MHI_CMD_TYPE_START << 16))
+
+/* time sync cfg command */
+#define MHI_TRE_CMD_TSYNC_CFG_PTR (0)
+#define MHI_TRE_CMD_TSYNC_CFG_DWORD0 (0)
+#define MHI_TRE_CMD_TSYNC_CFG_DWORD1(er) ((MHI_CMD_TYPE_TSYNC << 16) | \
+					  (er << 24))
+
+#define MHI_TRE_GET_CMD_CHID(tre) (((tre)->dword[1] >> 24) & 0xFF)
+#define MHI_TRE_GET_CMD_TYPE(tre) (((tre)->dword[1] >> 16) & 0xFF)
+
+/* event descriptor macros */
+#define MHI_TRE_EV_PTR(ptr) (ptr)
+#define MHI_TRE_EV_DWORD0(code, len) ((code << 24) | len)
+#define MHI_TRE_EV_DWORD1(chid, type) ((chid << 24) | (type << 16))
+#define MHI_TRE_GET_EV_PTR(tre) ((tre)->ptr)
+#define MHI_TRE_GET_EV_CODE(tre) (((tre)->dword[0] >> 24) & 0xFF)
+#define MHI_TRE_GET_EV_LEN(tre) ((tre)->dword[0] & 0xFFFF)
+#define MHI_TRE_GET_EV_CHID(tre) (((tre)->dword[1] >> 24) & 0xFF)
+#define MHI_TRE_GET_EV_TYPE(tre) (((tre)->dword[1] >> 16) & 0xFF)
+#define MHI_TRE_GET_EV_STATE(tre) (((tre)->dword[0] >> 24) & 0xFF)
+#define MHI_TRE_GET_EV_EXECENV(tre) (((tre)->dword[0] >> 24) & 0xFF)
+#define MHI_TRE_GET_EV_SEQ(tre) ((tre)->dword[0])
+#define MHI_TRE_GET_EV_TIME(tre) ((tre)->ptr)
+
+/* transfer descriptor macros */
+#define MHI_TRE_DATA_PTR(ptr) (ptr)
+#define MHI_TRE_DATA_DWORD0(len) (len & MHI_MAX_MTU)
+#define MHI_TRE_DATA_DWORD1(bei, ieot, ieob, chain) ((2 << 16) | (bei << 10) \
+	| (ieot << 9) | (ieob << 8) | chain)
+
+enum MHI_CMD {
+	MHI_CMD_RESET_CHAN,
+	MHI_CMD_START_CHAN,
+	MHI_CMD_TIMSYNC_CFG,
+};
+
+enum MHI_PKT_TYPE {
+	MHI_PKT_TYPE_INVALID = 0x0,
+	MHI_PKT_TYPE_NOOP_CMD = 0x1,
+	MHI_PKT_TYPE_TRANSFER = 0x2,
+	MHI_PKT_TYPE_RESET_CHAN_CMD = 0x10,
+	MHI_PKT_TYPE_STOP_CHAN_CMD = 0x11,
+	MHI_PKT_TYPE_START_CHAN_CMD = 0x12,
+	MHI_PKT_TYPE_STATE_CHANGE_EVENT = 0x20,
+	MHI_PKT_TYPE_CMD_COMPLETION_EVENT = 0x21,
+	MHI_PKT_TYPE_TX_EVENT = 0x22,
+	MHI_PKT_TYPE_EE_EVENT = 0x40,
+	MHI_PKT_TYPE_TSYNC_EVENT = 0x48,
+	MHI_PKT_TYPE_STALE_EVENT, /* internal event */
+};
+
 /* MHI transfer completion events */
 enum MHI_EV_CCS {
 	MHI_EV_CC_INVALID = 0x0,
@@ -52,6 +361,93 @@ enum MHI_EE {
 	MHI_EE_MAX,
 };
 
+extern const char * const mhi_ee_str[MHI_EE_MAX];
+#define TO_MHI_EXEC_STR(ee) (((ee) >= MHI_EE_MAX) ? \
+			     "INVALID_EE" : mhi_ee_str[ee])
+
+#define MHI_IN_PBL(ee) (ee == MHI_EE_PBL || ee == MHI_EE_PTHRU || \
+			ee == MHI_EE_EDL)
+
+enum MHI_ST_TRANSITION {
+	MHI_ST_TRANSITION_PBL,
+	MHI_ST_TRANSITION_READY,
+	MHI_ST_TRANSITION_SBL,
+	MHI_ST_TRANSITION_AMSS,
+	MHI_ST_TRANSITION_BHIE,
+	MHI_ST_TRANSITION_MAX,
+};
+
+extern const char * const mhi_state_tran_str[MHI_ST_TRANSITION_MAX];
+#define TO_MHI_STATE_TRANS_STR(state) (((state) >= MHI_ST_TRANSITION_MAX) ? \
+				"INVALID_STATE" : mhi_state_tran_str[state])
+
+enum MHI_STATE {
+	MHI_STATE_RESET = 0x0,
+	MHI_STATE_READY = 0x1,
+	MHI_STATE_M0 = 0x2,
+	MHI_STATE_M1 = 0x3,
+	MHI_STATE_M2 = 0x4,
+	MHI_STATE_M3 = 0x5,
+	MHI_STATE_BHI  = 0x7,
+	MHI_STATE_SYS_ERR  = 0xFF,
+	MHI_STATE_MAX,
+};
+
+extern const char * const mhi_state_str[MHI_STATE_MAX];
+#define TO_MHI_STATE_STR(state) ((state >= MHI_STATE_MAX || \
+				  !mhi_state_str[state]) ? \
+				"INVALID_STATE" : mhi_state_str[state])
+
+enum {
+	MHI_PM_BIT_DISABLE,
+	MHI_PM_BIT_POR,
+	MHI_PM_BIT_M0,
+	MHI_PM_BIT_M2,
+	MHI_PM_BIT_M3_ENTER,
+	MHI_PM_BIT_M3,
+	MHI_PM_BIT_M3_EXIT,
+	MHI_PM_BIT_FW_DL_ERR,
+	MHI_PM_BIT_SYS_ERR_DETECT,
+	MHI_PM_BIT_SYS_ERR_PROCESS,
+	MHI_PM_BIT_SHUTDOWN_PROCESS,
+	MHI_PM_BIT_LD_ERR_FATAL_DETECT,
+	MHI_PM_BIT_MAX
+};
+
+/* internal power states */
+enum MHI_PM_STATE {
+	MHI_PM_DISABLE = BIT(MHI_PM_BIT_DISABLE), /* MHI is not enabled */
+	MHI_PM_POR = BIT(MHI_PM_BIT_POR), /* reset state */
+	MHI_PM_M0 = BIT(MHI_PM_BIT_M0),
+	MHI_PM_M2 = BIT(MHI_PM_BIT_M2),
+	MHI_PM_M3_ENTER = BIT(MHI_PM_BIT_M3_ENTER),
+	MHI_PM_M3 = BIT(MHI_PM_BIT_M3),
+	MHI_PM_M3_EXIT = BIT(MHI_PM_BIT_M3_EXIT),
+	/* firmware download failure state */
+	MHI_PM_FW_DL_ERR = BIT(MHI_PM_BIT_FW_DL_ERR),
+	MHI_PM_SYS_ERR_DETECT = BIT(MHI_PM_BIT_SYS_ERR_DETECT),
+	MHI_PM_SYS_ERR_PROCESS = BIT(MHI_PM_BIT_SYS_ERR_PROCESS),
+	MHI_PM_SHUTDOWN_PROCESS = BIT(MHI_PM_BIT_SHUTDOWN_PROCESS),
+	/* link not accessible */
+	MHI_PM_LD_ERR_FATAL_DETECT = BIT(MHI_PM_BIT_LD_ERR_FATAL_DETECT),
+};
+
+#define MHI_REG_ACCESS_VALID(pm_state) ((pm_state & (MHI_PM_POR | MHI_PM_M0 | \
+		MHI_PM_M2 | MHI_PM_M3_ENTER | MHI_PM_M3_EXIT | \
+		MHI_PM_SYS_ERR_DETECT | MHI_PM_SYS_ERR_PROCESS | \
+		MHI_PM_SHUTDOWN_PROCESS | MHI_PM_FW_DL_ERR)))
+#define MHI_PM_IN_ERROR_STATE(pm_state) (pm_state >= MHI_PM_FW_DL_ERR)
+#define MHI_PM_IN_FATAL_STATE(pm_state) (pm_state == MHI_PM_LD_ERR_FATAL_DETECT)
+#define MHI_DB_ACCESS_VALID(pm_state) (pm_state & MHI_PM_M0)
+#define MHI_WAKE_DB_CLEAR_VALID(pm_state) (pm_state & (MHI_PM_M0 | \
+						       MHI_PM_M2))
+#define MHI_WAKE_DB_SET_VALID(pm_state) (pm_state & MHI_PM_M2)
+#define MHI_WAKE_DB_FORCE_SET_VALID(pm_state) MHI_WAKE_DB_CLEAR_VALID(pm_state)
+#define MHI_EVENT_ACCESS_INVALID(pm_state) (pm_state == MHI_PM_DISABLE || \
+					    MHI_PM_IN_ERROR_STATE(pm_state))
+#define MHI_PM_IN_SUSPEND_STATE(pm_state) (pm_state & \
+					   (MHI_PM_M3_ENTER | MHI_PM_M3))
+
 /* accepted buffer type for the channel */
 enum MHI_XFER_TYPE {
 	MHI_XFER_BUFFER,
@@ -63,6 +459,7 @@ enum MHI_XFER_TYPE {
 #define NR_OF_CMD_RINGS (1)
 #define CMD_EL_PER_RING (128)
 #define PRIMARY_CMD_RING (0)
+#define MHI_DEV_WAKE_DB (127)
 #define MHI_MAX_MTU (0xffff)
 
 enum MHI_ER_TYPE {
@@ -87,6 +484,25 @@ struct db_cfg {
 			   dma_addr_t db_val);
 };
 
+struct mhi_pm_transitions {
+	enum MHI_PM_STATE from_state;
+	u32 to_states;
+};
+
+struct state_transition {
+	struct list_head node;
+	enum MHI_ST_TRANSITION state;
+};
+
+struct mhi_ctxt {
+	struct mhi_event_ctxt *er_ctxt;
+	struct mhi_chan_ctxt *chan_ctxt;
+	struct mhi_cmd_ctxt *cmd_ctxt;
+	dma_addr_t er_ctxt_addr;
+	dma_addr_t chan_ctxt_addr;
+	dma_addr_t cmd_ctxt_addr;
+};
+
 struct mhi_ring {
 	dma_addr_t dma_handle;
 	dma_addr_t iommu_base;
@@ -179,10 +595,33 @@ struct mhi_chan {
 /* default MHI timeout */
 #define MHI_TIMEOUT_MS (1000)
 
+/* debug fs related functions */
+void mhi_deinit_debugfs(struct mhi_controller *mhi_cntrl);
+void mhi_init_debugfs(struct mhi_controller *mhi_cntrl);
+
 /* power management apis */
+enum MHI_PM_STATE __must_check mhi_tryset_pm_state(
+					struct mhi_controller *mhi_cntrl,
+					enum MHI_PM_STATE state);
+const char *to_mhi_pm_state_str(enum MHI_PM_STATE state);
+void mhi_reset_chan(struct mhi_controller *mhi_cntrl,
+		    struct mhi_chan *mhi_chan);
+enum MHI_EE mhi_get_exec_env(struct mhi_controller *mhi_cntrl);
+enum MHI_STATE mhi_get_m_state(struct mhi_controller *mhi_cntrl);
+int mhi_queue_state_transition(struct mhi_controller *mhi_cntrl,
+			       enum MHI_ST_TRANSITION state);
 void mhi_pm_st_worker(struct work_struct *work);
 void mhi_fw_load_worker(struct work_struct *work);
 void mhi_pm_sys_err_worker(struct work_struct *work);
+int mhi_ready_state_transition(struct mhi_controller *mhi_cntrl);
+void mhi_ctrl_ev_task(unsigned long data);
+int mhi_pm_m0_transition(struct mhi_controller *mhi_cntrl);
+void mhi_pm_m1_transition(struct mhi_controller *mhi_cntrl);
+int mhi_pm_m3_transition(struct mhi_controller *mhi_cntrl);
+void mhi_notify(struct mhi_device *mhi_dev, enum MHI_CB cb_reason);
+int mhi_send_cmd(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
+		 enum MHI_CMD cmd);
+int __mhi_device_get_sync(struct mhi_controller *mhi_cntrl);
 
 /* queue transfer buffer */
 int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
@@ -202,7 +641,46 @@ void mhi_db_brstmode(struct mhi_controller *mhi_cntrl, struct db_cfg *db_cfg,
 void mhi_db_brstmode_disable(struct mhi_controller *mhi_cntrl,
 			     struct db_cfg *db_mode, void __iomem *db_addr,
 			     dma_addr_t wp);
+int __must_check mhi_read_reg(struct mhi_controller *mhi_cntrl,
+			      void __iomem *base, u32 offset, u32 *out);
+int __must_check mhi_read_reg_field(struct mhi_controller *mhi_cntrl,
+				    void __iomem *base, u32 offset, u32 mask,
+				    u32 shift, u32 *out);
+void mhi_write_reg(struct mhi_controller *mhi_cntrl, void __iomem *base,
+		   u32 offset, u32 val);
+void mhi_write_reg_field(struct mhi_controller *mhi_cntrl, void __iomem *base,
+			 u32 offset, u32 mask, u32 shift, u32 val);
+void mhi_ring_er_db(struct mhi_event *mhi_event);
+void mhi_write_db(struct mhi_controller *mhi_cntrl, void __iomem *db_addr,
+		  dma_addr_t wp);
+void mhi_ring_cmd_db(struct mhi_controller *mhi_cntrl, struct mhi_cmd *mhi_cmd);
+void mhi_ring_chan_db(struct mhi_controller *mhi_cntrl,
+		      struct mhi_chan *mhi_chan);
+void mhi_set_mhi_state(struct mhi_controller *mhi_cntrl, enum MHI_STATE state);
+int mhi_get_capability_offset(struct mhi_controller *mhi_cntrl, u32 capability,
+			      u32 *offset);
+
+/* memory allocation methods */
+static inline void *mhi_alloc_coherent(struct mhi_controller *mhi_cntrl,
+				       size_t size,
+				       dma_addr_t *dma_handle,
+				       gfp_t gfp)
+{
+	void *buf = dma_zalloc_coherent(mhi_cntrl->dev, size, dma_handle, gfp);
+
+	if (buf)
+		atomic_add(size, &mhi_cntrl->alloc_size);
 
+	return buf;
+}
+static inline void mhi_free_coherent(struct mhi_controller *mhi_cntrl,
+				     size_t size,
+				     void *vaddr,
+				     dma_addr_t dma_handle)
+{
+	atomic_sub(size, &mhi_cntrl->alloc_size);
+	dma_free_coherent(mhi_cntrl->dev, size, vaddr, dma_handle);
+}
 struct mhi_device *mhi_alloc_device(struct mhi_controller *mhi_cntrl);
 static inline void mhi_dealloc_device(struct mhi_controller *mhi_cntrl,
 				      struct mhi_device *mhi_dev)
@@ -211,6 +689,10 @@ static inline void mhi_dealloc_device(struct mhi_controller *mhi_cntrl,
 }
 int mhi_destroy_device(struct device *dev, void *data);
 void mhi_create_devices(struct mhi_controller *mhi_cntrl);
+int mhi_alloc_bhie_table(struct mhi_controller *mhi_cntrl,
+			 struct image_info **image_info, size_t alloc_size);
+void mhi_free_bhie_table(struct mhi_controller *mhi_cntrl,
+			 struct image_info *image_info);
 
 int mhi_map_single_no_bb(struct mhi_controller *mhi_cntrl,
 			 struct mhi_buf_info *buf_info);
@@ -227,6 +709,15 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
 			     struct mhi_event *mhi_event, u32 event_quota);
 
 /* initialization methods */
+int mhi_init_chan_ctxt(struct mhi_controller *mhi_cntrl,
+		       struct mhi_chan *mhi_chan);
+void mhi_deinit_chan_ctxt(struct mhi_controller *mhi_cntrl,
+			  struct mhi_chan *mhi_chan);
+int mhi_init_mmio(struct mhi_controller *mhi_cntrl);
+int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl);
+void mhi_deinit_dev_ctxt(struct mhi_controller *mhi_cntrl);
+int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl);
+void mhi_deinit_free_irq(struct mhi_controller *mhi_cntrl);
 int mhi_dtr_init(void);
 
 /* isr handlers */
diff --git a/drivers/bus/mhi/core/mhi_main.c b/drivers/bus/mhi/core/mhi_main.c
index 4df4cd0..81cda31 100644
--- a/drivers/bus/mhi/core/mhi_main.c
+++ b/drivers/bus/mhi/core/mhi_main.c
@@ -17,11 +17,87 @@
 #include <linux/mhi.h>
 #include "mhi_internal.h"
 
+int __must_check mhi_read_reg(struct mhi_controller *mhi_cntrl,
+			      void __iomem *base,
+			      u32 offset,
+			      u32 *out)
+{
+	u32 tmp = readl_relaxed(base + offset);
+
+	/* unexpected value, query the link status */
+	if (PCI_INVALID_READ(tmp) &&
+	    mhi_cntrl->link_status(mhi_cntrl, mhi_cntrl->priv_data))
+		return -EIO;
+
+	*out = tmp;
+
+	return 0;
+}
+
+int __must_check mhi_read_reg_field(struct mhi_controller *mhi_cntrl,
+				    void __iomem *base,
+				    u32 offset,
+				    u32 mask,
+				    u32 shift,
+				    u32 *out)
+{
+	u32 tmp;
+	int ret;
+
+	ret = mhi_read_reg(mhi_cntrl, base, offset, &tmp);
+	if (ret)
+		return ret;
+
+	*out = (tmp & mask) >> shift;
+
+	return 0;
+}
+
+void mhi_write_reg(struct mhi_controller *mhi_cntrl,
+		   void __iomem *base,
+		   u32 offset,
+		   u32 val)
+{
+	writel_relaxed(val, base + offset);
+}
+
+void mhi_write_reg_field(struct mhi_controller *mhi_cntrl,
+			 void __iomem *base,
+			 u32 offset,
+			 u32 mask,
+			 u32 shift,
+			 u32 val)
+{
+	int ret;
+	u32 tmp;
+
+	ret = mhi_read_reg(mhi_cntrl, base, offset, &tmp);
+	if (ret)
+		return;
+
+	tmp &= ~mask;
+	tmp |= (val << shift);
+	mhi_write_reg(mhi_cntrl, base, offset, tmp);
+}
+
+void mhi_write_db(struct mhi_controller *mhi_cntrl,
+		  void __iomem *db_addr,
+		  dma_addr_t wp)
+{
+	mhi_write_reg(mhi_cntrl, db_addr, 4, upper_32_bits(wp));
+	mhi_write_reg(mhi_cntrl, db_addr, 0, lower_32_bits(wp));
+}
+
 void mhi_db_brstmode(struct mhi_controller *mhi_cntrl,
 		     struct db_cfg *db_cfg,
 		     void __iomem *db_addr,
 		     dma_addr_t wp)
 {
+	if (db_cfg->db_mode) {
+		db_cfg->db_val = wp;
+		mhi_write_db(mhi_cntrl, db_addr, wp);
+		db_cfg->db_mode = 0;
+	}
 }
 
 void mhi_db_brstmode_disable(struct mhi_controller *mhi_cntrl,
@@ -29,6 +105,55 @@ void mhi_db_brstmode_disable(struct mhi_controller *mhi_cntrl,
 			     void __iomem *db_addr,
 			     dma_addr_t wp)
 {
+	db_cfg->db_val = wp;
+	mhi_write_db(mhi_cntrl, db_addr, wp);
+}
+
+void mhi_ring_er_db(struct mhi_event *mhi_event)
+{
+	struct mhi_ring *ring = &mhi_event->ring;
+
+	mhi_event->db_cfg.process_db(mhi_event->mhi_cntrl, &mhi_event->db_cfg,
+				     ring->db_addr, *ring->ctxt_wp);
+}
+
+void mhi_ring_cmd_db(struct mhi_controller *mhi_cntrl, struct mhi_cmd *mhi_cmd)
+{
+	dma_addr_t db;
+	struct mhi_ring *ring = &mhi_cmd->ring;
+
+	db = ring->iommu_base + (ring->wp - ring->base);
+	*ring->ctxt_wp = db;
+	mhi_write_db(mhi_cntrl, ring->db_addr, db);
+}
+
+void mhi_ring_chan_db(struct mhi_controller *mhi_cntrl,
+		      struct mhi_chan *mhi_chan)
+{
+	struct mhi_ring *ring = &mhi_chan->tre_ring;
+	dma_addr_t db;
+
+	db = ring->iommu_base + (ring->wp - ring->base);
+	*ring->ctxt_wp = db;
+	mhi_chan->db_cfg.process_db(mhi_cntrl, &mhi_chan->db_cfg, ring->db_addr,
+				    db);
+}
+
+enum MHI_EE mhi_get_exec_env(struct mhi_controller *mhi_cntrl)
+{
+	u32 exec;
+	int ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_EXECENV, &exec);
+
+	return (ret) ? MHI_EE_MAX : exec;
+}
+
+enum MHI_STATE mhi_get_m_state(struct mhi_controller *mhi_cntrl)
+{
+	u32 state;
+	int ret = mhi_read_reg_field(mhi_cntrl, mhi_cntrl->regs, MHISTATUS,
+				     MHISTATUS_MHISTATE_MASK,
+				     MHISTATUS_MHISTATE_SHIFT, &state);
+	return ret ? MHI_STATE_MAX : state;
 }
 
 int mhi_map_single_no_bb(struct mhi_controller *mhi_cntrl,
@@ -71,6 +196,41 @@ int mhi_queue_nop(struct mhi_device *mhi_dev,
 	return -EINVAL;
 }
 
+static void *mhi_to_virtual(struct mhi_ring *ring, dma_addr_t addr)
+{
+	return (addr - ring->iommu_base) + ring->base;
+}
+
+dma_addr_t mhi_to_physical(struct mhi_ring *ring, void *addr)
+{
+	return (addr - ring->base) + ring->iommu_base;
+}
+
+static void mhi_recycle_ev_ring_element(struct mhi_controller *mhi_cntrl,
+					struct mhi_ring *ring)
+{
+	dma_addr_t ctxt_wp;
+
+	/* update the WP */
+	ring->wp += ring->el_size;
+	ctxt_wp = *ring->ctxt_wp + ring->el_size;
+
+	if (ring->wp >= (ring->base + ring->len)) {
+		ring->wp = ring->base;
+		ctxt_wp = ring->iommu_base;
+	}
+
+	*ring->ctxt_wp = ctxt_wp;
+
+	/* update the RP */
+	ring->rp += ring->el_size;
+	if (ring->rp >= (ring->base + ring->len))
+		ring->rp = ring->base;
+
+	/* visible to other cores */
+	smp_wmb();
+}
+
 int mhi_queue_skb(struct mhi_device *mhi_dev,
 		  struct mhi_chan *mhi_chan,
 		  void *buf,
@@ -99,11 +259,254 @@ int mhi_queue_buf(struct mhi_device *mhi_dev,
 	return -EINVAL;
 }
 
+/* destroy specific device */
+int mhi_destroy_device(struct device *dev, void *data)
+{
+	struct mhi_device *mhi_dev;
+	struct mhi_controller *mhi_cntrl;
+
+	if (dev->bus != &mhi_bus_type)
+		return 0;
+
+	mhi_dev = to_mhi_device(dev);
+	mhi_cntrl = mhi_dev->mhi_cntrl;
+
+	/* only destroying virtual devices thats attached to bus */
+	if (mhi_dev->dev_type ==  MHI_CONTROLLER_TYPE)
+		return 0;
+
+	dev_info(mhi_cntrl->dev, "destroy device for chan:%s\n",
+		 mhi_dev->chan_name);
+
+	/* notify the client and remove the device from mhi bus */
+	device_del(dev);
+	put_device(dev);
+
+	return 0;
+}
+
+void mhi_notify(struct mhi_device *mhi_dev, enum MHI_CB cb_reason)
+{
+	struct mhi_driver *mhi_drv;
+
+	if (!mhi_dev->dev.driver)
+		return;
+
+	mhi_drv = to_mhi_driver(mhi_dev->dev.driver);
+
+	if (mhi_drv->status_cb)
+		mhi_drv->status_cb(mhi_dev, cb_reason);
+}
+
+static void mhi_assign_of_node(struct mhi_controller *mhi_cntrl,
+			       struct mhi_device *mhi_dev)
+{
+	struct device_node *controller, *node;
+	const char *dt_name;
+	int ret;
+
+	controller = mhi_cntrl->of_node;
+	for_each_available_child_of_node(controller, node) {
+		ret = of_property_read_string(node, "mhi,chan", &dt_name);
+		if (ret)
+			continue;
+		if (!strcmp(mhi_dev->chan_name, dt_name)) {
+			mhi_dev->dev.of_node = node;
+			break;
+		}
+	}
+}
+
+/* bind mhi channels into mhi devices */
+void mhi_create_devices(struct mhi_controller *mhi_cntrl)
+{
+	int i;
+	struct mhi_chan *mhi_chan;
+	struct mhi_device *mhi_dev;
+	int ret;
+
+	mhi_chan = mhi_cntrl->mhi_chan;
+	for (i = 0; i < mhi_cntrl->max_chan; i++, mhi_chan++) {
+		if (!mhi_chan->configured || mhi_chan->ee != mhi_cntrl->ee)
+			continue;
+		mhi_dev = mhi_alloc_device(mhi_cntrl);
+		if (!mhi_dev)
+			return;
+
+		mhi_dev->dev_type = MHI_XFER_TYPE;
+		switch (mhi_chan->dir) {
+		case DMA_TO_DEVICE:
+			mhi_dev->ul_chan = mhi_chan;
+			mhi_dev->ul_chan_id = mhi_chan->chan;
+			mhi_dev->ul_xfer = mhi_chan->queue_xfer;
+			mhi_dev->ul_event_id = mhi_chan->er_index;
+			break;
+		case DMA_NONE:
+		case DMA_BIDIRECTIONAL:
+			mhi_dev->ul_chan_id = mhi_chan->chan;
+		case DMA_FROM_DEVICE:
+			/* we use dl_chan for offload channels */
+			mhi_dev->dl_chan = mhi_chan;
+			mhi_dev->dl_chan_id = mhi_chan->chan;
+			mhi_dev->dl_xfer = mhi_chan->queue_xfer;
+			mhi_dev->dl_event_id = mhi_chan->er_index;
+		}
+
+		mhi_chan->mhi_dev = mhi_dev;
+
+		/* check next channel if it matches */
+		if ((i + 1) < mhi_cntrl->max_chan && mhi_chan[1].configured) {
+			if (!strcmp(mhi_chan[1].name, mhi_chan->name)) {
+				i++;
+				mhi_chan++;
+				if (mhi_chan->dir == DMA_TO_DEVICE) {
+					mhi_dev->ul_chan = mhi_chan;
+					mhi_dev->ul_chan_id = mhi_chan->chan;
+					mhi_dev->ul_xfer = mhi_chan->queue_xfer;
+					mhi_dev->ul_event_id =
+						mhi_chan->er_index;
+				} else {
+					mhi_dev->dl_chan = mhi_chan;
+					mhi_dev->dl_chan_id = mhi_chan->chan;
+					mhi_dev->dl_xfer = mhi_chan->queue_xfer;
+					mhi_dev->dl_event_id =
+						mhi_chan->er_index;
+				}
+				mhi_chan->mhi_dev = mhi_dev;
+			}
+		}
+
+		mhi_dev->chan_name = mhi_chan->name;
+		dev_set_name(&mhi_dev->dev, "%04x_%02u.%02u.%02u_%s",
+			     mhi_dev->dev_id, mhi_dev->domain, mhi_dev->bus,
+			     mhi_dev->slot, mhi_dev->chan_name);
+
+		/* add if there is a matching DT node */
+		mhi_assign_of_node(mhi_cntrl, mhi_dev);
+
+		ret = device_add(&mhi_dev->dev);
+		if (ret)
+			mhi_dealloc_device(mhi_cntrl, mhi_dev);
+	}
+}
 int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
 			     struct mhi_event *mhi_event,
 			     u32 event_quota)
 {
-	return -EIO;
+	struct mhi_tre *dev_rp, *local_rp;
+	struct mhi_ring *ev_ring = &mhi_event->ring;
+	struct mhi_event_ctxt *er_ctxt =
+		&mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
+	int count = 0;
+
+	/*
+	 * this is a quick check to avoid unnecessary event processing
+	 * in case we already in error state, but it's still possible
+	 * to transition to error state while processing events
+	 */
+	if (unlikely(MHI_EVENT_ACCESS_INVALID(mhi_cntrl->pm_state)))
+		return -EIO;
+
+	dev_rp = mhi_to_virtual(ev_ring, er_ctxt->rp);
+	local_rp = ev_ring->rp;
+
+	while (dev_rp != local_rp) {
+		enum MHI_PKT_TYPE type = MHI_TRE_GET_EV_TYPE(local_rp);
+
+		switch (type) {
+		case MHI_PKT_TYPE_STATE_CHANGE_EVENT:
+		{
+			enum MHI_STATE new_state;
+
+			new_state = MHI_TRE_GET_EV_STATE(local_rp);
+
+			dev_info(mhi_cntrl->dev,
+				 "MHI state change event to state:%s\n",
+				 TO_MHI_STATE_STR(new_state));
+
+			switch (new_state) {
+			case MHI_STATE_M0:
+				mhi_pm_m0_transition(mhi_cntrl);
+				break;
+			case MHI_STATE_M1:
+				mhi_pm_m1_transition(mhi_cntrl);
+				break;
+			case MHI_STATE_M3:
+				mhi_pm_m3_transition(mhi_cntrl);
+				break;
+			case MHI_STATE_SYS_ERR:
+			{
+				enum MHI_PM_STATE new_state;
+
+				dev_info(mhi_cntrl->dev,
+					 "MHI system error detected\n");
+				write_lock_irq(&mhi_cntrl->pm_lock);
+				new_state = mhi_tryset_pm_state(mhi_cntrl,
+							MHI_PM_SYS_ERR_DETECT);
+				write_unlock_irq(&mhi_cntrl->pm_lock);
+				if (new_state == MHI_PM_SYS_ERR_DETECT)
+					schedule_work(
+						&mhi_cntrl->syserr_worker);
+				break;
+			}
+			default:
+				dev_err(mhi_cntrl->dev, "Unsupported STE:%s\n",
+					TO_MHI_STATE_STR(new_state));
+			}
+
+			break;
+		}
+		case MHI_PKT_TYPE_CMD_COMPLETION_EVENT:
+			break;
+		case MHI_PKT_TYPE_EE_EVENT:
+		{
+			enum MHI_ST_TRANSITION st = MHI_ST_TRANSITION_MAX;
+			enum MHI_EE event = MHI_TRE_GET_EV_EXECENV(local_rp);
+
+			dev_info(mhi_cntrl->dev, "MHI EE received event:%s\n",
+				 TO_MHI_EXEC_STR(event));
+			switch (event) {
+			case MHI_EE_SBL:
+				st = MHI_ST_TRANSITION_SBL;
+				break;
+			case MHI_EE_AMSS:
+				st = MHI_ST_TRANSITION_AMSS;
+				break;
+			case MHI_EE_RDDM:
+				mhi_cntrl->status_cb(mhi_cntrl,
+						     mhi_cntrl->priv_data,
+						     MHI_CB_EE_RDDM);
+				/* fall thru to wake up the event */
+			case MHI_EE_BHIE:
+				write_lock_irq(&mhi_cntrl->pm_lock);
+				mhi_cntrl->ee = event;
+				write_unlock_irq(&mhi_cntrl->pm_lock);
+				wake_up(&mhi_cntrl->state_event);
+				break;
+			default:
+				dev_err(mhi_cntrl->dev, "Unhandled EE event\n");
+			}
+			if (st != MHI_ST_TRANSITION_MAX)
+				mhi_queue_state_transition(mhi_cntrl, st);
+
+			break;
+		}
+		default:
+			break;
+		}
+
+		mhi_recycle_ev_ring_element(mhi_cntrl, ev_ring);
+		local_rp = ev_ring->rp;
+		dev_rp = mhi_to_virtual(ev_ring, er_ctxt->rp);
+		count++;
+	}
+
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl->pm_state)))
+		mhi_ring_er_db(mhi_event);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	return count;
 }
 
 int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
@@ -119,4 +522,127 @@ void mhi_ev_task(unsigned long data)
 
 void mhi_ctrl_ev_task(unsigned long data)
 {
+	struct mhi_event *mhi_event = (struct mhi_event *)data;
+	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
+	enum MHI_STATE state = MHI_STATE_MAX;
+	enum MHI_PM_STATE pm_state = 0;
+	int ret;
+
+	/* process ctrl events events */
+	ret = mhi_event->process_event(mhi_cntrl, mhi_event, U32_MAX);
+
+	/*
+	 * we received a MSI but no events to process maybe device went to
+	 * SYS_ERR state, check the state
+	 */
+	if (!ret) {
+		write_lock_irq(&mhi_cntrl->pm_lock);
+		if (MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state))
+			state = mhi_get_m_state(mhi_cntrl);
+		if (state == MHI_STATE_SYS_ERR) {
+			dev_info(mhi_cntrl->dev, "MHI system error detected\n");
+			pm_state = mhi_tryset_pm_state(mhi_cntrl,
+						       MHI_PM_SYS_ERR_DETECT);
+		}
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		if (pm_state == MHI_PM_SYS_ERR_DETECT)
+			schedule_work(&mhi_cntrl->syserr_worker);
+	}
+}
+
+irqreturn_t mhi_msi_handlr(int irq_number, void *dev)
+{
+	struct mhi_event *mhi_event = dev;
+	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
+	struct mhi_event_ctxt *er_ctxt =
+		&mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
+	struct mhi_ring *ev_ring = &mhi_event->ring;
+	void *dev_rp = mhi_to_virtual(ev_ring, er_ctxt->rp);
+
+	/* confirm ER has pending events to process before scheduling work */
+	if (ev_ring->rp == dev_rp)
+		return IRQ_HANDLED;
+
+	/* client managed event ring, notify pending data */
+	if (mhi_event->cl_manage) {
+		struct mhi_chan *mhi_chan = mhi_event->mhi_chan;
+		struct mhi_device *mhi_dev = mhi_chan->mhi_dev;
+
+		if (mhi_dev)
+			mhi_dev->status_cb(mhi_dev, MHI_CB_PENDING_DATA);
+	} else
+		tasklet_schedule(&mhi_event->task);
+
+	return IRQ_HANDLED;
+}
+
+/* this is the threaded fn */
+irqreturn_t mhi_intvec_threaded_handlr(int irq_number, void *dev)
+{
+	struct mhi_controller *mhi_cntrl = dev;
+	enum MHI_STATE state = MHI_STATE_MAX;
+	enum MHI_PM_STATE pm_state = 0;
+
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	if (MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state))
+		state = mhi_get_m_state(mhi_cntrl);
+	if (state == MHI_STATE_SYS_ERR) {
+		dev_info(mhi_cntrl->dev, "MHI system error detected\n");
+		pm_state = mhi_tryset_pm_state(mhi_cntrl,
+					       MHI_PM_SYS_ERR_DETECT);
+	}
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+	if (pm_state == MHI_PM_SYS_ERR_DETECT)
+		schedule_work(&mhi_cntrl->syserr_worker);
+
+	return IRQ_HANDLED;
+}
+
+irqreturn_t mhi_intvec_handlr(int irq_number, void *dev)
+{
+
+	struct mhi_controller *mhi_cntrl = dev;
+
+	/* wake up any events waiting for state change */
+	wake_up(&mhi_cntrl->state_event);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static int __mhi_bdf_to_controller(struct device *dev, void *tmp)
+{
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+	struct mhi_device *match = tmp;
+
+	/* return any none-zero value if match */
+	if (mhi_dev->dev_type == MHI_CONTROLLER_TYPE &&
+	    mhi_dev->domain == match->domain && mhi_dev->bus == match->bus &&
+	    mhi_dev->slot == match->slot && mhi_dev->dev_id == match->dev_id)
+		return 1;
+
+	return 0;
+}
+
+struct mhi_controller *mhi_bdf_to_controller(u32 domain,
+					     u32 bus,
+					     u32 slot,
+					     u32 dev_id)
+{
+	struct mhi_device tmp, *mhi_dev;
+	struct device *dev;
+
+	tmp.domain = domain;
+	tmp.bus = bus;
+	tmp.slot = slot;
+	tmp.dev_id = dev_id;
+
+	dev = bus_find_device(&mhi_bus_type, NULL, &tmp,
+			      __mhi_bdf_to_controller);
+	if (!dev)
+		return NULL;
+
+	mhi_dev = to_mhi_device(dev);
+
+	return mhi_dev->mhi_cntrl;
 }
+EXPORT_SYMBOL(mhi_bdf_to_controller);
diff --git a/drivers/bus/mhi/core/mhi_pm.c b/drivers/bus/mhi/core/mhi_pm.c
new file mode 100644
index 0000000..5220cfa
--- /dev/null
+++ b/drivers/bus/mhi/core/mhi_pm.c
@@ -0,0 +1,1027 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ *
+ */
+
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/of.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
+#include <linux/mhi.h>
+#include "mhi_internal.h"
+
+/*
+ * Not all MHI states transitions are sync transitions. Linkdown, SSR, and
+ * shutdown can happen anytime asynchronously. This function will transition to
+ * new state only if we're allowed to transitions.
+ *
+ * Priority increase as we go down, example while in any states from L0, start
+ * state from L1, L2, or L3 can be set.  Notable exception to this rule is state
+ * DISABLE.  From DISABLE state we can transition to only POR or state.  Also
+ * for example while in L2 state, user cannot jump back to L1 or L0 states.
+ * Valid transitions:
+ * L0: DISABLE <--> POR
+ *     POR <--> POR
+ *     POR -> M0 -> M2 --> M0
+ *     POR -> FW_DL_ERR
+ *     FW_DL_ERR <--> FW_DL_ERR
+ *     M0 -> FW_DL_ERR
+ *     M0 -> M3_ENTER -> M3 -> M3_EXIT --> M0
+ * L1: SYS_ERR_DETECT -> SYS_ERR_PROCESS --> POR
+ * L2: SHUTDOWN_PROCESS -> DISABLE
+ * L3: LD_ERR_FATAL_DETECT <--> LD_ERR_FATAL_DETECT
+ *     LD_ERR_FATAL_DETECT -> SHUTDOWN_PROCESS
+ */
+static struct mhi_pm_transitions const mhi_state_transitions[] = {
+	/* L0 States */
+	{
+		MHI_PM_DISABLE,
+		MHI_PM_POR
+	},
+	{
+		MHI_PM_POR,
+		MHI_PM_POR | MHI_PM_DISABLE | MHI_PM_M0 |
+		MHI_PM_SYS_ERR_DETECT | MHI_PM_SHUTDOWN_PROCESS |
+		MHI_PM_LD_ERR_FATAL_DETECT | MHI_PM_FW_DL_ERR
+	},
+	{
+		MHI_PM_M0,
+		MHI_PM_M2 | MHI_PM_M3_ENTER | MHI_PM_SYS_ERR_DETECT |
+		MHI_PM_SHUTDOWN_PROCESS | MHI_PM_LD_ERR_FATAL_DETECT |
+		MHI_PM_FW_DL_ERR
+	},
+	{
+		MHI_PM_M2,
+		MHI_PM_M0 | MHI_PM_SYS_ERR_DETECT | MHI_PM_SHUTDOWN_PROCESS |
+		MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	{
+		MHI_PM_M3_ENTER,
+		MHI_PM_M3 | MHI_PM_SYS_ERR_DETECT | MHI_PM_SHUTDOWN_PROCESS |
+		MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	{
+		MHI_PM_M3,
+		MHI_PM_M3_EXIT | MHI_PM_SYS_ERR_DETECT |
+		MHI_PM_SHUTDOWN_PROCESS | MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	{
+		MHI_PM_M3_EXIT,
+		MHI_PM_M0 | MHI_PM_SYS_ERR_DETECT | MHI_PM_SHUTDOWN_PROCESS |
+		MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	{
+		MHI_PM_FW_DL_ERR,
+		MHI_PM_FW_DL_ERR | MHI_PM_SYS_ERR_DETECT |
+		MHI_PM_SHUTDOWN_PROCESS | MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	/* L1 States */
+	{
+		MHI_PM_SYS_ERR_DETECT,
+		MHI_PM_SYS_ERR_PROCESS | MHI_PM_SHUTDOWN_PROCESS |
+		MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	{
+		MHI_PM_SYS_ERR_PROCESS,
+		MHI_PM_POR | MHI_PM_SHUTDOWN_PROCESS |
+		MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	/* L2 States */
+	{
+		MHI_PM_SHUTDOWN_PROCESS,
+		MHI_PM_DISABLE | MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	/* L3 States */
+	{
+		MHI_PM_LD_ERR_FATAL_DETECT,
+		MHI_PM_LD_ERR_FATAL_DETECT | MHI_PM_SHUTDOWN_PROCESS
+	},
+};
+
+enum MHI_PM_STATE __must_check mhi_tryset_pm_state(
+				struct mhi_controller *mhi_cntrl,
+				enum MHI_PM_STATE state)
+{
+	unsigned long cur_state = mhi_cntrl->pm_state;
+	int index = find_last_bit(&cur_state, 32);
+
+	if (unlikely(index >= ARRAY_SIZE(mhi_state_transitions)))
+		return cur_state;
+
+	if (unlikely(mhi_state_transitions[index].from_state != cur_state))
+		return cur_state;
+
+	if (unlikely(!(mhi_state_transitions[index].to_states & state)))
+		return cur_state;
+
+	mhi_cntrl->pm_state = state;
+	return mhi_cntrl->pm_state;
+}
+
+void mhi_set_mhi_state(struct mhi_controller *mhi_cntrl, enum MHI_STATE state)
+{
+	if (state == MHI_STATE_RESET) {
+		mhi_write_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
+				    MHICTRL_RESET_MASK, MHICTRL_RESET_SHIFT, 1);
+	} else {
+		mhi_write_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
+			MHICTRL_MHISTATE_MASK, MHICTRL_MHISTATE_SHIFT, state);
+	}
+}
+
+/* set device wake */
+void mhi_assert_dev_wake(struct mhi_controller *mhi_cntrl, bool force)
+{
+	unsigned long flags;
+
+	/* if set, regardless of count set the bit if not set */
+	if (unlikely(force)) {
+		spin_lock_irqsave(&mhi_cntrl->wlock, flags);
+		atomic_inc(&mhi_cntrl->dev_wake);
+		if (MHI_WAKE_DB_FORCE_SET_VALID(mhi_cntrl->pm_state) &&
+		    !mhi_cntrl->wake_set) {
+			mhi_write_db(mhi_cntrl, mhi_cntrl->wake_db, 1);
+			mhi_cntrl->wake_set = true;
+		}
+		spin_unlock_irqrestore(&mhi_cntrl->wlock, flags);
+	} else {
+		/* if resources requested already, then increment and exit */
+		if (likely(atomic_add_unless(&mhi_cntrl->dev_wake, 1, 0)))
+			return;
+
+		spin_lock_irqsave(&mhi_cntrl->wlock, flags);
+		if ((atomic_inc_return(&mhi_cntrl->dev_wake) == 1) &&
+		    MHI_WAKE_DB_SET_VALID(mhi_cntrl->pm_state) &&
+		    !mhi_cntrl->wake_set) {
+			mhi_write_db(mhi_cntrl, mhi_cntrl->wake_db, 1);
+			mhi_cntrl->wake_set = true;
+		}
+		spin_unlock_irqrestore(&mhi_cntrl->wlock, flags);
+	}
+}
+
+/* clear device wake */
+void mhi_deassert_dev_wake(struct mhi_controller *mhi_cntrl, bool override)
+{
+	unsigned long flags;
+
+	/* resources not dropping to 0, decrement and exit */
+	if (likely(atomic_add_unless(&mhi_cntrl->dev_wake, -1, 1)))
+		return;
+
+	spin_lock_irqsave(&mhi_cntrl->wlock, flags);
+	if ((atomic_dec_return(&mhi_cntrl->dev_wake) == 0) &&
+	    MHI_WAKE_DB_CLEAR_VALID(mhi_cntrl->pm_state) && !override &&
+	    mhi_cntrl->wake_set) {
+		mhi_write_db(mhi_cntrl, mhi_cntrl->wake_db, 0);
+		mhi_cntrl->wake_set = false;
+	}
+	spin_unlock_irqrestore(&mhi_cntrl->wlock, flags);
+}
+
+int mhi_ready_state_transition(struct mhi_controller *mhi_cntrl)
+{
+	void __iomem *base = mhi_cntrl->regs;
+	u32 reset = 1, ready = 0;
+	struct mhi_event *mhi_event;
+	enum MHI_PM_STATE cur_state;
+	int ret, i;
+
+	/* wait for RESET to be cleared and READY bit to be set */
+	wait_event_timeout(mhi_cntrl->state_event,
+			   MHI_PM_IN_FATAL_STATE(mhi_cntrl->pm_state) ||
+			   mhi_read_reg_field(mhi_cntrl, base, MHICTRL,
+					      MHICTRL_RESET_MASK,
+					      MHICTRL_RESET_SHIFT, &reset) ||
+			   mhi_read_reg_field(mhi_cntrl, base, MHISTATUS,
+					      MHISTATUS_READY_MASK,
+					      MHISTATUS_READY_SHIFT, &ready) ||
+			   (!reset && ready),
+			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	/* device enter into error state */
+	if (MHI_PM_IN_FATAL_STATE(mhi_cntrl->pm_state))
+		return -EIO;
+
+	/* device did not transition to ready state */
+	if (reset || !ready)
+		return -ETIMEDOUT;
+
+	dev_info(mhi_cntrl->dev, "Device in READY State\n");
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	cur_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_POR);
+	mhi_cntrl->dev_state = MHI_STATE_READY;
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+
+	if (cur_state != MHI_PM_POR) {
+		dev_err(mhi_cntrl->dev, "Error moving to state %s from %s\n",
+			to_mhi_pm_state_str(MHI_PM_POR),
+			to_mhi_pm_state_str(cur_state));
+		return -EIO;
+	}
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state))
+		goto error_mmio;
+
+	ret = mhi_init_mmio(mhi_cntrl);
+	if (ret) {
+		dev_err(mhi_cntrl->dev, "Error programming mmio registers\n");
+		goto error_mmio;
+	}
+
+	/* add elements to all sw event rings */
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		struct mhi_ring *ring = &mhi_event->ring;
+
+		if (mhi_event->offload_ev || mhi_event->hw_ring)
+			continue;
+
+		ring->wp = ring->base + ring->len - ring->el_size;
+		*ring->ctxt_wp = ring->iommu_base + ring->len - ring->el_size;
+		/* needs to update to all cores */
+		smp_wmb();
+
+		/* ring the db for event rings */
+		spin_lock_irq(&mhi_event->lock);
+		mhi_ring_er_db(mhi_event);
+		spin_unlock_irq(&mhi_event->lock);
+	}
+
+	/* set device into M0 state */
+	mhi_set_mhi_state(mhi_cntrl, MHI_STATE_M0);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	return 0;
+
+error_mmio:
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	return -EIO;
+}
+
+int mhi_pm_m0_transition(struct mhi_controller *mhi_cntrl)
+{
+	enum MHI_PM_STATE cur_state;
+	struct mhi_chan *mhi_chan;
+	int i;
+
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	mhi_cntrl->dev_state = MHI_STATE_M0;
+	cur_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_M0);
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+	if (unlikely(cur_state != MHI_PM_M0))
+		return -EIO;
+
+	mhi_cntrl->M0++;
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_cntrl->wake_get(mhi_cntrl, false);
+
+	/* ring all event rings and CMD ring only if we're in AMSS */
+	if (mhi_cntrl->ee == MHI_EE_AMSS) {
+		struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
+		struct mhi_cmd *mhi_cmd =
+			&mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING];
+
+		for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+			if (mhi_event->offload_ev)
+				continue;
+
+			spin_lock_irq(&mhi_event->lock);
+			mhi_ring_er_db(mhi_event);
+			spin_unlock_irq(&mhi_event->lock);
+		}
+
+		/* only ring primary cmd ring */
+		spin_lock_irq(&mhi_cmd->lock);
+		if (mhi_cmd->ring.rp != mhi_cmd->ring.wp)
+			mhi_ring_cmd_db(mhi_cntrl, mhi_cmd);
+		spin_unlock_irq(&mhi_cmd->lock);
+	}
+
+	/* ring channel db registers */
+	mhi_chan = mhi_cntrl->mhi_chan;
+	for (i = 0; i < mhi_cntrl->max_chan; i++, mhi_chan++) {
+		struct mhi_ring *tre_ring = &mhi_chan->tre_ring;
+
+		write_lock_irq(&mhi_chan->lock);
+		if (mhi_chan->db_cfg.reset_req)
+			mhi_chan->db_cfg.db_mode = true;
+
+		/* only ring DB if ring is not empty */
+		if (tre_ring->base && tre_ring->wp  != tre_ring->rp)
+			mhi_ring_chan_db(mhi_cntrl, mhi_chan);
+		write_unlock_irq(&mhi_chan->lock);
+	}
+
+	mhi_cntrl->wake_put(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+	wake_up(&mhi_cntrl->state_event);
+
+	return 0;
+}
+
+void mhi_pm_m1_transition(struct mhi_controller *mhi_cntrl)
+{
+	enum MHI_PM_STATE state;
+
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	/* if it fails, means we transition to M3 */
+	state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_M2);
+	if (state == MHI_PM_M2) {
+		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_M2);
+		mhi_cntrl->dev_state = MHI_STATE_M2;
+		mhi_cntrl->M2++;
+
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+
+		/* transfer pending, exit M2 immediately */
+		if (unlikely(atomic_read(&mhi_cntrl->dev_wake))) {
+			read_lock_bh(&mhi_cntrl->pm_lock);
+			mhi_cntrl->wake_get(mhi_cntrl, true);
+			mhi_cntrl->wake_put(mhi_cntrl, false);
+			read_unlock_bh(&mhi_cntrl->pm_lock);
+		} else {
+			mhi_cntrl->status_cb(mhi_cntrl, mhi_cntrl->priv_data,
+					     MHI_CB_IDLE);
+		}
+	} else {
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+	}
+}
+
+int mhi_pm_m3_transition(struct mhi_controller *mhi_cntrl)
+{
+	enum MHI_PM_STATE state;
+
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	mhi_cntrl->dev_state = MHI_STATE_M3;
+	state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_M3);
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+	if (state != MHI_PM_M3)
+		return -EIO;
+
+	wake_up(&mhi_cntrl->state_event);
+	mhi_cntrl->M3++;
+
+	return 0;
+}
+
+static int mhi_pm_amss_transition(struct mhi_controller *mhi_cntrl)
+{
+	int i;
+	struct mhi_event *mhi_event;
+
+	dev_info(mhi_cntrl->dev, "Processing AMSS Transition\n");
+
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	mhi_cntrl->ee = MHI_EE_AMSS;
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+	wake_up(&mhi_cntrl->state_event);
+
+	/* add elements to all HW event rings */
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		read_unlock_bh(&mhi_cntrl->pm_lock);
+		return -EIO;
+	}
+
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		struct mhi_ring *ring = &mhi_event->ring;
+
+		if (mhi_event->offload_ev || !mhi_event->hw_ring)
+			continue;
+
+		ring->wp = ring->base + ring->len - ring->el_size;
+		*ring->ctxt_wp = ring->iommu_base + ring->len - ring->el_size;
+		/* all ring updates must get updated immediately */
+		smp_wmb();
+
+		spin_lock_irq(&mhi_event->lock);
+		if (MHI_DB_ACCESS_VALID(mhi_cntrl->pm_state))
+			mhi_ring_er_db(mhi_event);
+		spin_unlock_irq(&mhi_event->lock);
+
+	}
+
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	/* add supported devices */
+	mhi_create_devices(mhi_cntrl);
+
+	return 0;
+}
+
+/* handles both sys_err and shutdown transitions */
+static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl,
+				      enum MHI_PM_STATE transition_state)
+{
+	enum MHI_PM_STATE cur_state, prev_state;
+	struct mhi_event *mhi_event;
+	struct mhi_cmd_ctxt *cmd_ctxt;
+	struct mhi_cmd *mhi_cmd;
+	struct mhi_event_ctxt *er_ctxt;
+	int ret, i;
+
+	dev_info(mhi_cntrl->dev,
+		 "Enter with from pm_state:%s MHI_STATE:%s to pm_state:%s\n",
+		 to_mhi_pm_state_str(mhi_cntrl->pm_state),
+		 TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+		 to_mhi_pm_state_str(transition_state));
+
+	mutex_lock(&mhi_cntrl->pm_mutex);
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	prev_state = mhi_cntrl->pm_state;
+	cur_state = mhi_tryset_pm_state(mhi_cntrl, transition_state);
+	if (cur_state == transition_state) {
+		mhi_cntrl->ee = MHI_EE_DISABLE_TRANSITION;
+		mhi_cntrl->dev_state = MHI_STATE_RESET;
+	}
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+
+	/* not handling sys_err, could be middle of shut down */
+	if (cur_state != transition_state) {
+		dev_info(mhi_cntrl->dev,
+			 "Failed to transition to state:0x%x from:0x%x\n",
+			 transition_state, cur_state);
+		mutex_unlock(&mhi_cntrl->pm_mutex);
+		return;
+	}
+
+	/* trigger MHI RESET so device will not access host ddr */
+	if (MHI_REG_ACCESS_VALID(prev_state)) {
+		u32 in_reset = -1;
+		unsigned long timeout = msecs_to_jiffies(mhi_cntrl->timeout_ms);
+
+		dev_info(mhi_cntrl->dev, "Trigger device into MHI_RESET\n");
+		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_RESET);
+
+		/* wait for reset to be cleared */
+		ret = wait_event_timeout(mhi_cntrl->state_event,
+					 mhi_read_reg_field(mhi_cntrl,
+						mhi_cntrl->regs, MHICTRL,
+						MHICTRL_RESET_MASK,
+						MHICTRL_RESET_SHIFT, &in_reset)
+					 || !in_reset, timeout);
+		if ((!ret || in_reset) && cur_state == MHI_PM_SYS_ERR_PROCESS) {
+			dev_err(mhi_cntrl->dev,
+				"Device failed to exit RESET state\n");
+			mutex_unlock(&mhi_cntrl->pm_mutex);
+			return;
+		}
+
+		/*
+		 * device cleares INTVEC as part of RESET processing,
+		 * re-program it
+		 */
+		mhi_write_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_INTVEC, 0);
+	}
+
+	dev_info(mhi_cntrl->dev,
+		 "Waiting for all pending event ring processing to complete\n");
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		if (mhi_event->offload_ev)
+			continue;
+		tasklet_kill(&mhi_event->task);
+	}
+
+	dev_info(mhi_cntrl->dev,
+		 "Reset all active channels and remove mhi devices\n");
+	device_for_each_child(mhi_cntrl->dev, NULL, mhi_destroy_device);
+
+	dev_info(mhi_cntrl->dev, "Finish resetting channels\n");
+
+	/* release lock and wait for all pending thread to complete */
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+	dev_info(mhi_cntrl->dev,
+		 "Waiting for all pending threads to complete\n");
+	wake_up(&mhi_cntrl->state_event);
+	flush_work(&mhi_cntrl->st_worker);
+	flush_work(&mhi_cntrl->fw_worker);
+
+	mutex_lock(&mhi_cntrl->pm_mutex);
+
+	/* reset the ev rings and cmd rings */
+	dev_info(mhi_cntrl->dev, "Resetting EV CTXT and CMD CTXT\n");
+	mhi_cmd = mhi_cntrl->mhi_cmd;
+	cmd_ctxt = mhi_cntrl->mhi_ctxt->cmd_ctxt;
+	for (i = 0; i < NR_OF_CMD_RINGS; i++, mhi_cmd++, cmd_ctxt++) {
+		struct mhi_ring *ring = &mhi_cmd->ring;
+
+		ring->rp = ring->base;
+		ring->wp = ring->base;
+		cmd_ctxt->rp = cmd_ctxt->rbase;
+		cmd_ctxt->wp = cmd_ctxt->rbase;
+	}
+
+	mhi_event = mhi_cntrl->mhi_event;
+	er_ctxt = mhi_cntrl->mhi_ctxt->er_ctxt;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, er_ctxt++,
+		     mhi_event++) {
+		struct mhi_ring *ring = &mhi_event->ring;
+
+		/* do not touch offload er */
+		if (mhi_event->offload_ev)
+			continue;
+
+		ring->rp = ring->base;
+		ring->wp = ring->base;
+		er_ctxt->rp = er_ctxt->rbase;
+		er_ctxt->wp = er_ctxt->rbase;
+	}
+
+	if (cur_state == MHI_PM_SYS_ERR_PROCESS) {
+		mhi_ready_state_transition(mhi_cntrl);
+	} else {
+		/* move to disable state */
+		write_lock_irq(&mhi_cntrl->pm_lock);
+		cur_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_DISABLE);
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		if (unlikely(cur_state != MHI_PM_DISABLE))
+			dev_err(mhi_cntrl->dev,
+				"Error moving from pm state:%s to state:%s\n",
+				to_mhi_pm_state_str(cur_state),
+				to_mhi_pm_state_str(MHI_PM_DISABLE));
+	}
+
+	dev_info(mhi_cntrl->dev, "Exit with pm_state:%s mhi_state:%s\n",
+		 to_mhi_pm_state_str(mhi_cntrl->pm_state),
+		 TO_MHI_STATE_STR(mhi_cntrl->dev_state));
+
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+}
+
+/* queue a new work item and scheduler work */
+int mhi_queue_state_transition(struct mhi_controller *mhi_cntrl,
+			       enum MHI_ST_TRANSITION state)
+{
+	struct state_transition *item = kmalloc(sizeof(*item), GFP_ATOMIC);
+	unsigned long flags;
+
+	if (!item)
+		return -ENOMEM;
+
+	item->state = state;
+	spin_lock_irqsave(&mhi_cntrl->transition_lock, flags);
+	list_add_tail(&item->node, &mhi_cntrl->transition_list);
+	spin_unlock_irqrestore(&mhi_cntrl->transition_lock, flags);
+
+	schedule_work(&mhi_cntrl->st_worker);
+
+	return 0;
+}
+
+void mhi_pm_sys_err_worker(struct work_struct *work)
+{
+	struct mhi_controller *mhi_cntrl = container_of(work,
+							struct mhi_controller,
+							syserr_worker);
+
+	mhi_pm_disable_transition(mhi_cntrl, MHI_PM_SYS_ERR_PROCESS);
+}
+
+void mhi_pm_st_worker(struct work_struct *work)
+{
+	struct state_transition *itr, *tmp;
+	LIST_HEAD(head);
+	struct mhi_controller *mhi_cntrl = container_of(work,
+							struct mhi_controller,
+							st_worker);
+	spin_lock_irq(&mhi_cntrl->transition_lock);
+	list_splice_tail_init(&mhi_cntrl->transition_list, &head);
+	spin_unlock_irq(&mhi_cntrl->transition_lock);
+
+	list_for_each_entry_safe(itr, tmp, &head, node) {
+		list_del(&itr->node);
+		dev_info(mhi_cntrl->dev, "Transition to state:%s\n",
+			 TO_MHI_STATE_TRANS_STR(itr->state));
+
+		switch (itr->state) {
+		case MHI_ST_TRANSITION_PBL:
+			write_lock_irq(&mhi_cntrl->pm_lock);
+			if (MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state))
+				mhi_cntrl->ee = mhi_get_exec_env(mhi_cntrl);
+			write_unlock_irq(&mhi_cntrl->pm_lock);
+			if (MHI_IN_PBL(mhi_cntrl->ee))
+				wake_up(&mhi_cntrl->state_event);
+			break;
+		case MHI_ST_TRANSITION_SBL:
+			write_lock_irq(&mhi_cntrl->pm_lock);
+			mhi_cntrl->ee = MHI_EE_SBL;
+			write_unlock_irq(&mhi_cntrl->pm_lock);
+			mhi_create_devices(mhi_cntrl);
+			break;
+		case MHI_ST_TRANSITION_AMSS:
+			mhi_pm_amss_transition(mhi_cntrl);
+			break;
+		case MHI_ST_TRANSITION_READY:
+			mhi_ready_state_transition(mhi_cntrl);
+			break;
+		default:
+			break;
+		}
+		kfree(itr);
+	}
+}
+
+int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
+{
+	int ret;
+	u32 val;
+	enum MHI_EE current_ee;
+	enum MHI_ST_TRANSITION next_state;
+
+	dev_info(mhi_cntrl->dev, "Requested to power on\n");
+
+	if (mhi_cntrl->msi_allocated < mhi_cntrl->total_ev_rings)
+		return -EINVAL;
+
+	/* set to default wake if not set */
+	if (!mhi_cntrl->wake_get || !mhi_cntrl->wake_put) {
+		mhi_cntrl->wake_get = mhi_assert_dev_wake;
+		mhi_cntrl->wake_put = mhi_deassert_dev_wake;
+	}
+
+	mutex_lock(&mhi_cntrl->pm_mutex);
+	mhi_cntrl->pm_state = MHI_PM_DISABLE;
+
+	if (!mhi_cntrl->pre_init) {
+		/* setup device context */
+		ret = mhi_init_dev_ctxt(mhi_cntrl);
+		if (ret)
+			goto error_dev_ctxt;
+
+		ret = mhi_init_irq_setup(mhi_cntrl);
+		if (ret)
+			goto error_setup_irq;
+	}
+
+	/* setup bhi offset & intvec */
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, BHIOFF, &val);
+	if (ret) {
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		goto error_bhi_offset;
+	}
+
+	mhi_cntrl->bhi = mhi_cntrl->regs + val;
+
+	/* setup bhie offset */
+	if (mhi_cntrl->fbc_download) {
+		ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, BHIEOFF, &val);
+		if (ret) {
+			write_unlock_irq(&mhi_cntrl->pm_lock);
+			dev_err(mhi_cntrl->dev, "Error reading BHIE offset\n");
+			goto error_bhi_offset;
+		}
+
+		mhi_cntrl->bhie = mhi_cntrl->regs + val;
+	}
+
+	mhi_write_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_INTVEC, 0);
+	mhi_cntrl->pm_state = MHI_PM_POR;
+	mhi_cntrl->ee = MHI_EE_MAX;
+	current_ee = mhi_get_exec_env(mhi_cntrl);
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+
+	/* confirm device is in valid exec env */
+	if (!MHI_IN_PBL(current_ee) && current_ee != MHI_EE_AMSS) {
+		dev_info(mhi_cntrl->dev, "Not a valid ee for power on\n");
+		ret = -EIO;
+		goto error_bhi_offset;
+	}
+
+	/* transition to next state */
+	next_state = MHI_IN_PBL(current_ee) ?
+		MHI_ST_TRANSITION_PBL : MHI_ST_TRANSITION_READY;
+
+	if (next_state == MHI_ST_TRANSITION_PBL)
+		schedule_work(&mhi_cntrl->fw_worker);
+
+	mhi_queue_state_transition(mhi_cntrl, next_state);
+
+	mhi_init_debugfs(mhi_cntrl);
+
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+
+	dev_info(mhi_cntrl->dev, "Power on setup success\n");
+
+	return 0;
+
+error_bhi_offset:
+	if (!mhi_cntrl->pre_init)
+		mhi_deinit_free_irq(mhi_cntrl);
+
+error_setup_irq:
+	if (!mhi_cntrl->pre_init)
+		mhi_deinit_dev_ctxt(mhi_cntrl);
+
+error_dev_ctxt:
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL(mhi_async_power_up);
+
+void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
+{
+	enum MHI_PM_STATE cur_state;
+
+	/* if it's not graceful shutdown, force MHI to a linkdown state */
+	if (!graceful) {
+		mutex_lock(&mhi_cntrl->pm_mutex);
+		write_lock_irq(&mhi_cntrl->pm_lock);
+		cur_state = mhi_tryset_pm_state(mhi_cntrl,
+						MHI_PM_LD_ERR_FATAL_DETECT);
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		mutex_unlock(&mhi_cntrl->pm_mutex);
+		if (cur_state != MHI_PM_LD_ERR_FATAL_DETECT)
+			dev_info(mhi_cntrl->dev,
+			"Failed to move to state:%s from:%s\n",
+			to_mhi_pm_state_str(MHI_PM_LD_ERR_FATAL_DETECT),
+			to_mhi_pm_state_str(mhi_cntrl->pm_state));
+	}
+	mhi_pm_disable_transition(mhi_cntrl, MHI_PM_SHUTDOWN_PROCESS);
+
+	mhi_deinit_debugfs(mhi_cntrl);
+
+	if (!mhi_cntrl->pre_init) {
+		/* free all allocated resources */
+		if (mhi_cntrl->fbc_image) {
+			mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->fbc_image);
+			mhi_cntrl->fbc_image = NULL;
+		}
+		mhi_deinit_free_irq(mhi_cntrl);
+		mhi_deinit_dev_ctxt(mhi_cntrl);
+	}
+}
+EXPORT_SYMBOL(mhi_power_down);
+
+int mhi_sync_power_up(struct mhi_controller *mhi_cntrl)
+{
+	int ret = mhi_async_power_up(mhi_cntrl);
+
+	if (ret)
+		return ret;
+
+	wait_event_timeout(mhi_cntrl->state_event,
+			   mhi_cntrl->ee == MHI_EE_AMSS ||
+			   MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
+			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	return (mhi_cntrl->ee == MHI_EE_AMSS) ? 0 : -EIO;
+}
+EXPORT_SYMBOL(mhi_sync_power_up);
+
+int mhi_pm_suspend(struct mhi_controller *mhi_cntrl)
+{
+	int ret;
+	enum MHI_PM_STATE new_state;
+	struct mhi_chan *itr, *tmp;
+
+	if (mhi_cntrl->pm_state == MHI_PM_DISABLE)
+		return -EINVAL;
+
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))
+		return -EIO;
+
+	/* do a quick check to see if any pending data, then exit */
+	if (atomic_read(&mhi_cntrl->dev_wake))
+		return -EBUSY;
+
+	/* exit MHI out of M2 state */
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_cntrl->wake_get(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+				 mhi_cntrl->dev_state == MHI_STATE_M0 ||
+				 mhi_cntrl->dev_state == MHI_STATE_M1 ||
+				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
+				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_cntrl->wake_put(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		dev_err(mhi_cntrl->dev,
+			"Did not enter M0||M1 state, cur_state:%s pm_state:%s\n",
+			TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+			to_mhi_pm_state_str(mhi_cntrl->pm_state));
+		return -EIO;
+	}
+
+	write_lock_irq(&mhi_cntrl->pm_lock);
+
+	if (atomic_read(&mhi_cntrl->dev_wake)) {
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		return -EBUSY;
+	}
+
+	/* anytime after this, we will resume thru runtime pm framework */
+	dev_info(mhi_cntrl->dev, "Allowing M3 transition\n");
+	new_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_M3_ENTER);
+	if (new_state != MHI_PM_M3_ENTER) {
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		dev_err(mhi_cntrl->dev,
+			"Error setting to pm_state:%s from pm_state:%s\n",
+			to_mhi_pm_state_str(MHI_PM_M3_ENTER),
+			to_mhi_pm_state_str(mhi_cntrl->pm_state));
+		return -EIO;
+	}
+
+	/* set dev to M3 and wait for completion */
+	mhi_set_mhi_state(mhi_cntrl, MHI_STATE_M3);
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+	dev_info(mhi_cntrl->dev, "Wait for M3 completion\n");
+
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+				 mhi_cntrl->dev_state == MHI_STATE_M3 ||
+				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
+				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		dev_err(mhi_cntrl->dev,
+			"Did not enter M3 state, cur_state:%s pm_state:%s\n",
+			TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+			to_mhi_pm_state_str(mhi_cntrl->pm_state));
+		return -EIO;
+	}
+
+	/* notify any clients we enter lpm */
+	list_for_each_entry_safe(itr, tmp, &mhi_cntrl->lpm_chans, node) {
+		mutex_lock(&itr->mutex);
+		if (itr->mhi_dev)
+			mhi_notify(itr->mhi_dev, MHI_CB_LPM_ENTER);
+		mutex_unlock(&itr->mutex);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(mhi_pm_suspend);
+
+int mhi_pm_resume(struct mhi_controller *mhi_cntrl)
+{
+	enum MHI_PM_STATE cur_state;
+	int ret;
+	struct mhi_chan *itr, *tmp;
+
+	dev_info(mhi_cntrl->dev, "Entered with pm_state:%s dev_state:%s\n",
+		 to_mhi_pm_state_str(mhi_cntrl->pm_state),
+		 TO_MHI_STATE_STR(mhi_cntrl->dev_state));
+
+	if (mhi_cntrl->pm_state == MHI_PM_DISABLE)
+		return 0;
+
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))
+		return -EIO;
+
+	/* notify any clients we enter lpm */
+	list_for_each_entry_safe(itr, tmp, &mhi_cntrl->lpm_chans, node) {
+		mutex_lock(&itr->mutex);
+		if (itr->mhi_dev)
+			mhi_notify(itr->mhi_dev, MHI_CB_LPM_EXIT);
+		mutex_unlock(&itr->mutex);
+	}
+
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	cur_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_M3_EXIT);
+	if (cur_state != MHI_PM_M3_EXIT) {
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		dev_info(mhi_cntrl->dev,
+			 "Error setting to pm_state:%s from pm_state:%s\n",
+			 to_mhi_pm_state_str(MHI_PM_M3_EXIT),
+			 to_mhi_pm_state_str(mhi_cntrl->pm_state));
+		return -EIO;
+	}
+
+	/* set dev to M0 and wait for completion */
+	mhi_set_mhi_state(mhi_cntrl, MHI_STATE_M0);
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+				 mhi_cntrl->dev_state == MHI_STATE_M0 ||
+				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
+				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		dev_err(mhi_cntrl->dev,
+			"Did not enter M0 state, cur_state:%s pm_state:%s\n",
+			TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+			to_mhi_pm_state_str(mhi_cntrl->pm_state));
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int __mhi_device_get_sync(struct mhi_controller *mhi_cntrl)
+{
+	int ret;
+
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_cntrl->wake_get(mhi_cntrl, true);
+	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state)) {
+		mhi_cntrl->runtime_get(mhi_cntrl, mhi_cntrl->priv_data);
+		mhi_cntrl->runtime_put(mhi_cntrl, mhi_cntrl->priv_data);
+	}
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+				 mhi_cntrl->dev_state == MHI_STATE_M0 ||
+				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
+				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		read_lock_bh(&mhi_cntrl->pm_lock);
+		mhi_cntrl->wake_put(mhi_cntrl, false);
+		read_unlock_bh(&mhi_cntrl->pm_lock);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+void mhi_device_get(struct mhi_device *mhi_dev)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+
+	atomic_inc(&mhi_dev->dev_wake);
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_cntrl->wake_get(mhi_cntrl, true);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+}
+EXPORT_SYMBOL(mhi_device_get);
+
+int mhi_device_get_sync(struct mhi_device *mhi_dev)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	int ret;
+
+	ret = __mhi_device_get_sync(mhi_cntrl);
+	if (!ret)
+		atomic_inc(&mhi_dev->dev_wake);
+
+	return ret;
+}
+EXPORT_SYMBOL(mhi_device_get_sync);
+
+void mhi_device_put(struct mhi_device *mhi_dev)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+
+	atomic_dec(&mhi_dev->dev_wake);
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_cntrl->wake_put(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+}
+EXPORT_SYMBOL(mhi_device_put);
+
+int mhi_force_rddm_mode(struct mhi_controller *mhi_cntrl)
+{
+	int ret;
+
+	/* before rddm mode, we need to enter M0 state */
+	ret = __mhi_device_get_sync(mhi_cntrl);
+	if (ret)
+		return ret;
+
+	mutex_lock(&mhi_cntrl->pm_mutex);
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state))
+		goto no_reg_access;
+
+	dev_info(mhi_cntrl->dev, "Triggering SYS_ERR to force rddm state\n");
+
+	mhi_set_mhi_state(mhi_cntrl, MHI_STATE_SYS_ERR);
+	mhi_cntrl->wake_put(mhi_cntrl, false);
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+
+	/* wait for rddm event */
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+				 mhi_cntrl->ee == MHI_EE_RDDM,
+				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
+	ret = !ret ? 0 : -EIO;
+
+	return ret;
+
+no_reg_access:
+	mhi_cntrl->wake_put(mhi_cntrl, false);
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+
+	return -EIO;
+}
+EXPORT_SYMBOL(mhi_force_rddm_mode);
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index c80685e9..ed7cea8 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -10,6 +10,8 @@
 struct mhi_event;
 struct mhi_ctxt;
 struct mhi_cmd;
+struct image_info;
+struct bhi_vec_entry;
 struct mhi_buf_info;
 
 /**
@@ -53,10 +55,24 @@ enum mhi_device_type {
 };
 
 /**
+ * struct image_info - firmware and rddm table table
+ * @mhi_buf - Contain device firmware and rddm table
+ * @entries - # of entries in table
+ */
+struct image_info {
+	struct mhi_buf *mhi_buf;
+	struct bhi_vec_entry *bhi_vec;
+	u32 entries;
+};
+
+/**
  * struct mhi_controller - Master controller structure for external modem
  * @dev: Device associated with this controller
  * @of_node: DT that has MHI configuration information
  * @regs: Points to base of MHI MMIO register space
+ * @bhi: Points to base of MHI BHI register space
+ * @bhie: Points to base of MHI BHIe register space
+ * @wake_db: MHI WAKE doorbell register address
  * @dev_id: PCIe device id of the external device
  * @domain: PCIe domain the device connected to
  * @bus: PCIe bus the device assigned to
@@ -106,6 +122,9 @@ struct mhi_controller {
 
 	/* mmio base */
 	void __iomem *regs;
+	void __iomem *bhi;
+	void __iomem *bhie;
+	void __iomem *wake_db;
 
 	/* device topology */
 	u32 dev_id;
@@ -128,6 +147,8 @@ struct mhi_controller {
 	size_t seg_len;
 	u32 session_id;
 	u32 sequence_id;
+	struct image_info *fbc_image;
+	struct image_info *rddm_image;
 
 	/* physical channel config data */
 	u32 max_chan;
@@ -254,6 +275,24 @@ struct mhi_result {
 };
 
 /**
+ * struct mhi_buf - Describes the buffer
+ * @buf: cpu address for the buffer
+ * @phys_addr: physical address of the buffer
+ * @dma_addr: iommu address for the buffer
+ * @len: # of bytes
+ * @name: Buffer label, for offload channel configurations name must be:
+ * ECA - Event context array data
+ * CCA - Channel context array data
+ */
+struct mhi_buf {
+	void *buf;
+	phys_addr_t phys_addr;
+	dma_addr_t dma_addr;
+	size_t len;
+	const char *name; /* ECA, CCA */
+};
+
+/**
  * struct mhi_driver - mhi driver information
  * @id_table: NULL terminated channel ID names
  * @ul_xfer_cb: UL data transfer callback
@@ -310,6 +349,28 @@ static inline void mhi_free_controller(struct mhi_controller *mhi_cntrl)
 void mhi_driver_unregister(struct mhi_driver *mhi_drv);
 
 /**
+ * mhi_device_get - disable all low power modes
+ * Only disables lpm, does not immediately exit low power mode
+ * if controller already in a low power mode
+ * @mhi_dev: Device associated with the channels
+ */
+void mhi_device_get(struct mhi_device *mhi_dev);
+
+/**
+ * mhi_device_get_sync - disable all low power modes
+ * Synchronously disable all low power, exit low power mode if
+ * controller already in a low power state
+ * @mhi_dev: Device associated with the channels
+ */
+int mhi_device_get_sync(struct mhi_device *mhi_dev);
+
+/**
+ * mhi_device_put - re-enable low power modes
+ * @mhi_dev: Device associated with the channels
+ */
+void mhi_device_put(struct mhi_device *mhi_dev);
+
+/**
  * mhi_alloc_controller - Allocate mhi_controller structure
  * Allocate controller structure and additional data for controller
  * private data. You may get the private data pointer by calling
@@ -338,4 +399,64 @@ static inline void mhi_free_controller(struct mhi_controller *mhi_cntrl)
 struct mhi_controller *mhi_bdf_to_controller(u32 domain, u32 bus, u32 slot,
 					     u32 dev_id);
 
+/**
+ * mhi_prepare_for_power_up - Do pre-initialization before power up
+ * This is optional, call this before power up if controller do not
+ * want bus framework to automatically free any allocated memory during shutdown
+ * process.
+ * @mhi_cntrl: MHI controller
+ */
+int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl);
+
+/**
+ * mhi_async_power_up - Starts MHI power up sequence
+ * @mhi_cntrl: MHI controller
+ */
+int mhi_async_power_up(struct mhi_controller *mhi_cntrl);
+int mhi_sync_power_up(struct mhi_controller *mhi_cntrl);
+
+/**
+ * mhi_power_down - Start MHI power down sequence
+ * @mhi_cntrl: MHI controller
+ * @graceful: link is still accessible, do a graceful shutdown process otherwise
+ * we will shutdown host w/o putting device into RESET state
+ */
+void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful);
+
+/**
+ * mhi_unprepare_after_powre_down - free any allocated memory for power up
+ * @mhi_cntrl: MHI controller
+ */
+void mhi_unprepare_after_power_down(struct mhi_controller *mhi_cntrl);
+
+/**
+ * mhi_pm_suspend - Move MHI into a suspended state
+ * Transition to MHI state M3 state from M0||M1||M2 state
+ * @mhi_cntrl: MHI controller
+ */
+int mhi_pm_suspend(struct mhi_controller *mhi_cntrl);
+
+/**
+ * mhi_pm_resume - Resume MHI from suspended state
+ * Transition to MHI state M0 state from M3 state
+ * @mhi_cntrl: MHI controller
+ */
+int mhi_pm_resume(struct mhi_controller *mhi_cntrl);
+
+/**
+ * mhi_download_rddm_img - Download ramdump image from device for
+ * debugging purpose.
+ * @mhi_cntrl: MHI controller
+ * @in_panic: If we trying to capture image while in kernel panic
+ */
+int mhi_download_rddm_img(struct mhi_controller *mhi_cntrl, bool in_panic);
+
+/**
+ * mhi_force_rddm_mode - Force external device into rddm mode
+ * to collect device ramdump. This is useful if host driver assert
+ * and we need to see device state as well.
+ * @mhi_cntrl: MHI controller
+ */
+int mhi_force_rddm_mode(struct mhi_controller *mhi_cntrl);
+
 #endif /* _MHI_H_ */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

