Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BD0C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572BE2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 572BE2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933372AbeGIUOi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 16:14:38 -0400
Received: from labrats.qualcomm.com ([199.106.110.90]:6632 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933218AbeGIUOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 16:14:35 -0400
X-IronPort-AV: E=Sophos;i="5.51,330,1526367600"; 
   d="scan'208";a="39007202"
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by labrats.qualcomm.com with ESMTP; 09 Jul 2018 13:08:24 -0700
X-IronPort-AV: E=McAfee;i="5900,7806,8949"; a="192504342"
Received: from sdias-linux.qualcomm.com (HELO sdias-linux1.qualcomm.com) ([192.168.140.71])
  by ironmsg03-sd.qualcomm.com with ESMTP; 09 Jul 2018 13:08:23 -0700
Received: by sdias-linux1.qualcomm.com (Postfix, from userid 84243)
        id 7F298150B; Mon,  9 Jul 2018 13:08:23 -0700 (PDT)
From:   Sujeev Dias <sdias@codeaurora.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Sujeev Dias <sdias@codeaurora.org>,
        Tony Truong <truong@codeaurora.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
Subject: [PATCH v2 4/7] mhi_bus: core: add support for handling ioctl cmds
Date:   Mon,  9 Jul 2018 13:08:11 -0700
Message-Id: <1531166894-30984-5-git-send-email-sdias@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531166894-30984-1-git-send-email-sdias@codeaurora.org>
References: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
 <1531166894-30984-1-git-send-email-sdias@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User space clients use RS232 control signaling mechanism to
communicate call status between host and modem. Adding support
to handle ioctl commands from user space.

Signed-off-by: Sujeev Dias <sdias@codeaurora.org>
Reviewed-by: Tony Truong <truong@codeaurora.org>
Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
---
 drivers/bus/mhi/core/Makefile   |   2 +-
 drivers/bus/mhi/core/mhi_dtr.c  | 218 ++++++++++++++++++++++++++++++++++++++++
 drivers/bus/mhi/core/mhi_init.c |   8 +-
 3 files changed, 226 insertions(+), 2 deletions(-)
 create mode 100644 drivers/bus/mhi/core/mhi_dtr.c

diff --git a/drivers/bus/mhi/core/Makefile b/drivers/bus/mhi/core/Makefile
index a6015ab..a743fbf 100644
--- a/drivers/bus/mhi/core/Makefile
+++ b/drivers/bus/mhi/core/Makefile
@@ -1 +1 @@
-obj-$(CONFIG_MHI_BUS) +=mhi_init.o mhi_main.o mhi_pm.o mhi_boot.o
+obj-$(CONFIG_MHI_BUS) +=mhi_init.o mhi_main.o mhi_pm.o mhi_boot.o mhi_dtr.o
diff --git a/drivers/bus/mhi/core/mhi_dtr.c b/drivers/bus/mhi/core/mhi_dtr.c
new file mode 100644
index 0000000..5c2409b
--- /dev/null
+++ b/drivers/bus/mhi/core/mhi_dtr.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ *
+ */
+
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/of.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/termios.h>
+#include <linux/wait.h>
+#include <linux/mhi.h>
+#include "mhi_internal.h"
+
+struct __packed dtr_ctrl_msg {
+	u32 preamble;
+	u32 msg_id;
+	u32 dest_id;
+	u32 size;
+	u32 msg;
+};
+
+#define CTRL_MAGIC (0x4C525443)
+#define CTRL_MSG_DTR BIT(0)
+#define CTRL_MSG_RTS BIT(1)
+#define CTRL_MSG_DCD BIT(0)
+#define CTRL_MSG_DSR BIT(1)
+#define CTRL_MSG_RI BIT(3)
+#define CTRL_HOST_STATE (0x10)
+#define CTRL_DEVICE_STATE (0x11)
+#define CTRL_GET_CHID(dtr) (dtr->dest_id & 0xFF)
+
+static int mhi_dtr_tiocmset(struct mhi_controller *mhi_cntrl,
+			    struct mhi_device *mhi_dev,
+			    u32 tiocm)
+{
+	struct dtr_ctrl_msg *dtr_msg = NULL;
+	struct mhi_chan *dtr_chan = mhi_cntrl->dtr_dev->ul_chan;
+	spinlock_t *res_lock = &mhi_dev->dev.devres_lock;
+	u32 cur_tiocm;
+	int ret = 0;
+
+	cur_tiocm = mhi_dev->tiocm & ~(TIOCM_CD | TIOCM_DSR | TIOCM_RI);
+
+	tiocm &= (TIOCM_DTR | TIOCM_RTS);
+
+	/* state did not changed */
+	if (cur_tiocm == tiocm)
+		return 0;
+
+	mutex_lock(&dtr_chan->mutex);
+
+	dtr_msg = kzalloc(sizeof(*dtr_msg), GFP_KERNEL);
+	if (!dtr_msg) {
+		ret = -ENOMEM;
+		goto tiocm_exit;
+	}
+
+	dtr_msg->preamble = CTRL_MAGIC;
+	dtr_msg->msg_id = CTRL_HOST_STATE;
+	dtr_msg->dest_id = mhi_dev->ul_chan_id;
+	dtr_msg->size = sizeof(u32);
+	if (tiocm & TIOCM_DTR)
+		dtr_msg->msg |= CTRL_MSG_DTR;
+	if (tiocm & TIOCM_RTS)
+		dtr_msg->msg |= CTRL_MSG_RTS;
+
+	reinit_completion(&dtr_chan->completion);
+	ret = mhi_queue_transfer(mhi_cntrl->dtr_dev, DMA_TO_DEVICE, dtr_msg,
+				 sizeof(*dtr_msg), MHI_EOT);
+	if (ret)
+		goto tiocm_exit;
+
+	ret = wait_for_completion_timeout(&dtr_chan->completion,
+				msecs_to_jiffies(mhi_cntrl->timeout_ms));
+	if (!ret) {
+		dev_err(mhi_cntrl->dev, "Failed to recv transfer callback\n");
+		ret = -EIO;
+		goto tiocm_exit;
+	}
+
+	ret = 0;
+	spin_lock_irq(res_lock);
+	mhi_dev->tiocm &= ~(TIOCM_DTR | TIOCM_RTS);
+	mhi_dev->tiocm |= tiocm;
+	spin_unlock_irq(res_lock);
+
+tiocm_exit:
+	kfree(dtr_msg);
+	mutex_unlock(&dtr_chan->mutex);
+
+	return ret;
+}
+
+long mhi_ioctl(struct mhi_device *mhi_dev, unsigned int cmd, unsigned long arg)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	int ret;
+
+	/* ioctl not supported by this controller */
+	if (!mhi_cntrl->dtr_dev)
+		return -EIO;
+
+	switch (cmd) {
+	case TIOCMGET:
+		return mhi_dev->tiocm;
+	case TIOCMSET:
+	{
+		u32 tiocm;
+
+		ret = get_user(tiocm, (u32 *)arg);
+		if (ret)
+			return ret;
+
+		return mhi_dtr_tiocmset(mhi_cntrl, mhi_dev, tiocm);
+	}
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(mhi_ioctl);
+
+static void mhi_dtr_dl_xfer_cb(struct mhi_device *mhi_dev,
+			       struct mhi_result *mhi_result)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct dtr_ctrl_msg *dtr_msg = mhi_result->buf_addr;
+	u32 chan;
+	spinlock_t *res_lock;
+
+	if (mhi_result->bytes_xferd != sizeof(*dtr_msg)) {
+		dev_err(mhi_cntrl->dev, "Unexpected length %zu received\n",
+			mhi_result->bytes_xferd);
+		return;
+	}
+
+	chan = CTRL_GET_CHID(dtr_msg);
+	if (chan >= mhi_cntrl->max_chan)
+		return;
+
+	mhi_dev = mhi_cntrl->mhi_chan[chan].mhi_dev;
+	if (!mhi_dev)
+		return;
+
+	res_lock = &mhi_dev->dev.devres_lock;
+	spin_lock_irq(res_lock);
+	mhi_dev->tiocm &= ~(TIOCM_CD | TIOCM_DSR | TIOCM_RI);
+
+	if (dtr_msg->msg & CTRL_MSG_DCD)
+		mhi_dev->tiocm |= TIOCM_CD;
+
+	if (dtr_msg->msg & CTRL_MSG_DSR)
+		mhi_dev->tiocm |= TIOCM_DSR;
+
+	if (dtr_msg->msg & CTRL_MSG_RI)
+		mhi_dev->tiocm |= TIOCM_RI;
+	spin_unlock_irq(res_lock);
+}
+
+static void mhi_dtr_ul_xfer_cb(struct mhi_device *mhi_dev,
+			       struct mhi_result *mhi_result)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_chan *dtr_chan = mhi_cntrl->dtr_dev->ul_chan;
+
+	if (!mhi_result->transaction_status)
+		complete(&dtr_chan->completion);
+}
+
+static void mhi_dtr_remove(struct mhi_device *mhi_dev)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+
+	mhi_cntrl->dtr_dev = NULL;
+}
+
+static int mhi_dtr_probe(struct mhi_device *mhi_dev,
+			 const struct mhi_device_id *id)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	int ret;
+
+	ret = mhi_prepare_for_transfer(mhi_dev);
+	if (!ret)
+		mhi_cntrl->dtr_dev = mhi_dev;
+
+	return ret;
+}
+
+static const struct mhi_device_id mhi_dtr_table[] = {
+	{ .chan = "IP_CTRL" },
+	{},
+};
+
+static struct mhi_driver mhi_dtr_driver = {
+	.id_table = mhi_dtr_table,
+	.remove = mhi_dtr_remove,
+	.probe = mhi_dtr_probe,
+	.ul_xfer_cb = mhi_dtr_ul_xfer_cb,
+	.dl_xfer_cb = mhi_dtr_dl_xfer_cb,
+	.driver = {
+		.name = "MHI_DTR",
+		.owner = THIS_MODULE,
+	}
+};
+
+int __init mhi_dtr_init(void)
+{
+	return mhi_driver_register(&mhi_dtr_driver);
+}
diff --git a/drivers/bus/mhi/core/mhi_init.c b/drivers/bus/mhi/core/mhi_init.c
index 43a700d..b09767a 100644
--- a/drivers/bus/mhi/core/mhi_init.c
+++ b/drivers/bus/mhi/core/mhi_init.c
@@ -1293,10 +1293,16 @@ struct mhi_device *mhi_alloc_device(struct mhi_controller *mhi_cntrl)
 
 static int __init mhi_init(void)
 {
+	int ret;
+
 	/* parent directory */
 	debugfs_create_dir(mhi_bus_type.name, NULL);
 
-	return bus_register(&mhi_bus_type);
+	ret = bus_register(&mhi_bus_type);
+
+	if (!ret)
+		mhi_dtr_init();
+	return ret;
 }
 postcore_initcall(mhi_init);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

