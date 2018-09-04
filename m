Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDCFC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E86120645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SADAcuAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E86120645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeIDQUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 12:20:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37945 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbeIDQUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 12:20:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id x17-v6so1582895pfh.5;
        Tue, 04 Sep 2018 04:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BkaJ1S2+HO4WKHauXDpzR+nF6um82paDLXYh4JzGR1Y=;
        b=SADAcuAPYUQ1VP+BhbnRVNWdc5lYO4/hGyCOImMqRZ9W2ep3RxGWj48YNukd5Iw410
         Qi8vZtBUp8OlDtTXlXnMwMMB3vMfG9tl1tEhin1RRGSz03EHobwyTpW+5XjT6M0Na4Fn
         m7kUhDyx+vYqVJ85r69t0KXJqeN/7SOIiJ5sdWeLQyf7Y8eeiFBsXzJpTLpJqXWL5INV
         L9RVYtELN+B+g6knUORNd+TiusCAEghR0TWrvbkmbsSKnuIe63AR6x53OGuE99AmNa+L
         7DuQOzJSCLitf2tprT1i41I82ayG5Ctm6qIh1kqMcQctZX2ETrKM4erxYvYbHRLIZK0j
         3iyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BkaJ1S2+HO4WKHauXDpzR+nF6um82paDLXYh4JzGR1Y=;
        b=NQsuMp/qrMQNy+TWAcMdVI0EPR/U2OqOqSdcHTFL5rJdzRsphgy8666eAE2/bAAQJe
         fyXEaoSJ1PLww+kBpctZJ6jK7i1Pbf9ilGZgpyGOVu9pgkrOX9qUOzWpxVwo46NrvyY/
         zB+ccVaG/loPuGYQi9vKRy9UdPIWNW9IXDIL/GRiOMAYezlWhEuz1cfAGa5Pul5tE113
         go6pE0yPgSIygtVr2B5Un9zicHPoKU9g5J+AdAJIiSaTwurc0RgzKy24E7ryjHwgJFlK
         Pwg9MzqBfXV1quOgWsUlCw/2XKMWQLs6Zg8dmi067wmpffkw8UtnKFQuP/nBP9bVQpkS
         uUgg==
X-Gm-Message-State: APzg51BM/tipUs3yfHPpxVTpFmx3lDqiPEtdX6KeM1TDtVHLHWpsu3Zm
        zzAwq6a+tIy/Q96YbbJpbR6TAMu8
X-Google-Smtp-Source: ANB0VdZYaR2cDGoSErjOV/txnphVD+E9pXa5ug3DTE86mAfmEMFZ6Du3au6q3ixIuT5vLqZ66hFM4w==
X-Received: by 2002:a65:4849:: with SMTP id i9-v6mr29989898pgs.350.1536062129532;
        Tue, 04 Sep 2018 04:55:29 -0700 (PDT)
Received: from machine421.caveonetworks.com ([115.113.156.2])
        by smtp.googlemail.com with ESMTPSA id u184-v6sm29740190pgd.46.2018.09.04.04.55.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Sep 2018 04:55:28 -0700 (PDT)
From:   sunil.kovvuri@gmail.com
To:     linux-kernel@vger.kernel.org, arnd@arndb.de, olof@lixom.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org,
        andrew@lunn.ch, davem@davemloft.net,
        Aleksey Makarov <amakarov@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Lukasz Bartosik <lbartosik@marvell.com>
Subject: [PATCH v2 04/15] soc: octeontx2: Add mailbox support infra
Date:   Tue,  4 Sep 2018 17:24:39 +0530
Message-Id: <1536062090-30446-5-git-send-email-sunil.kovvuri@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536062090-30446-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1536062090-30446-1-git-send-email-sunil.kovvuri@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aleksey Makarov <amakarov@marvell.com>

This patch adds mailbox support infrastructure APIs.
Each RVU device has a dedicated 64KB mailbox region
shared with it's peer for communication. RVU AF has
a separate mailbox region shared with each of RVU PFs
and a RVU PF has a separate region shared with each of
it's VF.

These set of APIs are used by this driver (RVU AF) and
other RVU PF/VF drivers eg netdev, crypto e.t.c.

Signed-off-by: Aleksey Makarov <amakarov@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
Signed-off-by: Lukasz Bartosik <lbartosik@marvell.com>
---
 drivers/soc/marvell/Kconfig             |   4 +
 drivers/soc/marvell/octeontx2/Makefile  |   2 +
 drivers/soc/marvell/octeontx2/mbox.c    | 303 ++++++++++++++++++++++++++++++++
 drivers/soc/marvell/octeontx2/mbox.h    | 142 +++++++++++++++
 drivers/soc/marvell/octeontx2/rvu_reg.h |   4 +
 5 files changed, 455 insertions(+)
 create mode 100644 drivers/soc/marvell/octeontx2/mbox.c
 create mode 100644 drivers/soc/marvell/octeontx2/mbox.h

diff --git a/drivers/soc/marvell/Kconfig b/drivers/soc/marvell/Kconfig
index 4499caf..428d22e 100644
--- a/drivers/soc/marvell/Kconfig
+++ b/drivers/soc/marvell/Kconfig
@@ -4,8 +4,12 @@
 
 menu "Marvell SoC drivers"
 
+config OCTEONTX2_MBOX
+	tristate
+
 config OCTEONTX2_AF
 	tristate "OcteonTX2 RVU Admin Function driver"
+	select OCTEONTX2_MBOX
 	depends on ARM64 && PCI
 	help
 	  This driver supports Marvell's OcteonTX2 Resource Virtualization
diff --git a/drivers/soc/marvell/octeontx2/Makefile b/drivers/soc/marvell/octeontx2/Makefile
index dacbd16..ac17cb9 100644
--- a/drivers/soc/marvell/octeontx2/Makefile
+++ b/drivers/soc/marvell/octeontx2/Makefile
@@ -3,6 +3,8 @@
 # Makefile for Marvell's OcteonTX2 RVU Admin Function driver
 #
 
+obj-$(CONFIG_OCTEONTX2_MBOX) += octeontx2_mbox.o
 obj-$(CONFIG_OCTEONTX2_AF) += octeontx2_af.o
 
+octeontx2_mbox-y := mbox.o
 octeontx2_af-y := rvu.o
diff --git a/drivers/soc/marvell/octeontx2/mbox.c b/drivers/soc/marvell/octeontx2/mbox.c
new file mode 100644
index 0000000..0722fa4
--- /dev/null
+++ b/drivers/soc/marvell/octeontx2/mbox.c
@@ -0,0 +1,303 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell OcteonTx2 RVU Admin Function driver
+ *
+ * Copyright (C) 2018 Marvell International Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+
+#include "rvu_reg.h"
+#include "mbox.h"
+
+static const u16 msgs_offset = ALIGN(sizeof(struct mbox_hdr), MBOX_MSG_ALIGN);
+
+void otx2_mbox_reset(struct otx2_mbox *mbox, int devid)
+{
+	struct otx2_mbox_dev *mdev = &mbox->dev[devid];
+	struct mbox_hdr *tx_hdr =
+		(struct mbox_hdr *)(mdev->mbase  + mbox->tx_start);
+	struct mbox_hdr *rx_hdr =
+		(struct mbox_hdr *)(mdev->mbase  + mbox->rx_start);
+
+	spin_lock(&mdev->mbox_lock);
+	mdev->msg_size = 0;
+	mdev->rsp_size = 0;
+	tx_hdr->num_msgs = 0;
+	rx_hdr->num_msgs = 0;
+	spin_unlock(&mdev->mbox_lock);
+}
+EXPORT_SYMBOL(otx2_mbox_reset);
+
+void otx2_mbox_destroy(struct otx2_mbox *mbox)
+{
+	mbox->reg_base = NULL;
+	mbox->hwbase = NULL;
+
+	kfree(mbox->dev);
+	mbox->dev = NULL;
+}
+EXPORT_SYMBOL(otx2_mbox_destroy);
+
+int otx2_mbox_init(struct otx2_mbox *mbox, void *hwbase, struct pci_dev *pdev,
+		   void *reg_base, int direction, int ndevs)
+{
+	int devid;
+	struct otx2_mbox_dev *mdev;
+
+	switch (direction) {
+	case MBOX_DIR_AFPF:
+	case MBOX_DIR_PFVF:
+		mbox->tx_start = MBOX_DOWN_TX_START;
+		mbox->rx_start = MBOX_DOWN_RX_START;
+		mbox->tx_size  = MBOX_DOWN_TX_SIZE;
+		mbox->rx_size  = MBOX_DOWN_RX_SIZE;
+		break;
+	case MBOX_DIR_PFAF:
+	case MBOX_DIR_VFPF:
+		mbox->tx_start = MBOX_DOWN_RX_START;
+		mbox->rx_start = MBOX_DOWN_TX_START;
+		mbox->tx_size  = MBOX_DOWN_RX_SIZE;
+		mbox->rx_size  = MBOX_DOWN_TX_SIZE;
+		break;
+	case MBOX_DIR_AFPF_UP:
+	case MBOX_DIR_PFVF_UP:
+		mbox->tx_start = MBOX_UP_TX_START;
+		mbox->rx_start = MBOX_UP_RX_START;
+		mbox->tx_size  = MBOX_UP_TX_SIZE;
+		mbox->rx_size  = MBOX_UP_RX_SIZE;
+		break;
+	case MBOX_DIR_PFAF_UP:
+	case MBOX_DIR_VFPF_UP:
+		mbox->tx_start = MBOX_UP_RX_START;
+		mbox->rx_start = MBOX_UP_TX_START;
+		mbox->tx_size  = MBOX_UP_RX_SIZE;
+		mbox->rx_size  = MBOX_UP_TX_SIZE;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	switch (direction) {
+	case MBOX_DIR_AFPF:
+	case MBOX_DIR_AFPF_UP:
+		mbox->trigger = RVU_AF_AFPF_MBOX0;
+		mbox->tr_shift = 4;
+		break;
+	case MBOX_DIR_PFAF:
+	case MBOX_DIR_PFAF_UP:
+		mbox->trigger = RVU_PF_PFAF_MBOX1;
+		mbox->tr_shift = 0;
+		break;
+	case MBOX_DIR_PFVF:
+	case MBOX_DIR_PFVF_UP:
+		mbox->trigger = RVU_PF_VFX_PFVF_MBOX0;
+		mbox->tr_shift = 12;
+		break;
+	case MBOX_DIR_VFPF:
+	case MBOX_DIR_VFPF_UP:
+		mbox->trigger = RVU_VF_VFPF_MBOX1;
+		mbox->tr_shift = 0;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	mbox->reg_base = reg_base;
+	mbox->hwbase = hwbase;
+	mbox->pdev = pdev;
+
+	mbox->dev = kcalloc(ndevs, sizeof(struct otx2_mbox_dev), GFP_KERNEL);
+	if (!mbox->dev) {
+		otx2_mbox_destroy(mbox);
+		return -ENOMEM;
+	}
+
+	mbox->ndevs = ndevs;
+	for (devid = 0; devid < ndevs; devid++) {
+		mdev = &mbox->dev[devid];
+		mdev->mbase = mbox->hwbase + (devid * MBOX_SIZE);
+		spin_lock_init(&mdev->mbox_lock);
+		/* Init header to reset value */
+		otx2_mbox_reset(mbox, devid);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(otx2_mbox_init);
+
+int otx2_mbox_wait_for_rsp(struct otx2_mbox *mbox, int devid)
+{
+	struct otx2_mbox_dev *mdev = &mbox->dev[devid];
+	int timeout = 0, sleep = 1;
+
+	while (mdev->num_msgs != mdev->msgs_acked) {
+		msleep(sleep);
+		timeout += sleep;
+		if (timeout >= MBOX_RSP_TIMEOUT)
+			return -EIO;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(otx2_mbox_wait_for_rsp);
+
+int otx2_mbox_busy_poll_for_rsp(struct otx2_mbox *mbox, int devid)
+{
+	struct otx2_mbox_dev *mdev = &mbox->dev[devid];
+	unsigned long timeout = jiffies + 1 * HZ;
+
+	while (!time_after(jiffies, timeout)) {
+		if (mdev->num_msgs == mdev->msgs_acked)
+			return 0;
+		cpu_relax();
+	}
+	return -EIO;
+}
+EXPORT_SYMBOL(otx2_mbox_busy_poll_for_rsp);
+
+void otx2_mbox_msg_send(struct otx2_mbox *mbox, int devid)
+{
+	struct otx2_mbox_dev *mdev = &mbox->dev[devid];
+	struct mbox_hdr *tx_hdr =
+		(struct mbox_hdr *)(mdev->mbase  + mbox->tx_start);
+	struct mbox_hdr *rx_hdr =
+		(struct mbox_hdr *)(mdev->mbase  + mbox->rx_start);
+
+	spin_lock(&mdev->mbox_lock);
+	/* Reset header for next messages */
+	mdev->msg_size = 0;
+	mdev->rsp_size = 0;
+	mdev->msgs_acked = 0;
+
+	/* Sync mbox data into memory */
+	smp_wmb();
+
+	/* num_msgs != 0 signals to the peer that the buffer has a number of
+	 * messages.  So this should be written after writing all the messages
+	 * to the shared memory.
+	 */
+	tx_hdr->num_msgs = mdev->num_msgs;
+	rx_hdr->num_msgs = 0;
+	spin_unlock(&mdev->mbox_lock);
+
+	/* The interrupt should be fired after num_msgs is written
+	 * to the shared memory
+	 */
+	writeq(1, (void __iomem *)mbox->reg_base +
+	       (mbox->trigger | (devid << mbox->tr_shift)));
+}
+EXPORT_SYMBOL(otx2_mbox_msg_send);
+
+struct mbox_msghdr *otx2_mbox_alloc_msg_rsp(struct otx2_mbox *mbox, int devid,
+					    int size, int size_rsp)
+{
+	struct otx2_mbox_dev *mdev = &mbox->dev[devid];
+	struct mbox_msghdr *msghdr = NULL;
+
+	spin_lock(&mdev->mbox_lock);
+	size = ALIGN(size, MBOX_MSG_ALIGN);
+	size_rsp = ALIGN(size_rsp, MBOX_MSG_ALIGN);
+	/* Check if there is space in mailbox */
+	if ((mdev->msg_size + size) > mbox->tx_size - msgs_offset)
+		goto exit;
+	if ((mdev->rsp_size + size_rsp) > mbox->rx_size - msgs_offset)
+		goto exit;
+
+	if (mdev->msg_size == 0)
+		mdev->num_msgs = 0;
+	mdev->num_msgs++;
+
+	msghdr = (struct mbox_msghdr *)(mdev->mbase + mbox->tx_start +
+					msgs_offset + mdev->msg_size);
+	/* Clear the whole msg region */
+	memset(msghdr, 0, sizeof(*msghdr) + size);
+	/* Init message header with reset values */
+	msghdr->ver = OTX2_MBOX_VERSION;
+	mdev->msg_size += size;
+	mdev->rsp_size += size_rsp;
+	msghdr->next_msgoff = mdev->msg_size + msgs_offset;
+exit:
+	spin_unlock(&mdev->mbox_lock);
+
+	return msghdr;
+}
+EXPORT_SYMBOL(otx2_mbox_alloc_msg_rsp);
+
+struct mbox_msghdr *otx2_mbox_get_rsp(struct otx2_mbox *mbox, int devid,
+				      struct mbox_msghdr *msg)
+{
+	struct otx2_mbox_dev *mdev = &mbox->dev[devid];
+	unsigned long imsg = mbox->tx_start + msgs_offset;
+	unsigned long irsp = mbox->rx_start + msgs_offset;
+	u16 msgs;
+
+	if (mdev->num_msgs != mdev->msgs_acked)
+		return ERR_PTR(-ENODEV);
+
+	for (msgs = 0; msgs < mdev->msgs_acked; msgs++) {
+		struct mbox_msghdr *pmsg = mdev->mbase + imsg;
+		struct mbox_msghdr *prsp = mdev->mbase + irsp;
+
+		if (msg == pmsg) {
+			if (pmsg->id != prsp->id)
+				return ERR_PTR(-ENODEV);
+			return prsp;
+		}
+
+		imsg = pmsg->next_msgoff;
+		irsp = prsp->next_msgoff;
+	}
+
+	return ERR_PTR(-ENODEV);
+}
+EXPORT_SYMBOL(otx2_mbox_get_rsp);
+
+int
+otx2_reply_invalid_msg(struct otx2_mbox *mbox, int devid, u16 pcifunc, u16 id)
+{
+	struct msg_rsp *rsp;
+
+	rsp = (struct msg_rsp *)
+	       otx2_mbox_alloc_msg(mbox, devid, sizeof(*rsp));
+	if (!rsp)
+		return -ENOMEM;
+	rsp->hdr.id = id;
+	rsp->hdr.sig = OTX2_MBOX_RSP_SIG;
+	rsp->hdr.rc = MBOX_MSG_INVALID;
+	rsp->hdr.pcifunc = pcifunc;
+	return 0;
+}
+EXPORT_SYMBOL(otx2_reply_invalid_msg);
+
+bool otx2_mbox_nonempty(struct otx2_mbox *mbox, int devid)
+{
+	struct otx2_mbox_dev *mdev = &mbox->dev[devid];
+	bool ret;
+
+	spin_lock(&mdev->mbox_lock);
+	ret = mdev->num_msgs != 0;
+	spin_unlock(&mdev->mbox_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(otx2_mbox_nonempty);
+
+const char *otx2_mbox_id2name(u16 id)
+{
+	switch (id) {
+#define M(_name, _id, _1, _2) case _id: return # _name;
+	MBOX_MESSAGES
+#undef M
+	default:
+		return "INVALID ID";
+	}
+}
+EXPORT_SYMBOL(otx2_mbox_id2name);
+
+MODULE_AUTHOR("Marvell International Ltd.");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/soc/marvell/octeontx2/mbox.h b/drivers/soc/marvell/octeontx2/mbox.h
new file mode 100644
index 0000000..8e205fd
--- /dev/null
+++ b/drivers/soc/marvell/octeontx2/mbox.h
@@ -0,0 +1,142 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * Marvell OcteonTx2 RVU Admin Function driver
+ *
+ * Copyright (C) 2018 Marvell International Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef MBOX_H
+#define MBOX_H
+
+#include <linux/etherdevice.h>
+#include <linux/sizes.h>
+
+#include "rvu_struct.h"
+
+#define MBOX_SIZE		SZ_64K
+
+/* AF/PF: PF initiated, PF/VF VF initiated */
+#define MBOX_DOWN_RX_START	0
+#define MBOX_DOWN_RX_SIZE	(46 * SZ_1K)
+#define MBOX_DOWN_TX_START	(MBOX_DOWN_RX_START + MBOX_DOWN_RX_SIZE)
+#define MBOX_DOWN_TX_SIZE	(16 * SZ_1K)
+/* AF/PF: AF initiated, PF/VF PF initiated */
+#define MBOX_UP_RX_START	(MBOX_DOWN_TX_START + MBOX_DOWN_TX_SIZE)
+#define MBOX_UP_RX_SIZE		SZ_1K
+#define MBOX_UP_TX_START	(MBOX_UP_RX_START + MBOX_UP_RX_SIZE)
+#define MBOX_UP_TX_SIZE		SZ_1K
+
+#if MBOX_UP_TX_SIZE + MBOX_UP_TX_START != MBOX_SIZE
+# error "incorrect mailbox area sizes"
+#endif
+
+#define MBOX_RSP_TIMEOUT	1000 /* in ms, Time to wait for mbox response */
+
+#define MBOX_MSG_ALIGN		16  /* Align mbox msg start to 16bytes */
+
+/* Mailbox directions */
+#define MBOX_DIR_AFPF		0  /* AF replies to PF */
+#define MBOX_DIR_PFAF		1  /* PF sends messages to AF */
+#define MBOX_DIR_PFVF		2  /* PF replies to VF */
+#define MBOX_DIR_VFPF		3  /* VF sends messages to PF */
+#define MBOX_DIR_AFPF_UP	4  /* AF sends messages to PF */
+#define MBOX_DIR_PFAF_UP	5  /* PF replies to AF */
+#define MBOX_DIR_PFVF_UP	6  /* PF sends messages to VF */
+#define MBOX_DIR_VFPF_UP	7  /* VF replies to PF */
+
+struct otx2_mbox_dev {
+	void	    *mbase;   /* This dev's mbox region */
+	spinlock_t  mbox_lock;
+	u16         msg_size; /* Total msg size to be sent */
+	u16         rsp_size; /* Total rsp size to be sure the reply is ok */
+	u16         num_msgs; /* No of msgs sent or waiting for response */
+	u16         msgs_acked; /* No of msgs for which response is received */
+};
+
+struct otx2_mbox {
+	struct pci_dev *pdev;
+	void   *hwbase;  /* Mbox region advertised by HW */
+	void   *reg_base;/* CSR base for this dev */
+	u64    trigger;  /* Trigger mbox notification */
+	u16    tr_shift; /* Mbox trigger shift */
+	u64    rx_start; /* Offset of Rx region in mbox memory */
+	u64    tx_start; /* Offset of Tx region in mbox memory */
+	u16    rx_size;  /* Size of Rx region */
+	u16    tx_size;  /* Size of Tx region */
+	u16    ndevs;    /* The number of peers */
+	struct otx2_mbox_dev *dev;
+};
+
+/* Header which preceeds all mbox messages */
+struct mbox_hdr {
+	u16  num_msgs;   /* No of msgs embedded */
+};
+
+/* Header which preceeds every msg and is also part of it */
+struct mbox_msghdr {
+	u16 pcifunc;     /* Who's sending this msg */
+	u16 id;          /* Mbox message ID */
+#define OTX2_MBOX_REQ_SIG (0xdead)
+#define OTX2_MBOX_RSP_SIG (0xbeef)
+	u16 sig;         /* Signature, for validating corrupted msgs */
+#define OTX2_MBOX_VERSION (0x0001)
+	u16 ver;         /* Version of msg's structure for this ID */
+	u16 next_msgoff; /* Offset of next msg within mailbox region */
+	int rc;          /* Msg process'ed response code */
+};
+
+void otx2_mbox_reset(struct otx2_mbox *mbox, int devid);
+void otx2_mbox_destroy(struct otx2_mbox *mbox);
+int otx2_mbox_init(struct otx2_mbox *mbox, void *hwbase, struct pci_dev *pdev,
+		   void *reg_base, int direction, int ndevs);
+void otx2_mbox_msg_send(struct otx2_mbox *mbox, int devid);
+int otx2_mbox_wait_for_rsp(struct otx2_mbox *mbox, int devid);
+int otx2_mbox_busy_poll_for_rsp(struct otx2_mbox *mbox, int devid);
+struct mbox_msghdr *otx2_mbox_alloc_msg_rsp(struct otx2_mbox *mbox, int devid,
+					    int size, int size_rsp);
+struct mbox_msghdr *otx2_mbox_get_rsp(struct otx2_mbox *mbox, int devid,
+				      struct mbox_msghdr *msg);
+int otx2_reply_invalid_msg(struct otx2_mbox *mbox, int devid,
+			   u16 pcifunc, u16 id);
+bool otx2_mbox_nonempty(struct otx2_mbox *mbox, int devid);
+const char *otx2_mbox_id2name(u16 id);
+static inline struct mbox_msghdr *otx2_mbox_alloc_msg(struct otx2_mbox *mbox,
+						      int devid, int size)
+{
+	return otx2_mbox_alloc_msg_rsp(mbox, devid, size, 0);
+}
+
+/* Mailbox message types */
+#define MBOX_MSG_MASK				0xFFFF
+#define MBOX_MSG_INVALID			0xFFFE
+#define MBOX_MSG_MAX				0xFFFF
+
+#define MBOX_MESSAGES							\
+M(READY,		0x001, msg_req, msg_rsp)
+
+enum {
+#define M(_name, _id, _1, _2) MBOX_MSG_ ## _name = _id,
+MBOX_MESSAGES
+#undef M
+};
+
+/* Mailbox message formats */
+
+/* Generic request msg used for those mbox messages which
+ * don't send any data in the request.
+ */
+struct msg_req {
+	struct mbox_msghdr hdr;
+};
+
+/* Generic rsponse msg used a ack or response for those mbox
+ * messages which doesn't have a specific rsp msg format.
+ */
+struct msg_rsp {
+	struct mbox_msghdr hdr;
+};
+
+#endif /* MBOX_H */
diff --git a/drivers/soc/marvell/octeontx2/rvu_reg.h b/drivers/soc/marvell/octeontx2/rvu_reg.h
index a7995d1..3bfb1e0 100644
--- a/drivers/soc/marvell/octeontx2/rvu_reg.h
+++ b/drivers/soc/marvell/octeontx2/rvu_reg.h
@@ -101,6 +101,10 @@
 #define RVU_PF_MSIX_VECX_CTL(a)             (0x008 | (a) << 4)
 #define RVU_PF_MSIX_PBAX(a)                 (0xF0000 | (a) << 3)
 
+/* RVU VF registers */
+#define	RVU_VF_VFPF_MBOX0		    (0x00000)
+#define	RVU_VF_VFPF_MBOX1		    (0x00008)
+
 /* NPA block's admin function registers */
 #define NPA_AF_BLK_RST                  (0x0000)
 #define NPA_AF_CONST                    (0x0010)
-- 
2.7.4

